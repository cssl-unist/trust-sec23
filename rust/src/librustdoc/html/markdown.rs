//! Markdown formatting for rustdoc.
//!
//! This module implements markdown formatting through the pulldown-cmark library.
//!
//! ```
//! #![feature(rustc_private)]
//!
//! extern crate rustc_span;
//!
//! use rustc_span::edition::Edition;
//! use rustdoc::html::markdown::{IdMap, Markdown, ErrorCodes};
//!
//! let s = "My *markdown* _text_";
//! let mut id_map = IdMap::new();
//! let md = Markdown(s, &[], &mut id_map, ErrorCodes::Yes, Edition::Edition2015, &None);
//! let html = md.into_string();
//! // ... something using html
//! ```

#![allow(non_camel_case_types)]

use rustc_data_structures::fx::FxHashMap;
use rustc_hir::def_id::DefId;
use rustc_hir::HirId;
use rustc_middle::ty::TyCtxt;
use rustc_session::lint;
use rustc_span::edition::Edition;
use rustc_span::Span;
use std::borrow::Cow;
use std::collections::VecDeque;
use std::default::Default;
use std::fmt::Write;
use std::ops::Range;
use std::str;

use crate::clean::RenderedLink;
use crate::doctest;
use crate::html::highlight;
use crate::html::toc::TocBuilder;

use pulldown_cmark::{html, BrokenLink, CodeBlockKind, CowStr, Event, Options, Parser, Tag};

#[cfg(test)]
mod tests;

pub(crate) fn opts() -> Options {
    Options::ENABLE_TABLES | Options::ENABLE_FOOTNOTES | Options::ENABLE_STRIKETHROUGH
}

/// When `to_string` is called, this struct will emit the HTML corresponding to
/// the rendered version of the contained markdown string.
pub struct Markdown<'a>(
    pub &'a str,
    /// A list of link replacements.
    pub &'a [RenderedLink],
    /// The current list of used header IDs.
    pub &'a mut IdMap,
    /// Whether to allow the use of explicit error codes in doctest lang strings.
    pub ErrorCodes,
    /// Default edition to use when parsing doctests (to add a `fn main`).
    pub Edition,
    pub &'a Option<Playground>,
);
/// A tuple struct like `Markdown` that renders the markdown with a table of contents.
pub struct MarkdownWithToc<'a>(
    pub &'a str,
    pub &'a mut IdMap,
    pub ErrorCodes,
    pub Edition,
    pub &'a Option<Playground>,
);
/// A tuple struct like `Markdown` that renders the markdown escaping HTML tags.
pub struct MarkdownHtml<'a>(
    pub &'a str,
    pub &'a mut IdMap,
    pub ErrorCodes,
    pub Edition,
    pub &'a Option<Playground>,
);
/// A tuple struct like `Markdown` that renders only the first paragraph.
pub struct MarkdownSummaryLine<'a>(pub &'a str, pub &'a [RenderedLink]);

#[derive(Copy, Clone, PartialEq, Debug)]
pub enum ErrorCodes {
    Yes,
    No,
}

impl ErrorCodes {
    pub fn from(b: bool) -> Self {
        match b {
            true => ErrorCodes::Yes,
            false => ErrorCodes::No,
        }
    }

    pub fn as_bool(self) -> bool {
        match self {
            ErrorCodes::Yes => true,
            ErrorCodes::No => false,
        }
    }
}

/// Controls whether a line will be hidden or shown in HTML output.
///
/// All lines are used in documentation tests.
enum Line<'a> {
    Hidden(&'a str),
    Shown(Cow<'a, str>),
}

impl<'a> Line<'a> {
    fn for_html(self) -> Option<Cow<'a, str>> {
        match self {
            Line::Shown(l) => Some(l),
            Line::Hidden(_) => None,
        }
    }

    fn for_code(self) -> Cow<'a, str> {
        match self {
            Line::Shown(l) => l,
            Line::Hidden(l) => Cow::Borrowed(l),
        }
    }
}

// FIXME: There is a minor inconsistency here. For lines that start with ##, we
// have no easy way of removing a potential single space after the hashes, which
// is done in the single # case. This inconsistency seems okay, if non-ideal. In
// order to fix it we'd have to iterate to find the first non-# character, and
// then reallocate to remove it; which would make us return a String.
fn map_line(s: &str) -> Line<'_> {
    let trimmed = s.trim();
    if trimmed.starts_with("##") {
        Line::Shown(Cow::Owned(s.replacen("##", "#", 1)))
    } else if trimmed.starts_with("# ") {
        // # text
        Line::Hidden(&trimmed[2..])
    } else if trimmed == "#" {
        // We cannot handle '#text' because it could be #[attr].
        Line::Hidden("")
    } else {
        Line::Shown(Cow::Borrowed(s))
    }
}

/// Convert chars from a title for an id.
///
/// "Hello, world!" -> "hello-world"
fn slugify(c: char) -> Option<char> {
    if c.is_alphanumeric() || c == '-' || c == '_' {
        if c.is_ascii() { Some(c.to_ascii_lowercase()) } else { Some(c) }
    } else if c.is_whitespace() && c.is_ascii() {
        Some('-')
    } else {
        None
    }
}

