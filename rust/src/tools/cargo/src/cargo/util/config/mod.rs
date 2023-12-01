//! Cargo's config system.
//!
//! The `Config` object contains general information about the environment,
//! and provides access to Cargo's configuration files.
//!
//! ## Config value API
//!
//! The primary API for fetching user-defined config values is the
//! `Config::get` method. It uses `serde` to translate config values to a
//! target type.
//!
//! There are a variety of helper types for deserializing some common formats:
//!
//! - `value::Value`: This type provides access to the location where the
//!   config value was defined.
//! - `ConfigRelativePath`: For a path that is relative to where it is
//!   defined.
//! - `PathAndArgs`: Similar to `ConfigRelativePath`, but also supports a list
//!   of arguments, useful for programs to execute.
//! - `StringList`: Get a value that is either a list or a whitespace split
//!   string.
//!
//! ## Map key recommendations
//!
//! Handling tables that have arbitrary keys can be tricky, particularly if it
//! should support environment variables. In general, if possible, the caller
//! should pass the full key path into the `get()` method so that the config
//! deserializer can properly handle environment variables (which need to be
//! uppercased, and dashes converted to underscores).
//!
//! A good example is the `[target]` table. The code will request
//! `target.$TRIPLE` and the config system can then appropriately fetch
//! environment variables like `CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER`.
//! Conversely, it is not possible do the same thing for the `cfg()` target
//! tables (because Cargo must fetch all of them), so those do not support
//! environment variables.
//!
//! Try to avoid keys that are a prefix of another with a dash/underscore. For
//! example `build.target` and `build.target-dir`. This is OK if these are not
//! structs/maps, but if it is a struct or map, then it will not be able to
//! read the environment variable due to ambiguity. (See `ConfigMapAccess` for
//! more details.)
//!
//! ## Internal API
//!
//! Internally config values are stored with the `ConfigValue` type after they
//! have been loaded from disk. This is similar to the `toml::Value` type, but
//! includes the definition location. The `get()` method uses serde to
//! translate from `ConfigValue` and environment variables to the caller's
//! desired type.

use std::cell::{RefCell, RefMut};
use std::collections::hash_map::Entry::{Occupied, Vacant};
use std::collections::{HashMap, HashSet};
use std::env;
use std::fmt;
use std::fs::{self, File};
use std::io::prelude::*;
use std::io::{self, SeekFrom};
use std::mem;
use std::path::{Path, PathBuf};
use std::str::FromStr;
use std::sync::Once;
use std::time::Instant;

use anyhow::{anyhow, bail};
use curl::easy::Easy;
use lazycell::LazyCell;
use serde::Deserialize;
use url::Url;

use self::ConfigValue as CV;
use crate::core::compiler::rustdoc::RustdocExternMap;
use crate::core::shell::Verbosity;
use crate::core::{nightly_features_allowed, CliUnstable, Shell, SourceId, Workspace};
use crate::ops;
use crate::util::errors::{CargoResult, CargoResultExt};
use crate::util::toml as cargo_toml;
use crate::util::{paths, validate_package_name};
use crate::util::{FileLock, Filesystem, IntoUrl, IntoUrlWithBase, Rustc};

mod de;
use de::Deserializer;

mod value;
pub use value::{Definition, OptValue, Value};

mod key;
use key::ConfigKey;

mod path;
pub use path::{ConfigRelativePath, PathAndArgs};

mod target;
pub use target::{TargetCfgConfig, TargetConfig};

// Helper macro for creating typed access methods.
macro_rules! get_value_typed {
    ($name:ident, $ty:ty, $variant:ident, $expected:expr) => {
        /// Low-level private method for getting a config value as an OptValue.
        fn $name(&self, key: &ConfigKey) -> Result<OptValue<$ty>, ConfigError> {
            let cv = self.get_cv(key)?;
            let env = self.get_env::<$ty>(key)?;
            match (cv, env) {
                (Some(CV::$variant(val, definition)), Some(env)) => {
                    if definition.is_higher_priority(&env.definition) {
                        Ok(Some(Value { val, definition }))
                    } else {
                        Ok(Some(env))
                    }
                }
                (Some(CV::$variant(val, definition)), None) => Ok(Some(Value { val, definition })),
                (Some(cv), _) => Err(ConfigError::expected(key, $expected, &cv)),
                (None, Some(env)) => Ok(Some(env)),
                (None, None) => Ok(None),
            }
        }
    };
}

/// Configuration information for cargo. This is not specific to a build, it is information
/// relating to cargo itself.
#[derive(Debug)]
pub struct Config {
    /// The location of the user's Cargo home directory. OS-dependent.
    home_path: Filesystem,
    /// Information about how to write messages to the shell
    shell: RefCell<Shell>,
    /// A collection of configuration options
    values: LazyCell<HashMap<String, ConfigValue>>,
    /// CLI config values, passed in via `configure`.
    cli_config: Option<Vec<String>>,
    /// The current working directory of cargo
    cwd: PathBuf,
    /// The location of the cargo executable (path to current process)
    cargo_exe: LazyCell<PathBuf>,
    /// The location of the rustdoc executable
    rustdoc: LazyCell<PathBuf>,
    /// Whether we are printing extra verbose messages
    extra_verbose: bool,
    /// `frozen` is the same as `locked`, but additionally will not access the
    /// network to determine if the lock file is out-of-date.
    frozen: bool,
    /// `locked` is set if we should not update lock files. If the lock file
    /// is missing, or needs to be updated, an error is produced.
    locked: bool,
    /// `offline` is set if we should never access the network, but otherwise
    /// continue operating if possible.
    offline: bool,
    /// A global static IPC control mechanism (used for managing parallel builds)
    jobserver: Option<jobserver::Client>,
    /// Cli flags of the form "-Z something" merged with config file values
    unstable_flags: CliUnstable,
    /// Cli flags of the form "-Z something"
    unstable_flags_cli: Option<Vec<String>>,
    /// A handle on curl easy mode for http calls
    easy: LazyCell<RefCell<Easy>>,
    /// Cache of the `SourceId` for crates.io
    crates_io_source_id: LazyCell<SourceId>,
    /// If false, don't cache `rustc --version --verbose` invocations
    cache_rustc_info: bool,
    /// Creation time of this config, used to output the total build time
    creation_time: Instant,
    /// Target Directory via resolved Cli parameter
    target_dir: Option<Filesystem>,
    /// Environment variables, separated to assist testing.
    env: HashMap<String, String>,
    /// Tracks which sources have been updated to avoid multiple updates.
    updated_sources: LazyCell<RefCell<HashSet<SourceId>>>,
    /// Lock, if held, of the global package cache along with the number of
    /// acquisitions so far.
    package_cache_lock: RefCell<Option<(Option<FileLock>, usize)>>,
    /// Cached configuration parsed by Cargo
    http_config: LazyCell<CargoHttpConfig>,
    net_config: LazyCell<CargoNetConfig>,
    build_config: LazyCell<CargoBuildConfig>,
    target_cfgs: LazyCell<Vec<(String, TargetCfgConfig)>>,
    doc_extern_map: LazyCell<RustdocExternMap>,
    progress_config: ProgressConfig,
}

