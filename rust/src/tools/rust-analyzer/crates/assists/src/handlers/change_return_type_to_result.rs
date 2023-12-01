use std::iter;

use syntax::{
    ast::{self, make, BlockExpr, Expr, LoopBodyOwner},
    AstNode, SyntaxNode,
};
use test_utils::mark;

use crate::{AssistContext, AssistId, AssistKind, Assists};

// Assist: change_return_type_to_result
//
// Change the function's return type to Result.
//
// ```
// fn foo() -> i32<|> { 42i32 }
// ```
// ->
// ```
// fn foo() -> Result<i32, ${0:_}> { Ok(42i32) }
// ```
pub(crate) fn change_return_type_to_result(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let ret_type = ctx.find_node_at_offset::<ast::RetType>()?;
    // FIXME: extend to lambdas as well
    let fn_def = ret_type.syntax().parent().and_then(ast::Fn::cast)?;

    let type_ref = &ret_type.ty()?;
    let ret_type_str = type_ref.syntax().text().to_string();
    let first_part_ret_type = ret_type_str.splitn(2, '<').next();
    if let Some(ret_type_first_part) = first_part_ret_type {
        if ret_type_first_part.ends_with("Result") {
            mark::hit!(change_return_type_to_result_simple_return_type_already_result);
            return None;
        }
    }

    let block_expr = &fn_def.body()?;

    acc.add(
        AssistId("change_return_type_to_result", AssistKind::RefactorRewrite),
        "Wrap return type in Result",
        type_ref.syntax().text_range(),
        |builder| {
            let mut tail_return_expr_collector = TailReturnCollector::new();
            tail_return_expr_collector.collect_jump_exprs(block_expr, false);
            tail_return_expr_collector.collect_tail_exprs(block_expr);

            for ret_expr_arg in tail_return_expr_collector.exprs_to_wrap {
                let ok_wrapped = make::expr_call(
                    make::expr_path(make::path_unqualified(make::path_segment(make::name_ref(
                        "Ok",
                    )))),
                    make::arg_list(iter::once(ret_expr_arg.clone())),
                );
                builder.replace_ast(ret_expr_arg, ok_wrapped);
            }

            match ctx.config.snippet_cap {
                Some(cap) => {
                    let snippet = format!("Result<{}, ${{0:_}}>", type_ref);
                    builder.replace_snippet(cap, type_ref.syntax().text_range(), snippet)
                }
                None => builder
                    .replace(type_ref.syntax().text_range(), format!("Result<{}, _>", type_ref)),
            }
        },
    )
}

struct TailReturnCollector {
    exprs_to_wrap: Vec<ast::Expr>,
}

impl TailReturnCollector {
    fn new() -> Self {
        Self { exprs_to_wrap: vec![] }
    }
    /// Collect all`return` expression
    fn collect_jump_exprs(&mut self, block_expr: &BlockExpr, collect_break: bool) {
        let statements = block_expr.statements();
        for stmt in statements {
            let expr = match &stmt {
                ast::Stmt::ExprStmt(stmt) => stmt.expr(),
                ast::Stmt::LetStmt(stmt) => stmt.initializer(),
                ast::Stmt::Item(_) => continue,
            };
            if let Some(expr) = &expr {
                self.handle_exprs(expr, collect_break);
            }
        }

        // Browse tail expressions for each block
        if let Some(expr) = block_expr.expr() {
            if let Some(last_exprs) = get_tail_expr_from_block(&expr) {
                for last_expr in last_exprs {
                    let last_expr = match last_expr {
                        NodeType::Node(expr) => expr,
                        NodeType::Leaf(expr) => expr.syntax().clone(),
                    };

                    if let Some(last_expr) = Expr::cast(last_expr.clone()) {
                        self.handle_exprs(&last_expr, collect_break);
                    } else if let Some(expr_stmt) = ast::Stmt::cast(last_expr) {
                        let expr_stmt = match &expr_stmt {
                            ast::Stmt::ExprStmt(stmt) => stmt.expr(),
                            ast::Stmt::LetStmt(stmt) => stmt.initializer(),
                            ast::Stmt::Item(_) => None,
                        };
                        if let Some(expr) = &expr_stmt {
                            self.handle_exprs(expr, collect_break);
                        }
                    }
                }
            }
        }
    }

