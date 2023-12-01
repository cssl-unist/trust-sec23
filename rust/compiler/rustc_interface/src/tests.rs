use crate::interface::parse_cfgspecs;

use rustc_data_structures::fx::FxHashSet;
use rustc_errors::{emitter::HumanReadableErrorType, registry, ColorConfig};
use rustc_session::config::Strip;
use rustc_session::config::{build_configuration, build_session_options, to_crate_config};
use rustc_session::config::{rustc_optgroups, ErrorOutputType, ExternLocation, Options, Passes};
use rustc_session::config::{CFGuard, ExternEntry, LinkerPluginLto, LtoCli, SwitchWithOptPath};
use rustc_session::config::{
    Externs, OutputType, OutputTypes, SanitizerSet, SymbolManglingVersion,
};
use rustc_session::lint::Level;
use rustc_session::search_paths::SearchPath;
use rustc_session::utils::NativeLibKind;
use rustc_session::{build_session, getopts, DiagnosticOutput, Session};
use rustc_span::edition::{Edition, DEFAULT_EDITION};
use rustc_span::symbol::sym;
use rustc_span::SourceFileHashAlgorithm;
use rustc_target::spec::{CodeModel, LinkerFlavor, MergeFunctions, PanicStrategy};
use rustc_target::spec::{RelocModel, RelroLevel, TlsModel};
use std::collections::{BTreeMap, BTreeSet};
use std::iter::FromIterator;
use std::path::PathBuf;

type CfgSpecs = FxHashSet<(String, Option<String>)>;

fn build_session_options_and_crate_config(matches: getopts::Matches) -> (Options, CfgSpecs) {
    let sessopts = build_session_options(&matches);
    let cfg = parse_cfgspecs(matches.opt_strs("cfg"));
    (sessopts, cfg)
}

fn mk_session(matches: getopts::Matches) -> (Session, CfgSpecs) {
    let registry = registry::Registry::new(&[]);
    let (sessopts, cfg) = build_session_options_and_crate_config(matches);
    let sess = build_session(
        sessopts,
        None,
        registry,
        DiagnosticOutput::Default,
        Default::default(),
        None,
        None,
    );
    (sess, cfg)
}

fn new_public_extern_entry<S, I>(locations: I) -> ExternEntry
where
    S: Into<String>,
    I: IntoIterator<Item = S>,
{
    let locations: BTreeSet<_> = locations.into_iter().map(|s| s.into()).collect();

    ExternEntry {
        location: ExternLocation::ExactPaths(locations),
        is_private_dep: false,
        add_prelude: true,
    }
}

fn optgroups() -> getopts::Options {
    let mut opts = getopts::Options::new();
    for group in rustc_optgroups() {
        (group.apply)(&mut opts);
    }
    return opts;
}

fn mk_map<K: Ord, V>(entries: Vec<(K, V)>) -> BTreeMap<K, V> {
    BTreeMap::from_iter(entries.into_iter())
}

// When the user supplies --test we should implicitly supply --cfg test
#[test]
fn test_switch_implies_cfg_test() {
    rustc_span::with_default_session_globals(|| {
        let matches = optgroups().parse(&["--test".to_string()]).unwrap();
        let (sess, cfg) = mk_session(matches);
        let cfg = build_configuration(&sess, to_crate_config(cfg));
        assert!(cfg.contains(&(sym::test, None)));
    });
}

// When the user supplies --test and --cfg test, don't implicitly add another --cfg test
#[test]
fn test_switch_implies_cfg_test_unless_cfg_test() {
    rustc_span::with_default_session_globals(|| {
        let matches = optgroups().parse(&["--test".to_string(), "--cfg=test".to_string()]).unwrap();
        let (sess, cfg) = mk_session(matches);
        let cfg = build_configuration(&sess, to_crate_config(cfg));
        let mut test_items = cfg.iter().filter(|&&(name, _)| name == sym::test);
        assert!(test_items.next().is_some());
        assert!(test_items.next().is_none());
    });
}

#[test]
fn test_can_print_warnings() {
    rustc_span::with_default_session_globals(|| {
        let matches = optgroups().parse(&["-Awarnings".to_string()]).unwrap();
        let (sess, _) = mk_session(matches);
        assert!(!sess.diagnostic().can_emit_warnings());
    });

    rustc_span::with_default_session_globals(|| {
        let matches =
            optgroups().parse(&["-Awarnings".to_string(), "-Dwarnings".to_string()]).unwrap();
        let (sess, _) = mk_session(matches);
        assert!(sess.diagnostic().can_emit_warnings());
    });

    rustc_span::with_default_session_globals(|| {
        let matches = optgroups().parse(&["-Adead_code".to_string()]).unwrap();
        let (sess, _) = mk_session(matches);
        assert!(sess.diagnostic().can_emit_warnings());
    });
}