#[derive(Clone, Debug)]
pub struct Playground {
    pub crate_name: Option<String>,
    pub url: String,
}

/// Adds syntax highlighting and playground Run buttons to Rust code blocks.
struct CodeBlocks<'p, 'a, I: Iterator<Item = Event<'a>>> {
    inner: I,
    check_error_codes: ErrorCodes,
    edition: Edition,
    // Information about the playground if a URL has been specified, containing an
    // optional crate name and the URL.
    playground: &'p Option<Playground>,
}

impl<'p, 'a, I: Iterator<Item = Event<'a>>> CodeBlocks<'p, 'a, I> {
    fn new(
        iter: I,
        error_codes: ErrorCodes,
        edition: Edition,
        playground: &'p Option<Playground>,
    ) -> Self {
        CodeBlocks { inner: iter, check_error_codes: error_codes, edition, playground }
    }
}

impl<'a, I: Iterator<Item = Event<'a>>> Iterator for CodeBlocks<'_, 'a, I> {
    type Item = Event<'a>;

    fn next(&mut self) -> Option<Self::Item> {
        let event = self.inner.next();
        let compile_fail;
        let should_panic;
        let ignore;
        let edition;
        if let Some(Event::Start(Tag::CodeBlock(kind))) = event {
            let parse_result = match kind {
                CodeBlockKind::Fenced(ref lang) => {
                    LangString::parse_without_check(&lang, self.check_error_codes, false)
                }
                CodeBlockKind::Indented => LangString::all_false(),
            };
            if !parse_result.rust {
                return Some(Event::Start(Tag::CodeBlock(kind)));
            }
            compile_fail = parse_result.compile_fail;
            should_panic = parse_result.should_panic;
            ignore = parse_result.ignore;
            edition = parse_result.edition;
        } else {
            return event;
        }

        let explicit_edition = edition.is_some();
        let edition = edition.unwrap_or(self.edition);

        let mut origtext = String::new();
        for event in &mut self.inner {
            match event {
                Event::End(Tag::CodeBlock(..)) => break,
                Event::Text(ref s) => {
                    origtext.push_str(s);
                }
                _ => {}
            }
        }
        let lines = origtext.lines().filter_map(|l| map_line(l).for_html());
        let text = lines.collect::<Vec<Cow<'_, str>>>().join("\n");
        // insert newline to clearly separate it from the
        // previous block so we can shorten the html output
        let mut s = String::from("\n");
        let playground_button = self.playground.as_ref().and_then(|playground| {
            let krate = &playground.crate_name;
            let url = &playground.url;
            if url.is_empty() {
                return None;
            }
            let test = origtext
                .lines()
                .map(|l| map_line(l).for_code())
                .collect::<Vec<Cow<'_, str>>>()
                .join("\n");
            let krate = krate.as_ref().map(|s| &**s);
            let (test, _) = doctest::make_test(&test, krate, false, &Default::default(), edition);
            let channel = if test.contains("#![feature(") { "&amp;version=nightly" } else { "" };

            let edition_string = format!("&amp;edition={}", edition);

            // These characters don't need to be escaped in a URI.
            // FIXME: use a library function for percent encoding.
            fn dont_escape(c: u8) -> bool {
                (b'a' <= c && c <= b'z')
                    || (b'A' <= c && c <= b'Z')
                    || (b'0' <= c && c <= b'9')
                    || c == b'-'
                    || c == b'_'
                    || c == b'.'
                    || c == b'~'
                    || c == b'!'
                    || c == b'\''
                    || c == b'('
                    || c == b')'
                    || c == b'*'
            }
            let mut test_escaped = String::new();
            for b in test.bytes() {
                if dont_escape(b) {
                    test_escaped.push(char::from(b));
                } else {
                    write!(test_escaped, "%{:02X}", b).unwrap();
                }
            }
            Some(format!(
                r#"<a class="test-arrow" target="_blank" href="{}?code={}{}{}">Run</a>"#,
                url, test_escaped, channel, edition_string
            ))
        });

        let tooltip = if ignore != Ignore::None {
            Some(("This example is not tested".to_owned(), "ignore"))
        } else if compile_fail {
            Some(("This example deliberately fails to compile".to_owned(), "compile_fail"))
        } else if should_panic {
            Some(("This example panics".to_owned(), "should_panic"))
        } else if explicit_edition {
            Some((format!("This code runs with edition {}", edition), "edition"))
        } else {
            None
        };

        if let Some((s1, s2)) = tooltip {
            s.push_str(&highlight::render_with_highlighting(
                text,
                Some(&format!(
                    "rust-example-rendered{}",
                    if ignore != Ignore::None {
                        " ignore"
                    } else if compile_fail {
                        " compile_fail"
                    } else if should_panic {
                        " should_panic"
                    } else if explicit_edition {
                        " edition "
                    } else {
                        ""
                    }
                )),
                playground_button.as_deref(),
                Some((s1.as_str(), s2)),
            ));
            Some(Event::Html(s.into()))
        } else {
            s.push_str(&highlight::render_with_highlighting(
                text,
                Some(&format!(
                    "rust-example-rendered{}",
                    if ignore != Ignore::None {
                        " ignore"
                    } else if compile_fail {
                        " compile_fail"
                    } else if should_panic {
                        " should_panic"
                    } else if explicit_edition {
                        " edition "
                    } else {
                        ""
                    }
                )),
                playground_button.as_deref(),
                None,
            ));
            Some(Event::Html(s.into()))
        }
    }
}

