use syntax::{algo::non_trivia_sibling, Direction, T};

use crate::{AssistContext, AssistId, AssistKind, Assists};

// Assist: flip_comma
//
// Flips two comma-separated items.
//
// ```
// fn main() {
//     ((1, 2),<|> (3, 4));
// }
// ```
// ->
// ```
// fn main() {
//     ((3, 4), (1, 2));
// }
// ```
pub(crate) fn flip_comma(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let comma = ctx.find_token_at_offset(T![,])?;
    let prev = non_trivia_sibling(comma.clone().into(), Direction::Prev)?;
    let next = non_trivia_sibling(comma.clone().into(), Direction::Next)?;

    // Don't apply a "flip" in case of a last comma
    // that typically comes before punctuation
    if next.kind().is_punct() {
        return None;
    }

    acc.add(
        AssistId("flip_comma", AssistKind::RefactorRewrite),
        "Flip comma",
        comma.text_range(),
        |edit| {
            edit.replace(prev.text_range(), next.to_string());
            edit.replace(next.text_range(), prev.to_string());
        },
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    use crate::tests::{check_assist, check_assist_target};

    #[test]
    fn flip_comma_works_for_function_parameters() {
        check_assist(
            flip_comma,
            "fn foo(x: i32,<|> y: Result<(), ()>) {}",
            "fn foo(y: Result<(), ()>, x: i32) {}",
        )
    }

    #[test]
    fn flip_comma_target() {
        check_assist_target(flip_comma, "fn foo(x: i32,<|> y: Result<(), ()>) {}", ",")
    }

    #[test]
    #[should_panic]
    fn flip_comma_before_punct() {
        // See https://github.com/rust-analyzer/rust-analyzer/issues/1619
        // "Flip comma" assist shouldn't be applicable to the last comma in enum or struct
        // declaration body.
        check_assist_target(
            flip_comma,
            "pub enum Test { \
             A,<|> \
             }",
            ",",
        );

        check_assist_target(
            flip_comma,
            "pub struct Test { \
             foo: usize,<|> \
             }",
            ",",
        );
    }
}
