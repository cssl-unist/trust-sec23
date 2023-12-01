// check-pass
#![feature(lazy_normalization_consts)]
#![allow(incomplete_features)]

pub struct X<P, Q>(P, Q);
pub struct L<T: ?Sized>(T);

impl<T: ?Sized> L<T> {
    const S: usize = 1;
}

impl<T> X<T, [u8; L::<T>::S]> {}
//~^ WARN cannot use constants which depend on generic parameters
//~| WARN this was previously accepted by the compiler but is being phased out

fn main() {}
