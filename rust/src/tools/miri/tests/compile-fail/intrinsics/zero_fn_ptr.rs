// error-pattern: the evaluated program aborted execution: attempted to zero-initialize type `fn()`, which is invalid

#[allow(deprecated, invalid_value)]
fn main() {
    unsafe { std::mem::zeroed::<fn()>() };
}
