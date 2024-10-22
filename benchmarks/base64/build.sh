#!/bin/bash
rm -rf target
#env RUSTFLAGS="-C save-temps --emit=llvm-bc -Z print-link-args" cargo bench --no-run -Z build-std=std,core --target x86_64-unknown-linux-gnu> nightly_commands.txt 
env RUSTFLAGS="-C save-temps --emit=llvm-bc -Z print-link-args" cargo bench --no-run> nightly_commands.txt 
./run.sh
