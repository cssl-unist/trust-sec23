echo "Setting up environment for benchmarks"


export SVFHOME=$PWD/mpk-svf
#parent=`realpath $PWD`
#parent="$(dirname "$parent../")"
export PRJHOME=$PWD
export LLVM_DIR="$PRJHOME/rust/build/x86_64-unknown-linux-gnu/llvm"
export PATH="$PRJHOME/rust/build/bin:$LLVM_DIR/bin:$PATH"
export LD_LIBRARY_PATH="$PRJHOME/mpk-library/build:$LD_LIBRARY_PATH"
