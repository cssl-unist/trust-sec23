use crate::ty::tls;

use rustc_query_system::query::deadlock;
use rustc_rayon_core as rayon_core;
use std::thread;

/// Creates a new thread and forwards information in thread locals to it.
/// The new thread runs the deadlock handler.
/// Must only be called when a deadlock is about to happen.
pub unsafe fn handle_deadlock() {
    let registry = rayon_core::Registry::current();

    let context = tls::get_tlv();
    assert!(context != 0);
    rustc_data_structures::sync::assert_sync::<tls::ImplicitCtxt<'_, '_>>();
    let icx: &tls::ImplicitCtxt<'_, '_> = &*(context as *const tls::ImplicitCtxt<'_, '_>);

    let session_globals = rustc_span::SESSION_GLOBALS.with(|sg| sg as *const _);
    let session_globals = &*session_globals;
    thread::spawn(move || {
        tls::enter_context(icx, |_| {
            rustc_span::SESSION_GLOBALS
                .set(session_globals, || tls::with(|tcx| deadlock(tcx, &registry)))
        })
    });
}
