// run-rustfix
#![allow(clippy::assertions_on_constants)]

#[rustfmt::skip]
#[warn(clippy::collapsible_if)]
fn main() {
    let x = "hello";
    let y = "world";
    // Collapse `else { if .. }` to `else if ..`
    if x == "hello" {
        print!("Hello ");
    } else {
        if y == "world" {
            println!("world!")
        }
    }

    if x == "hello" {
        print!("Hello ");
    } else {
        if let Some(42) = Some(42) {
            println!("world!")
        }
    }

    if x == "hello" {
        print!("Hello ");
    } else {
        if y == "world" {
            println!("world")
        }
        else {
            println!("!")
        }
    }

    if x == "hello" {
        print!("Hello ");
    } else {
        if let Some(42) = Some(42) {
            println!("world")
        }
        else {
            println!("!")
        }
    }

    if let Some(42) = Some(42) {
        print!("Hello ");
    } else {
        if let Some(42) = Some(42) {
            println!("world")
        }
        else {
            println!("!")
        }
    }

    if let Some(42) = Some(42) {
        print!("Hello ");
    } else {
        if x == "hello" {
            println!("world")
        }
        else {
            println!("!")
        }
    }

    if let Some(42) = Some(42) {
        print!("Hello ");
    } else {
        if let Some(42) = Some(42) {
            println!("world")
        }
        else {
            println!("!")
        }
    }
}
