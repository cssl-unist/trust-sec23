//! Tests for config settings.

use cargo::core::profiles::Strip;
use cargo::core::{enable_nightly_features, Shell};
use cargo::util::config::{self, Config, SslVersionConfig, StringList};
use cargo::util::interning::InternedString;
use cargo::util::toml::{self, VecStringOrBool as VSOB};
use cargo::CargoResult;
use cargo_test_support::{normalized_lines_match, paths, project, t};
use serde::Deserialize;
use std::borrow::Borrow;
use std::collections::{BTreeMap, HashMap};
use std::fs;
use std::io;
use std::os;
use std::path::{Path, PathBuf};

/// Helper for constructing a `Config` object.
pub struct ConfigBuilder {
    env: HashMap<String, String>,
    unstable: Vec<String>,
    config_args: Vec<String>,
    cwd: Option<PathBuf>,
}

impl ConfigBuilder {
    pub fn new() -> ConfigBuilder {
        ConfigBuilder {
            env: HashMap::new(),
            unstable: Vec::new(),
            config_args: Vec::new(),
            cwd: None,
        }
    }

    /// Passes a `-Z` flag.
    pub fn unstable_flag(&mut self, s: impl Into<String>) -> &mut Self {
        self.unstable.push(s.into());
        self
    }

    /// Sets an environment variable.
    pub fn env(&mut self, key: impl Into<String>, val: impl Into<String>) -> &mut Self {
        self.env.insert(key.into(), val.into());
        self
    }

    /// Passes a `--config` flag.
    pub fn config_arg(&mut self, arg: impl Into<String>) -> &mut Self {
        if !self.unstable.iter().any(|s| s == "unstable-options") {
            // --config is current unstable
            self.unstable_flag("unstable-options");
        }
        self.config_args.push(arg.into());
        self
    }

    /// Sets the current working directory where config files will be loaded.
    pub fn cwd(&mut self, path: impl AsRef<Path>) -> &mut Self {
        self.cwd = Some(paths::root().join(path.as_ref()));
        self
    }

    /// Creates the `Config`.
    pub fn build(&self) -> Config {
        self.build_err().unwrap()
    }

    /// Creates the `Config`, returning a Result.
    pub fn build_err(&self) -> CargoResult<Config> {
        if !self.unstable.is_empty() {
            // This is unfortunately global. Some day that should be fixed.
            enable_nightly_features();
        }
        let output = Box::new(fs::File::create(paths::root().join("shell.out")).unwrap());
        let shell = Shell::from_write(output);
        let cwd = self.cwd.clone().unwrap_or_else(|| paths::root());
        let homedir = paths::home();
        let mut config = Config::new(shell, cwd, homedir);
        config.set_env(self.env.clone());
        config.configure(
            0,
            false,
            None,
            false,
            false,
            false,
            &None,
            &self.unstable,
            &self.config_args,
        )?;
        Ok(config)
    }
}

fn new_config() -> Config {
    ConfigBuilder::new().build()
}

/// Read the output from Config.
pub fn read_output(config: Config) -> String {
    drop(config); // Paranoid about flushing the file.
    let path = paths::root().join("shell.out");
    fs::read_to_string(path).unwrap()
}

#[cargo_test]
fn read_env_vars_for_config() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                authors = []
                version = "0.0.0"
                build = "build.rs"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            "build.rs",
            r#"
                use std::env;
                fn main() {
                    assert_eq!(env::var("NUM_JOBS").unwrap(), "100");
                }
            "#,
        )
        .build();

    p.cargo("build").env("CARGO_BUILD_JOBS", "100").run();
}

pub fn write_config(config: &str) {
    write_config_at(paths::root().join(".cargo/config"), config);
}

pub fn write_config_at(path: impl AsRef<Path>, contents: &str) {
    let path = paths::root().join(path.as_ref());
    fs::create_dir_all(path.parent().unwrap()).unwrap();
    fs::write(path, contents).unwrap();
}

fn write_config_toml(config: &str) {
    write_config_at(paths::root().join(".cargo/config.toml"), config);
}

// Several test fail on windows if the user does not have permission to
// create symlinks (the `SeCreateSymbolicLinkPrivilege`). Instead of
// disabling these test on Windows, use this function to test whether we
// have permission, and return otherwise. This way, we still don't run these
// tests most of the time, but at least we do if the user has the right
// permissions.
// This function is derived from libstd fs tests.
pub fn got_symlink_permission() -> bool {
    if cfg!(unix) {
        return true;
    }
    let link = paths::root().join("some_hopefully_unique_link_name");
    let target = paths::root().join("nonexisting_target");

    match symlink_file(&target, &link) {
        Ok(_) => true,
        // ERROR_PRIVILEGE_NOT_HELD = 1314
        Err(ref err) if err.raw_os_error() == Some(1314) => false,
        Err(_) => true,
    }
}

#[cfg(unix)]
fn symlink_file(target: &Path, link: &Path) -> io::Result<()> {
    os::unix::fs::symlink(target, link)
}

#[cfg(windows)]
fn symlink_file(target: &Path, link: &Path) -> io::Result<()> {
    os::windows::fs::symlink_file(target, link)
}

fn symlink_config_to_config_toml() {
    let toml_path = paths::root().join(".cargo/config.toml");
    let symlink_path = paths::root().join(".cargo/config");
    t!(symlink_file(&toml_path, &symlink_path));
}

