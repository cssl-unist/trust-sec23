//! Tests for some invalid .cargo/config files.

use cargo_test_support::registry::Package;
use cargo_test_support::{basic_manifest, project, rustc_host};

#[cargo_test]
fn bad1() {
    let p = project()
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                  [target]
                  nonexistent-target = "foo"
            "#,
        )
        .build();
    p.cargo("build -v --target=nonexistent-target")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] invalid configuration for key `target.nonexistent-target`
expected a table, but found a string for `[..]` in [..]config
",
        )
        .run();
}

#[cargo_test]
fn bad2() {
    let p = project()
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                  [http]
                    proxy = 3.0
            "#,
        )
        .build();
    p.cargo("publish -v")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] could not load Cargo configuration

Caused by:
  failed to load TOML configuration from `[..]config`

Caused by:
  failed to parse key `http`

Caused by:
  failed to parse key `proxy`

Caused by:
  found TOML configuration value of unknown type `float`
",
        )
        .run();
}

#[cargo_test]
fn bad3() {
    let p = project()
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [http]
                  proxy = true
            "#,
        )
        .build();
    Package::new("foo", "1.0.0").publish();

    p.cargo("publish -v")
        .with_status(101)
        .with_stderr(
            "\
error: failed to update registry [..]

Caused by:
  error in [..]config: `http.proxy` expected a string, but found a boolean
",
        )
        .run();
}

#[cargo_test]
fn bad4() {
    let p = project()
        .file(
            ".cargo/config",
            r#"
                [cargo-new]
                  name = false
            "#,
        )
        .build();
    p.cargo("new -v foo")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] Failed to create package `foo` at `[..]`

Caused by:
  error in [..]config: `cargo-new.name` expected a string, but found a boolean
",
        )
        .run();
}

#[cargo_test]
fn bad6() {
    let p = project()
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [http]
                  user-agent = true
            "#,
        )
        .build();
    Package::new("foo", "1.0.0").publish();

    p.cargo("publish -v")
        .with_status(101)
        .with_stderr(
            "\
error: failed to update registry [..]

Caused by:
  error in [..]config: `http.user-agent` expected a string, but found a boolean
",
        )
        .run();
}

#[cargo_test]
fn bad_cargo_config_jobs() {
    let p = project()
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [build]
                jobs = -1
            "#,
        )
        .build();
    p.cargo("build -v")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] error in [..].cargo/config: \
could not load config key `build.jobs`

Caused by:
  invalid value: integer `-1`, expected u32
",
        )
        .run();
}

#[cargo_test]
fn invalid_global_config() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                foo = "0.1.0"
            "#,
        )
        .file(".cargo/config", "4")
        .file("src/lib.rs", "")
        .build();

    p.cargo("build -v")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] could not load Cargo configuration

Caused by:
  could not parse TOML configuration in `[..]`

Caused by:
  could not parse input as TOML

Caused by:
  expected an equals, found eof at line 1 column 2
",
        )
        .run();
}

#[cargo_test]
fn bad_cargo_lock() {
    let p = project()
        .file("Cargo.lock", "[[package]]\nfoo = 92")
        .file("src/lib.rs", "")
        .build();

    p.cargo("build -v")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse lock file at: [..]Cargo.lock

Caused by:
  missing field `name` for key `package`
",
        )
        .run();
}

#[cargo_test]
fn duplicate_packages_in_cargo_lock() {
    Package::new("bar", "0.1.0").publish();

    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [project]
                name = "foo"
                version = "0.0.1"
                authors = []

                [dependencies]
                bar = "0.1.0"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            "Cargo.lock",
            r#"
                [[package]]
                name = "foo"
                version = "0.0.1"
                dependencies = [
                 "bar 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)",
                ]

                [[package]]
                name = "bar"
                version = "0.1.0"
                source = "registry+https://github.com/rust-lang/crates.io-index"

                [[package]]
                name = "bar"
                version = "0.1.0"
                source = "registry+https://github.com/rust-lang/crates.io-index"
            "#,
        )
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse lock file at: [..]

