use ide_db::{defs::Definition, search::ReferenceKind};
use syntax::{
    ast::{self, AstNode, AstToken},
    TextRange,
};
use test_utils::mark;

use crate::{
    assist_context::{AssistContext, Assists},
    AssistId, AssistKind,
};

// Assist: inline_local_variable
//
// Inlines local variable.
//
// ```
// fn main() {
//     let x<|> = 1 + 2;
//     x * 4;
// }
// ```
// ->
// ```
// fn main() {
//     (1 + 2) * 4;
// }
// ```
pub(crate) fn inline_local_variable(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let let_stmt = ctx.find_node_at_offset::<ast::LetStmt>()?;
    let bind_pat = match let_stmt.pat()? {
        ast::Pat::IdentPat(pat) => pat,
        _ => return None,
    };
    if bind_pat.mut_token().is_some() {
        mark::hit!(test_not_inline_mut_variable);
        return None;
    }
    if !bind_pat.syntax().text_range().contains_inclusive(ctx.offset()) {
        mark::hit!(not_applicable_outside_of_bind_pat);
        return None;
    }
    let initializer_expr = let_stmt.initializer()?;

    let def = ctx.sema.to_def(&bind_pat)?;
    let def = Definition::Local(def);
    let refs = def.usages(&ctx.sema).all();
    if refs.is_empty() {
        mark::hit!(test_not_applicable_if_variable_unused);
        return None;
    };

    let delete_range = if let Some(whitespace) = let_stmt
        .syntax()
        .next_sibling_or_token()
        .and_then(|it| ast::Whitespace::cast(it.as_token()?.clone()))
    {
        TextRange::new(
            let_stmt.syntax().text_range().start(),
            whitespace.syntax().text_range().end(),
        )
    } else {
        let_stmt.syntax().text_range()
    };

    let mut wrap_in_parens = vec![true; refs.len()];

    for (i, desc) in refs.iter().enumerate() {
        let usage_node = ctx
            .covering_node_for_range(desc.file_range.range)
            .ancestors()
            .find_map(ast::PathExpr::cast)?;
        let usage_parent_option = usage_node.syntax().parent().and_then(ast::Expr::cast);
        let usage_parent = match usage_parent_option {
            Some(u) => u,
            None => {
                wrap_in_parens[i] = false;
                continue;
            }
        };

        wrap_in_parens[i] = match (&initializer_expr, usage_parent) {
            (ast::Expr::CallExpr(_), _)
            | (ast::Expr::IndexExpr(_), _)
            | (ast::Expr::MethodCallExpr(_), _)
            | (ast::Expr::FieldExpr(_), _)
            | (ast::Expr::TryExpr(_), _)
            | (ast::Expr::RefExpr(_), _)
            | (ast::Expr::Literal(_), _)
            | (ast::Expr::TupleExpr(_), _)
            | (ast::Expr::ArrayExpr(_), _)
            | (ast::Expr::ParenExpr(_), _)
            | (ast::Expr::PathExpr(_), _)
            | (ast::Expr::BlockExpr(_), _)
            | (ast::Expr::EffectExpr(_), _)
            | (_, ast::Expr::CallExpr(_))
            | (_, ast::Expr::TupleExpr(_))
            | (_, ast::Expr::ArrayExpr(_))
            | (_, ast::Expr::ParenExpr(_))
            | (_, ast::Expr::ForExpr(_))
            | (_, ast::Expr::WhileExpr(_))
            | (_, ast::Expr::BreakExpr(_))
            | (_, ast::Expr::ReturnExpr(_))
            | (_, ast::Expr::MatchExpr(_)) => false,
            _ => true,
        };
    }

    let init_str = initializer_expr.syntax().text().to_string();
    let init_in_paren = format!("({})", &init_str);

    let target = bind_pat.syntax().text_range();
    acc.add(
        AssistId("inline_local_variable", AssistKind::RefactorInline),
        "Inline variable",
        target,
        move |builder| {
            builder.delete(delete_range);
            for (desc, should_wrap) in refs.iter().zip(wrap_in_parens) {
                let replacement =
                    if should_wrap { init_in_paren.clone() } else { init_str.clone() };
                match desc.kind {
                    ReferenceKind::FieldShorthandForLocal => {
                        mark::hit!(inline_field_shorthand);
                        builder.insert(desc.file_range.range.end(), format!(": {}", replacement))
                    }
                    _ => builder.replace(desc.file_range.range, replacement),
                }
            }
        },
    )
}

#[cfg(test)]
mod tests {
    use test_utils::mark;

