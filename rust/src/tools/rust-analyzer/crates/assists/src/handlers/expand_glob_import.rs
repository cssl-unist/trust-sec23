use either::Either;
use hir::{AssocItem, MacroDef, Module, ModuleDef, Name, PathResolution, ScopeDef};
use ide_db::{
    defs::{classify_name_ref, Definition, NameRefClass},
    search::SearchScope,
};
use syntax::{
    algo,
    ast::{self, make},
    AstNode, Direction, SyntaxNode, SyntaxToken, T,
};

use crate::{
    assist_context::{AssistBuilder, AssistContext, Assists},
    AssistId, AssistKind,
};

// Assist: expand_glob_import
//
// Expands glob imports.
//
// ```
// mod foo {
//     pub struct Bar;
//     pub struct Baz;
// }
//
// use foo::*<|>;
//
// fn qux(bar: Bar, baz: Baz) {}
// ```
// ->
// ```
// mod foo {
//     pub struct Bar;
//     pub struct Baz;
// }
//
// use foo::{Baz, Bar};
//
// fn qux(bar: Bar, baz: Baz) {}
// ```
pub(crate) fn expand_glob_import(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let star = ctx.find_token_at_offset(T![*])?;
    let (parent, mod_path) = find_parent_and_path(&star)?;
    let target_module = match ctx.sema.resolve_path(&mod_path)? {
        PathResolution::Def(ModuleDef::Module(it)) => it,
        _ => return None,
    };

    let current_scope = ctx.sema.scope(&star.parent());
    let current_module = current_scope.module()?;

    let refs_in_target = find_refs_in_mod(ctx, target_module, Some(current_module))?;
    let imported_defs = find_imported_defs(ctx, star)?;
    let names_to_import = find_names_to_import(ctx, refs_in_target, imported_defs);

    let target = parent.clone().either(|n| n.syntax().clone(), |n| n.syntax().clone());
    acc.add(
        AssistId("expand_glob_import", AssistKind::RefactorRewrite),
        "Expand glob import",
        target.text_range(),
        |builder| {
            replace_ast(builder, parent, mod_path, names_to_import);
        },
    )
}

fn find_parent_and_path(
    star: &SyntaxToken,
) -> Option<(Either<ast::UseTree, ast::UseTreeList>, ast::Path)> {
    return star.ancestors().find_map(|n| {
        find_use_tree_list(n.clone())
            .and_then(|(u, p)| Some((Either::Right(u), p)))
            .or_else(|| find_use_tree(n).and_then(|(u, p)| Some((Either::Left(u), p))))
    });

    fn find_use_tree_list(n: SyntaxNode) -> Option<(ast::UseTreeList, ast::Path)> {
        let use_tree_list = ast::UseTreeList::cast(n)?;
        let path = use_tree_list.parent_use_tree().path()?;
        Some((use_tree_list, path))
    }

    fn find_use_tree(n: SyntaxNode) -> Option<(ast::UseTree, ast::Path)> {
        let use_tree = ast::UseTree::cast(n)?;
        let path = use_tree.path()?;
        Some((use_tree, path))
    }
}

#[derive(Debug, PartialEq, Clone)]
enum Def {
    ModuleDef(ModuleDef),
    MacroDef(MacroDef),
}

impl Def {
    fn is_referenced_in(&self, ctx: &AssistContext) -> bool {
        let def = match self {
            Def::ModuleDef(def) => Definition::ModuleDef(*def),
            Def::MacroDef(def) => Definition::Macro(*def),
        };

        let search_scope = SearchScope::single_file(ctx.frange.file_id);
        def.usages(&ctx.sema).in_scope(search_scope).at_least_one()
    }
}

#[derive(Debug, Clone)]
struct Ref {
    // could be alias
    visible_name: Name,
    def: Def,
}

impl Ref {
    fn from_scope_def(name: Name, scope_def: ScopeDef) -> Option<Self> {
        match scope_def {
            ScopeDef::ModuleDef(def) => Some(Ref { visible_name: name, def: Def::ModuleDef(def) }),
            ScopeDef::MacroDef(def) => Some(Ref { visible_name: name, def: Def::MacroDef(def) }),
            _ => None,
        }
    }
}