/// Make headings links with anchor IDs and build up TOC.
struct LinkReplacer<'a, I: Iterator<Item = Event<'a>>> {
    inner: I,
    links: &'a [RenderedLink],
    shortcut_link: Option<&'a RenderedLink>,
}

impl<'a, I: Iterator<Item = Event<'a>>> LinkReplacer<'a, I> {
    fn new(iter: I, links: &'a [RenderedLink]) -> Self {
        LinkReplacer { inner: iter, links, shortcut_link: None }
    }
}

impl<'a, I: Iterator<Item = Event<'a>>> Iterator for LinkReplacer<'a, I> {
    type Item = Event<'a>;

    fn next(&mut self) -> Option<Self::Item> {
        use pulldown_cmark::LinkType;

        let mut event = self.inner.next();

        // Replace intra-doc links and remove disambiguators from shortcut links (`[fn@f]`).
        match &mut event {
            // This is a shortcut link that was resolved by the broken_link_callback: `[fn@f]`
            // Remove any disambiguator.
            Some(Event::Start(Tag::Link(
                // [fn@f] or [fn@f][]
                LinkType::ShortcutUnknown | LinkType::CollapsedUnknown,
                dest,
                title,
            ))) => {
                debug!("saw start of shortcut link to {} with title {}", dest, title);
                // If this is a shortcut link, it was resolved by the broken_link_callback.
                // So the URL will already be updated properly.
                let link = self.links.iter().find(|&link| *link.href == **dest);
                // Since this is an external iterator, we can't replace the inner text just yet.
                // Store that we saw a link so we know to replace it later.
                if let Some(link) = link {
                    trace!("it matched");
                    assert!(self.shortcut_link.is_none(), "shortcut links cannot be nested");
                    self.shortcut_link = Some(link);
                }
            }
            // Now that we're done with the shortcut link, don't replace any more text.
            Some(Event::End(Tag::Link(
                LinkType::ShortcutUnknown | LinkType::CollapsedUnknown,
                dest,
                _,
            ))) => {
                debug!("saw end of shortcut link to {}", dest);
                if self.links.iter().find(|&link| *link.href == **dest).is_some() {
                    assert!(self.shortcut_link.is_some(), "saw closing link without opening tag");
                    self.shortcut_link = None;
                }
            }
            // Handle backticks in inline code blocks, but only if we're in the middle of a shortcut link.
            // [`fn@f`]
            Some(Event::Code(text)) => {
                trace!("saw code {}", text);
                if let Some(link) = self.shortcut_link {
                    trace!("original text was {}", link.original_text);
                    // NOTE: this only replaces if the code block is the *entire* text.
                    // If only part of the link has code highlighting, the disambiguator will not be removed.
                    // e.g. [fn@`f`]
                    // This is a limitation from `collect_intra_doc_links`: it passes a full link,
                    // and does not distinguish at all between code blocks.
                    // So we could never be sure we weren't replacing too much:
                    // [fn@my_`f`unc] is treated the same as [my_func()] in that pass.
                    //
                    // NOTE: &[1..len() - 1] is to strip the backticks
                    if **text == link.original_text[1..link.original_text.len() - 1] {
                        debug!("replacing {} with {}", text, link.new_text);
                        *text = CowStr::Borrowed(&link.new_text);
                    }
                }
            }
            // Replace plain text in links, but only in the middle of a shortcut link.
            // [fn@f]
            Some(Event::Text(text)) => {
                trace!("saw text {}", text);
                if let Some(link) = self.shortcut_link {
                    trace!("original text was {}", link.original_text);
                    // NOTE: same limitations as `Event::Code`
                    if **text == *link.original_text {
                        debug!("replacing {} with {}", text, link.new_text);
                        *text = CowStr::Borrowed(&link.new_text);
                    }
                }
            }
            // If this is a link, but not a shortcut link,
            // replace the URL, since the broken_link_callback was not called.
            Some(Event::Start(Tag::Link(_, dest, _))) => {
                if let Some(link) = self.links.iter().find(|&link| *link.original_text == **dest) {
                    *dest = CowStr::Borrowed(link.href.as_ref());
                }
            }
            // Anything else couldn't have been a valid Rust path, so no need to replace the text.
            _ => {}
        }

        // Yield the modified event
        event
    }
}

/// Make headings links with anchor IDs and build up TOC.
struct HeadingLinks<'a, 'b, 'ids, I: Iterator<Item = Event<'a>>> {
    inner: I,
    toc: Option<&'b mut TocBuilder>,
    buf: VecDeque<Event<'a>>,
    id_map: &'ids mut IdMap,
}