#[test]
fn test_output_types_tracking_hash_different_paths() {
    let mut v1 = Options::default();
    let mut v2 = Options::default();
    let mut v3 = Options::default();

    v1.output_types = OutputTypes::new(&[(OutputType::Exe, Some(PathBuf::from("./some/thing")))]);
    v2.output_types = OutputTypes::new(&[(OutputType::Exe, Some(PathBuf::from("/some/thing")))]);
    v3.output_types = OutputTypes::new(&[(OutputType::Exe, None)]);

    assert!(v1.dep_tracking_hash() != v2.dep_tracking_hash());
    assert!(v1.dep_tracking_hash() != v3.dep_tracking_hash());
    assert!(v2.dep_tracking_hash() != v3.dep_tracking_hash());

    // Check clone
    assert_eq!(v1.dep_tracking_hash(), v1.clone().dep_tracking_hash());
    assert_eq!(v2.dep_tracking_hash(), v2.clone().dep_tracking_hash());
    assert_eq!(v3.dep_tracking_hash(), v3.clone().dep_tracking_hash());
}

#[test]
fn test_output_types_tracking_hash_different_construction_order() {
    let mut v1 = Options::default();
    let mut v2 = Options::default();

    v1.output_types = OutputTypes::new(&[
        (OutputType::Exe, Some(PathBuf::from("./some/thing"))),
        (OutputType::Bitcode, Some(PathBuf::from("./some/thing.bc"))),
    ]);

    v2.output_types = OutputTypes::new(&[
        (OutputType::Bitcode, Some(PathBuf::from("./some/thing.bc"))),
        (OutputType::Exe, Some(PathBuf::from("./some/thing"))),
    ]);

    assert_eq!(v1.dep_tracking_hash(), v2.dep_tracking_hash());

    // Check clone
    assert_eq!(v1.dep_tracking_hash(), v1.clone().dep_tracking_hash());
}

#[test]
fn test_externs_tracking_hash_different_construction_order() {
    let mut v1 = Options::default();
    let mut v2 = Options::default();
    let mut v3 = Options::default();

    v1.externs = Externs::new(mk_map(vec![
        (String::from("a"), new_public_extern_entry(vec!["b", "c"])),
        (String::from("d"), new_public_extern_entry(vec!["e", "f"])),
    ]));

    v2.externs = Externs::new(mk_map(vec![
        (String::from("d"), new_public_extern_entry(vec!["e", "f"])),
        (String::from("a"), new_public_extern_entry(vec!["b", "c"])),
    ]));

    v3.externs = Externs::new(mk_map(vec![
        (String::from("a"), new_public_extern_entry(vec!["b", "c"])),
        (String::from("d"), new_public_extern_entry(vec!["f", "e"])),
    ]));

    assert_eq!(v1.dep_tracking_hash(), v2.dep_tracking_hash());
    assert_eq!(v1.dep_tracking_hash(), v3.dep_tracking_hash());
    assert_eq!(v2.dep_tracking_hash(), v3.dep_tracking_hash());

    // Check clone
    assert_eq!(v1.dep_tracking_hash(), v1.clone().dep_tracking_hash());
    assert_eq!(v2.dep_tracking_hash(), v2.clone().dep_tracking_hash());
    assert_eq!(v3.dep_tracking_hash(), v3.clone().dep_tracking_hash());
}

#[test]
fn test_lints_tracking_hash_different_values() {
    let mut v1 = Options::default();
    let mut v2 = Options::default();
    let mut v3 = Options::default();

    v1.lint_opts = vec![
        (String::from("a"), Level::Allow),
        (String::from("b"), Level::Warn),
        (String::from("c"), Level::Deny),
        (String::from("d"), Level::Forbid),
    ];

    v2.lint_opts = vec![
        (String::from("a"), Level::Allow),
        (String::from("b"), Level::Warn),
        (String::from("X"), Level::Deny),
        (String::from("d"), Level::Forbid),
    ];

    v3.lint_opts = vec![
        (String::from("a"), Level::Allow),
        (String::from("b"), Level::Warn),
        (String::from("c"), Level::Forbid),
        (String::from("d"), Level::Deny),
    ];

    assert!(v1.dep_tracking_hash() != v2.dep_tracking_hash());
    assert!(v1.dep_tracking_hash() != v3.dep_tracking_hash());
    assert!(v2.dep_tracking_hash() != v3.dep_tracking_hash());

    // Check clone
    assert_eq!(v1.dep_tracking_hash(), v1.clone().dep_tracking_hash());
    assert_eq!(v2.dep_tracking_hash(), v2.clone().dep_tracking_hash());
    assert_eq!(v3.dep_tracking_hash(), v3.clone().dep_tracking_hash());
}

