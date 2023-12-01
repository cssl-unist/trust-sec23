use std::collections::hash_map::{Entry, HashMap};
use std::env;
use std::hash::{Hash, Hasher};
use std::path::{Path, PathBuf};
use std::sync::Mutex;

use log::{debug, info, warn};
use serde::{Deserialize, Serialize};

use crate::util::interning::InternedString;
use crate::util::paths;
use crate::util::{self, profile, CargoResult, CargoResultExt, ProcessBuilder, StableHasher};

/// Information on the `rustc` executable
#[derive(Debug)]
pub struct Rustc {
    /// The location of the exe
    pub path: PathBuf,
    /// An optional program that will be passed the path of the rust exe as its first argument, and
    /// rustc args following this.
    pub wrapper: Option<PathBuf>,
    /// An optional wrapper to be used in addition to `rustc.wrapper` for workspace crates
    pub workspace_wrapper: Option<PathBuf>,
    /// Verbose version information (the output of `rustc -vV`)
    pub verbose_version: String,
    /// The rustc version (`1.23.4-beta.2`), this comes from verbose_version.
    pub version: semver::Version,
    /// The host triple (arch-platform-OS), this comes from verbose_version.
    pub host: InternedString,
    cache: Mutex<Cache>,
}

impl Rustc {
    /// Runs the compiler at `path` to learn various pieces of information about
    /// it, with an optional wrapper.
    ///
    /// If successful this function returns a description of the compiler along
    /// with a list of its capabilities.
    pub fn new(
        path: PathBuf,
        wrapper: Option<PathBuf>,
        workspace_wrapper: Option<PathBuf>,
        rustup_rustc: &Path,
        cache_location: Option<PathBuf>,
    ) -> CargoResult<Rustc> {
        let _p = profile::start("Rustc::new");

        let mut cache = Cache::load(&path, rustup_rustc, cache_location);

        let mut cmd = util::process(&path);
        cmd.arg("-vV");
        let verbose_version = cache.cached_output(&cmd)?.0;

        let extract = |field: &str| -> CargoResult<&str> {
            verbose_version
                .lines()
                .find(|l| l.starts_with(field))
                .map(|l| &l[field.len()..])
                .ok_or_else(|| {
                    anyhow::format_err!(
                        "`rustc -vV` didn't have a line for `{}`, got:\n{}",
                        field.trim(),
                        verbose_version
                    )
                })
        };

        let host = InternedString::new(extract("host: ")?);
        let version = semver::Version::parse(extract("release: ")?).chain_err(|| {
            format!(
                "rustc version does not appear to be a valid semver version, from:\n{}",
                verbose_version
            )
        })?;

        Ok(Rustc {
            path,
            wrapper,
            workspace_wrapper,
            verbose_version,
            version,
            host,
            cache: Mutex::new(cache),
        })
    }

    /// Gets a process builder set up to use the found rustc version, with a wrapper if `Some`.
    pub fn process(&self) -> ProcessBuilder {
        util::process(self.path.as_path()).wrapped(self.wrapper.as_ref())
    }

    /// Gets a process builder set up to use the found rustc version, with a wrapper if `Some`.
    pub fn workspace_process(&self) -> ProcessBuilder {
        util::process(self.path.as_path())
            .wrapped(self.workspace_wrapper.as_ref())
            .wrapped(self.wrapper.as_ref())
    }

    pub fn process_no_wrapper(&self) -> ProcessBuilder {
        util::process(&self.path)
    }

    pub fn cached_output(&self, cmd: &ProcessBuilder) -> CargoResult<(String, String)> {
        self.cache.lock().unwrap().cached_output(cmd)
    }
}

/// It is a well known fact that `rustc` is not the fastest compiler in the
/// world.  What is less known is that even `rustc --version --verbose` takes
/// about a hundred milliseconds! Because we need compiler version info even
/// for no-op builds, we cache it here, based on compiler's mtime and rustup's
/// current toolchain.
///
/// https://github.com/rust-lang/cargo/issues/5315
/// https://github.com/rust-lang/rust/issues/49761
#[derive(Debug)]
struct Cache {
    cache_location: Option<PathBuf>,
    dirty: bool,
    data: CacheData,
}

#[derive(Serialize, Deserialize, Debug, Default)]
struct CacheData {
    rustc_fingerprint: u64,
    outputs: HashMap<u64, (String, String)>,
    successes: HashMap<u64, bool>,
}