pub fn assert_error<E: Borrow<anyhow::Error>>(error: E, msgs: &str) {
    let causes = error
        .borrow()
        .chain()
        .enumerate()
        .map(|(i, e)| {
            if i == 0 {
                e.to_string()
            } else {
                format!("Caused by:\n  {}", e)
            }
        })
        .collect::<Vec<_>>()
        .join("\n\n");
    assert_match(msgs, &causes);
}

pub fn assert_match(expected: &str, actual: &str) {
    if !normalized_lines_match(expected, actual, None) {
        panic!(
            "Did not find expected:\n{}\nActual:\n{}\n",
            expected, actual
        );
    }
}

#[cargo_test]
fn get_config() {
    write_config(
        "\
[S]
f1 = 123
",
    );

    let config = new_config();

    #[derive(Debug, Deserialize, Eq, PartialEq)]
    struct S {
        f1: Option<i64>,
    }
    let s: S = config.get("S").unwrap();
    assert_eq!(s, S { f1: Some(123) });
    let config = ConfigBuilder::new().env("CARGO_S_F1", "456").build();
    let s: S = config.get("S").unwrap();
    assert_eq!(s, S { f1: Some(456) });
}

#[cargo_test]
fn config_works_with_extension() {
    write_config_toml(
        "\
[foo]
f1 = 1
",
    );

    let config = new_config();

    assert_eq!(config.get::<Option<i32>>("foo.f1").unwrap(), Some(1));
}

#[cargo_test]
fn config_ambiguous_filename_symlink_doesnt_warn() {
    // Windows requires special permissions to create symlinks.
    // If we don't have permission, just skip this test.
    if !got_symlink_permission() {
        return;
    };

    write_config_toml(
        "\
[foo]
f1 = 1
",
    );

    symlink_config_to_config_toml();

    let config = new_config();

    assert_eq!(config.get::<Option<i32>>("foo.f1").unwrap(), Some(1));

    // It should NOT have warned for the symlink.
    let output = read_output(config);
    let unexpected = "\
warning: Both `[..]/.cargo/config` and `[..]/.cargo/config.toml` exist. Using `[..]/.cargo/config`
";
    if normalized_lines_match(unexpected, &output, None) {
        panic!(
            "Found unexpected:\n{}\nActual error:\n{}\n",
            unexpected, output
        );
    }
}

#[cargo_test]
fn config_ambiguous_filename() {
    write_config(
        "\
[foo]
f1 = 1
",
    );

    write_config_toml(
        "\
[foo]
f1 = 2
",
    );

    let config = new_config();

    // It should use the value from the one without the extension for
    // backwards compatibility.
    assert_eq!(config.get::<Option<i32>>("foo.f1").unwrap(), Some(1));

    // But it also should have warned.
    let output = read_output(config);
    let expected = "\
warning: Both `[..]/.cargo/config` and `[..]/.cargo/config.toml` exist. Using `[..]/.cargo/config`
";
    assert_match(expected, &output);
}

#[cargo_test]
fn config_unused_fields() {
    write_config(
        "\
[S]
unused = 456
",
    );

    let config = ConfigBuilder::new()
        .env("CARGO_S_UNUSED2", "1")
        .env("CARGO_S2_UNUSED", "2")
        .build();

    #[derive(Debug, Deserialize, Eq, PartialEq)]
    struct S {
        f1: Option<i64>,
    }
    // This prints a warning (verified below).
    let s: S = config.get("S").unwrap();
    assert_eq!(s, S { f1: None });
    // This does not print anything, we cannot easily/reliably warn for
    // environment variables.
    let s: S = config.get("S2").unwrap();
    assert_eq!(s, S { f1: None });

    // Verify the warnings.
    let output = read_output(config);
    let expected = "\
warning: unused config key `S.unused` in `[..]/.cargo/config`
";
    assert_match(expected, &output);
}

#[cargo_test]
fn config_load_toml_profile() {
    write_config(
        "\
[profile.dev]
opt-level = 's'
lto = true
codegen-units=4
debug = true
debug-assertions = true
rpath = true
panic = 'abort'
overflow-checks = true
incremental = true

[profile.dev.build-override]
opt-level = 1

[profile.dev.package.bar]
codegen-units = 9

[profile.no-lto]
inherits = 'dev'
dir-name = 'without-lto'
lto = false
",
    );

    let config = ConfigBuilder::new()
        .unstable_flag("advanced-env")
        .env("CARGO_PROFILE_DEV_CODEGEN_UNITS", "5")
        .env("CARGO_PROFILE_DEV_BUILD_OVERRIDE_CODEGEN_UNITS", "11")
        .env("CARGO_PROFILE_DEV_PACKAGE_env_CODEGEN_UNITS", "13")
        .env("CARGO_PROFILE_DEV_PACKAGE_bar_OPT_LEVEL", "2")
        .build();

    // TODO: don't use actual `tomlprofile`.
    let p: toml::TomlProfile = config.get("profile.dev").unwrap();
    let mut packages = BTreeMap::new();
    let key = toml::ProfilePackageSpec::Spec(::cargo::core::PackageIdSpec::parse("bar").unwrap());
    let o_profile = toml::TomlProfile {
        opt_level: Some(toml::TomlOptLevel("2".to_string())),
        codegen_units: Some(9),
        ..Default::default()
    };
    packages.insert(key, o_profile);
    let key = toml::ProfilePackageSpec::Spec(::cargo::core::PackageIdSpec::parse("env").unwrap());
    let o_profile = toml::TomlProfile {
        codegen_units: Some(13),
        ..Default::default()
    };
    packages.insert(key, o_profile);

    assert_eq!(
        p,
        toml::TomlProfile {
            opt_level: Some(toml::TomlOptLevel("s".to_string())),
            lto: Some(toml::StringOrBool::Bool(true)),
            codegen_units: Some(5),
            debug: Some(toml::U32OrBool::Bool(true)),
            debug_assertions: Some(true),
            rpath: Some(true),
            panic: Some("abort".to_string()),
            overflow_checks: Some(true),
            incremental: Some(true),
            package: Some(packages),
            build_override: Some(Box::new(toml::TomlProfile {
                opt_level: Some(toml::TomlOptLevel("1".to_string())),
                codegen_units: Some(11),
                ..Default::default()
            })),
            ..Default::default()
        }
    );

    let p: toml::TomlProfile = config.get("profile.no-lto").unwrap();
    assert_eq!(
        p,
        toml::TomlProfile {
            lto: Some(toml::StringOrBool::Bool(false)),
            dir_name: Some(InternedString::new("without-lto")),
            inherits: Some(InternedString::new("dev")),
            ..Default::default()
        }
    );
}