impl<'a, 'b, 'ids, I: Iterator<Item = Event<'a>>> HeadingLinks<'a, 'b, 'ids, I> {
    fn new(iter: I, toc: Option<&'b mut TocBuilder>, ids: &'ids mut IdMap) -> Self {
        HeadingLinks { inner: iter, toc, buf: VecDeque::new(), id_map: ids }
    }
}

impl<'a, 'b, 'ids, I: Iterator<Item = Event<'a>>> Iterator for HeadingLinks<'a, 'b, 'ids, I> {
    type Item = Event<'a>;

    fn next(&mut self) -> Option<Self::Item> {
        if let Some(e) = self.buf.pop_front() {
            return Some(e);
        }

        let event = self.inner.next();
        if let Some(Event::Start(Tag::Heading(level))) = event {
            let mut id = String::new();
            for event in &mut self.inner {
                match &event {
                    Event::End(Tag::Heading(..)) => break,
                    Event::Text(text) | Event::Code(text) => {
                        id.extend(text.chars().filter_map(slugify));
                    }
                    _ => {}
                }
                match event {
                    Event::Start(Tag::Link(_, _, _)) | Event::End(Tag::Link(..)) => {}
                    event => self.buf.push_back(event),
                }
            }
            let id = self.id_map.derive(id);

            if let Some(ref mut builder) = self.toc {
                let mut html_header = String::new();
                html::push_html(&mut html_header, self.buf.iter().cloned());
                let sec = builder.push(level as u32, html_header, id.clone());
                self.buf.push_front(Event::Html(format!("{} ", sec).into()));
            }

            self.buf.push_back(Event::Html(format!("</a></h{}>", level).into()));

            let start_tags = format!(
                "<h{level} id=\"{id}\" class=\"section-header\">\
                    <a href=\"#{id}\">",
                id = id,
                level = level
            );
            return Some(Event::Html(start_tags.into()));
        }
        event
    }
}

/// Extracts just the first paragraph.
struct SummaryLine<'a, I: Iterator<Item = Event<'a>>> {
    inner: I,
    started: bool,
    depth: u32,
}

impl<'a, I: Iterator<Item = Event<'a>>> SummaryLine<'a, I> {
    fn new(iter: I) -> Self {
        SummaryLine { inner: iter, started: false, depth: 0 }
    }
}

fn check_if_allowed_tag(t: &Tag<'_>) -> bool {
    match *t {
        Tag::Paragraph
        | Tag::Item
        | Tag::Emphasis
        | Tag::Strong
        | Tag::Link(..)
        | Tag::BlockQuote => true,
        _ => false,
    }
}

impl<'a, I: Iterator<Item = Event<'a>>> Iterator for SummaryLine<'a, I> {
    type Item = Event<'a>;

    fn next(&mut self) -> Option<Self::Item> {
        if self.started && self.depth == 0 {
            return None;
        }
        if !self.started {
            self.started = true;
        }
        if let Some(event) = self.inner.next() {
            let mut is_start = true;
            let is_allowed_tag = match event {
                Event::Start(Tag::CodeBlock(_)) | Event::End(Tag::CodeBlock(_)) => {
                    return None;
                }
                Event::Start(ref c) => {
                    self.depth += 1;
                    check_if_allowed_tag(c)
                }
                Event::End(ref c) => {
                    self.depth -= 1;
                    is_start = false;
                    check_if_allowed_tag(c)
                }
                _ => true,
            };
            return if !is_allowed_tag {
                if is_start {
                    Some(Event::Start(Tag::Paragraph))
                } else {
                    Some(Event::End(Tag::Paragraph))
                }
            } else {
                Some(event)
            };
        }
        None
    }
}

/// Moves all footnote definitions to the end and add back links to the
/// references.
struct Footnotes<'a, I: Iterator<Item = Event<'a>>> {
    inner: I,
    footnotes: FxHashMap<String, (Vec<Event<'a>>, u16)>,
}

impl<'a, I: Iterator<Item = Event<'a>>> Footnotes<'a, I> {
    fn new(iter: I) -> Self {
        Footnotes { inner: iter, footnotes: FxHashMap::default() }
    }
    fn get_entry(&mut self, key: &str) -> &mut (Vec<Event<'a>>, u16) {
        let new_id = self.footnotes.keys().count() + 1;
        let key = key.to_owned();
        self.footnotes.entry(key).or_insert((Vec::new(), new_id as u16))
    }
}

