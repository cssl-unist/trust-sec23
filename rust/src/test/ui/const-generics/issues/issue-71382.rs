// revisions: full min
#![cfg_attr(full, feature(const_generics))]
#![cfg_attr(full, allow(incomplete_features))]
#![cfg_attr(min, feature(min_const_generics))]

struct Test();

fn pass() {
    println!("Hello, world!");
}

impl Test {
    pub fn call_me(&self) {
        self.test::<pass>();
    }

    fn test<const FN: fn()>(&self) {
        //~^ ERROR: using function pointers as const generic parameters is forbidden
        FN();
    }
}

fn main() {
    let x = Test();
    x.call_me()
}
