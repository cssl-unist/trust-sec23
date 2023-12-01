//! Renders a bit of code as HTML.

use base_db::SourceDatabase;
use oorandom::Rand32;
use stdx::format_to;
use syntax::{AstNode, TextRange, TextSize};

use crate::{syntax_highlighting::highlight, FileId, RootDatabase};

pub(crate) fn highlight_as_html(db: &RootDatabase, file_id: FileId, rainbow: bool) -> String {
    let parse = db.parse(file_id);

    fn rainbowify(seed: u64) -> String {
        let mut rng = Rand32::new(seed);
        format!(
            "hsl({h},{s}%,{l}%)",
            h = rng.rand_range(0..361),
            s = rng.rand_range(42..99),
            l = rng.rand_range(40..91),
        )
    }

    let ranges = highlight(db, file_id, None, false);
    let text = parse.tree().syntax().to_string();
    let mut prev_pos = TextSize::from(0);
    let mut buf = String::new();
    buf.push_str(&STYLE);
    buf.push_str("<pre><code>");
    for range in &ranges {
        if range.range.start() > prev_pos {
            let curr = &text[TextRange::new(prev_pos, range.range.start())];
            let text = html_escape(curr);
            buf.push_str(&text);
        }
        let curr = &text[TextRange::new(range.range.start(), range.range.end())];

        let class = range.highlight.to_string().replace('.', " ");
        let color = match (rainbow, range.binding_hash) {
            (true, Some(hash)) => {
                format!(" data-binding-hash=\"{}\" style=\"color: {};\"", hash, rainbowify(hash))
            }
            _ => "".into(),
        };
        format_to!(buf, "<span class=\"{}\"{}>{}</span>", class, color, html_escape(curr));

        prev_pos = range.range.end();
    }
    // Add the remaining (non-highlighted) text
    let curr = &text[TextRange::new(prev_pos, TextSize::of(&text))];
    let text = html_escape(curr);
    buf.push_str(&text);
    buf.push_str("</code></pre>");
    buf
}

//FIXME: like, real html escaping
fn html_escape(text: &str) -> String {
    text.replace("<", "&lt;").replace(">", "&gt;")
}

const STYLE: &str = "
<style>
body                { margin: 0; }
pre                 { color: #DCDCCC; background: #3F3F3F; font-size: 22px; padding: 0.4em; }

.lifetime           { color: #DFAF8F; font-style: italic; }
.comment            { color: #7F9F7F; }
.documentation      { color: #629755; }
.injected           { opacity: 0.65 ; }
.struct, .enum      { color: #7CB8BB; }
.enum_variant       { color: #BDE0F3; }
.string_literal     { color: #CC9393; }
.field              { color: #94BFF3; }
.function           { color: #93E0E3; }
.function.unsafe    { color: #BC8383; }
.operator.unsafe    { color: #BC8383; }
.parameter          { color: #94BFF3; }
.text               { color: #DCDCCC; }
.type               { color: #7CB8BB; }
.builtin_type       { color: #8CD0D3; }
.type_param         { color: #DFAF8F; }
.attribute          { color: #94BFF3; }
.numeric_literal    { color: #BFEBBF; }
.bool_literal       { color: #BFE6EB; }
.macro              { color: #94BFF3; }
.module             { color: #AFD8AF; }
.value_param        { color: #DCDCCC; }
.variable           { color: #DCDCCC; }
.format_specifier   { color: #CC696B; }
.mutable            { text-decoration: underline; }
.escape_sequence    { color: #94BFF3; }
.keyword            { color: #F0DFAF; font-weight: bold; }
.keyword.unsafe     { color: #BC8383; font-weight: bold; }
.control            { font-style: italic; }

.unresolved_reference { color: #FC5555; text-decoration: wavy underline; }
</style>
";