impl<'a, I: Iterator<Item = Event<'a>>> Iterator for Footnotes<'a, I> {
    type Item = Event<'a>;

    fn next(&mut self) -> Option<Self::Item> {
        loop {
            match self.inner.next() {
                Some(Event::FootnoteReference(ref reference)) => {
                    let entry = self.get_entry(&reference);
                    let reference = format!(
                        "<sup id=\"fnref{0}\"><a href=\"#fn{0}\">{0}</a></sup>",
                        (*entry).1
                    );
                    return Some(Event::Html(reference.into()));
                }
                Some(Event::Start(Tag::FootnoteDefinition(def))) => {
                    let mut content = Vec::new();
                    for event in &mut self.inner {
                        if let Event::End(Tag::FootnoteDefinition(..)) = event {
                            break;
                        }
                        content.push(event);
                    }
                    let entry = self.get_entry(&def);
                    (*entry).0 = content;
                }
                Some(e) => return Some(e),
                None => {
                    if !self.footnotes.is_empty() {
                        let mut v: Vec<_> = self.footnotes.drain().map(|(_, x)| x).collect();
                        v.sort_by(|a, b| a.1.cmp(&b.1));
                        let mut ret = String::from("<div class=\"footnotes\"><hr><ol>");
                        for (mut content, id) in v {
                            write!(ret, "<li id=\"fn{}\">", id).unwrap();
                            let mut is_paragraph = false;
                            if let Some(&Event::End(Tag::Paragraph)) = content.last() {
                                content.pop();
                                is_paragraph = true;
                            }
                            html::push_html(&mut ret, content.into_iter());
                            write!(ret, "&nbsp;<a href=\"#fnref{}\" rev=\"footnote\">↩</a>", id)
                                .unwrap();
                            if is_paragraph {
                                ret.push_str("</p>");
                            }
                            ret.push_str("</li>");
                        }
                        ret.push_str("</ol></div>");
                        return Some(Event::Html(ret.into()));
                    } else {
                        return None;
                    }
                }
            }
        }
    }
}

pub fn find_testable_code<T: doctest::Tester>(
    doc: &str,
    tests: &mut T,
    error_codes: ErrorCodes,
    enable_per_target_ignores: bool,
    extra_info: Option<&ExtraInfo<'_, '_>>,
) {
    let mut parser = Parser::new(doc).into_offset_iter();
    let mut prev_offset = 0;
    let mut nb_lines = 0;
    let mut register_header = None;
    while let Some((event, offset)) = parser.next() {
        match event {
            Event::Start(Tag::CodeBlock(kind)) => {
                let block_info = match kind {
                    CodeBlockKind::Fenced(ref lang) => {
                        if lang.is_empty() {
                            LangString::all_false()
                        } else {
                            LangString::parse(
                                lang,
                                error_codes,
                                enable_per_target_ignores,
                                extra_info,
                            )
                        }
                    }
                    CodeBlockKind::Indented => LangString::all_false(),
                };
                if !block_info.rust {
                    continue;
                }

                let mut test_s = String::new();

                while let Some((Event::Text(s), _)) = parser.next() {
                    test_s.push_str(&s);
                }
                let text = test_s
                    .lines()
                    .map(|l| map_line(l).for_code())
                    .collect::<Vec<Cow<'_, str>>>()
                    .join("\n");

                nb_lines += doc[prev_offset..offset.start].lines().count();
                let line = tests.get_line() + nb_lines + 1;
                tests.add_test(text, block_info, line);
                prev_offset = offset.start;
            }
            Event::Start(Tag::Heading(level)) => {
                register_header = Some(level as u32);
            }
            Event::Text(ref s) if register_header.is_some() => {
                let level = register_header.unwrap();
                if s.is_empty() {
                    tests.register_header("", level);
                } else {
                    tests.register_header(s, level);
                }
                register_header = None;
            }
            _ => {}
        }
    }
}

pub struct ExtraInfo<'a, 'b> {
    hir_id: Option<HirId>,
    item_did: Option<DefId>,
    sp: Span,
    tcx: &'a TyCtxt<'b>,
}

impl<'a, 'b> ExtraInfo<'a, 'b> {
    pub fn new(tcx: &'a TyCtxt<'b>, hir_id: HirId, sp: Span) -> ExtraInfo<'a, 'b> {
        ExtraInfo { hir_id: Some(hir_id), item_did: None, sp, tcx }
    }

    pub fn new_did(tcx: &'a TyCtxt<'b>, did: DefId, sp: Span) -> ExtraInfo<'a, 'b> {
        ExtraInfo { hir_id: None, item_did: Some(did), sp, tcx }
    }

    fn error_invalid_codeblock_attr(&self, msg: &str, help: &str) {
        let hir_id = match (self.hir_id, self.item_did) {
            (Some(h), _) => h,
            (None, Some(item_did)) => {
                match item_did.as_local() {
                    Some(item_did) => self.tcx.hir().local_def_id_to_hir_id(item_did),
                    None => {
                        // If non-local, no need to check anything.
                        return;
                    }
                }
            }
            (None, None) => return,
        };
        self.tcx.struct_span_lint_hir(
            lint::builtin::INVALID_CODEBLOCK_ATTRIBUTES,
            hir_id,
            self.sp,
            |lint| {
                let mut diag = lint.build(msg);
                diag.help(help);
                diag.emit();
            },
        );
    }
}

#[derive(Eq, PartialEq, Clone, Debug)]
pub struct LangString {
    original: String,
    pub should_panic: bool,
    pub no_run: bool,
    pub ignore: Ignore,
    pub rust: bool,
    pub test_harness: bool,
    pub compile_fail: bool,
    pub error_codes: Vec<String>,
    pub allow_fail: bool,
    pub edition: Option<Edition>,
}

#[derive(Eq, PartialEq, Clone, Debug)]
pub enum Ignore {
    All,
    None,
    Some(Vec<String>),
}

