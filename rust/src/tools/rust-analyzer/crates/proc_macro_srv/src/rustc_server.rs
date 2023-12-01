//! Rustc proc-macro server implementation with tt
//!
//! Based on idea from https://github.com/fedochet/rust-proc-macro-expander
//! The lib-proc-macro server backend is `TokenStream`-agnostic, such that
//! we could provide any TokenStream implementation.
//! The original idea from fedochet is using proc-macro2 as backend,
//! we use tt instead for better intergation with RA.
//!
//! FIXME: No span and source file information is implemented yet

use crate::proc_macro::bridge::{self, server};

use std::collections::{Bound, HashMap};
use std::hash::Hash;
use std::iter::FromIterator;
use std::str::FromStr;
use std::{ascii, vec::IntoIter};

type Group = tt::Subtree;
type TokenTree = tt::TokenTree;
type Punct = tt::Punct;
type Spacing = tt::Spacing;
type Literal = tt::Literal;
type Span = tt::TokenId;

#[derive(Debug, Clone)]
pub struct TokenStream {
    pub subtree: tt::Subtree,
}

impl TokenStream {
    pub fn new() -> Self {
        TokenStream { subtree: Default::default() }
    }

    pub fn with_subtree(subtree: tt::Subtree) -> Self {
        TokenStream { subtree }
    }

    pub fn is_empty(&self) -> bool {
        self.subtree.token_trees.is_empty()
    }
}

/// Creates a token stream containing a single token tree.
impl From<TokenTree> for TokenStream {
    fn from(tree: TokenTree) -> TokenStream {
        TokenStream { subtree: tt::Subtree { delimiter: None, token_trees: vec![tree] } }
    }
}

/// Collects a number of token trees into a single stream.
impl FromIterator<TokenTree> for TokenStream {
    fn from_iter<I: IntoIterator<Item = TokenTree>>(trees: I) -> Self {
        trees.into_iter().map(TokenStream::from).collect()
    }
}

/// A "flattening" operation on token streams, collects token trees
/// from multiple token streams into a single stream.
impl FromIterator<TokenStream> for TokenStream {
    fn from_iter<I: IntoIterator<Item = TokenStream>>(streams: I) -> Self {
        let mut builder = TokenStreamBuilder::new();
        streams.into_iter().for_each(|stream| builder.push(stream));
        builder.build()
    }
}

impl Extend<TokenTree> for TokenStream {
    fn extend<I: IntoIterator<Item = TokenTree>>(&mut self, trees: I) {
        self.extend(trees.into_iter().map(TokenStream::from));
    }
}

impl Extend<TokenStream> for TokenStream {
    fn extend<I: IntoIterator<Item = TokenStream>>(&mut self, streams: I) {
        for item in streams {
            for tkn in item {
                match tkn {
                    tt::TokenTree::Subtree(subtree) if subtree.delimiter.is_none() => {
                        self.subtree.token_trees.extend(subtree.token_trees);
                    }
                    _ => {
                        self.subtree.token_trees.push(tkn);
                    }
                }
            }
        }
    }
}

type Level = crate::proc_macro::Level;
type LineColumn = crate::proc_macro::LineColumn;
type SourceFile = crate::proc_macro::SourceFile;

/// A structure representing a diagnostic message and associated children
/// messages.
#[derive(Clone, Debug)]
pub struct Diagnostic {
    level: Level,
    message: String,
    spans: Vec<Span>,
    children: Vec<Diagnostic>,
}

impl Diagnostic {
    /// Creates a new diagnostic with the given `level` and `message`.
    pub fn new<T: Into<String>>(level: Level, message: T) -> Diagnostic {
        Diagnostic { level, message: message.into(), spans: vec![], children: vec![] }
    }
}

// Rustc Server Ident has to be `Copyable`
// We use a stub here for bypassing
#[derive(Hash, Eq, PartialEq, Copy, Clone)]
pub struct IdentId(u32);

#[derive(Clone, Hash, Eq, PartialEq)]
struct IdentData(tt::Ident);