Caused by:
  package `bar` is specified twice in the lockfile
",
        )
        .run();
}

#[cargo_test]
fn bad_source_in_cargo_lock() {
    Package::new("bar", "0.1.0").publish();

    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [project]
                name = "foo"
                version = "0.0.1"
                authors = []

                [dependencies]
                bar = "0.1.0"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            "Cargo.lock",
            r#"
                [[package]]
                name = "foo"
                version = "0.0.1"
                dependencies = [
                 "bar 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)",
                ]

                [[package]]
                name = "bar"
                version = "0.1.0"
                source = "You shall not parse"
            "#,
        )
        .build();

    p.cargo("build --verbose")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse lock file at: [..]

Caused by:
  invalid source `You shall not parse` for key `package.source`
",
        )
        .run();
}

#[cargo_test]
fn bad_dependency_in_lockfile() {
    let p = project()
        .file("src/lib.rs", "")
        .file(
            "Cargo.lock",
            r#"
                [[package]]
                name = "foo"
                version = "0.0.1"
                dependencies = [
                 "bar 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)",
                ]
            "#,
        )
        .build();

    p.cargo("build").run();
}

#[cargo_test]
fn bad_git_dependency() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                foo = { git = "file:.." }
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build -v")
        .with_status(101)
        .with_stderr(
            "\
[UPDATING] git repository `file:///`
[ERROR] failed to get `foo` as a dependency of package `foo v0.0.0 [..]`

Caused by:
  failed to load source for dependency `foo`

Caused by:
  Unable to update file:///

Caused by:
  failed to clone into: [..]

Caused by:
  [..]'file:///' is not a valid local file URI[..]
",
        )
        .run();
}

#[cargo_test]
fn bad_crate_type() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [lib]
                crate-type = ["bad_type", "rlib"]
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build -v")
        .with_status(101)
        .with_stderr_contains(
            "error: failed to run `rustc` to learn about crate-type bad_type information",
        )
        .run();
}

#[cargo_test]
fn malformed_override() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [target.x86_64-apple-darwin.freetype]
                native = {
                  foo: "bar"
                }
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse manifest at `[..]`

Caused by:
  could not parse input as TOML

Caused by:
  expected a table key, found a newline at line 8 column 27
",
        )
        .run();
}

#[cargo_test]
fn duplicate_binary_names() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
               [package]
               name = "qqq"
               version = "0.1.0"
               authors = ["A <a@a.a>"]

               [[bin]]
               name = "e"
               path = "a.rs"

               [[bin]]
               name = "e"
               path = "b.rs"
            "#,
        )
        .file("a.rs", r#"fn main() -> () {}"#)
        .file("b.rs", r#"fn main() -> () {}"#)
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse manifest at `[..]`

Caused by:
  found duplicate binary name e, but all binary targets must have a unique name
",
        )
        .run();
}

#[cargo_test]
fn duplicate_example_names() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
               [package]
               name = "qqq"
               version = "0.1.0"
               authors = ["A <a@a.a>"]

               [[example]]
               name = "ex"
               path = "examples/ex.rs"

               [[example]]
               name = "ex"
               path = "examples/ex2.rs"
            "#,
        )
        .file("examples/ex.rs", r#"fn main () -> () {}"#)
        .file("examples/ex2.rs", r#"fn main () -> () {}"#)
        .build();

    p.cargo("build --example ex")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse manifest at `[..]`

Caused by:
  found duplicate example name ex, but all example targets must have a unique name
",
        )
        .run();
}

