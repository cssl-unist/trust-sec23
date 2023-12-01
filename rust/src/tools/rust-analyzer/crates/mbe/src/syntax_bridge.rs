//! FIXME: write short doc here

use parser::{FragmentKind, ParseError, TreeSink};
use rustc_hash::FxHashMap;
use syntax::{
    ast::{self, make::tokens::doc_comment},
    tokenize, AstToken, Parse, SmolStr, SyntaxKind,
    SyntaxKind::*,
    SyntaxNode, SyntaxToken, SyntaxTreeBuilder, TextRange, TextSize, Token as RawToken, T,
};
use tt::buffer::{Cursor, TokenBuffer};

use crate::subtree_source::SubtreeTokenSource;
use crate::ExpandError;

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum TokenTextRange {
    Token(TextRange),
    Delimiter(TextRange, TextRange),
}

impl TokenTextRange {
    pub fn by_kind(self, kind: SyntaxKind) -> Option<TextRange> {
        match self {
            TokenTextRange::Token(it) => Some(it),
            TokenTextRange::Delimiter(open, close) => match kind {
                T!['{'] | T!['('] | T!['['] => Some(open),
                T!['}'] | T![')'] | T![']'] => Some(close),
                _ => None,
            },
        }
    }
}

/// Maps `tt::TokenId` to the relative range of the original token.
#[derive(Debug, PartialEq, Eq, Clone, Default)]
pub struct TokenMap {
    /// Maps `tt::TokenId` to the *relative* source range.
    entries: Vec<(tt::TokenId, TokenTextRange)>,
}

/// Convert the syntax tree (what user has written) to a `TokenTree` (what macro
/// will consume).
pub fn ast_to_token_tree(ast: &impl ast::AstNode) -> Option<(tt::Subtree, TokenMap)> {
    syntax_node_to_token_tree(ast.syntax())
}

/// Convert the syntax node to a `TokenTree` (what macro
/// will consume).
pub fn syntax_node_to_token_tree(node: &SyntaxNode) -> Option<(tt::Subtree, TokenMap)> {
    let global_offset = node.text_range().start();
    let mut c = Convertor::new(node, global_offset);
    let subtree = c.go()?;
    Some((subtree, c.id_alloc.map))
}

// The following items are what `rustc` macro can be parsed into :
// link: https://github.com/rust-lang/rust/blob/9ebf47851a357faa4cd97f4b1dc7835f6376e639/src/libsyntax/ext/expand.rs#L141
// * Expr(P<ast::Expr>)                     -> token_tree_to_expr
// * Pat(P<ast::Pat>)                       -> token_tree_to_pat
// * Ty(P<ast::Ty>)                         -> token_tree_to_ty
// * Stmts(SmallVec<[ast::Stmt; 1]>)        -> token_tree_to_stmts
// * Items(SmallVec<[P<ast::Item>; 1]>)     -> token_tree_to_items
//
// * TraitItems(SmallVec<[ast::TraitItem; 1]>)
// * AssocItems(SmallVec<[ast::AssocItem; 1]>)
// * ForeignItems(SmallVec<[ast::ForeignItem; 1]>

pub fn token_tree_to_syntax_node(
    tt: &tt::Subtree,
    fragment_kind: FragmentKind,
) -> Result<(Parse<SyntaxNode>, TokenMap), ExpandError> {
    let tmp;
    let tokens = match tt {
        tt::Subtree { delimiter: None, token_trees } => token_trees.as_slice(),
        _ => {
            tmp = [tt.clone().into()];
            &tmp[..]
        }
    };
    let buffer = TokenBuffer::new(&tokens);
    let mut token_source = SubtreeTokenSource::new(&buffer);
    let mut tree_sink = TtTreeSink::new(buffer.begin());
    parser::parse_fragment(&mut token_source, &mut tree_sink, fragment_kind);
    if tree_sink.roots.len() != 1 {
        return Err(ExpandError::ConversionError);
    }
    //FIXME: would be cool to report errors
    let (parse, range_map) = tree_sink.finish();
    Ok((parse, range_map))
}

