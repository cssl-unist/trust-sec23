//! Builtin derives.

use log::debug;

use parser::FragmentKind;
use syntax::{
    ast::{self, AstNode, GenericParamsOwner, ModuleItemOwner, NameOwner},
    match_ast,
};

use crate::{db::AstDatabase, name, quote, LazyMacroId, MacroDefId, MacroDefKind};

macro_rules! register_builtin {
    ( $($trait:ident => $expand:ident),* ) => {
        #[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
        pub enum BuiltinDeriveExpander {
            $($trait),*
        }

        impl BuiltinDeriveExpander {
            pub fn expand(
                &self,
                db: &dyn AstDatabase,
                id: LazyMacroId,
                tt: &tt::Subtree,
            ) -> Result<tt::Subtree, mbe::ExpandError> {
                let expander = match *self {
                    $( BuiltinDeriveExpander::$trait => $expand, )*
                };
                expander(db, id, tt)
            }
        }

        pub fn find_builtin_derive(ident: &name::Name) -> Option<MacroDefId> {
            let kind = match ident {
                $( id if id == &name::name![$trait] => BuiltinDeriveExpander::$trait, )*
                 _ => return None,
            };

            Some(MacroDefId { krate: None, ast_id: None, kind: MacroDefKind::BuiltInDerive(kind), local_inner: false })
        }
    };
}

register_builtin! {
    Copy => copy_expand,
    Clone => clone_expand,
    Default => default_expand,
    Debug => debug_expand,
    Hash => hash_expand,
    Ord => ord_expand,
    PartialOrd => partial_ord_expand,
    Eq => eq_expand,
    PartialEq => partial_eq_expand
}

struct BasicAdtInfo {
    name: tt::Ident,
    type_params: usize,
}

fn parse_adt(tt: &tt::Subtree) -> Result<BasicAdtInfo, mbe::ExpandError> {
    let (parsed, token_map) = mbe::token_tree_to_syntax_node(tt, FragmentKind::Items)?; // FragmentKind::Items doesn't parse attrs?
    let macro_items = ast::MacroItems::cast(parsed.syntax_node()).ok_or_else(|| {
        debug!("derive node didn't parse");
        mbe::ExpandError::UnexpectedToken
    })?;
    let item = macro_items.items().next().ok_or_else(|| {
        debug!("no module item parsed");
        mbe::ExpandError::NoMatchingRule
    })?;
    let node = item.syntax();
    let (name, params) = match_ast! {
        match node {
            ast::Struct(it) => (it.name(), it.generic_param_list()),
            ast::Enum(it) => (it.name(), it.generic_param_list()),
            ast::Union(it) => (it.name(), it.generic_param_list()),
            _ => {
                debug!("unexpected node is {:?}", node);
                return Err(mbe::ExpandError::ConversionError)
            },
        }
    };
    let name = name.ok_or_else(|| {
        debug!("parsed item has no name");
        mbe::ExpandError::NoMatchingRule
    })?;
    let name_token_id = token_map.token_by_range(name.syntax().text_range()).ok_or_else(|| {
        debug!("name token not found");
        mbe::ExpandError::ConversionError
    })?;
    let name_token = tt::Ident { id: name_token_id, text: name.text().clone() };
    let type_params = params.map_or(0, |type_param_list| type_param_list.type_params().count());
    Ok(BasicAdtInfo { name: name_token, type_params })
}

fn make_type_args(n: usize, bound: Vec<tt::TokenTree>) -> Vec<tt::TokenTree> {
    let mut result = Vec::<tt::TokenTree>::new();
    result.push(
        tt::Leaf::Punct(tt::Punct {
            char: '<',
            spacing: tt::Spacing::Alone,
            id: tt::TokenId::unspecified(),
        })
        .into(),
    );
    for i in 0..n {
        if i > 0 {
            result.push(
                tt::Leaf::Punct(tt::Punct {
                    char: ',',
                    spacing: tt::Spacing::Alone,
                    id: tt::TokenId::unspecified(),
                })
                .into(),
            );
        }
        result.push(
            tt::Leaf::Ident(tt::Ident {
                id: tt::TokenId::unspecified(),
                text: format!("T{}", i).into(),
            })
            .into(),
        );
        result.extend(bound.iter().cloned());
    }
    result.push(
        tt::Leaf::Punct(tt::Punct {
            char: '>',
            spacing: tt::Spacing::Alone,
            id: tt::TokenId::unspecified(),
        })
        .into(),
    );
    result
}

