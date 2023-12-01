use super::{contains_return, BIND_INSTEAD_OF_MAP};
use crate::utils::{
    in_macro, match_qpath, match_type, method_calls, multispan_sugg_with_applicability, paths, remove_blocks, snippet,
    snippet_with_macro_callsite, span_lint_and_sugg, span_lint_and_then,
};
use if_chain::if_chain;
use rustc_errors::Applicability;
use rustc_hir as hir;
use rustc_hir::intravisit::{self, Visitor};
use rustc_lint::LateContext;
use rustc_middle::hir::map::Map;
use rustc_span::Span;

pub(crate) struct OptionAndThenSome;

impl BindInsteadOfMap for OptionAndThenSome {
    const TYPE_NAME: &'static str = "Option";
    const TYPE_QPATH: &'static [&'static str] = &paths::OPTION;

    const BAD_METHOD_NAME: &'static str = "and_then";
    const BAD_VARIANT_NAME: &'static str = "Some";
    const BAD_VARIANT_QPATH: &'static [&'static str] = &paths::OPTION_SOME;

    const GOOD_METHOD_NAME: &'static str = "map";
}

pub(crate) struct ResultAndThenOk;

impl BindInsteadOfMap for ResultAndThenOk {
    const TYPE_NAME: &'static str = "Result";
    const TYPE_QPATH: &'static [&'static str] = &paths::RESULT;

    const BAD_METHOD_NAME: &'static str = "and_then";
    const BAD_VARIANT_NAME: &'static str = "Ok";
    const BAD_VARIANT_QPATH: &'static [&'static str] = &paths::RESULT_OK;

    const GOOD_METHOD_NAME: &'static str = "map";
}

pub(crate) struct ResultOrElseErrInfo;

impl BindInsteadOfMap for ResultOrElseErrInfo {
    const TYPE_NAME: &'static str = "Result";
    const TYPE_QPATH: &'static [&'static str] = &paths::RESULT;

    const BAD_METHOD_NAME: &'static str = "or_else";
    const BAD_VARIANT_NAME: &'static str = "Err";
    const BAD_VARIANT_QPATH: &'static [&'static str] = &paths::RESULT_ERR;

    const GOOD_METHOD_NAME: &'static str = "map_err";
}