#[derive(Default)]
struct IdentInterner {
    idents: HashMap<IdentData, u32>,
    ident_data: Vec<IdentData>,
}

impl IdentInterner {
    fn intern(&mut self, data: &IdentData) -> u32 {
        if let Some(index) = self.idents.get(data) {
            return *index;
        }

        let index = self.idents.len() as u32;
        self.ident_data.push(data.clone());
        self.idents.insert(data.clone(), index);
        index
    }

    fn get(&self, index: u32) -> &IdentData {
        &self.ident_data[index as usize]
    }

    #[allow(unused)]
    fn get_mut(&mut self, index: u32) -> &mut IdentData {
        self.ident_data.get_mut(index as usize).expect("Should be consistent")
    }
}

pub struct TokenStreamBuilder {
    acc: TokenStream,
}

/// Public implementation details for the `TokenStream` type, such as iterators.
pub mod token_stream {
    use std::str::FromStr;

    use super::{TokenStream, TokenTree};

    /// An iterator over `TokenStream`'s `TokenTree`s.
    /// The iteration is "shallow", e.g., the iterator doesn't recurse into delimited groups,
    /// and returns whole groups as token trees.
    impl IntoIterator for TokenStream {
        type Item = TokenTree;
        type IntoIter = super::IntoIter<TokenTree>;

        fn into_iter(self) -> Self::IntoIter {
            self.subtree.token_trees.into_iter()
        }
    }

    type LexError = String;

    /// Attempts to break the string into tokens and parse those tokens into a token stream.
    /// May fail for a number of reasons, for example, if the string contains unbalanced delimiters
    /// or characters not existing in the language.
    /// All tokens in the parsed stream get `Span::call_site()` spans.
    ///
    /// NOTE: some errors may cause panics instead of returning `LexError`. We reserve the right to
    /// change these errors into `LexError`s later.
    impl FromStr for TokenStream {
        type Err = LexError;

        fn from_str(src: &str) -> Result<TokenStream, LexError> {
            let (subtree, _token_map) =
                mbe::parse_to_token_tree(src).ok_or("Failed to parse from mbe")?;

            let tt: tt::TokenTree = subtree.into();
            Ok(tt.into())
        }
    }

    impl ToString for TokenStream {
        fn to_string(&self) -> String {
            let tt = self.subtree.clone().into();
            to_text(&tt)
        }
    }

    fn to_text(tkn: &tt::TokenTree) -> String {
        match tkn {
            tt::TokenTree::Leaf(tt::Leaf::Ident(ident)) => ident.text.clone().into(),
            tt::TokenTree::Leaf(tt::Leaf::Literal(literal)) => literal.text.clone().into(),
            tt::TokenTree::Leaf(tt::Leaf::Punct(punct)) => format!("{}", punct.char),
            tt::TokenTree::Subtree(subtree) => {
                let content = subtree
                    .token_trees
                    .iter()
                    .map(|tkn| {
                        let s = to_text(tkn);
                        if let tt::TokenTree::Leaf(tt::Leaf::Punct(punct)) = tkn {
                            if punct.spacing == tt::Spacing::Alone {
                                return s + " ";
                            }
                        }
                        s
                    })
                    .collect::<Vec<_>>()
                    .concat();
                let (open, close) = match subtree.delimiter.map(|it| it.kind) {
                    None => ("", ""),
                    Some(tt::DelimiterKind::Brace) => ("{", "}"),
                    Some(tt::DelimiterKind::Parenthesis) => ("(", ")"),
                    Some(tt::DelimiterKind::Bracket) => ("[", "]"),
                };
                format!("{}{}{}", open, content, close)
            }
        }
    }
}

impl TokenStreamBuilder {
    fn new() -> TokenStreamBuilder {
        TokenStreamBuilder { acc: TokenStream::new() }
    }

    fn push(&mut self, stream: TokenStream) {
        self.acc.extend(stream.into_iter())
    }

    fn build(self) -> TokenStream {
        self.acc
    }
}

#[derive(Clone)]
pub struct TokenStreamIter {
    trees: IntoIter<TokenTree>,
}

