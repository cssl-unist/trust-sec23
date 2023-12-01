//! Name resolution façade.
use std::sync::Arc;

use base_db::CrateId;
use hir_expand::{
    name::{name, Name},
    MacroDefId,
};
use rustc_hash::FxHashSet;

use crate::{
    body::scope::{ExprScopes, ScopeId},
    body::Body,
    builtin_type::BuiltinType,
    db::DefDatabase,
    expr::{ExprId, PatId},
    generics::GenericParams,
    item_scope::{BuiltinShadowMode, BUILTIN_SCOPE},
    nameres::CrateDefMap,
    path::{ModPath, PathKind},
    per_ns::PerNs,
    visibility::{RawVisibility, Visibility},
    AdtId, AssocContainerId, ConstId, ContainerId, DefWithBodyId, EnumId, EnumVariantId,
    FunctionId, GenericDefId, HasModule, ImplId, LocalModuleId, Lookup, ModuleDefId, ModuleId,
    StaticId, StructId, TraitId, TypeAliasId, TypeParamId, VariantId,
};

#[derive(Debug, Clone, Default)]
pub struct Resolver {
    // FIXME: all usages generally call `.rev`, so maybe reverse once in consturciton?
    scopes: Vec<Scope>,
}

// FIXME how to store these best
#[derive(Debug, Clone)]
struct ModuleItemMap {
    crate_def_map: Arc<CrateDefMap>,
    module_id: LocalModuleId,
}

#[derive(Debug, Clone)]
struct ExprScope {
    owner: DefWithBodyId,
    expr_scopes: Arc<ExprScopes>,
    scope_id: ScopeId,
}

#[derive(Debug, Clone)]
enum Scope {
    /// All the items and imported names of a module
    ModuleScope(ModuleItemMap),
    /// Brings the generic parameters of an item into scope
    GenericParams { def: GenericDefId, params: Arc<GenericParams> },
    /// Brings `Self` in `impl` block into scope
    ImplDefScope(ImplId),
    /// Brings `Self` in enum, struct and union definitions into scope
    AdtScope(AdtId),
    /// Local bindings
    ExprScope(ExprScope),
    /// Temporary hack to support local items.
    LocalItemsScope(Arc<Body>),
}

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum TypeNs {
    SelfType(ImplId),
    GenericParam(TypeParamId),
    AdtId(AdtId),
    AdtSelfType(AdtId),
    // Yup, enum variants are added to the types ns, but any usage of variant as
    // type is an error.
    EnumVariantId(EnumVariantId),
    TypeAliasId(TypeAliasId),
    BuiltinType(BuiltinType),
    TraitId(TraitId),
    // Module belong to type ns, but the resolver is used when all module paths
    // are fully resolved.
    // ModuleId(ModuleId)
}

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum ResolveValueResult {
    ValueNs(ValueNs),
    Partial(TypeNs, usize),
}

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum ValueNs {
    ImplSelf(ImplId),
    LocalBinding(PatId),
    FunctionId(FunctionId),
    ConstId(ConstId),
    StaticId(StaticId),
    StructId(StructId),
    EnumVariantId(EnumVariantId),
}

impl Resolver {
    /// Resolve known trait from std, like `std::futures::Future`
    pub fn resolve_known_trait(&self, db: &dyn DefDatabase, path: &ModPath) -> Option<TraitId> {
        let res = self.resolve_module_path(db, path, BuiltinShadowMode::Other).take_types()?;
        match res {
            ModuleDefId::TraitId(it) => Some(it),
            _ => None,
        }
    }

    /// Resolve known struct from std, like `std::boxed::Box`
    pub fn resolve_known_struct(&self, db: &dyn DefDatabase, path: &ModPath) -> Option<StructId> {
        let res = self.resolve_module_path(db, path, BuiltinShadowMode::Other).take_types()?;
        match res {
            ModuleDefId::AdtId(AdtId::StructId(it)) => Some(it),
            _ => None,
        }
    }