#[cargo_test]
fn duplicate_bench_names() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
               [package]
               name = "qqq"
               version = "0.1.0"
               authors = ["A <a@a.a>"]

               [[bench]]
               name = "ex"
               path = "benches/ex.rs"

               [[bench]]
               name = "ex"
               path = "benches/ex2.rs"
            "#,
        )
        .file("benches/ex.rs", r#"fn main () {}"#)
        .file("benches/ex2.rs", r#"fn main () {}"#)
        .build();

    p.cargo("bench")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse manifest at `[..]`

Caused by:
  found duplicate bench name ex, but all bench targets must have a unique name
",
        )
        .run();
}

#[cargo_test]
fn duplicate_deps() {
    let p = project()
        .file("shim-bar/Cargo.toml", &basic_manifest("bar", "0.0.1"))
        .file("shim-bar/src/lib.rs", "pub fn a() {}")
        .file("linux-bar/Cargo.toml", &basic_manifest("bar", "0.0.1"))
        .file("linux-bar/src/lib.rs", "pub fn a() {}")
        .file(
            "Cargo.toml",
            r#"
               [package]
               name = "qqq"
               version = "0.0.1"
               authors = []

               [dependencies]
               bar = { path = "shim-bar" }

               [target.x86_64-unknown-linux-gnu.dependencies]
               bar = { path = "linux-bar" }
            "#,
        )
        .file("src/main.rs", r#"fn main () {}"#)
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse manifest at `[..]`

Caused by:
  Dependency 'bar' has different source paths depending on the build target. Each dependency must \
have a single canonical source path irrespective of build target.
",
        )
        .run();
}

#[cargo_test]
fn duplicate_deps_diff_sources() {
    let p = project()
        .file("shim-bar/Cargo.toml", &basic_manifest("bar", "0.0.1"))
        .file("shim-bar/src/lib.rs", "pub fn a() {}")
        .file("linux-bar/Cargo.toml", &basic_manifest("bar", "0.0.1"))
        .file("linux-bar/src/lib.rs", "pub fn a() {}")
        .file(
            "Cargo.toml",
            r#"
               [package]
               name = "qqq"
               version = "0.0.1"
               authors = []

               [target.i686-unknown-linux-gnu.dependencies]
               bar = { path = "shim-bar" }

               [target.x86_64-unknown-linux-gnu.dependencies]
               bar = { path = "linux-bar" }
            "#,
        )
        .file("src/main.rs", r#"fn main () {}"#)
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to parse manifest at `[..]`

Caused by:
  Dependency 'bar' has different source paths depending on the build target. Each dependency must \
have a single canonical source path irrespective of build target.
",
        )
        .run();
}

#[cargo_test]
fn unused_keys() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
               [package]
               name = "foo"
               version = "0.1.0"
               authors = []

               [target.foo]
               bar = "3"
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build")
        .with_stderr(
            "\
warning: unused manifest key: target.foo.bar
[COMPILING] foo v0.1.0 ([CWD])
[FINISHED] dev [unoptimized + debuginfo] target(s) in [..]
",
        )
        .run();

    let p = project()
        .file(
            "Cargo.toml",
            r#"
               cargo-features = ["named-profiles"]

               [package]
               name = "foo"
               version = "0.1.0"
               authors = []

               [profile.debug]
               debug = 1
               inherits = "dev"
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build -Z named-profiles")
        .masquerade_as_nightly_cargo()
        .with_stderr(
            "\
warning: use `[profile.dev]` to configure debug builds
[..]
[..]",
        )
        .run();

    p.cargo("build -Z named-profiles")
        .masquerade_as_nightly_cargo()
        .run();

    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [project]

                name = "foo"
                version = "0.5.0"
                authors = ["wycats@example.com"]
                bulid = "foo"
            "#,
        )
        .file("src/lib.rs", "pub fn foo() {}")
        .build();
    p.cargo("build")
        .with_stderr(
            "\
warning: unused manifest key: project.bulid
[COMPILING] foo [..]
[FINISHED] dev [unoptimized + debuginfo] target(s) in [..]
",
        )
        .run();

    let p = project()
        .at("bar")
        .file(
            "Cargo.toml",
            r#"
                [project]

                name = "foo"
                version = "0.5.0"
                authors = ["wycats@example.com"]

                [lib]
                build = "foo"
            "#,
        )
        .file("src/lib.rs", "pub fn foo() {}")
        .build();
    p.cargo("build")
        .with_stderr(
            "\
warning: unused manifest key: lib.build
[COMPILING] foo [..]
[FINISHED] dev [unoptimized + debuginfo] target(s) in [..]
",
        )
        .run();
}

