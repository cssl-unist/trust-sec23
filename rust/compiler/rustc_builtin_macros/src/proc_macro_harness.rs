use std::mem;

use rustc_ast::attr;
use rustc_ast::ptr::P;
use rustc_ast::visit::{self, Visitor};
use rustc_ast::{self as ast, NodeId};
use rustc_ast_pretty::pprust;
use rustc_expand::base::{ExtCtxt, ResolverExpand};
use rustc_expand::expand::{AstFragment, ExpansionConfig};
use rustc_session::Session;
use rustc_span::hygiene::AstPass;
use rustc_span::source_map::SourceMap;
use rustc_span::symbol::{kw, sym, Ident, Symbol};
use rustc_span::{Span, DUMMY_SP};
use smallvec::smallvec;
use std::cell::RefCell;

struct ProcMacroDerive {
    id: NodeId,
    trait_name: Symbol,
    function_name: Ident,
    span: Span,
    attrs: Vec<Symbol>,
}

enum ProcMacroDefType {
    Attr,
    Bang,
}

struct ProcMacroDef {
    id: NodeId,
    function_name: Ident,
    span: Span,
    def_type: ProcMacroDefType,
}

enum ProcMacro {
    Derive(ProcMacroDerive),
    Def(ProcMacroDef),
}

struct CollectProcMacros<'a> {
    sess: &'a Session,
    macros: Vec<ProcMacro>,
    in_root: bool,
    handler: &'a rustc_errors::Handler,
    source_map: &'a SourceMap,
    is_proc_macro_crate: bool,
    is_test_crate: bool,
}

pub fn inject(
    sess: &Session,
    resolver: &mut dyn ResolverExpand,
    mut krate: ast::Crate,
    is_proc_macro_crate: bool,
    has_proc_macro_decls: bool,
    is_test_crate: bool,
    num_crate_types: usize,
    handler: &rustc_errors::Handler,
) -> ast::Crate {
    let ecfg = ExpansionConfig::default("proc_macro".to_string());
    let mut cx = ExtCtxt::new(sess, ecfg, resolver, None);

    let mut collect = CollectProcMacros {
        sess,
        macros: Vec::new(),
        in_root: true,
        handler,
        source_map: sess.source_map(),
        is_proc_macro_crate,
        is_test_crate,
    };

    if has_proc_macro_decls || is_proc_macro_crate {
        visit::walk_crate(&mut collect, &krate);
    }
    let macros = collect.macros;

    if !is_proc_macro_crate {
        return krate;
    }

    if num_crate_types > 1 {
        handler.err("cannot mix `proc-macro` crate type with others");
    }

    if is_test_crate {
        return krate;
    }

    let decls = mk_decls(&mut krate, &mut cx, &macros);
    krate.module.items.push(decls);

    krate
}

impl<'a> CollectProcMacros<'a> {
    fn check_not_pub_in_root(&self, vis: &ast::Visibility, sp: Span) {
        if self.is_proc_macro_crate && self.in_root && vis.kind.is_pub() {
            self.handler.span_err(
                sp,
                "`proc-macro` crate types currently cannot export any items other \
                    than functions tagged with `#[proc_macro]`, `#[proc_macro_derive]`, \
                    or `#[proc_macro_attribute]`",
            );
        }
    }