    /// Resolve known enum from std, like `std::result::Result`
    pub fn resolve_known_enum(&self, db: &dyn DefDatabase, path: &ModPath) -> Option<EnumId> {
        let res = self.resolve_module_path(db, path, BuiltinShadowMode::Other).take_types()?;
        match res {
            ModuleDefId::AdtId(AdtId::EnumId(it)) => Some(it),
            _ => None,
        }
    }

    fn resolve_module_path(
        &self,
        db: &dyn DefDatabase,
        path: &ModPath,
        shadow: BuiltinShadowMode,
    ) -> PerNs {
        let (item_map, module) = match self.module_scope() {
            Some(it) => it,
            None => return PerNs::none(),
        };
        let (module_res, segment_index) = item_map.resolve_path(db, module, &path, shadow);
        if segment_index.is_some() {
            return PerNs::none();
        }
        module_res
    }

    pub fn resolve_module_path_in_items(&self, db: &dyn DefDatabase, path: &ModPath) -> PerNs {
        self.resolve_module_path(db, path, BuiltinShadowMode::Module)
    }

    pub fn resolve_path_in_type_ns(
        &self,
        db: &dyn DefDatabase,
        path: &ModPath,
    ) -> Option<(TypeNs, Option<usize>)> {
        let first_name = path.segments.first()?;
        let skip_to_mod = path.kind != PathKind::Plain;
        for scope in self.scopes.iter().rev() {
            match scope {
                Scope::ExprScope(_) => continue,
                Scope::GenericParams { .. }
                | Scope::ImplDefScope(_)
                | Scope::LocalItemsScope(_)
                    if skip_to_mod =>
                {
                    continue
                }

                Scope::GenericParams { params, def } => {
                    if let Some(local_id) = params.find_by_name(first_name) {
                        let idx = if path.segments.len() == 1 { None } else { Some(1) };
                        return Some((
                            TypeNs::GenericParam(TypeParamId { local_id, parent: *def }),
                            idx,
                        ));
                    }
                }
                Scope::ImplDefScope(impl_) => {
                    if first_name == &name![Self] {
                        let idx = if path.segments.len() == 1 { None } else { Some(1) };
                        return Some((TypeNs::SelfType(*impl_), idx));
                    }
                }
                Scope::AdtScope(adt) => {
                    if first_name == &name![Self] {
                        let idx = if path.segments.len() == 1 { None } else { Some(1) };
                        return Some((TypeNs::AdtSelfType(*adt), idx));
                    }
                }
                Scope::ModuleScope(m) => {
                    let (module_def, idx) = m.crate_def_map.resolve_path(
                        db,
                        m.module_id,
                        &path,
                        BuiltinShadowMode::Other,
                    );
                    let res = to_type_ns(module_def)?;
                    return Some((res, idx));
                }
                Scope::LocalItemsScope(body) => {
                    let def = body.item_scope.get(first_name);
                    if let Some(res) = to_type_ns(def) {
                        return Some((res, None));
                    }
                }
            }
        }
        return None;
        fn to_type_ns(per_ns: PerNs) -> Option<TypeNs> {
            let res = match per_ns.take_types()? {
                ModuleDefId::AdtId(it) => TypeNs::AdtId(it),
                ModuleDefId::EnumVariantId(it) => TypeNs::EnumVariantId(it),

                ModuleDefId::TypeAliasId(it) => TypeNs::TypeAliasId(it),
                ModuleDefId::BuiltinType(it) => TypeNs::BuiltinType(it),

                ModuleDefId::TraitId(it) => TypeNs::TraitId(it),

                ModuleDefId::FunctionId(_)
                | ModuleDefId::ConstId(_)
                | ModuleDefId::StaticId(_)
                | ModuleDefId::ModuleId(_) => return None,
            };
            Some(res)
        }
    }

    pub fn resolve_path_in_type_ns_fully(
        &self,
        db: &dyn DefDatabase,
        path: &ModPath,
    ) -> Option<TypeNs> {
        let (res, unresolved) = self.resolve_path_in_type_ns(db, path)?;
        if unresolved.is_some() {
            return None;
        }
        Some(res)
    }

