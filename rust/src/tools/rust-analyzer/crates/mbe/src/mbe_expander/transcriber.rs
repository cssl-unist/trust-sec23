//! Transcriber takes a template, like `fn $ident() {}`, a set of bindings like
//! `$ident => foo`, interpolates variables in the template, to get `fn foo() {}`

use syntax::SmolStr;

use super::ExpandResult;
use crate::{
    mbe_expander::{Binding, Bindings, Fragment},
    parser::{parse_template, Op, RepeatKind, Separator},
    ExpandError,
};

impl Bindings {
    fn contains(&self, name: &str) -> bool {
        self.inner.contains_key(name)
    }

    fn get(&self, name: &str, nesting: &mut [NestingState]) -> Result<&Fragment, ExpandError> {
        let mut b = self.inner.get(name).ok_or_else(|| {
            ExpandError::BindingError(format!("could not find binding `{}`", name))
        })?;
        for nesting_state in nesting.iter_mut() {
            nesting_state.hit = true;
            b = match b {
                Binding::Fragment(_) => break,
                Binding::Nested(bs) => bs.get(nesting_state.idx).ok_or_else(|| {
                    nesting_state.at_end = true;
                    ExpandError::BindingError(format!("could not find nested binding `{}`", name))
                })?,
                Binding::Empty => {
                    nesting_state.at_end = true;
                    return Err(ExpandError::BindingError(format!(
                        "could not find empty binding `{}`",
                        name
                    )));
                }
            };
        }
        match b {
            Binding::Fragment(it) => Ok(it),
            Binding::Nested(_) => Err(ExpandError::BindingError(format!(
                "expected simple binding, found nested binding `{}`",
                name
            ))),
            Binding::Empty => Err(ExpandError::BindingError(format!(
                "expected simple binding, found empty binding `{}`",
                name
            ))),
        }
    }
}

pub(super) fn transcribe(template: &tt::Subtree, bindings: &Bindings) -> ExpandResult<tt::Subtree> {
    assert!(template.delimiter == None);
    let mut ctx = ExpandCtx { bindings: &bindings, nesting: Vec::new() };
    let mut arena: Vec<tt::TokenTree> = Vec::new();
    expand_subtree(&mut ctx, template, &mut arena)
}

#[derive(Debug)]
struct NestingState {
    idx: usize,
    /// `hit` is currently necessary to tell `expand_repeat` if it should stop
    /// because there is no variable in use by the current repetition
    hit: bool,
    /// `at_end` is currently necessary to tell `expand_repeat` if it should stop
    /// because there is no more value avaible for the current repetition
    at_end: bool,
}

#[derive(Debug)]
struct ExpandCtx<'a> {
    bindings: &'a Bindings,
    nesting: Vec<NestingState>,
}

fn expand_subtree(
    ctx: &mut ExpandCtx,
    template: &tt::Subtree,
    arena: &mut Vec<tt::TokenTree>,
) -> ExpandResult<tt::Subtree> {
    // remember how many elements are in the arena now - when returning, we want to drain exactly how many elements we added. This way, the recursive uses of the arena get their own "view" of the arena, but will reuse the allocation
    let start_elements = arena.len();
    let mut err = None;
    for op in parse_template(template) {
        let op = match op {
            Ok(op) => op,
            Err(e) => {
                err = Some(e);
                break;
            }
        };
        match op {
            Op::TokenTree(tt @ tt::TokenTree::Leaf(..)) => arena.push(tt.clone()),
            Op::TokenTree(tt::TokenTree::Subtree(tt)) => {
                let ExpandResult(tt, e) = expand_subtree(ctx, tt, arena);
                err = err.or(e);
                arena.push(tt.into());
            }
            Op::Var { name, kind: _ } => {
                let ExpandResult(fragment, e) = expand_var(ctx, name);
                err = err.or(e);
                push_fragment(arena, fragment);
            }
            Op::Repeat { subtree, kind, separator } => {
                let ExpandResult(fragment, e) = expand_repeat(ctx, subtree, kind, separator, arena);
                err = err.or(e);
                push_fragment(arena, fragment)
            }
        }
    }
    // drain the elements added in this instance of expand_subtree
    let tts = arena.drain(start_elements..arena.len()).collect();
    ExpandResult(tt::Subtree { delimiter: template.delimiter, token_trees: tts }, err)
}

