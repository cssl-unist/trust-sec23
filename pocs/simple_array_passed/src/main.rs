#[link(name="ffi", kind="static")]
extern "C" {
    fn write_memory_ptr(mem_addr: *mut u64);
    fn write_memory_val(mem_addr: u64);
}

fn main() {
    let vec = vec![0,2,3,4];
    let ptr = vec.as_ptr() as *mut u64;
    unsafe {
        write_memory_ptr(ptr);
    }
    println!("Vec after: {:?}", vec);
    let array = [0,3,45];
    let ptr = array.as_ptr() as *mut u64;
    unsafe {write_memory_ptr(ptr);}
    println!("Array: {:?}", array);
}