    pub fn resolve_visibility(
        &self,
        db: &dyn DefDatabase,
        visibility: &RawVisibility,
    ) -> Option<Visibility> {
        match visibility {
            RawVisibility::Module(_) => {
                let (item_map, module) = match self.module_scope() {
                    Some(it) => it,
                    None => return None,
                };
                item_map.resolve_visibility(db, module, visibility)
            }
            RawVisibility::Public => Some(Visibility::Public),
        }
    }

    pub fn resolve_path_in_value_ns(
        &self,
        db: &dyn DefDatabase,
        path: &ModPath,
    ) -> Option<ResolveValueResult> {
        let n_segments = path.segments.len();
        let tmp = name![self];
        let first_name = if path.is_self() { &tmp } else { &path.segments.first()? };
        let skip_to_mod = path.kind != PathKind::Plain && !path.is_self();
        for scope in self.scopes.iter().rev() {
            match scope {
                Scope::AdtScope(_)
                | Scope::ExprScope(_)
                | Scope::GenericParams { .. }
                | Scope::ImplDefScope(_)
                | Scope::LocalItemsScope(_)
                    if skip_to_mod =>
                {
                    continue
                }

                Scope::ExprScope(scope) if n_segments <= 1 => {
                    let entry = scope
                        .expr_scopes
                        .entries(scope.scope_id)
                        .iter()
                        .find(|entry| entry.name() == first_name);

                    if let Some(e) = entry {
                        return Some(ResolveValueResult::ValueNs(ValueNs::LocalBinding(e.pat())));
                    }
                }
                Scope::ExprScope(_) => continue,

                Scope::GenericParams { params, def } if n_segments > 1 => {
                    if let Some(local_id) = params.find_by_name(first_name) {
                        let ty = TypeNs::GenericParam(TypeParamId { local_id, parent: *def });
                        return Some(ResolveValueResult::Partial(ty, 1));
                    }
                }
                Scope::GenericParams { .. } => continue,

                Scope::ImplDefScope(impl_) => {
                    if first_name == &name![Self] {
                        if n_segments > 1 {
                            let ty = TypeNs::SelfType(*impl_);
                            return Some(ResolveValueResult::Partial(ty, 1));
                        } else {
                            return Some(ResolveValueResult::ValueNs(ValueNs::ImplSelf(*impl_)));
                        }
                    }
                }
                Scope::AdtScope(adt) => {
                    if n_segments == 1 {
                        // bare `Self` doesn't work in the value namespace in a struct/enum definition
                        continue;
                    }
                    if first_name == &name![Self] {
                        let ty = TypeNs::AdtSelfType(*adt);
                        return Some(ResolveValueResult::Partial(ty, 1));
                    }
                }

                Scope::ModuleScope(m) => {
                    let (module_def, idx) = m.crate_def_map.resolve_path(
                        db,
                        m.module_id,
                        &path,
                        BuiltinShadowMode::Other,
                    );
                    return match idx {
                        None => {
                            let value = to_value_ns(module_def)?;
                            Some(ResolveValueResult::ValueNs(value))
                        }
                        Some(idx) => {
                            let ty = match module_def.take_types()? {
                                ModuleDefId::AdtId(it) => TypeNs::AdtId(it),
                                ModuleDefId::TraitId(it) => TypeNs::TraitId(it),
                                ModuleDefId::TypeAliasId(it) => TypeNs::TypeAliasId(it),
                                ModuleDefId::BuiltinType(it) => TypeNs::BuiltinType(it),

                                ModuleDefId::ModuleId(_)
                                | ModuleDefId::FunctionId(_)
                                | ModuleDefId::EnumVariantId(_)
                                | ModuleDefId::ConstId(_)
                                | ModuleDefId::StaticId(_) => return None,
                            };
                            Some(ResolveValueResult::Partial(ty, idx))
                        }
                    };
                }
                Scope::LocalItemsScope(body) => {
                    // we don't bother looking in the builtin scope here because there are no builtin values
                    let def = to_value_ns(body.item_scope.get(first_name));

                    if let Some(res) = def {
                        return Some(ResolveValueResult::ValueNs(res));
                    }
                }
            }
        }
        return None;

        fn to_value_ns(per_ns: PerNs) -> Option<ValueNs> {
            let res = match per_ns.take_values()? {
                ModuleDefId::FunctionId(it) => ValueNs::FunctionId(it),
                ModuleDefId::AdtId(AdtId::StructId(it)) => ValueNs::StructId(it),
                ModuleDefId::EnumVariantId(it) => ValueNs::EnumVariantId(it),
                ModuleDefId::ConstId(it) => ValueNs::ConstId(it),
                ModuleDefId::StaticId(it) => ValueNs::StaticId(it),

                ModuleDefId::AdtId(AdtId::EnumId(_))
                | ModuleDefId::AdtId(AdtId::UnionId(_))
                | ModuleDefId::TraitId(_)
                | ModuleDefId::TypeAliasId(_)
                | ModuleDefId::BuiltinType(_)
                | ModuleDefId::ModuleId(_) => return None,
            };
            Some(res)
        }
    }

