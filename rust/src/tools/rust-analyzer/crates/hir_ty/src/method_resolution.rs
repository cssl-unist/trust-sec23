//! This module is concerned with finding methods that a given type provides.
//! For details about how this works in rustc, see the method lookup page in the
//! [rustc guide](https://rust-lang.github.io/rustc-guide/method-lookup.html)
//! and the corresponding code mostly in librustc_typeck/check/method/probe.rs.
use std::{iter, sync::Arc};

use arrayvec::ArrayVec;
use base_db::CrateId;
use hir_def::{
    builtin_type::{IntBitness, Signedness},
    lang_item::LangItemTarget,
    type_ref::Mutability,
    AssocContainerId, AssocItemId, FunctionId, HasModule, ImplId, Lookup, TraitId,
};
use hir_expand::name::Name;
use rustc_hash::{FxHashMap, FxHashSet};

use super::Substs;
use crate::{
    autoderef,
    db::HirDatabase,
    primitive::{FloatBitness, FloatTy, IntTy},
    utils::all_super_traits,
    ApplicationTy, Canonical, DebruijnIndex, InEnvironment, TraitEnvironment, TraitRef, Ty, TyKind,
    TypeCtor, TypeWalk,
};

/// This is used as a key for indexing impls.
#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
pub enum TyFingerprint {
    Apply(TypeCtor),
}

impl TyFingerprint {
    /// Creates a TyFingerprint for looking up an impl. Only certain types can
    /// have impls: if we have some `struct S`, we can have an `impl S`, but not
    /// `impl &S`. Hence, this will return `None` for reference types and such.
    pub(crate) fn for_impl(ty: &Ty) -> Option<TyFingerprint> {
        match ty {
            Ty::Apply(a_ty) => Some(TyFingerprint::Apply(a_ty.ctor)),
            _ => None,
        }
    }
}

pub(crate) const ALL_INT_FPS: [TyFingerprint; 12] = [
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Unsigned,
        bitness: IntBitness::X8,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Unsigned,
        bitness: IntBitness::X16,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Unsigned,
        bitness: IntBitness::X32,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Unsigned,
        bitness: IntBitness::X64,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Unsigned,
        bitness: IntBitness::X128,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Unsigned,
        bitness: IntBitness::Xsize,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Signed,
        bitness: IntBitness::X8,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Signed,
        bitness: IntBitness::X16,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Signed,
        bitness: IntBitness::X32,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Signed,
        bitness: IntBitness::X64,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Signed,
        bitness: IntBitness::X128,
    })),
    TyFingerprint::Apply(TypeCtor::Int(IntTy {
        signedness: Signedness::Signed,
        bitness: IntBitness::Xsize,
    })),
];

pub(crate) const ALL_FLOAT_FPS: [TyFingerprint; 2] = [
    TyFingerprint::Apply(TypeCtor::Float(FloatTy { bitness: FloatBitness::X32 })),
    TyFingerprint::Apply(TypeCtor::Float(FloatTy { bitness: FloatBitness::X64 })),
];

/// Trait impls defined or available in some crate.
#[derive(Debug, Eq, PartialEq)]
pub struct TraitImpls {
    // If the `Option<TyFingerprint>` is `None`, the impl may apply to any self type.
    map: FxHashMap<TraitId, FxHashMap<Option<TyFingerprint>, Vec<ImplId>>>,
}

impl TraitImpls {
    pub(crate) fn trait_impls_in_crate_query(db: &dyn HirDatabase, krate: CrateId) -> Arc<Self> {
        let _p = profile::span("trait_impls_in_crate_query");
        let mut impls = Self { map: FxHashMap::default() };

        let crate_def_map = db.crate_def_map(krate);
        for (_module_id, module_data) in crate_def_map.modules.iter() {
            for impl_id in module_data.scope.impls() {
                let target_trait = match db.impl_trait(impl_id) {
                    Some(tr) => tr.value.trait_,
                    None => continue,
                };
                let self_ty = db.impl_self_ty(impl_id);
                let self_ty_fp = TyFingerprint::for_impl(&self_ty.value);
                impls
                    .map
                    .entry(target_trait)
                    .or_default()
                    .entry(self_ty_fp)
                    .or_default()
                    .push(impl_id);
            }
        }

        Arc::new(impls)
    }

