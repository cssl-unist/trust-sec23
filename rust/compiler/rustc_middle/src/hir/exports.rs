use crate::ty;

use rustc_data_structures::fx::FxHashMap;
use rustc_hir::def::Res;
use rustc_hir::def_id::LocalDefId;
use rustc_macros::HashStable;
use rustc_span::symbol::Ident;
use rustc_span::Span;

use std::fmt::Debug;

/// This is the replacement export map. It maps a module to all of the exports
/// within.
pub type ExportMap<Id> = FxHashMap<LocalDefId, Vec<Export<Id>>>;

#[derive(Copy, Clone, Debug, TyEncodable, TyDecodable, HashStable)]
pub struct Export<Id> {
    /// The name of the target.
    pub ident: Ident,
    /// The resolution of the target.
    pub res: Res<Id>,
    /// The span of the target.
    pub span: Span,
    /// The visibility of the export.
    /// We include non-`pub` exports for hygienic macros that get used from extern crates.
    pub vis: ty::Visibility,
}

impl<Id> Export<Id> {
    pub fn map_id<R>(self, map: impl FnMut(Id) -> R) -> Export<R> {
        Export { ident: self.ident, res: self.res.map_id(map), span: self.span, vis: self.vis }
    }
}
