fn main() {
    let p = 44 as *const i32;
    let x = unsafe { *p }; //~ ERROR inbounds test failed: 0x2c is not a valid pointer
    panic!("this should never print: {}", x);
}
