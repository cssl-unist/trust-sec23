# cargo-bench(1)
{{*set actionverb="Benchmark"}}
{{*set nouns="benchmarks"}}

## NAME

cargo-bench - Execute benchmarks of a package

## SYNOPSIS

`cargo bench` [_options_] [_benchname_] [`--` _bench-options_]

## DESCRIPTION

Compile and execute benchmarks.

The benchmark filtering argument _benchname_ and all the arguments following
the two dashes (`--`) are passed to the benchmark binaries and thus to
_libtest_ (rustc's built in unit-test and micro-benchmarking framework). If
you are passing arguments to both Cargo and the binary, the ones after `--` go
to the binary, the ones before go to Cargo. For details about libtest's
arguments see the output of `cargo bench -- --help`.  As an example, this will
run only the benchmark named `foo` (and skip other similarly named benchmarks
like `foobar`):

    cargo bench -- foo --exact

Benchmarks are built with the `--test` option to `rustc` which creates an
executable with a `main` function that automatically runs all functions
annotated with the `#[bench]` attribute. Cargo passes the `--bench` flag to
the test harness to tell it to run only benchmarks.

The libtest harness may be disabled by setting `harness = false` in the target
manifest settings, in which case your code will need to provide its own `main`
function to handle running benchmarks.

> **Note**: The
> [`#[bench]` attribute](https://doc.rust-lang.org/nightly/unstable-book/library-features/test.html)
> is currently unstable and only available on the
> [nightly channel](https://doc.rust-lang.org/book/appendix-07-nightly-rust.html).
> There are some packages available on
> [crates.io](https://crates.io/keywords/benchmark) that may help with
> running benchmarks on the stable channel, such as
> [Criterion](https://crates.io/crates/criterion).

## OPTIONS

### Benchmark Options

{{> options-test }}

{{> section-package-selection }}

### Target Selection

When no target selection options are given, `cargo bench` will build the
following targets of the selected packages:

- lib — used to link with binaries and benchmarks
- bins (only if benchmark targets are built and required features are
  available)
- lib as a benchmark
- bins as benchmarks
- benchmark targets

The default behavior can be changed by setting the `bench` flag for the target
in the manifest settings. Setting examples to `bench = true` will build and
run the example as a benchmark. Setting targets to `bench = false` will stop
them from being benchmarked by default. Target selection options that take a
target by name ignore the `bench` flag and will always benchmark the given
target.

{{> options-targets }}

{{> section-features }}

### Compilation Options

{{#options}}

{{> options-target-triple }}

{{/options}}

### Output Options

{{#options}}
{{> options-target-dir }}
{{/options}}

### Display Options

By default the Rust test harness hides output from benchmark execution to keep
results readable. Benchmark output can be recovered (e.g., for debugging) by
passing `--nocapture` to the benchmark binaries:

    cargo bench -- --nocapture

{{#options}}

{{> options-display }}

{{> options-message-format }}

{{/options}}

### Manifest Options

{{#options}}
{{> options-manifest-path }}

{{> options-locked }}
{{/options}}

{{> section-options-common }}

### Miscellaneous Options

The `--jobs` argument affects the building of the benchmark executable but
does not affect how many threads are used when running the benchmarks. The
Rust test harness runs benchmarks serially in a single thread.

{{#options}}
{{> options-jobs }}
{{/options}}

## PROFILES

Profiles may be used to configure compiler options such as optimization levels
and debug settings. See
[the reference](../reference/profiles.html)
for more details.

Benchmarks are always built with the `bench` profile. Binary and lib targets
are built separately as benchmarks with the `bench` profile. Library targets
are built with the `release` profiles when linked to binaries and benchmarks.
Dependencies use the `release` profile.

If you need a debug build of a benchmark, try building it with
{{man "cargo-build" 1}} which will use the `test` profile which is by default
unoptimized and includes debug information. You can then run the debug-enabled
benchmark manually.

{{> section-environment }}

{{> section-exit-status }}

## EXAMPLES

1. Build and execute all the benchmarks of the current package:

       cargo bench

2. Run only a specific benchmark within a specific benchmark target:

       cargo bench --bench bench_name -- modname::some_benchmark

## SEE ALSO
{{man "cargo" 1}}, {{man "cargo-test" 1}}