impl LangString {
    fn all_false() -> LangString {
        LangString {
            original: String::new(),
            should_panic: false,
            no_run: false,
            ignore: Ignore::None,
            rust: true, // NB This used to be `notrust = false`
            test_harness: false,
            compile_fail: false,
            error_codes: Vec::new(),
            allow_fail: false,
            edition: None,
        }
    }

    fn parse_without_check(
        string: &str,
        allow_error_code_check: ErrorCodes,
        enable_per_target_ignores: bool,
    ) -> LangString {
        Self::parse(string, allow_error_code_check, enable_per_target_ignores, None)
    }

    fn parse(
        string: &str,
        allow_error_code_check: ErrorCodes,
        enable_per_target_ignores: bool,
        extra: Option<&ExtraInfo<'_, '_>>,
    ) -> LangString {
        let allow_error_code_check = allow_error_code_check.as_bool();
        let mut seen_rust_tags = false;
        let mut seen_other_tags = false;
        let mut data = LangString::all_false();
        let mut ignores = vec![];

        data.original = string.to_owned();
        let tokens = string.split(|c: char| !(c == '_' || c == '-' || c.is_alphanumeric()));

        for token in tokens {
            match token.trim() {
                "" => {}
                "should_panic" => {
                    data.should_panic = true;
                    seen_rust_tags = !seen_other_tags;
                }
                "no_run" => {
                    data.no_run = true;
                    seen_rust_tags = !seen_other_tags;
                }
                "ignore" => {
                    data.ignore = Ignore::All;
                    seen_rust_tags = !seen_other_tags;
                }
                x if x.starts_with("ignore-") => {
                    if enable_per_target_ignores {
                        ignores.push(x.trim_start_matches("ignore-").to_owned());
                        seen_rust_tags = !seen_other_tags;
                    }
                }
                "allow_fail" => {
                    data.allow_fail = true;
                    seen_rust_tags = !seen_other_tags;
                }
                "rust" => {
                    data.rust = true;
                    seen_rust_tags = true;
                }
                "test_harness" => {
                    data.test_harness = true;
                    seen_rust_tags = !seen_other_tags || seen_rust_tags;
                }
                "compile_fail" => {
                    data.compile_fail = true;
                    seen_rust_tags = !seen_other_tags || seen_rust_tags;
                    data.no_run = true;
                }
                x if x.starts_with("edition") => {
                    data.edition = x[7..].parse::<Edition>().ok();
                }
                x if allow_error_code_check && x.starts_with('E') && x.len() == 5 => {
                    if x[1..].parse::<u32>().is_ok() {
                        data.error_codes.push(x.to_owned());
                        seen_rust_tags = !seen_other_tags || seen_rust_tags;
                    } else {
                        seen_other_tags = true;
                    }
                }
                x if extra.is_some() => {
                    let s = x.to_lowercase();
                    match if s == "compile-fail" || s == "compile_fail" || s == "compilefail" {
                        Some((
                            "compile_fail",
                            "the code block will either not be tested if not marked as a rust one \
                             or won't fail if it compiles successfully",
                        ))
                    } else if s == "should-panic" || s == "should_panic" || s == "shouldpanic" {
                        Some((
                            "should_panic",
                            "the code block will either not be tested if not marked as a rust one \
                             or won't fail if it doesn't panic when running",
                        ))
                    } else if s == "no-run" || s == "no_run" || s == "norun" {
                        Some((
                            "no_run",
                            "the code block will either not be tested if not marked as a rust one \
                             or will be run (which you might not want)",
                        ))
                    } else if s == "allow-fail" || s == "allow_fail" || s == "allowfail" {
                        Some((
                            "allow_fail",
                            "the code block will either not be tested if not marked as a rust one \
                             or will be run (which you might not want)",
                        ))
                    } else if s == "test-harness" || s == "test_harness" || s == "testharness" {
                        Some((
                            "test_harness",
                            "the code block will either not be tested if not marked as a rust one \
                             or the code will be wrapped inside a main function",
                        ))
                    } else {
                        None
                    } {
                        Some((flag, help)) => {
                            if let Some(ref extra) = extra {
                                extra.error_invalid_codeblock_attr(
                                    &format!("unknown attribute `{}`. Did you mean `{}`?", x, flag),
                                    help,
                                );
                            }
                        }
                        None => {}
                    }
                    seen_other_tags = true;
                }
                _ => seen_other_tags = true,
            }
        }
        // ignore-foo overrides ignore
        if !ignores.is_empty() {
            data.ignore = Ignore::Some(ignores);
        }

        data.rust &= !seen_other_tags || seen_rust_tags;

        data
    }
}