    fn handle_exprs(&mut self, expr: &Expr, collect_break: bool) {
        match expr {
            Expr::BlockExpr(block_expr) => {
                self.collect_jump_exprs(&block_expr, collect_break);
            }
            Expr::ReturnExpr(ret_expr) => {
                if let Some(ret_expr_arg) = &ret_expr.expr() {
                    self.exprs_to_wrap.push(ret_expr_arg.clone());
                }
            }
            Expr::BreakExpr(break_expr) if collect_break => {
                if let Some(break_expr_arg) = &break_expr.expr() {
                    self.exprs_to_wrap.push(break_expr_arg.clone());
                }
            }
            Expr::IfExpr(if_expr) => {
                for block in if_expr.blocks() {
                    self.collect_jump_exprs(&block, collect_break);
                }
            }
            Expr::LoopExpr(loop_expr) => {
                if let Some(block_expr) = loop_expr.loop_body() {
                    self.collect_jump_exprs(&block_expr, collect_break);
                }
            }
            Expr::ForExpr(for_expr) => {
                if let Some(block_expr) = for_expr.loop_body() {
                    self.collect_jump_exprs(&block_expr, collect_break);
                }
            }
            Expr::WhileExpr(while_expr) => {
                if let Some(block_expr) = while_expr.loop_body() {
                    self.collect_jump_exprs(&block_expr, collect_break);
                }
            }
            Expr::MatchExpr(match_expr) => {
                if let Some(arm_list) = match_expr.match_arm_list() {
                    arm_list.arms().filter_map(|match_arm| match_arm.expr()).for_each(|expr| {
                        self.handle_exprs(&expr, collect_break);
                    });
                }
            }
            _ => {}
        }
    }

    fn collect_tail_exprs(&mut self, block: &BlockExpr) {
        if let Some(expr) = block.expr() {
            self.handle_exprs(&expr, true);
            self.fetch_tail_exprs(&expr);
        }
    }

    fn fetch_tail_exprs(&mut self, expr: &Expr) {
        if let Some(exprs) = get_tail_expr_from_block(expr) {
            for node_type in &exprs {
                match node_type {
                    NodeType::Leaf(expr) => {
                        self.exprs_to_wrap.push(expr.clone());
                    }
                    NodeType::Node(expr) => {
                        if let Some(last_expr) = Expr::cast(expr.clone()) {
                            self.fetch_tail_exprs(&last_expr);
                        }
                    }
                }
            }
        }
    }
}

#[derive(Debug)]
enum NodeType {
    Leaf(ast::Expr),
    Node(SyntaxNode),
}

