use crate::utils::{differing_macro_contexts, higher, snippet_block_with_applicability, span_lint, span_lint_and_sugg};
use rustc_errors::Applicability;
use rustc_hir::intravisit::{walk_expr, NestedVisitorMap, Visitor};
use rustc_hir::{BlockCheckMode, Expr, ExprKind};
use rustc_lint::{LateContext, LateLintPass, LintContext};
use rustc_middle::hir::map::Map;
use rustc_middle::lint::in_external_macro;
use rustc_session::{declare_lint_pass, declare_tool_lint};

declare_clippy_lint! {
    /// **What it does:** Checks for `if` conditions that use blocks containing an
    /// expression, statements or conditions that use closures with blocks.
    ///
    /// **Why is this bad?** Style, using blocks in the condition makes it hard to read.
    ///
    /// **Known problems:** None.
    ///
    /// **Examples:**
    /// ```rust
    /// // Bad
    /// if { true } { /* ... */ }
    ///
    /// // Good
    /// if true { /* ... */ }
    /// ```
    ///
    /// // or
    ///
    /// ```rust
    /// # fn somefunc() -> bool { true };
    /// // Bad
    /// if { let x = somefunc(); x } { /* ... */ }
    ///
    /// // Good
    /// let res = { let x = somefunc(); x };
    /// if res { /* ... */ }
    /// ```
    pub BLOCKS_IN_IF_CONDITIONS,
    style,
    "useless or complex blocks that can be eliminated in conditions"
}

declare_lint_pass!(BlocksInIfConditions => [BLOCKS_IN_IF_CONDITIONS]);

struct ExVisitor<'a, 'tcx> {
    found_block: Option<&'tcx Expr<'tcx>>,
    cx: &'a LateContext<'tcx>,
}

impl<'a, 'tcx> Visitor<'tcx> for ExVisitor<'a, 'tcx> {
    type Map = Map<'tcx>;

    fn visit_expr(&mut self, expr: &'tcx Expr<'tcx>) {
        if let ExprKind::Closure(_, _, eid, _, _) = expr.kind {
            let body = self.cx.tcx.hir().body(eid);
            let ex = &body.value;
            if matches!(ex.kind, ExprKind::Block(_, _)) && !body.value.span.from_expansion() {
                self.found_block = Some(ex);
                return;
            }
        }
        walk_expr(self, expr);
    }
    fn nested_visit_map(&mut self) -> NestedVisitorMap<Self::Map> {
        NestedVisitorMap::None
    }
}

const BRACED_EXPR_MESSAGE: &str = "omit braces around single expression condition";
const COMPLEX_BLOCK_MESSAGE: &str = "in an `if` condition, avoid complex blocks or closures with blocks; \
                                    instead, move the block or closure higher and bind it with a `let`";

impl<'tcx> LateLintPass<'tcx> for BlocksInIfConditions {
    fn check_expr(&mut self, cx: &LateContext<'tcx>, expr: &'tcx Expr<'_>) {
        if in_external_macro(cx.sess(), expr.span) {
            return;
        }
        if let Some((cond, _, _)) = higher::if_block(&expr) {
            if let ExprKind::Block(block, _) = &cond.kind {
                if block.rules == BlockCheckMode::DefaultBlock {
                    if block.stmts.is_empty() {
                        if let Some(ex) = &block.expr {
                            // don't dig into the expression here, just suggest that they remove
                            // the block
                            if expr.span.from_expansion() || differing_macro_contexts(expr.span, ex.span) {
                                return;
                            }
                            let mut applicability = Applicability::MachineApplicable;
                            span_lint_and_sugg(
                                cx,
                                BLOCKS_IN_IF_CONDITIONS,
                                cond.span,
                                BRACED_EXPR_MESSAGE,
                                "try",
                                format!(
                                    "{}",
                                    snippet_block_with_applicability(
                                        cx,
                                        ex.span,
                                        "..",
                                        Some(expr.span),
                                        &mut applicability
                                    )
                                ),
                                applicability,
                            );
                        }
                    } else {
                        let span = block.expr.as_ref().map_or_else(|| block.stmts[0].span, |e| e.span);
                        if span.from_expansion() || differing_macro_contexts(expr.span, span) {
                            return;
                        }
                        // move block higher
                        let mut applicability = Applicability::MachineApplicable;
                        span_lint_and_sugg(
                            cx,
                            BLOCKS_IN_IF_CONDITIONS,
                            expr.span.with_hi(cond.span.hi()),
                            COMPLEX_BLOCK_MESSAGE,
                            "try",
                            format!(
                                "let res = {}; if res",
                                snippet_block_with_applicability(
                                    cx,
                                    block.span,
                                    "..",
                                    Some(expr.span),
                                    &mut applicability
                                ),
                            ),
                            applicability,
                        );
                    }
                }
            } else {
                let mut visitor = ExVisitor { found_block: None, cx };
                walk_expr(&mut visitor, cond);
                if let Some(block) = visitor.found_block {
                    span_lint(cx, BLOCKS_IN_IF_CONDITIONS, block.span, COMPLEX_BLOCK_MESSAGE);
                }
            }
        }
    }
}