    pub fn resolve_path_in_value_ns_fully(
        &self,
        db: &dyn DefDatabase,
        path: &ModPath,
    ) -> Option<ValueNs> {
        match self.resolve_path_in_value_ns(db, path)? {
            ResolveValueResult::ValueNs(it) => Some(it),
            ResolveValueResult::Partial(..) => None,
        }
    }

    pub fn resolve_path_as_macro(
        &self,
        db: &dyn DefDatabase,
        path: &ModPath,
    ) -> Option<MacroDefId> {
        // Search item scope legacy macro first
        if let Some(def) = self.resolve_local_macro_def(path) {
            return Some(def);
        }

        let (item_map, module) = self.module_scope()?;
        item_map.resolve_path(db, module, &path, BuiltinShadowMode::Other).0.take_macros()
    }

    pub fn process_all_names(&self, db: &dyn DefDatabase, f: &mut dyn FnMut(Name, ScopeDef)) {
        for scope in self.scopes.iter().rev() {
            scope.process_names(db, f);
        }
    }

    pub fn traits_in_scope(&self, db: &dyn DefDatabase) -> FxHashSet<TraitId> {
        let mut traits = FxHashSet::default();
        for scope in &self.scopes {
            if let Scope::ModuleScope(m) = scope {
                if let Some(prelude) = m.crate_def_map.prelude {
                    let prelude_def_map = db.crate_def_map(prelude.krate);
                    traits.extend(prelude_def_map[prelude.local_id].scope.traits());
                }
                traits.extend(m.crate_def_map[m.module_id].scope.traits());
            }
        }
        traits
    }

    fn module_scope(&self) -> Option<(&CrateDefMap, LocalModuleId)> {
        self.scopes.iter().rev().find_map(|scope| match scope {
            Scope::ModuleScope(m) => Some((&*m.crate_def_map, m.module_id)),

            _ => None,
        })
    }

    fn resolve_local_macro_def(&self, path: &ModPath) -> Option<MacroDefId> {
        let name = path.as_ident()?;
        self.scopes.iter().rev().find_map(|scope| {
            if let Scope::LocalItemsScope(body) = scope {
                return body.item_scope.get_legacy_macro(name);
            }
            None
        })
    }

    pub fn module(&self) -> Option<ModuleId> {
        let (def_map, local_id) = self.module_scope()?;
        Some(ModuleId { krate: def_map.krate, local_id })
    }

    pub fn krate(&self) -> Option<CrateId> {
        self.module_scope().map(|t| t.0.krate)
    }

    pub fn where_predicates_in_scope<'a>(
        &'a self,
    ) -> impl Iterator<Item = &'a crate::generics::WherePredicate> + 'a {
        self.scopes
            .iter()
            .rev()
            .filter_map(|scope| match scope {
                Scope::GenericParams { params, .. } => Some(params),
                _ => None,
            })
            .flat_map(|params| params.where_predicates.iter())
    }

    pub fn generic_def(&self) -> Option<GenericDefId> {
        self.scopes.iter().rev().find_map(|scope| match scope {
            Scope::GenericParams { def, .. } => Some(*def),
            _ => None,
        })
    }

    pub fn body_owner(&self) -> Option<DefWithBodyId> {
        self.scopes.iter().rev().find_map(|scope| match scope {
            Scope::ExprScope(it) => Some(it.owner),
            _ => None,
        })
    }
}

