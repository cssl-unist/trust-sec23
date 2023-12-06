#!/bin/bash

set -x
rm -rf target
LLVM_HOME=/home/martin/rust/build/x86_64-unknown-linux-gnu/llvm/build/
RUSTUP_TOOLCHAIN_LIB=/home/martin/rust/build/lib/rustlib/x86_64-unknown-linux-gnu/lib/
SVF=/home/martin/projects/mpk-rust/SVF/bin/dvf
MPK_LIB_DIR=/home/martin/mpk-library/build/
CRUST_LIB_DIR=/home/martin/crust/
export RUSTC=/home/martin/rust/build/bin/rustc
#export LD_PRELOAD=/home/martin/mpk-library/build/libmpk.so:/home/martin/allocators/jemalloc/lib/libjemalloc.so
#export LD_LIBRARY_PATH=/home/martin/mpk-library/build/:/home/martin/crust
~/rust/build/bin/cargo fetch
~/rust/build/bin/cargo rustc --bench benchmarks --verbose -- -C save-temps --emit=llvm-ir -Z print-link-args > nightly_commands.txt

#build command from nightly_commands.txt
#Using java => avoiding the stress of bash string handling
cp ~/projects/mpk-rust/ProcessCommands.java .

javac ProcessCommands.java

#obtain build command
java ProcessCommands > target/debug/deps/final_build.sh

cd target/debug/deps


ORIGIN=`pwd`

rm *no-opt*

find . -name '*.bc' | xargs -n 1 -I{} $SVF -cxt -query=all -max-cxt=100 -flow-bg=1000000 -field-limit=0 -cxt-bg=1000000 {}

find . -name '*.bc' | xargs -n 1 -I{} $LLVM_HOME/bin/opt -mpk-isolation -mpk-isolation-gates {} -o {}

find . -name '*.bc' | xargs -n 1 -I{} $LLVM_HOME/bin/llc {} -relocation-model=pic -filetype=obj

chmod +x final_build.sh

./final_build.sh

#the program can now be run by finding the binary in the target/debug/deps folder
#run it by providing the necessary args
#remember to preload mpk libraries and allocators using
#env LD_PRELOAD=/home/martin/mpk-library/build/libmpk.so:/home/martin/allocators/jemalloc/lib/libjemalloc.so LD_LIBRARY_PATH=/home/martin/mpk-library/build/:/home/martin/crust

#here libcrust is just being used for this project only.