#[cargo_test]
fn profile_env_var_prefix() {
    // Check for a bug with collision on DEBUG vs DEBUG_ASSERTIONS.
    let config = ConfigBuilder::new()
        .env("CARGO_PROFILE_DEV_DEBUG_ASSERTIONS", "false")
        .build();
    let p: toml::TomlProfile = config.get("profile.dev").unwrap();
    assert_eq!(p.debug_assertions, Some(false));
    assert_eq!(p.debug, None);

    let config = ConfigBuilder::new()
        .env("CARGO_PROFILE_DEV_DEBUG", "1")
        .build();
    let p: toml::TomlProfile = config.get("profile.dev").unwrap();
    assert_eq!(p.debug_assertions, None);
    assert_eq!(p.debug, Some(toml::U32OrBool::U32(1)));

    let config = ConfigBuilder::new()
        .env("CARGO_PROFILE_DEV_DEBUG_ASSERTIONS", "false")
        .env("CARGO_PROFILE_DEV_DEBUG", "1")
        .build();
    let p: toml::TomlProfile = config.get("profile.dev").unwrap();
    assert_eq!(p.debug_assertions, Some(false));
    assert_eq!(p.debug, Some(toml::U32OrBool::U32(1)));
}

#[cargo_test]
fn config_deserialize_any() {
    // Some tests to exercise deserialize_any for deserializers that need to
    // be told the format.
    write_config(
        "\
a = true
b = ['b']
c = ['c']
",
    );

    // advanced-env
    let config = ConfigBuilder::new()
        .unstable_flag("advanced-env")
        .env("CARGO_ENVB", "false")
        .env("CARGO_C", "['d']")
        .env("CARGO_ENVL", "['a', 'b']")
        .build();
    assert_eq!(config.get::<VSOB>("a").unwrap(), VSOB::Bool(true));
    assert_eq!(
        config.get::<VSOB>("b").unwrap(),
        VSOB::VecString(vec!["b".to_string()])
    );
    assert_eq!(
        config.get::<VSOB>("c").unwrap(),
        VSOB::VecString(vec!["c".to_string(), "d".to_string()])
    );
    assert_eq!(config.get::<VSOB>("envb").unwrap(), VSOB::Bool(false));
    assert_eq!(
        config.get::<VSOB>("envl").unwrap(),
        VSOB::VecString(vec!["a".to_string(), "b".to_string()])
    );

    // Demonstrate where merging logic isn't very smart. This could be improved.
    let config = ConfigBuilder::new().env("CARGO_A", "x y").build();
    assert_error(
        config.get::<VSOB>("a").unwrap_err(),
        "\
error in environment variable `CARGO_A`: could not load config key `a`

Caused by:
  invalid type: string \"x y\", expected a boolean or vector of strings",
    );

    // Normal env.
    let config = ConfigBuilder::new()
        .unstable_flag("advanced-env")
        .env("CARGO_B", "d e")
        .env("CARGO_C", "f g")
        .build();
    assert_eq!(
        config.get::<VSOB>("b").unwrap(),
        VSOB::VecString(vec!["b".to_string(), "d".to_string(), "e".to_string()])
    );
    assert_eq!(
        config.get::<VSOB>("c").unwrap(),
        VSOB::VecString(vec!["c".to_string(), "f".to_string(), "g".to_string()])
    );

    // config-cli
    // This test demonstrates that ConfigValue::merge isn't very smart.
    // It would be nice if it was smarter.
    let config = ConfigBuilder::new().config_arg("a = ['a']").build_err();
    assert_error(
        config.unwrap_err(),
        "\
failed to merge --config key `a` into `[..]/.cargo/config`

Caused by:
  failed to merge config value from `--config cli option` into `[..]/.cargo/config`: \
expected boolean, but found array",
    );

    // config-cli and advanced-env
    let config = ConfigBuilder::new()
        .unstable_flag("advanced-env")
        .config_arg("b=['clib']")
        .config_arg("c=['clic']")
        .env("CARGO_B", "env1 env2")
        .env("CARGO_C", "['e1', 'e2']")
        .build();
    assert_eq!(
        config.get::<VSOB>("b").unwrap(),
        VSOB::VecString(vec![
            "b".to_string(),
            "clib".to_string(),
            "env1".to_string(),
            "env2".to_string()
        ])
    );
    assert_eq!(
        config.get::<VSOB>("c").unwrap(),
        VSOB::VecString(vec![
            "c".to_string(),
            "clic".to_string(),
            "e1".to_string(),
            "e2".to_string()
        ])
    );
}

