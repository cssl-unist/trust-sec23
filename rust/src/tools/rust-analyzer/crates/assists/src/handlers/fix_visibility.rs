use base_db::FileId;
use hir::{db::HirDatabase, HasSource, HasVisibility, PathResolution};
use syntax::{ast, AstNode, TextRange, TextSize};

use crate::{utils::vis_offset, AssistContext, AssistId, AssistKind, Assists};
use ast::VisibilityOwner;

// FIXME: this really should be a fix for diagnostic, rather than an assist.

// Assist: fix_visibility
//
// Makes inaccessible item public.
//
// ```
// mod m {
//     fn frobnicate() {}
// }
// fn main() {
//     m::frobnicate<|>() {}
// }
// ```
// ->
// ```
// mod m {
//     $0pub(crate) fn frobnicate() {}
// }
// fn main() {
//     m::frobnicate() {}
// }
// ```
pub(crate) fn fix_visibility(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    add_vis_to_referenced_module_def(acc, ctx)
        .or_else(|| add_vis_to_referenced_record_field(acc, ctx))
}

fn add_vis_to_referenced_module_def(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let path: ast::Path = ctx.find_node_at_offset()?;
    let path_res = ctx.sema.resolve_path(&path)?;
    let def = match path_res {
        PathResolution::Def(def) => def,
        _ => return None,
    };

    let current_module = ctx.sema.scope(&path.syntax()).module()?;
    let target_module = def.module(ctx.db())?;

    let vis = target_module.visibility_of(ctx.db(), &def)?;
    if vis.is_visible_from(ctx.db(), current_module.into()) {
        return None;
    };

    let (offset, current_visibility, target, target_file, target_name) =
        target_data_for_def(ctx.db(), def)?;

    let missing_visibility =
        if current_module.krate() == target_module.krate() { "pub(crate)" } else { "pub" };

    let assist_label = match target_name {
        None => format!("Change visibility to {}", missing_visibility),
        Some(name) => format!("Change visibility of {} to {}", name, missing_visibility),
    };

    acc.add(AssistId("fix_visibility", AssistKind::QuickFix), assist_label, target, |builder| {
        builder.edit_file(target_file);
        match ctx.config.snippet_cap {
            Some(cap) => match current_visibility {
                Some(current_visibility) => builder.replace_snippet(
                    cap,
                    current_visibility.syntax().text_range(),
                    format!("$0{}", missing_visibility),
                ),
                None => builder.insert_snippet(cap, offset, format!("$0{} ", missing_visibility)),
            },
            None => match current_visibility {
                Some(current_visibility) => {
                    builder.replace(current_visibility.syntax().text_range(), missing_visibility)
                }
                None => builder.insert(offset, format!("{} ", missing_visibility)),
            },
        }
    })
}

fn add_vis_to_referenced_record_field(acc: &mut Assists, ctx: &AssistContext) -> Option<()> {
    let record_field: ast::RecordExprField = ctx.find_node_at_offset()?;
    let (record_field_def, _) = ctx.sema.resolve_record_field(&record_field)?;

    let current_module = ctx.sema.scope(record_field.syntax()).module()?;
    let visibility = record_field_def.visibility(ctx.db());
    if visibility.is_visible_from(ctx.db(), current_module.into()) {
        return None;
    }

    let parent = record_field_def.parent_def(ctx.db());
    let parent_name = parent.name(ctx.db());
    let target_module = parent.module(ctx.db());

    let in_file_source = record_field_def.source(ctx.db());
    let (offset, current_visibility, target) = match in_file_source.value {
        hir::FieldSource::Named(it) => {
            let s = it.syntax();
            (vis_offset(s), it.visibility(), s.text_range())
        }
        hir::FieldSource::Pos(it) => {
            let s = it.syntax();
            (vis_offset(s), it.visibility(), s.text_range())
        }
    };

    let missing_visibility =
        if current_module.krate() == target_module.krate() { "pub(crate)" } else { "pub" };
    let target_file = in_file_source.file_id.original_file(ctx.db());

    let target_name = record_field_def.name(ctx.db());
    let assist_label =
        format!("Change visibility of {}.{} to {}", parent_name, target_name, missing_visibility);

    acc.add(AssistId("fix_visibility", AssistKind::QuickFix), assist_label, target, |builder| {
        builder.edit_file(target_file);
        match ctx.config.snippet_cap {
            Some(cap) => match current_visibility {
                Some(current_visibility) => builder.replace_snippet(
                    cap,
                    current_visibility.syntax().text_range(),
                    format!("$0{}", missing_visibility),
                ),
                None => builder.insert_snippet(cap, offset, format!("$0{} ", missing_visibility)),
            },
            None => match current_visibility {
                Some(current_visibility) => {
                    builder.replace(current_visibility.syntax().text_range(), missing_visibility)
                }
                None => builder.insert(offset, format!("{} ", missing_visibility)),
            },
        }
    })
}