/// Get a tail expression inside a block
fn get_tail_expr_from_block(expr: &Expr) -> Option<Vec<NodeType>> {
    match expr {
        Expr::IfExpr(if_expr) => {
            let mut nodes = vec![];
            for block in if_expr.blocks() {
                if let Some(block_expr) = block.expr() {
                    if let Some(tail_exprs) = get_tail_expr_from_block(&block_expr) {
                        nodes.extend(tail_exprs);
                    }
                } else if let Some(last_expr) = block.syntax().last_child() {
                    nodes.push(NodeType::Node(last_expr));
                } else {
                    nodes.push(NodeType::Node(block.syntax().clone()));
                }
            }
            Some(nodes)
        }
        Expr::LoopExpr(loop_expr) => {
            loop_expr.syntax().last_child().map(|lc| vec![NodeType::Node(lc)])
        }
        Expr::ForExpr(for_expr) => {
            for_expr.syntax().last_child().map(|lc| vec![NodeType::Node(lc)])
        }
        Expr::WhileExpr(while_expr) => {
            while_expr.syntax().last_child().map(|lc| vec![NodeType::Node(lc)])
        }
        Expr::BlockExpr(block_expr) => {
            block_expr.expr().map(|lc| vec![NodeType::Node(lc.syntax().clone())])
        }
        Expr::MatchExpr(match_expr) => {
            let arm_list = match_expr.match_arm_list()?;
            let arms: Vec<NodeType> = arm_list
                .arms()
                .filter_map(|match_arm| match_arm.expr())
                .map(|expr| match expr {
                    Expr::ReturnExpr(ret_expr) => NodeType::Node(ret_expr.syntax().clone()),
                    Expr::BreakExpr(break_expr) => NodeType::Node(break_expr.syntax().clone()),
                    _ => match expr.syntax().last_child() {
                        Some(last_expr) => NodeType::Node(last_expr),
                        None => NodeType::Node(expr.syntax().clone()),
                    },
                })
                .collect();

            Some(arms)
        }
        Expr::BreakExpr(expr) => expr.expr().map(|e| vec![NodeType::Leaf(e)]),
        Expr::ReturnExpr(ret_expr) => Some(vec![NodeType::Node(ret_expr.syntax().clone())]),

        Expr::CallExpr(_)
        | Expr::Literal(_)
        | Expr::TupleExpr(_)
        | Expr::ArrayExpr(_)
        | Expr::ParenExpr(_)
        | Expr::PathExpr(_)
        | Expr::RecordExpr(_)
        | Expr::IndexExpr(_)
        | Expr::MethodCallExpr(_)
        | Expr::AwaitExpr(_)
        | Expr::CastExpr(_)
        | Expr::RefExpr(_)
        | Expr::PrefixExpr(_)
        | Expr::RangeExpr(_)
        | Expr::BinExpr(_)
        | Expr::MacroCall(_)
        | Expr::BoxExpr(_) => Some(vec![NodeType::Leaf(expr.clone())]),
        _ => None,
    }
}

#[cfg(test)]
mod tests {
    use crate::tests::{check_assist, check_assist_not_applicable};

    use super::*;