/// Convert a string to a `TokenTree`
pub fn parse_to_token_tree(text: &str) -> Option<(tt::Subtree, TokenMap)> {
    let (tokens, errors) = tokenize(text);
    if !errors.is_empty() {
        return None;
    }

    let mut conv = RawConvertor {
        text,
        offset: TextSize::default(),
        inner: tokens.iter(),
        id_alloc: TokenIdAlloc {
            map: Default::default(),
            global_offset: TextSize::default(),
            next_id: 0,
        },
    };

    let subtree = conv.go()?;
    Some((subtree, conv.id_alloc.map))
}

impl TokenMap {
    pub fn token_by_range(&self, relative_range: TextRange) -> Option<tt::TokenId> {
        let &(token_id, _) = self.entries.iter().find(|(_, range)| match range {
            TokenTextRange::Token(it) => *it == relative_range,
            TokenTextRange::Delimiter(open, close) => {
                *open == relative_range || *close == relative_range
            }
        })?;
        Some(token_id)
    }

    pub fn range_by_token(&self, token_id: tt::TokenId) -> Option<TokenTextRange> {
        let &(_, range) = self.entries.iter().find(|(tid, _)| *tid == token_id)?;
        Some(range)
    }

    fn insert(&mut self, token_id: tt::TokenId, relative_range: TextRange) {
        self.entries.push((token_id, TokenTextRange::Token(relative_range)));
    }

    fn insert_delim(
        &mut self,
        token_id: tt::TokenId,
        open_relative_range: TextRange,
        close_relative_range: TextRange,
    ) -> usize {
        let res = self.entries.len();
        self.entries
            .push((token_id, TokenTextRange::Delimiter(open_relative_range, close_relative_range)));
        res
    }

    fn update_close_delim(&mut self, idx: usize, close_relative_range: TextRange) {
        let (_, token_text_range) = &mut self.entries[idx];
        if let TokenTextRange::Delimiter(dim, _) = token_text_range {
            *token_text_range = TokenTextRange::Delimiter(*dim, close_relative_range);
        }
    }

    fn remove_delim(&mut self, idx: usize) {
        // FIXME: This could be accidently quadratic
        self.entries.remove(idx);
    }
}

/// Returns the textual content of a doc comment block as a quoted string
/// That is, strips leading `///` (or `/**`, etc)
/// and strips the ending `*/`
/// And then quote the string, which is needed to convert to `tt::Literal`
fn doc_comment_text(comment: &ast::Comment) -> SmolStr {
    let prefix_len = comment.prefix().len();
    let mut text = &comment.text()[prefix_len..];

    // Remove ending "*/"
    if comment.kind().shape == ast::CommentShape::Block {
        text = &text[0..text.len() - 2];
    }

    // Quote the string
    // Note that `tt::Literal` expect an escaped string
    let text = format!("{:?}", text.escape_default().to_string());
    text.into()
}

fn convert_doc_comment(token: &syntax::SyntaxToken) -> Option<Vec<tt::TokenTree>> {
    let comment = ast::Comment::cast(token.clone())?;
    let doc = comment.kind().doc?;

    // Make `doc="\" Comments\""
    let mut meta_tkns = Vec::new();
    meta_tkns.push(mk_ident("doc"));
    meta_tkns.push(mk_punct('='));
    meta_tkns.push(mk_doc_literal(&comment));

    // Make `#![]`
    let mut token_trees = Vec::new();
    token_trees.push(mk_punct('#'));
    if let ast::CommentPlacement::Inner = doc {
        token_trees.push(mk_punct('!'));
    }
    token_trees.push(tt::TokenTree::from(tt::Subtree {
        delimiter: Some(tt::Delimiter {
            kind: tt::DelimiterKind::Bracket,
            id: tt::TokenId::unspecified(),
        }),
        token_trees: meta_tkns,
    }));

    return Some(token_trees);

    // Helper functions
    fn mk_ident(s: &str) -> tt::TokenTree {
        tt::TokenTree::from(tt::Leaf::from(tt::Ident {
            text: s.into(),
            id: tt::TokenId::unspecified(),
        }))
    }

    fn mk_punct(c: char) -> tt::TokenTree {
        tt::TokenTree::from(tt::Leaf::from(tt::Punct {
            char: c,
            spacing: tt::Spacing::Alone,
            id: tt::TokenId::unspecified(),
        }))
    }

    fn mk_doc_literal(comment: &ast::Comment) -> tt::TokenTree {
        let lit = tt::Literal { text: doc_comment_text(comment), id: tt::TokenId::unspecified() };

        tt::TokenTree::from(tt::Leaf::from(lit))
    }
}