impl Config {
    /// Creates a new config instance.
    ///
    /// This is typically used for tests or other special cases. `default` is
    /// preferred otherwise.
    ///
    /// This does only minimal initialization. In particular, it does not load
    /// any config files from disk. Those will be loaded lazily as-needed.
    pub fn new(shell: Shell, cwd: PathBuf, homedir: PathBuf) -> Config {
        static mut GLOBAL_JOBSERVER: *mut jobserver::Client = 0 as *mut _;
        static INIT: Once = Once::new();

        // This should be called early on in the process, so in theory the
        // unsafety is ok here. (taken ownership of random fds)
        INIT.call_once(|| unsafe {
            if let Some(client) = jobserver::Client::from_env() {
                GLOBAL_JOBSERVER = Box::into_raw(Box::new(client));
            }
        });

        let env: HashMap<_, _> = env::vars_os()
            .filter_map(|(k, v)| {
                // Ignore any key/values that are not valid Unicode.
                match (k.into_string(), v.into_string()) {
                    (Ok(k), Ok(v)) => Some((k, v)),
                    _ => None,
                }
            })
            .collect();

        let cache_rustc_info = match env.get("CARGO_CACHE_RUSTC_INFO") {
            Some(cache) => cache != "0",
            _ => true,
        };

        Config {
            home_path: Filesystem::new(homedir),
            shell: RefCell::new(shell),
            cwd,
            values: LazyCell::new(),
            cli_config: None,
            cargo_exe: LazyCell::new(),
            rustdoc: LazyCell::new(),
            extra_verbose: false,
            frozen: false,
            locked: false,
            offline: false,
            jobserver: unsafe {
                if GLOBAL_JOBSERVER.is_null() {
                    None
                } else {
                    Some((*GLOBAL_JOBSERVER).clone())
                }
            },
            unstable_flags: CliUnstable::default(),
            unstable_flags_cli: None,
            easy: LazyCell::new(),
            crates_io_source_id: LazyCell::new(),
            cache_rustc_info,
            creation_time: Instant::now(),
            target_dir: None,
            env,
            updated_sources: LazyCell::new(),
            package_cache_lock: RefCell::new(None),
            http_config: LazyCell::new(),
            net_config: LazyCell::new(),
            build_config: LazyCell::new(),
            target_cfgs: LazyCell::new(),
            doc_extern_map: LazyCell::new(),
            progress_config: ProgressConfig::default(),
        }
    }

    /// Creates a new Config instance, with all default settings.
    ///
    /// This does only minimal initialization. In particular, it does not load
    /// any config files from disk. Those will be loaded lazily as-needed.
    pub fn default() -> CargoResult<Config> {
        let shell = Shell::new();
        let cwd =
            env::current_dir().chain_err(|| "couldn't get the current directory of the process")?;
        let homedir = homedir(&cwd).ok_or_else(|| {
            anyhow!(
                "Cargo couldn't find your home directory. \
                 This probably means that $HOME was not set."
            )
        })?;
        Ok(Config::new(shell, cwd, homedir))
    }

    /// Gets the user's Cargo home directory (OS-dependent).
    pub fn home(&self) -> &Filesystem {
        &self.home_path
    }

    /// Gets the Cargo Git directory (`<cargo_home>/git`).
    pub fn git_path(&self) -> Filesystem {
        self.home_path.join("git")
    }

    /// Gets the Cargo registry index directory (`<cargo_home>/registry/index`).
    pub fn registry_index_path(&self) -> Filesystem {
        self.home_path.join("registry").join("index")
    }

    /// Gets the Cargo registry cache directory (`<cargo_home>/registry/path`).
    pub fn registry_cache_path(&self) -> Filesystem {
        self.home_path.join("registry").join("cache")
    }

    /// Gets the Cargo registry source directory (`<cargo_home>/registry/src`).
    pub fn registry_source_path(&self) -> Filesystem {
        self.home_path.join("registry").join("src")
    }

    /// Gets the default Cargo registry.
    pub fn default_registry(&self) -> CargoResult<Option<String>> {
        Ok(match self.get_string("registry.default")? {
            Some(registry) => Some(registry.val),
            None => None,
        })
    }

