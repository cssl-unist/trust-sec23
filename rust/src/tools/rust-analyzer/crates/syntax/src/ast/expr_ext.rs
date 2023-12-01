//! Various extension methods to ast Expr Nodes, which are hard to code-generate.

use crate::{
    ast::{self, support, AstChildren, AstNode},
    SmolStr,
    SyntaxKind::*,
    SyntaxToken, T,
};

impl ast::AttrsOwner for ast::Expr {}

impl ast::Expr {
    pub fn is_block_like(&self) -> bool {
        match self {
            ast::Expr::IfExpr(_)
            | ast::Expr::LoopExpr(_)
            | ast::Expr::ForExpr(_)
            | ast::Expr::WhileExpr(_)
            | ast::Expr::BlockExpr(_)
            | ast::Expr::MatchExpr(_)
            | ast::Expr::EffectExpr(_) => true,
            _ => false,
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ElseBranch {
    Block(ast::BlockExpr),
    IfExpr(ast::IfExpr),
}

impl ast::IfExpr {
    pub fn then_branch(&self) -> Option<ast::BlockExpr> {
        self.blocks().next()
    }
    pub fn else_branch(&self) -> Option<ElseBranch> {
        let res = match self.blocks().nth(1) {
            Some(block) => ElseBranch::Block(block),
            None => {
                let elif: ast::IfExpr = support::child(self.syntax())?;
                ElseBranch::IfExpr(elif)
            }
        };
        Some(res)
    }

    pub fn blocks(&self) -> AstChildren<ast::BlockExpr> {
        support::children(self.syntax())
    }
}

#[derive(Copy, Clone, Debug, PartialEq, Eq, Hash)]
pub enum PrefixOp {
    /// The `*` operator for dereferencing
    Deref,
    /// The `!` operator for logical inversion
    Not,
    /// The `-` operator for negation
    Neg,
}

impl ast::PrefixExpr {
    pub fn op_kind(&self) -> Option<PrefixOp> {
        match self.op_token()?.kind() {
            T![*] => Some(PrefixOp::Deref),
            T![!] => Some(PrefixOp::Not),
            T![-] => Some(PrefixOp::Neg),
            _ => None,
        }
    }

    pub fn op_token(&self) -> Option<SyntaxToken> {
        self.syntax().first_child_or_token()?.into_token()
    }
}

#[derive(Copy, Clone, Debug, PartialEq, Eq, Hash)]
pub enum BinOp {
    /// The `||` operator for boolean OR
    BooleanOr,
    /// The `&&` operator for boolean AND
    BooleanAnd,
    /// The `==` operator for equality testing
    EqualityTest,
    /// The `!=` operator for equality testing
    NegatedEqualityTest,
    /// The `<=` operator for lesser-equal testing
    LesserEqualTest,
    /// The `>=` operator for greater-equal testing
    GreaterEqualTest,
    /// The `<` operator for comparison
    LesserTest,
    /// The `>` operator for comparison
    GreaterTest,
    /// The `+` operator for addition
    Addition,
    /// The `*` operator for multiplication
    Multiplication,
    /// The `-` operator for subtraction
    Subtraction,
    /// The `/` operator for division
    Division,
    /// The `%` operator for remainder after division
    Remainder,
    /// The `<<` operator for left shift
    LeftShift,
    /// The `>>` operator for right shift
    RightShift,
    /// The `^` operator for bitwise XOR
    BitwiseXor,
    /// The `|` operator for bitwise OR
    BitwiseOr,
    /// The `&` operator for bitwise AND
    BitwiseAnd,
    /// The `=` operator for assignment
    Assignment,
    /// The `+=` operator for assignment after addition
    AddAssign,
    /// The `/=` operator for assignment after division
    DivAssign,
    /// The `*=` operator for assignment after multiplication
    MulAssign,
    /// The `%=` operator for assignment after remainders
    RemAssign,
    /// The `>>=` operator for assignment after shifting right
    ShrAssign,
    /// The `<<=` operator for assignment after shifting left
    ShlAssign,
    /// The `-=` operator for assignment after subtraction
    SubAssign,
    /// The `|=` operator for assignment after bitwise OR
    BitOrAssign,
    /// The `&=` operator for assignment after bitwise AND
    BitAndAssign,
    /// The `^=` operator for assignment after bitwise XOR
    BitXorAssign,
}

impl BinOp {
    pub fn is_assignment(self) -> bool {
        match self {
            BinOp::Assignment
            | BinOp::AddAssign
            | BinOp::DivAssign
            | BinOp::MulAssign
            | BinOp::RemAssign
            | BinOp::ShrAssign
            | BinOp::ShlAssign
            | BinOp::SubAssign
            | BinOp::BitOrAssign
            | BinOp::BitAndAssign
            | BinOp::BitXorAssign => true,
            _ => false,
        }
    }
}

impl ast::BinExpr {
    pub fn op_details(&self) -> Option<(SyntaxToken, BinOp)> {
        self.syntax().children_with_tokens().filter_map(|it| it.into_token()).find_map(|c| {
            let bin_op = match c.kind() {
                T![||] => BinOp::BooleanOr,
                T![&&] => BinOp::BooleanAnd,
                T![==] => BinOp::EqualityTest,
                T![!=] => BinOp::NegatedEqualityTest,
                T![<=] => BinOp::LesserEqualTest,
                T![>=] => BinOp::GreaterEqualTest,
                T![<] => BinOp::LesserTest,
                T![>] => BinOp::GreaterTest,
                T![+] => BinOp::Addition,
                T![*] => BinOp::Multiplication,
                T![-] => BinOp::Subtraction,
                T![/] => BinOp::Division,
                T![%] => BinOp::Remainder,
                T![<<] => BinOp::LeftShift,
                T![>>] => BinOp::RightShift,
                T![^] => BinOp::BitwiseXor,
                T![|] => BinOp::BitwiseOr,
                T![&] => BinOp::BitwiseAnd,
                T![=] => BinOp::Assignment,
                T![+=] => BinOp::AddAssign,
                T![/=] => BinOp::DivAssign,
                T![*=] => BinOp::MulAssign,
                T![%=] => BinOp::RemAssign,
                T![>>=] => BinOp::ShrAssign,
                T![<<=] => BinOp::ShlAssign,
                T![-=] => BinOp::SubAssign,
                T![|=] => BinOp::BitOrAssign,
                T![&=] => BinOp::BitAndAssign,
                T![^=] => BinOp::BitXorAssign,
                _ => return None,
            };
            Some((c, bin_op))
        })
    }

    pub fn op_kind(&self) -> Option<BinOp> {
        self.op_details().map(|t| t.1)
    }

    pub fn op_token(&self) -> Option<SyntaxToken> {
        self.op_details().map(|t| t.0)
    }

    pub fn lhs(&self) -> Option<ast::Expr> {
        support::children(self.syntax()).next()
    }

    pub fn rhs(&self) -> Option<ast::Expr> {
        support::children(self.syntax()).nth(1)
    }

    pub fn sub_exprs(&self) -> (Option<ast::Expr>, Option<ast::Expr>) {
        let mut children = support::children(self.syntax());
        let first = children.next();
        let second = children.next();
        (first, second)
    }
}

#[derive(Copy, Clone, Debug, PartialEq, Eq, Hash)]
pub enum RangeOp {
    /// `..`
    Exclusive,
    /// `..=`
    Inclusive,
}

impl ast::RangeExpr {
    fn op_details(&self) -> Option<(usize, SyntaxToken, RangeOp)> {
        self.syntax().children_with_tokens().enumerate().find_map(|(ix, child)| {
            let token = child.into_token()?;
            let bin_op = match token.kind() {
                T![..] => RangeOp::Exclusive,
                T![..=] => RangeOp::Inclusive,
                _ => return None,
            };
            Some((ix, token, bin_op))
        })
    }

    pub fn op_kind(&self) -> Option<RangeOp> {
        self.op_details().map(|t| t.2)
    }

    pub fn op_token(&self) -> Option<SyntaxToken> {
        self.op_details().map(|t| t.1)
    }

    pub fn start(&self) -> Option<ast::Expr> {
        let op_ix = self.op_details()?.0;
        self.syntax()
            .children_with_tokens()
            .take(op_ix)
            .find_map(|it| ast::Expr::cast(it.into_node()?))
    }

    pub fn end(&self) -> Option<ast::Expr> {
        let op_ix = self.op_details()?.0;
        self.syntax()
            .children_with_tokens()
            .skip(op_ix + 1)
            .find_map(|it| ast::Expr::cast(it.into_node()?))
    }
}

impl ast::IndexExpr {
    pub fn base(&self) -> Option<ast::Expr> {
        support::children(self.syntax()).next()
    }
    pub fn index(&self) -> Option<ast::Expr> {
        support::children(self.syntax()).nth(1)
    }
}

pub enum ArrayExprKind {
    Repeat { initializer: Option<ast::Expr>, repeat: Option<ast::Expr> },
    ElementList(AstChildren<ast::Expr>),
}

impl ast::ArrayExpr {
    pub fn kind(&self) -> ArrayExprKind {
        if self.is_repeat() {
            ArrayExprKind::Repeat {
                initializer: support::children(self.syntax()).next(),
                repeat: support::children(self.syntax()).nth(1),
            }
        } else {
            ArrayExprKind::ElementList(support::children(self.syntax()))
        }
    }

    fn is_repeat(&self) -> bool {
        self.syntax().children_with_tokens().any(|it| it.kind() == T![;])
    }
}

#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub enum LiteralKind {
    String,
    ByteString,
    Char,
    Byte,
    IntNumber { suffix: Option<SmolStr> },
    FloatNumber { suffix: Option<SmolStr> },
    Bool(bool),
}

impl ast::Literal {
    pub fn token(&self) -> SyntaxToken {
        self.syntax()
            .children_with_tokens()
            .find(|e| e.kind() != ATTR && !e.kind().is_trivia())
            .and_then(|e| e.into_token())
            .unwrap()
    }

    fn find_suffix(text: &str, possible_suffixes: &[&str]) -> Option<SmolStr> {
        possible_suffixes
            .iter()
            .find(|&suffix| text.ends_with(suffix))
            .map(|&suffix| SmolStr::new(suffix))
    }

    pub fn kind(&self) -> LiteralKind {
        const INT_SUFFIXES: [&str; 12] = [
            "u64", "u32", "u16", "u8", "usize", "isize", "i64", "i32", "i16", "i8", "u128", "i128",
        ];
        const FLOAT_SUFFIXES: [&str; 2] = ["f32", "f64"];

        let token = self.token();

        match token.kind() {
            INT_NUMBER => {
                // FYI: there was a bug here previously, thus the if statement below is necessary.
                // The lexer treats e.g. `1f64` as an integer literal. See
                // https://github.com/rust-analyzer/rust-analyzer/issues/1592
                // and the comments on the linked PR.

                let text = token.text();
                if let suffix @ Some(_) = Self::find_suffix(&text, &FLOAT_SUFFIXES) {
                    LiteralKind::FloatNumber { suffix }
                } else {
                    LiteralKind::IntNumber { suffix: Self::find_suffix(&text, &INT_SUFFIXES) }
                }
            }
            FLOAT_NUMBER => {
                let text = token.text();
                LiteralKind::FloatNumber { suffix: Self::find_suffix(&text, &FLOAT_SUFFIXES) }
            }
            STRING | RAW_STRING => LiteralKind::String,
            T![true] => LiteralKind::Bool(true),
            T![false] => LiteralKind::Bool(false),
            BYTE_STRING | RAW_BYTE_STRING => LiteralKind::ByteString,
            CHAR => LiteralKind::Char,
            BYTE => LiteralKind::Byte,
            _ => unreachable!(),
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Effect {
    Async(SyntaxToken),
    Unsafe(SyntaxToken),
    Try(SyntaxToken),
    // Very much not an effect, but we stuff it into this node anyway
    Label(ast::Label),
}

impl ast::EffectExpr {
    pub fn effect(&self) -> Effect {
        if let Some(token) = self.async_token() {
            return Effect::Async(token);
        }
        if let Some(token) = self.unsafe_token() {
            return Effect::Unsafe(token);
        }
        if let Some(token) = self.try_token() {
            return Effect::Try(token);
        }
        if let Some(label) = self.label() {
            return Effect::Label(label);
        }
        unreachable!("ast::EffectExpr without Effect")
    }
}

impl ast::BlockExpr {
    /// false if the block is an intrinsic part of the syntax and can't be
    /// replaced with arbitrary expression.
    ///
    /// ```not_rust
    /// fn foo() { not_stand_alone }
    /// const FOO: () = { stand_alone };
    /// ```
    pub fn is_standalone(&self) -> bool {
        let parent = match self.syntax().parent() {
            Some(it) => it,
            None => return true,
        };
        !matches!(parent.kind(), FN | IF_EXPR | WHILE_EXPR | LOOP_EXPR | EFFECT_EXPR)
    }
}

#[test]
fn test_literal_with_attr() {
    let parse = ast::SourceFile::parse(r#"const _: &str = { #[attr] "Hello" };"#);
    let lit = parse.tree().syntax().descendants().find_map(ast::Literal::cast).unwrap();
    assert_eq!(lit.token().text(), r#""Hello""#);
}

impl ast::RecordExprField {
    pub fn parent_record_lit(&self) -> ast::RecordExpr {
        self.syntax().ancestors().find_map(ast::RecordExpr::cast).unwrap()
    }
}