pub enum ScopeDef {
    PerNs(PerNs),
    ImplSelfType(ImplId),
    AdtSelfType(AdtId),
    GenericParam(TypeParamId),
    Local(PatId),
}

impl Scope {
    fn process_names(&self, db: &dyn DefDatabase, f: &mut dyn FnMut(Name, ScopeDef)) {
        match self {
            Scope::ModuleScope(m) => {
                // FIXME: should we provide `self` here?
                // f(
                //     Name::self_param(),
                //     PerNs::types(Resolution::Def {
                //         def: m.module.into(),
                //     }),
                // );
                m.crate_def_map[m.module_id].scope.entries().for_each(|(name, def)| {
                    f(name.clone(), ScopeDef::PerNs(def));
                });
                m.crate_def_map[m.module_id].scope.legacy_macros().for_each(|(name, macro_)| {
                    f(name.clone(), ScopeDef::PerNs(PerNs::macros(macro_, Visibility::Public)));
                });
                m.crate_def_map.extern_prelude.iter().for_each(|(name, &def)| {
                    f(name.clone(), ScopeDef::PerNs(PerNs::types(def, Visibility::Public)));
                });
                BUILTIN_SCOPE.iter().for_each(|(name, &def)| {
                    f(name.clone(), ScopeDef::PerNs(def));
                });
                if let Some(prelude) = m.crate_def_map.prelude {
                    let prelude_def_map = db.crate_def_map(prelude.krate);
                    prelude_def_map[prelude.local_id].scope.entries().for_each(|(name, def)| {
                        f(name.clone(), ScopeDef::PerNs(def));
                    });
                }
            }
            Scope::LocalItemsScope(body) => body.item_scope.entries().for_each(|(name, def)| {
                f(name.clone(), ScopeDef::PerNs(def));
            }),
            Scope::GenericParams { params, def } => {
                for (local_id, param) in params.types.iter() {
                    if let Some(name) = &param.name {
                        f(
                            name.clone(),
                            ScopeDef::GenericParam(TypeParamId { local_id, parent: *def }),
                        )
                    }
                }
            }
            Scope::ImplDefScope(i) => {
                f(name![Self], ScopeDef::ImplSelfType(*i));
            }
            Scope::AdtScope(i) => {
                f(name![Self], ScopeDef::AdtSelfType(*i));
            }
            Scope::ExprScope(scope) => {
                scope.expr_scopes.entries(scope.scope_id).iter().for_each(|e| {
                    f(e.name().clone(), ScopeDef::Local(e.pat()));
                });
            }
        }
    }
}

// needs arbitrary_self_types to be a method... or maybe move to the def?
pub fn resolver_for_expr(db: &dyn DefDatabase, owner: DefWithBodyId, expr_id: ExprId) -> Resolver {
    let scopes = db.expr_scopes(owner);
    resolver_for_scope(db, owner, scopes.scope_for(expr_id))
}

pub fn resolver_for_scope(
    db: &dyn DefDatabase,
    owner: DefWithBodyId,
    scope_id: Option<ScopeId>,
) -> Resolver {
    let mut r = owner.resolver(db);
    r = r.push_local_items_scope(db.body(owner));
    let scopes = db.expr_scopes(owner);
    let scope_chain = scopes.scope_chain(scope_id).collect::<Vec<_>>();
    for scope in scope_chain.into_iter().rev() {
        r = r.push_expr_scope(owner, Arc::clone(&scopes), scope);
    }
    r
}

impl Resolver {
    fn push_scope(mut self, scope: Scope) -> Resolver {
        self.scopes.push(scope);
        self
    }