    /// Gets a reference to the shell, e.g., for writing error messages.
    pub fn shell(&self) -> RefMut<'_, Shell> {
        self.shell.borrow_mut()
    }

    /// Gets the path to the `rustdoc` executable.
    pub fn rustdoc(&self) -> CargoResult<&Path> {
        self.rustdoc
            .try_borrow_with(|| Ok(self.get_tool("rustdoc", &self.build_config()?.rustdoc)))
            .map(AsRef::as_ref)
    }

    /// Gets the path to the `rustc` executable.
    pub fn load_global_rustc(&self, ws: Option<&Workspace<'_>>) -> CargoResult<Rustc> {
        let cache_location = ws.map(|ws| {
            ws.target_dir()
                .join(".rustc_info.json")
                .into_path_unlocked()
        });
        let wrapper = self.maybe_get_tool("rustc_wrapper", &self.build_config()?.rustc_wrapper);
        let rustc_workspace_wrapper = self.maybe_get_tool(
            "rustc_workspace_wrapper",
            &self.build_config()?.rustc_workspace_wrapper,
        );

        if !self.cli_unstable().unstable_options && rustc_workspace_wrapper.is_some() {
            bail!("Usage of `RUSTC_WORKSPACE_WRAPPER` requires `-Z unstable-options`")
        }

        Rustc::new(
            self.get_tool("rustc", &self.build_config()?.rustc),
            wrapper,
            rustc_workspace_wrapper,
            &self
                .home()
                .join("bin")
                .join("rustc")
                .into_path_unlocked()
                .with_extension(env::consts::EXE_EXTENSION),
            if self.cache_rustc_info {
                cache_location
            } else {
                None
            },
        )
    }

    /// Gets the path to the `cargo` executable.
    pub fn cargo_exe(&self) -> CargoResult<&Path> {
        self.cargo_exe
            .try_borrow_with(|| {
                fn from_current_exe() -> CargoResult<PathBuf> {
                    // Try fetching the path to `cargo` using `env::current_exe()`.
                    // The method varies per operating system and might fail; in particular,
                    // it depends on `/proc` being mounted on Linux, and some environments
                    // (like containers or chroots) may not have that available.
                    let exe = env::current_exe()?.canonicalize()?;
                    Ok(exe)
                }

                fn from_argv() -> CargoResult<PathBuf> {
                    // Grab `argv[0]` and attempt to resolve it to an absolute path.
                    // If `argv[0]` has one component, it must have come from a `PATH` lookup,
                    // so probe `PATH` in that case.
                    // Otherwise, it has multiple components and is either:
                    // - a relative path (e.g., `./cargo`, `target/debug/cargo`), or
                    // - an absolute path (e.g., `/usr/local/bin/cargo`).
                    // In either case, `Path::canonicalize` will return the full absolute path
                    // to the target if it exists.
                    let argv0 = env::args_os()
                        .map(PathBuf::from)
                        .next()
                        .ok_or_else(|| anyhow!("no argv[0]"))?;
                    paths::resolve_executable(&argv0)
                }

                let exe = from_current_exe()
                    .or_else(|_| from_argv())
                    .chain_err(|| "couldn't get the path to cargo executable")?;
                Ok(exe)
            })
            .map(AsRef::as_ref)
    }

    /// Which package sources have been updated, used to ensure it is only done once.
    pub fn updated_sources(&self) -> RefMut<'_, HashSet<SourceId>> {
        self.updated_sources
            .borrow_with(|| RefCell::new(HashSet::new()))
            .borrow_mut()
    }

    /// Gets all config values from disk.
    ///
    /// This will lazy-load the values as necessary. Callers are responsible
    /// for checking environment variables. Callers outside of the `config`
    /// module should avoid using this.
    pub fn values(&self) -> CargoResult<&HashMap<String, ConfigValue>> {
        self.values.try_borrow_with(|| self.load_values())
    }

    /// Gets a mutable copy of the on-disk config values.
    ///
    /// This requires the config values to already have been loaded. This
    /// currently only exists for `cargo vendor` to remove the `source`
    /// entries. This doesn't respect environment variables. You should avoid
    /// using this if possible.
    pub fn values_mut(&mut self) -> CargoResult<&mut HashMap<String, ConfigValue>> {
        match self.values.borrow_mut() {
            Some(map) => Ok(map),
            None => bail!("config values not loaded yet"),
        }
    }

    // Note: this is used by RLS, not Cargo.
    pub fn set_values(&self, values: HashMap<String, ConfigValue>) -> CargoResult<()> {
        if self.values.borrow().is_some() {
            bail!("config values already found")
        }
        match self.values.fill(values) {
            Ok(()) => Ok(()),
            Err(_) => bail!("could not fill values"),
        }
    }

    /// Reloads on-disk configuration values, starting at the given path and
    /// walking up its ancestors.
    pub fn reload_rooted_at<P: AsRef<Path>>(&mut self, path: P) -> CargoResult<()> {
        let values = self.load_values_from(path.as_ref())?;
        self.values.replace(values);
        self.merge_cli_args()?;
        self.load_unstable_flags_from_config()?;
        Ok(())
    }

    /// The current working directory.
    pub fn cwd(&self) -> &Path {
        &self.cwd
    }

    /// The `target` output directory to use.
    ///
    /// Returns `None` if the user has not chosen an explicit directory.
    ///
    /// Callers should prefer `Workspace::target_dir` instead.
    pub fn target_dir(&self) -> CargoResult<Option<Filesystem>> {
        if let Some(dir) = &self.target_dir {
            Ok(Some(dir.clone()))
        } else if let Some(dir) = env::var_os("CARGO_TARGET_DIR") {
            Ok(Some(Filesystem::new(self.cwd.join(dir))))
        } else if let Some(val) = &self.build_config()?.target_dir {
            let val = val.resolve_path(self);
            Ok(Some(Filesystem::new(val)))
        } else {
            Ok(None)
        }
    }

    /// Get a configuration value by key.
    ///
    /// This does NOT look at environment variables. See `get_cv_with_env` for
    /// a variant that supports environment variables.
    fn get_cv(&self, key: &ConfigKey) -> CargoResult<Option<ConfigValue>> {
        log::trace!("get cv {:?}", key);
        let vals = self.values()?;
        let mut parts = key.parts().enumerate();
        let mut val = match vals.get(parts.next().unwrap().1) {
            Some(val) => val,
            None => return Ok(None),
        };
        for (i, part) in parts {
            match val {
                CV::Table(map, _) => {
                    val = match map.get(part) {
                        Some(val) => val,
                        None => return Ok(None),
                    }
                }
                CV::Integer(_, def)
                | CV::String(_, def)
                | CV::List(_, def)
                | CV::Boolean(_, def) => {
                    let key_so_far: Vec<&str> = key.parts().take(i).collect();
                    bail!(
                        "expected table for configuration key `{}`, \
                         but found {} in {}",
                        // This join doesn't handle quoting properly.
                        key_so_far.join("."),
                        val.desc(),
                        def
                    )
                }
            }
        }
        Ok(Some(val.clone()))
    }

    /// Helper primarily for testing.
    pub fn set_env(&mut self, env: HashMap<String, String>) {
        self.env = env;
    }

    fn get_env<T>(&self, key: &ConfigKey) -> Result<OptValue<T>, ConfigError>
    where
        T: FromStr,
        <T as FromStr>::Err: fmt::Display,
    {
        match self.env.get(key.as_env_key()) {
            Some(value) => {
                let definition = Definition::Environment(key.as_env_key().to_string());
                Ok(Some(Value {
                    val: value
                        .parse()
                        .map_err(|e| ConfigError::new(format!("{}", e), definition.clone()))?,
                    definition,
                }))
            }
            None => Ok(None),
        }
    }

    fn has_key(&self, key: &ConfigKey, env_prefix_ok: bool) -> bool {
        if self.env.contains_key(key.as_env_key()) {
            return true;
        }
        // See ConfigMapAccess for a description of this.
        if env_prefix_ok {
            let env_prefix = format!("{}_", key.as_env_key());
            if self.env.keys().any(|k| k.starts_with(&env_prefix)) {
                return true;
            }
        }
        if let Ok(o_cv) = self.get_cv(key) {
            if o_cv.is_some() {
                return true;
            }
        }
        false
    }

    /// Get a string config value.
    ///
    /// See `get` for more details.
    pub fn get_string(&self, key: &str) -> CargoResult<OptValue<String>> {
        self.get::<Option<Value<String>>>(key)
    }

    /// Get a config value that is expected to be a path.
    ///
    /// This returns a relative path if the value does not contain any
    /// directory separators. See `ConfigRelativePath::resolve_program` for
    /// more details.
    pub fn get_path(&self, key: &str) -> CargoResult<OptValue<PathBuf>> {
        self.get::<Option<Value<ConfigRelativePath>>>(key).map(|v| {
            v.map(|v| Value {
                val: v.val.resolve_program(self),
                definition: v.definition,
            })
        })
    }

    fn string_to_path(&self, value: String, definition: &Definition) -> PathBuf {
        let is_path = value.contains('/') || (cfg!(windows) && value.contains('\\'));
        if is_path {
            definition.root(self).join(value)
        } else {
            // A pathless name.
            PathBuf::from(value)
        }
    }

    /// Get a list of strings.
    ///
    /// DO NOT USE outside of the config module. `pub` will be removed in the
    /// future.
    ///
    /// NOTE: this does **not** support environment variables. Use `get` instead
    /// if you want that.
    pub fn get_list(&self, key: &str) -> CargoResult<OptValue<Vec<(String, Definition)>>> {
        let key = ConfigKey::from_str(key);
        self._get_list(&key)
    }

    fn _get_list(&self, key: &ConfigKey) -> CargoResult<OptValue<Vec<(String, Definition)>>> {
        match self.get_cv(key)? {
            Some(CV::List(val, definition)) => Ok(Some(Value { val, definition })),
            Some(val) => self.expected("list", key, &val),
            None => Ok(None),
        }
    }

    /// Helper for StringList type to get something that is a string or list.
    fn get_list_or_string(
        &self,
        key: &ConfigKey,
        merge: bool,
    ) -> CargoResult<Vec<(String, Definition)>> {
        let mut res = Vec::new();

        if !merge {
            self.get_env_list(key, &mut res)?;

            if !res.is_empty() {
                return Ok(res);
            }
        }

        match self.get_cv(key)? {
            Some(CV::List(val, _def)) => res.extend(val),
            Some(CV::String(val, def)) => {
                let split_vs = val.split_whitespace().map(|s| (s.to_string(), def.clone()));
                res.extend(split_vs);
            }
            Some(val) => {
                return self.expected("string or array of strings", key, &val);
            }
            None => {}
        }

        self.get_env_list(key, &mut res)?;

        Ok(res)
    }

    /// Internal method for getting an environment variable as a list.
    fn get_env_list(
        &self,
        key: &ConfigKey,
        output: &mut Vec<(String, Definition)>,
    ) -> CargoResult<()> {
        let env_val = match self.env.get(key.as_env_key()) {
            Some(v) => v,
            None => return Ok(()),
        };

        let def = Definition::Environment(key.as_env_key().to_string());
        if self.cli_unstable().advanced_env && env_val.starts_with('[') && env_val.ends_with(']') {
            // Parse an environment string as a TOML array.
            let toml_s = format!("value={}", env_val);
            let toml_v: toml::Value = toml::de::from_str(&toml_s).map_err(|e| {
                ConfigError::new(format!("could not parse TOML list: {}", e), def.clone())
            })?;
            let values = toml_v
                .as_table()
                .unwrap()
                .get("value")
                .unwrap()
                .as_array()
                .expect("env var was not array");
            for value in values {
                // TODO: support other types.
                let s = value.as_str().ok_or_else(|| {
                    ConfigError::new(
                        format!("expected string, found {}", value.type_str()),
                        def.clone(),
                    )
                })?;
                output.push((s.to_string(), def.clone()));
            }
        } else {
            output.extend(
                env_val
                    .split_whitespace()
                    .map(|s| (s.to_string(), def.clone())),
            );
        }
        Ok(())
    }

    /// Low-level method for getting a config value as a `OptValue<HashMap<String, CV>>`.
    ///
    /// NOTE: This does not read from env. The caller is responsible for that.
    fn get_table(&self, key: &ConfigKey) -> CargoResult<OptValue<HashMap<String, CV>>> {
        match self.get_cv(key)? {
            Some(CV::Table(val, definition)) => Ok(Some(Value { val, definition })),
            Some(val) => self.expected("table", key, &val),
            None => Ok(None),
        }
    }

    get_value_typed! {get_integer, i64, Integer, "an integer"}
    get_value_typed! {get_bool, bool, Boolean, "true/false"}
    get_value_typed! {get_string_priv, String, String, "a string"}

    /// Generate an error when the given value is the wrong type.
    fn expected<T>(&self, ty: &str, key: &ConfigKey, val: &CV) -> CargoResult<T> {
        val.expected(ty, &key.to_string())
            .map_err(|e| anyhow!("invalid configuration for key `{}`\n{}", key, e))
    }

    /// Update the Config instance based on settings typically passed in on
    /// the command-line.
    ///
    /// This may also load the config from disk if it hasn't already been
    /// loaded.
    pub fn configure(
        &mut self,
        verbose: u32,
        quiet: bool,
        color: Option<&str>,
        frozen: bool,
        locked: bool,
        offline: bool,
        target_dir: &Option<PathBuf>,
        unstable_flags: &[String],
        cli_config: &[String],
    ) -> CargoResult<()> {
        self.unstable_flags.parse(unstable_flags)?;
        if !unstable_flags.is_empty() {
            // store a copy of the cli flags separately for `load_unstable_flags_from_config`
            // (we might also need it again for `reload_rooted_at`)
            self.unstable_flags_cli = Some(unstable_flags.to_vec());
        }
        if !cli_config.is_empty() {
            self.unstable_flags.fail_if_stable_opt("--config", 6699)?;
            self.cli_config = Some(cli_config.iter().map(|s| s.to_string()).collect());
            self.merge_cli_args()?;
        }
        let extra_verbose = verbose >= 2;
        let verbose = verbose != 0;

        // Ignore errors in the configuration files. We don't want basic
        // commands like `cargo version` to error out due to config file
        // problems.
        let term = self.get::<TermConfig>("term").unwrap_or_default();

        let color = color.or_else(|| term.color.as_deref());

        let verbosity = match (verbose, term.verbose, quiet) {
            (true, _, false) | (_, Some(true), false) => Verbosity::Verbose,

            // Command line takes precedence over configuration, so ignore the
            // configuration..
            (false, _, true) => Verbosity::Quiet,

            // Can't pass both at the same time on the command line regardless
            // of configuration.
            (true, _, true) => {
                bail!("cannot set both --verbose and --quiet");
            }

            (false, _, false) => Verbosity::Normal,
        };

        let cli_target_dir = match target_dir.as_ref() {
            Some(dir) => Some(Filesystem::new(dir.clone())),
            None => None,
        };

        self.shell().set_verbosity(verbosity);
        self.shell().set_color_choice(color)?;
        self.progress_config = term.progress.unwrap_or_default();
        self.extra_verbose = extra_verbose;
        self.frozen = frozen;
        self.locked = locked;
        self.offline = offline
            || self
                .net_config()
                .ok()
                .and_then(|n| n.offline)
                .unwrap_or(false);
        self.target_dir = cli_target_dir;

        self.load_unstable_flags_from_config()?;

        Ok(())
    }

    fn load_unstable_flags_from_config(&mut self) -> CargoResult<()> {
        // If nightly features are enabled, allow setting Z-flags from config
        // using the `unstable` table. Ignore that block otherwise.
        if nightly_features_allowed() {
            self.unstable_flags = self
                .get::<Option<CliUnstable>>("unstable")?
                .unwrap_or_default();
            if let Some(unstable_flags_cli) = &self.unstable_flags_cli {
                // NB. It's not ideal to parse these twice, but doing it again here
                //     allows the CLI to override config files for both enabling
                //     and disabling, and doing it up top allows CLI Zflags to
                //     control config parsing behavior.
                self.unstable_flags.parse(unstable_flags_cli)?;
            }
        }

        Ok(())
    }

    pub fn cli_unstable(&self) -> &CliUnstable {
        &self.unstable_flags
    }

    pub fn extra_verbose(&self) -> bool {
        self.extra_verbose
    }

    pub fn network_allowed(&self) -> bool {
        !self.frozen() && !self.offline()
    }

    pub fn offline(&self) -> bool {
        self.offline
    }

    pub fn frozen(&self) -> bool {
        self.frozen
    }

    pub fn lock_update_allowed(&self) -> bool {
        !self.frozen && !self.locked
    }

    /// Loads configuration from the filesystem.
    pub fn load_values(&self) -> CargoResult<HashMap<String, ConfigValue>> {
        self.load_values_from(&self.cwd)
    }

    fn load_values_from(&self, path: &Path) -> CargoResult<HashMap<String, ConfigValue>> {
        // This definition path is ignored, this is just a temporary container
        // representing the entire file.
        let mut cfg = CV::Table(HashMap::new(), Definition::Path(PathBuf::from(".")));
        let home = self.home_path.clone().into_path_unlocked();

        self.walk_tree(path, &home, |path| {
            let value = self.load_file(path)?;
            cfg.merge(value, false)
                .chain_err(|| format!("failed to merge configuration at `{}`", path.display()))?;
            Ok(())
        })
        .chain_err(|| "could not load Cargo configuration")?;

        match cfg {
            CV::Table(map, _) => Ok(map),
            _ => unreachable!(),
        }
    }

    fn load_file(&self, path: &Path) -> CargoResult<ConfigValue> {
        let mut seen = HashSet::new();
        self._load_file(path, &mut seen)
    }

    fn _load_file(&self, path: &Path, seen: &mut HashSet<PathBuf>) -> CargoResult<ConfigValue> {
        if !seen.insert(path.to_path_buf()) {
            bail!(
                "config `include` cycle detected with path `{}`",
                path.display()
            );
        }
        let contents = fs::read_to_string(path)
            .chain_err(|| format!("failed to read configuration file `{}`", path.display()))?;
        let toml = cargo_toml::parse(&contents, path, self)
            .chain_err(|| format!("could not parse TOML configuration in `{}`", path.display()))?;
        let value = CV::from_toml(Definition::Path(path.to_path_buf()), toml).chain_err(|| {
            format!(
                "failed to load TOML configuration from `{}`",
                path.display()
            )
        })?;
        let value = self.load_includes(value, seen)?;
        Ok(value)
    }

    /// Load any `include` files listed in the given `value`.
    ///
    /// Returns `value` with the given include files merged into it.
    ///
    /// `seen` is used to check for cyclic includes.
    fn load_includes(&self, mut value: CV, seen: &mut HashSet<PathBuf>) -> CargoResult<CV> {
        // Get the list of files to load.
        let (includes, def) = match &mut value {
            CV::Table(table, _def) => match table.remove("include") {
                Some(CV::String(s, def)) => (vec![(s, def.clone())], def),
                Some(CV::List(list, def)) => (list, def),
                Some(other) => bail!(
                    "`include` expected a string or list, but found {} in `{}`",
                    other.desc(),
                    other.definition()
                ),
                None => {
                    return Ok(value);
                }
            },
            _ => unreachable!(),
        };
        // Check unstable.
        if !self.cli_unstable().config_include {
            self.shell().warn(format!("config `include` in `{}` ignored, the -Zconfig-include command-line flag is required",
                def))?;
            return Ok(value);
        }
        // Accumulate all values here.
        let mut root = CV::Table(HashMap::new(), value.definition().clone());
        for (path, def) in includes {
            let abs_path = match &def {
                Definition::Path(p) => p.parent().unwrap().join(&path),
                Definition::Environment(_) | Definition::Cli => self.cwd().join(&path),
            };
            self._load_file(&abs_path, seen)
                .and_then(|include| root.merge(include, true))
                .chain_err(|| format!("failed to load config include `{}` from `{}`", path, def))?;
        }
        root.merge(value, true)?;
        Ok(root)
    }

    /// Add config arguments passed on the command line.
    fn merge_cli_args(&mut self) -> CargoResult<()> {
        let cli_args = match &self.cli_config {
            Some(cli_args) => cli_args,
            None => return Ok(()),
        };
        let mut loaded_args = CV::Table(HashMap::new(), Definition::Cli);
        for arg in cli_args {
            let arg_as_path = self.cwd.join(arg);
            let tmp_table = if !arg.is_empty() && arg_as_path.exists() {
                // --config path_to_file
                let str_path = arg_as_path
                    .to_str()
                    .ok_or_else(|| {
                        anyhow::format_err!("config path {:?} is not utf-8", arg_as_path)
                    })?
                    .to_string();
                let mut map = HashMap::new();
                let value = CV::String(str_path, Definition::Cli);
                map.insert("include".to_string(), value);
                CV::Table(map, Definition::Cli)
            } else {
                // TODO: This should probably use a more narrow parser, reject
                // comments, blank lines, [headers], etc.
                let toml_v: toml::Value = toml::de::from_str(arg)
                    .chain_err(|| format!("failed to parse --config argument `{}`", arg))?;
                let toml_table = toml_v.as_table().unwrap();
                if toml_table.len() != 1 {
                    bail!(
                        "--config argument `{}` expected exactly one key=value pair, got {} keys",
                        arg,
                        toml_table.len()
                    );
                }
                CV::from_toml(Definition::Cli, toml_v)
                    .chain_err(|| format!("failed to convert --config argument `{}`", arg))?
            };
            let mut seen = HashSet::new();
            let tmp_table = self
                .load_includes(tmp_table, &mut seen)
                .chain_err(|| "failed to load --config include".to_string())?;
            loaded_args
                .merge(tmp_table, true)
                .chain_err(|| format!("failed to merge --config argument `{}`", arg))?;
        }
        // Force values to be loaded.
        let _ = self.values()?;
        let values = self.values_mut()?;
        let loaded_map = match loaded_args {
            CV::Table(table, _def) => table,
            _ => unreachable!(),
        };
        for (key, value) in loaded_map.into_iter() {
            match values.entry(key) {
                Vacant(entry) => {
                    entry.insert(value);
                }
                Occupied(mut entry) => entry.get_mut().merge(value, true).chain_err(|| {
                    format!(
                        "failed to merge --config key `{}` into `{}`",
                        entry.key(),
                        entry.get().definition(),
                    )
                })?,
            };
        }
        Ok(())
    }

    /// The purpose of this function is to aid in the transition to using
    /// .toml extensions on Cargo's config files, which were historically not used.
    /// Both 'config.toml' and 'credentials.toml' should be valid with or without extension.
    /// When both exist, we want to prefer the one without an extension for
    /// backwards compatibility, but warn the user appropriately.
    fn get_file_path(
        &self,
        dir: &Path,
        filename_without_extension: &str,
        warn: bool,
    ) -> CargoResult<Option<PathBuf>> {
        let possible = dir.join(filename_without_extension);
        let possible_with_extension = dir.join(format!("{}.toml", filename_without_extension));

        if possible.exists() {
            if warn && possible_with_extension.exists() {
                // We don't want to print a warning if the version
                // without the extension is just a symlink to the version
                // WITH an extension, which people may want to do to
                // support multiple Cargo versions at once and not
                // get a warning.
                let skip_warning = if let Ok(target_path) = fs::read_link(&possible) {
                    target_path == possible_with_extension
                } else {
                    false
                };

                if !skip_warning {
                    self.shell().warn(format!(
                        "Both `{}` and `{}` exist. Using `{}`",
                        possible.display(),
                        possible_with_extension.display(),
                        possible.display()
                    ))?;
                }
            }

            Ok(Some(possible))
        } else if possible_with_extension.exists() {
            Ok(Some(possible_with_extension))
        } else {
            Ok(None)
        }
    }

    fn walk_tree<F>(&self, pwd: &Path, home: &Path, mut walk: F) -> CargoResult<()>
    where
        F: FnMut(&Path) -> CargoResult<()>,
    {
        let mut stash: HashSet<PathBuf> = HashSet::new();

        for current in paths::ancestors(pwd) {
            if let Some(path) = self.get_file_path(&current.join(".cargo"), "config", true)? {
                walk(&path)?;
                stash.insert(path);
            }
        }

        // Once we're done, also be sure to walk the home directory even if it's not
        // in our history to be sure we pick up that standard location for
        // information.
        if let Some(path) = self.get_file_path(home, "config", true)? {
            if !stash.contains(&path) {
                walk(&path)?;
            }
        }

        Ok(())
    }

    /// Gets the index for a registry.
    pub fn get_registry_index(&self, registry: &str) -> CargoResult<Url> {
        validate_package_name(registry, "registry name", "")?;
        if let Some(index) = self.get_string(&format!("registries.{}.index", registry))? {
            self.resolve_registry_index(&index).chain_err(|| {
                format!(
                    "invalid index URL for registry `{}` defined in {}",
                    registry, index.definition
                )
            })
        } else {
            bail!("no index found for registry: `{}`", registry);
        }
    }

    /// Returns an error if `registry.index` is set.
    pub fn check_registry_index_not_set(&self) -> CargoResult<()> {
        if self.get_string("registry.index")?.is_some() {
            bail!(
                "the `registry.index` config value is no longer supported\n\
                Use `[source]` replacement to alter the default index for crates.io."
            );
        }
        Ok(())
    }

    fn resolve_registry_index(&self, index: &Value<String>) -> CargoResult<Url> {
        // This handles relative file: URLs, relative to the config definition.
        let base = index
            .definition
            .root(self)
            .join("truncated-by-url_with_base");
        // Parse val to check it is a URL, not a relative path without a protocol.
        let _parsed = index.val.into_url()?;
        let url = index.val.into_url_with_base(Some(&*base))?;
        if url.password().is_some() {
            bail!("registry URLs may not contain passwords");
        }
        Ok(url)
    }

    /// Loads credentials config from the credentials file, if present.
    pub fn load_credentials(&mut self) -> CargoResult<()> {
        let home_path = self.home_path.clone().into_path_unlocked();
        let credentials = match self.get_file_path(&home_path, "credentials", true)? {
            Some(credentials) => credentials,
            None => return Ok(()),
        };

        let mut value = self.load_file(&credentials)?;
        // Backwards compatibility for old `.cargo/credentials` layout.
        {
            let (value_map, def) = match value {
                CV::Table(ref mut value, ref def) => (value, def),
                _ => unreachable!(),
            };

            if let Some(token) = value_map.remove("token") {
                if let Vacant(entry) = value_map.entry("registry".into()) {
                    let mut map = HashMap::new();
                    map.insert("token".into(), token);
                    let table = CV::Table(map, def.clone());
                    entry.insert(table);
                }
            }
        }

        if let CV::Table(map, _) = value {
            let base_map = self.values_mut()?;
            for (k, v) in map {
                match base_map.entry(k) {
                    Vacant(entry) => {
                        entry.insert(v);
                    }
                    Occupied(mut entry) => {
                        entry.get_mut().merge(v, true)?;
                    }
                }
            }
        }

        Ok(())
    }

    /// Looks for a path for `tool` in an environment variable or the given config, and returns
    /// `None` if it's not present.
    fn maybe_get_tool(&self, tool: &str, from_config: &Option<PathBuf>) -> Option<PathBuf> {
        let var = tool.to_uppercase();

        match env::var_os(&var) {
            Some(tool_path) => {
                let maybe_relative = match tool_path.to_str() {
                    Some(s) => s.contains('/') || s.contains('\\'),
                    None => false,
                };
                let path = if maybe_relative {
                    self.cwd.join(tool_path)
                } else {
                    PathBuf::from(tool_path)
                };
                Some(path)
            }

            None => from_config.clone(),
        }
    }

    /// Looks for a path for `tool` in an environment variable or config path, defaulting to `tool`
    /// as a path.
    fn get_tool(&self, tool: &str, from_config: &Option<PathBuf>) -> PathBuf {
        self.maybe_get_tool(tool, from_config)
            .unwrap_or_else(|| PathBuf::from(tool))
    }

    pub fn jobserver_from_env(&self) -> Option<&jobserver::Client> {
        self.jobserver.as_ref()
    }

    pub fn http(&self) -> CargoResult<&RefCell<Easy>> {
        let http = self
            .easy
            .try_borrow_with(|| ops::http_handle(self).map(RefCell::new))?;
        {
            let mut http = http.borrow_mut();
            http.reset();
            let timeout = ops::configure_http_handle(self, &mut http)?;
            timeout.configure(&mut http)?;
        }
        Ok(http)
    }

    pub fn http_config(&self) -> CargoResult<&CargoHttpConfig> {
        self.http_config
            .try_borrow_with(|| Ok(self.get::<CargoHttpConfig>("http")?))
    }

    pub fn net_config(&self) -> CargoResult<&CargoNetConfig> {
        self.net_config
            .try_borrow_with(|| Ok(self.get::<CargoNetConfig>("net")?))
    }

    pub fn build_config(&self) -> CargoResult<&CargoBuildConfig> {
        self.build_config
            .try_borrow_with(|| Ok(self.get::<CargoBuildConfig>("build")?))
    }

    pub fn progress_config(&self) -> &ProgressConfig {
        &self.progress_config
    }

    /// This is used to validate the `term` table has valid syntax.
    ///
    /// This is necessary because loading the term settings happens very
    /// early, and in some situations (like `cargo version`) we don't want to
    /// fail if there are problems with the config file.
    pub fn validate_term_config(&self) -> CargoResult<()> {
        drop(self.get::<TermConfig>("term")?);
        Ok(())
    }

    /// Returns a list of [target.'cfg()'] tables.
    ///
    /// The list is sorted by the table name.
    pub fn target_cfgs(&self) -> CargoResult<&Vec<(String, TargetCfgConfig)>> {
        self.target_cfgs
            .try_borrow_with(|| target::load_target_cfgs(self))
    }

    pub fn doc_extern_map(&self) -> CargoResult<&RustdocExternMap> {
        // Note: This does not support environment variables. The `Unit`
        // fundamentally does not have access to the registry name, so there is
        // nothing to query. Plumbing the name into SourceId is quite challenging.
        self.doc_extern_map
            .try_borrow_with(|| self.get::<RustdocExternMap>("doc.extern-map"))
    }

    /// Returns the `[target]` table definition for the given target triple.
    pub fn target_cfg_triple(&self, target: &str) -> CargoResult<TargetConfig> {
        target::load_target_triple(self, target)
    }

    pub fn crates_io_source_id<F>(&self, f: F) -> CargoResult<SourceId>
    where
        F: FnMut() -> CargoResult<SourceId>,
    {
        Ok(*(self.crates_io_source_id.try_borrow_with(f)?))
    }

    pub fn creation_time(&self) -> Instant {
        self.creation_time
    }

    /// Retrieves a config variable.
    ///
    /// This supports most serde `Deserialize` types. Examples:
    ///
    /// ```rust,ignore
    /// let v: Option<u32> = config.get("some.nested.key")?;
    /// let v: Option<MyStruct> = config.get("some.key")?;
    /// let v: Option<HashMap<String, MyStruct>> = config.get("foo")?;
    /// ```
    ///
    /// The key may be a dotted key, but this does NOT support TOML key
    /// quoting. Avoid key components that may have dots. For example,
    /// `foo.'a.b'.bar" does not work if you try to fetch `foo.'a.b'". You can
    /// fetch `foo` if it is a map, though.
    pub fn get<'de, T: serde::de::Deserialize<'de>>(&self, key: &str) -> CargoResult<T> {
        let d = Deserializer {
            config: self,
            key: ConfigKey::from_str(key),
            env_prefix_ok: true,
        };
        T::deserialize(d).map_err(|e| e.into())
    }

    pub fn assert_package_cache_locked<'a>(&self, f: &'a Filesystem) -> &'a Path {
        let ret = f.as_path_unlocked();
        assert!(
            self.package_cache_lock.borrow().is_some(),
            "package cache lock is not currently held, Cargo forgot to call \
             `acquire_package_cache_lock` before we got to this stack frame",
        );
        assert!(ret.starts_with(self.home_path.as_path_unlocked()));
        ret
    }

    /// Acquires an exclusive lock on the global "package cache"
    ///
    /// This lock is global per-process and can be acquired recursively. An RAII
    /// structure is returned to release the lock, and if this process
    /// abnormally terminates the lock is also released.
    pub fn acquire_package_cache_lock(&self) -> CargoResult<PackageCacheLock<'_>> {
        let mut slot = self.package_cache_lock.borrow_mut();
        match *slot {
            // We've already acquired the lock in this process, so simply bump
            // the count and continue.
            Some((_, ref mut cnt)) => {
                *cnt += 1;
            }
            None => {
                let path = ".package-cache";
                let desc = "package cache";

                // First, attempt to open an exclusive lock which is in general
                // the purpose of this lock!
                //
                // If that fails because of a readonly filesystem or a
                // permission error, though, then we don't really want to fail
                // just because of this. All files that this lock protects are
                // in subfolders, so they're assumed by Cargo to also be
                // readonly or have invalid permissions for us to write to. If
                // that's the case, then we don't really need to grab a lock in
                // the first place here.
                //
                // Despite this we attempt to grab a readonly lock. This means
                // that if our read-only folder is shared read-write with
                // someone else on the system we should synchronize with them,
                // but if we can't even do that then we did our best and we just
                // keep on chugging elsewhere.
                match self.home_path.open_rw(path, self, desc) {
                    Ok(lock) => *slot = Some((Some(lock), 1)),
                    Err(e) => {
                        if maybe_readonly(&e) {
                            let lock = self.home_path.open_ro(path, self, desc).ok();
                            *slot = Some((lock, 1));
                            return Ok(PackageCacheLock(self));
                        }

                        Err(e).chain_err(|| "failed to acquire package cache lock")?;
                    }
                }
            }
        }
        return Ok(PackageCacheLock(self));

        fn maybe_readonly(err: &anyhow::Error) -> bool {
            err.chain().any(|err| {
                if let Some(io) = err.downcast_ref::<io::Error>() {
                    if io.kind() == io::ErrorKind::PermissionDenied {
                        return true;
                    }

                    #[cfg(unix)]
                    return io.raw_os_error() == Some(libc::EROFS);
                }

                false
            })
        }
    }

    pub fn release_package_cache_lock(&self) {}
}