struct TokenIdAlloc {
    map: TokenMap,
    global_offset: TextSize,
    next_id: u32,
}

impl TokenIdAlloc {
    fn alloc(&mut self, absolute_range: TextRange) -> tt::TokenId {
        let relative_range = absolute_range - self.global_offset;
        let token_id = tt::TokenId(self.next_id);
        self.next_id += 1;
        self.map.insert(token_id, relative_range);
        token_id
    }

    fn open_delim(&mut self, open_abs_range: TextRange) -> (tt::TokenId, usize) {
        let token_id = tt::TokenId(self.next_id);
        self.next_id += 1;
        let idx = self.map.insert_delim(
            token_id,
            open_abs_range - self.global_offset,
            open_abs_range - self.global_offset,
        );
        (token_id, idx)
    }

    fn close_delim(&mut self, idx: usize, close_abs_range: Option<TextRange>) {
        match close_abs_range {
            None => {
                self.map.remove_delim(idx);
            }
            Some(close) => {
                self.map.update_close_delim(idx, close - self.global_offset);
            }
        }
    }
}

/// A Raw Token (straightly from lexer) convertor
struct RawConvertor<'a> {
    text: &'a str,
    offset: TextSize,
    id_alloc: TokenIdAlloc,
    inner: std::slice::Iter<'a, RawToken>,
}

trait SrcToken: std::fmt::Debug {
    fn kind(&self) -> SyntaxKind;

    fn to_char(&self) -> Option<char>;

    fn to_text(&self) -> SmolStr;
}

trait TokenConvertor {
    type Token: SrcToken;

    fn go(&mut self) -> Option<tt::Subtree> {
        let mut subtree = tt::Subtree::default();
        subtree.delimiter = None;
        while self.peek().is_some() {
            self.collect_leaf(&mut subtree.token_trees);
        }
        if subtree.token_trees.is_empty() {
            return None;
        }
        if subtree.token_trees.len() == 1 {
            if let tt::TokenTree::Subtree(first) = &subtree.token_trees[0] {
                return Some(first.clone());
            }
        }
        Some(subtree)
    }

