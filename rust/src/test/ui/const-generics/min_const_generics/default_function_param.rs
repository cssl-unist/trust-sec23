#![feature(min_const_generics)]

fn foo<const SIZE: usize = 5>() {}
                      //~^ ERROR expected one of `!`, `(`, `+`, `,`, `::`, `<`, or `>`, found `=`

fn main() {}