/// Internal error for serde errors.
#[derive(Debug)]
pub struct ConfigError {
    error: anyhow::Error,
    definition: Option<Definition>,
}

impl ConfigError {
    fn new(message: String, definition: Definition) -> ConfigError {
        ConfigError {
            error: anyhow::Error::msg(message),
            definition: Some(definition),
        }
    }

    fn expected(key: &ConfigKey, expected: &str, found: &ConfigValue) -> ConfigError {
        ConfigError {
            error: anyhow!(
                "`{}` expected {}, but found a {}",
                key,
                expected,
                found.desc()
            ),
            definition: Some(found.definition().clone()),
        }
    }

    fn missing(key: &ConfigKey) -> ConfigError {
        ConfigError {
            error: anyhow!("missing config key `{}`", key),
            definition: None,
        }
    }

    fn with_key_context(self, key: &ConfigKey, definition: Definition) -> ConfigError {
        ConfigError {
            error: anyhow::Error::from(self)
                .context(format!("could not load config key `{}`", key)),
            definition: Some(definition),
        }
    }
}

impl std::error::Error for ConfigError {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        self.error.source()
    }
}

impl fmt::Display for ConfigError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        if let Some(definition) = &self.definition {
            write!(f, "error in {}: {}", definition, self.error)
        } else {
            self.error.fmt(f)
        }
    }
}