    fn collect_custom_derive(&mut self, item: &'a ast::Item, attr: &'a ast::Attribute) {
        // Once we've located the `#[proc_macro_derive]` attribute, verify
        // that it's of the form `#[proc_macro_derive(Foo)]` or
        // `#[proc_macro_derive(Foo, attributes(A, ..))]`
        let list = match attr.meta_item_list() {
            Some(list) => list,
            None => return,
        };
        if list.len() != 1 && list.len() != 2 {
            self.handler.span_err(attr.span, "attribute must have either one or two arguments");
            return;
        }
        let trait_attr = match list[0].meta_item() {
            Some(meta_item) => meta_item,
            _ => {
                self.handler.span_err(list[0].span(), "not a meta item");
                return;
            }
        };
        let trait_ident = match trait_attr.ident() {
            Some(trait_ident) if trait_attr.is_word() => trait_ident,
            _ => {
                self.handler.span_err(trait_attr.span, "must only be one word");
                return;
            }
        };

        if !trait_ident.name.can_be_raw() {
            self.handler.span_err(
                trait_attr.span,
                &format!("`{}` cannot be a name of derive macro", trait_ident),
            );
        }

        let attributes_attr = list.get(1);
        let proc_attrs: Vec<_> = if let Some(attr) = attributes_attr {
            if !attr.has_name(sym::attributes) {
                self.handler.span_err(attr.span(), "second argument must be `attributes`")
            }
            attr.meta_item_list()
                .unwrap_or_else(|| {
                    self.handler
                        .span_err(attr.span(), "attribute must be of form: `attributes(foo, bar)`");
                    &[]
                })
                .iter()
                .filter_map(|attr| {
                    let attr = match attr.meta_item() {
                        Some(meta_item) => meta_item,
                        _ => {
                            self.handler.span_err(attr.span(), "not a meta item");
                            return None;
                        }
                    };

                    let ident = match attr.ident() {
                        Some(ident) if attr.is_word() => ident,
                        _ => {
                            self.handler.span_err(attr.span, "must only be one word");
                            return None;
                        }
                    };
                    if !ident.name.can_be_raw() {
                        self.handler.span_err(
                            attr.span,
                            &format!("`{}` cannot be a name of derive helper attribute", ident),
                        );
                    }

                    Some(ident.name)
                })
                .collect()
        } else {
            Vec::new()
        };

        if self.in_root && item.vis.kind.is_pub() {
            self.macros.push(ProcMacro::Derive(ProcMacroDerive {
                id: item.id,
                span: item.span,
                trait_name: trait_ident.name,
                function_name: item.ident,
                attrs: proc_attrs,
            }));
        } else {
            let msg = if !self.in_root {
                "functions tagged with `#[proc_macro_derive]` must \
                 currently reside in the root of the crate"
            } else {
                "functions tagged with `#[proc_macro_derive]` must be `pub`"
            };
            self.handler.span_err(self.source_map.guess_head_span(item.span), msg);
        }
    }

    fn collect_attr_proc_macro(&mut self, item: &'a ast::Item) {
        if self.in_root && item.vis.kind.is_pub() {
            self.macros.push(ProcMacro::Def(ProcMacroDef {
                id: item.id,
                span: item.span,
                function_name: item.ident,
                def_type: ProcMacroDefType::Attr,
            }));
        } else {
            let msg = if !self.in_root {
                "functions tagged with `#[proc_macro_attribute]` must \
                 currently reside in the root of the crate"
            } else {
                "functions tagged with `#[proc_macro_attribute]` must be `pub`"
            };
            self.handler.span_err(self.source_map.guess_head_span(item.span), msg);
        }
    }

    fn collect_bang_proc_macro(&mut self, item: &'a ast::Item) {
        if self.in_root && item.vis.kind.is_pub() {
            self.macros.push(ProcMacro::Def(ProcMacroDef {
                id: item.id,
                span: item.span,
                function_name: item.ident,
                def_type: ProcMacroDefType::Bang,
            }));
        } else {
            let msg = if !self.in_root {
                "functions tagged with `#[proc_macro]` must \
                 currently reside in the root of the crate"
            } else {
                "functions tagged with `#[proc_macro]` must be `pub`"
            };
            self.handler.span_err(self.source_map.guess_head_span(item.span), msg);
        }
    }
}