    use crate::tests::{check_assist, check_assist_not_applicable};

    use super::*;

    #[test]
    fn test_inline_let_bind_literal_expr() {
        check_assist(
            inline_local_variable,
            r"
fn bar(a: usize) {}
fn foo() {
    let a<|> = 1;
    a + 1;
    if a > 10 {
    }

    while a > 10 {

    }
    let b = a * 10;
    bar(a);
}",
            r"
fn bar(a: usize) {}
fn foo() {
    1 + 1;
    if 1 > 10 {
    }

    while 1 > 10 {

    }
    let b = 1 * 10;
    bar(1);
}",
        );
    }

    #[test]
    fn test_inline_let_bind_bin_expr() {
        check_assist(
            inline_local_variable,
            r"
fn bar(a: usize) {}
fn foo() {
    let a<|> = 1 + 1;
    a + 1;
    if a > 10 {
    }

    while a > 10 {

    }
    let b = a * 10;
    bar(a);
}",
            r"
fn bar(a: usize) {}
fn foo() {
    (1 + 1) + 1;
    if (1 + 1) > 10 {
    }

    while (1 + 1) > 10 {

    }
    let b = (1 + 1) * 10;
    bar(1 + 1);
}",
        );
    }

    #[test]
    fn test_inline_let_bind_function_call_expr() {
        check_assist(
            inline_local_variable,
            r"
fn bar(a: usize) {}
fn foo() {
    let a<|> = bar(1);
    a + 1;
    if a > 10 {
    }

    while a > 10 {

    }
    let b = a * 10;
    bar(a);
}",
            r"
fn bar(a: usize) {}
fn foo() {
    bar(1) + 1;
    if bar(1) > 10 {
    }

    while bar(1) > 10 {

    }
    let b = bar(1) * 10;
    bar(bar(1));
}",
        );
    }

    #[test]
    fn test_inline_let_bind_cast_expr() {
        check_assist(
            inline_local_variable,
            r"
fn bar(a: usize): usize { a }
fn foo() {
    let a<|> = bar(1) as u64;
    a + 1;
    if a > 10 {
    }

    while a > 10 {

    }
    let b = a * 10;
    bar(a);
}",
            r"
fn bar(a: usize): usize { a }
fn foo() {
    (bar(1) as u64) + 1;
    if (bar(1) as u64) > 10 {
    }

    while (bar(1) as u64) > 10 {

    }
    let b = (bar(1) as u64) * 10;
    bar(bar(1) as u64);
}",
        );
    }

    #[test]
    fn test_inline_let_bind_block_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = { 10 + 1 };
    a + 1;
    if a > 10 {
    }

    while a > 10 {

    }
    let b = a * 10;
    bar(a);
}",
            r"
fn foo() {
    { 10 + 1 } + 1;
    if { 10 + 1 } > 10 {
    }

    while { 10 + 1 } > 10 {

    }
    let b = { 10 + 1 } * 10;
    bar({ 10 + 1 });
}",
        );
    }

    #[test]
    fn test_inline_let_bind_paren_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = ( 10 + 1 );
    a + 1;
    if a > 10 {
    }

    while a > 10 {

    }
    let b = a * 10;
    bar(a);
}",
            r"
fn foo() {
    ( 10 + 1 ) + 1;
    if ( 10 + 1 ) > 10 {
    }

    while ( 10 + 1 ) > 10 {

    }
    let b = ( 10 + 1 ) * 10;
    bar(( 10 + 1 ));
}",
        );
    }

    #[test]
    fn test_not_inline_mut_variable() {
        mark::check!(test_not_inline_mut_variable);
        check_assist_not_applicable(
            inline_local_variable,
            r"
fn foo() {
    let mut a<|> = 1 + 1;
    a + 1;
}",
        );
    }

    #[test]
    fn test_call_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = bar(10 + 1);
    let b = a * 10;
    let c = a as usize;
}",
            r"
fn foo() {
    let b = bar(10 + 1) * 10;
    let c = bar(10 + 1) as usize;
}",
        );
    }

    #[test]
    fn test_index_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let x = vec![1, 2, 3];
    let a<|> = x[0];
    let b = a * 10;
    let c = a as usize;
}",
            r"
fn foo() {
    let x = vec![1, 2, 3];
    let b = x[0] * 10;
    let c = x[0] as usize;
}",
        );
    }

    #[test]
    fn test_method_call_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let bar = vec![1];
    let a<|> = bar.len();
    let b = a * 10;
    let c = a as usize;
}",
            r"