    pub(crate) fn trait_impls_in_deps_query(db: &dyn HirDatabase, krate: CrateId) -> Arc<Self> {
        let _p = profile::span("trait_impls_in_deps_query");
        let crate_graph = db.crate_graph();
        let mut res = Self { map: FxHashMap::default() };

        for krate in crate_graph.transitive_deps(krate) {
            res.merge(&db.trait_impls_in_crate(krate));
        }

        Arc::new(res)
    }

    fn merge(&mut self, other: &Self) {
        for (trait_, other_map) in &other.map {
            let map = self.map.entry(*trait_).or_default();
            for (fp, impls) in other_map {
                let vec = map.entry(*fp).or_default();
                vec.extend(impls);
            }
        }
    }

    /// Queries all impls of the given trait.
    pub fn for_trait(&self, trait_: TraitId) -> impl Iterator<Item = ImplId> + '_ {
        self.map
            .get(&trait_)
            .into_iter()
            .flat_map(|map| map.values().flat_map(|v| v.iter().copied()))
    }

    /// Queries all impls of `trait_` that may apply to `self_ty`.
    pub fn for_trait_and_self_ty(
        &self,
        trait_: TraitId,
        self_ty: TyFingerprint,
    ) -> impl Iterator<Item = ImplId> + '_ {
        self.map
            .get(&trait_)
            .into_iter()
            .flat_map(move |map| map.get(&None).into_iter().chain(map.get(&Some(self_ty))))
            .flat_map(|v| v.iter().copied())
    }

    pub fn all_impls(&self) -> impl Iterator<Item = ImplId> + '_ {
        self.map.values().flat_map(|map| map.values().flat_map(|v| v.iter().copied()))
    }
}

/// Inherent impls defined in some crate.
///
/// Inherent impls can only be defined in the crate that also defines the self type of the impl
/// (note that some primitives are considered to be defined by both libcore and liballoc).
///
/// This makes inherent impl lookup easier than trait impl lookup since we only have to consider a
/// single crate.
#[derive(Debug, Eq, PartialEq)]
pub struct InherentImpls {
    map: FxHashMap<TyFingerprint, Vec<ImplId>>,
}

impl InherentImpls {
    pub(crate) fn inherent_impls_in_crate_query(db: &dyn HirDatabase, krate: CrateId) -> Arc<Self> {
        let mut map: FxHashMap<_, Vec<_>> = FxHashMap::default();

        let crate_def_map = db.crate_def_map(krate);
        for (_module_id, module_data) in crate_def_map.modules.iter() {
            for impl_id in module_data.scope.impls() {
                let data = db.impl_data(impl_id);
                if data.target_trait.is_some() {
                    continue;
                }

                let self_ty = db.impl_self_ty(impl_id);
                if let Some(fp) = TyFingerprint::for_impl(&self_ty.value) {
                    map.entry(fp).or_default().push(impl_id);
                }
            }
        }

        Arc::new(Self { map })
    }

    pub fn for_self_ty(&self, self_ty: &Ty) -> &[ImplId] {
        match TyFingerprint::for_impl(self_ty) {
            Some(fp) => self.map.get(&fp).map(|vec| vec.as_ref()).unwrap_or(&[]),
            None => &[],
        }
    }

    pub fn all_impls(&self) -> impl Iterator<Item = ImplId> + '_ {
        self.map.values().flat_map(|v| v.iter().copied())
    }
}