impl<'a> Visitor<'a> for CollectProcMacros<'a> {
    fn visit_item(&mut self, item: &'a ast::Item) {
        if let ast::ItemKind::MacroDef(..) = item.kind {
            if self.is_proc_macro_crate && self.sess.contains_name(&item.attrs, sym::macro_export) {
                let msg =
                    "cannot export macro_rules! macros from a `proc-macro` crate type currently";
                self.handler.span_err(self.source_map.guess_head_span(item.span), msg);
            }
        }

        // First up, make sure we're checking a bare function. If we're not then
        // we're just not interested in this item.
        //
        // If we find one, try to locate a `#[proc_macro_derive]` attribute on it.
        let is_fn = match item.kind {
            ast::ItemKind::Fn(..) => true,
            _ => false,
        };

        let mut found_attr: Option<&'a ast::Attribute> = None;

        for attr in &item.attrs {
            if self.sess.is_proc_macro_attr(&attr) {
                if let Some(prev_attr) = found_attr {
                    let prev_item = prev_attr.get_normal_item();
                    let item = attr.get_normal_item();
                    let path_str = pprust::path_to_string(&item.path);
                    let msg = if item.path.segments[0].ident.name
                        == prev_item.path.segments[0].ident.name
                    {
                        format!(
                            "only one `#[{}]` attribute is allowed on any given function",
                            path_str,
                        )
                    } else {
                        format!(
                            "`#[{}]` and `#[{}]` attributes cannot both be applied
                            to the same function",
                            path_str,
                            pprust::path_to_string(&prev_item.path),
                        )
                    };

                    self.handler
                        .struct_span_err(attr.span, &msg)
                        .span_label(prev_attr.span, "previous attribute here")
                        .emit();

                    return;
                }

                found_attr = Some(attr);
            }
        }

        let attr = match found_attr {
            None => {
                self.check_not_pub_in_root(&item.vis, self.source_map.guess_head_span(item.span));
                let prev_in_root = mem::replace(&mut self.in_root, false);
                visit::walk_item(self, item);
                self.in_root = prev_in_root;
                return;
            }
            Some(attr) => attr,
        };

        if !is_fn {
            let msg = format!(
                "the `#[{}]` attribute may only be used on bare functions",
                pprust::path_to_string(&attr.get_normal_item().path),
            );

            self.handler.span_err(attr.span, &msg);
            return;
        }

        if self.is_test_crate {
            return;
        }

        if !self.is_proc_macro_crate {
            let msg = format!(
                "the `#[{}]` attribute is only usable with crates of the `proc-macro` crate type",
                pprust::path_to_string(&attr.get_normal_item().path),
            );

            self.handler.span_err(attr.span, &msg);
            return;
        }

        if self.sess.check_name(attr, sym::proc_macro_derive) {
            self.collect_custom_derive(item, attr);
        } else if self.sess.check_name(attr, sym::proc_macro_attribute) {
            self.collect_attr_proc_macro(item);
        } else if self.sess.check_name(attr, sym::proc_macro) {
            self.collect_bang_proc_macro(item);
        };

        let prev_in_root = mem::replace(&mut self.in_root, false);
        visit::walk_item(self, item);
        self.in_root = prev_in_root;
    }
}

