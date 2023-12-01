use ide_db::RootDatabase;
use syntax::{ast, match_ast, AstNode, SyntaxKind::*, SyntaxToken, TokenAtOffset, T};

use crate::{display::ToNav, FilePosition, NavigationTarget, RangeInfo};

// Feature: Go to Type Definition
//
// Navigates to the type of an identifier.
//
// |===
// | Editor  | Action Name
//
// | VS Code | **Go to Type Definition*
// |===
pub(crate) fn goto_type_definition(
    db: &RootDatabase,
    position: FilePosition,
) -> Option<RangeInfo<Vec<NavigationTarget>>> {
    let sema = hir::Semantics::new(db);

    let file: ast::SourceFile = sema.parse(position.file_id);
    let token: SyntaxToken = pick_best(file.syntax().token_at_offset(position.offset))?;
    let token: SyntaxToken = sema.descend_into_macros(token);

    let (ty, node) = sema.ancestors_with_macros(token.parent()).find_map(|node| {
        let ty = match_ast! {
            match node {
                ast::Expr(it) => sema.type_of_expr(&it)?,
                ast::Pat(it) => sema.type_of_pat(&it)?,
                ast::SelfParam(it) => sema.type_of_self(&it)?,
                _ => return None,
            }
        };

        Some((ty, node))
    })?;

    let adt_def = ty.autoderef(db).filter_map(|ty| ty.as_adt()).last()?;

    let nav = adt_def.to_nav(db);
    Some(RangeInfo::new(node.text_range(), vec![nav]))
}

fn pick_best(tokens: TokenAtOffset<SyntaxToken>) -> Option<SyntaxToken> {
    return tokens.max_by_key(priority);
    fn priority(n: &SyntaxToken) -> usize {
        match n.kind() {
            IDENT | INT_NUMBER | T![self] => 2,
            kind if kind.is_trivia() => 0,
            _ => 1,
        }
    }
}

#[cfg(test)]
mod tests {
    use base_db::FileRange;

    use crate::mock_analysis::MockAnalysis;

    fn check(ra_fixture: &str) {
        let (mock, position) = MockAnalysis::with_files_and_position(ra_fixture);
        let (expected, data) = mock.annotation();
        assert!(data.is_empty());
        let analysis = mock.analysis();

        let mut navs = analysis.goto_type_definition(position).unwrap().unwrap().info;
        assert_eq!(navs.len(), 1);
        let nav = navs.pop().unwrap();
        assert_eq!(expected, FileRange { file_id: nav.file_id, range: nav.focus_or_full_range() });
    }

    #[test]
    fn goto_type_definition_works_simple() {
        check(
            r#"
struct Foo;
     //^^^
fn foo() {
    let f: Foo; f<|>
}
"#,
        );
    }

    #[test]
    fn goto_type_definition_works_simple_ref() {
        check(
            r#"
struct Foo;
     //^^^
fn foo() {
    let f: &Foo; f<|>
}
"#,
        );
    }

    #[test]
    fn goto_type_definition_works_through_macro() {
        check(
            r#"
macro_rules! id { ($($tt:tt)*) => { $($tt)* } }
struct Foo {}
     //^^^
id! {
    fn bar() { let f<|> = Foo {}; }
}
"#,
        );
    }

    #[test]
    fn goto_type_definition_for_param() {
        check(
            r#"
struct Foo;
     //^^^
fn foo(<|>f: Foo) {}
"#,
        );
    }

    #[test]
    fn goto_type_definition_for_tuple_field() {
        check(
            r#"
struct Foo;
     //^^^
struct Bar(Foo);
fn foo() {
    let bar = Bar(Foo);
    bar.<|>0;
}
"#,
        );
    }

    #[test]
    fn goto_def_for_self_param() {
        check(
            r#"
struct Foo;
     //^^^
impl Foo {
    fn f(&self<|>) {}
}
"#,
        )
    }
}