    fn collect_leaf(&mut self, result: &mut Vec<tt::TokenTree>) {
        let (token, range) = match self.bump() {
            None => return,
            Some(it) => it,
        };

        let k: SyntaxKind = token.kind();
        if k == COMMENT {
            if let Some(tokens) = self.convert_doc_comment(&token) {
                result.extend(tokens);
            }
            return;
        }

        result.push(if k.is_punct() {
            assert_eq!(range.len(), TextSize::of('.'));
            let delim = match k {
                T!['('] => Some((tt::DelimiterKind::Parenthesis, T![')'])),
                T!['{'] => Some((tt::DelimiterKind::Brace, T!['}'])),
                T!['['] => Some((tt::DelimiterKind::Bracket, T![']'])),
                _ => None,
            };

            if let Some((kind, closed)) = delim {
                let mut subtree = tt::Subtree::default();
                let (id, idx) = self.id_alloc().open_delim(range);
                subtree.delimiter = Some(tt::Delimiter { kind, id });

                while self.peek().map(|it| it.kind() != closed).unwrap_or(false) {
                    self.collect_leaf(&mut subtree.token_trees);
                }
                let last_range = match self.bump() {
                    None => {
                        // For error resilience, we insert an char punct for the opening delim here
                        self.id_alloc().close_delim(idx, None);
                        let leaf: tt::Leaf = tt::Punct {
                            id: self.id_alloc().alloc(range),
                            char: token.to_char().unwrap(),
                            spacing: tt::Spacing::Alone,
                        }
                        .into();
                        result.push(leaf.into());
                        result.extend(subtree.token_trees);
                        return;
                    }
                    Some(it) => it.1,
                };
                self.id_alloc().close_delim(idx, Some(last_range));
                subtree.into()
            } else {
                let spacing = match self.peek() {
                    Some(next)
                        if next.kind().is_trivia()
                            || next.kind() == T!['[']
                            || next.kind() == T!['{']
                            || next.kind() == T!['('] =>
                    {
                        tt::Spacing::Alone
                    }
                    Some(next) if next.kind().is_punct() => tt::Spacing::Joint,
                    _ => tt::Spacing::Alone,
                };
                let char = match token.to_char() {
                    Some(c) => c,
                    None => {
                        panic!("Token from lexer must be single char: token = {:#?}", token);
                    }
                };
                tt::Leaf::from(tt::Punct { char, spacing, id: self.id_alloc().alloc(range) }).into()
            }
        } else {
            macro_rules! make_leaf {
                ($i:ident) => {
                    tt::$i { id: self.id_alloc().alloc(range), text: token.to_text() }.into()
                };
            }
            let leaf: tt::Leaf = match k {
                T![true] | T![false] => make_leaf!(Ident),
                IDENT => make_leaf!(Ident),
                k if k.is_keyword() => make_leaf!(Ident),
                k if k.is_literal() => make_leaf!(Literal),
                LIFETIME => {
                    let char_unit = TextSize::of('\'');
                    let r = TextRange::at(range.start(), char_unit);
                    let apostrophe = tt::Leaf::from(tt::Punct {
                        char: '\'',
                        spacing: tt::Spacing::Joint,
                        id: self.id_alloc().alloc(r),
                    });
                    result.push(apostrophe.into());

                    let r = TextRange::at(range.start() + char_unit, range.len() - char_unit);
                    let ident = tt::Leaf::from(tt::Ident {
                        text: SmolStr::new(&token.to_text()[1..]),
                        id: self.id_alloc().alloc(r),
                    });
                    result.push(ident.into());
                    return;
                }
                _ => return,
            };

            leaf.into()
        });
    }

    fn convert_doc_comment(&self, token: &Self::Token) -> Option<Vec<tt::TokenTree>>;

    fn bump(&mut self) -> Option<(Self::Token, TextRange)>;

    fn peek(&self) -> Option<Self::Token>;

    fn id_alloc(&mut self) -> &mut TokenIdAlloc;
}

impl<'a> SrcToken for (RawToken, &'a str) {
    fn kind(&self) -> SyntaxKind {
        self.0.kind
    }

    fn to_char(&self) -> Option<char> {
        self.1.chars().next()
    }

    fn to_text(&self) -> SmolStr {
        self.1.into()
    }
}

impl RawConvertor<'_> {}

