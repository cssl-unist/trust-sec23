#!/usr/bin/env bash

# This script regenerates hyper.h. As of April 2021, it only works with the
# nightly build of Rust.

set -e

CAPI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

WORK_DIR=$(mktemp -d)

# check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
    echo "Could not create temp dir"
    exit 1
fi

header_file_backup="$CAPI_DIR/include/hyper.h.backup"

function cleanup {
    rm -rf "$WORK_DIR"
    rm "$header_file_backup" || true
}

trap cleanup EXIT

mkdir "$WORK_DIR/src"

# Fake a library
cat > "$WORK_DIR/src/lib.rs" << EOF
#[path = "$CAPI_DIR/../src/ffi/mod.rs"]
pub mod ffi;
EOF

# And its Cargo.toml
cat > "$WORK_DIR/Cargo.toml" << EOF
[package]
name = "hyper"
version = "0.0.0"
edition = "2018"
publish = false

[dependencies]
# Determined which dependencies we need by running the "cargo rustc" command
# below and watching the compile error output for references to unknown imports,
# until we didn't get any errors.
bytes = "1"
futures-channel = "0.3"
futures-util = { version = "0.3", default-features = false, features = ["alloc"] }
libc = { version = "0.2", optional = true }
http = "0.2"
http-body = "0.4"
tokio = { version = "1", features = ["rt"] }

[features]
default = [
    "client",
    "ffi",
    "http1",
]

http1 = []
client = []
ffi = ["libc", "tokio/rt"]
EOF

cp "$CAPI_DIR/include/hyper.h" "$header_file_backup"

#cargo metadata --no-default-features --features ffi --format-version 1 > "$WORK_DIR/metadata.json"

cd "${WORK_DIR}" || exit 2

# Expand just the ffi module
if ! output=$(RUSTFLAGS='--cfg hyper_unstable_ffi' cargo rustc -- -Z unpretty=expanded 2>&1 > expanded.rs); then
    # As of April 2021 the script above prints a lot of warnings/errors, and
    # exits with a nonzero return code, but hyper.h still gets generated.
    #
    # However, on Github Actions, this will result in automatic "annotations"
    # being added to files not related to a PR, so if this is `--verify` mode,
    # then don't show it.
    #
    # But yes show it when using it locally.
    if [[ "--verify" != "$1" ]]; then
        echo "$output"
    fi
fi

# Replace the previous copy with the single expanded file
rm -rf ./src
mkdir src
mv expanded.rs src/lib.rs


# Bindgen!
if ! cbindgen \
    --config "$CAPI_DIR/cbindgen.toml" \
    --lockfile "$CAPI_DIR/../Cargo.lock" \
    --output "$CAPI_DIR/include/hyper.h" \
    "${@}"; then
    bindgen_exit_code=$?
    if [[ "--verify" == "$1" ]]; then
        echo "diff generated (<) vs backup (>)"
        diff "$CAPI_DIR/include/hyper.h" "$header_file_backup"
    fi
    exit $bindgen_exit_code
fi

exit 0