impl serde::de::Error for ConfigError {
    fn custom<T: fmt::Display>(msg: T) -> Self {
        ConfigError {
            error: anyhow::Error::msg(msg.to_string()),
            definition: None,
        }
    }
}

impl From<anyhow::Error> for ConfigError {
    fn from(error: anyhow::Error) -> Self {
        ConfigError {
            error,
            definition: None,
        }
    }
}

#[derive(Eq, PartialEq, Clone)]
pub enum ConfigValue {
    Integer(i64, Definition),
    String(String, Definition),
    List(Vec<(String, Definition)>, Definition),
    Table(HashMap<String, ConfigValue>, Definition),
    Boolean(bool, Definition),
}

impl fmt::Debug for ConfigValue {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            CV::Integer(i, def) => write!(f, "{} (from {})", i, def),
            CV::Boolean(b, def) => write!(f, "{} (from {})", b, def),
            CV::String(s, def) => write!(f, "{} (from {})", s, def),
            CV::List(list, def) => {
                write!(f, "[")?;
                for (i, (s, def)) in list.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{} (from {})", s, def)?;
                }
                write!(f, "] (from {})", def)
            }
            CV::Table(table, _) => write!(f, "{:?}", table),
        }
    }
}

impl ConfigValue {
    fn from_toml(def: Definition, toml: toml::Value) -> CargoResult<ConfigValue> {
        match toml {
            toml::Value::String(val) => Ok(CV::String(val, def)),
            toml::Value::Boolean(b) => Ok(CV::Boolean(b, def)),
            toml::Value::Integer(i) => Ok(CV::Integer(i, def)),
            toml::Value::Array(val) => Ok(CV::List(
                val.into_iter()
                    .map(|toml| match toml {
                        toml::Value::String(val) => Ok((val, def.clone())),
                        v => bail!("expected string but found {} in list", v.type_str()),
                    })
                    .collect::<CargoResult<_>>()?,
                def,
            )),
            toml::Value::Table(val) => Ok(CV::Table(
                val.into_iter()
                    .map(|(key, value)| {
                        let value = CV::from_toml(def.clone(), value)
                            .chain_err(|| format!("failed to parse key `{}`", key))?;
                        Ok((key, value))
                    })
                    .collect::<CargoResult<_>>()?,
                def,
            )),
            v => bail!(
                "found TOML configuration value of unknown type `{}`",
                v.type_str()
            ),
        }
    }