impl<'a> TokenConvertor for RawConvertor<'a> {
    type Token = (RawToken, &'a str);

    fn convert_doc_comment(&self, token: &Self::Token) -> Option<Vec<tt::TokenTree>> {
        convert_doc_comment(&doc_comment(token.1))
    }

    fn bump(&mut self) -> Option<(Self::Token, TextRange)> {
        let token = self.inner.next()?;
        let range = TextRange::at(self.offset, token.len);
        self.offset += token.len;

        Some(((*token, &self.text[range]), range))
    }

    fn peek(&self) -> Option<Self::Token> {
        let token = self.inner.as_slice().get(0).cloned();

        token.map(|it| {
            let range = TextRange::at(self.offset, it.len);
            (it, &self.text[range])
        })
    }

    fn id_alloc(&mut self) -> &mut TokenIdAlloc {
        &mut self.id_alloc
    }
}

struct Convertor {
    id_alloc: TokenIdAlloc,
    current: Option<SyntaxToken>,
    range: TextRange,
    punct_offset: Option<(SyntaxToken, TextSize)>,
}

impl Convertor {
    fn new(node: &SyntaxNode, global_offset: TextSize) -> Convertor {
        Convertor {
            id_alloc: { TokenIdAlloc { map: TokenMap::default(), global_offset, next_id: 0 } },
            current: node.first_token(),
            range: node.text_range(),
            punct_offset: None,
        }
    }
}

#[derive(Debug)]
enum SynToken {
    Ordiniary(SyntaxToken),
    Punch(SyntaxToken, TextSize),
}

impl SynToken {
    fn token(&self) -> &SyntaxToken {
        match self {
            SynToken::Ordiniary(it) => it,
            SynToken::Punch(it, _) => it,
        }
    }
}

impl SrcToken for SynToken {
    fn kind(&self) -> SyntaxKind {
        self.token().kind()
    }
    fn to_char(&self) -> Option<char> {
        match self {
            SynToken::Ordiniary(_) => None,
            SynToken::Punch(it, i) => it.text().chars().nth((*i).into()),
        }
    }
    fn to_text(&self) -> SmolStr {
        self.token().text().clone()
    }
}

impl TokenConvertor for Convertor {
    type Token = SynToken;
    fn convert_doc_comment(&self, token: &Self::Token) -> Option<Vec<tt::TokenTree>> {
        convert_doc_comment(token.token())
    }

    fn bump(&mut self) -> Option<(Self::Token, TextRange)> {
        if let Some((punct, offset)) = self.punct_offset.clone() {
            if usize::from(offset) + 1 < punct.text().len() {
                let offset = offset + TextSize::of('.');
                let range = punct.text_range();
                self.punct_offset = Some((punct.clone(), offset));
                let range = TextRange::at(range.start() + offset, TextSize::of('.'));
                return Some((SynToken::Punch(punct, offset), range));
            }
        }

        let curr = self.current.clone()?;
        if !&self.range.contains_range(curr.text_range()) {
            return None;
        }
        self.current = curr.next_token();

        let token = if curr.kind().is_punct() {
            let range = curr.text_range();
            let range = TextRange::at(range.start(), TextSize::of('.'));
            self.punct_offset = Some((curr.clone(), 0.into()));
            (SynToken::Punch(curr, 0.into()), range)
        } else {
            self.punct_offset = None;
            let range = curr.text_range();
            (SynToken::Ordiniary(curr), range)
        };

        Some(token)
    }

    fn peek(&self) -> Option<Self::Token> {
        if let Some((punct, mut offset)) = self.punct_offset.clone() {
            offset = offset + TextSize::of('.');
            if usize::from(offset) < punct.text().len() {
                return Some(SynToken::Punch(punct, offset));
            }
        }

        let curr = self.current.clone()?;
        if !self.range.contains_range(curr.text_range()) {
            return None;
        }

        let token = if curr.kind().is_punct() {
            SynToken::Punch(curr, 0.into())
        } else {
            SynToken::Ordiniary(curr)
        };
        Some(token)
    }

    fn id_alloc(&mut self) -> &mut TokenIdAlloc {
        &mut self.id_alloc
    }
}

struct TtTreeSink<'a> {
    buf: String,
    cursor: Cursor<'a>,
    open_delims: FxHashMap<tt::TokenId, TextSize>,
    text_pos: TextSize,
    inner: SyntaxTreeBuilder,
    token_map: TokenMap,

    // Number of roots
    // Use for detect ill-form tree which is not single root
    roots: smallvec::SmallVec<[usize; 1]>,
}

impl<'a> TtTreeSink<'a> {
    fn new(cursor: Cursor<'a>) -> Self {
        TtTreeSink {
            buf: String::new(),
            cursor,
            open_delims: FxHashMap::default(),
            text_pos: 0.into(),
            inner: SyntaxTreeBuilder::default(),
            roots: smallvec::SmallVec::new(),
            token_map: TokenMap::default(),
        }
    }

