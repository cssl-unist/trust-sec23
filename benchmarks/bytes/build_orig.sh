#!/bin/bash

set -x
rm -rf target
LLVM_HOME=/home/martin/rust/build/x86_64-unknown-linux-gnu/llvm/build/
RUSTUP_TOOLCHAIN_LIB=/home/martin/rust/build/lib/rustlib/x86_64-unknown-linux-gnu/lib/
SVF=/home/martin/SVF/bin/dvf
MPK_LIB_DIR=/home/martin/mpk-library/build/
CRUST_LIB_DIR=/home/martin/crust/
export RUSTC=/home/martin/rust/build/bin/rustc
export CARGO_BUILD_STD=true
#export LD_PRELOAD=/home/martin/mpk-library/build/libmpk.so:/home/martin/allocators/jemalloc/lib/libjemalloc.so
#export LD_LIBRARY_PATH=/home/martin/mpk-library/build/:/home/martin/crust
~/rust/build/bin/cargo fetch
~/rust/build/bin/cargo rustc --release --bench benchmarks --verbose -- -C save-temps --emit=llvm-ir -Z print-link-args > nightly_commands.txt

#the program can now be run by finding the binary in the target/debug/deps folder
#run it by providing the necessary args
#remember to preload mpk libraries and allocators using
#env LD_PRELOAD=/home/martin/mpk-library/build/libmpk.so:/home/martin/allocators/jemalloc/lib/libjemalloc.so LD_LIBRARY_PATH=/home/martin/mpk-library/build/:/home/martin/crust

#here libcrust is just being used for this project only.
