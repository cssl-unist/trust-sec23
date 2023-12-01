use crate::deriving::generic::ty::*;
use crate::deriving::generic::*;

use rustc_ast::ptr::P;
use rustc_ast::{Expr, MetaItem};
use rustc_errors::struct_span_err;
use rustc_expand::base::{Annotatable, DummyResult, ExtCtxt};
use rustc_span::symbol::{kw, sym};
use rustc_span::Span;

pub fn expand_deriving_default(
    cx: &mut ExtCtxt<'_>,
    span: Span,
    mitem: &MetaItem,
    item: &Annotatable,
    push: &mut dyn FnMut(Annotatable),
) {
    let inline = cx.meta_word(span, sym::inline);
    let attrs = vec![cx.attribute(inline)];
    let trait_def = TraitDef {
        span,
        attributes: Vec::new(),
        path: Path::new(vec![kw::Default, sym::Default]),
        additional_bounds: Vec::new(),
        generics: Bounds::empty(),
        is_unsafe: false,
        supports_unions: false,
        methods: vec![MethodDef {
            name: kw::Default,
            generics: Bounds::empty(),
            explicit_self: None,
            args: Vec::new(),
            ret_ty: Self_,
            attributes: attrs,
            is_unsafe: false,
            unify_fieldless_variants: false,
            combine_substructure: combine_substructure(Box::new(|a, b, c| {
                default_substructure(a, b, c)
            })),
        }],
        associated_types: Vec::new(),
    };
    trait_def.expand(cx, mitem, item, push)
}

fn default_substructure(
    cx: &mut ExtCtxt<'_>,
    trait_span: Span,
    substr: &Substructure<'_>,
) -> P<Expr> {
    // Note that `kw::Default` is "default" and `sym::Default` is "Default"!
    let default_ident = cx.std_path(&[kw::Default, sym::Default, kw::Default]);
    let default_call = |span| cx.expr_call_global(span, default_ident.clone(), Vec::new());

    match *substr.fields {
        StaticStruct(_, ref summary) => match *summary {
            Unnamed(ref fields, is_tuple) => {
                if !is_tuple {
                    cx.expr_ident(trait_span, substr.type_ident)
                } else {
                    let exprs = fields.iter().map(|sp| default_call(*sp)).collect();
                    cx.expr_call_ident(trait_span, substr.type_ident, exprs)
                }
            }
            Named(ref fields) => {
                let default_fields = fields
                    .iter()
                    .map(|&(ident, span)| cx.field_imm(span, ident, default_call(span)))
                    .collect();
                cx.expr_struct_ident(trait_span, substr.type_ident, default_fields)
            }
        },
        StaticEnum(..) => {
            struct_span_err!(
                &cx.sess.parse_sess.span_diagnostic,
                trait_span,
                E0665,
                "`Default` cannot be derived for enums, only structs"
            )
            .emit();
            // let compilation continue
            DummyResult::raw_expr(trait_span, true)
        }
        _ => cx.span_bug(trait_span, "method in `derive(Default)`"),
    }
}