#[derive(Default)]
pub struct Rustc {
    ident_interner: IdentInterner,
    // FIXME: store span information here.
}

impl server::Types for Rustc {
    type TokenStream = TokenStream;
    type TokenStreamBuilder = TokenStreamBuilder;
    type TokenStreamIter = TokenStreamIter;
    type Group = Group;
    type Punct = Punct;
    type Ident = IdentId;
    type Literal = Literal;
    type SourceFile = SourceFile;
    type Diagnostic = Diagnostic;
    type Span = Span;
    type MultiSpan = Vec<Span>;
}

impl server::TokenStream for Rustc {
    fn new(&mut self) -> Self::TokenStream {
        Self::TokenStream::new()
    }

    fn is_empty(&mut self, stream: &Self::TokenStream) -> bool {
        stream.is_empty()
    }
    fn from_str(&mut self, src: &str) -> Self::TokenStream {
        Self::TokenStream::from_str(src).expect("cannot parse string")
    }
    fn to_string(&mut self, stream: &Self::TokenStream) -> String {
        stream.to_string()
    }
    fn from_token_tree(
        &mut self,
        tree: bridge::TokenTree<Self::Group, Self::Punct, Self::Ident, Self::Literal>,
    ) -> Self::TokenStream {
        match tree {
            bridge::TokenTree::Group(group) => {
                let tree = TokenTree::from(group);
                Self::TokenStream::from_iter(vec![tree])
            }

            bridge::TokenTree::Ident(IdentId(index)) => {
                let IdentData(ident) = self.ident_interner.get(index).clone();
                let ident: tt::Ident = ident;
                let leaf = tt::Leaf::from(ident);
                let tree = TokenTree::from(leaf);
                Self::TokenStream::from_iter(vec![tree])
            }

            bridge::TokenTree::Literal(literal) => {
                let leaf = tt::Leaf::from(literal);
                let tree = TokenTree::from(leaf);
                Self::TokenStream::from_iter(vec![tree])
            }

            bridge::TokenTree::Punct(p) => {
                let leaf = tt::Leaf::from(p);
                let tree = TokenTree::from(leaf);
                Self::TokenStream::from_iter(vec![tree])
            }
        }
    }

    fn into_iter(&mut self, stream: Self::TokenStream) -> Self::TokenStreamIter {
        let trees: Vec<TokenTree> = stream.into_iter().collect();
        TokenStreamIter { trees: trees.into_iter() }
    }
}

impl server::TokenStreamBuilder for Rustc {
    fn new(&mut self) -> Self::TokenStreamBuilder {
        Self::TokenStreamBuilder::new()
    }
    fn push(&mut self, builder: &mut Self::TokenStreamBuilder, stream: Self::TokenStream) {
        builder.push(stream)
    }
    fn build(&mut self, builder: Self::TokenStreamBuilder) -> Self::TokenStream {
        builder.build()
    }
}

impl server::TokenStreamIter for Rustc {
    fn next(
        &mut self,
        iter: &mut Self::TokenStreamIter,
    ) -> Option<bridge::TokenTree<Self::Group, Self::Punct, Self::Ident, Self::Literal>> {
        iter.trees.next().map(|tree| match tree {
            TokenTree::Subtree(group) => bridge::TokenTree::Group(group),
            TokenTree::Leaf(tt::Leaf::Ident(ident)) => {
                bridge::TokenTree::Ident(IdentId(self.ident_interner.intern(&IdentData(ident))))
            }
            TokenTree::Leaf(tt::Leaf::Literal(literal)) => bridge::TokenTree::Literal(literal),
            TokenTree::Leaf(tt::Leaf::Punct(punct)) => bridge::TokenTree::Punct(punct),
        })
    }
}

fn delim_to_internal(d: bridge::Delimiter) -> Option<tt::Delimiter> {
    let kind = match d {
        bridge::Delimiter::Parenthesis => tt::DelimiterKind::Parenthesis,
        bridge::Delimiter::Brace => tt::DelimiterKind::Brace,
        bridge::Delimiter::Bracket => tt::DelimiterKind::Bracket,
        bridge::Delimiter::None => return None,
    };
    Some(tt::Delimiter { id: tt::TokenId::unspecified(), kind })
}

