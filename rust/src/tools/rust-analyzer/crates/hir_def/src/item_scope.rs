//! Describes items defined or visible (ie, imported) in a certain scope.
//! This is shared between modules and blocks.

use std::collections::hash_map::Entry;

use base_db::CrateId;
use hir_expand::name::Name;
use once_cell::sync::Lazy;
use rustc_hash::{FxHashMap, FxHashSet};
use test_utils::mark;

use crate::{
    db::DefDatabase, per_ns::PerNs, visibility::Visibility, AdtId, BuiltinType, HasModule, ImplId,
    LocalModuleId, Lookup, MacroDefId, ModuleDefId, TraitId,
};

#[derive(Copy, Clone)]
pub(crate) enum ImportType {
    Glob,
    Named,
}

#[derive(Debug, Default)]
pub struct PerNsGlobImports {
    types: FxHashSet<(LocalModuleId, Name)>,
    values: FxHashSet<(LocalModuleId, Name)>,
    macros: FxHashSet<(LocalModuleId, Name)>,
}

#[derive(Debug, Default, PartialEq, Eq)]
pub struct ItemScope {
    types: FxHashMap<Name, (ModuleDefId, Visibility)>,
    values: FxHashMap<Name, (ModuleDefId, Visibility)>,
    macros: FxHashMap<Name, (MacroDefId, Visibility)>,
    unresolved: FxHashSet<Name>,

    defs: Vec<ModuleDefId>,
    impls: Vec<ImplId>,
    /// Traits imported via `use Trait as _;`.
    unnamed_trait_imports: FxHashMap<TraitId, Visibility>,
    /// Macros visible in current module in legacy textual scope
    ///
    /// For macros invoked by an unqualified identifier like `bar!()`, `legacy_macros` will be searched in first.
    /// If it yields no result, then it turns to module scoped `macros`.
    /// It macros with name qualified with a path like `crate::foo::bar!()`, `legacy_macros` will be skipped,
    /// and only normal scoped `macros` will be searched in.
    ///
    /// Note that this automatically inherit macros defined textually before the definition of module itself.
    ///
    /// Module scoped macros will be inserted into `items` instead of here.
    // FIXME: Macro shadowing in one module is not properly handled. Non-item place macros will
    // be all resolved to the last one defined if shadowing happens.
    legacy_macros: FxHashMap<Name, MacroDefId>,
}

pub(crate) static BUILTIN_SCOPE: Lazy<FxHashMap<Name, PerNs>> = Lazy::new(|| {
    BuiltinType::ALL
        .iter()
        .map(|(name, ty)| (name.clone(), PerNs::types(ty.clone().into(), Visibility::Public)))
        .collect()
});

/// Shadow mode for builtin type which can be shadowed by module.
#[derive(Debug, Copy, Clone, PartialEq, Eq)]
pub(crate) enum BuiltinShadowMode {
    /// Prefer user-defined modules (or other types) over builtins.
    Module,
    /// Prefer builtins over user-defined modules (but not other types).
    Other,
}

