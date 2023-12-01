use std::iter::successors;

use syntax::{ast, AstNode, T};

use crate::{AssistContext, AssistId, AssistKind, Assists};

// Assist: split_import
//
// Wraps the tail of import into braces.
//
// ```
// use std::<|>collections::HashMap;
// ```
// ->
// ```
// use std::{collections::HashMap};
// ```
pub(crate) fn split_import(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let colon_colon = ctx.find_token_at_offset(T![::])?;
    let path = ast::Path::cast(colon_colon.parent())?.qualifier()?;
    let top_path = successors(Some(path.clone()), |it| it.parent_path()).last()?;

    let use_tree = top_path.syntax().ancestors().find_map(ast::UseTree::cast)?;

    let new_tree = use_tree.split_prefix(&path);
    if new_tree == use_tree {
        return None;
    }

    let target = colon_colon.text_range();
    acc.add(AssistId("split_import", AssistKind::RefactorRewrite), "Split import", target, |edit| {
        edit.replace_ast(use_tree, new_tree);
    })
}

#[cfg(test)]
mod tests {
    use crate::tests::{check_assist, check_assist_not_applicable, check_assist_target};

    use super::*;

    #[test]
    fn test_split_import() {
        check_assist(
            split_import,
            "use crate::<|>db::RootDatabase;",
            "use crate::{db::RootDatabase};",
        )
    }

    #[test]
    fn split_import_works_with_trees() {
        check_assist(
            split_import,
            "use crate:<|>:db::{RootDatabase, FileSymbol}",
            "use crate::{db::{RootDatabase, FileSymbol}}",
        )
    }

    #[test]
    fn split_import_target() {
        check_assist_target(split_import, "use crate::<|>db::{RootDatabase, FileSymbol}", "::");
    }

    #[test]
    fn issue4044() {
        check_assist_not_applicable(split_import, "use crate::<|>:::self;")
    }

    #[test]
    fn test_empty_use() {
        check_assist_not_applicable(
            split_import,
            r"
use std::<|>
fn main() {}",
        );
    }
}
