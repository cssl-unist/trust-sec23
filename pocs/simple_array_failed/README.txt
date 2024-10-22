In this PoC, we showcase TRust detecting unsafe access to the safe region.
We craft a simple array whose pointer is sent to FFI as a value.
Sending the pointer to FFI as a value passes the SVF PTA, hence the array is not recognized as a unsafe.
Thus, instead of placing the array in the unsafe region, it is placed in the safe region.
As TRust disables access to the safe region when FFI is running, any writes to this pointer value from FFI causes SIGSEGV.
Please checkout the code in ffi/function.c.
Understand that not recognizing pointers casted as values is not a weakness of TRust, rather SVF.
We made this PoC just to show how TRust used MPK to catch unauthorized safe region access.
The counterpart of this example can be found in simple_array_passed.
Build the PoCs with:
./build.sh
Run them with LD_PRELOAD=/trust/mpk-library/build/libmpk.so:/trust/mpk-mimalloc/out/release/libmimalloc.so ./target/release/deps/simple_array-9ec182b7e50455c2

This should be the same as for the heap, if you can get past SVF analysis properly identifying safe and unsafe heap objects correctly.