impl Markdown<'_> {
    pub fn into_string(self) -> String {
        let Markdown(md, links, mut ids, codes, edition, playground) = self;

        // This is actually common enough to special-case
        if md.is_empty() {
            return String::new();
        }
        let mut replacer = |broken_link: BrokenLink<'_>| {
            if let Some(link) =
                links.iter().find(|link| &*link.original_text == broken_link.reference)
            {
                Some((link.href.as_str().into(), link.new_text.as_str().into()))
            } else {
                None
            }
        };

        let p = Parser::new_with_broken_link_callback(md, opts(), Some(&mut replacer));

        let mut s = String::with_capacity(md.len() * 3 / 2);

        let p = HeadingLinks::new(p, None, &mut ids);
        let p = LinkReplacer::new(p, links);
        let p = CodeBlocks::new(p, codes, edition, playground);
        let p = Footnotes::new(p);
        html::push_html(&mut s, p);

        s
    }
}

impl MarkdownWithToc<'_> {
    pub fn into_string(self) -> String {
        let MarkdownWithToc(md, mut ids, codes, edition, playground) = self;

        let p = Parser::new_ext(md, opts());

        let mut s = String::with_capacity(md.len() * 3 / 2);

        let mut toc = TocBuilder::new();

        {
            let p = HeadingLinks::new(p, Some(&mut toc), &mut ids);
            let p = CodeBlocks::new(p, codes, edition, playground);
            let p = Footnotes::new(p);
            html::push_html(&mut s, p);
        }

        format!("<nav id=\"TOC\">{}</nav>{}", toc.into_toc().print(), s)
    }
}

impl MarkdownHtml<'_> {
    pub fn into_string(self) -> String {
        let MarkdownHtml(md, mut ids, codes, edition, playground) = self;

        // This is actually common enough to special-case
        if md.is_empty() {
            return String::new();
        }
        let p = Parser::new_ext(md, opts());

        // Treat inline HTML as plain text.
        let p = p.map(|event| match event {
            Event::Html(text) => Event::Text(text),
            _ => event,
        });

        let mut s = String::with_capacity(md.len() * 3 / 2);

        let p = HeadingLinks::new(p, None, &mut ids);
        let p = CodeBlocks::new(p, codes, edition, playground);
        let p = Footnotes::new(p);
        html::push_html(&mut s, p);

        s
    }
}

impl MarkdownSummaryLine<'_> {
    pub fn into_string(self) -> String {
        let MarkdownSummaryLine(md, links) = self;
        // This is actually common enough to special-case
        if md.is_empty() {
            return String::new();
        }

        let mut replacer = |broken_link: BrokenLink<'_>| {
            if let Some(link) =
                links.iter().find(|link| &*link.original_text == broken_link.reference)
            {
                Some((link.href.as_str().into(), link.new_text.as_str().into()))
            } else {
                None
            }
        };

        let p = Parser::new_with_broken_link_callback(
            md,
            Options::ENABLE_STRIKETHROUGH,
            Some(&mut replacer),
        );

        let mut s = String::new();

        html::push_html(&mut s, LinkReplacer::new(SummaryLine::new(p), links));

        s
    }
}

/// Renders the first paragraph of the provided markdown as plain text.
///
/// - Headings, links, and formatting are stripped.
/// - Inline code is rendered as-is, surrounded by backticks.
/// - HTML and code blocks are ignored.
pub fn plain_text_summary(md: &str) -> String {
    if md.is_empty() {
        return String::new();
    }

    let mut s = String::with_capacity(md.len() * 3 / 2);

    for event in Parser::new_ext(md, Options::ENABLE_STRIKETHROUGH) {
        match &event {
            Event::Text(text) => s.push_str(text),
            Event::Code(code) => {
                s.push('`');
                s.push_str(code);
                s.push('`');
            }
            Event::HardBreak | Event::SoftBreak => s.push(' '),
            Event::Start(Tag::CodeBlock(..)) => break,
            Event::End(Tag::Paragraph) => break,
            _ => (),
        }
    }

    s
}

pub fn markdown_links(md: &str) -> Vec<(String, Option<Range<usize>>)> {
    if md.is_empty() {
        return vec![];
    }

    let mut links = vec![];
    let mut shortcut_links = vec![];

    {
        let locate = |s: &str| unsafe {
            let s_start = s.as_ptr();
            let s_end = s_start.add(s.len());
            let md_start = md.as_ptr();
            let md_end = md_start.add(md.len());
            if md_start <= s_start && s_end <= md_end {
                let start = s_start.offset_from(md_start) as usize;
                let end = s_end.offset_from(md_start) as usize;
                Some(start..end)
            } else {
                None
            }
        };

        let mut push = |link: BrokenLink<'_>| {
            // FIXME: use `link.span` instead of `locate`
            // (doing it now includes the `[]` as well as the text)
            shortcut_links.push((link.reference.to_owned(), locate(link.reference)));
            None
        };
        let p = Parser::new_with_broken_link_callback(md, opts(), Some(&mut push));

        // There's no need to thread an IdMap through to here because
        // the IDs generated aren't going to be emitted anywhere.
        let mut ids = IdMap::new();
        let iter = Footnotes::new(HeadingLinks::new(p, None, &mut ids));

        for ev in iter {
            if let Event::Start(Tag::Link(_, dest, _)) = ev {
                debug!("found link: {}", dest);
                links.push(match dest {
                    CowStr::Borrowed(s) => (s.to_owned(), locate(s)),
                    s @ (CowStr::Boxed(..) | CowStr::Inlined(..)) => (s.into_string(), None),
                });
            }
        }
    }

    links.append(&mut shortcut_links);

    links
}