#[cargo_test]
fn config_toml_errors() {
    write_config(
        "\
[profile.dev]
opt-level = 'foo'
",
    );

    let config = new_config();

    assert_error(
        config.get::<toml::TomlProfile>("profile.dev").unwrap_err(),
        "\
error in [..]/.cargo/config: could not load config key `profile.dev.opt-level`

Caused by:
  must be an integer, `z`, or `s`, but found the string: \"foo\"",
    );

    let config = ConfigBuilder::new()
        .env("CARGO_PROFILE_DEV_OPT_LEVEL", "asdf")
        .build();

    assert_error(
        config.get::<toml::TomlProfile>("profile.dev").unwrap_err(),
        "\
error in environment variable `CARGO_PROFILE_DEV_OPT_LEVEL`: could not load config key `profile.dev.opt-level`

Caused by:
  must be an integer, `z`, or `s`, but found the string: \"asdf\"",
    );
}

#[cargo_test]
fn load_nested() {
    write_config(
        "\
[nest.foo]
f1 = 1
f2 = 2
[nest.bar]
asdf = 3
",
    );

    let config = ConfigBuilder::new()
        .unstable_flag("advanced-env")
        .env("CARGO_NEST_foo_f2", "3")
        .env("CARGO_NESTE_foo_f1", "1")
        .env("CARGO_NESTE_foo_f2", "3")
        .env("CARGO_NESTE_bar_asdf", "3")
        .build();

    type Nested = HashMap<String, HashMap<String, u8>>;

    let n: Nested = config.get("nest").unwrap();
    let mut expected = HashMap::new();
    let mut foo = HashMap::new();
    foo.insert("f1".to_string(), 1);
    foo.insert("f2".to_string(), 3);
    expected.insert("foo".to_string(), foo);
    let mut bar = HashMap::new();
    bar.insert("asdf".to_string(), 3);
    expected.insert("bar".to_string(), bar);
    assert_eq!(n, expected);

    let n: Nested = config.get("neste").unwrap();
    assert_eq!(n, expected);
}

#[cargo_test]
fn get_errors() {
    write_config(
        "\
[S]
f1 = 123
f2 = 'asdf'
big = 123456789
",
    );

    let config = ConfigBuilder::new()
        .env("CARGO_E_S", "asdf")
        .env("CARGO_E_BIG", "123456789")
        .build();
    assert_error(
        config.get::<i64>("foo").unwrap_err(),
        "missing config key `foo`",
    );
    assert_error(
        config.get::<i64>("foo.bar").unwrap_err(),
        "missing config key `foo.bar`",
    );
    assert_error(
        config.get::<i64>("S.f2").unwrap_err(),
        "error in [..]/.cargo/config: `S.f2` expected an integer, but found a string",
    );
    assert_error(
        config.get::<u8>("S.big").unwrap_err(),
        "\
error in [..].cargo/config: could not load config key `S.big`

Caused by:
  invalid value: integer `123456789`, expected u8",
    );

    // Environment variable type errors.
    assert_error(
        config.get::<i64>("e.s").unwrap_err(),
        "error in environment variable `CARGO_E_S`: invalid digit found in string",
    );
    assert_error(
        config.get::<i8>("e.big").unwrap_err(),
        "\
error in environment variable `CARGO_E_BIG`: could not load config key `e.big`

Caused by:
  invalid value: integer `123456789`, expected i8",
    );

    #[derive(Debug, Deserialize)]
    struct S {
        f1: i64,
        f2: String,
        f3: i64,
        big: i64,
    }
    assert_error(config.get::<S>("S").unwrap_err(), "missing field `f3`");
}

#[cargo_test]
fn config_get_option() {
    write_config(
        "\
[foo]
f1 = 1
",
    );

    let config = ConfigBuilder::new().env("CARGO_BAR_ASDF", "3").build();

    assert_eq!(config.get::<Option<i32>>("a").unwrap(), None);
    assert_eq!(config.get::<Option<i32>>("a.b").unwrap(), None);
    assert_eq!(config.get::<Option<i32>>("foo.f1").unwrap(), Some(1));
    assert_eq!(config.get::<Option<i32>>("bar.asdf").unwrap(), Some(3));
    assert_eq!(config.get::<Option<i32>>("bar.zzzz").unwrap(), None);
}

#[cargo_test]
fn config_bad_toml() {
    write_config("asdf");
    let config = new_config();
    assert_error(
        config.get::<i32>("foo").unwrap_err(),
        "\
could not load Cargo configuration

Caused by:
  could not parse TOML configuration in `[..]/.cargo/config`

Caused by:
  could not parse input as TOML

Caused by:
  expected an equals, found eof at line 1 column 5",
    );
}