// Creates a new module which looks like:
//
//      const _: () = {
//          extern crate proc_macro;
//
//          use proc_macro::bridge::client::ProcMacro;
//
//          #[rustc_proc_macro_decls]
//          #[allow(deprecated)]
//          static DECLS: &[ProcMacro] = &[
//              ProcMacro::custom_derive($name_trait1, &[], ::$name1);
//              ProcMacro::custom_derive($name_trait2, &["attribute_name"], ::$name2);
//              // ...
//          ];
//      }
fn mk_decls(
    ast_krate: &mut ast::Crate,
    cx: &mut ExtCtxt<'_>,
    macros: &[ProcMacro],
) -> P<ast::Item> {
    // We're the ones filling in this Vec,
    // so it should be empty to start with
    assert!(ast_krate.proc_macros.is_empty());

    let expn_id = cx.resolver.expansion_for_ast_pass(
        DUMMY_SP,
        AstPass::ProcMacroHarness,
        &[sym::rustc_attrs, sym::proc_macro_internals],
        None,
    );
    let span = DUMMY_SP.with_def_site_ctxt(expn_id);

    let proc_macro = Ident::new(sym::proc_macro, span);
    let krate = cx.item(span, proc_macro, Vec::new(), ast::ItemKind::ExternCrate(None));

    let bridge = Ident::new(sym::bridge, span);
    let client = Ident::new(sym::client, span);
    let proc_macro_ty = Ident::new(sym::ProcMacro, span);
    let custom_derive = Ident::new(sym::custom_derive, span);
    let attr = Ident::new(sym::attr, span);
    let bang = Ident::new(sym::bang, span);

    let krate_ref = RefCell::new(ast_krate);

    // We add NodeIds to 'krate.proc_macros' in the order
    // that we generate expressions. The position of each NodeId
    // in the 'proc_macros' Vec corresponds to its position
    // in the static array that will be generated
    let decls = {
        let local_path =
            |sp: Span, name| cx.expr_path(cx.path(sp.with_ctxt(span.ctxt()), vec![name]));
        let proc_macro_ty_method_path = |method| {
            cx.expr_path(cx.path(span, vec![proc_macro, bridge, client, proc_macro_ty, method]))
        };
        macros
            .iter()
            .map(|m| match m {
                ProcMacro::Derive(cd) => {
                    krate_ref.borrow_mut().proc_macros.push(cd.id);
                    cx.expr_call(
                        span,
                        proc_macro_ty_method_path(custom_derive),
                        vec![
                            cx.expr_str(cd.span, cd.trait_name),
                            cx.expr_vec_slice(
                                span,
                                cd.attrs
                                    .iter()
                                    .map(|&s| cx.expr_str(cd.span, s))
                                    .collect::<Vec<_>>(),
                            ),
                            local_path(cd.span, cd.function_name),
                        ],
                    )
                }
                ProcMacro::Def(ca) => {
                    krate_ref.borrow_mut().proc_macros.push(ca.id);
                    let ident = match ca.def_type {
                        ProcMacroDefType::Attr => attr,
                        ProcMacroDefType::Bang => bang,
                    };

                    cx.expr_call(
                        span,
                        proc_macro_ty_method_path(ident),
                        vec![
                            cx.expr_str(ca.span, ca.function_name.name),
                            local_path(ca.span, ca.function_name),
                        ],
                    )
                }
            })
            .collect()
    };

    let decls_static = cx
        .item_static(
            span,
            Ident::new(sym::_DECLS, span),
            cx.ty_rptr(
                span,
                cx.ty(
                    span,
                    ast::TyKind::Slice(
                        cx.ty_path(cx.path(span, vec![proc_macro, bridge, client, proc_macro_ty])),
                    ),
                ),
                None,
                ast::Mutability::Not,
            ),
            ast::Mutability::Not,
            cx.expr_vec_slice(span, decls),
        )
        .map(|mut i| {
            let attr = cx.meta_word(span, sym::rustc_proc_macro_decls);
            i.attrs.push(cx.attribute(attr));

            let deprecated_attr = attr::mk_nested_word_item(Ident::new(sym::deprecated, span));
            let allow_deprecated_attr =
                attr::mk_list_item(Ident::new(sym::allow, span), vec![deprecated_attr]);
            i.attrs.push(cx.attribute(allow_deprecated_attr));

            i
        });

    let block = cx.expr_block(
        cx.block(span, vec![cx.stmt_item(span, krate), cx.stmt_item(span, decls_static)]),
    );

    let anon_constant = cx.item_const(
        span,
        Ident::new(kw::Underscore, span),
        cx.ty(span, ast::TyKind::Tup(Vec::new())),
        block,
    );

    // Integrate the new item into existing module structures.
    let items = AstFragment::Items(smallvec![anon_constant]);
    cx.monotonic_expander().fully_expand_fragment(items).make_items().pop().unwrap()
}
