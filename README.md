# trust-sec23

##Download Source Code
```sh
git clone https://github.com/cssl-unist/trust-sec23.git
```

## Dependencies

Make sure you have installed the dependencies:

* `python` 3 or 2.7
* `git`
* A C compiler (when building for the host, `cc` is enough; cross-compiling may
  need additional compilers)
* `curl` (not needed on Windows)
* `pkg-config` if you are compiling on Linux and targeting Linux
* `ninja`, or GNU `make` 3.81 or later (Ninja is recommended, especially on
  Windows)
* `libiconv` (already included with glibc on Debian-based distros)
* `cmake` 3.13.4 or later
* `libstdc++-static` may be required on some Linux distributions such as Fedora
  and Ubuntu

##Build Rust
```sh
cd TRust
cd rust
./x.py build && ./x.py install
rustup toolchain link trust ./build
rustup default trust
```


##Build mimalloc
```sh
cd ../mpk-mimalloc
./build.sh
```

##Build Dynamic Library
```sh
cd ../mpk-library
./build.sh
```

##Set Environment Variables
```sh
cd ../
. ./setup.sh
```
Environment variables set-up is required for both building the framework and running benchmarks

##Build Demangler
```sh
cd $PRJHOME/mpk-rust-demangle
cargo build --lib
cargo build --lib --release
```

##Build SVF
```sh
cd $PRJHOME/mpk-svf
. ./build.sh
```

##Build and Run Benchmarks

###Build and Run Base64, Bytes, Byteorder, Json,  Image, Regex
```sh
cd $PRJHOME/benchmarks/base64
./build.sh
cd target/release/deps
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./benchmarks-b37d04cee6b6da39  --bench
```
hash of the executable may vary (the executable may not exactly be benchmarks-b37d04cee6b6da39)

###Build and Run Regex
```sh
cd $PRJHOME/benchmarks/regex/bench
./build.sh
cd ../target/release/deps
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./benchmarks-b37d04cee6b6da39  --bench
```

###Build and Run Vec, String, Linked-list, Vec-deque, Btree
```sh
cd $PRJHOME/benchmarks/std
./build.sh
cd target/release/deps
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./collectionsbenches-949558e15ed0a833 --bench -- vec
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./collectionsbenches-949558e15ed0a833 --bench -- string
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./collectionsbenches-949558e15ed0a833 --bench -- linked-list
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./collectionsbenches-949558e15ed0a833 --bench -- vec-deque
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./collectionsbenches-949558e15ed0a833 --bench -- btree

```
hash of the executable may vary

###Build and Run Hyper
```sh
cd $PRJHOME/benchmarks/hyper
./build.sh
cd target/release/deps
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./body-ecce9aa8ef6e888b --bench
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./connect-43bd2033fb0ad8f9 --bench
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./end_to_end-65c04f5871934fc8 --bench
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./pipeline-fc359c99b71e3a82 --bench
LD_PRELOAD=$PRJHOME/mpk-library/build/libmpk.so ./server-6050495059813025 --bench
```
hash of the executable may vary

###Build and Run Tokio
```sh
cd $PRJHOME/benchmarks/tokio
./build.sh
cd target/release/deps


```