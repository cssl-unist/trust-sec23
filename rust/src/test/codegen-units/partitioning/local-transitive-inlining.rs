// ignore-tidy-linelength
// We specify -C incremental here because we want to test the partitioning for
// incremental compilation
// compile-flags:-Zprint-mono-items=lazy -Cincremental=tmp/partitioning-tests/local-transitive-inlining
// compile-flags:-Zinline-in-all-cgus

#![allow(dead_code)]
#![crate_type="rlib"]

mod inline {

    //~ MONO_ITEM fn inline::inlined_function @@ local_transitive_inlining-indirect_user[Internal]
    #[inline(always)]
    pub fn inlined_function()
    {

    }
}

mod direct_user {
    use super::inline;

    //~ MONO_ITEM fn direct_user::foo @@ local_transitive_inlining-indirect_user[Internal]
    #[inline(always)]
    pub fn foo() {
        inline::inlined_function();
    }
}

pub mod indirect_user {
    use super::direct_user;

    //~ MONO_ITEM fn indirect_user::bar @@ local_transitive_inlining-indirect_user[External]
    pub fn bar() {
        direct_user::foo();
    }
}

pub mod non_user {

    //~ MONO_ITEM fn non_user::baz @@ local_transitive_inlining-non_user[External]
    pub fn baz() {

    }
}