impl Ty {
    pub fn def_crates(
        &self,
        db: &dyn HirDatabase,
        cur_crate: CrateId,
    ) -> Option<ArrayVec<[CrateId; 2]>> {
        // Types like slice can have inherent impls in several crates, (core and alloc).
        // The corresponding impls are marked with lang items, so we can use them to find the required crates.
        macro_rules! lang_item_crate {
            ($($name:expr),+ $(,)?) => {{
                let mut v = ArrayVec::<[LangItemTarget; 2]>::new();
                $(
                    v.extend(db.lang_item(cur_crate, $name.into()));
                )+
                v
            }};
        }

        let lang_item_targets = match self {
            Ty::Apply(a_ty) => match a_ty.ctor {
                TypeCtor::Adt(def_id) => {
                    return Some(std::iter::once(def_id.module(db.upcast()).krate).collect())
                }
                TypeCtor::Bool => lang_item_crate!("bool"),
                TypeCtor::Char => lang_item_crate!("char"),
                TypeCtor::Float(f) => match f.bitness {
                    // There are two lang items: one in libcore (fXX) and one in libstd (fXX_runtime)
                    FloatBitness::X32 => lang_item_crate!("f32", "f32_runtime"),
                    FloatBitness::X64 => lang_item_crate!("f64", "f64_runtime"),
                },
                TypeCtor::Int(i) => lang_item_crate!(i.ty_to_string()),
                TypeCtor::Str => lang_item_crate!("str_alloc", "str"),
                TypeCtor::Slice => lang_item_crate!("slice_alloc", "slice"),
                TypeCtor::RawPtr(Mutability::Shared) => lang_item_crate!("const_ptr"),
                TypeCtor::RawPtr(Mutability::Mut) => lang_item_crate!("mut_ptr"),
                _ => return None,
            },
            _ => return None,
        };
        let res = lang_item_targets
            .into_iter()
            .filter_map(|it| match it {
                LangItemTarget::ImplDefId(it) => Some(it),
                _ => None,
            })
            .map(|it| it.lookup(db.upcast()).container.module(db.upcast()).krate)
            .collect();
        Some(res)
    }
}
/// Look up the method with the given name, returning the actual autoderefed
/// receiver type (but without autoref applied yet).
pub(crate) fn lookup_method(
    ty: &Canonical<Ty>,
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    traits_in_scope: &FxHashSet<TraitId>,
    name: &Name,
) -> Option<(Ty, FunctionId)> {
    iterate_method_candidates(
        ty,
        db,
        env,
        krate,
        &traits_in_scope,
        Some(name),
        LookupMode::MethodCall,
        |ty, f| match f {
            AssocItemId::FunctionId(f) => Some((ty.clone(), f)),
            _ => None,
        },
    )
}

/// Whether we're looking up a dotted method call (like `v.len()`) or a path
/// (like `Vec::new`).
#[derive(Copy, Clone, Debug, PartialEq, Eq)]
pub enum LookupMode {
    /// Looking up a method call like `v.len()`: We only consider candidates
    /// that have a `self` parameter, and do autoderef.
    MethodCall,
    /// Looking up a path like `Vec::new` or `Vec::default`: We consider all
    /// candidates including associated constants, but don't do autoderef.
    Path,
}

// This would be nicer if it just returned an iterator, but that runs into
// lifetime problems, because we need to borrow temp `CrateImplDefs`.
// FIXME add a context type here?
pub fn iterate_method_candidates<T>(
    ty: &Canonical<Ty>,
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    traits_in_scope: &FxHashSet<TraitId>,
    name: Option<&Name>,
    mode: LookupMode,
    mut callback: impl FnMut(&Ty, AssocItemId) -> Option<T>,
) -> Option<T> {
    let mut slot = None;
    iterate_method_candidates_impl(
        ty,
        db,
        env,
        krate,
        traits_in_scope,
        name,
        mode,
        &mut |ty, item| {
            assert!(slot.is_none());
            slot = callback(ty, item);
            slot.is_some()
        },
    );
    slot
}

fn iterate_method_candidates_impl(
    ty: &Canonical<Ty>,
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    traits_in_scope: &FxHashSet<TraitId>,
    name: Option<&Name>,
    mode: LookupMode,
    callback: &mut dyn FnMut(&Ty, AssocItemId) -> bool,
) -> bool {
    match mode {
        LookupMode::MethodCall => {
            // For method calls, rust first does any number of autoderef, and then one
            // autoref (i.e. when the method takes &self or &mut self). We just ignore
            // the autoref currently -- when we find a method matching the given name,
            // we assume it fits.

            // Also note that when we've got a receiver like &S, even if the method we
            // find in the end takes &self, we still do the autoderef step (just as
            // rustc does an autoderef and then autoref again).
            let ty = InEnvironment { value: ty.clone(), environment: env.clone() };

            // We have to be careful about the order we're looking at candidates
            // in here. Consider the case where we're resolving `x.clone()`
            // where `x: &Vec<_>`. This resolves to the clone method with self
            // type `Vec<_>`, *not* `&_`. I.e. we need to consider methods where
            // the receiver type exactly matches before cases where we have to
            // do autoref. But in the autoderef steps, the `&_` self type comes
            // up *before* the `Vec<_>` self type.
            //
            // On the other hand, we don't want to just pick any by-value method
            // before any by-autoref method; it's just that we need to consider
            // the methods by autoderef order of *receiver types*, not *self
            // types*.

            let deref_chain = autoderef_method_receiver(db, krate, ty);
            for i in 0..deref_chain.len() {
                if iterate_method_candidates_with_autoref(
                    &deref_chain[i..],
                    db,
                    env.clone(),
                    krate,
                    traits_in_scope,
                    name,
                    callback,
                ) {
                    return true;
                }
            }
            false
        }
        LookupMode::Path => {
            // No autoderef for path lookups
            iterate_method_candidates_for_self_ty(
                &ty,
                db,
                env,
                krate,
                traits_in_scope,
                name,
                callback,
            )
        }
    }
}