/// Legacy macros can only be accessed through special methods like `get_legacy_macros`.
/// Other methods will only resolve values, types and module scoped macros only.
impl ItemScope {
    pub fn entries<'a>(&'a self) -> impl Iterator<Item = (&'a Name, PerNs)> + 'a {
        // FIXME: shadowing
        let keys: FxHashSet<_> = self
            .types
            .keys()
            .chain(self.values.keys())
            .chain(self.macros.keys())
            .chain(self.unresolved.iter())
            .collect();

        keys.into_iter().map(move |name| (name, self.get(name)))
    }

    pub fn declarations(&self) -> impl Iterator<Item = ModuleDefId> + '_ {
        self.defs.iter().copied()
    }

    pub fn impls(&self) -> impl Iterator<Item = ImplId> + ExactSizeIterator + '_ {
        self.impls.iter().copied()
    }

    pub fn visibility_of(&self, def: ModuleDefId) -> Option<Visibility> {
        self.name_of(ItemInNs::Types(def))
            .or_else(|| self.name_of(ItemInNs::Values(def)))
            .map(|(_, v)| v)
    }

    /// Iterate over all module scoped macros
    pub(crate) fn macros<'a>(&'a self) -> impl Iterator<Item = (&'a Name, MacroDefId)> + 'a {
        self.entries().filter_map(|(name, def)| def.take_macros().map(|macro_| (name, macro_)))
    }

    /// Iterate over all legacy textual scoped macros visible at the end of the module
    pub(crate) fn legacy_macros<'a>(&'a self) -> impl Iterator<Item = (&'a Name, MacroDefId)> + 'a {
        self.legacy_macros.iter().map(|(name, def)| (name, *def))
    }

    /// Get a name from current module scope, legacy macros are not included
    pub(crate) fn get(&self, name: &Name) -> PerNs {
        PerNs {
            types: self.types.get(name).copied(),
            values: self.values.get(name).copied(),
            macros: self.macros.get(name).copied(),
        }
    }

    pub(crate) fn name_of(&self, item: ItemInNs) -> Option<(&Name, Visibility)> {
        for (name, per_ns) in self.entries() {
            if let Some(vis) = item.match_with(per_ns) {
                return Some((name, vis));
            }
        }
        None
    }

    pub(crate) fn traits<'a>(&'a self) -> impl Iterator<Item = TraitId> + 'a {
        self.types
            .values()
            .filter_map(|(def, _)| match def {
                ModuleDefId::TraitId(t) => Some(*t),
                _ => None,
            })
            .chain(self.unnamed_trait_imports.keys().copied())
    }

    pub(crate) fn define_def(&mut self, def: ModuleDefId) {
        self.defs.push(def)
    }

    pub(crate) fn get_legacy_macro(&self, name: &Name) -> Option<MacroDefId> {
        self.legacy_macros.get(name).copied()
    }

    pub(crate) fn define_impl(&mut self, imp: ImplId) {
        self.impls.push(imp)
    }

    pub(crate) fn define_legacy_macro(&mut self, name: Name, mac: MacroDefId) {
        self.legacy_macros.insert(name, mac);
    }

    pub(crate) fn unnamed_trait_vis(&self, tr: TraitId) -> Option<Visibility> {
        self.unnamed_trait_imports.get(&tr).copied()
    }

    pub(crate) fn push_unnamed_trait(&mut self, tr: TraitId, vis: Visibility) {
        self.unnamed_trait_imports.insert(tr, vis);
    }

    pub(crate) fn push_res(&mut self, name: Name, def: PerNs) -> bool {
        let mut changed = false;

        if let Some(types) = def.types {
            self.types.entry(name.clone()).or_insert_with(|| {
                changed = true;
                types
            });
        }
        if let Some(values) = def.values {
            self.values.entry(name.clone()).or_insert_with(|| {
                changed = true;
                values
            });
        }
        if let Some(macros) = def.macros {
            self.macros.entry(name.clone()).or_insert_with(|| {
                changed = true;
                macros
            });
        }

        if def.is_none() {
            if self.unresolved.insert(name) {
                changed = true;
            }
        }

        changed
    }

    pub(crate) fn push_res_with_import(
        &mut self,
        glob_imports: &mut PerNsGlobImports,
        lookup: (LocalModuleId, Name),
        def: PerNs,
        def_import_type: ImportType,
    ) -> bool {
        let mut changed = false;

        macro_rules! check_changed {
            (
                $changed:ident,
                ( $this:ident / $def:ident ) . $field:ident,
                $glob_imports:ident [ $lookup:ident ],
                $def_import_type:ident
            ) => {{
                let existing = $this.$field.entry($lookup.1.clone());
                match (existing, $def.$field) {
                    (Entry::Vacant(entry), Some(_)) => {
                        match $def_import_type {
                            ImportType::Glob => {
                                $glob_imports.$field.insert($lookup.clone());
                            }
                            ImportType::Named => {
                                $glob_imports.$field.remove(&$lookup);
                            }
                        }

                        if let Some(fld) = $def.$field {
                            entry.insert(fld);
                        }
                        $changed = true;
                    }
                    (Entry::Occupied(mut entry), Some(_))
                        if $glob_imports.$field.contains(&$lookup)
                            && matches!($def_import_type, ImportType::Named) =>
                    {
                        mark::hit!(import_shadowed);
                        $glob_imports.$field.remove(&$lookup);
                        if let Some(fld) = $def.$field {
                            entry.insert(fld);
                        }
                        $changed = true;
                    }
                    _ => {}
                }
            }};
        }

        check_changed!(changed, (self / def).types, glob_imports[lookup], def_import_type);
        check_changed!(changed, (self / def).values, glob_imports[lookup], def_import_type);
        check_changed!(changed, (self / def).macros, glob_imports[lookup], def_import_type);

        if def.is_none() {
            if self.unresolved.insert(lookup.1) {
                changed = true;
            }
        }

        changed
    }

    pub(crate) fn resolutions<'a>(&'a self) -> impl Iterator<Item = (Option<Name>, PerNs)> + 'a {
        self.entries().map(|(name, res)| (Some(name.clone()), res)).chain(
            self.unnamed_trait_imports
                .iter()
                .map(|(tr, vis)| (None, PerNs::types(ModuleDefId::TraitId(*tr), *vis))),
        )
    }

    pub(crate) fn collect_legacy_macros(&self) -> FxHashMap<Name, MacroDefId> {
        self.legacy_macros.clone()
    }
}

