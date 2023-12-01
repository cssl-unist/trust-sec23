//! A desugared representation of paths like `crate::foo` or `<Type as Trait>::bar`.
mod lower;

use std::{
    fmt::{self, Display},
    iter,
    sync::Arc,
};

use crate::body::LowerCtx;
use base_db::CrateId;
use hir_expand::{
    hygiene::Hygiene,
    name::{AsName, Name},
};
use syntax::ast;

use crate::{
    type_ref::{TypeBound, TypeRef},
    InFile,
};

#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct ModPath {
    pub kind: PathKind,
    pub segments: Vec<Name>,
}

#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum PathKind {
    Plain,
    /// `self::` is `Super(0)`
    Super(u8),
    Crate,
    /// Absolute path (::foo)
    Abs,
    /// `$crate` from macro expansion
    DollarCrate(CrateId),
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ImportAlias {
    /// Unnamed alias, as in `use Foo as _;`
    Underscore,
    /// Named alias
    Alias(Name),
}

impl ModPath {
    pub fn from_src(path: ast::Path, hygiene: &Hygiene) -> Option<ModPath> {
        lower::lower_path(path, hygiene).map(|it| it.mod_path)
    }

    pub fn from_segments(kind: PathKind, segments: impl IntoIterator<Item = Name>) -> ModPath {
        let segments = segments.into_iter().collect::<Vec<_>>();
        ModPath { kind, segments }
    }

    pub(crate) fn from_name_ref(name_ref: &ast::NameRef) -> ModPath {
        name_ref.as_name().into()
    }

    /// Converts an `tt::Ident` into a single-identifier `Path`.
    pub(crate) fn from_tt_ident(ident: &tt::Ident) -> ModPath {
        ident.as_name().into()
    }

    /// Calls `cb` with all paths, represented by this use item.
    pub(crate) fn expand_use_item(
        item_src: InFile<ast::Use>,
        hygiene: &Hygiene,
        mut cb: impl FnMut(ModPath, &ast::UseTree, /* is_glob */ bool, Option<ImportAlias>),
    ) {
        if let Some(tree) = item_src.value.use_tree() {
            lower::lower_use_tree(None, tree, hygiene, &mut cb);
        }
    }

    /// Returns the number of segments in the path (counting special segments like `$crate` and
    /// `super`).
    pub fn len(&self) -> usize {
        self.segments.len()
            + match self.kind {
                PathKind::Plain => 0,
                PathKind::Super(i) => i as usize,
                PathKind::Crate => 1,
                PathKind::Abs => 0,
                PathKind::DollarCrate(_) => 1,
            }
    }

    pub fn is_ident(&self) -> bool {
        self.kind == PathKind::Plain && self.segments.len() == 1
    }

    pub fn is_self(&self) -> bool {
        self.kind == PathKind::Super(0) && self.segments.is_empty()
    }

    /// If this path is a single identifier, like `foo`, return its name.
    pub fn as_ident(&self) -> Option<&Name> {
        if self.kind != PathKind::Plain || self.segments.len() > 1 {
            return None;
        }
        self.segments.first()
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Path {
    /// Type based path like `<T>::foo`.
    /// Note that paths like `<Type as Trait>::foo` are desugard to `Trait::<Self=Type>::foo`.
    type_anchor: Option<Box<TypeRef>>,
    mod_path: ModPath,
    /// Invariant: the same len as `self.mod_path.segments`
    generic_args: Vec<Option<Arc<GenericArgs>>>,
}

/// Generic arguments to a path segment (e.g. the `i32` in `Option<i32>`). This
/// also includes bindings of associated types, like in `Iterator<Item = Foo>`.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct GenericArgs {
    pub args: Vec<GenericArg>,
    /// This specifies whether the args contain a Self type as the first
    /// element. This is the case for path segments like `<T as Trait>`, where
    /// `T` is actually a type parameter for the path `Trait` specifying the
    /// Self type. Otherwise, when we have a path `Trait<X, Y>`, the Self type
    /// is left out.
    pub has_self_type: bool,
    /// Associated type bindings like in `Iterator<Item = T>`.
    pub bindings: Vec<AssociatedTypeBinding>,
}

/// An associated type binding like in `Iterator<Item = T>`.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct AssociatedTypeBinding {
    /// The name of the associated type.
    pub name: Name,
    /// The type bound to this associated type (in `Item = T`, this would be the
    /// `T`). This can be `None` if there are bounds instead.
    pub type_ref: Option<TypeRef>,
    /// Bounds for the associated type, like in `Iterator<Item:
    /// SomeOtherTrait>`. (This is the unstable `associated_type_bounds`
    /// feature.)
    pub bounds: Vec<TypeBound>,
}

/// A single generic argument.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum GenericArg {
    Type(TypeRef),
    // or lifetime...
}

impl Path {
    /// Converts an `ast::Path` to `Path`. Works with use trees.
    /// It correctly handles `$crate` based path from macro call.
    pub fn from_src(path: ast::Path, hygiene: &Hygiene) -> Option<Path> {
        lower::lower_path(path, hygiene)
    }

    /// Converts a known mod path to `Path`.
    pub(crate) fn from_known_path(
        path: ModPath,
        generic_args: Vec<Option<Arc<GenericArgs>>>,
    ) -> Path {
        Path { type_anchor: None, mod_path: path, generic_args }
    }

    pub fn kind(&self) -> &PathKind {
        &self.mod_path.kind
    }