fn iterate_method_candidates_with_autoref(
    deref_chain: &[Canonical<Ty>],
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    traits_in_scope: &FxHashSet<TraitId>,
    name: Option<&Name>,
    mut callback: &mut dyn FnMut(&Ty, AssocItemId) -> bool,
) -> bool {
    if iterate_method_candidates_by_receiver(
        &deref_chain[0],
        &deref_chain[1..],
        db,
        env.clone(),
        krate,
        &traits_in_scope,
        name,
        &mut callback,
    ) {
        return true;
    }
    let refed = Canonical {
        kinds: deref_chain[0].kinds.clone(),
        value: Ty::apply_one(TypeCtor::Ref(Mutability::Shared), deref_chain[0].value.clone()),
    };
    if iterate_method_candidates_by_receiver(
        &refed,
        deref_chain,
        db,
        env.clone(),
        krate,
        &traits_in_scope,
        name,
        &mut callback,
    ) {
        return true;
    }
    let ref_muted = Canonical {
        kinds: deref_chain[0].kinds.clone(),
        value: Ty::apply_one(TypeCtor::Ref(Mutability::Mut), deref_chain[0].value.clone()),
    };
    if iterate_method_candidates_by_receiver(
        &ref_muted,
        deref_chain,
        db,
        env,
        krate,
        &traits_in_scope,
        name,
        &mut callback,
    ) {
        return true;
    }
    false
}

fn iterate_method_candidates_by_receiver(
    receiver_ty: &Canonical<Ty>,
    rest_of_deref_chain: &[Canonical<Ty>],
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    traits_in_scope: &FxHashSet<TraitId>,
    name: Option<&Name>,
    mut callback: &mut dyn FnMut(&Ty, AssocItemId) -> bool,
) -> bool {
    // We're looking for methods with *receiver* type receiver_ty. These could
    // be found in any of the derefs of receiver_ty, so we have to go through
    // that.
    for self_ty in std::iter::once(receiver_ty).chain(rest_of_deref_chain) {
        if iterate_inherent_methods(self_ty, db, name, Some(receiver_ty), krate, &mut callback) {
            return true;
        }
    }
    for self_ty in std::iter::once(receiver_ty).chain(rest_of_deref_chain) {
        if iterate_trait_method_candidates(
            self_ty,
            db,
            env.clone(),
            krate,
            &traits_in_scope,
            name,
            Some(receiver_ty),
            &mut callback,
        ) {
            return true;
        }
    }
    false
}

fn iterate_method_candidates_for_self_ty(
    self_ty: &Canonical<Ty>,
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    traits_in_scope: &FxHashSet<TraitId>,
    name: Option<&Name>,
    mut callback: &mut dyn FnMut(&Ty, AssocItemId) -> bool,
) -> bool {
    if iterate_inherent_methods(self_ty, db, name, None, krate, &mut callback) {
        return true;
    }
    iterate_trait_method_candidates(self_ty, db, env, krate, traits_in_scope, name, None, callback)
}