pub(crate) trait BindInsteadOfMap {
    const TYPE_NAME: &'static str;
    const TYPE_QPATH: &'static [&'static str];

    const BAD_METHOD_NAME: &'static str;
    const BAD_VARIANT_NAME: &'static str;
    const BAD_VARIANT_QPATH: &'static [&'static str];

    const GOOD_METHOD_NAME: &'static str;

    fn no_op_msg() -> String {
        format!(
            "using `{}.{}({})`, which is a no-op",
            Self::TYPE_NAME,
            Self::BAD_METHOD_NAME,
            Self::BAD_VARIANT_NAME
        )
    }

    fn lint_msg() -> String {
        format!(
            "using `{}.{}(|x| {}(y))`, which is more succinctly expressed as `{}(|x| y)`",
            Self::TYPE_NAME,
            Self::BAD_METHOD_NAME,
            Self::BAD_VARIANT_NAME,
            Self::GOOD_METHOD_NAME
        )
    }

    fn lint_closure_autofixable(
        cx: &LateContext<'_>,
        expr: &hir::Expr<'_>,
        args: &[hir::Expr<'_>],
        closure_expr: &hir::Expr<'_>,
        closure_args_span: Span,
    ) -> bool {
        if_chain! {
            if let hir::ExprKind::Call(ref some_expr, ref some_args) = closure_expr.kind;
            if let hir::ExprKind::Path(ref qpath) = some_expr.kind;
            if match_qpath(qpath, Self::BAD_VARIANT_QPATH);
            if some_args.len() == 1;
            then {
                let inner_expr = &some_args[0];

                if contains_return(inner_expr) {
                    return false;
                }

                let some_inner_snip = if inner_expr.span.from_expansion() {
                    snippet_with_macro_callsite(cx, inner_expr.span, "_")
                } else {
                    snippet(cx, inner_expr.span, "_")
                };

                let closure_args_snip = snippet(cx, closure_args_span, "..");
                let option_snip = snippet(cx, args[0].span, "..");
                let note = format!("{}.{}({} {})", option_snip, Self::GOOD_METHOD_NAME, closure_args_snip, some_inner_snip);
                span_lint_and_sugg(
                    cx,
                    BIND_INSTEAD_OF_MAP,
                    expr.span,
                    Self::lint_msg().as_ref(),
                    "try this",
                    note,
                    Applicability::MachineApplicable,
                );
                true
            } else {
                false
            }
        }
    }

    fn lint_closure(cx: &LateContext<'_>, expr: &hir::Expr<'_>, closure_expr: &hir::Expr<'_>) -> bool {
        let mut suggs = Vec::new();
        let can_sugg: bool = find_all_ret_expressions(cx, closure_expr, |ret_expr| {
            if_chain! {
                if !in_macro(ret_expr.span);
                if let hir::ExprKind::Call(ref func_path, ref args) = ret_expr.kind;
                if let hir::ExprKind::Path(ref qpath) = func_path.kind;
                if match_qpath(qpath, Self::BAD_VARIANT_QPATH);
                if args.len() == 1;
                if !contains_return(&args[0]);
                then {
                    suggs.push((ret_expr.span, args[0].span.source_callsite()));
                    true
                } else {
                    false
                }
            }
        });

        if can_sugg {
            span_lint_and_then(cx, BIND_INSTEAD_OF_MAP, expr.span, Self::lint_msg().as_ref(), |diag| {
                multispan_sugg_with_applicability(
                    diag,
                    "try this",
                    Applicability::MachineApplicable,
                    std::iter::once((*method_calls(expr, 1).2.get(0).unwrap(), Self::GOOD_METHOD_NAME.into())).chain(
                        suggs
                            .into_iter()
                            .map(|(span1, span2)| (span1, snippet(cx, span2, "_").into())),
                    ),
                )
            });
        }
        can_sugg
    }

    /// Lint use of `_.and_then(|x| Some(y))` for `Option`s
    fn lint(cx: &LateContext<'_>, expr: &hir::Expr<'_>, args: &[hir::Expr<'_>]) -> bool {
        if !match_type(cx, cx.typeck_results().expr_ty(&args[0]), Self::TYPE_QPATH) {
            return false;
        }

        match args[1].kind {
            hir::ExprKind::Closure(_, _, body_id, closure_args_span, _) => {
                let closure_body = cx.tcx.hir().body(body_id);
                let closure_expr = remove_blocks(&closure_body.value);

                if Self::lint_closure_autofixable(cx, expr, args, closure_expr, closure_args_span) {
                    true
                } else {
                    Self::lint_closure(cx, expr, closure_expr)
                }
            },
            // `_.and_then(Some)` case, which is no-op.
            hir::ExprKind::Path(ref qpath) if match_qpath(qpath, Self::BAD_VARIANT_QPATH) => {
                span_lint_and_sugg(
                    cx,
                    BIND_INSTEAD_OF_MAP,
                    expr.span,
                    Self::no_op_msg().as_ref(),
                    "use the expression directly",
                    snippet(cx, args[0].span, "..").into(),
                    Applicability::MachineApplicable,
                );
                true
            },
            _ => false,
        }
    }
}

/// returns `true` if expr contains match expr desugared from try
fn contains_try(expr: &hir::Expr<'_>) -> bool {
    struct TryFinder {
        found: bool,
    }

    impl<'hir> intravisit::Visitor<'hir> for TryFinder {
        type Map = Map<'hir>;

        fn nested_visit_map(&mut self) -> intravisit::NestedVisitorMap<Self::Map> {
            intravisit::NestedVisitorMap::None
        }

        fn visit_expr(&mut self, expr: &'hir hir::Expr<'hir>) {
            if self.found {
                return;
            }
            match expr.kind {
                hir::ExprKind::Match(_, _, hir::MatchSource::TryDesugar) => self.found = true,
                _ => intravisit::walk_expr(self, expr),
            }
        }
    }

    let mut visitor = TryFinder { found: false };
    visitor.visit_expr(expr);
    visitor.found
}

fn find_all_ret_expressions<'hir, F>(_cx: &LateContext<'_>, expr: &'hir hir::Expr<'hir>, callback: F) -> bool
where
    F: FnMut(&'hir hir::Expr<'hir>) -> bool,
{
    struct RetFinder<F> {
        in_stmt: bool,
        failed: bool,
        cb: F,
    }

    struct WithStmtGuarg<'a, F> {
        val: &'a mut RetFinder<F>,
        prev_in_stmt: bool,
    }

    impl<F> RetFinder<F> {
        fn inside_stmt(&mut self, in_stmt: bool) -> WithStmtGuarg<'_, F> {
            let prev_in_stmt = std::mem::replace(&mut self.in_stmt, in_stmt);
            WithStmtGuarg {
                val: self,
                prev_in_stmt,
            }
        }
    }

    impl<F> std::ops::Deref for WithStmtGuarg<'_, F> {
        type Target = RetFinder<F>;

        fn deref(&self) -> &Self::Target {
            self.val
        }
    }

    impl<F> std::ops::DerefMut for WithStmtGuarg<'_, F> {
        fn deref_mut(&mut self) -> &mut Self::Target {
            self.val
        }
    }

    impl<F> Drop for WithStmtGuarg<'_, F> {
        fn drop(&mut self) {
            self.val.in_stmt = self.prev_in_stmt;
        }
    }

    impl<'hir, F: FnMut(&'hir hir::Expr<'hir>) -> bool> intravisit::Visitor<'hir> for RetFinder<F> {
        type Map = Map<'hir>;

        fn nested_visit_map(&mut self) -> intravisit::NestedVisitorMap<Self::Map> {
            intravisit::NestedVisitorMap::None
        }

        fn visit_stmt(&mut self, stmt: &'hir hir::Stmt<'_>) {
            intravisit::walk_stmt(&mut *self.inside_stmt(true), stmt)
        }

        fn visit_expr(&mut self, expr: &'hir hir::Expr<'_>) {
            if self.failed {
                return;
            }
            if self.in_stmt {
                match expr.kind {
                    hir::ExprKind::Ret(Some(expr)) => self.inside_stmt(false).visit_expr(expr),
                    _ => intravisit::walk_expr(self, expr),
                }
            } else {
                match expr.kind {
                    hir::ExprKind::Match(cond, arms, _) => {
                        self.inside_stmt(true).visit_expr(cond);
                        for arm in arms {
                            self.visit_expr(arm.body);
                        }
                    },
                    hir::ExprKind::Block(..) => intravisit::walk_expr(self, expr),
                    hir::ExprKind::Ret(Some(expr)) => self.visit_expr(expr),
                    _ => self.failed |= !(self.cb)(expr),
                }
            }
        }
    }

    !contains_try(expr) && {
        let mut ret_finder = RetFinder {
            in_stmt: false,
            failed: false,
            cb: callback,
        };
        ret_finder.visit_expr(expr);
        !ret_finder.failed
    }
}