fn expand_var(ctx: &mut ExpandCtx, v: &SmolStr) -> ExpandResult<Fragment> {
    if v == "crate" {
        // We simply produce identifier `$crate` here. And it will be resolved when lowering ast to Path.
        let tt =
            tt::Leaf::from(tt::Ident { text: "$crate".into(), id: tt::TokenId::unspecified() })
                .into();
        ExpandResult::ok(Fragment::Tokens(tt))
    } else if !ctx.bindings.contains(v) {
        // Note that it is possible to have a `$var` inside a macro which is not bound.
        // For example:
        // ```
        // macro_rules! foo {
        //     ($a:ident, $b:ident, $c:tt) => {
        //         macro_rules! bar {
        //             ($bi:ident) => {
        //                 fn $bi() -> u8 {$c}
        //             }
        //         }
        //     }
        // ```
        // We just treat it a normal tokens
        let tt = tt::Subtree {
            delimiter: None,
            token_trees: vec![
                tt::Leaf::from(tt::Punct {
                    char: '$',
                    spacing: tt::Spacing::Alone,
                    id: tt::TokenId::unspecified(),
                })
                .into(),
                tt::Leaf::from(tt::Ident { text: v.clone(), id: tt::TokenId::unspecified() })
                    .into(),
            ],
        }
        .into();
        ExpandResult::ok(Fragment::Tokens(tt))
    } else {
        ctx.bindings.get(&v, &mut ctx.nesting).map_or_else(
            |e| ExpandResult(Fragment::Tokens(tt::TokenTree::empty()), Some(e)),
            |b| ExpandResult::ok(b.clone()),
        )
    }
}

fn expand_repeat(
    ctx: &mut ExpandCtx,
    template: &tt::Subtree,
    kind: RepeatKind,
    separator: Option<Separator>,
    arena: &mut Vec<tt::TokenTree>,
) -> ExpandResult<Fragment> {
    let mut buf: Vec<tt::TokenTree> = Vec::new();
    ctx.nesting.push(NestingState { idx: 0, at_end: false, hit: false });
    // Dirty hack to make macro-expansion terminate.
    // This should be replaced by a proper macro-by-example implementation
    let limit = 65536;
    let mut has_seps = 0;
    let mut counter = 0;

    loop {
        let ExpandResult(mut t, e) = expand_subtree(ctx, template, arena);
        let nesting_state = ctx.nesting.last_mut().unwrap();
        if nesting_state.at_end || !nesting_state.hit {
            break;
        }
        nesting_state.idx += 1;
        nesting_state.hit = false;

        counter += 1;
        if counter == limit {
            log::warn!(
                "expand_tt excced in repeat pattern exceed limit => {:#?}\n{:#?}",
                template,
                ctx
            );
            break;
        }

        if e.is_some() {
            continue;
        }

        t.delimiter = None;
        push_subtree(&mut buf, t);

        if let Some(ref sep) = separator {
            match sep {
                Separator::Ident(ident) => {
                    has_seps = 1;
                    buf.push(tt::Leaf::from(ident.clone()).into());
                }
                Separator::Literal(lit) => {
                    has_seps = 1;
                    buf.push(tt::Leaf::from(lit.clone()).into());
                }

                Separator::Puncts(puncts) => {
                    has_seps = puncts.len();
                    for punct in puncts {
                        buf.push(tt::Leaf::from(*punct).into());
                    }
                }
            }
        }

        if RepeatKind::ZeroOrOne == kind {
            break;
        }
    }

    ctx.nesting.pop().unwrap();
    for _ in 0..has_seps {
        buf.pop();
    }

    // Check if it is a single token subtree without any delimiter
    // e.g {Delimiter:None> ['>'] /Delimiter:None>}
    let tt = tt::Subtree { delimiter: None, token_trees: buf }.into();

    if RepeatKind::OneOrMore == kind && counter == 0 {
        return ExpandResult(Fragment::Tokens(tt), Some(ExpandError::UnexpectedToken));
    }
    ExpandResult::ok(Fragment::Tokens(tt))
}

fn push_fragment(buf: &mut Vec<tt::TokenTree>, fragment: Fragment) {
    match fragment {
        Fragment::Tokens(tt::TokenTree::Subtree(tt)) => push_subtree(buf, tt),
        Fragment::Tokens(tt) | Fragment::Ast(tt) => buf.push(tt),
    }
}

fn push_subtree(buf: &mut Vec<tt::TokenTree>, tt: tt::Subtree) {
    match tt.delimiter {
        None => buf.extend(tt.token_trees),
        _ => buf.push(tt.into()),
    }
}
