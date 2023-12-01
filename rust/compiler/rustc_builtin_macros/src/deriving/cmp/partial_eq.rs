use crate::deriving::generic::ty::*;
use crate::deriving::generic::*;
use crate::deriving::{path_local, path_std};

use rustc_ast::ptr::P;
use rustc_ast::{BinOpKind, Expr, MetaItem};
use rustc_expand::base::{Annotatable, ExtCtxt};
use rustc_span::symbol::sym;
use rustc_span::Span;

pub fn expand_deriving_partial_eq(
    cx: &mut ExtCtxt<'_>,
    span: Span,
    mitem: &MetaItem,
    item: &Annotatable,
    push: &mut dyn FnMut(Annotatable),
) {
    // structures are equal if all fields are equal, and non equal, if
    // any fields are not equal or if the enum variants are different
    fn cs_op(
        cx: &mut ExtCtxt<'_>,
        span: Span,
        substr: &Substructure<'_>,
        op: BinOpKind,
        combiner: BinOpKind,
        base: bool,
    ) -> P<Expr> {
        let op = |cx: &mut ExtCtxt<'_>, span: Span, self_f: P<Expr>, other_fs: &[P<Expr>]| {
            let other_f = match other_fs {
                [o_f] => o_f,
                _ => cx.span_bug(span, "not exactly 2 arguments in `derive(PartialEq)`"),
            };

            cx.expr_binary(span, op, self_f, other_f.clone())
        };

        cs_fold1(
            true, // use foldl
            |cx, span, subexpr, self_f, other_fs| {
                let eq = op(cx, span, self_f, other_fs);
                cx.expr_binary(span, combiner, subexpr, eq)
            },
            |cx, args| {
                match args {
                    Some((span, self_f, other_fs)) => {
                        // Special-case the base case to generate cleaner code.
                        op(cx, span, self_f, other_fs)
                    }
                    None => cx.expr_bool(span, base),
                }
            },
            Box::new(|cx, span, _, _| cx.expr_bool(span, !base)),
            cx,
            span,
            substr,
        )
    }

    fn cs_eq(cx: &mut ExtCtxt<'_>, span: Span, substr: &Substructure<'_>) -> P<Expr> {
        cs_op(cx, span, substr, BinOpKind::Eq, BinOpKind::And, true)
    }
    fn cs_ne(cx: &mut ExtCtxt<'_>, span: Span, substr: &Substructure<'_>) -> P<Expr> {
        cs_op(cx, span, substr, BinOpKind::Ne, BinOpKind::Or, false)
    }

    macro_rules! md {
        ($name:expr, $f:ident) => {{
            let inline = cx.meta_word(span, sym::inline);
            let attrs = vec![cx.attribute(inline)];
            MethodDef {
                name: $name,
                generics: Bounds::empty(),
                explicit_self: borrowed_explicit_self(),
                args: vec![(borrowed_self(), sym::other)],
                ret_ty: Literal(path_local!(bool)),
                attributes: attrs,
                is_unsafe: false,
                unify_fieldless_variants: true,
                combine_substructure: combine_substructure(Box::new(|a, b, c| $f(a, b, c))),
            }
        }};
    }

    super::inject_impl_of_structural_trait(
        cx,
        span,
        item,
        path_std!(marker::StructuralPartialEq),
        push,
    );

    // avoid defining `ne` if we can
    // c-like enums, enums without any fields and structs without fields
    // can safely define only `eq`.
    let mut methods = vec![md!(sym::eq, cs_eq)];
    if !is_type_without_fields(item) {
        methods.push(md!(sym::ne, cs_ne));
    }

    let trait_def = TraitDef {
        span,
        attributes: Vec::new(),
        path: path_std!(cmp::PartialEq),
        additional_bounds: Vec::new(),
        generics: Bounds::empty(),
        is_unsafe: false,
        supports_unions: false,
        methods,
        associated_types: Vec::new(),
    };
    trait_def.expand(cx, mitem, item, push)
}