    #[test]
    fn change_return_type_to_result_simple() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i3<|>2 {
                let test = "test";
                return 42i32;
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let test = "test";
                return Ok(42i32);
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_return_type() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let test = "test";
                return 42i32;
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let test = "test";
                return Ok(42i32);
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_return_type_bad_cursor() {
        check_assist_not_applicable(
            change_return_type_to_result,
            r#"fn foo() -> i32 {
                let test = "test";<|>
                return 42i32;
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_return_type_already_result_std() {
        check_assist_not_applicable(
            change_return_type_to_result,
            r#"fn foo() -> std::result::Result<i32<|>, String> {
                let test = "test";
                return 42i32;
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_return_type_already_result() {
        mark::check!(change_return_type_to_result_simple_return_type_already_result);
        check_assist_not_applicable(
            change_return_type_to_result,
            r#"fn foo() -> Result<i32<|>, String> {
                let test = "test";
                return 42i32;
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_cursor() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> <|>i32 {
                let test = "test";
                return 42i32;
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let test = "test";
                return Ok(42i32);
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_tail() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -><|> i32 {
                let test = "test";
                42i32
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let test = "test";
                Ok(42i32)
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_tail_only() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                42i32
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                Ok(42i32)
            }"#,
        );
    }
    #[test]
    fn change_return_type_to_result_simple_with_tail_block_like() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                if true {
                    42i32
                } else {
                    24i32
                }
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                if true {
                    Ok(42i32)
                } else {
                    Ok(24i32)
                }
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_nested_if() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                if true {
                    if false {
                        1
                    } else {
                        2
                    }
                } else {
                    24i32
                }
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                if true {
                    if false {
                        Ok(1)
                    } else {
                        Ok(2)
                    }
                } else {
                    Ok(24i32)
                }
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_await() {
        check_assist(
            change_return_type_to_result,
            r#"async fn foo() -> i<|>32 {
                if true {
                    if false {
                        1.await
                    } else {
                        2.await
                    }
                } else {
                    24i32.await
                }
            }"#,
            r#"async fn foo() -> Result<i32, ${0:_}> {
                if true {
                    if false {
                        Ok(1.await)
                    } else {
                        Ok(2.await)
                    }
                } else {
                    Ok(24i32.await)
                }
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_array() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> [i32;<|> 3] {
                [1, 2, 3]
            }"#,
            r#"fn foo() -> Result<[i32; 3], ${0:_}> {
                Ok([1, 2, 3])
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_cast() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -<|>> i32 {
                if true {
                    if false {
                        1 as i32
                    } else {
                        2 as i32
                    }
                } else {
                    24 as i32
                }
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                if true {
                    if false {
                        Ok(1 as i32)
                    } else {
                        Ok(2 as i32)
                    }
                } else {
                    Ok(24 as i32)
                }
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_tail_block_like_match() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let my_var = 5;
                match my_var {
                    5 => 42i32,
                    _ => 24i32,
                }
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let my_var = 5;
                match my_var {
                    5 => Ok(42i32),
                    _ => Ok(24i32),
                }
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_loop_with_tail() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let my_var = 5;
                loop {
                    println!("test");
                    5
                }

                my_var
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let my_var = 5;
                loop {
                    println!("test");
                    5
                }

                Ok(my_var)
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_loop_in_let_stmt() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let my_var = let x = loop {
                    break 1;
                };

                my_var
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let my_var = let x = loop {
                    break 1;
                };

                Ok(my_var)
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_tail_block_like_match_return_expr() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let my_var = 5;
                let res = match my_var {
                    5 => 42i32,
                    _ => return 24i32,
                };

                res
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let my_var = 5;
                let res = match my_var {
                    5 => 42i32,
                    _ => return Ok(24i32),
                };

                Ok(res)
            }"#,
        );

        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let my_var = 5;
                let res = if my_var == 5 {
                    42i32
                } else {
                    return 24i32;
                };

                res
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let my_var = 5;
                let res = if my_var == 5 {
                    42i32
                } else {
                    return Ok(24i32);
                };

                Ok(res)
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_tail_block_like_match_deeper() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let my_var = 5;
                match my_var {
                    5 => {
                        if true {
                            42i32
                        } else {
                            25i32
                        }
                    },
                    _ => {
                        let test = "test";
                        if test == "test" {
                            return bar();
                        }
                        53i32
                    },
                }
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let my_var = 5;
                match my_var {
                    5 => {
                        if true {
                            Ok(42i32)
                        } else {
                            Ok(25i32)
                        }
                    },
                    _ => {
                        let test = "test";
                        if test == "test" {
                            return Ok(bar());
                        }
                        Ok(53i32)
                    },
                }
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_tail_block_like_early_return() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i<|>32 {
                let test = "test";
                if test == "test" {
                    return 24i32;
                }
                53i32
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let test = "test";
                if test == "test" {
                    return Ok(24i32);
                }
                Ok(53i32)
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_closure() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo(the_field: u32) -><|> u32 {
                let true_closure = || {
                    return true;
                };
                if the_field < 5 {
                    let mut i = 0;


                    if true_closure() {
                        return 99;
                    } else {
                        return 0;
                    }
                }

                the_field
            }"#,
            r#"fn foo(the_field: u32) -> Result<u32, ${0:_}> {
                let true_closure = || {
                    return true;
                };
                if the_field < 5 {
                    let mut i = 0;


                    if true_closure() {
                        return Ok(99);
                    } else {
                        return Ok(0);
                    }
                }

                Ok(the_field)
            }"#,
        );

        check_assist(
            change_return_type_to_result,
            r#"fn foo(the_field: u32) -> u32<|> {
                let true_closure = || {
                    return true;
                };
                if the_field < 5 {
                    let mut i = 0;


                    if true_closure() {
                        return 99;
                    } else {
                        return 0;
                    }
                }
                let t = None;

                t.unwrap_or_else(|| the_field)
            }"#,
            r#"fn foo(the_field: u32) -> Result<u32, ${0:_}> {
                let true_closure = || {
                    return true;
                };
                if the_field < 5 {
                    let mut i = 0;


                    if true_closure() {
                        return Ok(99);
                    } else {
                        return Ok(0);
                    }
                }
                let t = None;

                Ok(t.unwrap_or_else(|| the_field))
            }"#,
        );
    }

    #[test]
    fn change_return_type_to_result_simple_with_weird_forms() {
        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let test = "test";
                if test == "test" {
                    return 24i32;
                }
                let mut i = 0;
                loop {
                    if i == 1 {
                        break 55;
                    }
                    i += 1;
                }
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let test = "test";
                if test == "test" {
                    return Ok(24i32);
                }
                let mut i = 0;
                loop {
                    if i == 1 {
                        break Ok(55);
                    }
                    i += 1;
                }
            }"#,
        );

        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i32<|> {
                let test = "test";
                if test == "test" {
                    return 24i32;
                }
                let mut i = 0;
                loop {
                    loop {
                        if i == 1 {
                            break 55;
                        }
                        i += 1;
                    }
                }
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let test = "test";
                if test == "test" {
                    return Ok(24i32);
                }
                let mut i = 0;
                loop {
                    loop {
                        if i == 1 {
                            break Ok(55);
                        }
                        i += 1;
                    }
                }
            }"#,
        );