    fn into_toml(self) -> toml::Value {
        match self {
            CV::Boolean(s, _) => toml::Value::Boolean(s),
            CV::String(s, _) => toml::Value::String(s),
            CV::Integer(i, _) => toml::Value::Integer(i),
            CV::List(l, _) => {
                toml::Value::Array(l.into_iter().map(|(s, _)| toml::Value::String(s)).collect())
            }
            CV::Table(l, _) => {
                toml::Value::Table(l.into_iter().map(|(k, v)| (k, v.into_toml())).collect())
            }
        }
    }

    /// Merge the given value into self.
    ///
    /// If `force` is true, primitive (non-container) types will override existing values.
    /// If false, the original will be kept and the new value ignored.
    ///
    /// Container types (tables and arrays) are merged with existing values.
    ///
    /// Container and non-container types cannot be mixed.
    fn merge(&mut self, from: ConfigValue, force: bool) -> CargoResult<()> {
        match (self, from) {
            (&mut CV::List(ref mut old, _), CV::List(ref mut new, _)) => {
                old.extend(mem::take(new).into_iter());
            }
            (&mut CV::Table(ref mut old, _), CV::Table(ref mut new, _)) => {
                for (key, value) in mem::take(new) {
                    match old.entry(key.clone()) {
                        Occupied(mut entry) => {
                            let new_def = value.definition().clone();
                            let entry = entry.get_mut();
                            entry.merge(value, force).chain_err(|| {
                                format!(
                                    "failed to merge key `{}` between \
                                     {} and {}",
                                    key,
                                    entry.definition(),
                                    new_def,
                                )
                            })?;
                        }
                        Vacant(entry) => {
                            entry.insert(value);
                        }
                    };
                }
            }
            // Allow switching types except for tables or arrays.
            (expected @ &mut CV::List(_, _), found)
            | (expected @ &mut CV::Table(_, _), found)
            | (expected, found @ CV::List(_, _))
            | (expected, found @ CV::Table(_, _)) => {
                return Err(anyhow!(
                    "failed to merge config value from `{}` into `{}`: expected {}, but found {}",
                    found.definition(),
                    expected.definition(),
                    expected.desc(),
                    found.desc()
                ));
            }
            (old, mut new) => {
                if force || new.definition().is_higher_priority(old.definition()) {
                    mem::swap(old, &mut new);
                }
            }
        }

        Ok(())
    }