#[derive(Debug, Clone)]
struct Refs(Vec<Ref>);

impl Refs {
    fn used_refs(&self, ctx: &AssistContext) -> Refs {
        Refs(
            self.0
                .clone()
                .into_iter()
                .filter(|r| {
                    if let Def::ModuleDef(ModuleDef::Trait(tr)) = r.def {
                        if tr
                            .items(ctx.db())
                            .into_iter()
                            .find(|ai| {
                                if let AssocItem::Function(f) = *ai {
                                    Def::ModuleDef(ModuleDef::Function(f)).is_referenced_in(ctx)
                                } else {
                                    false
                                }
                            })
                            .is_some()
                        {
                            return true;
                        }
                    }

                    r.def.is_referenced_in(ctx)
                })
                .collect(),
        )
    }

    fn filter_out_by_defs(&self, defs: Vec<Def>) -> Refs {
        Refs(self.0.clone().into_iter().filter(|r| !defs.contains(&r.def)).collect())
    }
}

fn find_refs_in_mod(
    ctx: &AssistContext,
    module: Module,
    visible_from: Option<Module>,
) -> Option<Refs> {
    if let Some(from) = visible_from {
        if !is_mod_visible_from(ctx, module, from) {
            return None;
        }
    }

    let module_scope = module.scope(ctx.db(), visible_from);
    let refs = module_scope.into_iter().filter_map(|(n, d)| Ref::from_scope_def(n, d)).collect();
    Some(Refs(refs))
}

fn is_mod_visible_from(ctx: &AssistContext, module: Module, from: Module) -> bool {
    match module.parent(ctx.db()) {
        Some(parent) => {
            parent.visibility_of(ctx.db(), &ModuleDef::Module(module)).map_or(true, |vis| {
                vis.is_visible_from(ctx.db(), from.into()) && is_mod_visible_from(ctx, parent, from)
            })
        }
        None => true,
    }
}

// looks for name refs in parent use block's siblings
//
// mod bar {
//     mod qux {
//         struct Qux;
//     }
//
//     pub use qux::Qux;
// }
//
// ↓ ---------------
// use foo::*<|>;
// use baz::Baz;
// ↑ ---------------
fn find_imported_defs(ctx: &AssistContext, star: SyntaxToken) -> Option<Vec<Def>> {
    let parent_use_item_syntax =
        star.ancestors().find_map(|n| if ast::Use::can_cast(n.kind()) { Some(n) } else { None })?;

    Some(
        [Direction::Prev, Direction::Next]
            .iter()
            .map(|dir| {
                parent_use_item_syntax
                    .siblings(dir.to_owned())
                    .filter(|n| ast::Use::can_cast(n.kind()))
            })
            .flatten()
            .filter_map(|n| Some(n.descendants().filter_map(ast::NameRef::cast)))
            .flatten()
            .filter_map(|r| match classify_name_ref(&ctx.sema, &r)? {
                NameRefClass::Definition(Definition::ModuleDef(def)) => Some(Def::ModuleDef(def)),
                NameRefClass::Definition(Definition::Macro(def)) => Some(Def::MacroDef(def)),
                _ => None,
            })
            .collect(),
    )
}

fn find_names_to_import(
    ctx: &AssistContext,
    refs_in_target: Refs,
    imported_defs: Vec<Def>,
) -> Vec<Name> {
    let used_refs = refs_in_target.used_refs(ctx).filter_out_by_defs(imported_defs);
    used_refs.0.iter().map(|r| r.visible_name.clone()).collect()
}