#[test]
fn test_lints_tracking_hash_different_construction_order() {
    let mut v1 = Options::default();
    let mut v2 = Options::default();

    v1.lint_opts = vec![
        (String::from("a"), Level::Allow),
        (String::from("b"), Level::Warn),
        (String::from("c"), Level::Deny),
        (String::from("d"), Level::Forbid),
    ];

    v2.lint_opts = vec![
        (String::from("a"), Level::Allow),
        (String::from("c"), Level::Deny),
        (String::from("b"), Level::Warn),
        (String::from("d"), Level::Forbid),
    ];

    assert_eq!(v1.dep_tracking_hash(), v2.dep_tracking_hash());

    // Check clone
    assert_eq!(v1.dep_tracking_hash(), v1.clone().dep_tracking_hash());
    assert_eq!(v2.dep_tracking_hash(), v2.clone().dep_tracking_hash());
}

#[test]
fn test_search_paths_tracking_hash_different_order() {
    let mut v1 = Options::default();
    let mut v2 = Options::default();
    let mut v3 = Options::default();
    let mut v4 = Options::default();

    const JSON: ErrorOutputType = ErrorOutputType::Json {
        pretty: false,
        json_rendered: HumanReadableErrorType::Default(ColorConfig::Never),
    };

    // Reference
    v1.search_paths.push(SearchPath::from_cli_opt("native=abc", JSON));
    v1.search_paths.push(SearchPath::from_cli_opt("crate=def", JSON));
    v1.search_paths.push(SearchPath::from_cli_opt("dependency=ghi", JSON));
    v1.search_paths.push(SearchPath::from_cli_opt("framework=jkl", JSON));
    v1.search_paths.push(SearchPath::from_cli_opt("all=mno", JSON));

    v2.search_paths.push(SearchPath::from_cli_opt("native=abc", JSON));
    v2.search_paths.push(SearchPath::from_cli_opt("dependency=ghi", JSON));
    v2.search_paths.push(SearchPath::from_cli_opt("crate=def", JSON));
    v2.search_paths.push(SearchPath::from_cli_opt("framework=jkl", JSON));
    v2.search_paths.push(SearchPath::from_cli_opt("all=mno", JSON));

    v3.search_paths.push(SearchPath::from_cli_opt("crate=def", JSON));
    v3.search_paths.push(SearchPath::from_cli_opt("framework=jkl", JSON));
    v3.search_paths.push(SearchPath::from_cli_opt("native=abc", JSON));
    v3.search_paths.push(SearchPath::from_cli_opt("dependency=ghi", JSON));
    v3.search_paths.push(SearchPath::from_cli_opt("all=mno", JSON));

    v4.search_paths.push(SearchPath::from_cli_opt("all=mno", JSON));
    v4.search_paths.push(SearchPath::from_cli_opt("native=abc", JSON));
    v4.search_paths.push(SearchPath::from_cli_opt("crate=def", JSON));
    v4.search_paths.push(SearchPath::from_cli_opt("dependency=ghi", JSON));
    v4.search_paths.push(SearchPath::from_cli_opt("framework=jkl", JSON));

    assert!(v1.dep_tracking_hash() == v2.dep_tracking_hash());
    assert!(v1.dep_tracking_hash() == v3.dep_tracking_hash());
    assert!(v1.dep_tracking_hash() == v4.dep_tracking_hash());

    // Check clone
    assert_eq!(v1.dep_tracking_hash(), v1.clone().dep_tracking_hash());
    assert_eq!(v2.dep_tracking_hash(), v2.clone().dep_tracking_hash());
    assert_eq!(v3.dep_tracking_hash(), v3.clone().dep_tracking_hash());
    assert_eq!(v4.dep_tracking_hash(), v4.clone().dep_tracking_hash());
}

