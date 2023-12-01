use super::*;

#[test]
fn macro_rules_are_globally_visible() {
    check(
        r#"
//- /lib.rs
macro_rules! structs {
    ($($i:ident),*) => {
        $(struct $i { field: u32 } )*
    }
}
structs!(Foo);
mod nested;

//- /nested.rs
structs!(Bar, Baz);
"#,
        expect![[r#"
            crate
            Foo: t
            nested: t

            crate::nested
            Bar: t
            Baz: t
        "#]],
    );
}

#[test]
fn macro_rules_can_define_modules() {
    check(
        r#"
//- /lib.rs
macro_rules! m {
    ($name:ident) => { mod $name;  }
}
m!(n1);
mod m { m!(n3) }

//- /n1.rs
m!(n2)
//- /n1/n2.rs
struct X;
//- /m/n3.rs
struct Y;
"#,
        expect![[r#"
            crate
            m: t
            n1: t

            crate::m
            n3: t

            crate::m::n3
            Y: t v

            crate::n1
            n2: t

            crate::n1::n2
            X: t v
        "#]],
    );
}

#[test]
fn macro_rules_from_other_crates_are_visible() {
    check(
        r#"
//- /main.rs crate:main deps:foo
foo::structs!(Foo, Bar)
mod bar;

//- /bar.rs
use crate::*;

//- /lib.rs crate:foo
#[macro_export]
macro_rules! structs {
    ($($i:ident),*) => {
        $(struct $i { field: u32 } )*
    }
}
"#,
        expect![[r#"
            crate
            Bar: t
            Foo: t
            bar: t

            crate::bar
            Bar: t
            Foo: t
            bar: t
        "#]],
    );
}

#[test]
fn macro_rules_export_with_local_inner_macros_are_visible() {
    check(
        r#"
//- /main.rs crate:main deps:foo
foo::structs!(Foo, Bar)
mod bar;

//- /bar.rs
use crate::*;

//- /lib.rs crate:foo
#[macro_export(local_inner_macros)]
macro_rules! structs {
    ($($i:ident),*) => {
        $(struct $i { field: u32 } )*
    }
}
"#,
        expect![[r#"
            crate
            Bar: t
            Foo: t
            bar: t

            crate::bar
            Bar: t
            Foo: t
            bar: t
        "#]],
    );
}

#[test]
fn local_inner_macros_makes_local_macros_usable() {
    check(
        r#"
//- /main.rs crate:main deps:foo
foo::structs!(Foo, Bar);
mod bar;

//- /bar.rs
use crate::*;

//- /lib.rs crate:foo
#[macro_export(local_inner_macros)]
macro_rules! structs {
    ($($i:ident),*) => {
        inner!($($i),*);
    }
}
#[macro_export]
macro_rules! inner {
    ($($i:ident),*) => {
        $(struct $i { field: u32 } )*
    }
}
"#,
        expect![[r#"
            crate
            Bar: t
            Foo: t
            bar: t

            crate::bar
            Bar: t
            Foo: t
            bar: t
        "#]],
    );
}

#[test]
fn unexpanded_macro_should_expand_by_fixedpoint_loop() {
    check(
        r#"
//- /main.rs crate:main deps:foo
macro_rules! baz {
    () => {
        use foo::bar;
    }
}
foo!();
bar!();
baz!();

//- /lib.rs crate:foo
#[macro_export]
macro_rules! foo {
    () => {
        struct Foo { field: u32 }
    }
}
#[macro_export]
macro_rules! bar {
    () => {
        use foo::foo;
    }
}
"#,
        expect![[r#"
            crate
            Foo: t
            bar: m
            foo: m
        "#]],
    );
}

#[test]
fn macro_rules_from_other_crates_are_visible_with_macro_use() {
    mark::check!(macro_rules_from_other_crates_are_visible_with_macro_use);
    check(
        r#"
//- /main.rs crate:main deps:foo
structs!(Foo);
structs_priv!(Bar);
structs_not_exported!(MacroNotResolved1);
crate::structs!(MacroNotResolved2);

mod bar;

#[macro_use]
extern crate foo;

//- /bar.rs
structs!(Baz);
crate::structs!(MacroNotResolved3);

//- /lib.rs crate:foo
#[macro_export]
macro_rules! structs {
    ($i:ident) => { struct $i; }
}

macro_rules! structs_not_exported {
    ($i:ident) => { struct $i; }
}

mod priv_mod {
    #[macro_export]
    macro_rules! structs_priv {
        ($i:ident) => { struct $i; }
    }
}
"#,
        expect![[r#"
            crate
            Bar: t v
            Foo: t v
            bar: t
            foo: t

            crate::bar
            Baz: t v
        "#]],
    );
}

#[test]
fn prelude_is_macro_use() {
    mark::check!(prelude_is_macro_use);
    check(
        r#"
//- /main.rs crate:main deps:foo
structs!(Foo);
structs_priv!(Bar);
structs_outside!(Out);
crate::structs!(MacroNotResolved2);

mod bar;

//- /bar.rs
structs!(Baz);
crate::structs!(MacroNotResolved3);

//- /lib.rs crate:foo
#[prelude_import]
use self::prelude::*;

mod prelude {
    #[macro_export]
    macro_rules! structs {
        ($i:ident) => { struct $i; }
    }

    mod priv_mod {
        #[macro_export]
        macro_rules! structs_priv {
            ($i:ident) => { struct $i; }
        }
    }
}

#[macro_export]
macro_rules! structs_outside {
    ($i:ident) => { struct $i; }
}
"#,
        expect![[r#"
            crate
            Bar: t v
            Foo: t v
            Out: t v
            bar: t

            crate::bar
            Baz: t v
        "#]],
    );
}

#[test]
fn prelude_cycle() {
    check(
        r#"
#[prelude_import]
use self::prelude::*;

declare_mod!();

mod prelude {
    macro_rules! declare_mod {
        () => (mod foo {})
    }
}
"#,
        expect![[r#"
            crate
            prelude: t

            crate::prelude
        "#]],
    );
}

#[test]
fn plain_macros_are_legacy_textual_scoped() {
    check(
        r#"
//- /main.rs
mod m1;
bar!(NotFoundNotMacroUse);

mod m2 { foo!(NotFoundBeforeInside2); }

macro_rules! foo {
    ($x:ident) => { struct $x; }
}
foo!(Ok);

mod m3;
foo!(OkShadowStop);
bar!(NotFoundMacroUseStop);

#[macro_use]
mod m5 {
    #[macro_use]
    mod m6 {
        macro_rules! foo {
            ($x:ident) => { fn $x() {} }
        }
    }
}
foo!(ok_double_macro_use_shadow);

baz!(NotFoundBefore);
#[macro_use]
mod m7 {
    macro_rules! baz {
        ($x:ident) => { struct $x; }
    }
}
baz!(OkAfter);

//- /m1.rs
foo!(NotFoundBeforeInside1);
macro_rules! bar {
    ($x:ident) => { struct $x; }
}

//- /m3/mod.rs
foo!(OkAfterInside);
macro_rules! foo {
    ($x:ident) => { fn $x() {} }
}
foo!(ok_shadow);

#[macro_use]
mod m4;
bar!(OkMacroUse);

//- /m3/m4.rs
foo!(ok_shadow_deep);
macro_rules! bar {
    ($x:ident) => { struct $x; }
}
"#,
        expect![[r#"
            crate
            Ok: t v
            OkAfter: t v
            OkShadowStop: t v
            m1: t
            m2: t
            m3: t
            m5: t
            m7: t
            ok_double_macro_use_shadow: v

            crate::m7

            crate::m1

            crate::m5
            m6: t

            crate::m5::m6

            crate::m2

            crate::m3
            OkAfterInside: t v
            OkMacroUse: t v
            m4: t
            ok_shadow: v

            crate::m3::m4
            ok_shadow_deep: v
        "#]],
    );
}

#[test]
fn type_value_macro_live_in_different_scopes() {
    check(
        r#"
#[macro_export]
macro_rules! foo {
    ($x:ident) => { type $x = (); }
}

foo!(foo);
use foo as bar;

use self::foo as baz;
fn baz() {}
"#,
        expect![[r#"
            crate
            bar: t m
            baz: t v m
            foo: t m
        "#]],
    );
}

#[test]
fn macro_use_can_be_aliased() {
    check(
        r#"
//- /main.rs crate:main deps:foo
#[macro_use]
extern crate foo;

foo!(Direct);
bar!(Alias);

//- /lib.rs crate:foo
use crate::foo as bar;

mod m {
    #[macro_export]
    macro_rules! foo {
        ($x:ident) => { struct $x; }
    }
}
"#,
        expect![[r#"
            crate
            Alias: t v
            Direct: t v
            foo: t
        "#]],
    );
}

#[test]
fn path_qualified_macros() {
    check(
        r#"
macro_rules! foo {
    ($x:ident) => { struct $x; }
}

crate::foo!(NotResolved);

crate::bar!(OkCrate);
bar!(OkPlain);
alias1!(NotHere);
m::alias1!(OkAliasPlain);
m::alias2!(OkAliasSuper);
m::alias3!(OkAliasCrate);
not_found!(NotFound);

mod m {
    #[macro_export]
    macro_rules! bar {
        ($x:ident) => { struct $x; }
    }
    pub use bar as alias1;
    pub use super::bar as alias2;
    pub use crate::bar as alias3;
    pub use self::bar as not_found;
}
"#,
        expect![[r#"
            crate
            OkAliasCrate: t v
            OkAliasPlain: t v
            OkAliasSuper: t v
            OkCrate: t v
            OkPlain: t v
            bar: m
            m: t

            crate::m
            alias1: m
            alias2: m
            alias3: m
            not_found: _
        "#]],
    );
}

#[test]
fn macro_dollar_crate_is_correct_in_item() {
    mark::check!(macro_dollar_crate_self);
    check(
        r#"
//- /main.rs crate:main deps:foo
#[macro_use]
extern crate foo;

#[macro_use]
mod m {
    macro_rules! current {
        () => {
            use $crate::Foo as FooSelf;
        }
    }
}

struct Foo;

current!();
not_current1!();
foo::not_current2!();

//- /lib.rs crate:foo
mod m {
    #[macro_export]
    macro_rules! not_current1 {
        () => {
            use $crate::Bar;
        }
    }
}

#[macro_export]
macro_rules! not_current2 {
    () => {
        use $crate::Baz;
    }
}

struct Bar;
struct Baz;
"#,
        expect![[r#"
            crate
            Bar: t v
            Baz: t v
            Foo: t v
            FooSelf: t v
            foo: t
            m: t

            crate::m
        "#]],
    );
}

#[test]
fn macro_dollar_crate_is_correct_in_indirect_deps() {
    mark::check!(macro_dollar_crate_other);
    // From std
    check(
        r#"
//- /main.rs crate:main deps:std
foo!();

//- /std.rs crate:std deps:core
#[prelude_import]
use self::prelude::*;

pub use core::foo;

mod prelude {}

#[macro_use]
mod std_macros;

//- /core.rs crate:core
#[macro_export]
macro_rules! foo {
    () => {
        use $crate::bar;
    }
}

pub struct bar;
"#,
        expect![[r#"
            crate
            bar: t v
        "#]],
    );
}

#[test]
fn expand_derive() {
    let map = compute_crate_def_map(
        "
        //- /main.rs
        #[derive(Copy, Clone)]
        struct Foo;
        ",
    );
    assert_eq!(map.modules[map.root].scope.impls().len(), 2);
}

#[test]
fn macro_expansion_overflow() {
    mark::check!(macro_expansion_overflow);
    check(
        r#"
macro_rules! a {
    ($e:expr; $($t:tt)*) => {
        b!($($t)*);
    };
    () => {};
}

macro_rules! b {
    (static = $e:expr; $($t:tt)*) => {
        a!($e; $($t)*);
    };
    () => {};
}

b! { static = #[] (); }
"#,
        expect![[r#"
            crate
        "#]],
    );
}
