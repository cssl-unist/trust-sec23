// ignore-windows: No libc on Windows
// error-pattern: unsupported operation: the main thread terminated without waiting for other threads

// Check that we terminate the program when the main thread terminates.

#![feature(rustc_private)]

extern crate libc;

use std::{mem, ptr};

extern "C" fn thread_start(_null: *mut libc::c_void) -> *mut libc::c_void {
    ptr::null_mut()
}

fn main() {
    unsafe {
        let mut native: libc::pthread_t = mem::zeroed();
        let attr: libc::pthread_attr_t = mem::zeroed();
        // assert_eq!(libc::pthread_attr_init(&mut attr), 0); FIXME: this function is not yet implemented.
        assert_eq!(libc::pthread_create(&mut native, &attr, thread_start, ptr::null_mut()), 0);
    }
}