    fn push_generic_params_scope(self, db: &dyn DefDatabase, def: GenericDefId) -> Resolver {
        let params = db.generic_params(def);
        self.push_scope(Scope::GenericParams { def, params })
    }

    fn push_impl_def_scope(self, impl_def: ImplId) -> Resolver {
        self.push_scope(Scope::ImplDefScope(impl_def))
    }

    fn push_module_scope(
        self,
        crate_def_map: Arc<CrateDefMap>,
        module_id: LocalModuleId,
    ) -> Resolver {
        self.push_scope(Scope::ModuleScope(ModuleItemMap { crate_def_map, module_id }))
    }

    fn push_local_items_scope(self, body: Arc<Body>) -> Resolver {
        self.push_scope(Scope::LocalItemsScope(body))
    }

    fn push_expr_scope(
        self,
        owner: DefWithBodyId,
        expr_scopes: Arc<ExprScopes>,
        scope_id: ScopeId,
    ) -> Resolver {
        self.push_scope(Scope::ExprScope(ExprScope { owner, expr_scopes, scope_id }))
    }
}

pub trait HasResolver: Copy {
    /// Builds a resolver for type references inside this def.
    fn resolver(self, db: &dyn DefDatabase) -> Resolver;
}

impl HasResolver for ModuleId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        let def_map = db.crate_def_map(self.krate);
        Resolver::default().push_module_scope(def_map, self.local_id)
    }
}

impl HasResolver for TraitId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        self.lookup(db).container.resolver(db).push_generic_params_scope(db, self.into())
    }
}

impl<T: Into<AdtId> + Copy> HasResolver for T {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        let def = self.into();
        def.module(db)
            .resolver(db)
            .push_generic_params_scope(db, def.into())
            .push_scope(Scope::AdtScope(def))
    }
}

impl HasResolver for FunctionId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        self.lookup(db).container.resolver(db).push_generic_params_scope(db, self.into())
    }
}

impl HasResolver for ConstId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        self.lookup(db).container.resolver(db)
    }
}

impl HasResolver for StaticId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        self.lookup(db).container.resolver(db)
    }
}

impl HasResolver for TypeAliasId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        self.lookup(db).container.resolver(db).push_generic_params_scope(db, self.into())
    }
}

impl HasResolver for ImplId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        self.lookup(db)
            .container
            .resolver(db)
            .push_generic_params_scope(db, self.into())
            .push_impl_def_scope(self)
    }
}

impl HasResolver for DefWithBodyId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        match self {
            DefWithBodyId::ConstId(c) => c.resolver(db),
            DefWithBodyId::FunctionId(f) => f.resolver(db),
            DefWithBodyId::StaticId(s) => s.resolver(db),
        }
    }
}

impl HasResolver for ContainerId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        match self {
            ContainerId::ModuleId(it) => it.resolver(db),
            ContainerId::DefWithBodyId(it) => it.module(db).resolver(db),
        }
    }
}

impl HasResolver for AssocContainerId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        match self {
            AssocContainerId::ContainerId(it) => it.resolver(db),
            AssocContainerId::TraitId(it) => it.resolver(db),
            AssocContainerId::ImplId(it) => it.resolver(db),
        }
    }
}

impl HasResolver for GenericDefId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        match self {
            GenericDefId::FunctionId(inner) => inner.resolver(db),
            GenericDefId::AdtId(adt) => adt.resolver(db),
            GenericDefId::TraitId(inner) => inner.resolver(db),
            GenericDefId::TypeAliasId(inner) => inner.resolver(db),
            GenericDefId::ImplId(inner) => inner.resolver(db),
            GenericDefId::EnumVariantId(inner) => inner.parent.resolver(db),
            GenericDefId::ConstId(inner) => inner.resolver(db),
        }
    }
}

impl HasResolver for VariantId {
    fn resolver(self, db: &dyn DefDatabase) -> Resolver {
        match self {
            VariantId::EnumVariantId(it) => it.parent.resolver(db),
            VariantId::StructId(it) => it.resolver(db),
            VariantId::UnionId(it) => it.resolver(db),
        }
    }
}