#[cargo_test]
fn unused_keys_in_virtual_manifest() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [workspace]
                members = ["bar"]
                bulid = "foo"
            "#,
        )
        .file("bar/Cargo.toml", &basic_manifest("bar", "0.0.1"))
        .file("bar/src/lib.rs", "")
        .build();
    p.cargo("build --workspace")
        .with_stderr(
            "\
[WARNING] [..]/foo/Cargo.toml: unused manifest key: workspace.bulid
[COMPILING] bar [..]
[FINISHED] dev [unoptimized + debuginfo] target(s) in [..]
",
        )
        .run();
}

#[cargo_test]
fn empty_dependencies() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = {}
            "#,
        )
        .file("src/main.rs", "fn main() {}")
        .build();

    Package::new("bar", "0.0.1").publish();

    p.cargo("build")
        .with_stderr_contains(
            "\
warning: dependency (bar) specified without providing a local path, Git repository, or version \
to use. This will be considered an error in future versions
",
        )
        .run();
}

#[cargo_test]
fn invalid_toml_historically_allowed_is_warned() {
    let p = project()
        .file(".cargo/config", "[bar] baz = 2")
        .file("src/main.rs", "fn main() {}")
        .build();

    p.cargo("build")
        .with_stderr(
            "\
warning: TOML file found which contains invalid syntax and will soon not parse
at `[..]config`.

The TOML spec requires newlines after table definitions (e.g., `[a] b = 1` is
invalid), but this file has a table header which does not have a newline after
it. A newline needs to be added and this warning will soon become a hard error
in the future.
[COMPILING] foo v0.0.1 ([..])
[FINISHED] dev [unoptimized + debuginfo] target(s) in [..]
",
        )
        .run();
}

#[cargo_test]
fn ambiguous_git_reference() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies.bar]
                git = "http://127.0.0.1"
                branch = "master"
                tag = "some-tag"
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build -v")
        .with_status(101)
        .with_stderr_contains(
            "\
[WARNING] dependency (bar) specification is ambiguous. \
Only one of `branch`, `tag` or `rev` is allowed. \
This will be considered an error in future versions
",
        )
        .run();
}

#[cargo_test]
fn fragment_in_git_url() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies.bar]
                git = "http://127.0.0.1#foo"
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build -v")
        .with_status(101)
        .with_stderr_contains(
            "\
[WARNING] URL fragment `#foo` in git URL is ignored for dependency (bar). \
If you were trying to specify a specific git revision, \
use `rev = \"foo\"` in the dependency declaration.
",
        )
        .run();
}

#[cargo_test]
fn bad_source_config1() {
    let p = project()
        .file("src/lib.rs", "")
        .file(".cargo/config", "[source.foo]")
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr("error: no source location specified for `source.foo`, need [..]")
        .run();
}

#[cargo_test]
fn bad_source_config2() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = "*"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [source.crates-io]
                registry = 'http://example.com'
                replace-with = 'bar'
            "#,
        )
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to get `bar` as a dependency of package `foo v0.0.0 [..]`

Caused by:
  failed to load source for dependency `bar`

Caused by:
  Unable to update registry `https://[..]`

Caused by:
  could not find a configured source with the name `bar` \
    when attempting to lookup `crates-io` (configuration in [..])
",
        )
        .run();
}