fn foo() {
    let bar = vec![1];
    let b = bar.len() * 10;
    let c = bar.len() as usize;
}",
        );
    }

    #[test]
    fn test_field_expr() {
        check_assist(
            inline_local_variable,
            r"
struct Bar {
    foo: usize
}

fn foo() {
    let bar = Bar { foo: 1 };
    let a<|> = bar.foo;
    let b = a * 10;
    let c = a as usize;
}",
            r"
struct Bar {
    foo: usize
}

fn foo() {
    let bar = Bar { foo: 1 };
    let b = bar.foo * 10;
    let c = bar.foo as usize;
}",
        );
    }

    #[test]
    fn test_try_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() -> Option<usize> {
    let bar = Some(1);
    let a<|> = bar?;
    let b = a * 10;
    let c = a as usize;
    None
}",
            r"
fn foo() -> Option<usize> {
    let bar = Some(1);
    let b = bar? * 10;
    let c = bar? as usize;
    None
}",
        );
    }

    #[test]
    fn test_ref_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let bar = 10;
    let a<|> = &bar;
    let b = a * 10;
}",
            r"
fn foo() {
    let bar = 10;
    let b = &bar * 10;
}",
        );
    }

    #[test]
    fn test_tuple_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = (10, 20);
    let b = a[0];
}",
            r"
fn foo() {
    let b = (10, 20)[0];
}",
        );
    }

    #[test]
    fn test_array_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = [1, 2, 3];
    let b = a.len();
}",
            r"
fn foo() {
    let b = [1, 2, 3].len();
}",
        );
    }

    #[test]
    fn test_paren() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = (10 + 20);
    let b = a * 10;
    let c = a as usize;
}",
            r"
fn foo() {
    let b = (10 + 20) * 10;
    let c = (10 + 20) as usize;
}",
        );
    }

    #[test]
    fn test_path_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let d = 10;
    let a<|> = d;
    let b = a * 10;
    let c = a as usize;
}",
            r"
fn foo() {
    let d = 10;
    let b = d * 10;
    let c = d as usize;
}",
        );
    }

    #[test]
    fn test_block_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = { 10 };
    let b = a * 10;
    let c = a as usize;
}",
            r"
fn foo() {
    let b = { 10 } * 10;
    let c = { 10 } as usize;
}",
        );
    }

    #[test]
    fn test_used_in_different_expr1() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = 10 + 20;
    let b = a * 10;
    let c = (a, 20);
    let d = [a, 10];
    let e = (a);
}",
            r"
fn foo() {
    let b = (10 + 20) * 10;
    let c = (10 + 20, 20);
    let d = [10 + 20, 10];
    let e = (10 + 20);
}",
        );
    }

    #[test]
    fn test_used_in_for_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = vec![10, 20];
    for i in a {}
}",
            r"
fn foo() {
    for i in vec![10, 20] {}
}",
        );
    }

    #[test]
    fn test_used_in_while_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = 1 > 0;
    while a {}
}",
            r"
fn foo() {
    while 1 > 0 {}
}",
        );
    }

    #[test]
    fn test_used_in_break_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = 1 + 1;
    loop {
        break a;
    }
}",
            r"
fn foo() {
    loop {
        break 1 + 1;
    }
}",
        );
    }

    #[test]
    fn test_used_in_return_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = 1 > 0;
    return a;
}",
            r"
fn foo() {
    return 1 > 0;
}",
        );
    }

    #[test]
    fn test_used_in_match_expr() {
        check_assist(
            inline_local_variable,
            r"
fn foo() {
    let a<|> = 1 > 0;
    match a {}
}",
            r"
fn foo() {
    match 1 > 0 {}
}",
        );
    }

    #[test]
    fn inline_field_shorthand() {
        mark::check!(inline_field_shorthand);
        check_assist(
            inline_local_variable,
            r"
struct S { foo: i32}
fn main() {
    let <|>foo = 92;
    S { foo }
}
",
            r"
struct S { foo: i32}
fn main() {
    S { foo: 92 }
}
",
        );
    }

    #[test]
    fn test_not_applicable_if_variable_unused() {
        mark::check!(test_not_applicable_if_variable_unused);
        check_assist_not_applicable(
            inline_local_variable,
            r"
fn foo() {
    let <|>a = 0;
}
            ",
        )
    }

    #[test]
    fn not_applicable_outside_of_bind_pat() {
        mark::check!(not_applicable_outside_of_bind_pat);
        check_assist_not_applicable(
            inline_local_variable,
            r"
fn main() {
    let x = <|>1 + 2;
    x * 4;
}
",
        )
    }
}
