static X: i32 = 1;
const C: i32 = 2;

const CR: &'static mut i32 = &mut C; //~ ERROR E0764
                                     //~| WARN taking a mutable
static STATIC_REF: &'static mut i32 = &mut X; //~ ERROR cannot borrow
                                              //~| ERROR E0764

static CONST_REF: &'static mut i32 = &mut C; //~ ERROR E0764
                                             //~| WARN taking a mutable

fn main() {}