#[cargo_test]
fn config_get_list() {
    write_config(
        "\
l1 = []
l2 = ['one', 'two']
l3 = 123
l4 = ['one', 'two']

[nested]
l = ['x']

[nested2]
l = ['y']

[nested-empty]
",
    );

    type L = Vec<String>;

    let config = ConfigBuilder::new()
        .unstable_flag("advanced-env")
        .env("CARGO_L4", "['three', 'four']")
        .env("CARGO_L5", "['a']")
        .env("CARGO_ENV_EMPTY", "[]")
        .env("CARGO_ENV_BLANK", "")
        .env("CARGO_ENV_NUM", "1")
        .env("CARGO_ENV_NUM_LIST", "[1]")
        .env("CARGO_ENV_TEXT", "asdf")
        .env("CARGO_LEPAIR", "['a', 'b']")
        .env("CARGO_NESTED2_L", "['z']")
        .env("CARGO_NESTEDE_L", "['env']")
        .env("CARGO_BAD_ENV", "[zzz]")
        .build();

    assert_eq!(config.get::<L>("unset").unwrap(), vec![] as Vec<String>);
    assert_eq!(config.get::<L>("l1").unwrap(), vec![] as Vec<String>);
    assert_eq!(config.get::<L>("l2").unwrap(), vec!["one", "two"]);
    assert_error(
        config.get::<L>("l3").unwrap_err(),
        "\
invalid configuration for key `l3`
expected a list, but found a integer for `l3` in [..]/.cargo/config",
    );
    assert_eq!(
        config.get::<L>("l4").unwrap(),
        vec!["one", "two", "three", "four"]
    );
    assert_eq!(config.get::<L>("l5").unwrap(), vec!["a"]);
    assert_eq!(config.get::<L>("env-empty").unwrap(), vec![] as Vec<String>);
    assert_eq!(config.get::<L>("env-blank").unwrap(), vec![] as Vec<String>);
    assert_eq!(config.get::<L>("env-num").unwrap(), vec!["1".to_string()]);
    assert_error(
        config.get::<L>("env-num-list").unwrap_err(),
        "error in environment variable `CARGO_ENV_NUM_LIST`: \
         expected string, found integer",
    );
    assert_eq!(
        config.get::<L>("env-text").unwrap(),
        vec!["asdf".to_string()]
    );
    // "invalid number" here isn't the best error, but I think it's just toml.rs.
    assert_error(
        config.get::<L>("bad-env").unwrap_err(),
        "error in environment variable `CARGO_BAD_ENV`: \
         could not parse TOML list: invalid TOML value, did you mean to use a quoted string? at line 1 column 8",
    );

    // Try some other sequence-like types.
    assert_eq!(
        config
            .get::<(String, String, String, String)>("l4")
            .unwrap(),
        (
            "one".to_string(),
            "two".to_string(),
            "three".to_string(),
            "four".to_string()
        )
    );
    assert_eq!(config.get::<(String,)>("l5").unwrap(), ("a".to_string(),));

    // Tuple struct
    #[derive(Debug, Deserialize, Eq, PartialEq)]
    struct TupS(String, String);
    assert_eq!(
        config.get::<TupS>("lepair").unwrap(),
        TupS("a".to_string(), "b".to_string())
    );

    // Nested with an option.
    #[derive(Debug, Deserialize, Eq, PartialEq)]
    struct S {
        l: Option<Vec<String>>,
    }
    assert_eq!(config.get::<S>("nested-empty").unwrap(), S { l: None });
    assert_eq!(
        config.get::<S>("nested").unwrap(),
        S {
            l: Some(vec!["x".to_string()]),
        }
    );
    assert_eq!(
        config.get::<S>("nested2").unwrap(),
        S {
            l: Some(vec!["y".to_string(), "z".to_string()]),
        }
    );
    assert_eq!(
        config.get::<S>("nestede").unwrap(),
        S {
            l: Some(vec!["env".to_string()]),
        }
    );
}

#[cargo_test]
fn config_get_other_types() {
    write_config(
        "\
ns = 123
ns2 = 456
",
    );

    let config = ConfigBuilder::new()
        .env("CARGO_NSE", "987")
        .env("CARGO_NS2", "654")
        .build();

    #[derive(Debug, Deserialize, Eq, PartialEq)]
    #[serde(transparent)]
    struct NewS(i32);
    assert_eq!(config.get::<NewS>("ns").unwrap(), NewS(123));
    assert_eq!(config.get::<NewS>("ns2").unwrap(), NewS(654));
    assert_eq!(config.get::<NewS>("nse").unwrap(), NewS(987));
    assert_error(
        config.get::<NewS>("unset").unwrap_err(),
        "missing config key `unset`",
    );
}

#[cargo_test]
fn config_relative_path() {
    write_config(&format!(
        "\
p1 = 'foo/bar'
p2 = '../abc'
p3 = 'b/c'
abs = '{}'
",
        paths::home().display(),
    ));

    let config = ConfigBuilder::new()
        .env("CARGO_EPATH", "a/b")
        .env("CARGO_P3", "d/e")
        .build();

    assert_eq!(
        config
            .get::<config::ConfigRelativePath>("p1")
            .unwrap()
            .resolve_path(&config),
        paths::root().join("foo/bar")
    );
    assert_eq!(
        config
            .get::<config::ConfigRelativePath>("p2")
            .unwrap()
            .resolve_path(&config),
        paths::root().join("../abc")
    );
    assert_eq!(
        config
            .get::<config::ConfigRelativePath>("p3")
            .unwrap()
            .resolve_path(&config),
        paths::root().join("d/e")
    );
    assert_eq!(
        config
            .get::<config::ConfigRelativePath>("abs")
            .unwrap()
            .resolve_path(&config),
        paths::home()
    );
    assert_eq!(
        config
            .get::<config::ConfigRelativePath>("epath")
            .unwrap()
            .resolve_path(&config),
        paths::root().join("a/b")
    );
}