fn target_data_for_def(
    db: &dyn HirDatabase,
    def: hir::ModuleDef,
) -> Option<(TextSize, Option<ast::Visibility>, TextRange, FileId, Option<hir::Name>)> {
    fn offset_target_and_file_id<S, Ast>(
        db: &dyn HirDatabase,
        x: S,
    ) -> (TextSize, Option<ast::Visibility>, TextRange, FileId)
    where
        S: HasSource<Ast = Ast>,
        Ast: AstNode + ast::VisibilityOwner,
    {
        let source = x.source(db);
        let in_file_syntax = source.syntax();
        let file_id = in_file_syntax.file_id;
        let syntax = in_file_syntax.value;
        let current_visibility = source.value.visibility();
        (
            vis_offset(syntax),
            current_visibility,
            syntax.text_range(),
            file_id.original_file(db.upcast()),
        )
    }

    let target_name;
    let (offset, current_visibility, target, target_file) = match def {
        hir::ModuleDef::Function(f) => {
            target_name = Some(f.name(db));
            offset_target_and_file_id(db, f)
        }
        hir::ModuleDef::Adt(adt) => {
            target_name = Some(adt.name(db));
            match adt {
                hir::Adt::Struct(s) => offset_target_and_file_id(db, s),
                hir::Adt::Union(u) => offset_target_and_file_id(db, u),
                hir::Adt::Enum(e) => offset_target_and_file_id(db, e),
            }
        }
        hir::ModuleDef::Const(c) => {
            target_name = c.name(db);
            offset_target_and_file_id(db, c)
        }
        hir::ModuleDef::Static(s) => {
            target_name = s.name(db);
            offset_target_and_file_id(db, s)
        }
        hir::ModuleDef::Trait(t) => {
            target_name = Some(t.name(db));
            offset_target_and_file_id(db, t)
        }
        hir::ModuleDef::TypeAlias(t) => {
            target_name = Some(t.name(db));
            offset_target_and_file_id(db, t)
        }
        hir::ModuleDef::Module(m) => {
            target_name = m.name(db);
            let in_file_source = m.declaration_source(db)?;
            let file_id = in_file_source.file_id.original_file(db.upcast());
            let syntax = in_file_source.value.syntax();
            (vis_offset(syntax), in_file_source.value.visibility(), syntax.text_range(), file_id)
        }
        // Enum variants can't be private, we can't modify builtin types
        hir::ModuleDef::EnumVariant(_) | hir::ModuleDef::BuiltinType(_) => return None,
    };

    Some((offset, current_visibility, target, target_file, target_name))
}

#[cfg(test)]
mod tests {
    use crate::tests::{check_assist, check_assist_not_applicable};

    use super::*;

