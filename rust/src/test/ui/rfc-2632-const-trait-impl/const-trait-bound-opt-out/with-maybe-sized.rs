#![feature(const_trait_bound_opt_out)]
#![allow(incomplete_features)]

struct S<T: ?const ?Sized>(std::marker::PhantomData<T>);
//~^ ERROR `?const` and `?` are mutually exclusive

fn main() {}