        check_assist(
            change_return_type_to_result,
            r#"fn foo() -> i3<|>2 {
                let test = "test";
                let other = 5;
                if test == "test" {
                    let res = match other {
                        5 => 43,
                        _ => return 56,
                    };
                }
                let mut i = 0;
                loop {
                    loop {
                        if i == 1 {
                            break 55;
                        }
                        i += 1;
                    }
                }
            }"#,
            r#"fn foo() -> Result<i32, ${0:_}> {
                let test = "test";
                let other = 5;
                if test == "test" {
                    let res = match other {
                        5 => 43,
                        _ => return Ok(56),
                    };
                }
                let mut i = 0;
                loop {
                    loop {
                        if i == 1 {
                            break Ok(55);
                        }
                        i += 1;
                    }
                }
            }"#,
        );

        check_assist(
            change_return_type_to_result,
            r#"fn foo(the_field: u32) -> u32<|> {
                if the_field < 5 {
                    let mut i = 0;
                    loop {
                        if i > 5 {
                            return 55u32;
                        }
                        i += 3;
                    }

                    match i {
                        5 => return 99,
                        _ => return 0,
                    };
                }

                the_field
            }"#,
            r#"fn foo(the_field: u32) -> Result<u32, ${0:_}> {
                if the_field < 5 {
                    let mut i = 0;
                    loop {
                        if i > 5 {
                            return Ok(55u32);
                        }
                        i += 3;
                    }

                    match i {
                        5 => return Ok(99),
                        _ => return Ok(0),
                    };
                }

                Ok(the_field)
            }"#,
        );

        check_assist(
            change_return_type_to_result,
            r#"fn foo(the_field: u32) -> u3<|>2 {
                if the_field < 5 {
                    let mut i = 0;

                    match i {
                        5 => return 99,
                        _ => return 0,
                    }
                }

                the_field
            }"#,
            r#"fn foo(the_field: u32) -> Result<u32, ${0:_}> {
                if the_field < 5 {
                    let mut i = 0;

                    match i {
                        5 => return Ok(99),
                        _ => return Ok(0),
                    }
                }

                Ok(the_field)
            }"#,
        );

        check_assist(
            change_return_type_to_result,
            r#"fn foo(the_field: u32) -> u32<|> {
                if the_field < 5 {
                    let mut i = 0;

                    if i == 5 {
                        return 99
                    } else {
                        return 0
                    }
                }

                the_field
            }"#,
            r#"fn foo(the_field: u32) -> Result<u32, ${0:_}> {
                if the_field < 5 {
                    let mut i = 0;

                    if i == 5 {
                        return Ok(99)
                    } else {
                        return Ok(0)
                    }
                }

                Ok(the_field)
            }"#,
        );

        check_assist(
            change_return_type_to_result,
            r#"fn foo(the_field: u32) -> <|>u32 {
                if the_field < 5 {
                    let mut i = 0;

                    if i == 5 {
                        return 99;
                    } else {
                        return 0;
                    }
                }

                the_field
            }"#,
            r#"fn foo(the_field: u32) -> Result<u32, ${0:_}> {
                if the_field < 5 {
                    let mut i = 0;

                    if i == 5 {
                        return Ok(99);
                    } else {
                        return Ok(0);
                    }
                }

                Ok(the_field)
            }"#,
        );
    }
}