#[test]
fn test_native_libs_tracking_hash_different_values() {
    let mut v1 = Options::default();
    let mut v2 = Options::default();
    let mut v3 = Options::default();
    let mut v4 = Options::default();

    // Reference
    v1.libs = vec![
        (String::from("a"), None, NativeLibKind::StaticBundle),
        (String::from("b"), None, NativeLibKind::Framework),
        (String::from("c"), None, NativeLibKind::Unspecified),
    ];

    // Change label
    v2.libs = vec![
        (String::from("a"), None, NativeLibKind::StaticBundle),
        (String::from("X"), None, NativeLibKind::Framework),
        (String::from("c"), None, NativeLibKind::Unspecified),
    ];

    // Change kind
    v3.libs = vec![
        (String::from("a"), None, NativeLibKind::StaticBundle),
        (String::from("b"), None, NativeLibKind::StaticBundle),
        (String::from("c"), None, NativeLibKind::Unspecified),
    ];

    // Change new-name
    v4.libs = vec![
        (String::from("a"), None, NativeLibKind::StaticBundle),
        (String::from("b"), Some(String::from("X")), NativeLibKind::Framework),
        (String::from("c"), None, NativeLibKind::Unspecified),
    ];

    assert!(v1.dep_tracking_hash() != v2.dep_tracking_hash());
    assert!(v1.dep_tracking_hash() != v3.dep_tracking_hash());
    assert!(v1.dep_tracking_hash() != v4.dep_tracking_hash());

    // Check clone
    assert_eq!(v1.dep_tracking_hash(), v1.clone().dep_tracking_hash());
    assert_eq!(v2.dep_tracking_hash(), v2.clone().dep_tracking_hash());
    assert_eq!(v3.dep_tracking_hash(), v3.clone().dep_tracking_hash());
    assert_eq!(v4.dep_tracking_hash(), v4.clone().dep_tracking_hash());
}

#[test]
fn test_native_libs_tracking_hash_different_order() {
    let mut v1 = Options::default();
    let mut v2 = Options::default();
    let mut v3 = Options::default();

    // Reference
    v1.libs = vec![
        (String::from("a"), None, NativeLibKind::StaticBundle),
        (String::from("b"), None, NativeLibKind::Framework),
        (String::from("c"), None, NativeLibKind::Unspecified),
    ];

    v2.libs = vec![
        (String::from("b"), None, NativeLibKind::Framework),
        (String::from("a"), None, NativeLibKind::StaticBundle),
        (String::from("c"), None, NativeLibKind::Unspecified),
    ];

    v3.libs = vec![
        (String::from("c"), None, NativeLibKind::Unspecified),
        (String::from("a"), None, NativeLibKind::StaticBundle),
        (String::from("b"), None, NativeLibKind::Framework),
    ];

    assert!(v1.dep_tracking_hash() == v2.dep_tracking_hash());
    assert!(v1.dep_tracking_hash() == v3.dep_tracking_hash());
    assert!(v2.dep_tracking_hash() == v3.dep_tracking_hash());

    // Check clone
    assert_eq!(v1.dep_tracking_hash(), v1.clone().dep_tracking_hash());
    assert_eq!(v2.dep_tracking_hash(), v2.clone().dep_tracking_hash());
    assert_eq!(v3.dep_tracking_hash(), v3.clone().dep_tracking_hash());
}

