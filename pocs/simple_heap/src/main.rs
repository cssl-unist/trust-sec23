#[link(name="ffi", kind="static")]
extern "C" {
    fn write_memory_ptr(mem_addr: *mut u64);
    fn write_memory_val(mem_addr: u64);
}

fn main() {
/*    let vec = vec![0,2,3,4];
    let ptr = vec.as_ptr() as *mut u64;
    unsafe {
        write_memory_ptr(ptr);
    }
    println!("Vec after: {:?}", vec);*/
    let array = vec![0,3,45];
    let safe_array = vec![1,5,8,9];
    let ptr = array.as_ptr() as *mut u64;
    unsafe {write_memory_ptr(ptr.offset(2));}
    println!("Array: {:?}", array);
    println!("Safe Array: {:?}", safe_array);
}
