#![feature(const_trait_bound_opt_out)]
#![allow(incomplete_features)]

trait Super {}
trait T: ?const Super {}
//~^ ERROR `?const` is not permitted in supertraits

fn main() {}