#[test]
fn test_codegen_options_tracking_hash() {
    let reference = Options::default();
    let mut opts = Options::default();

    macro_rules! untracked {
        ($name: ident, $non_default_value: expr) => {
            opts.cg.$name = $non_default_value;
            assert_eq!(reference.dep_tracking_hash(), opts.dep_tracking_hash());
        };
    }

    // Make sure that changing an [UNTRACKED] option leaves the hash unchanged.
    // This list is in alphabetical order.
    untracked!(ar, String::from("abc"));
    untracked!(codegen_units, Some(42));
    untracked!(default_linker_libraries, true);
    untracked!(extra_filename, String::from("extra-filename"));
    untracked!(incremental, Some(String::from("abc")));
    // `link_arg` is omitted because it just forwards to `link_args`.
    untracked!(link_args, vec![String::from("abc"), String::from("def")]);
    untracked!(link_dead_code, Some(true));
    untracked!(link_self_contained, Some(true));
    untracked!(linker, Some(PathBuf::from("linker")));
    untracked!(linker_flavor, Some(LinkerFlavor::Gcc));
    untracked!(no_stack_check, true);
    untracked!(remark, Passes::Some(vec![String::from("pass1"), String::from("pass2")]));
    untracked!(rpath, true);
    untracked!(save_temps, true);

    macro_rules! tracked {
        ($name: ident, $non_default_value: expr) => {
            opts = reference.clone();
            opts.cg.$name = $non_default_value;
            assert_ne!(reference.dep_tracking_hash(), opts.dep_tracking_hash());
        };
    }

    // Make sure that changing a [TRACKED] option changes the hash.
    // This list is in alphabetical order.
    tracked!(code_model, Some(CodeModel::Large));
    tracked!(control_flow_guard, CFGuard::Checks);
    tracked!(debug_assertions, Some(true));
    tracked!(debuginfo, 0xdeadbeef);
    tracked!(embed_bitcode, false);
    tracked!(force_frame_pointers, Some(false));
    tracked!(force_unwind_tables, Some(true));
    tracked!(inline_threshold, Some(0xf007ba11));
    tracked!(linker_plugin_lto, LinkerPluginLto::LinkerPluginAuto);
    tracked!(llvm_args, vec![String::from("1"), String::from("2")]);
    tracked!(lto, LtoCli::Fat);
    tracked!(metadata, vec![String::from("A"), String::from("B")]);
    tracked!(no_prepopulate_passes, true);
    tracked!(no_redzone, Some(true));
    tracked!(no_vectorize_loops, true);
    tracked!(no_vectorize_slp, true);
    tracked!(opt_level, "3".to_string());
    tracked!(overflow_checks, Some(true));
    tracked!(panic, Some(PanicStrategy::Abort));
    tracked!(passes, vec![String::from("1"), String::from("2")]);
    tracked!(prefer_dynamic, true);
    tracked!(profile_generate, SwitchWithOptPath::Enabled(None));
    tracked!(profile_use, Some(PathBuf::from("abc")));
    tracked!(relocation_model, Some(RelocModel::Pic));
    tracked!(soft_float, true);
    tracked!(target_cpu, Some(String::from("abc")));
    tracked!(target_feature, String::from("all the features, all of them"));
}

