//! Walks the crate looking for items/impl-items/trait-items that have
//! either a `rustc_symbol_name` or `rustc_def_path` attribute and
//! generates an error giving, respectively, the symbol name or
//! def-path. This is used for unit testing the code that generates
//! paths etc in all kinds of annoying scenarios.

use rustc_hir as hir;
use rustc_middle::ty::print::with_no_trimmed_paths;
use rustc_middle::ty::{subst::InternalSubsts, Instance, TyCtxt};
use rustc_span::symbol::{sym, Symbol};

const SYMBOL_NAME: Symbol = sym::rustc_symbol_name;
const DEF_PATH: Symbol = sym::rustc_def_path;

pub fn report_symbol_names(tcx: TyCtxt<'_>) {
    // if the `rustc_attrs` feature is not enabled, then the
    // attributes we are interested in cannot be present anyway, so
    // skip the walk.
    if !tcx.features().rustc_attrs {
        return;
    }

    tcx.dep_graph.with_ignore(|| {
        let mut visitor = SymbolNamesTest { tcx };
        tcx.hir().krate().visit_all_item_likes(&mut visitor);
    })
}

struct SymbolNamesTest<'tcx> {
    tcx: TyCtxt<'tcx>,
}

impl SymbolNamesTest<'tcx> {
    fn process_attrs(&mut self, hir_id: hir::HirId) {
        let tcx = self.tcx;
        let def_id = tcx.hir().local_def_id(hir_id);
        for attr in tcx.get_attrs(def_id.to_def_id()).iter() {
            if tcx.sess.check_name(attr, SYMBOL_NAME) {
                let def_id = def_id.to_def_id();
                let instance = Instance::new(
                    def_id,
                    tcx.erase_regions(&InternalSubsts::identity_for_item(tcx, def_id)),
                );
                let mangled = tcx.symbol_name(instance);
                tcx.sess.span_err(attr.span, &format!("symbol-name({})", mangled));
                if let Ok(demangling) = rustc_demangle::try_demangle(mangled.name) {
                    tcx.sess.span_err(attr.span, &format!("demangling({})", demangling));
                    tcx.sess.span_err(attr.span, &format!("demangling-alt({:#})", demangling));
                }
            } else if tcx.sess.check_name(attr, DEF_PATH) {
                let path = with_no_trimmed_paths(|| tcx.def_path_str(def_id.to_def_id()));
                tcx.sess.span_err(attr.span, &format!("def-path({})", path));
            }

            // (*) The formatting of `tag({})` is chosen so that tests can elect
            // to test the entirety of the string, if they choose, or else just
            // some subset.
        }
    }
}

impl hir::itemlikevisit::ItemLikeVisitor<'tcx> for SymbolNamesTest<'tcx> {
    fn visit_item(&mut self, item: &'tcx hir::Item<'tcx>) {
        self.process_attrs(item.hir_id);
    }

    fn visit_trait_item(&mut self, trait_item: &'tcx hir::TraitItem<'tcx>) {
        self.process_attrs(trait_item.hir_id);
    }

    fn visit_impl_item(&mut self, impl_item: &'tcx hir::ImplItem<'tcx>) {
        self.process_attrs(impl_item.hir_id);
    }
}
