use crate::utils::{snippet_opt, span_lint_and_then};
use if_chain::if_chain;
use rustc_ast::ast::{Attribute, Item, ItemKind, StructField, Variant, VariantData, VisibilityKind};
use rustc_attr as attr;
use rustc_errors::Applicability;
use rustc_lint::{EarlyContext, EarlyLintPass};
use rustc_session::{declare_lint_pass, declare_tool_lint};
use rustc_span::{sym, Span};

declare_clippy_lint! {
    /// **What it does:** Checks for manual implementations of the non-exhaustive pattern.
    ///
    /// **Why is this bad?** Using the #[non_exhaustive] attribute expresses better the intent
    /// and allows possible optimizations when applied to enums.
    ///
    /// **Known problems:** None.
    ///
    /// **Example:**
    ///
    /// ```rust
    /// struct S {
    ///     pub a: i32,
    ///     pub b: i32,
    ///     _c: (),
    /// }
    ///
    /// enum E {
    ///     A,
    ///     B,
    ///     #[doc(hidden)]
    ///     _C,
    /// }
    ///
    /// struct T(pub i32, pub i32, ());
    /// ```
    /// Use instead:
    /// ```rust
    /// #[non_exhaustive]
    /// struct S {
    ///     pub a: i32,
    ///     pub b: i32,
    /// }
    ///
    /// #[non_exhaustive]
    /// enum E {
    ///     A,
    ///     B,
    /// }
    ///
    /// #[non_exhaustive]
    /// struct T(pub i32, pub i32);
    /// ```
    pub MANUAL_NON_EXHAUSTIVE,
    style,
    "manual implementations of the non-exhaustive pattern can be simplified using #[non_exhaustive]"
}

declare_lint_pass!(ManualNonExhaustive => [MANUAL_NON_EXHAUSTIVE]);

impl EarlyLintPass for ManualNonExhaustive {
    fn check_item(&mut self, cx: &EarlyContext<'_>, item: &Item) {
        match &item.kind {
            ItemKind::Enum(def, _) => {
                check_manual_non_exhaustive_enum(cx, item, &def.variants);
            },
            ItemKind::Struct(variant_data, _) => {
                if let VariantData::Unit(..) = variant_data {
                    return;
                }

                check_manual_non_exhaustive_struct(cx, item, variant_data);
            },
            _ => {},
        }
    }
}

fn check_manual_non_exhaustive_enum(cx: &EarlyContext<'_>, item: &Item, variants: &[Variant]) {
    fn is_non_exhaustive_marker(variant: &Variant) -> bool {
        matches!(variant.data, VariantData::Unit(_))
            && variant.ident.as_str().starts_with('_')
            && variant.attrs.iter().any(|a| is_doc_hidden(a))
    }

    fn is_doc_hidden(attr: &Attribute) -> bool {
        attr.has_name(sym::doc)
            && match attr.meta_item_list() {
                Some(l) => attr::list_contains_name(&l, sym::hidden),
                None => false,
            }
    }

    if_chain! {
        let mut markers = variants.iter().filter(|v| is_non_exhaustive_marker(v));
        if let Some(marker) = markers.next();
        if markers.count() == 0 && variants.len() > 1;
        then {
            span_lint_and_then(
                cx,
                MANUAL_NON_EXHAUSTIVE,
                item.span,
                "this seems like a manual implementation of the non-exhaustive pattern",
                |diag| {
                    if_chain! {
                        if !item.attrs.iter().any(|attr| attr.has_name(sym::non_exhaustive));
                        let header_span = cx.sess.source_map().span_until_char(item.span, '{');
                        if let Some(snippet) = snippet_opt(cx, header_span);
                        then {
                            diag.span_suggestion(
                                header_span,
                                "add the attribute",
                                format!("#[non_exhaustive] {}", snippet),
                                Applicability::Unspecified,
                            );
                        }
                    }
                    diag.span_help(marker.span, "remove this variant");
                });
        }
    }
}

fn check_manual_non_exhaustive_struct(cx: &EarlyContext<'_>, item: &Item, data: &VariantData) {
    fn is_private(field: &StructField) -> bool {
        matches!(field.vis.kind, VisibilityKind::Inherited)
    }

    fn is_non_exhaustive_marker(field: &StructField) -> bool {
        is_private(field) && field.ty.kind.is_unit() && field.ident.map_or(true, |n| n.as_str().starts_with('_'))
    }

    fn find_header_span(cx: &EarlyContext<'_>, item: &Item, data: &VariantData) -> Span {
        let delimiter = match data {
            VariantData::Struct(..) => '{',
            VariantData::Tuple(..) => '(',
            VariantData::Unit(_) => unreachable!("`VariantData::Unit` is already handled above"),
        };

        cx.sess.source_map().span_until_char(item.span, delimiter)
    }

    let fields = data.fields();
    let private_fields = fields.iter().filter(|f| is_private(f)).count();
    let public_fields = fields.iter().filter(|f| f.vis.kind.is_pub()).count();

    if_chain! {
        if private_fields == 1 && public_fields >= 1 && public_fields == fields.len() - 1;
        if let Some(marker) = fields.iter().find(|f| is_non_exhaustive_marker(f));
        then {
            span_lint_and_then(
                cx,
                MANUAL_NON_EXHAUSTIVE,
                item.span,
                "this seems like a manual implementation of the non-exhaustive pattern",
                |diag| {
                    if_chain! {
                        if !item.attrs.iter().any(|attr| attr.has_name(sym::non_exhaustive));
                        let header_span = find_header_span(cx, item, data);
                        if let Some(snippet) = snippet_opt(cx, header_span);
                        then {
                            diag.span_suggestion(
                                header_span,
                                "add the attribute",
                                format!("#[non_exhaustive] {}", snippet),
                                Applicability::Unspecified,
                            );
                        }
                    }
                    diag.span_help(marker.span, "remove this field");
                });
        }
    }
}