#[cargo_test]
fn bad_source_config3() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = "*"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [source.crates-io]
                registry = 'https://example.com'
                replace-with = 'crates-io'
            "#,
        )
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to get `bar` as a dependency of package `foo v0.0.0 [..]`

Caused by:
  failed to load source for dependency `bar`

Caused by:
  Unable to update registry `https://[..]`

Caused by:
  detected a cycle of `replace-with` sources, [..]
",
        )
        .run();
}

#[cargo_test]
fn bad_source_config4() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = "*"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [source.crates-io]
                replace-with = 'bar'

                [source.bar]
                registry = 'https://example.com'
                replace-with = 'crates-io'
            "#,
        )
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] failed to get `bar` as a dependency of package `foo v0.0.0 ([..])`

Caused by:
  failed to load source for dependency `bar`

Caused by:
  Unable to update registry `https://[..]`

Caused by:
  detected a cycle of `replace-with` sources, the source `crates-io` is \
    eventually replaced with itself (configuration in [..])
",
        )
        .run();
}

#[cargo_test]
fn bad_source_config5() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = "*"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [source.crates-io]
                registry = 'https://example.com'
                replace-with = 'bar'

                [source.bar]
                registry = 'not a url'
            "#,
        )
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
error: configuration key `source.bar.registry` specified an invalid URL (in [..])

Caused by:
  invalid url `not a url`: [..]
",
        )
        .run();
}

#[cargo_test]
fn both_git_and_path_specified() {
    let foo = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies.bar]
                git = "http://127.0.0.1"
                path = "bar"
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    foo.cargo("build -v")
        .with_status(101)
        .with_stderr_contains(
            "\
[WARNING] dependency (bar) specification is ambiguous. \
Only one of `git` or `path` is allowed. \
This will be considered an error in future versions
",
        )
        .run();
}

#[cargo_test]
fn bad_source_config6() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = "*"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [source.crates-io]
                registry = 'https://example.com'
                replace-with = ['not', 'a', 'string']
            "#,
        )
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] error in [..]/foo/.cargo/config: could not load config key `source.crates-io.replace-with`

Caused by:
  error in [..]/foo/.cargo/config: `source.crates-io.replace-with` expected a string, but found a array
"
        )
        .run();
}

#[cargo_test]
fn ignored_git_revision() {
    let foo = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies.bar]
                path = "bar"
                branch = "spam"
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    foo.cargo("build -v")
        .with_status(101)
        .with_stderr_contains(
            "[WARNING] key `branch` is ignored for dependency (bar). \
             This will be considered an error in future versions",
        )
        .run();
}

#[cargo_test]
fn bad_source_config7() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = "*"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [source.foo]
                registry = 'https://example.com'
                local-registry = 'file:///another/file'
            "#,
        )
        .build();

    Package::new("bar", "0.1.0").publish();

    p.cargo("build")
        .with_status(101)
        .with_stderr("error: more than one source location specified for `source.foo`")
        .run();
}

#[cargo_test]
fn bad_source_config8() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = "*"
            "#,
        )
        .file("src/lib.rs", "")
        .file(
            ".cargo/config",
            r#"
                [source.foo]
                branch = "somebranch"
            "#,
        )
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "[ERROR] source definition `source.foo` specifies `branch`, \
             but that requires a `git` key to be specified (in [..]/foo/.cargo/config)",
        )
        .run();
}

#[cargo_test]
fn bad_dependency() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [dependencies]
                bar = 3
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
error: failed to parse manifest at `[..]`

Caused by:
  invalid type: integer `3`, expected a version string like [..]
",
        )
        .run();
}

#[cargo_test]
fn bad_debuginfo() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []

                [profile.dev]
                debug = 'a'
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
error: failed to parse manifest at `[..]`

Caused by:
  invalid type: string \"a\", expected a boolean or an integer for [..]
",
        )
        .run();
}