impl PerNs {
    pub(crate) fn from_def(def: ModuleDefId, v: Visibility, has_constructor: bool) -> PerNs {
        match def {
            ModuleDefId::ModuleId(_) => PerNs::types(def, v),
            ModuleDefId::FunctionId(_) => PerNs::values(def, v),
            ModuleDefId::AdtId(adt) => match adt {
                AdtId::UnionId(_) => PerNs::types(def, v),
                AdtId::EnumId(_) => PerNs::types(def, v),
                AdtId::StructId(_) => {
                    if has_constructor {
                        PerNs::both(def, def, v)
                    } else {
                        PerNs::types(def, v)
                    }
                }
            },
            ModuleDefId::EnumVariantId(_) => PerNs::both(def, def, v),
            ModuleDefId::ConstId(_) | ModuleDefId::StaticId(_) => PerNs::values(def, v),
            ModuleDefId::TraitId(_) => PerNs::types(def, v),
            ModuleDefId::TypeAliasId(_) => PerNs::types(def, v),
            ModuleDefId::BuiltinType(_) => PerNs::types(def, v),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug, Hash)]
pub enum ItemInNs {
    Types(ModuleDefId),
    Values(ModuleDefId),
    Macros(MacroDefId),
}

impl ItemInNs {
    fn match_with(self, per_ns: PerNs) -> Option<Visibility> {
        match self {
            ItemInNs::Types(def) => {
                per_ns.types.filter(|(other_def, _)| *other_def == def).map(|(_, vis)| vis)
            }
            ItemInNs::Values(def) => {
                per_ns.values.filter(|(other_def, _)| *other_def == def).map(|(_, vis)| vis)
            }
            ItemInNs::Macros(def) => {
                per_ns.macros.filter(|(other_def, _)| *other_def == def).map(|(_, vis)| vis)
            }
        }
    }

    pub fn as_module_def_id(self) -> Option<ModuleDefId> {
        match self {
            ItemInNs::Types(id) | ItemInNs::Values(id) => Some(id),
            ItemInNs::Macros(_) => None,
        }
    }

    /// Returns the crate defining this item (or `None` if `self` is built-in).
    pub fn krate(&self, db: &dyn DefDatabase) -> Option<CrateId> {
        Some(match self {
            ItemInNs::Types(did) | ItemInNs::Values(did) => match did {
                ModuleDefId::ModuleId(id) => id.krate,
                ModuleDefId::FunctionId(id) => id.lookup(db).module(db).krate,
                ModuleDefId::AdtId(id) => id.module(db).krate,
                ModuleDefId::EnumVariantId(id) => id.parent.lookup(db).container.module(db).krate,
                ModuleDefId::ConstId(id) => id.lookup(db).container.module(db).krate,
                ModuleDefId::StaticId(id) => id.lookup(db).container.module(db).krate,
                ModuleDefId::TraitId(id) => id.lookup(db).container.module(db).krate,
                ModuleDefId::TypeAliasId(id) => id.lookup(db).module(db).krate,
                ModuleDefId::BuiltinType(_) => return None,
            },
            ItemInNs::Macros(id) => return id.krate,
        })
    }
}