#[derive(Debug)]
crate struct RustCodeBlock {
    /// The range in the markdown that the code block occupies. Note that this includes the fences
    /// for fenced code blocks.
    pub range: Range<usize>,
    /// The range in the markdown that the code within the code block occupies.
    pub code: Range<usize>,
    pub is_fenced: bool,
    pub syntax: Option<String>,
}

/// Returns a range of bytes for each code block in the markdown that is tagged as `rust` or
/// untagged (and assumed to be rust).
crate fn rust_code_blocks(md: &str, extra_info: &ExtraInfo<'_, '_>) -> Vec<RustCodeBlock> {
    let mut code_blocks = vec![];

    if md.is_empty() {
        return code_blocks;
    }

    let mut p = Parser::new_ext(md, opts()).into_offset_iter();

    while let Some((event, offset)) = p.next() {
        if let Event::Start(Tag::CodeBlock(syntax)) = event {
            let (syntax, code_start, code_end, range, is_fenced) = match syntax {
                CodeBlockKind::Fenced(syntax) => {
                    let syntax = syntax.as_ref();
                    let lang_string = if syntax.is_empty() {
                        LangString::all_false()
                    } else {
                        LangString::parse(&*syntax, ErrorCodes::Yes, false, Some(extra_info))
                    };
                    if !lang_string.rust {
                        continue;
                    }
                    let syntax = if syntax.is_empty() { None } else { Some(syntax.to_owned()) };
                    let (code_start, mut code_end) = match p.next() {
                        Some((Event::Text(_), offset)) => (offset.start, offset.end),
                        Some((_, sub_offset)) => {
                            let code = Range { start: sub_offset.start, end: sub_offset.start };
                            code_blocks.push(RustCodeBlock {
                                is_fenced: true,
                                range: offset,
                                code,
                                syntax,
                            });
                            continue;
                        }
                        None => {
                            let code = Range { start: offset.end, end: offset.end };
                            code_blocks.push(RustCodeBlock {
                                is_fenced: true,
                                range: offset,
                                code,
                                syntax,
                            });
                            continue;
                        }
                    };
                    while let Some((Event::Text(_), offset)) = p.next() {
                        code_end = offset.end;
                    }
                    (syntax, code_start, code_end, offset, true)
                }
                CodeBlockKind::Indented => {
                    // The ending of the offset goes too far sometime so we reduce it by one in
                    // these cases.
                    if offset.end > offset.start && md.get(offset.end..=offset.end) == Some(&"\n") {
                        (
                            None,
                            offset.start,
                            offset.end,
                            Range { start: offset.start, end: offset.end - 1 },
                            false,
                        )
                    } else {
                        (None, offset.start, offset.end, offset, false)
                    }
                }
            };

            code_blocks.push(RustCodeBlock {
                is_fenced,
                range,
                code: Range { start: code_start, end: code_end },
                syntax,
            });
        }
    }

    code_blocks
}

#[derive(Clone, Default, Debug)]
pub struct IdMap {
    map: FxHashMap<String, usize>,
}

fn init_id_map() -> FxHashMap<String, usize> {
    let mut map = FxHashMap::default();
    // This is the list of IDs used by rustdoc templates.
    map.insert("mainThemeStyle".to_owned(), 1);
    map.insert("themeStyle".to_owned(), 1);
    map.insert("theme-picker".to_owned(), 1);
    map.insert("theme-choices".to_owned(), 1);
    map.insert("settings-menu".to_owned(), 1);
    map.insert("main".to_owned(), 1);
    map.insert("search".to_owned(), 1);
    map.insert("crate-search".to_owned(), 1);
    map.insert("render-detail".to_owned(), 1);
    map.insert("toggle-all-docs".to_owned(), 1);
    map.insert("all-types".to_owned(), 1);
    map.insert("default-settings".to_owned(), 1);
    // This is the list of IDs used by rustdoc sections.
    map.insert("fields".to_owned(), 1);
    map.insert("variants".to_owned(), 1);
    map.insert("implementors-list".to_owned(), 1);
    map.insert("synthetic-implementors-list".to_owned(), 1);
    map.insert("implementations".to_owned(), 1);
    map.insert("trait-implementations".to_owned(), 1);
    map.insert("synthetic-implementations".to_owned(), 1);
    map.insert("blanket-implementations".to_owned(), 1);
    map.insert("deref-methods".to_owned(), 1);
    map
}

impl IdMap {
    pub fn new() -> Self {
        IdMap { map: init_id_map() }
    }

    pub fn populate<I: IntoIterator<Item = String>>(&mut self, ids: I) {
        for id in ids {
            let _ = self.derive(id);
        }
    }

    pub fn reset(&mut self) {
        self.map = init_id_map();
    }

    pub fn derive(&mut self, candidate: String) -> String {
        let id = match self.map.get_mut(&candidate) {
            None => candidate,
            Some(a) => {
                let id = format!("{}-{}", candidate, *a);
                *a += 1;
                id
            }
        };

        self.map.insert(id.clone(), 1);
        id
    }
}