fn replace_ast(
    builder: &mut AssistBuilder,
    parent: Either<ast::UseTree, ast::UseTreeList>,
    path: ast::Path,
    names_to_import: Vec<Name>,
) {
    let existing_use_trees = match parent.clone() {
        Either::Left(_) => vec![],
        Either::Right(u) => u
            .use_trees()
            .filter(|n|
            // filter out star
            n.star_token().is_none())
            .collect(),
    };

    let new_use_trees: Vec<ast::UseTree> = names_to_import
        .iter()
        .map(|n| {
            let path = make::path_unqualified(make::path_segment(make::name_ref(&n.to_string())));
            make::use_tree(path, None, None, false)
        })
        .collect();

    let use_trees = [&existing_use_trees[..], &new_use_trees[..]].concat();

    match use_trees.as_slice() {
        [name] => {
            if let Some(end_path) = name.path() {
                let replacement = make::use_tree(
                    make::path_from_text(&format!("{}::{}", path, end_path)),
                    None,
                    None,
                    false,
                );

                algo::diff(
                    &parent.either(|n| n.syntax().clone(), |n| n.syntax().clone()),
                    replacement.syntax(),
                )
                .into_text_edit(builder.text_edit_builder());
            }
        }
        names => {
            let replacement = match parent {
                Either::Left(_) => {
                    make::use_tree(path, Some(make::use_tree_list(names.to_owned())), None, false)
                        .syntax()
                        .clone()
                }
                Either::Right(_) => make::use_tree_list(names.to_owned()).syntax().clone(),
            };

            algo::diff(
                &parent.either(|n| n.syntax().clone(), |n| n.syntax().clone()),
                &replacement,
            )
            .into_text_edit(builder.text_edit_builder());
        }
    };
}

#[cfg(test)]
mod tests {
    use crate::tests::{check_assist, check_assist_not_applicable};

    use super::*;

    #[test]
    fn expanding_glob_import() {
        check_assist(
            expand_glob_import,
            r"
mod foo {
    pub struct Bar;
    pub struct Baz;
    pub struct Qux;

    pub fn f() {}
}

use foo::*<|>;

fn qux(bar: Bar, baz: Baz) {
    f();
}
",
            r"
mod foo {
    pub struct Bar;
    pub struct Baz;
    pub struct Qux;

    pub fn f() {}
}

use foo::{Baz, Bar, f};

fn qux(bar: Bar, baz: Baz) {
    f();
}
",
        )
    }

    #[test]
    fn expanding_glob_import_with_existing_explicit_names() {
        check_assist(
            expand_glob_import,
            r"
mod foo {
    pub struct Bar;
    pub struct Baz;
    pub struct Qux;

    pub fn f() {}
}

use foo::{*<|>, f};

fn qux(bar: Bar, baz: Baz) {
    f();
}
",
            r"
mod foo {
    pub struct Bar;
    pub struct Baz;
    pub struct Qux;

    pub fn f() {}
}

use foo::{f, Baz, Bar};

fn qux(bar: Bar, baz: Baz) {
    f();
}
",
        )
    }

    #[test]
    fn expanding_glob_import_with_existing_uses_in_same_module() {
        check_assist(
            expand_glob_import,
            r"
mod foo {
    pub struct Bar;
    pub struct Baz;
    pub struct Qux;

    pub fn f() {}
}

use foo::Bar;
use foo::{*<|>, f};

fn qux(bar: Bar, baz: Baz) {
    f();
}
",
            r"
mod foo {
    pub struct Bar;
    pub struct Baz;
    pub struct Qux;

    pub fn f() {}
}

use foo::Bar;
use foo::{f, Baz};

fn qux(bar: Bar, baz: Baz) {
    f();
}
",
        )
    }

    #[test]
    fn expanding_nested_glob_import() {
        check_assist(
            expand_glob_import,
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}
    }
}

use foo::{bar::{*<|>, f}, baz::*};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
}
",
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}
    }
}

use foo::{bar::{f, Baz, Bar}, baz::*};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
}
",
        );

        check_assist(
            expand_glob_import,
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}
    }
}

use foo::{bar::{Bar, Baz, f}, baz::*<|>};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
}
",
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}
    }
}

use foo::{bar::{Bar, Baz, f}, baz::g};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
}
",
        );

        check_assist(
            expand_glob_import,
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}

        pub mod qux {
            pub fn h() {}
            pub fn m() {}

            pub mod q {
                pub fn j() {}
            }
        }
    }
}

use foo::{
    bar::{*, f},
    baz::{g, qux::*<|>}
};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
    h();
    q::j();
}
",
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}

        pub mod qux {
            pub fn h() {}
            pub fn m() {}

            pub mod q {
                pub fn j() {}
            }
        }
    }
}

