use syntax::{
    ast::{self, AstNode},
    SourceFile, SyntaxKind, TextSize, T,
};
use test_utils::mark;

// Feature: Matching Brace
//
// If the cursor is on any brace (`<>(){}[]||`) which is a part of a brace-pair,
// moves cursor to the matching brace. It uses the actual parser to determine
// braces, so it won't confuse generics with comparisons.
//
// |===
// | Editor  | Action Name
//
// | VS Code | **Rust Analyzer: Find matching brace**
// |===
pub fn matching_brace(file: &SourceFile, offset: TextSize) -> Option<TextSize> {
    const BRACES: &[SyntaxKind] =
        &[T!['{'], T!['}'], T!['['], T![']'], T!['('], T![')'], T![<], T![>], T![|], T![|]];
    let (brace_token, brace_idx) = file
        .syntax()
        .token_at_offset(offset)
        .filter_map(|node| {
            let idx = BRACES.iter().position(|&brace| brace == node.kind())?;
            Some((node, idx))
        })
        .next()?;
    let parent = brace_token.parent();
    if brace_token.kind() == T![|] && !ast::ParamList::can_cast(parent.kind()) {
        mark::hit!(pipes_not_braces);
        return None;
    }
    let matching_kind = BRACES[brace_idx ^ 1];
    let matching_node = parent
        .children_with_tokens()
        .filter_map(|it| it.into_token())
        .find(|node| node.kind() == matching_kind && node != &brace_token)?;
    Some(matching_node.text_range().start())
}

#[cfg(test)]
mod tests {
    use test_utils::{add_cursor, assert_eq_text, extract_offset};

    use super::*;

    #[test]
    fn test_matching_brace() {
        fn do_check(before: &str, after: &str) {
            let (pos, before) = extract_offset(before);
            let parse = SourceFile::parse(&before);
            let new_pos = match matching_brace(&parse.tree(), pos) {
                None => pos,
                Some(pos) => pos,
            };
            let actual = add_cursor(&before, new_pos);
            assert_eq_text!(after, &actual);
        }

        do_check("struct Foo { a: i32, }<|>", "struct Foo <|>{ a: i32, }");
        do_check("fn main() { |x: i32|<|> x * 2;}", "fn main() { <|>|x: i32| x * 2;}");
        do_check("fn main() { <|>|x: i32| x * 2;}", "fn main() { |x: i32<|>| x * 2;}");

        {
            mark::check!(pipes_not_braces);
            do_check(
                "fn main() { match 92 { 1 | 2 |<|> 3 => 92 } }",
                "fn main() { match 92 { 1 | 2 |<|> 3 => 92 } }",
            );
        }
    }
}
