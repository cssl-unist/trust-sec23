use rustc_errors::{Applicability, DiagnosticBuilder};

use rustc_ast::ptr::P;
use rustc_ast::token::{self, TokenKind};
use rustc_ast::tokenstream::{DelimSpan, TokenStream, TokenTree};
use rustc_ast::{self as ast, *};
use rustc_ast_pretty::pprust;
use rustc_expand::base::*;
use rustc_parse::parser::Parser;
use rustc_span::symbol::{sym, Ident, Symbol};
use rustc_span::{Span, DUMMY_SP};

pub fn expand_assert<'cx>(
    cx: &'cx mut ExtCtxt<'_>,
    sp: Span,
    tts: TokenStream,
) -> Box<dyn MacResult + 'cx> {
    let Assert { cond_expr, custom_message } = match parse_assert(cx, sp, tts) {
        Ok(assert) => assert,
        Err(mut err) => {
            err.emit();
            return DummyResult::any(sp);
        }
    };

    // `core::panic` and `std::panic` are different macros, so we use call-site
    // context to pick up whichever is currently in scope.
    let sp = cx.with_call_site_ctxt(sp);
    let tokens = custom_message.unwrap_or_else(|| {
        TokenStream::from(TokenTree::token(
            TokenKind::lit(
                token::Str,
                Symbol::intern(&format!(
                    "assertion failed: {}",
                    pprust::expr_to_string(&cond_expr).escape_debug()
                )),
                None,
            ),
            DUMMY_SP,
        ))
    });
    let args = P(MacArgs::Delimited(DelimSpan::from_single(sp), MacDelimiter::Parenthesis, tokens));
    let panic_call = MacCall {
        path: Path::from_ident(Ident::new(sym::panic, sp)),
        args,
        prior_type_ascription: None,
    };
    let if_expr = cx.expr_if(
        sp,
        cx.expr(sp, ExprKind::Unary(UnOp::Not, cond_expr)),
        cx.expr(sp, ExprKind::MacCall(panic_call)),
        None,
    );
    MacEager::expr(if_expr)
}

struct Assert {
    cond_expr: P<ast::Expr>,
    custom_message: Option<TokenStream>,
}

fn parse_assert<'a>(
    cx: &mut ExtCtxt<'a>,
    sp: Span,
    stream: TokenStream,
) -> Result<Assert, DiagnosticBuilder<'a>> {
    let mut parser = cx.new_parser_from_tts(stream);

    if parser.token == token::Eof {
        let mut err = cx.struct_span_err(sp, "macro requires a boolean expression as an argument");
        err.span_label(sp, "boolean expression required");
        return Err(err);
    }

    let cond_expr = parser.parse_expr()?;

    // Some crates use the `assert!` macro in the following form (note extra semicolon):
    //
    // assert!(
    //     my_function();
    // );
    //
    // Emit an error about semicolon and suggest removing it.
    if parser.token == token::Semi {
        let mut err = cx.struct_span_err(sp, "macro requires an expression as an argument");
        err.span_suggestion(
            parser.token.span,
            "try removing semicolon",
            String::new(),
            Applicability::MaybeIncorrect,
        );
        err.emit();

        parser.bump();
    }

    // Some crates use the `assert!` macro in the following form (note missing comma before
    // message):
    //
    // assert!(true "error message");
    //
    // Emit an error and suggest inserting a comma.
    let custom_message =
        if let token::Literal(token::Lit { kind: token::Str, .. }) = parser.token.kind {
            let mut err = cx.struct_span_err(parser.token.span, "unexpected string literal");
            let comma_span = parser.prev_token.span.shrink_to_hi();
            err.span_suggestion_short(
                comma_span,
                "try adding a comma",
                ", ".to_string(),
                Applicability::MaybeIncorrect,
            );
            err.emit();

            parse_custom_message(&mut parser)
        } else if parser.eat(&token::Comma) {
            parse_custom_message(&mut parser)
        } else {
            None
        };

    if parser.token != token::Eof {
        return parser.unexpected();
    }

    Ok(Assert { cond_expr, custom_message })
}

fn parse_custom_message(parser: &mut Parser<'_>) -> Option<TokenStream> {
    let ts = parser.parse_tokens();
    if !ts.is_empty() { Some(ts) } else { None }
}
