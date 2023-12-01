#![warn(clippy::map_err_ignore)]
use std::convert::TryFrom;
use std::error::Error;
use std::fmt;

#[derive(Debug)]
enum Errors {
    Ignored,
}

impl Error for Errors {}

impl fmt::Display for Errors {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Error")
    }
}

fn main() -> Result<(), Errors> {
    let x = u32::try_from(-123_i32);

    println!("{:?}", x.map_err(|_| Errors::Ignored));

    Ok(())
}