#[cargo_test]
fn bad_opt_level() {
    let p = project()
        .file(
            "Cargo.toml",
            r#"
                [package]
                name = "foo"
                version = "0.0.0"
                authors = []
                build = 3
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("build")
        .with_status(101)
        .with_stderr(
            "\
error: failed to parse manifest at `[..]`

Caused by:
  invalid type: integer `3`, expected a boolean or a string for key [..]
",
        )
        .run();
}

#[cargo_test]
fn warn_semver_metadata() {
    Package::new("bar", "1.0.0").publish();
    let p = project()
        .file(
            "Cargo.toml",
            r#"
            [package]
            name = "foo"
            version = "1.0.0"

            [dependencies]
            bar = "1.0.0+1234"
            "#,
        )
        .file("src/lib.rs", "")
        .build();
    p.cargo("check")
        .with_stderr_contains("[WARNING] version requirement `1.0.0+1234` for dependency `bar`[..]")
        .run();
}

#[cargo_test]
fn bad_target_cfg() {
    // Invalid type in a StringList.
    //
    // The error message is a bit unfortunate here. The type here ends up
    // being essentially Value<Value<StringList>>, and each layer of "Value"
    // adds some context to the error message. Also, untagged enums provide
    // strange error messages. Hopefully most users will be able to untangle
    // the message.
    let p = project()
        .file(
            ".cargo/config",
            r#"
            [target.'cfg(not(target_os = "none"))']
            runner = false
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("check")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] error in [..]/foo/.cargo/config: \
could not load config key `target.cfg(not(target_os = \"none\")).runner`

Caused by:
  error in [..]/foo/.cargo/config: \
  could not load config key `target.cfg(not(target_os = \"none\")).runner`

Caused by:
  invalid configuration for key `target.cfg(not(target_os = \"none\")).runner`
  expected a string or array of strings, but found a boolean for \
  `target.cfg(not(target_os = \"none\")).runner` in [..]/foo/.cargo/config
",
        )
        .run();
}

#[cargo_test]
fn bad_target_links_overrides() {
    // Invalid parsing of links overrides.
    //
    // This error message is terrible. Nothing in the deserialization path is
    // using config::Value<>, so nothing is able to report the location. I
    // think this illustrates how the way things break down with how it
    // currently is designed with serde.
    let p = project()
        .file(
            ".cargo/config",
            &format!(
                r#"
                [target.{}.somelib]
                rustc-flags = 'foo'
                "#,
                rustc_host()
            ),
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("check")
        .with_status(101)
        .with_stderr(
            "[ERROR] Only `-l` and `-L` flags are allowed in target config \
             `target.[..].rustc-flags` (in [..]foo/.cargo/config): `foo`",
        )
        .run();

    p.change_file(
        ".cargo/config",
        &format!(
            "[target.{}.somelib]
            warning = \"foo\"
            ",
            rustc_host(),
        ),
    );
    p.cargo("check")
        .with_status(101)
        .with_stderr("[ERROR] `warning` is not supported in build script overrides")
        .run();
}

#[cargo_test]
fn redefined_sources() {
    // Cannot define a source multiple times.
    let p = project()
        .file(
            ".cargo/config",
            r#"
            [source.foo]
            registry = "https://github.com/rust-lang/crates.io-index"
            "#,
        )
        .file("src/lib.rs", "")
        .build();

    p.cargo("check")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] source `foo` defines source registry `https://github.com/rust-lang/crates.io-index`, \
    but that source is already defined by `crates-io`
note: Sources are not allowed to be defined multiple times.
",
        )
        .run();

    p.change_file(
        ".cargo/config",
        r#"
        [source.one]
        directory = "index"

        [source.two]
        directory = "index"
        "#,
    );

    // Name is `[..]` because we can't guarantee the order.
    p.cargo("check")
        .with_status(101)
        .with_stderr(
            "\
[ERROR] source `[..]` defines source dir [..]/foo/index, \
    but that source is already defined by `[..]`
note: Sources are not allowed to be defined multiple times.
",
        )
        .run();
}