use foo::{
    bar::{*, f},
    baz::{g, qux::{q, h}}
};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
    h();
    q::j();
}
",
        );

        check_assist(
            expand_glob_import,
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}

        pub mod qux {
            pub fn h() {}
            pub fn m() {}

            pub mod q {
                pub fn j() {}
            }
        }
    }
}

use foo::{
    bar::{*, f},
    baz::{g, qux::{h, q::*<|>}}
};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
    h();
    j();
}
",
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}

        pub mod qux {
            pub fn h() {}
            pub fn m() {}

            pub mod q {
                pub fn j() {}
            }
        }
    }
}

use foo::{
    bar::{*, f},
    baz::{g, qux::{h, q::j}}
};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
    h();
    j();
}
",
        );

        check_assist(
            expand_glob_import,
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}

        pub mod qux {
            pub fn h() {}
            pub fn m() {}

            pub mod q {
                pub fn j() {}
            }
        }
    }
}

use foo::{
    bar::{*, f},
    baz::{g, qux::{q::j, *<|>}}
};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
    h();
    j();
}
",
            r"
mod foo {
    pub mod bar {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;

        pub fn f() {}
    }

    pub mod baz {
        pub fn g() {}

        pub mod qux {
            pub fn h() {}
            pub fn m() {}

            pub mod q {
                pub fn j() {}
            }
        }
    }
}

use foo::{
    bar::{*, f},
    baz::{g, qux::{q::j, h}}
};

fn qux(bar: Bar, baz: Baz) {
    f();
    g();
    h();
    j();
}
",
        );
    }

    #[test]
    fn expanding_glob_import_with_macro_defs() {
        // FIXME: this is currently fails because `Definition::find_usages` ignores macros
        //       https://github.com/rust-analyzer/rust-analyzer/issues/3484
        //
        //         check_assist(
        //             expand_glob_import,
        //             r"
        // //- /lib.rs crate:foo
        // #[macro_export]
        // macro_rules! bar {
        //     () => ()
        // }

        // pub fn baz() {}

        // //- /main.rs crate:main deps:foo
        // use foo::*<|>;

        // fn main() {
        //     bar!();
        //     baz();
        // }
        // ",
        //             r"
        // use foo::{bar, baz};

        // fn main() {
        //     bar!();
        //     baz();
        // }
        // ",
        //         )
    }

    #[test]
    fn expanding_glob_import_with_trait_method_uses() {
        check_assist(
            expand_glob_import,
            r"
//- /lib.rs crate:foo
pub trait Tr {
    fn method(&self) {}
}
impl Tr for () {}

//- /main.rs crate:main deps:foo
use foo::*<|>;

fn main() {
    ().method();
}
",
            r"
use foo::Tr;

fn main() {
    ().method();
}
",
        );

        check_assist(
            expand_glob_import,
            r"
//- /lib.rs crate:foo
pub trait Tr {
    fn method(&self) {}
}
impl Tr for () {}

pub trait Tr2 {
    fn method2(&self) {}
}
impl Tr2 for () {}

//- /main.rs crate:main deps:foo
use foo::*<|>;

fn main() {
    ().method();
}
",
            r"
use foo::Tr;

fn main() {
    ().method();
}
",
        );
    }

    #[test]
    fn expanding_is_not_applicable_if_target_module_is_not_accessible_from_current_scope() {
        check_assist_not_applicable(
            expand_glob_import,
            r"
mod foo {
    mod bar {
        pub struct Bar;
    }
}

use foo::bar::*<|>;

fn baz(bar: Bar) {}
",
        );

        check_assist_not_applicable(
            expand_glob_import,
            r"
mod foo {
    mod bar {
        pub mod baz {
            pub struct Baz;
        }
    }
}

use foo::bar::baz::*<|>;

fn qux(baz: Baz) {}
",
        );
    }

    #[test]
    fn expanding_is_not_applicable_if_cursor_is_not_in_star_token() {
        check_assist_not_applicable(
            expand_glob_import,
            r"
    mod foo {
        pub struct Bar;
        pub struct Baz;
        pub struct Qux;
    }

    use foo::Bar<|>;

    fn qux(bar: Bar, baz: Baz) {}
    ",
        )
    }
}
