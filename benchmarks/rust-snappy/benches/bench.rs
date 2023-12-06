// Copyright 2020 Parity Technologies
//
// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
// option. This file may not be copied, modified, or distributed
// except according to those terms.

#![feature(test)]
extern crate test;

extern crate parity_snappy as snappy;
extern crate rand;


#[cfg(test)]
mod tests {
	use rand::prelude::*;
	use snappy;
	use test::Bencher;

	const INPUT_SIZE: usize = 1 << 24;

	#[bench]
	fn bench_compress_decompress(b: &mut Bencher) {
		let mut rng = StdRng::from_seed([0u8; 32]);
		let mut input = vec![0u8; INPUT_SIZE];
		rng.fill(&mut input[..]);
		let mut compressed = Vec::with_capacity(INPUT_SIZE);
		let mut decompressed = Vec::with_capacity(INPUT_SIZE);

		b.iter(|| {
            use std::time::Instant;
            let now = Instant::now();
			let size = snappy::compress_into(&input, &mut compressed);
            let compress_time = now.elapsed().as_nanos();
			let _ = snappy::decompress_into(&compressed[..size], &mut decompressed);
            let decompress_time = now.elapsed().as_nanos() - compress_time;
            println!("Compress time: {:.2?} Decompress time: {:.2?}", compress_time, decompress_time);

		});
	}
}