fn delim_to_external(d: Option<tt::Delimiter>) -> bridge::Delimiter {
    match d.map(|it| it.kind) {
        Some(tt::DelimiterKind::Parenthesis) => bridge::Delimiter::Parenthesis,
        Some(tt::DelimiterKind::Brace) => bridge::Delimiter::Brace,
        Some(tt::DelimiterKind::Bracket) => bridge::Delimiter::Bracket,
        None => bridge::Delimiter::None,
    }
}

fn spacing_to_internal(spacing: bridge::Spacing) -> Spacing {
    match spacing {
        bridge::Spacing::Alone => Spacing::Alone,
        bridge::Spacing::Joint => Spacing::Joint,
    }
}

fn spacing_to_external(spacing: Spacing) -> bridge::Spacing {
    match spacing {
        Spacing::Alone => bridge::Spacing::Alone,
        Spacing::Joint => bridge::Spacing::Joint,
    }
}

impl server::Group for Rustc {
    fn new(&mut self, delimiter: bridge::Delimiter, stream: Self::TokenStream) -> Self::Group {
        Self::Group {
            delimiter: delim_to_internal(delimiter),
            token_trees: stream.subtree.token_trees,
        }
    }
    fn delimiter(&mut self, group: &Self::Group) -> bridge::Delimiter {
        delim_to_external(group.delimiter)
    }

    // NOTE: Return value of do not include delimiter
    fn stream(&mut self, group: &Self::Group) -> Self::TokenStream {
        TokenStream {
            subtree: tt::Subtree { delimiter: None, token_trees: group.token_trees.clone() },
        }
    }

    fn span(&mut self, group: &Self::Group) -> Self::Span {
        group.delimiter.map(|it| it.id).unwrap_or_else(|| tt::TokenId::unspecified())
    }

    fn set_span(&mut self, _group: &mut Self::Group, _span: Self::Span) {
        // FIXME handle span
    }

    fn span_open(&mut self, _group: &Self::Group) -> Self::Span {
        // FIXME handle span
        // MySpan(self.span_interner.intern(&MySpanData(group.span_open())))
        tt::TokenId::unspecified()
    }

    fn span_close(&mut self, _group: &Self::Group) -> Self::Span {
        // FIXME handle span
        tt::TokenId::unspecified()
    }
}

impl server::Punct for Rustc {
    fn new(&mut self, ch: char, spacing: bridge::Spacing) -> Self::Punct {
        tt::Punct {
            char: ch,
            spacing: spacing_to_internal(spacing),
            id: tt::TokenId::unspecified(),
        }
    }
    fn as_char(&mut self, punct: Self::Punct) -> char {
        punct.char
    }
    fn spacing(&mut self, punct: Self::Punct) -> bridge::Spacing {
        spacing_to_external(punct.spacing)
    }
    fn span(&mut self, _punct: Self::Punct) -> Self::Span {
        // FIXME handle span
        tt::TokenId::unspecified()
    }
    fn with_span(&mut self, punct: Self::Punct, _span: Self::Span) -> Self::Punct {
        // FIXME handle span
        punct
    }
}

impl server::Ident for Rustc {
    fn new(&mut self, string: &str, _span: Self::Span, _is_raw: bool) -> Self::Ident {
        IdentId(
            self.ident_interner.intern(&IdentData(tt::Ident {
                text: string.into(),
                id: tt::TokenId::unspecified(),
            })),
        )
    }

    fn span(&mut self, _ident: Self::Ident) -> Self::Span {
        // FIXME handle span
        tt::TokenId::unspecified()
    }
    fn with_span(&mut self, ident: Self::Ident, _span: Self::Span) -> Self::Ident {
        // FIXME handle span
        ident
    }
}

impl server::Literal for Rustc {
    fn debug_kind(&mut self, _literal: &Self::Literal) -> String {
        // r-a: debug_kind and suffix are unsupported; corresponding client code has been changed to not call these.
        // They must still be present to be ABI-compatible and work with upstream proc_macro.
        "".to_owned()
    }
    fn symbol(&mut self, literal: &Self::Literal) -> String {
        literal.text.to_string()
    }
    fn suffix(&mut self, _literal: &Self::Literal) -> Option<String> {
        None
    }