impl Cache {
    fn load(rustc: &Path, rustup_rustc: &Path, cache_location: Option<PathBuf>) -> Cache {
        match (cache_location, rustc_fingerprint(rustc, rustup_rustc)) {
            (Some(cache_location), Ok(rustc_fingerprint)) => {
                let empty = CacheData {
                    rustc_fingerprint,
                    outputs: HashMap::new(),
                    successes: HashMap::new(),
                };
                let mut dirty = true;
                let data = match read(&cache_location) {
                    Ok(data) => {
                        if data.rustc_fingerprint == rustc_fingerprint {
                            debug!("reusing existing rustc info cache");
                            dirty = false;
                            data
                        } else {
                            debug!("different compiler, creating new rustc info cache");
                            empty
                        }
                    }
                    Err(e) => {
                        debug!("failed to read rustc info cache: {}", e);
                        empty
                    }
                };
                return Cache {
                    cache_location: Some(cache_location),
                    dirty,
                    data,
                };

                fn read(path: &Path) -> CargoResult<CacheData> {
                    let json = paths::read(path)?;
                    Ok(serde_json::from_str(&json)?)
                }
            }
            (_, fingerprint) => {
                if let Err(e) = fingerprint {
                    warn!("failed to calculate rustc fingerprint: {}", e);
                }
                debug!("rustc info cache disabled");
                Cache {
                    cache_location: None,
                    dirty: false,
                    data: CacheData::default(),
                }
            }
        }
    }

    fn cached_output(&mut self, cmd: &ProcessBuilder) -> CargoResult<(String, String)> {
        let key = process_fingerprint(cmd);
        match self.data.outputs.entry(key) {
            Entry::Occupied(entry) => {
                debug!("rustc info cache hit");
                Ok(entry.get().clone())
            }
            Entry::Vacant(entry) => {
                debug!("rustc info cache miss");
                debug!("running {}", cmd);
                let output = cmd.exec_with_output()?;
                let stdout = String::from_utf8(output.stdout)
                    .map_err(|e| anyhow::anyhow!("{}: {:?}", e, e.as_bytes()))
                    .chain_err(|| anyhow::anyhow!("`{}` didn't return utf8 output", cmd))?;
                let stderr = String::from_utf8(output.stderr)
                    .map_err(|e| anyhow::anyhow!("{}: {:?}", e, e.as_bytes()))
                    .chain_err(|| anyhow::anyhow!("`{}` didn't return utf8 output", cmd))?;
                let output = (stdout, stderr);
                entry.insert(output.clone());
                self.dirty = true;
                Ok(output)
            }
        }
    }
}

impl Drop for Cache {
    fn drop(&mut self) {
        if !self.dirty {
            return;
        }
        if let Some(ref path) = self.cache_location {
            let json = serde_json::to_string(&self.data).unwrap();
            match paths::write(path, json.as_bytes()) {
                Ok(()) => info!("updated rustc info cache"),
                Err(e) => warn!("failed to update rustc info cache: {}", e),
            }
        }
    }
}

fn rustc_fingerprint(path: &Path, rustup_rustc: &Path) -> CargoResult<u64> {
    let mut hasher = StableHasher::new();

    let path = paths::resolve_executable(path)?;
    path.hash(&mut hasher);

    paths::mtime(&path)?.hash(&mut hasher);

    // Rustup can change the effective compiler without touching
    // the `rustc` binary, so we try to account for this here.
    // If we see rustup's env vars, we mix them into the fingerprint,
    // but we also mix in the mtime of the actual compiler (and not
    // the rustup shim at `~/.cargo/bin/rustup`), because `RUSTUP_TOOLCHAIN`
    // could be just `stable-x86_64-unknown-linux-gnu`, i.e, it could
    // not mention the version of Rust at all, which changes after
    // `rustup update`.
    //
    // If we don't see rustup env vars, but it looks like the compiler
    // is managed by rustup, we conservatively bail out.
    let maybe_rustup = rustup_rustc == path;
    match (
        maybe_rustup,
        env::var("RUSTUP_HOME"),
        env::var("RUSTUP_TOOLCHAIN"),
    ) {
        (_, Ok(rustup_home), Ok(rustup_toolchain)) => {
            debug!("adding rustup info to rustc fingerprint");
            rustup_toolchain.hash(&mut hasher);
            rustup_home.hash(&mut hasher);
            let real_rustc = Path::new(&rustup_home)
                .join("toolchains")
                .join(rustup_toolchain)
                .join("bin")
                .join("rustc")
                .with_extension(env::consts::EXE_EXTENSION);
            paths::mtime(&real_rustc)?.hash(&mut hasher);
        }
        (true, _, _) => anyhow::bail!("probably rustup rustc, but without rustup's env vars"),
        _ => (),
    }

    Ok(hasher.finish())
}

fn process_fingerprint(cmd: &ProcessBuilder) -> u64 {
    let mut hasher = StableHasher::new();
    cmd.get_args().hash(&mut hasher);
    let mut env = cmd.get_envs().iter().collect::<Vec<_>>();
    env.sort_unstable();
    env.hash(&mut hasher);
    hasher.finish()
}