#[test]
fn test_debugging_options_tracking_hash() {
    let reference = Options::default();
    let mut opts = Options::default();

    macro_rules! untracked {
        ($name: ident, $non_default_value: expr) => {
            opts.debugging_opts.$name = $non_default_value;
            assert_eq!(reference.dep_tracking_hash(), opts.dep_tracking_hash());
        };
    }

    // Make sure that changing an [UNTRACKED] option leaves the hash unchanged.
    // This list is in alphabetical order.
    untracked!(ast_json, true);
    untracked!(ast_json_noexpand, true);
    untracked!(borrowck, String::from("other"));
    untracked!(borrowck_stats, true);
    untracked!(deduplicate_diagnostics, true);
    untracked!(dep_tasks, true);
    untracked!(dont_buffer_diagnostics, true);
    untracked!(dump_dep_graph, true);
    untracked!(dump_mir, Some(String::from("abc")));
    untracked!(dump_mir_dataflow, true);
    untracked!(dump_mir_dir, String::from("abc"));
    untracked!(dump_mir_exclude_pass_number, true);
    untracked!(dump_mir_graphviz, true);
    untracked!(emit_future_incompat_report, true);
    untracked!(emit_stack_sizes, true);
    untracked!(hir_stats, true);
    untracked!(identify_regions, true);
    untracked!(incremental_ignore_spans, true);
    untracked!(incremental_info, true);
    untracked!(incremental_verify_ich, true);
    untracked!(input_stats, true);
    untracked!(keep_hygiene_data, true);
    untracked!(link_native_libraries, false);
    untracked!(llvm_time_trace, true);
    untracked!(ls, true);
    untracked!(macro_backtrace, true);
    untracked!(meta_stats, true);
    untracked!(nll_facts, true);
    untracked!(no_analysis, true);
    untracked!(no_interleave_lints, true);
    untracked!(no_leak_check, true);
    untracked!(no_parallel_llvm, true);
    untracked!(parse_only, true);
    untracked!(perf_stats, true);
    untracked!(polonius, true);
    // `pre_link_arg` is omitted because it just forwards to `pre_link_args`.
    untracked!(pre_link_args, vec![String::from("abc"), String::from("def")]);
    untracked!(print_link_args, true);
    untracked!(print_llvm_passes, true);
    untracked!(print_mono_items, Some(String::from("abc")));
    untracked!(print_type_sizes, true);
    untracked!(proc_macro_backtrace, true);
    untracked!(query_dep_graph, true);
    untracked!(query_stats, true);
    untracked!(save_analysis, true);
    untracked!(self_profile, SwitchWithOptPath::Enabled(None));
    untracked!(self_profile_events, Some(vec![String::new()]));
    untracked!(span_debug, true);
    untracked!(span_free_formats, true);
    untracked!(strip, Strip::None);
    untracked!(terminal_width, Some(80));
    untracked!(threads, 99);
    untracked!(time, true);
    untracked!(time_llvm_passes, true);
    untracked!(time_passes, true);
    untracked!(trace_macros, true);
    untracked!(trim_diagnostic_paths, false);
    untracked!(ui_testing, true);
    untracked!(unpretty, Some("expanded".to_string()));
    untracked!(unstable_options, true);
    untracked!(validate_mir, true);
    untracked!(verbose, true);

    macro_rules! tracked {
        ($name: ident, $non_default_value: expr) => {
            opts = reference.clone();
            opts.debugging_opts.$name = $non_default_value;
            assert_ne!(reference.dep_tracking_hash(), opts.dep_tracking_hash());
        };
    }

    // Make sure that changing a [TRACKED] option changes the hash.
    // This list is in alphabetical order.
    tracked!(allow_features, Some(vec![String::from("lang_items")]));
    tracked!(always_encode_mir, true);
    tracked!(asm_comments, true);
    tracked!(binary_dep_depinfo, true);
    tracked!(chalk, true);
    tracked!(codegen_backend, Some("abc".to_string()));
    tracked!(crate_attr, vec!["abc".to_string()]);
    tracked!(debug_macros, true);
    tracked!(dep_info_omit_d_target, true);
    tracked!(dual_proc_macros, true);
    tracked!(fewer_names, true);
    tracked!(force_overflow_checks, Some(true));
    tracked!(force_unstable_if_unmarked, true);
    tracked!(fuel, Some(("abc".to_string(), 99)));
    tracked!(function_sections, Some(false));
    tracked!(human_readable_cgu_names, true);
    tracked!(inline_in_all_cgus, Some(true));
    tracked!(inline_mir_threshold, 123);
    tracked!(inline_mir_hint_threshold, 123);
    tracked!(insert_sideeffect, true);
    tracked!(instrument_coverage, true);
    tracked!(instrument_mcount, true);
    tracked!(link_only, true);
    tracked!(merge_functions, Some(MergeFunctions::Disabled));
    tracked!(mir_emit_retag, true);
    tracked!(mir_opt_level, 3);
    tracked!(mutable_noalias, true);
    tracked!(new_llvm_pass_manager, true);
    tracked!(no_codegen, true);
    tracked!(no_generate_arange_section, true);
    tracked!(no_link, true);
    tracked!(no_profiler_runtime, true);
    tracked!(osx_rpath_install_name, true);
    tracked!(panic_abort_tests, true);
    tracked!(plt, Some(true));
    tracked!(precise_enum_drop_elaboration, false);
    tracked!(print_fuel, Some("abc".to_string()));
    tracked!(profile, true);
    tracked!(profile_emit, Some(PathBuf::from("abc")));
    tracked!(relax_elf_relocations, Some(true));
    tracked!(relro_level, Some(RelroLevel::Full));
    tracked!(report_delayed_bugs, true);
    tracked!(run_dsymutil, false);
    tracked!(sanitizer, SanitizerSet::ADDRESS);
    tracked!(sanitizer_memory_track_origins, 2);
    tracked!(sanitizer_recover, SanitizerSet::ADDRESS);
    tracked!(saturating_float_casts, Some(true));
    tracked!(share_generics, Some(true));
    tracked!(show_span, Some(String::from("abc")));
    tracked!(src_hash_algorithm, Some(SourceFileHashAlgorithm::Sha1));
    tracked!(symbol_mangling_version, SymbolManglingVersion::V0);
    tracked!(teach, true);
    tracked!(thinlto, Some(true));
    tracked!(tune_cpu, Some(String::from("abc")));
    tracked!(tls_model, Some(TlsModel::GeneralDynamic));
    tracked!(treat_err_as_bug, Some(1));
    tracked!(unleash_the_miri_inside_of_you, true);
    tracked!(use_ctors_section, Some(true));
    tracked!(verify_llvm_ir, true);
}

#[test]
fn test_edition_parsing() {
    // test default edition
    let options = Options::default();
    assert!(options.edition == DEFAULT_EDITION);

    let matches = optgroups().parse(&["--edition=2018".to_string()]).unwrap();
    let (sessopts, _) = build_session_options_and_crate_config(matches);
    assert!(sessopts.edition == Edition::Edition2018)
}