    #[test]
    fn fix_visibility_of_fn() {
        check_assist(
            fix_visibility,
            r"mod foo { fn foo() {} }
              fn main() { foo::foo<|>() } ",
            r"mod foo { $0pub(crate) fn foo() {} }
              fn main() { foo::foo() } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub fn foo() {} }
              fn main() { foo::foo<|>() } ",
        )
    }

    #[test]
    fn fix_visibility_of_adt_in_submodule() {
        check_assist(
            fix_visibility,
            r"mod foo { struct Foo; }
              fn main() { foo::Foo<|> } ",
            r"mod foo { $0pub(crate) struct Foo; }
              fn main() { foo::Foo } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub struct Foo; }
              fn main() { foo::Foo<|> } ",
        );
        check_assist(
            fix_visibility,
            r"mod foo { enum Foo; }
              fn main() { foo::Foo<|> } ",
            r"mod foo { $0pub(crate) enum Foo; }
              fn main() { foo::Foo } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub enum Foo; }
              fn main() { foo::Foo<|> } ",
        );
        check_assist(
            fix_visibility,
            r"mod foo { union Foo; }
              fn main() { foo::Foo<|> } ",
            r"mod foo { $0pub(crate) union Foo; }
              fn main() { foo::Foo } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub union Foo; }
              fn main() { foo::Foo<|> } ",
        );
    }

    #[test]
    fn fix_visibility_of_adt_in_other_file() {
        check_assist(
            fix_visibility,
            r"
//- /main.rs
mod foo;
fn main() { foo::Foo<|> }

//- /foo.rs
struct Foo;
",
            r"$0pub(crate) struct Foo;
",
        );
    }

    #[test]
    fn fix_visibility_of_struct_field() {
        check_assist(
            fix_visibility,
            r"mod foo { pub struct Foo { bar: (), } }
              fn main() { foo::Foo { <|>bar: () }; } ",
            r"mod foo { pub struct Foo { $0pub(crate) bar: (), } }
              fn main() { foo::Foo { bar: () }; } ",
        );
        check_assist(
            fix_visibility,
            r"
//- /lib.rs
mod foo;
fn main() { foo::Foo { <|>bar: () }; }
//- /foo.rs
pub struct Foo { bar: () }
",
            r"pub struct Foo { $0pub(crate) bar: () }
",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub struct Foo { pub bar: (), } }
              fn main() { foo::Foo { <|>bar: () }; } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"
//- /lib.rs
mod foo;
fn main() { foo::Foo { <|>bar: () }; }
//- /foo.rs
pub struct Foo { pub bar: () }
",
        );
    }

    #[test]
    fn fix_visibility_of_enum_variant_field() {
        check_assist(
            fix_visibility,
            r"mod foo { pub enum Foo { Bar { bar: () } } }
              fn main() { foo::Foo::Bar { <|>bar: () }; } ",
            r"mod foo { pub enum Foo { Bar { $0pub(crate) bar: () } } }
              fn main() { foo::Foo::Bar { bar: () }; } ",
        );
        check_assist(
            fix_visibility,
            r"
//- /lib.rs
mod foo;
fn main() { foo::Foo::Bar { <|>bar: () }; }
//- /foo.rs
pub enum Foo { Bar { bar: () } }
",
            r"pub enum Foo { Bar { $0pub(crate) bar: () } }
",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub struct Foo { pub bar: (), } }
              fn main() { foo::Foo { <|>bar: () }; } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"
//- /lib.rs
mod foo;
fn main() { foo::Foo { <|>bar: () }; }
//- /foo.rs
pub struct Foo { pub bar: () }
",
        );
    }

    #[test]
    #[ignore]
    // FIXME reenable this test when `Semantics::resolve_record_field` works with union fields
    fn fix_visibility_of_union_field() {
        check_assist(
            fix_visibility,
            r"mod foo { pub union Foo { bar: (), } }
              fn main() { foo::Foo { <|>bar: () }; } ",
            r"mod foo { pub union Foo { $0pub(crate) bar: (), } }
              fn main() { foo::Foo { bar: () }; } ",
        );
        check_assist(
            fix_visibility,
            r"
//- /lib.rs
mod foo;
fn main() { foo::Foo { <|>bar: () }; }
//- /foo.rs
pub union Foo { bar: () }
",
            r"pub union Foo { $0pub(crate) bar: () }
",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub union Foo { pub bar: (), } }
              fn main() { foo::Foo { <|>bar: () }; } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"
//- /lib.rs
mod foo;
fn main() { foo::Foo { <|>bar: () }; }
//- /foo.rs
pub union Foo { pub bar: () }
",
        );
    }

    #[test]
    fn fix_visibility_of_const() {
        check_assist(
            fix_visibility,
            r"mod foo { const FOO: () = (); }
              fn main() { foo::FOO<|> } ",
            r"mod foo { $0pub(crate) const FOO: () = (); }
              fn main() { foo::FOO } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub const FOO: () = (); }
              fn main() { foo::FOO<|> } ",
        );
    }

    #[test]
    fn fix_visibility_of_static() {
        check_assist(
            fix_visibility,
            r"mod foo { static FOO: () = (); }
              fn main() { foo::FOO<|> } ",
            r"mod foo { $0pub(crate) static FOO: () = (); }
              fn main() { foo::FOO } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub static FOO: () = (); }
              fn main() { foo::FOO<|> } ",
        );
    }

    #[test]
    fn fix_visibility_of_trait() {
        check_assist(
            fix_visibility,
            r"mod foo { trait Foo { fn foo(&self) {} } }
              fn main() { let x: &dyn foo::<|>Foo; } ",
            r"mod foo { $0pub(crate) trait Foo { fn foo(&self) {} } }
              fn main() { let x: &dyn foo::Foo; } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub trait Foo { fn foo(&self) {} } }
              fn main() { let x: &dyn foo::Foo<|>; } ",
        );
    }

    #[test]
    fn fix_visibility_of_type_alias() {
        check_assist(
            fix_visibility,
            r"mod foo { type Foo = (); }
              fn main() { let x: foo::Foo<|>; } ",
            r"mod foo { $0pub(crate) type Foo = (); }
              fn main() { let x: foo::Foo; } ",
        );
        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub type Foo = (); }
              fn main() { let x: foo::Foo<|>; } ",
        );
    }

    #[test]
    fn fix_visibility_of_module() {
        check_assist(
            fix_visibility,
            r"mod foo { mod bar { fn bar() {} } }
              fn main() { foo::bar<|>::bar(); } ",
            r"mod foo { $0pub(crate) mod bar { fn bar() {} } }
              fn main() { foo::bar::bar(); } ",
        );

        check_assist(
            fix_visibility,
            r"
//- /main.rs
mod foo;
fn main() { foo::bar<|>::baz(); }

//- /foo.rs
mod bar {
    pub fn baz() {}
}
",
            r"$0pub(crate) mod bar {
    pub fn baz() {}
}
",
        );

        check_assist_not_applicable(
            fix_visibility,
            r"mod foo { pub mod bar { pub fn bar() {} } }
              fn main() { foo::bar<|>::bar(); } ",
        );
    }

    #[test]
    fn fix_visibility_of_inline_module_in_other_file() {
        check_assist(
            fix_visibility,
            r"
//- /main.rs
mod foo;
fn main() { foo::bar<|>::baz(); }

//- /foo.rs
mod bar;
//- /foo/bar.rs
pub fn baz() {}
",
            r"$0pub(crate) mod bar;
",
        );
    }

    #[test]
    fn fix_visibility_of_module_declaration_in_other_file() {
        check_assist(
            fix_visibility,
            r"
//- /main.rs
mod foo;
fn main() { foo::bar<|>>::baz(); }

//- /foo.rs
mod bar {
    pub fn baz() {}
}
",
            r"$0pub(crate) mod bar {
    pub fn baz() {}
}
",
        );
    }

    #[test]
    fn adds_pub_when_target_is_in_another_crate() {
        check_assist(
            fix_visibility,
            r"
//- /main.rs crate:a deps:foo
foo::Bar<|>
//- /lib.rs crate:foo
struct Bar;
",
            r"$0pub struct Bar;
",
        )
    }

    #[test]
    fn replaces_pub_crate_with_pub() {
        check_assist(
            fix_visibility,
            r"
//- /main.rs crate:a deps:foo
foo::Bar<|>
//- /lib.rs crate:foo
pub(crate) struct Bar;
",
            r"$0pub struct Bar;
",
        );
        check_assist(
            fix_visibility,
            r"
//- /main.rs crate:a deps:foo
fn main() {
    foo::Foo { <|>bar: () };
}
//- /lib.rs crate:foo
pub struct Foo { pub(crate) bar: () }
",
            r"pub struct Foo { $0pub bar: () }
",
        );
    }

    #[test]
    #[ignore]
    // FIXME handle reexports properly
    fn fix_visibility_of_reexport() {
        check_assist(
            fix_visibility,
            r"
            mod foo {
                use bar::Baz;
                mod bar { pub(super) struct Baz; }
            }
            foo::Baz<|>
            ",
            r"
            mod foo {
                $0pub(crate) use bar::Baz;
                mod bar { pub(super) struct Baz; }
            }
            foo::Baz
            ",
        )
    }
}