    fn finish(self) -> (Parse<SyntaxNode>, TokenMap) {
        (self.inner.finish(), self.token_map)
    }
}

fn delim_to_str(d: Option<tt::DelimiterKind>, closing: bool) -> SmolStr {
    let texts = match d {
        Some(tt::DelimiterKind::Parenthesis) => "()",
        Some(tt::DelimiterKind::Brace) => "{}",
        Some(tt::DelimiterKind::Bracket) => "[]",
        None => return "".into(),
    };

    let idx = closing as usize;
    let text = &texts[idx..texts.len() - (1 - idx)];
    text.into()
}

impl<'a> TreeSink for TtTreeSink<'a> {
    fn token(&mut self, kind: SyntaxKind, mut n_tokens: u8) {
        if kind == L_DOLLAR || kind == R_DOLLAR {
            self.cursor = self.cursor.bump_subtree();
            return;
        }
        if kind == LIFETIME {
            n_tokens = 2;
        }

        let mut last = self.cursor;
        for _ in 0..n_tokens {
            if self.cursor.eof() {
                break;
            }
            last = self.cursor;
            let text: SmolStr = match self.cursor.token_tree() {
                Some(tt::TokenTree::Leaf(leaf)) => {
                    // Mark the range if needed
                    let (text, id) = match leaf {
                        tt::Leaf::Ident(ident) => (ident.text.clone(), ident.id),
                        tt::Leaf::Punct(punct) => {
                            (SmolStr::new_inline_from_ascii(1, &[punct.char as u8]), punct.id)
                        }
                        tt::Leaf::Literal(lit) => (lit.text.clone(), lit.id),
                    };
                    let range = TextRange::at(self.text_pos, TextSize::of(text.as_str()));
                    self.token_map.insert(id, range);
                    self.cursor = self.cursor.bump();
                    text
                }
                Some(tt::TokenTree::Subtree(subtree)) => {
                    self.cursor = self.cursor.subtree().unwrap();
                    if let Some(id) = subtree.delimiter.map(|it| it.id) {
                        self.open_delims.insert(id, self.text_pos);
                    }
                    delim_to_str(subtree.delimiter_kind(), false)
                }
                None => {
                    if let Some(parent) = self.cursor.end() {
                        self.cursor = self.cursor.bump();
                        if let Some(id) = parent.delimiter.map(|it| it.id) {
                            if let Some(open_delim) = self.open_delims.get(&id) {
                                let open_range = TextRange::at(*open_delim, TextSize::of('('));
                                let close_range = TextRange::at(self.text_pos, TextSize::of('('));
                                self.token_map.insert_delim(id, open_range, close_range);
                            }
                        }
                        delim_to_str(parent.delimiter_kind(), true)
                    } else {
                        continue;
                    }
                }
            };
            self.buf += &text;
            self.text_pos += TextSize::of(text.as_str());
        }

        let text = SmolStr::new(self.buf.as_str());
        self.buf.clear();
        self.inner.token(kind, text);

        // Add whitespace between adjoint puncts
        let next = last.bump();
        if let (
            Some(tt::TokenTree::Leaf(tt::Leaf::Punct(curr))),
            Some(tt::TokenTree::Leaf(tt::Leaf::Punct(_))),
        ) = (last.token_tree(), next.token_tree())
        {
            // Note: We always assume the semi-colon would be the last token in
            // other parts of RA such that we don't add whitespace here.
            if curr.spacing == tt::Spacing::Alone && curr.char != ';' {
                self.inner.token(WHITESPACE, " ".into());
                self.text_pos += TextSize::of(' ');
            }
        }
    }

    fn start_node(&mut self, kind: SyntaxKind) {
        self.inner.start_node(kind);

        match self.roots.last_mut() {
            None | Some(0) => self.roots.push(1),
            Some(ref mut n) => **n += 1,
        };
    }

    fn finish_node(&mut self) {
        self.inner.finish_node();
        *self.roots.last_mut().unwrap() -= 1;
    }

