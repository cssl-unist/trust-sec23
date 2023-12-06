// Copyright 2020 Parity Technologies
//
// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
// option. This file may not be copied, modified, or distributed
// except according to those terms.

//! Snappy compression bindings.
extern crate libc;
extern crate parity_snappy_sys;
#[cfg(test)]
extern crate rand;

use libc::{c_char, size_t};
use parity_snappy_sys as snappy;
use std::fmt;

/// Attempted to decompress an uncompressed buffer.
#[derive(Debug)]
pub struct InvalidInput;

impl std::error::Error for InvalidInput {
	fn description(&self) -> &str {
		"Attempted snappy decompression with invalid input"
	}
}

impl fmt::Display for InvalidInput {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		write!(f, "Attempted snappy decompression with invalid input")
	}
}

/// The maximum compressed length given a size.
pub fn max_compressed_len(len: usize) -> usize {
	unsafe { snappy::snappy_max_compressed_length(len as size_t) as usize }
}

/// How large the given data will be when decompressed.
pub fn decompressed_len(compressed: &[u8]) -> Result<usize, InvalidInput> {
	let mut size: size_t = 0;
	let len = compressed.len() as size_t;

	let status = unsafe {
		snappy::snappy_uncompressed_length(compressed.as_ptr() as *const c_char, len, &mut size)
	};

	if status == snappy::SNAPPY_INVALID_INPUT {
		Err(InvalidInput)
	} else {
		Ok(size)
	}
}

/// Compress a buffer using snappy.
pub fn compress(input: &[u8]) -> Vec<u8> {
	let mut buf = Vec::new();
	let size = compress_into(input, &mut buf);
	buf.truncate(size);
	buf
}

/// Compress a buffer using snappy, writing the result into
/// the given output buffer, growing it if necessary.
/// Otherwise, returns the length of the compressed data.
pub fn compress_into(input: &[u8], output: &mut Vec<u8>) -> usize {
	let mut len = max_compressed_len(input.len());

	if output.len() < len {
		output.resize(len, 0);
	}

	let status = unsafe {
		snappy::snappy_compress(
			input.as_ptr() as *const c_char,
			input.len() as size_t,
			output.as_mut_ptr() as *mut c_char,
			&mut len as &mut size_t,
		)
	};

	match status {
		snappy::SNAPPY_OK => len,
		snappy::SNAPPY_INVALID_INPUT => {
			panic!("snappy compression has no concept of invalid input")
		}
		snappy::SNAPPY_BUFFER_TOO_SMALL => {
			panic!("buffer cannot be too small, the capacity was just ensured.")
		}
		_ => panic!("snappy returned unspecified status"),
	}
}

/// Decompress a buffer using snappy. Will return an error if the buffer is not snappy-compressed.
pub fn decompress(input: &[u8]) -> Result<Vec<u8>, InvalidInput> {
	let mut v = Vec::new();
	decompress_into(input, &mut v).map(|_| v)
}

/// Decompress a buffer using snappy, writing the result into
/// the given output buffer, growing it if necessary.
/// Will error if the input buffer is not snappy-compressed.
/// Otherwise, returns the length of the decompressed data.
pub fn decompress_into(input: &[u8], output: &mut Vec<u8>) -> Result<usize, InvalidInput> {
	let mut len = decompressed_len(input)?;

	if output.len() < len {
		output.resize(len, 0);
	}

	let status = unsafe {
		snappy::snappy_uncompress(
			input.as_ptr() as *const c_char,
			input.len() as size_t,
			output.as_mut_ptr() as *mut c_char,
			&mut len as &mut size_t,
		)
	};

	match status {
		snappy::SNAPPY_OK => Ok(len as usize),
		snappy::SNAPPY_INVALID_INPUT => Err(InvalidInput),
		snappy::SNAPPY_BUFFER_TOO_SMALL => {
			panic!("buffer cannot be too small, size was just set to large enough.")
		}
		_ => panic!("snappy returned unspecified status"),
	}
}

/// Validate a compressed buffer. True if valid, false if not.
pub fn validate_compressed_buffer(input: &[u8]) -> bool {
	let status = unsafe {
		snappy::snappy_validate_compressed_buffer(
			input.as_ptr() as *const c_char,
			input.len() as size_t,
		)
	};
	status == snappy::SNAPPY_OK
}

#[cfg(test)]
mod tests {
	use super::*;
	use rand::prelude::*;

	const ITERATIONS: usize = 100;
	const INPUT_SIZE: usize = 1 << 18;

	#[test]
	fn it_works() {
		let mut rng = thread_rng();
		let mut input = [0u8; INPUT_SIZE];

		for _ in 0..ITERATIONS {
			rng.fill(&mut input[..]);

			let output = decompress(&compress(&input));

			match output {
				Err(err) => panic!("failed with error: {} for input: {:?}", err, input.to_vec()),
				Ok(output) => assert_eq!(input.to_vec(), output),
			}
		}
	}
}
