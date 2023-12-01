use rustc_data_structures::fx::FxHashMap;
use rustc_hir::def_id::DefId;
use rustc_middle::ty::{self, OutlivesPredicate, TyCtxt};

use super::utils::*;

#[derive(Debug)]
pub struct ExplicitPredicatesMap<'tcx> {
    map: FxHashMap<DefId, RequiredPredicates<'tcx>>,
}

impl<'tcx> ExplicitPredicatesMap<'tcx> {
    pub fn new() -> ExplicitPredicatesMap<'tcx> {
        ExplicitPredicatesMap { map: FxHashMap::default() }
    }

    pub fn explicit_predicates_of(
        &mut self,
        tcx: TyCtxt<'tcx>,
        def_id: DefId,
    ) -> &RequiredPredicates<'tcx> {
        self.map.entry(def_id).or_insert_with(|| {
            let predicates = if def_id.is_local() {
                tcx.explicit_predicates_of(def_id)
            } else {
                tcx.predicates_of(def_id)
            };
            let mut required_predicates = RequiredPredicates::default();

            // process predicates and convert to `RequiredPredicates` entry, see below
            for &(predicate, span) in predicates.predicates {
                match predicate.skip_binders() {
                    ty::PredicateAtom::TypeOutlives(OutlivesPredicate(ref ty, ref reg)) => {
                        insert_outlives_predicate(
                            tcx,
                            (*ty).into(),
                            reg,
                            span,
                            &mut required_predicates,
                        )
                    }

                    ty::PredicateAtom::RegionOutlives(OutlivesPredicate(ref reg1, ref reg2)) => {
                        insert_outlives_predicate(
                            tcx,
                            (*reg1).into(),
                            reg2,
                            span,
                            &mut required_predicates,
                        )
                    }

                    ty::PredicateAtom::Trait(..)
                    | ty::PredicateAtom::Projection(..)
                    | ty::PredicateAtom::WellFormed(..)
                    | ty::PredicateAtom::ObjectSafe(..)
                    | ty::PredicateAtom::ClosureKind(..)
                    | ty::PredicateAtom::Subtype(..)
                    | ty::PredicateAtom::ConstEvaluatable(..)
                    | ty::PredicateAtom::ConstEquate(..)
                    | ty::PredicateAtom::TypeWellFormedFromEnv(..) => (),
                }
            }

            required_predicates
        })
    }
}