    fn error(&mut self, error: ParseError) {
        self.inner.error(error, self.text_pos)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tests::parse_macro;
    use parser::TokenSource;
    use syntax::{
        algo::{insert_children, InsertPosition},
        ast::AstNode,
    };

    #[test]
    fn convert_tt_token_source() {
        let expansion = parse_macro(
            r#"
            macro_rules! literals {
                ($i:ident) => {
                    {
                        let a = 'c';
                        let c = 1000;
                        let f = 12E+99_f64;
                        let s = "rust1";
                    }
                }
            }
            "#,
        )
        .expand_tt("literals!(foo);");
        let tts = &[expansion.into()];
        let buffer = tt::buffer::TokenBuffer::new(tts);
        let mut tt_src = SubtreeTokenSource::new(&buffer);
        let mut tokens = vec![];
        while tt_src.current().kind != EOF {
            tokens.push((tt_src.current().kind, tt_src.text()));
            tt_src.bump();
        }

        // [${]
        // [let] [a] [=] ['c'] [;]
        assert_eq!(tokens[2 + 3].1, "'c'");
        assert_eq!(tokens[2 + 3].0, CHAR);
        // [let] [c] [=] [1000] [;]
        assert_eq!(tokens[2 + 5 + 3].1, "1000");
        assert_eq!(tokens[2 + 5 + 3].0, INT_NUMBER);
        // [let] [f] [=] [12E+99_f64] [;]
        assert_eq!(tokens[2 + 10 + 3].1, "12E+99_f64");
        assert_eq!(tokens[2 + 10 + 3].0, FLOAT_NUMBER);

        // [let] [s] [=] ["rust1"] [;]
        assert_eq!(tokens[2 + 15 + 3].1, "\"rust1\"");
        assert_eq!(tokens[2 + 15 + 3].0, STRING);
    }

    #[test]
    fn stmts_token_trees_to_expr_is_err() {
        let expansion = parse_macro(
            r#"
            macro_rules! stmts {
                () => {
                    let a = 0;
                    let b = 0;
                    let c = 0;
                    let d = 0;
                }
            }
            "#,
        )
        .expand_tt("stmts!();");
        assert!(token_tree_to_syntax_node(&expansion, FragmentKind::Expr).is_err());
    }

    #[test]
    fn test_token_tree_last_child_is_white_space() {
        let source_file = ast::SourceFile::parse("f!({} );").ok().unwrap();
        let macro_call = source_file.syntax().descendants().find_map(ast::MacroCall::cast).unwrap();
        let token_tree = macro_call.token_tree().unwrap();

        // Token Tree now is :
        // TokenTree
        // - T!['(']
        // - TokenTree
        //   - T!['{']
        //   - T!['}']
        // - WHITE_SPACE
        // - T![')']

        let rbrace =
            token_tree.syntax().descendants_with_tokens().find(|it| it.kind() == T!['}']).unwrap();
        let space = token_tree
            .syntax()
            .descendants_with_tokens()
            .find(|it| it.kind() == SyntaxKind::WHITESPACE)
            .unwrap();

        // reorder th white space, such that the white is inside the inner token-tree.
        let token_tree = insert_children(
            &rbrace.parent().unwrap(),
            InsertPosition::Last,
            std::iter::once(space),
        );

        // Token Tree now is :
        // TokenTree
        // - T!['{']
        // - T!['}']
        // - WHITE_SPACE
        let token_tree = ast::TokenTree::cast(token_tree).unwrap();
        let tt = ast_to_token_tree(&token_tree).unwrap().0;

        assert_eq!(tt.delimiter_kind(), Some(tt::DelimiterKind::Brace));
    }

    #[test]
    fn test_token_tree_multi_char_punct() {
        let source_file = ast::SourceFile::parse("struct Foo { a: x::Y }").ok().unwrap();
        let struct_def = source_file.syntax().descendants().find_map(ast::Struct::cast).unwrap();
        let tt = ast_to_token_tree(&struct_def).unwrap().0;
        token_tree_to_syntax_node(&tt, FragmentKind::Item).unwrap();
    }
}
