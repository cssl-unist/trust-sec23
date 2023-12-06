// Copyright 2020 Parity Technologies
//
// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
// option. This file may not be copied, modified, or distributed
// except according to those terms.

//! Snappy compression bindings.
extern crate libc;

use libc::{c_char, c_int, size_t};

pub const SNAPPY_OK: c_int = 0;
pub const SNAPPY_INVALID_INPUT: c_int = 1;
pub const SNAPPY_BUFFER_TOO_SMALL: c_int = 2;

extern {
	pub fn snappy_compress(
		input: *const c_char,
		input_len: size_t,
		compressed: *mut c_char,
		compressed_len: *mut size_t
	) -> c_int;

	pub fn snappy_max_compressed_length(source_len: size_t) -> size_t;

	pub fn snappy_uncompress(
		compressed: *const c_char,
		compressed_len: size_t,
		uncompressed: *mut c_char,
		uncompressed_len: *mut size_t,
	) -> c_int;

	pub fn snappy_uncompressed_length(
		compressed: *const c_char,
		compressed_len: size_t,
		result: *mut size_t,
	) -> c_int;

	pub fn snappy_validate_compressed_buffer(
		compressed: *const c_char,
		compressed_len: size_t,
	) -> c_int;
}