    fn integer(&mut self, n: &str) -> Self::Literal {
        let n: i128 = n.parse().unwrap();
        Literal { text: n.to_string().into(), id: tt::TokenId::unspecified() }
    }

    fn typed_integer(&mut self, n: &str, kind: &str) -> Self::Literal {
        macro_rules! def_suffixed_integer {
            ($kind:ident, $($ty:ty),*) => {
                match $kind {
                    $(
                        stringify!($ty) => {
                            let n: $ty = n.parse().unwrap();
                            format!(concat!("{}", stringify!($ty)), n)
                        }
                    )*
                    _ => unimplemented!("unknown args for typed_integer: n {}, kind {}", n, $kind),
                }
            }
        }

        let text =
            def_suffixed_integer! {kind, u8, u16, u32, u64, u128, usize, i8, i16, i32, i64, i128};

        Literal { text: text.into(), id: tt::TokenId::unspecified() }
    }

    fn float(&mut self, n: &str) -> Self::Literal {
        let n: f64 = n.parse().unwrap();
        let mut text = f64::to_string(&n);
        if !text.contains('.') {
            text += ".0"
        }
        Literal { text: text.into(), id: tt::TokenId::unspecified() }
    }

    fn f32(&mut self, n: &str) -> Self::Literal {
        let n: f32 = n.parse().unwrap();
        let text = format!("{}f32", n);
        Literal { text: text.into(), id: tt::TokenId::unspecified() }
    }

    fn f64(&mut self, n: &str) -> Self::Literal {
        let n: f64 = n.parse().unwrap();
        let text = format!("{}f64", n);
        Literal { text: text.into(), id: tt::TokenId::unspecified() }
    }

    fn string(&mut self, string: &str) -> Self::Literal {
        let mut escaped = String::new();
        for ch in string.chars() {
            escaped.extend(ch.escape_debug());
        }
        Literal { text: format!("\"{}\"", escaped).into(), id: tt::TokenId::unspecified() }
    }

    fn character(&mut self, ch: char) -> Self::Literal {
        Literal { text: format!("'{}'", ch).into(), id: tt::TokenId::unspecified() }
    }

    fn byte_string(&mut self, bytes: &[u8]) -> Self::Literal {
        let string = bytes
            .iter()
            .cloned()
            .flat_map(ascii::escape_default)
            .map(Into::<char>::into)
            .collect::<String>();

        Literal { text: format!("b\"{}\"", string).into(), id: tt::TokenId::unspecified() }
    }

    fn span(&mut self, literal: &Self::Literal) -> Self::Span {
        literal.id
    }

    fn set_span(&mut self, _literal: &mut Self::Literal, _span: Self::Span) {
        // FIXME handle span
    }

    fn subspan(
        &mut self,
        _literal: &Self::Literal,
        _start: Bound<usize>,
        _end: Bound<usize>,
    ) -> Option<Self::Span> {
        // FIXME handle span
        None
    }
}

impl server::SourceFile for Rustc {
    fn eq(&mut self, file1: &Self::SourceFile, file2: &Self::SourceFile) -> bool {
        file1.eq(file2)
    }
    fn path(&mut self, file: &Self::SourceFile) -> String {
        String::from(
            file.path().to_str().expect("non-UTF8 file path in `proc_macro::SourceFile::path`"),
        )
    }
    fn is_real(&mut self, file: &Self::SourceFile) -> bool {
        file.is_real()
    }
}

impl server::Diagnostic for Rustc {
    fn new(&mut self, level: Level, msg: &str, spans: Self::MultiSpan) -> Self::Diagnostic {
        let mut diag = Diagnostic::new(level, msg);
        diag.spans = spans;
        diag
    }

    fn sub(
        &mut self,
        _diag: &mut Self::Diagnostic,
        _level: Level,
        _msg: &str,
        _spans: Self::MultiSpan,
    ) {
        // FIXME handle diagnostic
        //
    }

