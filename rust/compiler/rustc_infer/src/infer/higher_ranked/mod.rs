//! Helper routines for higher-ranked things. See the `doc` module at
//! the end of the file for details.

use super::combine::CombineFields;
use super::{HigherRankedType, InferCtxt};

use crate::infer::CombinedSnapshot;
use rustc_middle::ty::relate::{Relate, RelateResult, TypeRelation};
use rustc_middle::ty::{self, Binder, TypeFoldable};

impl<'a, 'tcx> CombineFields<'a, 'tcx> {
    pub fn higher_ranked_sub<T>(
        &mut self,
        a: Binder<T>,
        b: Binder<T>,
        a_is_expected: bool,
    ) -> RelateResult<'tcx, Binder<T>>
    where
        T: Relate<'tcx>,
    {
        debug!("higher_ranked_sub(a={:?}, b={:?})", a, b);

        // Rather than checking the subtype relationship between `a` and `b`
        // as-is, we need to do some extra work here in order to make sure
        // that function subtyping works correctly with respect to regions
        //
        // Note: this is a subtle algorithm.  For a full explanation,
        // please see the large comment at the end of the file in the (inlined) module
        // `doc`.

        let span = self.trace.cause.span;

        self.infcx.commit_if_ok(|_| {
            // First, we instantiate each bound region in the supertype with a
            // fresh placeholder region.
            let b_prime = self.infcx.replace_bound_vars_with_placeholders(&b);

            // Next, we instantiate each bound region in the subtype
            // with a fresh region variable. These region variables --
            // but no other pre-existing region variables -- can name
            // the placeholders.
            let (a_prime, _) =
                self.infcx.replace_bound_vars_with_fresh_vars(span, HigherRankedType, &a);

            debug!("a_prime={:?}", a_prime);
            debug!("b_prime={:?}", b_prime);

            // Compare types now that bound regions have been replaced.
            let result = self.sub(a_is_expected).relate(a_prime, b_prime)?;

            debug!("higher_ranked_sub: OK result={:?}", result);

            Ok(ty::Binder::bind(result))
        })
    }
}

impl<'a, 'tcx> InferCtxt<'a, 'tcx> {
    /// Replaces all regions (resp. types) bound by `binder` with placeholder
    /// regions (resp. types) and return a map indicating which bound-region
    /// placeholder region. This is the first step of checking subtyping
    /// when higher-ranked things are involved.
    ///
    /// **Important:** You have to be careful to not leak these placeholders,
    /// for more information about how placeholders and HRTBs work, see
    /// the [rustc dev guide].
    ///
    /// [rustc dev guide]: https://rustc-dev-guide.rust-lang.org/traits/hrtb.html
    pub fn replace_bound_vars_with_placeholders<T>(&self, binder: &ty::Binder<T>) -> T
    where
        T: TypeFoldable<'tcx>,
    {
        // Figure out what the next universe will be, but don't actually create
        // it until after we've done the substitution (in particular there may
        // be no bound variables). This is a performance optimization, since the
        // leak check for example can be skipped if no new universes are created
        // (i.e., if there are no placeholders).
        let next_universe = self.universe().next_universe();

        let fld_r = |br| {
            self.tcx.mk_region(ty::RePlaceholder(ty::PlaceholderRegion {
                universe: next_universe,
                name: br,
            }))
        };

        let fld_t = |bound_ty: ty::BoundTy| {
            self.tcx.mk_ty(ty::Placeholder(ty::PlaceholderType {
                universe: next_universe,
                name: bound_ty.var,
            }))
        };

        let fld_c = |bound_var: ty::BoundVar, ty| {
            self.tcx.mk_const(ty::Const {
                val: ty::ConstKind::Placeholder(ty::PlaceholderConst {
                    universe: next_universe,
                    name: bound_var,
                }),
                ty,
            })
        };

        let (result, map) = self.tcx.replace_bound_vars(binder, fld_r, fld_t, fld_c);

        // If there were higher-ranked regions to replace, then actually create
        // the next universe (this avoids needlessly creating universes).
        if !map.is_empty() {
            let n_u = self.create_next_universe();
            assert_eq!(n_u, next_universe);
        }

        debug!(
            "replace_bound_vars_with_placeholders(\
             next_universe={:?}, \
             binder={:?}, \
             result={:?}, \
             map={:?})",
            next_universe, binder, result, map,
        );

        result
    }

    /// See `infer::region_constraints::RegionConstraintCollector::leak_check`.
    pub fn leak_check(
        &self,
        overly_polymorphic: bool,
        snapshot: &CombinedSnapshot<'_, 'tcx>,
    ) -> RelateResult<'tcx, ()> {
        // If the user gave `-Zno-leak-check`, or we have been
        // configured to skip the leak check, then skip the leak check
        // completely. The leak check is deprecated. Any legitimate
        // subtyping errors that it would have caught will now be
        // caught later on, during region checking. However, we
        // continue to use it for a transition period.
        if self.tcx.sess.opts.debugging_opts.no_leak_check || self.skip_leak_check.get() {
            return Ok(());
        }

        self.inner.borrow_mut().unwrap_region_constraints().leak_check(
            self.tcx,
            overly_polymorphic,
            self.universe(),
            snapshot,
        )
    }
}