#[cargo_test]
fn config_get_integers() {
    write_config(
        "\
npos = 123456789
nneg = -123456789
i64max = 9223372036854775807
",
    );

    let config = ConfigBuilder::new()
        .env("CARGO_EPOS", "123456789")
        .env("CARGO_ENEG", "-1")
        .env("CARGO_EI64MAX", "9223372036854775807")
        .build();

    assert_eq!(
        config.get::<u64>("i64max").unwrap(),
        9_223_372_036_854_775_807
    );
    assert_eq!(
        config.get::<i64>("i64max").unwrap(),
        9_223_372_036_854_775_807
    );
    assert_eq!(
        config.get::<u64>("ei64max").unwrap(),
        9_223_372_036_854_775_807
    );
    assert_eq!(
        config.get::<i64>("ei64max").unwrap(),
        9_223_372_036_854_775_807
    );

    assert_error(
        config.get::<u32>("nneg").unwrap_err(),
        "\
error in [..].cargo/config: could not load config key `nneg`

Caused by:
  invalid value: integer `-123456789`, expected u32",
    );
    assert_error(
        config.get::<u32>("eneg").unwrap_err(),
        "\
error in environment variable `CARGO_ENEG`: could not load config key `eneg`

Caused by:
  invalid value: integer `-1`, expected u32",
    );
    assert_error(
        config.get::<i8>("npos").unwrap_err(),
        "\
error in [..].cargo/config: could not load config key `npos`

Caused by:
  invalid value: integer `123456789`, expected i8",
    );
    assert_error(
        config.get::<i8>("epos").unwrap_err(),
        "\
error in environment variable `CARGO_EPOS`: could not load config key `epos`

Caused by:
  invalid value: integer `123456789`, expected i8",
    );
}

#[cargo_test]
fn config_get_ssl_version_missing() {
    write_config(
        "\
[http]
hello = 'world'
",
    );

    let config = new_config();

    assert!(config
        .get::<Option<SslVersionConfig>>("http.ssl-version")
        .unwrap()
        .is_none());
}

#[cargo_test]
fn config_get_ssl_version_single() {
    write_config(
        "\
[http]
ssl-version = 'tlsv1.2'
",
    );

    let config = new_config();

    let a = config
        .get::<Option<SslVersionConfig>>("http.ssl-version")
        .unwrap()
        .unwrap();
    match a {
        SslVersionConfig::Single(v) => assert_eq!(&v, "tlsv1.2"),
        SslVersionConfig::Range(_) => panic!("Did not expect ssl version min/max."),
    };
}

#[cargo_test]
fn config_get_ssl_version_min_max() {
    write_config(
        "\
[http]
ssl-version.min = 'tlsv1.2'
ssl-version.max = 'tlsv1.3'
",
    );

    let config = new_config();

    let a = config
        .get::<Option<SslVersionConfig>>("http.ssl-version")
        .unwrap()
        .unwrap();
    match a {
        SslVersionConfig::Single(_) => panic!("Did not expect exact ssl version."),
        SslVersionConfig::Range(range) => {
            assert_eq!(range.min, Some(String::from("tlsv1.2")));
            assert_eq!(range.max, Some(String::from("tlsv1.3")));
        }
    };
}

#[cargo_test]
fn config_get_ssl_version_both_forms_configured() {
    // this is not allowed
    write_config(
        "\
[http]
ssl-version = 'tlsv1.1'
ssl-version.min = 'tlsv1.2'
ssl-version.max = 'tlsv1.3'
",
    );

    let config = new_config();

    assert_error(
        config
            .get::<SslVersionConfig>("http.ssl-version")
            .unwrap_err(),
        "\
could not load Cargo configuration

Caused by:
  could not parse TOML configuration in `[..]/.cargo/config`

Caused by:
  could not parse input as TOML

Caused by:
  dotted key attempted to extend non-table type at line 2 column 15",
    );
    assert!(config
        .get::<Option<SslVersionConfig>>("http.ssl-version")
        .unwrap()
        .is_none());
}

#[cargo_test]
/// Assert that unstable options can be configured with the `unstable` table in
/// cargo config files
fn unstable_table_notation() {
    cargo::core::enable_nightly_features();
    write_config(
        "\
[unstable]
print-im-a-teapot = true
",
    );
    let config = ConfigBuilder::new().build();
    assert_eq!(config.cli_unstable().print_im_a_teapot, true);
}

#[cargo_test]
/// Assert that dotted notation works for configuring unstable options
fn unstable_dotted_notation() {
    cargo::core::enable_nightly_features();
    write_config(
        "\
unstable.print-im-a-teapot = true
",
    );
    let config = ConfigBuilder::new().build();
    assert_eq!(config.cli_unstable().print_im_a_teapot, true);
}

#[cargo_test]
/// Assert that Zflags on the CLI take precedence over those from config
fn unstable_cli_precedence() {
    cargo::core::enable_nightly_features();
    write_config(
        "\
unstable.print-im-a-teapot = true
",
    );
    let config = ConfigBuilder::new().build();
    assert_eq!(config.cli_unstable().print_im_a_teapot, true);

    let config = ConfigBuilder::new()
        .unstable_flag("print-im-a-teapot=no")
        .build();
    assert_eq!(config.cli_unstable().print_im_a_teapot, false);
}

#[cargo_test]
/// Assert that atempting to set an unstable flag that doesn't exist via config
/// is ignored on stable
fn unstable_invalid_flag_ignored_on_stable() {
    write_config(
        "\
unstable.an-invalid-flag = 'yes'
",
    );
    assert!(ConfigBuilder::new().build_err().is_ok());
}

