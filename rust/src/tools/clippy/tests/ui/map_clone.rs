// run-rustfix
#![warn(clippy::all, clippy::pedantic)]
#![allow(clippy::iter_cloned_collect)]
#![allow(clippy::clone_on_copy, clippy::redundant_clone)]
#![allow(clippy::missing_docs_in_private_items)]
#![allow(clippy::redundant_closure_for_method_calls)]
#![allow(clippy::many_single_char_names)]

fn main() {
    let _: Vec<i8> = vec![5_i8; 6].iter().map(|x| *x).collect();
    let _: Vec<String> = vec![String::new()].iter().map(|x| x.clone()).collect();
    let _: Vec<u32> = vec![42, 43].iter().map(|&x| x).collect();
    let _: Option<u64> = Some(Box::new(16)).map(|b| *b);
    let _: Option<u64> = Some(&16).map(|b| *b);
    let _: Option<u8> = Some(&1).map(|x| x.clone());

    // Don't lint these
    let v = vec![5_i8; 6];
    let a = 0;
    let b = &a;
    let _ = v.iter().map(|_x| *b);
    let _ = v.iter().map(|_x| a.clone());
    let _ = v.iter().map(|&_x| a);

    // Issue #498
    let _ = std::env::args().map(|v| v.clone());

    // Issue #4824 item types that aren't references
    {
        use std::rc::Rc;

        let o: Option<Rc<u32>> = Some(Rc::new(0_u32));
        let _: Option<u32> = o.map(|x| *x);
        let v: Vec<Rc<u32>> = vec![Rc::new(0_u32)];
        let _: Vec<u32> = v.into_iter().map(|x| *x).collect();
    }

    // Issue #5524 mutable references
    {
        let mut c = 42;
        let v = vec![&mut c];
        let _: Vec<u32> = v.into_iter().map(|x| *x).collect();
        let mut d = 21;
        let v = vec![&mut d];
        let _: Vec<u32> = v.into_iter().map(|&mut x| x).collect();
    }
}