    fn emit(&mut self, _diag: Self::Diagnostic) {
        // FIXME handle diagnostic
        // diag.emit()
    }
}

impl server::Span for Rustc {
    fn debug(&mut self, span: Self::Span) -> String {
        format!("{:?}", span.0)
    }
    fn def_site(&mut self) -> Self::Span {
        // MySpan(self.span_interner.intern(&MySpanData(Span::def_site())))
        // FIXME handle span
        tt::TokenId::unspecified()
    }
    fn call_site(&mut self) -> Self::Span {
        // MySpan(self.span_interner.intern(&MySpanData(Span::call_site())))
        // FIXME handle span
        tt::TokenId::unspecified()
    }
    fn source_file(&mut self, _span: Self::Span) -> Self::SourceFile {
        // let MySpanData(span) = self.span_interner.get(span.0);
        unimplemented!()
    }

    /// Recent feature, not yet in the proc_macro
    ///
    /// See PR:
    /// https://github.com/rust-lang/rust/pull/55780
    fn source_text(&mut self, _span: Self::Span) -> Option<String> {
        None
    }

    fn parent(&mut self, _span: Self::Span) -> Option<Self::Span> {
        // FIXME handle span
        None
    }
    fn source(&mut self, span: Self::Span) -> Self::Span {
        // FIXME handle span
        span
    }
    fn start(&mut self, _span: Self::Span) -> LineColumn {
        // FIXME handle span
        LineColumn { line: 0, column: 0 }
    }
    fn end(&mut self, _span: Self::Span) -> LineColumn {
        // FIXME handle span
        LineColumn { line: 0, column: 0 }
    }
    fn join(&mut self, _first: Self::Span, _second: Self::Span) -> Option<Self::Span> {
        None
    }
    fn resolved_at(&mut self, _span: Self::Span, _at: Self::Span) -> Self::Span {
        // FIXME handle span
        tt::TokenId::unspecified()
    }

    fn mixed_site(&mut self) -> Self::Span {
        // FIXME handle span
        tt::TokenId::unspecified()
    }
}

impl server::MultiSpan for Rustc {
    fn new(&mut self) -> Self::MultiSpan {
        // FIXME handle span
        vec![]
    }

    fn push(&mut self, other: &mut Self::MultiSpan, span: Self::Span) {
        //TODP
        other.push(span)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::proc_macro::bridge::server::Literal;

    #[test]
    fn test_rustc_server_literals() {
        let mut srv = Rustc { ident_interner: IdentInterner::default() };
        assert_eq!(srv.integer("1234").text, "1234");

        assert_eq!(srv.typed_integer("12", "u8").text, "12u8");
        assert_eq!(srv.typed_integer("255", "u16").text, "255u16");
        assert_eq!(srv.typed_integer("1234", "u32").text, "1234u32");
        assert_eq!(srv.typed_integer("15846685", "u64").text, "15846685u64");
        assert_eq!(srv.typed_integer("15846685258", "u128").text, "15846685258u128");
        assert_eq!(srv.typed_integer("156788984", "usize").text, "156788984usize");
        assert_eq!(srv.typed_integer("127", "i8").text, "127i8");
        assert_eq!(srv.typed_integer("255", "i16").text, "255i16");
        assert_eq!(srv.typed_integer("1234", "i32").text, "1234i32");
        assert_eq!(srv.typed_integer("15846685", "i64").text, "15846685i64");
        assert_eq!(srv.typed_integer("15846685258", "i128").text, "15846685258i128");
        assert_eq!(srv.float("0").text, "0.0");
        assert_eq!(srv.float("15684.5867").text, "15684.5867");
        assert_eq!(srv.f32("15684.58").text, "15684.58f32");
        assert_eq!(srv.f64("15684.58").text, "15684.58f64");

        assert_eq!(srv.string("hello_world").text, "\"hello_world\"");
        assert_eq!(srv.character('c').text, "'c'");
        assert_eq!(srv.byte_string(b"1234586\x88").text, "b\"1234586\\x88\"");
    }
}