    pub fn i64(&self, key: &str) -> CargoResult<(i64, &Definition)> {
        match self {
            CV::Integer(i, def) => Ok((*i, def)),
            _ => self.expected("integer", key),
        }
    }

    pub fn string(&self, key: &str) -> CargoResult<(&str, &Definition)> {
        match self {
            CV::String(s, def) => Ok((s, def)),
            _ => self.expected("string", key),
        }
    }

    pub fn table(&self, key: &str) -> CargoResult<(&HashMap<String, ConfigValue>, &Definition)> {
        match self {
            CV::Table(table, def) => Ok((table, def)),
            _ => self.expected("table", key),
        }
    }

    pub fn list(&self, key: &str) -> CargoResult<&[(String, Definition)]> {
        match self {
            CV::List(list, _) => Ok(list),
            _ => self.expected("list", key),
        }
    }

    pub fn boolean(&self, key: &str) -> CargoResult<(bool, &Definition)> {
        match self {
            CV::Boolean(b, def) => Ok((*b, def)),
            _ => self.expected("bool", key),
        }
    }

    pub fn desc(&self) -> &'static str {
        match *self {
            CV::Table(..) => "table",
            CV::List(..) => "array",
            CV::String(..) => "string",
            CV::Boolean(..) => "boolean",
            CV::Integer(..) => "integer",
        }
    }

    pub fn definition(&self) -> &Definition {
        match self {
            CV::Boolean(_, def)
            | CV::Integer(_, def)
            | CV::String(_, def)
            | CV::List(_, def)
            | CV::Table(_, def) => def,
        }
    }

    fn expected<T>(&self, wanted: &str, key: &str) -> CargoResult<T> {
        bail!(
            "expected a {}, but found a {} for `{}` in {}",
            wanted,
            self.desc(),
            key,
            self.definition()
        )
    }
}

pub fn homedir(cwd: &Path) -> Option<PathBuf> {
    ::home::cargo_home_with_cwd(cwd).ok()
}

pub fn save_credentials(cfg: &Config, token: String, registry: Option<String>) -> CargoResult<()> {
    // If 'credentials.toml' exists, we should write to that, otherwise
    // use the legacy 'credentials'. There's no need to print the warning
    // here, because it would already be printed at load time.
    let home_path = cfg.home_path.clone().into_path_unlocked();
    let filename = match cfg.get_file_path(&home_path, "credentials", false)? {
        Some(path) => match path.file_name() {
            Some(filename) => Path::new(filename).to_owned(),
            None => Path::new("credentials").to_owned(),
        },
        None => Path::new("credentials").to_owned(),
    };

    let mut file = {
        cfg.home_path.create_dir()?;
        cfg.home_path
            .open_rw(filename, cfg, "credentials' config file")?
    };

    let (key, mut value) = {
        let key = "token".to_string();
        let value = ConfigValue::String(token, Definition::Path(file.path().to_path_buf()));
        let mut map = HashMap::new();
        map.insert(key, value);
        let table = CV::Table(map, Definition::Path(file.path().to_path_buf()));

        if let Some(registry) = registry.clone() {
            let mut map = HashMap::new();
            map.insert(registry, table);
            (
                "registries".into(),
                CV::Table(map, Definition::Path(file.path().to_path_buf())),
            )
        } else {
            ("registry".into(), table)
        }
    };

    let mut contents = String::new();
    file.read_to_string(&mut contents).chain_err(|| {
        format!(
            "failed to read configuration file `{}`",
            file.path().display()
        )
    })?;

    let mut toml = cargo_toml::parse(&contents, file.path(), cfg)?;

    // Move the old token location to the new one.
    if let Some(token) = toml.as_table_mut().unwrap().remove("token") {
        let mut map = HashMap::new();
        map.insert("token".to_string(), token);
        toml.as_table_mut()
            .unwrap()
            .insert("registry".into(), map.into());
    }

    if registry.is_some() {
        if let Some(table) = toml.as_table_mut().unwrap().remove("registries") {
            let v = CV::from_toml(Definition::Path(file.path().to_path_buf()), table)?;
            value.merge(v, false)?;
        }
    }
    toml.as_table_mut().unwrap().insert(key, value.into_toml());

    let contents = toml.to_string();
    file.seek(SeekFrom::Start(0))?;
    file.write_all(contents.as_bytes())
        .chain_err(|| format!("failed to write to `{}`", file.path().display()))?;
    file.file().set_len(contents.len() as u64)?;
    set_permissions(file.file(), 0o600)
        .chain_err(|| format!("failed to set permissions of `{}`", file.path().display()))?;

    return Ok(());

    #[cfg(unix)]
    fn set_permissions(file: &File, mode: u32) -> CargoResult<()> {
        use std::os::unix::fs::PermissionsExt;

        let mut perms = file.metadata()?.permissions();
        perms.set_mode(mode);
        file.set_permissions(perms)?;
        Ok(())
    }

    #[cfg(not(unix))]
    #[allow(unused)]
    fn set_permissions(file: &File, mode: u32) -> CargoResult<()> {
        Ok(())
    }
}