#[cargo_test]
/// Assert that unstable options can be configured with the `unstable` table in
/// cargo config files
fn unstable_flags_ignored_on_stable() {
    write_config(
        "\
[unstable]
print-im-a-teapot = true
",
    );
    let config = ConfigBuilder::new().build();
    assert_eq!(config.cli_unstable().print_im_a_teapot, false);
}

#[cargo_test]
fn table_merge_failure() {
    // Config::merge fails to merge entries in two tables.
    write_config_at(
        "foo/.cargo/config",
        "
        [table]
        key = ['foo']
        ",
    );
    write_config_at(
        ".cargo/config",
        "
        [table]
        key = 'bar'
        ",
    );

    #[derive(Debug, Deserialize)]
    struct Table {
        key: StringList,
    }
    let config = ConfigBuilder::new().cwd("foo").build();
    assert_error(
        config.get::<Table>("table").unwrap_err(),
        "\
could not load Cargo configuration

Caused by:
  failed to merge configuration at `[..]/.cargo/config`

Caused by:
  failed to merge key `table` between [..]/foo/.cargo/config and [..]/.cargo/config

Caused by:
  failed to merge key `key` between [..]/foo/.cargo/config and [..]/.cargo/config

Caused by:
  failed to merge config value from `[..]/.cargo/config` into `[..]/foo/.cargo/config`: \
  expected array, but found string",
    );
}

#[cargo_test]
fn non_string_in_array() {
    // Currently only strings are supported.
    write_config("foo = [1, 2, 3]");
    let config = new_config();
    assert_error(
        config.get::<Vec<i32>>("foo").unwrap_err(),
        "\
could not load Cargo configuration

Caused by:
  failed to load TOML configuration from `[..]/.cargo/config`

Caused by:
  failed to parse key `foo`

Caused by:
  expected string but found integer in list",
    );
}

#[cargo_test]
fn struct_with_opt_inner_struct() {
    // Struct with a key that is Option of another struct.
    // Check that can be defined with environment variable.
    #[derive(Deserialize)]
    struct Inner {
        value: Option<i32>,
    }
    #[derive(Deserialize)]
    struct Foo {
        inner: Option<Inner>,
    }
    let config = ConfigBuilder::new()
        .env("CARGO_FOO_INNER_VALUE", "12")
        .build();
    let f: Foo = config.get("foo").unwrap();
    assert_eq!(f.inner.unwrap().value.unwrap(), 12);
}

#[cargo_test]
fn struct_with_default_inner_struct() {
    // Struct with serde defaults.
    // Check that can be defined with environment variable.
    #[derive(Deserialize, Default)]
    #[serde(default)]
    struct Inner {
        value: i32,
    }
    #[derive(Deserialize, Default)]
    #[serde(default)]
    struct Foo {
        inner: Inner,
    }
    let config = ConfigBuilder::new()
        .env("CARGO_FOO_INNER_VALUE", "12")
        .build();
    let f: Foo = config.get("foo").unwrap();
    assert_eq!(f.inner.value, 12);
}

#[cargo_test]
fn overlapping_env_config() {
    // Issue where one key is a prefix of another.
    #[derive(Deserialize)]
    #[serde(rename_all = "kebab-case")]
    struct Ambig {
        debug: Option<u32>,
        debug_assertions: Option<bool>,
    }
    let config = ConfigBuilder::new()
        .env("CARGO_AMBIG_DEBUG_ASSERTIONS", "true")
        .build();

    let s: Ambig = config.get("ambig").unwrap();
    assert_eq!(s.debug_assertions, Some(true));
    assert_eq!(s.debug, None);

    let config = ConfigBuilder::new().env("CARGO_AMBIG_DEBUG", "0").build();
    let s: Ambig = config.get("ambig").unwrap();
    assert_eq!(s.debug_assertions, None);
    assert_eq!(s.debug, Some(0));

    let config = ConfigBuilder::new()
        .env("CARGO_AMBIG_DEBUG", "1")
        .env("CARGO_AMBIG_DEBUG_ASSERTIONS", "true")
        .build();
    let s: Ambig = config.get("ambig").unwrap();
    assert_eq!(s.debug_assertions, Some(true));
    assert_eq!(s.debug, Some(1));
}

#[cargo_test]
fn overlapping_env_with_defaults_errors_out() {
    // Issue where one key is a prefix of another.
    // This is a limitation of mapping environment variables on to a hierarchy.
    // Check that we error out when we hit ambiguity in this way, rather than
    // the more-surprising defaulting through.
    // If, in the future, we can handle this more correctly, feel free to delete
    // this test.
    #[derive(Deserialize, Default)]
    #[serde(default, rename_all = "kebab-case")]
    struct Ambig {
        debug: u32,
        debug_assertions: bool,
    }
    let config = ConfigBuilder::new()
        .env("CARGO_AMBIG_DEBUG_ASSERTIONS", "true")
        .build();
    let err = config.get::<Ambig>("ambig").err().unwrap();
    assert!(format!("{}", err).contains("missing config key `ambig.debug`"));

    let config = ConfigBuilder::new().env("CARGO_AMBIG_DEBUG", "5").build();
    let s: Ambig = config.get("ambig").unwrap();
    assert_eq!(s.debug_assertions, bool::default());
    assert_eq!(s.debug, 5);

    let config = ConfigBuilder::new()
        .env("CARGO_AMBIG_DEBUG", "1")
        .env("CARGO_AMBIG_DEBUG_ASSERTIONS", "true")
        .build();
    let s: Ambig = config.get("ambig").unwrap();
    assert_eq!(s.debug_assertions, true);
    assert_eq!(s.debug, 1);
}

