// run-rustfix

#![allow(unused, clippy::needless_bool)]
#![allow(clippy::if_same_then_else, clippy::single_match)]
#![warn(clippy::needless_return)]

macro_rules! the_answer {
    () => {
        42
    };
}

fn test_end_of_fn() -> bool {
    if true {
        // no error!
        return true;
    }
    return true;
}

fn test_no_semicolon() -> bool {
    return true;
}

fn test_if_block() -> bool {
    if true {
        return true;
    } else {
        return false;
    }
}

fn test_match(x: bool) -> bool {
    match x {
        true => return false,
        false => {
            return true;
        },
    }
}

fn test_closure() {
    let _ = || {
        return true;
    };
    let _ = || return true;
}

fn test_macro_call() -> i32 {
    return the_answer!();
}

fn test_void_fun() {
    return;
}

fn test_void_if_fun(b: bool) {
    if b {
        return;
    } else {
        return;
    }
}

fn test_void_match(x: u32) {
    match x {
        0 => (),
        _ => return,
    }
}

fn read_line() -> String {
    use std::io::BufRead;
    let stdin = ::std::io::stdin();
    return stdin.lock().lines().next().unwrap().unwrap();
}

fn borrows_but_not_last(value: bool) -> String {
    if value {
        use std::io::BufRead;
        let stdin = ::std::io::stdin();
        let _a = stdin.lock().lines().next().unwrap().unwrap();
        return String::from("test");
    } else {
        return String::new();
    }
}

fn main() {
    let _ = test_end_of_fn();
    let _ = test_no_semicolon();
    let _ = test_if_block();
    let _ = test_match(true);
    test_closure();
}