pub struct PackageCacheLock<'a>(&'a Config);

impl Drop for PackageCacheLock<'_> {
    fn drop(&mut self) {
        let mut slot = self.0.package_cache_lock.borrow_mut();
        let (_, cnt) = slot.as_mut().unwrap();
        *cnt -= 1;
        if *cnt == 0 {
            *slot = None;
        }
    }
}

#[derive(Debug, Default, Deserialize, PartialEq)]
#[serde(rename_all = "kebab-case")]
pub struct CargoHttpConfig {
    pub proxy: Option<String>,
    pub low_speed_limit: Option<u32>,
    pub timeout: Option<u64>,
    pub cainfo: Option<ConfigRelativePath>,
    pub check_revoke: Option<bool>,
    pub user_agent: Option<String>,
    pub debug: Option<bool>,
    pub multiplexing: Option<bool>,
    pub ssl_version: Option<SslVersionConfig>,
}

/// Configuration for `ssl-version` in `http` section
/// There are two ways to configure:
///
/// ```text
/// [http]
/// ssl-version = "tlsv1.3"
/// ```
///
/// ```text
/// [http]
/// ssl-version.min = "tlsv1.2"
/// ssl-version.max = "tlsv1.3"
/// ```
#[derive(Clone, Debug, Deserialize, PartialEq)]
#[serde(untagged)]
pub enum SslVersionConfig {
    Single(String),
    Range(SslVersionConfigRange),
}

#[derive(Clone, Debug, Deserialize, PartialEq)]
pub struct SslVersionConfigRange {
    pub min: Option<String>,
    pub max: Option<String>,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub struct CargoNetConfig {
    pub retry: Option<u32>,
    pub offline: Option<bool>,
    pub git_fetch_with_cli: Option<bool>,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "kebab-case")]
pub struct CargoBuildConfig {
    pub pipelining: Option<bool>,
    pub dep_info_basedir: Option<ConfigRelativePath>,
    pub target_dir: Option<ConfigRelativePath>,
    pub incremental: Option<bool>,
    pub target: Option<ConfigRelativePath>,
    pub jobs: Option<u32>,
    pub rustflags: Option<StringList>,
    pub rustdocflags: Option<StringList>,
    pub rustc_wrapper: Option<PathBuf>,
    pub rustc_workspace_wrapper: Option<PathBuf>,
    pub rustc: Option<PathBuf>,
    pub rustdoc: Option<PathBuf>,
    pub out_dir: Option<ConfigRelativePath>,
}

#[derive(Deserialize, Default)]
struct TermConfig {
    verbose: Option<bool>,
    color: Option<String>,
    #[serde(default)]
    #[serde(deserialize_with = "progress_or_string")]
    progress: Option<ProgressConfig>,
}

#[derive(Debug, Default, Deserialize)]
pub struct ProgressConfig {
    pub when: ProgressWhen,
    pub width: Option<usize>,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum ProgressWhen {
    Auto,
    Never,
    Always,
}

impl Default for ProgressWhen {
    fn default() -> ProgressWhen {
        ProgressWhen::Auto
    }
}

fn progress_or_string<'de, D>(deserializer: D) -> Result<Option<ProgressConfig>, D::Error>
where
    D: serde::de::Deserializer<'de>,
{
    struct ProgressVisitor;

    impl<'de> serde::de::Visitor<'de> for ProgressVisitor {
        type Value = Option<ProgressConfig>;

        fn expecting(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
            formatter.write_str("a string (\"auto\" or \"never\") or a table")
        }

        fn visit_str<E>(self, s: &str) -> Result<Self::Value, E>
        where
            E: serde::de::Error,
        {
            match s {
                "auto" => Ok(Some(ProgressConfig {
                    when: ProgressWhen::Auto,
                    width: None,
                })),
                "never" => Ok(Some(ProgressConfig {
                    when: ProgressWhen::Never,
                    width: None,
                })),
                "always" => Err(E::custom("\"always\" progress requires a `width` key")),
                _ => Err(E::unknown_variant(s, &["auto", "never"])),
            }
        }

        fn visit_none<E>(self) -> Result<Self::Value, E>
        where
            E: serde::de::Error,
        {
            Ok(None)
        }

        fn visit_some<D>(self, deserializer: D) -> Result<Self::Value, D::Error>
        where
            D: serde::de::Deserializer<'de>,
        {
            let pc = ProgressConfig::deserialize(deserializer)?;
            if let ProgressConfig {
                when: ProgressWhen::Always,
                width: None,
            } = pc
            {
                return Err(serde::de::Error::custom(
                    "\"always\" progress requires a `width` key",
                ));
            }
            Ok(Some(pc))
        }
    }

    deserializer.deserialize_option(ProgressVisitor)
}

/// A type to deserialize a list of strings from a toml file.
///
/// Supports deserializing either a whitespace-separated list of arguments in a
/// single string or a string list itself. For example these deserialize to
/// equivalent values:
///
/// ```toml
/// a = 'a b c'
/// b = ['a', 'b', 'c']
/// ```
#[derive(Debug, Deserialize, Clone)]
pub struct StringList(Vec<String>);

impl StringList {
    pub fn as_slice(&self) -> &[String] {
        &self.0
    }
}

/// StringList automatically merges config values with environment values,
/// this instead follows the precedence rules, so that eg. a string list found
/// in the environment will be used instead of one in a config file.
///
/// This is currently only used by `PathAndArgs`
#[derive(Debug, Deserialize)]
pub struct UnmergedStringList(Vec<String>);

#[macro_export]
macro_rules! __shell_print {
    ($config:expr, $which:ident, $newline:literal, $($arg:tt)*) => ({
        let mut shell = $config.shell();
        let out = shell.$which();
        drop(out.write_fmt(format_args!($($arg)*)));
        if $newline {
            drop(out.write_all(b"\n"));
        }
    });
}

#[macro_export]
macro_rules! drop_println {
    ($config:expr) => ( $crate::drop_print!($config, "\n") );
    ($config:expr, $($arg:tt)*) => (
        $crate::__shell_print!($config, out, true, $($arg)*)
    );
}

#[macro_export]
macro_rules! drop_eprintln {
    ($config:expr) => ( $crate::drop_eprint!($config, "\n") );
    ($config:expr, $($arg:tt)*) => (
        $crate::__shell_print!($config, err, true, $($arg)*)
    );
}

#[macro_export]
macro_rules! drop_print {
    ($config:expr, $($arg:tt)*) => (
        $crate::__shell_print!($config, out, false, $($arg)*)
    );
}

#[macro_export]
macro_rules! drop_eprint {
    ($config:expr, $($arg:tt)*) => (
        $crate::__shell_print!($config, err, false, $($arg)*)
    );
}
