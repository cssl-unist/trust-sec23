use expect_test::expect;

use super::{check_infer, check_types};

#[test]
fn infer_box() {
    check_types(
        r#"
//- /main.rs crate:main deps:std
fn test() {
    let x = box 1;
    let t = (x, box x, box &1, box [1]);
    t;
} //^ (Box<i32>, Box<Box<i32>>, Box<&i32>, Box<[i32; _]>)

//- /std.rs crate:std
#[prelude_import] use prelude::*;
mod prelude {}

mod boxed {
    #[lang = "owned_box"]
    pub struct Box<T: ?Sized> {
        inner: *mut T,
    }
}
"#,
    );
}

#[test]
fn infer_adt_self() {
    check_types(
        r#"
enum Nat { Succ(Self), Demo(Nat), Zero }

fn test() {
    let foo: Nat = Nat::Zero;
    if let Nat::Succ(x) = foo {
        x
    } //^ Nat
}
"#,
    );
}

#[test]
fn self_in_struct_lit() {
    check_infer(
        r#"
        //- /main.rs
        struct S<T> { x: T }

        impl S<u32> {
            fn foo() {
                Self { x: 1 };
            }
        }
        "#,
        expect![[r#"
            49..79 '{     ...     }': ()
            59..72 'Self { x: 1 }': S<u32>
            69..70 '1': u32
        "#]],
    );
}

#[test]
fn type_alias_in_struct_lit() {
    check_infer(
        r#"
        //- /main.rs
        struct S<T> { x: T }

        type SS = S<u32>;

        fn foo() {
            SS { x: 1 };
        }
        "#,
        expect![[r#"
            50..70 '{     ...1 }; }': ()
            56..67 'SS { x: 1 }': S<u32>
            64..65 '1': u32
        "#]],
    );
}

#[test]
fn infer_ranges() {
    check_types(
        r#"
//- /main.rs crate:main deps:core
fn test() {
    let a = ..;
    let b = 1..;
    let c = ..2u32;
    let d = 1..2usize;
    let e = ..=10;
    let f = 'a'..='z';

    let t = (a, b, c, d, e, f);
    t;
} //^ (RangeFull, RangeFrom<i32>, RangeTo<u32>, Range<usize>, RangeToInclusive<i32>, RangeInclusive<char>)

//- /core.rs crate:core
#[prelude_import] use prelude::*;
mod prelude {}

pub mod ops {
    pub struct Range<Idx> {
        pub start: Idx,
        pub end: Idx,
    }
    pub struct RangeFrom<Idx> {
        pub start: Idx,
    }
    struct RangeFull;
    pub struct RangeInclusive<Idx> {
        start: Idx,
        end: Idx,
        is_empty: u8,
    }
    pub struct RangeTo<Idx> {
        pub end: Idx,
    }
    pub struct RangeToInclusive<Idx> {
        pub end: Idx,
    }
}
"#,
    );
}

#[test]
fn infer_while_let() {
    check_types(
        r#"
enum Option<T> { Some(T), None }

fn test() {
    let foo: Option<f32> = None;
    while let Option::Some(x) = foo {
        x
    } //^ f32
}
"#,
    );
}

#[test]
fn infer_basics() {
    check_infer(
        r#"
        fn test(a: u32, b: isize, c: !, d: &str) {
            a;
            b;
            c;
            d;
            1usize;
            1isize;
            "test";
            1.0f32;
        }"#,
        expect![[r#"
            8..9 'a': u32
            16..17 'b': isize
            26..27 'c': !
            32..33 'd': &str
            41..120 '{     ...f32; }': ()
            47..48 'a': u32
            54..55 'b': isize
            61..62 'c': !
            68..69 'd': &str
            75..81 '1usize': usize
            87..93 '1isize': isize
            99..105 '"test"': &str
            111..117 '1.0f32': f32
        "#]],
    );
}

#[test]
fn infer_let() {
    check_infer(
        r#"
        fn test() {
            let a = 1isize;
            let b: usize = 1;
            let c = b;
            let d: u32;
            let e;
            let f: i32 = e;
        }
        "#,
        expect![[r#"
            10..117 '{     ...= e; }': ()
            20..21 'a': isize
            24..30 '1isize': isize
            40..41 'b': usize
            51..52 '1': usize
            62..63 'c': usize
            66..67 'b': usize
            77..78 'd': u32
            93..94 'e': i32
            104..105 'f': i32
            113..114 'e': i32
        "#]],
    );
}

#[test]
fn infer_paths() {
    check_infer(
        r#"
        fn a() -> u32 { 1 }

        mod b {
            fn c() -> u32 { 1 }
        }

        fn test() {
            a();
            b::c();
        }
        "#,
        expect![[r#"
            14..19 '{ 1 }': u32
            16..17 '1': u32
            47..52 '{ 1 }': u32
            49..50 '1': u32
            66..90 '{     ...c(); }': ()
            72..73 'a': fn a() -> u32
            72..75 'a()': u32
            81..85 'b::c': fn c() -> u32
            81..87 'b::c()': u32
        "#]],
    );
}

#[test]
fn infer_path_type() {
    check_infer(
        r#"
        struct S;

        impl S {
            fn foo() -> i32 { 1 }
        }

        fn test() {
            S::foo();
            <S>::foo();
        }
        "#,
        expect![[r#"
            40..45 '{ 1 }': i32
            42..43 '1': i32
            59..92 '{     ...o(); }': ()
            65..71 'S::foo': fn foo() -> i32
            65..73 'S::foo()': i32
            79..87 '<S>::foo': fn foo() -> i32
            79..89 '<S>::foo()': i32
        "#]],
    );
}

#[test]
fn infer_struct() {
    check_infer(
        r#"
        struct A {
            b: B,
            c: C,
        }
        struct B;
        struct C(usize);

        fn test() {
            let c = C(1);
            B;
            let a: A = A { b: B, c: C(1) };
            a.b;
            a.c;
        }
        "#,
        expect![[r#"
            71..153 '{     ...a.c; }': ()
            81..82 'c': C
            85..86 'C': C(usize) -> C
            85..89 'C(1)': C
            87..88 '1': usize
            95..96 'B': B
            106..107 'a': A
            113..132 'A { b:...C(1) }': A
            120..121 'B': B
            126..127 'C': C(usize) -> C
            126..130 'C(1)': C
            128..129 '1': usize
            138..139 'a': A
            138..141 'a.b': B
            147..148 'a': A
            147..150 'a.c': C
        "#]],
    );
}

#[test]
fn infer_enum() {
    check_infer(
        r#"
        enum E {
            V1 { field: u32 },
            V2
        }
        fn test() {
            E::V1 { field: 1 };
            E::V2;
        }"#,
        expect![[r#"
            51..89 '{     ...:V2; }': ()
            57..75 'E::V1 ...d: 1 }': E
            72..73 '1': u32
            81..86 'E::V2': E
        "#]],
    );
}

#[test]
fn infer_union() {
    check_infer(
        r#"
        union MyUnion {
            foo: u32,
            bar: f32,
        }

        fn test() {
            let u = MyUnion { foo: 0 };
            unsafe { baz(u); }
            let u = MyUnion { bar: 0.0 };
            unsafe { baz(u); }
        }

        unsafe fn baz(u: MyUnion) {
            let inner = u.foo;
            let inner = u.bar;
        }
        "#,
        expect![[r#"
            57..172 '{     ...); } }': ()
            67..68 'u': MyUnion
            71..89 'MyUnio...o: 0 }': MyUnion
            86..87 '0': u32
            95..113 'unsafe...(u); }': ()
            102..113 '{ baz(u); }': ()
            104..107 'baz': fn baz(MyUnion)
            104..110 'baz(u)': ()
            108..109 'u': MyUnion
            122..123 'u': MyUnion
            126..146 'MyUnio... 0.0 }': MyUnion
            141..144 '0.0': f32
            152..170 'unsafe...(u); }': ()
            159..170 '{ baz(u); }': ()
            161..164 'baz': fn baz(MyUnion)
            161..167 'baz(u)': ()
            165..166 'u': MyUnion
            188..189 'u': MyUnion
            200..249 '{     ...bar; }': ()
            210..215 'inner': u32
            218..219 'u': MyUnion
            218..223 'u.foo': u32
            233..238 'inner': f32
            241..242 'u': MyUnion
            241..246 'u.bar': f32
        "#]],
    );
}

#[test]
fn infer_refs() {
    check_infer(
        r#"
        fn test(a: &u32, b: &mut u32, c: *const u32, d: *mut u32) {
            a;
            *a;
            &a;
            &mut a;
            b;
            *b;
            &b;
            c;
            *c;
            d;
            *d;
        }
        "#,
        expect![[r#"
            8..9 'a': &u32
            17..18 'b': &mut u32
            30..31 'c': *const u32
            45..46 'd': *mut u32
            58..149 '{     ... *d; }': ()
            64..65 'a': &u32
            71..73 '*a': u32
            72..73 'a': &u32
            79..81 '&a': &&u32
            80..81 'a': &u32
            87..93 '&mut a': &mut &u32
            92..93 'a': &u32
            99..100 'b': &mut u32
            106..108 '*b': u32
            107..108 'b': &mut u32
            114..116 '&b': &&mut u32
            115..116 'b': &mut u32
            122..123 'c': *const u32
            129..131 '*c': u32
            130..131 'c': *const u32
            137..138 'd': *mut u32
            144..146 '*d': u32
            145..146 'd': *mut u32
        "#]],
    );
}

#[test]
fn infer_raw_ref() {
    check_infer(
        r#"
        fn test(a: i32) {
            &raw mut a;
            &raw const a;
        }
        "#,
        expect![[r#"
            8..9 'a': i32
            16..53 '{     ...t a; }': ()
            22..32 '&raw mut a': *mut i32
            31..32 'a': i32
            38..50 '&raw const a': *const i32
            49..50 'a': i32
        "#]],
    );
}

#[test]
fn infer_literals() {
    check_infer(
        r##"
        fn test() {
            5i32;
            5f32;
            5f64;
            "hello";
            b"bytes";
            'c';
            b'b';
            3.14;
            5000;
            false;
            true;
            r#"
                //! doc
                // non-doc
                mod foo {}
            "#;
            br#"yolo"#;
        }
        "##,
        expect![[r##"
            10..216 '{     ...o"#; }': ()
            16..20 '5i32': i32
            26..30 '5f32': f32
            36..40 '5f64': f64
            46..53 '"hello"': &str
            59..67 'b"bytes"': &[u8; _]
            73..76 ''c'': char
            82..86 'b'b'': u8
            92..96 '3.14': f64
            102..106 '5000': i32
            112..117 'false': bool
            123..127 'true': bool
            133..197 'r#"   ...    "#': &str
            203..213 'br#"yolo"#': &[u8; _]
        "##]],
    );
}

#[test]
fn infer_unary_op() {
    check_infer(
        r#"
        enum SomeType {}

        fn test(x: SomeType) {
            let b = false;
            let c = !b;
            let a = 100;
            let d: i128 = -a;
            let e = -100;
            let f = !!!true;
            let g = !42;
            let h = !10u32;
            let j = !a;
            -3.14;
            !3;
            -x;
            !x;
            -"hello";
            !"hello";
        }
        "#,
        expect![[r#"
            26..27 'x': SomeType
            39..271 '{     ...lo"; }': ()
            49..50 'b': bool
            53..58 'false': bool
            68..69 'c': bool
            72..74 '!b': bool
            73..74 'b': bool
            84..85 'a': i128
            88..91 '100': i128
            101..102 'd': i128
            111..113 '-a': i128
            112..113 'a': i128
            123..124 'e': i32
            127..131 '-100': i32
            128..131 '100': i32
            141..142 'f': bool
            145..152 '!!!true': bool
            146..152 '!!true': bool
            147..152 '!true': bool
            148..152 'true': bool
            162..163 'g': i32
            166..169 '!42': i32
            167..169 '42': i32
            179..180 'h': u32
            183..189 '!10u32': u32
            184..189 '10u32': u32
            199..200 'j': i128
            203..205 '!a': i128
            204..205 'a': i128
            211..216 '-3.14': f64
            212..216 '3.14': f64
            222..224 '!3': i32
            223..224 '3': i32
            230..232 '-x': {unknown}
            231..232 'x': SomeType
            238..240 '!x': {unknown}
            239..240 'x': SomeType
            246..254 '-"hello"': {unknown}
            247..254 '"hello"': &str
            260..268 '!"hello"': {unknown}
            261..268 '"hello"': &str
        "#]],
    );
}

#[test]
fn infer_backwards() {
    check_infer(
        r#"
        fn takes_u32(x: u32) {}

        struct S { i32_field: i32 }

        fn test() -> &mut &f64 {
            let a = unknown_function();
            takes_u32(a);
            let b = unknown_function();
            S { i32_field: b };
            let c = unknown_function();
            &mut &c
        }
        "#,
        expect![[r#"
            13..14 'x': u32
            21..23 '{}': ()
            77..230 '{     ...t &c }': &mut &f64
            87..88 'a': u32
            91..107 'unknow...nction': {unknown}
            91..109 'unknow...tion()': u32
            115..124 'takes_u32': fn takes_u32(u32)
            115..127 'takes_u32(a)': ()
            125..126 'a': u32
            137..138 'b': i32
            141..157 'unknow...nction': {unknown}
            141..159 'unknow...tion()': i32
            165..183 'S { i3...d: b }': S
            180..181 'b': i32
            193..194 'c': f64
            197..213 'unknow...nction': {unknown}
            197..215 'unknow...tion()': f64
            221..228 '&mut &c': &mut &f64
            226..228 '&c': &f64
            227..228 'c': f64
        "#]],
    );
}

#[test]
fn infer_self() {
    check_infer(
        r#"
        struct S;

        impl S {
            fn test(&self) {
                self;
            }
            fn test2(self: &Self) {
                self;
            }
            fn test3() -> Self {
                S {}
            }
            fn test4() -> Self {
                Self {}
            }
        }
        "#,
        expect![[r#"
            33..37 'self': &S
            39..60 '{     ...     }': ()
            49..53 'self': &S
            74..78 'self': &S
            87..108 '{     ...     }': ()
            97..101 'self': &S
            132..152 '{     ...     }': S
            142..146 'S {}': S
            176..199 '{     ...     }': S
            186..193 'Self {}': S
        "#]],
    );
}

#[test]
fn infer_self_as_path() {
    check_infer(
        r#"
        struct S1;
        struct S2(isize);
        enum E {
            V1,
            V2(u32),
        }

        impl S1 {
            fn test() {
                Self;
            }
        }
        impl S2 {
            fn test() {
                Self(1);
            }
        }
        impl E {
            fn test() {
                Self::V1;
                Self::V2(1);
            }
        }
        "#,
        expect![[r#"
            86..107 '{     ...     }': ()
            96..100 'Self': S1
            134..158 '{     ...     }': ()
            144..148 'Self': S2(isize) -> S2
            144..151 'Self(1)': S2
            149..150 '1': isize
            184..230 '{     ...     }': ()
            194..202 'Self::V1': E
            212..220 'Self::V2': V2(u32) -> E
            212..223 'Self::V2(1)': E
            221..222 '1': u32
        "#]],
    );
}

#[test]
fn infer_binary_op() {
    check_infer(
        r#"
        fn f(x: bool) -> i32 {
            0i32
        }

        fn test() -> bool {
            let x = a && b;
            let y = true || false;
            let z = x == y;
            let t = x != y;
            let minus_forty: isize = -40isize;
            let h = minus_forty <= CONST_2;
            let c = f(z || y) + 5;
            let d = b;
            let g = minus_forty ^= i;
            let ten: usize = 10;
            let ten_is_eleven = ten == some_num;

            ten < 3
        }
        "#,
        expect![[r#"
            5..6 'x': bool
            21..33 '{     0i32 }': i32
            27..31 '0i32': i32
            53..369 '{     ... < 3 }': bool
            63..64 'x': bool
            67..68 'a': bool
            67..73 'a && b': bool
            72..73 'b': bool
            83..84 'y': bool
            87..91 'true': bool
            87..100 'true || false': bool
            95..100 'false': bool
            110..111 'z': bool
            114..115 'x': bool
            114..120 'x == y': bool
            119..120 'y': bool
            130..131 't': bool
            134..135 'x': bool
            134..140 'x != y': bool
            139..140 'y': bool
            150..161 'minus_forty': isize
            171..179 '-40isize': isize
            172..179 '40isize': isize
            189..190 'h': bool
            193..204 'minus_forty': isize
            193..215 'minus_...ONST_2': bool
            208..215 'CONST_2': isize
            225..226 'c': i32
            229..230 'f': fn f(bool) -> i32
            229..238 'f(z || y)': i32
            229..242 'f(z || y) + 5': i32
            231..232 'z': bool
            231..237 'z || y': bool
            236..237 'y': bool
            241..242 '5': i32
            252..253 'd': {unknown}
            256..257 'b': {unknown}
            267..268 'g': ()
            271..282 'minus_forty': isize
            271..287 'minus_...y ^= i': ()
            286..287 'i': isize
            297..300 'ten': usize
            310..312 '10': usize
            322..335 'ten_is_eleven': bool
            338..341 'ten': usize
            338..353 'ten == some_num': bool
            345..353 'some_num': usize
            360..363 'ten': usize
            360..367 'ten < 3': bool
            366..367 '3': usize
        "#]],
    );
}

#[test]
fn infer_shift_op() {
    check_infer(
        r#"
        fn test() {
            1u32 << 5u8;
            1u32 >> 5u8;
        }
        "#,
        expect![[r#"
            10..47 '{     ...5u8; }': ()
            16..20 '1u32': u32
            16..27 '1u32 << 5u8': u32
            24..27 '5u8': u8
            33..37 '1u32': u32
            33..44 '1u32 >> 5u8': u32
            41..44 '5u8': u8
        "#]],
    );
}

#[test]
fn infer_field_autoderef() {
    check_infer(
        r#"
        struct A {
            b: B,
        }
        struct B;

        fn test1(a: A) {
            let a1 = a;
            a1.b;
            let a2 = &a;
            a2.b;
            let a3 = &mut a;
            a3.b;
            let a4 = &&&&&&&a;
            a4.b;
            let a5 = &mut &&mut &&mut a;
            a5.b;
        }

        fn test2(a1: *const A, a2: *mut A) {
            a1.b;
            a2.b;
        }
        "#,
        expect![[r#"
            43..44 'a': A
            49..212 '{     ...5.b; }': ()
            59..61 'a1': A
            64..65 'a': A
            71..73 'a1': A
            71..75 'a1.b': B
            85..87 'a2': &A
            90..92 '&a': &A
            91..92 'a': A
            98..100 'a2': &A
            98..102 'a2.b': B
            112..114 'a3': &mut A
            117..123 '&mut a': &mut A
            122..123 'a': A
            129..131 'a3': &mut A
            129..133 'a3.b': B
            143..145 'a4': &&&&&&&A
            148..156 '&&&&&&&a': &&&&&&&A
            149..156 '&&&&&&a': &&&&&&A
            150..156 '&&&&&a': &&&&&A
            151..156 '&&&&a': &&&&A
            152..156 '&&&a': &&&A
            153..156 '&&a': &&A
            154..156 '&a': &A
            155..156 'a': A
            162..164 'a4': &&&&&&&A
            162..166 'a4.b': B
            176..178 'a5': &mut &&mut &&mut A
            181..199 '&mut &...&mut a': &mut &&mut &&mut A
            186..199 '&&mut &&mut a': &&mut &&mut A
            187..199 '&mut &&mut a': &mut &&mut A
            192..199 '&&mut a': &&mut A
            193..199 '&mut a': &mut A
            198..199 'a': A
            205..207 'a5': &mut &&mut &&mut A
            205..209 'a5.b': B
            223..225 'a1': *const A
            237..239 'a2': *mut A
            249..272 '{     ...2.b; }': ()
            255..257 'a1': *const A
            255..259 'a1.b': B
            265..267 'a2': *mut A
            265..269 'a2.b': B
        "#]],
    );
}

#[test]
fn infer_argument_autoderef() {
    check_infer(
        r#"
        #[lang = "deref"]
        pub trait Deref {
            type Target;
            fn deref(&self) -> &Self::Target;
        }

        struct A<T>(T);

        impl<T> A<T> {
            fn foo(&self) -> &T {
                &self.0
            }
        }

        struct B<T>(T);

        impl<T> Deref for B<T> {
            type Target = T;
            fn deref(&self) -> &Self::Target {
                &self.0
            }
        }

        fn test() {
            let t = A::foo(&&B(B(A(42))));
        }
        "#,
        expect![[r#"
            67..71 'self': &Self
            138..142 'self': &A<T>
            150..173 '{     ...     }': &T
            160..167 '&self.0': &T
            161..165 'self': &A<T>
            161..167 'self.0': T
            254..258 'self': &B<T>
            277..300 '{     ...     }': &T
            287..294 '&self.0': &T
            288..292 'self': &B<T>
            288..294 'self.0': T
            314..352 '{     ...))); }': ()
            324..325 't': &i32
            328..334 'A::foo': fn foo<i32>(&A<i32>) -> &i32
            328..349 'A::foo...42))))': &i32
            335..348 '&&B(B(A(42)))': &&B<B<A<i32>>>
            336..348 '&B(B(A(42)))': &B<B<A<i32>>>
            337..338 'B': B<B<A<i32>>>(B<A<i32>>) -> B<B<A<i32>>>
            337..348 'B(B(A(42)))': B<B<A<i32>>>
            339..340 'B': B<A<i32>>(A<i32>) -> B<A<i32>>
            339..347 'B(A(42))': B<A<i32>>
            341..342 'A': A<i32>(i32) -> A<i32>
            341..346 'A(42)': A<i32>
            343..345 '42': i32
        "#]],
    );
}

#[test]
fn infer_method_argument_autoderef() {
    check_infer(
        r#"
        #[lang = "deref"]
        pub trait Deref {
            type Target;
            fn deref(&self) -> &Self::Target;
        }

        struct A<T>(*mut T);

        impl<T> A<T> {
            fn foo(&self, x: &A<T>) -> &T {
                &*x.0
            }
        }

        struct B<T>(T);

        impl<T> Deref for B<T> {
            type Target = T;
            fn deref(&self) -> &Self::Target {
                &self.0
            }
        }

        fn test(a: A<i32>) {
            let t = A(0 as *mut _).foo(&&B(B(a)));
        }
        "#,
        expect![[r#"
            67..71 'self': &Self
            143..147 'self': &A<T>
            149..150 'x': &A<T>
            165..186 '{     ...     }': &T
            175..180 '&*x.0': &T
            176..180 '*x.0': T
            177..178 'x': &A<T>
            177..180 'x.0': *mut T
            267..271 'self': &B<T>
            290..313 '{     ...     }': &T
            300..307 '&self.0': &T
            301..305 'self': &B<T>
            301..307 'self.0': T
            325..326 'a': A<i32>
            336..382 '{     ...))); }': ()
            346..347 't': &i32
            350..351 'A': A<i32>(*mut i32) -> A<i32>
            350..364 'A(0 as *mut _)': A<i32>
            350..379 'A(0 as...B(a)))': &i32
            352..353 '0': i32
            352..363 '0 as *mut _': *mut i32
            369..378 '&&B(B(a))': &&B<B<A<i32>>>
            370..378 '&B(B(a))': &B<B<A<i32>>>
            371..372 'B': B<B<A<i32>>>(B<A<i32>>) -> B<B<A<i32>>>
            371..378 'B(B(a))': B<B<A<i32>>>
            373..374 'B': B<A<i32>>(A<i32>) -> B<A<i32>>
            373..377 'B(a)': B<A<i32>>
            375..376 'a': A<i32>
        "#]],
    );
}

#[test]
fn infer_in_elseif() {
    check_infer(
        r#"
        struct Foo { field: i32 }
        fn main(foo: Foo) {
            if true {

            } else if false {
                foo.field
            }
        }
        "#,
        expect![[r#"
            34..37 'foo': Foo
            44..108 '{     ...   } }': ()
            50..106 'if tru...     }': ()
            53..57 'true': bool
            58..66 '{      }': ()
            72..106 'if fal...     }': i32
            75..80 'false': bool
            81..106 '{     ...     }': i32
            91..94 'foo': Foo
            91..100 'foo.field': i32
        "#]],
    )
}

#[test]
fn infer_if_match_with_return() {
    check_infer(
        r#"
        fn foo() {
            let _x1 = if true {
                1
            } else {
                return;
            };
            let _x2 = if true {
                2
            } else {
                return
            };
            let _x3 = match true {
                true => 3,
                _ => {
                    return;
                }
            };
            let _x4 = match true {
                true => 4,
                _ => return
            };
        }"#,
        expect![[r#"
            9..322 '{     ...  }; }': ()
            19..22 '_x1': i32
            25..79 'if tru...     }': i32
            28..32 'true': bool
            33..50 '{     ...     }': i32
            43..44 '1': i32
            56..79 '{     ...     }': i32
            66..72 'return': !
            89..92 '_x2': i32
            95..148 'if tru...     }': i32
            98..102 'true': bool
            103..120 '{     ...     }': i32
            113..114 '2': i32
            126..148 '{     ...     }': !
            136..142 'return': !
            158..161 '_x3': i32
            164..246 'match ...     }': i32
            170..174 'true': bool
            185..189 'true': bool
            185..189 'true': bool
            193..194 '3': i32
            204..205 '_': bool
            209..240 '{     ...     }': i32
            223..229 'return': !
            256..259 '_x4': i32
            262..319 'match ...     }': i32
            268..272 'true': bool
            283..287 'true': bool
            283..287 'true': bool
            291..292 '4': i32
            302..303 '_': bool
            307..313 'return': !
        "#]],
    )
}

#[test]
fn infer_inherent_method() {
    check_infer(
        r#"
        struct A;

        impl A {
            fn foo(self, x: u32) -> i32 {}
        }

        mod b {
            impl super::A {
                fn bar(&self, x: u64) -> i64 {}
            }
        }

        fn test(a: A) {
            a.foo(1);
            (&a).bar(1);
            a.bar(1);
        }
        "#,
        expect![[r#"
            31..35 'self': A
            37..38 'x': u32
            52..54 '{}': ()
            102..106 'self': &A
            108..109 'x': u64
            123..125 '{}': ()
            143..144 'a': A
            149..197 '{     ...(1); }': ()
            155..156 'a': A
            155..163 'a.foo(1)': i32
            161..162 '1': u32
            169..180 '(&a).bar(1)': i64
            170..172 '&a': &A
            171..172 'a': A
            178..179 '1': u64
            186..187 'a': A
            186..194 'a.bar(1)': i64
            192..193 '1': u64
        "#]],
    );
}

#[test]
fn infer_inherent_method_str() {
    check_infer(
        r#"
        #[lang = "str"]
        impl str {
            fn foo(&self) -> i32 {}
        }

        fn test() {
            "foo".foo();
        }
        "#,
        expect![[r#"
            39..43 'self': &str
            52..54 '{}': ()
            68..88 '{     ...o(); }': ()
            74..79 '"foo"': &str
            74..85 '"foo".foo()': i32
        "#]],
    );
}

#[test]
fn infer_tuple() {
    check_infer(
        r#"
        fn test(x: &str, y: isize) {
            let a: (u32, &str) = (1, "a");
            let b = (a, x);
            let c = (y, x);
            let d = (c, x);
            let e = (1, "e");
            let f = (e, "d");
        }
        "#,
        expect![[r#"
            8..9 'x': &str
            17..18 'y': isize
            27..169 '{     ...d"); }': ()
            37..38 'a': (u32, &str)
            54..62 '(1, "a")': (u32, &str)
            55..56 '1': u32
            58..61 '"a"': &str
            72..73 'b': ((u32, &str), &str)
            76..82 '(a, x)': ((u32, &str), &str)
            77..78 'a': (u32, &str)
            80..81 'x': &str
            92..93 'c': (isize, &str)
            96..102 '(y, x)': (isize, &str)
            97..98 'y': isize
            100..101 'x': &str
            112..113 'd': ((isize, &str), &str)
            116..122 '(c, x)': ((isize, &str), &str)
            117..118 'c': (isize, &str)
            120..121 'x': &str
            132..133 'e': (i32, &str)
            136..144 '(1, "e")': (i32, &str)
            137..138 '1': i32
            140..143 '"e"': &str
            154..155 'f': ((i32, &str), &str)
            158..166 '(e, "d")': ((i32, &str), &str)
            159..160 'e': (i32, &str)
            162..165 '"d"': &str
        "#]],
    );
}

#[test]
fn infer_array() {
    check_infer(
        r#"
        fn test(x: &str, y: isize) {
            let a = [x];
            let b = [a, a];
            let c = [b, b];

            let d = [y, 1, 2, 3];
            let d = [1, y, 2, 3];
            let e = [y];
            let f = [d, d];
            let g = [e, e];

            let h = [1, 2];
            let i = ["a", "b"];

            let b = [a, ["b"]];
            let x: [u8; 0] = [];
        }
        "#,
        expect![[r#"
            8..9 'x': &str
            17..18 'y': isize
            27..292 '{     ... []; }': ()
            37..38 'a': [&str; _]
            41..44 '[x]': [&str; _]
            42..43 'x': &str
            54..55 'b': [[&str; _]; _]
            58..64 '[a, a]': [[&str; _]; _]
            59..60 'a': [&str; _]
            62..63 'a': [&str; _]
            74..75 'c': [[[&str; _]; _]; _]
            78..84 '[b, b]': [[[&str; _]; _]; _]
            79..80 'b': [[&str; _]; _]
            82..83 'b': [[&str; _]; _]
            95..96 'd': [isize; _]
            99..111 '[y, 1, 2, 3]': [isize; _]
            100..101 'y': isize
            103..104 '1': isize
            106..107 '2': isize
            109..110 '3': isize
            121..122 'd': [isize; _]
            125..137 '[1, y, 2, 3]': [isize; _]
            126..127 '1': isize
            129..130 'y': isize
            132..133 '2': isize
            135..136 '3': isize
            147..148 'e': [isize; _]
            151..154 '[y]': [isize; _]
            152..153 'y': isize
            164..165 'f': [[isize; _]; _]
            168..174 '[d, d]': [[isize; _]; _]
            169..170 'd': [isize; _]
            172..173 'd': [isize; _]
            184..185 'g': [[isize; _]; _]
            188..194 '[e, e]': [[isize; _]; _]
            189..190 'e': [isize; _]
            192..193 'e': [isize; _]
            205..206 'h': [i32; _]
            209..215 '[1, 2]': [i32; _]
            210..211 '1': i32
            213..214 '2': i32
            225..226 'i': [&str; _]
            229..239 '["a", "b"]': [&str; _]
            230..233 '"a"': &str
            235..238 '"b"': &str
            250..251 'b': [[&str; _]; _]
            254..264 '[a, ["b"]]': [[&str; _]; _]
            255..256 'a': [&str; _]
            258..263 '["b"]': [&str; _]
            259..262 '"b"': &str
            274..275 'x': [u8; _]
            287..289 '[]': [u8; _]
        "#]],
    );
}

#[test]
fn infer_struct_generics() {
    check_infer(
        r#"
        struct A<T> {
            x: T,
        }

        fn test(a1: A<u32>, i: i32) {
            a1.x;
            let a2 = A { x: i };
            a2.x;
            let a3 = A::<i128> { x: 1 };
            a3.x;
        }
        "#,
        expect![[r#"
            35..37 'a1': A<u32>
            47..48 'i': i32
            55..146 '{     ...3.x; }': ()
            61..63 'a1': A<u32>
            61..65 'a1.x': u32
            75..77 'a2': A<i32>
            80..90 'A { x: i }': A<i32>
            87..88 'i': i32
            96..98 'a2': A<i32>
            96..100 'a2.x': i32
            110..112 'a3': A<i128>
            115..133 'A::<i1...x: 1 }': A<i128>
            130..131 '1': i128
            139..141 'a3': A<i128>
            139..143 'a3.x': i128
        "#]],
    );
}

#[test]
fn infer_tuple_struct_generics() {
    check_infer(
        r#"
        struct A<T>(T);
        enum Option<T> { Some(T), None }
        use Option::*;

        fn test() {
            A(42);
            A(42u128);
            Some("x");
            Option::Some("x");
            None;
            let x: Option<i64> = None;
        }
        "#,
        expect![[r#"
            75..183 '{     ...one; }': ()
            81..82 'A': A<i32>(i32) -> A<i32>
            81..86 'A(42)': A<i32>
            83..85 '42': i32
            92..93 'A': A<u128>(u128) -> A<u128>
            92..101 'A(42u128)': A<u128>
            94..100 '42u128': u128
            107..111 'Some': Some<&str>(&str) -> Option<&str>
            107..116 'Some("x")': Option<&str>
            112..115 '"x"': &str
            122..134 'Option::Some': Some<&str>(&str) -> Option<&str>
            122..139 'Option...e("x")': Option<&str>
            135..138 '"x"': &str
            145..149 'None': Option<{unknown}>
            159..160 'x': Option<i64>
            176..180 'None': Option<i64>
        "#]],
    );
}

#[test]
fn infer_function_generics() {
    check_infer(
        r#"
        fn id<T>(t: T) -> T { t }

        fn test() {
            id(1u32);
            id::<i128>(1);
            let x: u64 = id(1);
        }
        "#,
        expect![[r#"
            9..10 't': T
            20..25 '{ t }': T
            22..23 't': T
            37..97 '{     ...(1); }': ()
            43..45 'id': fn id<u32>(u32) -> u32
            43..51 'id(1u32)': u32
            46..50 '1u32': u32
            57..67 'id::<i128>': fn id<i128>(i128) -> i128
            57..70 'id::<i128>(1)': i128
            68..69 '1': i128
            80..81 'x': u64
            89..91 'id': fn id<u64>(u64) -> u64
            89..94 'id(1)': u64
            92..93 '1': u64
        "#]],
    );
}

#[test]
fn infer_impl_generics_basic() {
    check_infer(
        r#"
        struct A<T1, T2> {
            x: T1,
            y: T2,
        }
        impl<Y, X> A<X, Y> {
            fn x(self) -> X {
                self.x
            }
            fn y(self) -> Y {
                self.y
            }
            fn z<T>(self, t: T) -> (X, Y, T) {
                (self.x, self.y, t)
            }
        }

        fn test() -> i128 {
            let a = A { x: 1u64, y: 1i64 };
            a.x();
            a.y();
            a.z(1i128);
            a.z::<u128>(1);
        }
        "#,
        expect![[r#"
            73..77 'self': A<X, Y>
            84..106 '{     ...     }': X
            94..98 'self': A<X, Y>
            94..100 'self.x': X
            116..120 'self': A<X, Y>
            127..149 '{     ...     }': Y
            137..141 'self': A<X, Y>
            137..143 'self.y': Y
            162..166 'self': A<X, Y>
            168..169 't': T
            187..222 '{     ...     }': (X, Y, T)
            197..216 '(self.....y, t)': (X, Y, T)
            198..202 'self': A<X, Y>
            198..204 'self.x': X
            206..210 'self': A<X, Y>
            206..212 'self.y': Y
            214..215 't': T
            244..341 '{     ...(1); }': ()
            254..255 'a': A<u64, i64>
            258..280 'A { x:...1i64 }': A<u64, i64>
            265..269 '1u64': u64
            274..278 '1i64': i64
            286..287 'a': A<u64, i64>
            286..291 'a.x()': u64
            297..298 'a': A<u64, i64>
            297..302 'a.y()': i64
            308..309 'a': A<u64, i64>
            308..318 'a.z(1i128)': (u64, i64, i128)
            312..317 '1i128': i128
            324..325 'a': A<u64, i64>
            324..338 'a.z::<u128>(1)': (u64, i64, u128)
            336..337 '1': u128
        "#]],
    );
}

#[test]
fn infer_impl_generics_with_autoderef() {
    check_infer(
        r#"
        enum Option<T> {
            Some(T),
            None,
        }
        impl<T> Option<T> {
            fn as_ref(&self) -> Option<&T> {}
        }
        fn test(o: Option<u32>) {
            (&o).as_ref();
            o.as_ref();
        }
        "#,
        expect![[r#"
            77..81 'self': &Option<T>
            97..99 '{}': ()
            110..111 'o': Option<u32>
            126..164 '{     ...f(); }': ()
            132..145 '(&o).as_ref()': Option<&u32>
            133..135 '&o': &Option<u32>
            134..135 'o': Option<u32>
            151..152 'o': Option<u32>
            151..161 'o.as_ref()': Option<&u32>
        "#]],
    );
}

#[test]
fn infer_generic_chain() {
    check_infer(
        r#"
        struct A<T> {
            x: T,
        }
        impl<T2> A<T2> {
            fn x(self) -> T2 {
                self.x
            }
        }
        fn id<T>(t: T) -> T { t }

        fn test() -> i128 {
            let x = 1;
            let y = id(x);
            let a = A { x: id(y) };
            let z = id(a.x);
            let b = A { x: z };
            b.x()
        }
        "#,
        expect![[r#"
            52..56 'self': A<T2>
            64..86 '{     ...     }': T2
            74..78 'self': A<T2>
            74..80 'self.x': T2
            98..99 't': T
            109..114 '{ t }': T
            111..112 't': T
            134..254 '{     ....x() }': i128
            144..145 'x': i128
            148..149 '1': i128
            159..160 'y': i128
            163..165 'id': fn id<i128>(i128) -> i128
            163..168 'id(x)': i128
            166..167 'x': i128
            178..179 'a': A<i128>
            182..196 'A { x: id(y) }': A<i128>
            189..191 'id': fn id<i128>(i128) -> i128
            189..194 'id(y)': i128
            192..193 'y': i128
            206..207 'z': i128
            210..212 'id': fn id<i128>(i128) -> i128
            210..217 'id(a.x)': i128
            213..214 'a': A<i128>
            213..216 'a.x': i128
            227..228 'b': A<i128>
            231..241 'A { x: z }': A<i128>
            238..239 'z': i128
            247..248 'b': A<i128>
            247..252 'b.x()': i128
        "#]],
    );
}

#[test]
fn infer_associated_const() {
    check_infer(
        r#"
        struct Struct;

        impl Struct {
            const FOO: u32 = 1;
        }

        enum Enum {}

        impl Enum {
            const BAR: u32 = 2;
        }

        trait Trait {
            const ID: u32;
        }

        struct TraitTest;

        impl Trait for TraitTest {
            const ID: u32 = 5;
        }

        fn test() {
            let x = Struct::FOO;
            let y = Enum::BAR;
            let z = TraitTest::ID;
        }
        "#,
        expect![[r#"
            51..52 '1': u32
            104..105 '2': u32
            212..213 '5': u32
            228..306 '{     ...:ID; }': ()
            238..239 'x': u32
            242..253 'Struct::FOO': u32
            263..264 'y': u32
            267..276 'Enum::BAR': u32
            286..287 'z': u32
            290..303 'TraitTest::ID': u32
        "#]],
    );
}

#[test]
fn infer_type_alias() {
    check_infer(
        r#"
        struct A<X, Y> { x: X, y: Y }
        type Foo = A<u32, i128>;
        type Bar<T> = A<T, u128>;
        type Baz<U, V> = A<V, U>;
        fn test(x: Foo, y: Bar<&str>, z: Baz<i8, u8>) {
            x.x;
            x.y;
            y.x;
            y.y;
            z.x;
            z.y;
        }
        "#,
        expect![[r#"
            115..116 'x': A<u32, i128>
            123..124 'y': A<&str, u128>
            137..138 'z': A<u8, i8>
            153..210 '{     ...z.y; }': ()
            159..160 'x': A<u32, i128>
            159..162 'x.x': u32
            168..169 'x': A<u32, i128>
            168..171 'x.y': i128
            177..178 'y': A<&str, u128>
            177..180 'y.x': &str
            186..187 'y': A<&str, u128>
            186..189 'y.y': u128
            195..196 'z': A<u8, i8>
            195..198 'z.x': u8
            204..205 'z': A<u8, i8>
            204..207 'z.y': i8
        "#]],
    )
}

#[test]
fn recursive_type_alias() {
    check_infer(
        r#"
        struct A<X> {}
        type Foo = Foo;
        type Bar = A<Bar>;
        fn test(x: Foo) {}
        "#,
        expect![[r#"
            58..59 'x': {unknown}
            66..68 '{}': ()
        "#]],
    )
}

#[test]
fn infer_type_param() {
    check_infer(
        r#"
        fn id<T>(x: T) -> T {
            x
        }

        fn clone<T>(x: &T) -> T {
            *x
        }

        fn test() {
            let y = 10u32;
            id(y);
            let x: bool = clone(z);
            id::<i128>(1);
        }
        "#,
        expect![[r#"
            9..10 'x': T
            20..29 '{     x }': T
            26..27 'x': T
            43..44 'x': &T
            55..65 '{     *x }': T
            61..63 '*x': T
            62..63 'x': &T
            77..157 '{     ...(1); }': ()
            87..88 'y': u32
            91..96 '10u32': u32
            102..104 'id': fn id<u32>(u32) -> u32
            102..107 'id(y)': u32
            105..106 'y': u32
            117..118 'x': bool
            127..132 'clone': fn clone<bool>(&bool) -> bool
            127..135 'clone(z)': bool
            133..134 'z': &bool
            141..151 'id::<i128>': fn id<i128>(i128) -> i128
            141..154 'id::<i128>(1)': i128
            152..153 '1': i128
        "#]],
    );
}

#[test]
fn infer_const() {
    check_infer(
        r#"
        struct Foo;
        impl Foo { const ASSOC_CONST: u32 = 0; }
        const GLOBAL_CONST: u32 = 101;
        fn test() {
            const LOCAL_CONST: u32 = 99;
            let x = LOCAL_CONST;
            let z = GLOBAL_CONST;
            let id = Foo::ASSOC_CONST;
        }
        "#,
        expect![[r#"
            48..49 '0': u32
            79..82 '101': u32
            94..212 '{     ...NST; }': ()
            137..138 'x': u32
            141..152 'LOCAL_CONST': u32
            162..163 'z': u32
            166..178 'GLOBAL_CONST': u32
            188..190 'id': u32
            193..209 'Foo::A..._CONST': u32
            125..127 '99': u32
        "#]],
    );
}

#[test]
fn infer_static() {
    check_infer(
        r#"
        static GLOBAL_STATIC: u32 = 101;
        static mut GLOBAL_STATIC_MUT: u32 = 101;
        fn test() {
            static LOCAL_STATIC: u32 = 99;
            static mut LOCAL_STATIC_MUT: u32 = 99;
            let x = LOCAL_STATIC;
            let y = LOCAL_STATIC_MUT;
            let z = GLOBAL_STATIC;
            let w = GLOBAL_STATIC_MUT;
        }
        "#,
        expect![[r#"
            28..31 '101': u32
            69..72 '101': u32
            84..279 '{     ...MUT; }': ()
            172..173 'x': u32
            176..188 'LOCAL_STATIC': u32
            198..199 'y': u32
            202..218 'LOCAL_...IC_MUT': u32
            228..229 'z': u32
            232..245 'GLOBAL_STATIC': u32
            255..256 'w': u32
            259..276 'GLOBAL...IC_MUT': u32
            117..119 '99': u32
            160..162 '99': u32
        "#]],
    );
}

#[test]
fn shadowing_primitive() {
    check_types(
        r#"
struct i32;
struct Foo;

impl i32 { fn foo(&self) -> Foo { Foo } }

fn main() {
    let x: i32 = i32;
    x.foo();
        //^ Foo
}"#,
    );
}

#[test]
fn not_shadowing_primitive_by_module() {
    check_types(
        r#"
//- /str.rs
fn foo() {}

//- /main.rs
mod str;
fn foo() -> &'static str { "" }

fn main() {
    foo();
      //^ &str
}"#,
    );
}

#[test]
fn not_shadowing_module_by_primitive() {
    check_types(
        r#"
//- /str.rs
fn foo() -> u32 {0}

//- /main.rs
mod str;
fn foo() -> &'static str { "" }

fn main() {
    str::foo();
           //^ u32
}"#,
    );
}

// This test is actually testing the shadowing behavior within hir_def. It
// lives here because the testing infrastructure in hir_def isn't currently
// capable of asserting the necessary conditions.
#[test]
fn should_be_shadowing_imports() {
    check_types(
        r#"
mod a {
    pub fn foo() -> i8 {0}
    pub struct foo { a: i8 }
}
mod b { pub fn foo () -> u8 {0} }
mod c { pub struct foo { a: u8 } }
mod d {
    pub use super::a::*;
    pub use super::c::foo;
    pub use super::b::foo;
}

fn main() {
    d::foo();
         //^ u8
    d::foo{a:0};
           //^ u8
}"#,
    );
}

#[test]
fn closure_return() {
    check_infer(
        r#"
        fn foo() -> u32 {
            let x = || -> usize { return 1; };
        }
        "#,
        expect![[r#"
            16..58 '{     ...; }; }': ()
            26..27 'x': || -> usize
            30..55 '|| -> ...n 1; }': || -> usize
            42..55 '{ return 1; }': usize
            44..52 'return 1': !
            51..52 '1': usize
        "#]],
    );
}

#[test]
fn closure_return_unit() {
    check_infer(
        r#"
        fn foo() -> u32 {
            let x = || { return; };
        }
        "#,
        expect![[r#"
            16..47 '{     ...; }; }': ()
            26..27 'x': || -> ()
            30..44 '|| { return; }': || -> ()
            33..44 '{ return; }': ()
            35..41 'return': !
        "#]],
    );
}

#[test]
fn closure_return_inferred() {
    check_infer(
        r#"
        fn foo() -> u32 {
            let x = || { "test" };
        }
        "#,
        expect![[r#"
            16..46 '{     ..." }; }': ()
            26..27 'x': || -> &str
            30..43 '|| { "test" }': || -> &str
            33..43 '{ "test" }': &str
            35..41 '"test"': &str
        "#]],
    );
}

#[test]
fn fn_pointer_return() {
    check_infer(
        r#"
        struct Vtable {
            method: fn(),
        }

        fn main() {
            let vtable = Vtable { method: || {} };
            let m = vtable.method;
        }
        "#,
        expect![[r#"
            47..120 '{     ...hod; }': ()
            57..63 'vtable': Vtable
            66..90 'Vtable...| {} }': Vtable
            83..88 '|| {}': || -> ()
            86..88 '{}': ()
            100..101 'm': fn()
            104..110 'vtable': Vtable
            104..117 'vtable.method': fn()
        "#]],
    );
}

#[test]
fn effects_smoke_test() {
    check_infer(
        r#"
        async fn main() {
            let x = unsafe { 92 };
            let y = async { async { () }.await };
            let z = try { () };
            let t = 'a: { 92 };
        }

        #[prelude_import] use future::*;

        mod future {
            #[lang = "future_trait"]
            pub trait Future { type Output; }
        }
        "#,
        expect![[r#"
            16..136 '{     ...2 }; }': ()
            26..27 'x': i32
            30..43 'unsafe { 92 }': i32
            37..43 '{ 92 }': i32
            39..41 '92': i32
            53..54 'y': impl Future<Output = ()>
            57..85 'async ...wait }': impl Future<Output = ()>
            63..85 '{ asyn...wait }': ()
            65..77 'async { () }': impl Future<Output = ()>
            65..83 'async ....await': ()
            71..77 '{ () }': ()
            73..75 '()': ()
            95..96 'z': {unknown}
            99..109 'try { () }': {unknown}
            103..109 '{ () }': ()
            105..107 '()': ()
            119..120 't': i32
            127..133 '{ 92 }': i32
            129..131 '92': i32
        "#]],
    )
}

#[test]
fn infer_generic_from_later_assignment() {
    check_infer(
        r#"
        enum Option<T> { Some(T), None }
        use Option::*;

        fn test() {
            let mut end = None;
            loop {
                end = Some(true);
            }
        }
        "#,
        expect![[r#"
            59..129 '{     ...   } }': ()
            69..76 'mut end': Option<bool>
            79..83 'None': Option<bool>
            89..127 'loop {...     }': !
            94..127 '{     ...     }': ()
            104..107 'end': Option<bool>
            104..120 'end = ...(true)': ()
            110..114 'Some': Some<bool>(bool) -> Option<bool>
            110..120 'Some(true)': Option<bool>
            115..119 'true': bool
        "#]],
    );
}

#[test]
fn infer_loop_break_with_val() {
    check_infer(
        r#"
        enum Option<T> { Some(T), None }
        use Option::*;

        fn test() {
            let x = loop {
                if false {
                    break None;
                }

                break Some(true);
            };
        }
        "#,
        expect![[r#"
            59..168 '{     ...  }; }': ()
            69..70 'x': Option<bool>
            73..165 'loop {...     }': Option<bool>
            78..165 '{     ...     }': ()
            88..132 'if fal...     }': ()
            91..96 'false': bool
            97..132 '{     ...     }': ()
            111..121 'break None': !
            117..121 'None': Option<bool>
            142..158 'break ...(true)': !
            148..152 'Some': Some<bool>(bool) -> Option<bool>
            148..158 'Some(true)': Option<bool>
            153..157 'true': bool
        "#]],
    );
}

#[test]
fn infer_loop_break_without_val() {
    check_infer(
        r#"
        enum Option<T> { Some(T), None }
        use Option::*;

        fn test() {
            let x = loop {
                if false {
                    break;
                }
            };
        }
        "#,
        expect![[r#"
            59..136 '{     ...  }; }': ()
            69..70 'x': ()
            73..133 'loop {...     }': ()
            78..133 '{     ...     }': ()
            88..127 'if fal...     }': ()
            91..96 'false': bool
            97..127 '{     ...     }': ()
            111..116 'break': !
        "#]],
    );
}

#[test]
fn infer_labelled_break_with_val() {
    check_infer(
        r#"
        fn foo() {
            let _x = || 'outer: loop {
                let inner = 'inner: loop {
                    let i = Default::default();
                    if (break 'outer i) {
                        loop { break 'inner 5i8; };
                    } else if true {
                        break 'inner 6;
                    }
                    break 7;
                };
                break inner < 8;
            };
        }
        "#,
        expect![[r#"
            9..335 '{     ...  }; }': ()
            19..21 '_x': || -> bool
            24..332 '|| 'ou...     }': || -> bool
            27..332 ''outer...     }': bool
            40..332 '{     ...     }': ()
            54..59 'inner': i8
            62..300 ''inner...     }': i8
            75..300 '{     ...     }': ()
            93..94 'i': bool
            97..113 'Defaul...efault': {unknown}
            97..115 'Defaul...ault()': bool
            129..269 'if (br...     }': ()
            133..147 'break 'outer i': !
            146..147 'i': bool
            149..208 '{     ...     }': ()
            167..193 'loop {...5i8; }': !
            172..193 '{ brea...5i8; }': ()
            174..190 'break ...er 5i8': !
            187..190 '5i8': i8
            214..269 'if tru...     }': ()
            217..221 'true': bool
            222..269 '{     ...     }': ()
            240..254 'break 'inner 6': !
            253..254 '6': i8
            282..289 'break 7': !
            288..289 '7': i8
            310..325 'break inner < 8': !
            316..321 'inner': i8
            316..325 'inner < 8': bool
            324..325 '8': i8
        "#]],
    );
}

#[test]
fn generic_default() {
    check_infer(
        r#"
        struct Thing<T = ()> { t: T }
        enum OtherThing<T = ()> {
            One { t: T },
            Two(T),
        }

        fn test(t1: Thing, t2: OtherThing, t3: Thing<i32>, t4: OtherThing<i32>) {
            t1.t;
            t3.t;
            match t2 {
                OtherThing::One { t } => { t; },
                OtherThing::Two(t) => { t; },
            }
            match t4 {
                OtherThing::One { t } => { t; },
                OtherThing::Two(t) => { t; },
            }
        }
        "#,
        expect![[r#"
            97..99 't1': Thing<()>
            108..110 't2': OtherThing<()>
            124..126 't3': Thing<i32>
            140..142 't4': OtherThing<i32>
            161..384 '{     ...   } }': ()
            167..169 't1': Thing<()>
            167..171 't1.t': ()
            177..179 't3': Thing<i32>
            177..181 't3.t': i32
            187..282 'match ...     }': ()
            193..195 't2': OtherThing<()>
            206..227 'OtherT... { t }': OtherThing<()>
            224..225 't': ()
            231..237 '{ t; }': ()
            233..234 't': ()
            247..265 'OtherT...Two(t)': OtherThing<()>
            263..264 't': ()
            269..275 '{ t; }': ()
            271..272 't': ()
            287..382 'match ...     }': ()
            293..295 't4': OtherThing<i32>
            306..327 'OtherT... { t }': OtherThing<i32>
            324..325 't': i32
            331..337 '{ t; }': ()
            333..334 't': i32
            347..365 'OtherT...Two(t)': OtherThing<i32>
            363..364 't': i32
            369..375 '{ t; }': ()
            371..372 't': i32
        "#]],
    );
}

#[test]
fn generic_default_in_struct_literal() {
    check_infer(
        r#"
        struct Thing<T = ()> { t: T }
        enum OtherThing<T = ()> {
            One { t: T },
            Two(T),
        }

        fn test() {
            let x = Thing { t: loop {} };
            let y = Thing { t: () };
            let z = Thing { t: 1i32 };
            if let Thing { t } = z {
                t;
            }

            let a = OtherThing::One { t: 1i32 };
            let b = OtherThing::Two(1i32);
        }
        "#,
        expect![[r#"
            99..319 '{     ...32); }': ()
            109..110 'x': Thing<!>
            113..133 'Thing ...p {} }': Thing<!>
            124..131 'loop {}': !
            129..131 '{}': ()
            143..144 'y': Thing<()>
            147..162 'Thing { t: () }': Thing<()>
            158..160 '()': ()
            172..173 'z': Thing<i32>
            176..193 'Thing ...1i32 }': Thing<i32>
            187..191 '1i32': i32
            199..240 'if let...     }': ()
            206..217 'Thing { t }': Thing<i32>
            214..215 't': i32
            220..221 'z': Thing<i32>
            222..240 '{     ...     }': ()
            232..233 't': i32
            250..251 'a': OtherThing<i32>
            254..281 'OtherT...1i32 }': OtherThing<i32>
            275..279 '1i32': i32
            291..292 'b': OtherThing<i32>
            295..310 'OtherThing::Two': Two<i32>(i32) -> OtherThing<i32>
            295..316 'OtherT...(1i32)': OtherThing<i32>
            311..315 '1i32': i32
        "#]],
    );
}

#[test]
fn generic_default_depending_on_other_type_arg() {
    // FIXME: the {unknown} is a bug
    check_infer(
        r#"
        struct Thing<T = u128, F = fn() -> T> { t: T }

        fn test(t1: Thing<u32>, t2: Thing) {
            t1;
            t2;
            Thing::<_> { t: 1u32 };
        }
        "#,
        expect![[r#"
            56..58 't1': Thing<u32, fn() -> u32>
            72..74 't2': Thing<u128, fn() -> u128>
            83..130 '{     ...2 }; }': ()
            89..91 't1': Thing<u32, fn() -> u32>
            97..99 't2': Thing<u128, fn() -> u128>
            105..127 'Thing:...1u32 }': Thing<u32, fn() -> {unknown}>
            121..125 '1u32': u32
        "#]],
    );
}

#[test]
fn generic_default_depending_on_other_type_arg_forward() {
    // the {unknown} here is intentional, as defaults are not allowed to
    // refer to type parameters coming later
    check_infer(
        r#"
        struct Thing<F = fn() -> T, T = u128> { t: T }

        fn test(t1: Thing) {
            t1;
        }
        "#,
        expect![[r#"
            56..58 't1': Thing<fn() -> {unknown}, u128>
            67..78 '{     t1; }': ()
            73..75 't1': Thing<fn() -> {unknown}, u128>
        "#]],
    );
}