fn iterate_trait_method_candidates(
    self_ty: &Canonical<Ty>,
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    traits_in_scope: &FxHashSet<TraitId>,
    name: Option<&Name>,
    receiver_ty: Option<&Canonical<Ty>>,
    callback: &mut dyn FnMut(&Ty, AssocItemId) -> bool,
) -> bool {
    // if ty is `dyn Trait`, the trait doesn't need to be in scope
    let inherent_trait =
        self_ty.value.dyn_trait().into_iter().flat_map(|t| all_super_traits(db.upcast(), t));
    let env_traits = if let Ty::Placeholder(_) = self_ty.value {
        // if we have `T: Trait` in the param env, the trait doesn't need to be in scope
        env.trait_predicates_for_self_ty(&self_ty.value)
            .map(|tr| tr.trait_)
            .flat_map(|t| all_super_traits(db.upcast(), t))
            .collect()
    } else {
        Vec::new()
    };
    let traits =
        inherent_trait.chain(env_traits.into_iter()).chain(traits_in_scope.iter().copied());
    'traits: for t in traits {
        let data = db.trait_data(t);

        // we'll be lazy about checking whether the type implements the
        // trait, but if we find out it doesn't, we'll skip the rest of the
        // iteration
        let mut known_implemented = false;
        for (_name, item) in data.items.iter() {
            if !is_valid_candidate(db, name, receiver_ty, *item, self_ty) {
                continue;
            }
            if !known_implemented {
                let goal = generic_implements_goal(db, env.clone(), t, self_ty.clone());
                if db.trait_solve(krate, goal).is_none() {
                    continue 'traits;
                }
            }
            known_implemented = true;
            if callback(&self_ty.value, *item) {
                return true;
            }
        }
    }
    false
}

fn iterate_inherent_methods(
    self_ty: &Canonical<Ty>,
    db: &dyn HirDatabase,
    name: Option<&Name>,
    receiver_ty: Option<&Canonical<Ty>>,
    krate: CrateId,
    callback: &mut dyn FnMut(&Ty, AssocItemId) -> bool,
) -> bool {
    let def_crates = match self_ty.value.def_crates(db, krate) {
        Some(k) => k,
        None => return false,
    };
    for krate in def_crates {
        let impls = db.inherent_impls_in_crate(krate);

        for &impl_def in impls.for_self_ty(&self_ty.value) {
            for &item in db.impl_data(impl_def).items.iter() {
                if !is_valid_candidate(db, name, receiver_ty, item, self_ty) {
                    continue;
                }
                // we have to check whether the self type unifies with the type
                // that the impl is for. If we have a receiver type, this
                // already happens in `is_valid_candidate` above; if not, we
                // check it here
                if receiver_ty.is_none() && inherent_impl_substs(db, impl_def, self_ty).is_none() {
                    test_utils::mark::hit!(impl_self_type_match_without_receiver);
                    continue;
                }
                if callback(&self_ty.value, item) {
                    return true;
                }
            }
        }
    }
    false
}

/// Returns the self type for the index trait call.
pub fn resolve_indexing_op(
    db: &dyn HirDatabase,
    ty: &Canonical<Ty>,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    index_trait: TraitId,
) -> Option<Canonical<Ty>> {
    let ty = InEnvironment { value: ty.clone(), environment: env.clone() };
    let deref_chain = autoderef_method_receiver(db, krate, ty);
    for ty in deref_chain {
        let goal = generic_implements_goal(db, env.clone(), index_trait, ty.clone());
        if db.trait_solve(krate, goal).is_some() {
            return Some(ty);
        }
    }
    None
}

fn is_valid_candidate(
    db: &dyn HirDatabase,
    name: Option<&Name>,
    receiver_ty: Option<&Canonical<Ty>>,
    item: AssocItemId,
    self_ty: &Canonical<Ty>,
) -> bool {
    match item {
        AssocItemId::FunctionId(m) => {
            let data = db.function_data(m);
            if let Some(name) = name {
                if &data.name != name {
                    return false;
                }
            }
            if let Some(receiver_ty) = receiver_ty {
                if !data.has_self_param {
                    return false;
                }
                let transformed_receiver_ty = match transform_receiver_ty(db, m, self_ty) {
                    Some(ty) => ty,
                    None => return false,
                };
                if transformed_receiver_ty != receiver_ty.value {
                    return false;
                }
            }
            true
        }
        AssocItemId::ConstId(c) => {
            let data = db.const_data(c);
            name.map_or(true, |name| data.name.as_ref() == Some(name)) && receiver_ty.is_none()
        }
        _ => false,
    }
}