#[cargo_test]
fn struct_with_overlapping_inner_struct_and_defaults() {
    // Struct with serde defaults.
    // Check that can be defined with environment variable.
    #[derive(Deserialize, Default)]
    #[serde(default)]
    struct Inner {
        value: i32,
    }

    // Containing struct with a prefix of inner
    //
    // This is a limitation of mapping environment variables on to a hierarchy.
    // Check that we error out when we hit ambiguity in this way, rather than
    // the more-surprising defaulting through.
    // If, in the future, we can handle this more correctly, feel free to delete
    // this case.
    #[derive(Deserialize, Default)]
    #[serde(default)]
    struct PrefixContainer {
        inn: bool,
        inner: Inner,
    }
    let config = ConfigBuilder::new()
        .env("CARGO_PREFIXCONTAINER_INNER_VALUE", "12")
        .build();
    let err = config
        .get::<PrefixContainer>("prefixcontainer")
        .err()
        .unwrap();
    assert!(format!("{}", err).contains("missing config key `prefixcontainer.inn`"));
    let config = ConfigBuilder::new()
        .env("CARGO_PREFIXCONTAINER_INNER_VALUE", "12")
        .env("CARGO_PREFIXCONTAINER_INN", "true")
        .build();
    let f: PrefixContainer = config.get("prefixcontainer").unwrap();
    assert_eq!(f.inner.value, 12);
    assert_eq!(f.inn, true);

    // Containing struct where the inner value's field is a prefix of another
    //
    // This is a limitation of mapping environment variables on to a hierarchy.
    // Check that we error out when we hit ambiguity in this way, rather than
    // the more-surprising defaulting through.
    // If, in the future, we can handle this more correctly, feel free to delete
    // this case.
    #[derive(Deserialize, Default)]
    #[serde(default)]
    struct InversePrefixContainer {
        inner_field: bool,
        inner: Inner,
    }
    let config = ConfigBuilder::new()
        .env("CARGO_INVERSEPREFIXCONTAINER_INNER_VALUE", "12")
        .build();
    let f: InversePrefixContainer = config.get("inverseprefixcontainer").unwrap();
    assert_eq!(f.inner_field, bool::default());
    assert_eq!(f.inner.value, 12);
}

#[cargo_test]
fn string_list_tricky_env() {
    // Make sure StringList handles typed env values.
    let config = ConfigBuilder::new()
        .env("CARGO_KEY1", "123")
        .env("CARGO_KEY2", "true")
        .env("CARGO_KEY3", "1 2")
        .build();
    let x = config.get::<StringList>("key1").unwrap();
    assert_eq!(x.as_slice(), &["123".to_string()]);
    let x = config.get::<StringList>("key2").unwrap();
    assert_eq!(x.as_slice(), &["true".to_string()]);
    let x = config.get::<StringList>("key3").unwrap();
    assert_eq!(x.as_slice(), &["1".to_string(), "2".to_string()]);
}

#[cargo_test]
fn string_list_wrong_type() {
    // What happens if StringList is given then wrong type.
    write_config("some_list = 123");
    let config = ConfigBuilder::new().build();
    assert_error(
        config.get::<StringList>("some_list").unwrap_err(),
        "\
invalid configuration for key `some_list`
expected a string or array of strings, but found a integer for `some_list` in [..]/.cargo/config",
    );

    write_config("some_list = \"1 2\"");
    let config = ConfigBuilder::new().build();
    let x = config.get::<StringList>("some_list").unwrap();
    assert_eq!(x.as_slice(), &["1".to_string(), "2".to_string()]);
}

#[cargo_test]
fn string_list_advanced_env() {
    // StringList with advanced env.
    let config = ConfigBuilder::new()
        .unstable_flag("advanced-env")
        .env("CARGO_KEY1", "[]")
        .env("CARGO_KEY2", "['1 2', '3']")
        .env("CARGO_KEY3", "[123]")
        .build();
    let x = config.get::<StringList>("key1").unwrap();
    assert_eq!(x.as_slice(), &[] as &[String]);
    let x = config.get::<StringList>("key2").unwrap();
    assert_eq!(x.as_slice(), &["1 2".to_string(), "3".to_string()]);
    assert_error(
        config.get::<StringList>("key3").unwrap_err(),
        "error in environment variable `CARGO_KEY3`: expected string, found integer",
    );
}

#[cargo_test]
fn parse_enum() {
    write_config(
        "\
[profile.release]
strip = 'debuginfo'
",
    );

    let config = new_config();

    let p: toml::TomlProfile = config.get("profile.release").unwrap();
    let strip = p.strip.unwrap();
    assert_eq!(strip, Strip::DebugInfo);
}

#[cargo_test]
fn parse_enum_fail() {
    write_config(
        "\
[profile.release]
strip = 'invalid'
",
    );

    let config = new_config();

    assert_error(
        config
            .get::<toml::TomlProfile>("profile.release")
            .unwrap_err(),
        "\
error in [..]/.cargo/config: could not load config key `profile.release.strip`

Caused by:
  unknown variant `invalid`, expected one of `debuginfo`, `none`, `symbols`",
    );
}