    pub fn type_anchor(&self) -> Option<&TypeRef> {
        self.type_anchor.as_deref()
    }

    pub fn segments(&self) -> PathSegments<'_> {
        PathSegments {
            segments: self.mod_path.segments.as_slice(),
            generic_args: self.generic_args.as_slice(),
        }
    }

    pub fn mod_path(&self) -> &ModPath {
        &self.mod_path
    }

    pub fn qualifier(&self) -> Option<Path> {
        if self.mod_path.is_ident() {
            return None;
        }
        let res = Path {
            type_anchor: self.type_anchor.clone(),
            mod_path: ModPath {
                kind: self.mod_path.kind.clone(),
                segments: self.mod_path.segments[..self.mod_path.segments.len() - 1].to_vec(),
            },
            generic_args: self.generic_args[..self.generic_args.len() - 1].to_vec(),
        };
        Some(res)
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct PathSegment<'a> {
    pub name: &'a Name,
    pub args_and_bindings: Option<&'a GenericArgs>,
}

pub struct PathSegments<'a> {
    segments: &'a [Name],
    generic_args: &'a [Option<Arc<GenericArgs>>],
}

impl<'a> PathSegments<'a> {
    pub const EMPTY: PathSegments<'static> = PathSegments { segments: &[], generic_args: &[] };
    pub fn is_empty(&self) -> bool {
        self.len() == 0
    }
    pub fn len(&self) -> usize {
        self.segments.len()
    }
    pub fn first(&self) -> Option<PathSegment<'a>> {
        self.get(0)
    }
    pub fn last(&self) -> Option<PathSegment<'a>> {
        self.get(self.len().checked_sub(1)?)
    }
    pub fn get(&self, idx: usize) -> Option<PathSegment<'a>> {
        assert_eq!(self.segments.len(), self.generic_args.len());
        let res = PathSegment {
            name: self.segments.get(idx)?,
            args_and_bindings: self.generic_args.get(idx).unwrap().as_ref().map(|it| &**it),
        };
        Some(res)
    }
    pub fn skip(&self, len: usize) -> PathSegments<'a> {
        assert_eq!(self.segments.len(), self.generic_args.len());
        PathSegments { segments: &self.segments[len..], generic_args: &self.generic_args[len..] }
    }
    pub fn take(&self, len: usize) -> PathSegments<'a> {
        assert_eq!(self.segments.len(), self.generic_args.len());
        PathSegments { segments: &self.segments[..len], generic_args: &self.generic_args[..len] }
    }
    pub fn iter(&self) -> impl Iterator<Item = PathSegment<'a>> {
        self.segments.iter().zip(self.generic_args.iter()).map(|(name, args)| PathSegment {
            name,
            args_and_bindings: args.as_ref().map(|it| &**it),
        })
    }
}

impl GenericArgs {
    pub(crate) fn from_ast(lower_ctx: &LowerCtx, node: ast::GenericArgList) -> Option<GenericArgs> {
        lower::lower_generic_args(lower_ctx, node)
    }

    pub(crate) fn empty() -> GenericArgs {
        GenericArgs { args: Vec::new(), has_self_type: false, bindings: Vec::new() }
    }
}

impl From<Name> for Path {
    fn from(name: Name) -> Path {
        Path {
            type_anchor: None,
            mod_path: ModPath::from_segments(PathKind::Plain, iter::once(name)),
            generic_args: vec![None],
        }
    }
}

impl From<Name> for ModPath {
    fn from(name: Name) -> ModPath {
        ModPath::from_segments(PathKind::Plain, iter::once(name))
    }
}

impl Display for ModPath {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut first_segment = true;
        let mut add_segment = |s| -> fmt::Result {
            if !first_segment {
                f.write_str("::")?;
            }
            first_segment = false;
            f.write_str(s)?;
            Ok(())
        };
        match self.kind {
            PathKind::Plain => {}
            PathKind::Super(n) => {
                if n == 0 {
                    add_segment("self")?;
                }
                for _ in 0..n {
                    add_segment("super")?;
                }
            }
            PathKind::Crate => add_segment("crate")?,
            PathKind::Abs => add_segment("")?,
            PathKind::DollarCrate(_) => add_segment("$crate")?,
        }
        for segment in &self.segments {
            if !first_segment {
                f.write_str("::")?;
            }
            first_segment = false;
            write!(f, "{}", segment)?;
        }
        Ok(())
    }
}

pub use hir_expand::name as __name;

#[macro_export]
macro_rules! __known_path {
    (core::iter::IntoIterator) => {};
    (core::result::Result) => {};
    (core::ops::Range) => {};
    (core::ops::RangeFrom) => {};
    (core::ops::RangeFull) => {};
    (core::ops::RangeTo) => {};
    (core::ops::RangeToInclusive) => {};
    (core::ops::RangeInclusive) => {};
    (core::future::Future) => {};
    (core::ops::Try) => {};
    ($path:path) => {
        compile_error!("Please register your known path in the path module")
    };
}

#[macro_export]
macro_rules! __path {
    ($start:ident $(:: $seg:ident)*) => ({
        $crate::__known_path!($start $(:: $seg)*);
        $crate::path::ModPath::from_segments($crate::path::PathKind::Abs, vec![
            $crate::path::__name![$start], $($crate::path::__name![$seg],)*
        ])
    });
}

pub use crate::__path as path;