pub(crate) fn inherent_impl_substs(
    db: &dyn HirDatabase,
    impl_id: ImplId,
    self_ty: &Canonical<Ty>,
) -> Option<Substs> {
    // we create a var for each type parameter of the impl; we need to keep in
    // mind here that `self_ty` might have vars of its own
    let vars = Substs::build_for_def(db, impl_id)
        .fill_with_bound_vars(DebruijnIndex::INNERMOST, self_ty.kinds.len())
        .build();
    let self_ty_with_vars = db.impl_self_ty(impl_id).subst(&vars);
    let mut kinds = self_ty.kinds.to_vec();
    kinds.extend(iter::repeat(TyKind::General).take(vars.len()));
    let tys = Canonical { kinds: kinds.into(), value: (self_ty_with_vars, self_ty.value.clone()) };
    let substs = super::infer::unify(&tys);
    // We only want the substs for the vars we added, not the ones from self_ty.
    // Also, if any of the vars we added are still in there, we replace them by
    // Unknown. I think this can only really happen if self_ty contained
    // Unknown, and in that case we want the result to contain Unknown in those
    // places again.
    substs.map(|s| fallback_bound_vars(s.suffix(vars.len()), self_ty.kinds.len()))
}

/// This replaces any 'free' Bound vars in `s` (i.e. those with indices past
/// num_vars_to_keep) by `Ty::Unknown`.
fn fallback_bound_vars(s: Substs, num_vars_to_keep: usize) -> Substs {
    s.fold_binders(
        &mut |ty, binders| {
            if let Ty::Bound(bound) = &ty {
                if bound.index >= num_vars_to_keep && bound.debruijn >= binders {
                    Ty::Unknown
                } else {
                    ty
                }
            } else {
                ty
            }
        },
        DebruijnIndex::INNERMOST,
    )
}

fn transform_receiver_ty(
    db: &dyn HirDatabase,
    function_id: FunctionId,
    self_ty: &Canonical<Ty>,
) -> Option<Ty> {
    let substs = match function_id.lookup(db.upcast()).container {
        AssocContainerId::TraitId(_) => Substs::build_for_def(db, function_id)
            .push(self_ty.value.clone())
            .fill_with_unknown()
            .build(),
        AssocContainerId::ImplId(impl_id) => inherent_impl_substs(db, impl_id, &self_ty)?,
        AssocContainerId::ContainerId(_) => unreachable!(),
    };
    let sig = db.callable_item_signature(function_id.into());
    Some(sig.value.params()[0].clone().subst_bound_vars(&substs))
}

pub fn implements_trait(
    ty: &Canonical<Ty>,
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    krate: CrateId,
    trait_: TraitId,
) -> bool {
    let goal = generic_implements_goal(db, env, trait_, ty.clone());
    let solution = db.trait_solve(krate, goal);

    solution.is_some()
}

/// This creates Substs for a trait with the given Self type and type variables
/// for all other parameters, to query Chalk with it.
fn generic_implements_goal(
    db: &dyn HirDatabase,
    env: Arc<TraitEnvironment>,
    trait_: TraitId,
    self_ty: Canonical<Ty>,
) -> Canonical<InEnvironment<super::Obligation>> {
    let mut kinds = self_ty.kinds.to_vec();
    let substs = super::Substs::build_for_def(db, trait_)
        .push(self_ty.value)
        .fill_with_bound_vars(DebruijnIndex::INNERMOST, kinds.len())
        .build();
    kinds.extend(iter::repeat(TyKind::General).take(substs.len() - 1));
    let trait_ref = TraitRef { trait_, substs };
    let obligation = super::Obligation::Trait(trait_ref);
    Canonical { kinds: kinds.into(), value: InEnvironment::new(env, obligation) }
}

fn autoderef_method_receiver(
    db: &dyn HirDatabase,
    krate: CrateId,
    ty: InEnvironment<Canonical<Ty>>,
) -> Vec<Canonical<Ty>> {
    let mut deref_chain: Vec<_> = autoderef::autoderef(db, Some(krate), ty).collect();
    // As a last step, we can do array unsizing (that's the only unsizing that rustc does for method receivers!)
    if let Some(Ty::Apply(ApplicationTy { ctor: TypeCtor::Array, parameters })) =
        deref_chain.last().map(|ty| &ty.value)
    {
        let kinds = deref_chain.last().unwrap().kinds.clone();
        let unsized_ty = Ty::apply(TypeCtor::Slice, parameters.clone());
        deref_chain.push(Canonical { value: unsized_ty, kinds })
    }
    deref_chain
}