fn expand_simple_derive(
    tt: &tt::Subtree,
    trait_path: tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let info = parse_adt(tt)?;
    let name = info.name;
    let trait_path_clone = trait_path.token_trees.clone();
    let bound = (quote! { : ##trait_path_clone }).token_trees;
    let type_params = make_type_args(info.type_params, bound);
    let type_args = make_type_args(info.type_params, Vec::new());
    let trait_path = trait_path.token_trees;
    let expanded = quote! {
        impl ##type_params ##trait_path for #name ##type_args {}
    };
    Ok(expanded)
}

fn find_builtin_crate(db: &dyn AstDatabase, id: LazyMacroId) -> tt::TokenTree {
    // FIXME: make hygiene works for builtin derive macro
    // such that $crate can be used here.
    let cg = db.crate_graph();
    let krate = db.lookup_intern_macro(id).krate;

    // XXX
    //  All crates except core itself should have a dependency on core,
    //  We detect `core` by seeing whether it doesn't have such a dependency.
    let tt = if cg[krate].dependencies.iter().any(|dep| &*dep.name == "core") {
        quote! { core }
    } else {
        quote! { crate }
    };

    tt.token_trees[0].clone()
}

fn copy_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::marker::Copy })
}

fn clone_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::clone::Clone })
}

fn default_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::default::Default })
}

fn debug_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::fmt::Debug })
}

fn hash_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::hash::Hash })
}

fn eq_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::cmp::Eq })
}

fn partial_eq_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::cmp::PartialEq })
}

fn ord_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::cmp::Ord })
}

fn partial_ord_expand(
    db: &dyn AstDatabase,
    id: LazyMacroId,
    tt: &tt::Subtree,
) -> Result<tt::Subtree, mbe::ExpandError> {
    let krate = find_builtin_crate(db, id);
    expand_simple_derive(tt, quote! { #krate::cmp::PartialOrd })
}

#[cfg(test)]
mod tests {
    use base_db::{fixture::WithFixture, CrateId, SourceDatabase};
    use name::{known, Name};

    use crate::{test_db::TestDB, AstId, MacroCallId, MacroCallKind, MacroCallLoc};

    use super::*;

    fn expand_builtin_derive(s: &str, name: Name) -> String {
        let def = find_builtin_derive(&name).unwrap();
        let fixture = format!(
            r#"//- /main.rs crate:main deps:core
<|>
{}
//- /lib.rs crate:core
// empty
"#,
            s
        );

        let (db, file_pos) = TestDB::with_position(&fixture);
        let file_id = file_pos.file_id;
        let parsed = db.parse(file_id);
        let items: Vec<_> =
            parsed.syntax_node().descendants().filter_map(ast::Item::cast).collect();

        let ast_id_map = db.ast_id_map(file_id.into());

        let attr_id = AstId::new(file_id.into(), ast_id_map.ast_id(&items[0]));

        let loc = MacroCallLoc {
            def,
            krate: CrateId(0),
            kind: MacroCallKind::Attr(attr_id, name.to_string()),
        };

        let id: MacroCallId = db.intern_macro(loc).into();
        let parsed = db.parse_or_expand(id.as_file()).unwrap();

        // FIXME text() for syntax nodes parsed from token tree looks weird
        // because there's no whitespace, see below
        parsed.text().to_string()
    }

    #[test]
    fn test_copy_expand_simple() {
        let expanded = expand_builtin_derive(
            r#"
        #[derive(Copy)]
        struct Foo;
"#,
            known::Copy,
        );

        assert_eq!(expanded, "impl< >core::marker::CopyforFoo< >{}");
    }

    #[test]
    fn test_copy_expand_with_type_params() {
        let expanded = expand_builtin_derive(
            r#"
        #[derive(Copy)]
        struct Foo<A, B>;
"#,
            known::Copy,
        );

        assert_eq!(
            expanded,
            "impl<T0:core::marker::Copy,T1:core::marker::Copy>core::marker::CopyforFoo<T0,T1>{}"
        );
    }

    #[test]
    fn test_copy_expand_with_lifetimes() {
        let expanded = expand_builtin_derive(
            r#"
        #[derive(Copy)]
        struct Foo<A, B, 'a, 'b>;
"#,
            known::Copy,
        );

        // We currently just ignore lifetimes

        assert_eq!(
            expanded,
            "impl<T0:core::marker::Copy,T1:core::marker::Copy>core::marker::CopyforFoo<T0,T1>{}"
        );
    }

    #[test]
    fn test_clone_expand() {
        let expanded = expand_builtin_derive(
            r#"
        #[derive(Clone)]
        struct Foo<A, B>;
"#,
            known::Clone,
        );

        assert_eq!(
            expanded,
            "impl<T0:core::clone::Clone,T1:core::clone::Clone>core::clone::CloneforFoo<T0,T1>{}"
        );
    }
}
