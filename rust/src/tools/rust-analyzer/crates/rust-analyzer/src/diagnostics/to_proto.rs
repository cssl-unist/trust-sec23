//! This module provides the functionality needed to convert diagnostics from
//! `cargo check` json format to the LSP diagnostic format.
use std::{collections::HashMap, path::Path};

use flycheck::{Applicability, DiagnosticLevel, DiagnosticSpan};
use stdx::format_to;

use crate::{lsp_ext, to_proto::url_from_abs_path};

use super::DiagnosticsMapConfig;

/// Determines the LSP severity from a diagnostic
fn diagnostic_severity(
    config: &DiagnosticsMapConfig,
    level: flycheck::DiagnosticLevel,
    code: Option<flycheck::DiagnosticCode>,
) -> Option<lsp_types::DiagnosticSeverity> {
    let res = match level {
        DiagnosticLevel::Ice => lsp_types::DiagnosticSeverity::Error,
        DiagnosticLevel::Error => lsp_types::DiagnosticSeverity::Error,
        DiagnosticLevel::Warning => match &code {
            Some(code) if config.warnings_as_hint.contains(&code.code) => {
                lsp_types::DiagnosticSeverity::Hint
            }
            Some(code) if config.warnings_as_info.contains(&code.code) => {
                lsp_types::DiagnosticSeverity::Information
            }
            _ => lsp_types::DiagnosticSeverity::Warning,
        },
        DiagnosticLevel::Note => lsp_types::DiagnosticSeverity::Information,
        DiagnosticLevel::Help => lsp_types::DiagnosticSeverity::Hint,
        DiagnosticLevel::Unknown => return None,
    };
    Some(res)
}

/// Check whether a file name is from macro invocation
fn is_from_macro(file_name: &str) -> bool {
    file_name.starts_with('<') && file_name.ends_with('>')
}

/// Converts a Rust span to a LSP location, resolving macro expansion site if neccesary
fn location(workspace_root: &Path, span: &DiagnosticSpan) -> lsp_types::Location {
    let mut span = span.clone();
    while let Some(expansion) = span.expansion {
        span = expansion.span;
    }
    return location_naive(workspace_root, &span);
}

/// Converts a Rust span to a LSP location
fn location_naive(workspace_root: &Path, span: &DiagnosticSpan) -> lsp_types::Location {
    let file_name = workspace_root.join(&span.file_name);
    let uri = url_from_abs_path(&file_name);

    // FIXME: this doesn't handle UTF16 offsets correctly
    let range = lsp_types::Range::new(
        lsp_types::Position::new(span.line_start as u64 - 1, span.column_start as u64 - 1),
        lsp_types::Position::new(span.line_end as u64 - 1, span.column_end as u64 - 1),
    );

    lsp_types::Location { uri, range }
}

/// Converts a secondary Rust span to a LSP related inflocation(ormation
///
/// If the span is unlabelled this will return `None`.
fn diagnostic_related_information(
    workspace_root: &Path,
    span: &DiagnosticSpan,
) -> Option<lsp_types::DiagnosticRelatedInformation> {
    let message = span.label.clone()?;
    let location = location(workspace_root, span);
    Some(lsp_types::DiagnosticRelatedInformation { location, message })
}

enum MappedRustChildDiagnostic {
    Related(lsp_types::DiagnosticRelatedInformation),
    SuggestedFix(lsp_ext::CodeAction),
    MessageLine(String),
}

fn map_rust_child_diagnostic(
    workspace_root: &Path,
    rd: &flycheck::Diagnostic,
) -> MappedRustChildDiagnostic {
    let spans: Vec<&DiagnosticSpan> = rd.spans.iter().filter(|s| s.is_primary).collect();
    if spans.is_empty() {
        // `rustc` uses these spanless children as a way to print multi-line
        // messages
        return MappedRustChildDiagnostic::MessageLine(rd.message.clone());
    }

    let mut edit_map: HashMap<lsp_types::Url, Vec<lsp_types::TextEdit>> = HashMap::new();
    for &span in &spans {
        if let (Some(Applicability::MachineApplicable), Some(suggested_replacement)) =
            (&span.suggestion_applicability, &span.suggested_replacement)
        {
            let location = location(workspace_root, span);
            let edit = lsp_types::TextEdit::new(location.range, suggested_replacement.clone());
            edit_map.entry(location.uri).or_default().push(edit);
        }
    }

    if edit_map.is_empty() {
        MappedRustChildDiagnostic::Related(lsp_types::DiagnosticRelatedInformation {
            location: location(workspace_root, spans[0]),
            message: rd.message.clone(),
        })
    } else {
        MappedRustChildDiagnostic::SuggestedFix(lsp_ext::CodeAction {
            title: rd.message.clone(),
            id: None,
            group: None,
            kind: Some(lsp_types::CodeActionKind::QUICKFIX),
            edit: Some(lsp_ext::SnippetWorkspaceEdit {
                // FIXME: there's no good reason to use edit_map here....
                changes: Some(edit_map),
                document_changes: None,
            }),
            is_preferred: Some(true),
        })
    }
}

#[derive(Debug)]
pub(crate) struct MappedRustDiagnostic {
    pub(crate) url: lsp_types::Url,
    pub(crate) diagnostic: lsp_types::Diagnostic,
    pub(crate) fixes: Vec<lsp_ext::CodeAction>,
}

/// Converts a Rust root diagnostic to LSP form
///
/// This flattens the Rust diagnostic by:
///
/// 1. Creating a LSP diagnostic with the root message and primary span.
/// 2. Adding any labelled secondary spans to `relatedInformation`
/// 3. Categorising child diagnostics as either `SuggestedFix`es,
///    `relatedInformation` or additional message lines.
///
/// If the diagnostic has no primary span this will return `None`
pub(crate) fn map_rust_diagnostic_to_lsp(
    config: &DiagnosticsMapConfig,
    rd: &flycheck::Diagnostic,
    workspace_root: &Path,
) -> Vec<MappedRustDiagnostic> {
    let primary_spans: Vec<&DiagnosticSpan> = rd.spans.iter().filter(|s| s.is_primary).collect();
    if primary_spans.is_empty() {
        return Vec::new();
    }

    let severity = diagnostic_severity(config, rd.level.clone(), rd.code.clone());

    let mut source = String::from("rustc");
    let mut code = rd.code.as_ref().map(|c| c.code.clone());
    if let Some(code_val) = &code {
        // See if this is an RFC #2103 scoped lint (e.g. from Clippy)
        let scoped_code: Vec<&str> = code_val.split("::").collect();
        if scoped_code.len() == 2 {
            source = String::from(scoped_code[0]);
            code = Some(String::from(scoped_code[1]));
        }
    }

    let mut needs_primary_span_label = true;
    let mut related_information = Vec::new();
    let mut tags = Vec::new();

    for secondary_span in rd.spans.iter().filter(|s| !s.is_primary) {
        let related = diagnostic_related_information(workspace_root, secondary_span);
        if let Some(related) = related {
            related_information.push(related);
        }
    }

    let mut fixes = Vec::new();
    let mut message = rd.message.clone();
    for child in &rd.children {
        let child = map_rust_child_diagnostic(workspace_root, &child);
        match child {
            MappedRustChildDiagnostic::Related(related) => related_information.push(related),
            MappedRustChildDiagnostic::SuggestedFix(code_action) => fixes.push(code_action),
            MappedRustChildDiagnostic::MessageLine(message_line) => {
                format_to!(message, "\n{}", message_line);

                // These secondary messages usually duplicate the content of the
                // primary span label.
                needs_primary_span_label = false;
            }
        }
    }

    if let Some(code) = &rd.code {
        let code = code.code.as_str();
        if matches!(
            code,
            "dead_code"
                | "unknown_lints"
                | "unreachable_code"
                | "unused_attributes"
                | "unused_imports"
                | "unused_macros"
                | "unused_variables"
        ) {
            tags.push(lsp_types::DiagnosticTag::Unnecessary);
        }

        if matches!(code, "deprecated") {
            tags.push(lsp_types::DiagnosticTag::Deprecated);
        }
    }

    primary_spans
        .iter()
        .map(|primary_span| {
            let location = location(workspace_root, &primary_span);

            let mut message = message.clone();
            if needs_primary_span_label {
                if let Some(primary_span_label) = &primary_span.label {
                    format_to!(message, "\n{}", primary_span_label);
                }
            }

            // If error occurs from macro expansion, add related info pointing to
            // where the error originated
            // Also, we would generate an additional diagnostic, so that exact place of macro
            // will be highlighted in the error origin place.
            let additional_diagnostic =
                if !is_from_macro(&primary_span.file_name) && primary_span.expansion.is_some() {
                    let in_macro_location = location_naive(workspace_root, &primary_span);

                    // Add related information for the main disagnostic.
                    related_information.push(lsp_types::DiagnosticRelatedInformation {
                        location: in_macro_location.clone(),
                        message: "Error originated from macro here".to_string(),
                    });

                    // For the additional in-macro diagnostic we add the inverse message pointing to the error location in code.
                    let information_for_additional_diagnostic =
                        vec![lsp_types::DiagnosticRelatedInformation {
                            location: location.clone(),
                            message: "Exact error occured here".to_string(),
                        }];

                    let diagnostic = lsp_types::Diagnostic {
                        range: in_macro_location.range,
                        severity,
                        code: code.clone().map(lsp_types::NumberOrString::String),
                        source: Some(source.clone()),
                        message: message.clone(),
                        related_information: Some(information_for_additional_diagnostic),
                        tags: if tags.is_empty() { None } else { Some(tags.clone()) },
                    };

                    Some(MappedRustDiagnostic {
                        url: in_macro_location.uri,
                        diagnostic,
                        fixes: fixes.clone(),
                    })
                } else {
                    None
                };

            let diagnostic = lsp_types::Diagnostic {
                range: location.range,
                severity,
                code: code.clone().map(lsp_types::NumberOrString::String),
                source: Some(source.clone()),
                message,
                related_information: if related_information.is_empty() {
                    None
                } else {
                    Some(related_information.clone())
                },
                tags: if tags.is_empty() { None } else { Some(tags.clone()) },
            };

            let main_diagnostic =
                MappedRustDiagnostic { url: location.uri, diagnostic, fixes: fixes.clone() };
            match additional_diagnostic {
                None => vec![main_diagnostic],
                Some(additional_diagnostic) => vec![main_diagnostic, additional_diagnostic],
            }
        })
        .flatten()
        .collect()
}

#[cfg(test)]
#[cfg(not(windows))]
mod tests {
    use super::*;

    use expect_test::{expect_file, ExpectFile};

    fn check(diagnostics_json: &str, expect: ExpectFile) {
        check_with_config(DiagnosticsMapConfig::default(), diagnostics_json, expect)
    }

    fn check_with_config(config: DiagnosticsMapConfig, diagnostics_json: &str, expect: ExpectFile) {
        let diagnostic: flycheck::Diagnostic = serde_json::from_str(diagnostics_json).unwrap();
        let workspace_root = Path::new("/test/");
        let actual = map_rust_diagnostic_to_lsp(&config, &diagnostic, workspace_root);
        expect.assert_debug_eq(&actual)
    }

    #[test]
    fn rustc_incompatible_type_for_trait() {
        check(
            r##"{
                "message": "method `next` has an incompatible type for trait",
                "code": {
                    "code": "E0053",
                    "explanation": "\nThe parameters of any trait method must match between a trait implementation\nand the trait definition.\n\nHere are a couple examples of this error:\n\n```compile_fail,E0053\ntrait Foo {\n    fn foo(x: u16);\n    fn bar(&self);\n}\n\nstruct Bar;\n\nimpl Foo for Bar {\n    // error, expected u16, found i16\n    fn foo(x: i16) { }\n\n    // error, types differ in mutability\n    fn bar(&mut self) { }\n}\n```\n"
                },
                "level": "error",
                "spans": [
                    {
                        "file_name": "compiler/ty/list_iter.rs",
                        "byte_start": 1307,
                        "byte_end": 1350,
                        "line_start": 52,
                        "line_end": 52,
                        "column_start": 5,
                        "column_end": 48,
                        "is_primary": true,
                        "text": [
                            {
                                "text": "    fn next(&self) -> Option<&'list ty::Ref<M>> {",
                                "highlight_start": 5,
                                "highlight_end": 48
                            }
                        ],
                        "label": "types differ in mutability",
                        "suggested_replacement": null,
                        "suggestion_applicability": null,
                        "expansion": null
                    }
                ],
                "children": [
                    {
                        "message": "expected type `fn(&mut ty::list_iter::ListIterator<'list, M>) -> std::option::Option<&ty::Ref<M>>`\n   found type `fn(&ty::list_iter::ListIterator<'list, M>) -> std::option::Option<&'list ty::Ref<M>>`",
                        "code": null,
                        "level": "note",
                        "spans": [],
                        "children": [],
                        "rendered": null
                    }
                ],
                "rendered": "error[E0053]: method `next` has an incompatible type for trait\n  --> compiler/ty/list_iter.rs:52:5\n   |\n52 |     fn next(&self) -> Option<&'list ty::Ref<M>> {\n   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ types differ in mutability\n   |\n   = note: expected type `fn(&mut ty::list_iter::ListIterator<'list, M>) -> std::option::Option<&ty::Ref<M>>`\n              found type `fn(&ty::list_iter::ListIterator<'list, M>) -> std::option::Option<&'list ty::Ref<M>>`\n\n"
            }
            "##,
            expect_file!["./test_data/rustc_incompatible_type_for_trait.txt"],
        );
    }

    #[test]
    fn rustc_unused_variable() {
        check(
            r##"{
    "message": "unused variable: `foo`",
    "code": {
        "code": "unused_variables",
        "explanation": null
    },
    "level": "warning",
    "spans": [
        {
            "file_name": "driver/subcommand/repl.rs",
            "byte_start": 9228,
            "byte_end": 9231,
            "line_start": 291,
            "line_end": 291,
            "column_start": 9,
            "column_end": 12,
            "is_primary": true,
            "text": [
                {
                    "text": "    let foo = 42;",
                    "highlight_start": 9,
                    "highlight_end": 12
                }
            ],
            "label": null,
            "suggested_replacement": null,
            "suggestion_applicability": null,
            "expansion": null
        }
    ],
    "children": [
        {
            "message": "#[warn(unused_variables)] on by default",
            "code": null,
            "level": "note",
            "spans": [],
            "children": [],
            "rendered": null
        },
        {
            "message": "consider prefixing with an underscore",
            "code": null,
            "level": "help",
            "spans": [
                {
                    "file_name": "driver/subcommand/repl.rs",
                    "byte_start": 9228,
                    "byte_end": 9231,
                    "line_start": 291,
                    "line_end": 291,
                    "column_start": 9,
                    "column_end": 12,
                    "is_primary": true,
                    "text": [
                        {
                            "text": "    let foo = 42;",
                            "highlight_start": 9,
                            "highlight_end": 12
                        }
                    ],
                    "label": null,
                    "suggested_replacement": "_foo",
                    "suggestion_applicability": "MachineApplicable",
                    "expansion": null
                }
            ],
            "children": [],
            "rendered": null
        }
    ],
    "rendered": "warning: unused variable: `foo`\n   --> driver/subcommand/repl.rs:291:9\n    |\n291 |     let foo = 42;\n    |         ^^^ help: consider prefixing with an underscore: `_foo`\n    |\n    = note: #[warn(unused_variables)] on by default\n\n"
    }"##,
            expect_file!["./test_data/rustc_unused_variable.txt"],
        );
    }

    #[test]
    #[cfg(not(windows))]
    fn rustc_unused_variable_as_info() {
        check_with_config(
            DiagnosticsMapConfig {
                warnings_as_info: vec!["unused_variables".to_string()],
                ..DiagnosticsMapConfig::default()
            },
            r##"{
    "message": "unused variable: `foo`",
    "code": {
        "code": "unused_variables",
        "explanation": null
    },
    "level": "warning",
    "spans": [
        {
            "file_name": "driver/subcommand/repl.rs",
            "byte_start": 9228,
            "byte_end": 9231,
            "line_start": 291,
            "line_end": 291,
            "column_start": 9,
            "column_end": 12,
            "is_primary": true,
            "text": [
                {
                    "text": "    let foo = 42;",
                    "highlight_start": 9,
                    "highlight_end": 12
                }
            ],
            "label": null,
            "suggested_replacement": null,
            "suggestion_applicability": null,
            "expansion": null
        }
    ],
    "children": [
        {
            "message": "#[warn(unused_variables)] on by default",
            "code": null,
            "level": "note",
            "spans": [],
            "children": [],
            "rendered": null
        },
        {
            "message": "consider prefixing with an underscore",
            "code": null,
            "level": "help",
            "spans": [
                {
                    "file_name": "driver/subcommand/repl.rs",
                    "byte_start": 9228,
                    "byte_end": 9231,
                    "line_start": 291,
                    "line_end": 291,
                    "column_start": 9,
                    "column_end": 12,
                    "is_primary": true,
                    "text": [
                        {
                            "text": "    let foo = 42;",
                            "highlight_start": 9,
                            "highlight_end": 12
                        }
                    ],
                    "label": null,
                    "suggested_replacement": "_foo",
                    "suggestion_applicability": "MachineApplicable",
                    "expansion": null
                }
            ],
            "children": [],
            "rendered": null
        }
    ],
    "rendered": "warning: unused variable: `foo`\n   --> driver/subcommand/repl.rs:291:9\n    |\n291 |     let foo = 42;\n    |         ^^^ help: consider prefixing with an underscore: `_foo`\n    |\n    = note: #[warn(unused_variables)] on by default\n\n"
    }"##,
            expect_file!["./test_data/rustc_unused_variable_as_info.txt"],
        );
    }

    #[test]
    #[cfg(not(windows))]
    fn rustc_unused_variable_as_hint() {
        check_with_config(
            DiagnosticsMapConfig {
                warnings_as_hint: vec!["unused_variables".to_string()],
                ..DiagnosticsMapConfig::default()
            },
            r##"{
    "message": "unused variable: `foo`",
    "code": {
        "code": "unused_variables",
        "explanation": null
    },
    "level": "warning",
    "spans": [
        {
            "file_name": "driver/subcommand/repl.rs",
            "byte_start": 9228,
            "byte_end": 9231,
            "line_start": 291,
            "line_end": 291,
            "column_start": 9,
            "column_end": 12,
            "is_primary": true,
            "text": [
                {
                    "text": "    let foo = 42;",
                    "highlight_start": 9,
                    "highlight_end": 12
                }
            ],
            "label": null,
            "suggested_replacement": null,
            "suggestion_applicability": null,
            "expansion": null
        }
    ],
    "children": [
        {
            "message": "#[warn(unused_variables)] on by default",
            "code": null,
            "level": "note",
            "spans": [],
            "children": [],
            "rendered": null
        },
        {
            "message": "consider prefixing with an underscore",
            "code": null,
            "level": "help",
            "spans": [
                {
                    "file_name": "driver/subcommand/repl.rs",
                    "byte_start": 9228,
                    "byte_end": 9231,
                    "line_start": 291,
                    "line_end": 291,
                    "column_start": 9,
                    "column_end": 12,
                    "is_primary": true,
                    "text": [
                        {
                            "text": "    let foo = 42;",
                            "highlight_start": 9,
                            "highlight_end": 12
                        }
                    ],
                    "label": null,
                    "suggested_replacement": "_foo",
                    "suggestion_applicability": "MachineApplicable",
                    "expansion": null
                }
            ],
            "children": [],
            "rendered": null
        }
    ],
    "rendered": "warning: unused variable: `foo`\n   --> driver/subcommand/repl.rs:291:9\n    |\n291 |     let foo = 42;\n    |         ^^^ help: consider prefixing with an underscore: `_foo`\n    |\n    = note: #[warn(unused_variables)] on by default\n\n"
    }"##,
            expect_file!["./test_data/rustc_unused_variable_as_hint.txt"],
        );
    }

    #[test]
    fn rustc_wrong_number_of_parameters() {
        check(
            r##"{
    "message": "this function takes 2 parameters but 3 parameters were supplied",
    "code": {
        "code": "E0061",
        "explanation": "\nThe number of arguments passed to a function must match the number of arguments\nspecified in the function signature.\n\nFor example, a function like:\n\n```\nfn f(a: u16, b: &str) {}\n```\n\nMust always be called with exactly two arguments, e.g., `f(2, \"test\")`.\n\nNote that Rust does not have a notion of optional function arguments or\nvariadic functions (except for its C-FFI).\n"
    },
    "level": "error",
    "spans": [
        {
            "file_name": "compiler/ty/select.rs",
            "byte_start": 8787,
            "byte_end": 9241,
            "line_start": 219,
            "line_end": 231,
            "column_start": 5,
            "column_end": 6,
            "is_primary": false,
            "text": [
                {
                    "text": "    pub fn add_evidence(",
                    "highlight_start": 5,
                    "highlight_end": 25
                },
                {
                    "text": "        &mut self,",
                    "highlight_start": 1,
                    "highlight_end": 19
                },
                {
                    "text": "        target_poly: &ty::Ref<ty::Poly>,",
                    "highlight_start": 1,
                    "highlight_end": 41
                },
                {
                    "text": "        evidence_poly: &ty::Ref<ty::Poly>,",
                    "highlight_start": 1,
                    "highlight_end": 43
                },
                {
                    "text": "    ) {",
                    "highlight_start": 1,
                    "highlight_end": 8
                },
                {
                    "text": "        match target_poly {",
                    "highlight_start": 1,
                    "highlight_end": 28
                },
                {
                    "text": "            ty::Ref::Var(tvar, _) => self.add_var_evidence(tvar, evidence_poly),",
                    "highlight_start": 1,
                    "highlight_end": 81
                },
                {
                    "text": "            ty::Ref::Fixed(target_ty) => {",
                    "highlight_start": 1,
                    "highlight_end": 43
                },
                {
                    "text": "                let evidence_ty = evidence_poly.resolve_to_ty();",
                    "highlight_start": 1,
                    "highlight_end": 65
                },
                {
                    "text": "                self.add_evidence_ty(target_ty, evidence_poly, evidence_ty)",
                    "highlight_start": 1,
                    "highlight_end": 76
                },
                {
                    "text": "            }",
                    "highlight_start": 1,
                    "highlight_end": 14
                },
                {
                    "text": "        }",
                    "highlight_start": 1,
                    "highlight_end": 10
                },
                {
                    "text": "    }",
                    "highlight_start": 1,
                    "highlight_end": 6
                }
            ],
            "label": "defined here",
            "suggested_replacement": null,
            "suggestion_applicability": null,
            "expansion": null
        },
        {
            "file_name": "compiler/ty/select.rs",
            "byte_start": 4045,
            "byte_end": 4057,
            "line_start": 104,
            "line_end": 104,
            "column_start": 18,
            "column_end": 30,
            "is_primary": true,
            "text": [
                {
                    "text": "            self.add_evidence(target_fixed, evidence_fixed, false);",
                    "highlight_start": 18,
                    "highlight_end": 30
                }
            ],
            "label": "expected 2 parameters",
            "suggested_replacement": null,
            "suggestion_applicability": null,
            "expansion": null
        }
    ],
    "children": [],
    "rendered": "error[E0061]: this function takes 2 parameters but 3 parameters were supplied\n   --> compiler/ty/select.rs:104:18\n    |\n104 |               self.add_evidence(target_fixed, evidence_fixed, false);\n    |                    ^^^^^^^^^^^^ expected 2 parameters\n...\n219 | /     pub fn add_evidence(\n220 | |         &mut self,\n221 | |         target_poly: &ty::Ref<ty::Poly>,\n222 | |         evidence_poly: &ty::Ref<ty::Poly>,\n...   |\n230 | |         }\n231 | |     }\n    | |_____- defined here\n\n"
    }"##,
            expect_file!["./test_data/rustc_wrong_number_of_parameters.txt"],
        );
    }

    #[test]
    fn clippy_pass_by_ref() {
        check(
            r##"{
    "message": "this argument is passed by reference, but would be more efficient if passed by value",
    "code": {
        "code": "clippy::trivially_copy_pass_by_ref",
        "explanation": null
    },
    "level": "warning",
    "spans": [
        {
            "file_name": "compiler/mir/tagset.rs",
            "byte_start": 941,
            "byte_end": 946,
            "line_start": 42,
            "line_end": 42,
            "column_start": 24,
            "column_end": 29,
            "is_primary": true,
            "text": [
                {
                    "text": "    pub fn is_disjoint(&self, other: Self) -> bool {",
                    "highlight_start": 24,
                    "highlight_end": 29
                }
            ],
            "label": null,
            "suggested_replacement": null,
            "suggestion_applicability": null,
            "expansion": null
        }
    ],
    "children": [
        {
            "message": "lint level defined here",
            "code": null,
            "level": "note",
            "spans": [
                {
                    "file_name": "compiler/lib.rs",
                    "byte_start": 8,
                    "byte_end": 19,
                    "line_start": 1,
                    "line_end": 1,
                    "column_start": 9,
                    "column_end": 20,
                    "is_primary": true,
                    "text": [
                        {
                            "text": "#![warn(clippy::all)]",
                            "highlight_start": 9,
                            "highlight_end": 20
                        }
                    ],
                    "label": null,
                    "suggested_replacement": null,
                    "suggestion_applicability": null,
                    "expansion": null
                }
            ],
            "children": [],
            "rendered": null
        },
        {
            "message": "#[warn(clippy::trivially_copy_pass_by_ref)] implied by #[warn(clippy::all)]",
            "code": null,
            "level": "note",
            "spans": [],
            "children": [],
            "rendered": null
        },
        {
            "message": "for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#trivially_copy_pass_by_ref",
            "code": null,
            "level": "help",
            "spans": [],
            "children": [],
            "rendered": null
        },
        {
            "message": "consider passing by value instead",
            "code": null,
            "level": "help",
            "spans": [
                {
                    "file_name": "compiler/mir/tagset.rs",
                    "byte_start": 941,
                    "byte_end": 946,
                    "line_start": 42,
                    "line_end": 42,
                    "column_start": 24,
                    "column_end": 29,
                    "is_primary": true,
                    "text": [
                        {
                            "text": "    pub fn is_disjoint(&self, other: Self) -> bool {",
                            "highlight_start": 24,
                            "highlight_end": 29
                        }
                    ],
                    "label": null,
                    "suggested_replacement": "self",
                    "suggestion_applicability": "Unspecified",
                    "expansion": null
                }
            ],
            "children": [],
            "rendered": null
        }
    ],
    "rendered": "warning: this argument is passed by reference, but would be more efficient if passed by value\n  --> compiler/mir/tagset.rs:42:24\n   |\n42 |     pub fn is_disjoint(&self, other: Self) -> bool {\n   |                        ^^^^^ help: consider passing by value instead: `self`\n   |\nnote: lint level defined here\n  --> compiler/lib.rs:1:9\n   |\n1  | #![warn(clippy::all)]\n   |         ^^^^^^^^^^^\n   = note: #[warn(clippy::trivially_copy_pass_by_ref)] implied by #[warn(clippy::all)]\n   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#trivially_copy_pass_by_ref\n\n"
    }"##,
            expect_file!["./test_data/clippy_pass_by_ref.txt"],
        );
    }

    #[test]
    fn rustc_mismatched_type() {
        check(
            r##"{
    "message": "mismatched types",
    "code": {
        "code": "E0308",
        "explanation": "\nThis error occurs when the compiler was unable to infer the concrete type of a\nvariable. It can occur for several cases, the most common of which is a\nmismatch in the expected type that the compiler inferred for a variable's\ninitializing expression, and the actual type explicitly assigned to the\nvariable.\n\nFor example:\n\n```compile_fail,E0308\nlet x: i32 = \"I am not a number!\";\n//     ~~~   ~~~~~~~~~~~~~~~~~~~~\n//      |             |\n//      |    initializing expression;\n//      |    compiler infers type `&str`\n//      |\n//    type `i32` assigned to variable `x`\n```\n"
    },
    "level": "error",
    "spans": [
        {
            "file_name": "runtime/compiler_support.rs",
            "byte_start": 1589,
            "byte_end": 1594,
            "line_start": 48,
            "line_end": 48,
            "column_start": 65,
            "column_end": 70,
            "is_primary": true,
            "text": [
                {
                    "text": "    let layout = alloc::Layout::from_size_align_unchecked(size, align);",
                    "highlight_start": 65,
                    "highlight_end": 70
                }
            ],
            "label": "expected usize, found u32",
            "suggested_replacement": null,
            "suggestion_applicability": null,
            "expansion": null
        }
    ],
    "children": [],
    "rendered": "error[E0308]: mismatched types\n  --> runtime/compiler_support.rs:48:65\n   |\n48 |     let layout = alloc::Layout::from_size_align_unchecked(size, align);\n   |                                                                 ^^^^^ expected usize, found u32\n\n"
    }"##,
            expect_file!["./test_data/rustc_mismatched_type.txt"],
        );
    }

    #[test]
    fn handles_macro_location() {
        check(
            r##"{
    "rendered": "error[E0277]: can't compare `{integer}` with `&str`\n --> src/main.rs:2:5\n  |\n2 |     assert_eq!(1, \"love\");\n  |     ^^^^^^^^^^^^^^^^^^^^^^ no implementation for `{integer} == &str`\n  |\n  = help: the trait `std::cmp::PartialEq<&str>` is not implemented for `{integer}`\n  = note: this error originates in a macro outside of the current crate (in Nightly builds, run with -Z external-macro-backtrace for more info)\n\n",
    "children": [
        {
            "children": [],
            "code": null,
            "level": "help",
            "message": "the trait `std::cmp::PartialEq<&str>` is not implemented for `{integer}`",
            "rendered": null,
            "spans": []
        }
    ],
    "code": {
        "code": "E0277",
        "explanation": "\nYou tried to use a type which doesn't implement some trait in a place which\nexpected that trait. Erroneous code example:\n\n```compile_fail,E0277\n// here we declare the Foo trait with a bar method\ntrait Foo {\n    fn bar(&self);\n}\n\n// we now declare a function which takes an object implementing the Foo trait\nfn some_func<T: Foo>(foo: T) {\n    foo.bar();\n}\n\nfn main() {\n    // we now call the method with the i32 type, which doesn't implement\n    // the Foo trait\n    some_func(5i32); // error: the trait bound `i32 : Foo` is not satisfied\n}\n```\n\nIn order to fix this error, verify that the type you're using does implement\nthe trait. Example:\n\n```\ntrait Foo {\n    fn bar(&self);\n}\n\nfn some_func<T: Foo>(foo: T) {\n    foo.bar(); // we can now use this method since i32 implements the\n               // Foo trait\n}\n\n// we implement the trait on the i32 type\nimpl Foo for i32 {\n    fn bar(&self) {}\n}\n\nfn main() {\n    some_func(5i32); // ok!\n}\n```\n\nOr in a generic context, an erroneous code example would look like:\n\n```compile_fail,E0277\nfn some_func<T>(foo: T) {\n    println!(\"{:?}\", foo); // error: the trait `core::fmt::Debug` is not\n                           //        implemented for the type `T`\n}\n\nfn main() {\n    // We now call the method with the i32 type,\n    // which *does* implement the Debug trait.\n    some_func(5i32);\n}\n```\n\nNote that the error here is in the definition of the generic function: Although\nwe only call it with a parameter that does implement `Debug`, the compiler\nstill rejects the function: It must work with all possible input types. In\norder to make this example compile, we need to restrict the generic type we're\naccepting:\n\n```\nuse std::fmt;\n\n// Restrict the input type to types that implement Debug.\nfn some_func<T: fmt::Debug>(foo: T) {\n    println!(\"{:?}\", foo);\n}\n\nfn main() {\n    // Calling the method is still fine, as i32 implements Debug.\n    some_func(5i32);\n\n    // This would fail to compile now:\n    // struct WithoutDebug;\n    // some_func(WithoutDebug);\n}\n```\n\nRust only looks at the signature of the called function, as such it must\nalready specify all requirements that will be used for every type parameter.\n"
    },
    "level": "error",
    "message": "can't compare `{integer}` with `&str`",
    "spans": [
        {
            "byte_end": 155,
            "byte_start": 153,
            "column_end": 33,
            "column_start": 31,
            "expansion": {
                "def_site_span": {
                    "byte_end": 940,
                    "byte_start": 0,
                    "column_end": 6,
                    "column_start": 1,
                    "expansion": null,
                    "file_name": "<::core::macros::assert_eq macros>",
                    "is_primary": false,
                    "label": null,
                    "line_end": 36,
                    "line_start": 1,
                    "suggested_replacement": null,
                    "suggestion_applicability": null,
                    "text": [
                        {
                            "highlight_end": 35,
                            "highlight_start": 1,
                            "text": "($ left : expr, $ right : expr) =>"
                        },
                        {
                            "highlight_end": 3,
                            "highlight_start": 1,
                            "text": "({"
                        },
                        {
                            "highlight_end": 33,
                            "highlight_start": 1,
                            "text": "     match (& $ left, & $ right)"
                        },
                        {
                            "highlight_end": 7,
                            "highlight_start": 1,
                            "text": "     {"
                        },
                        {
                            "highlight_end": 34,
                            "highlight_start": 1,
                            "text": "         (left_val, right_val) =>"
                        },
                        {
                            "highlight_end": 11,
                            "highlight_start": 1,
                            "text": "         {"
                        },
                        {
                            "highlight_end": 46,
                            "highlight_start": 1,
                            "text": "             if ! (* left_val == * right_val)"
                        },
                        {
                            "highlight_end": 15,
                            "highlight_start": 1,
                            "text": "             {"
                        },
                        {
                            "highlight_end": 25,
                            "highlight_start": 1,
                            "text": "                 panic !"
                        },
                        {
                            "highlight_end": 57,
                            "highlight_start": 1,
                            "text": "                 (r#\"assertion failed: `(left == right)`"
                        },
                        {
                            "highlight_end": 16,
                            "highlight_start": 1,
                            "text": "  left: `{:?}`,"
                        },
                        {
                            "highlight_end": 18,
                            "highlight_start": 1,
                            "text": " right: `{:?}`\"#,"
                        },
                        {
                            "highlight_end": 47,
                            "highlight_start": 1,
                            "text": "                  & * left_val, & * right_val)"
                        },
                        {
                            "highlight_end": 15,
                            "highlight_start": 1,
                            "text": "             }"
                        },
                        {
                            "highlight_end": 11,
                            "highlight_start": 1,
                            "text": "         }"
                        },
                        {
                            "highlight_end": 7,
                            "highlight_start": 1,
                            "text": "     }"
                        },
                        {
                            "highlight_end": 42,
                            "highlight_start": 1,
                            "text": " }) ; ($ left : expr, $ right : expr,) =>"
                        },
                        {
                            "highlight_end": 49,
                            "highlight_start": 1,
                            "text": "({ $ crate :: assert_eq ! ($ left, $ right) }) ;"
                        },
                        {
                            "highlight_end": 53,
                            "highlight_start": 1,
                            "text": "($ left : expr, $ right : expr, $ ($ arg : tt) +) =>"
                        },
                        {
                            "highlight_end": 3,
                            "highlight_start": 1,
                            "text": "({"
                        },
                        {
                            "highlight_end": 37,
                            "highlight_start": 1,
                            "text": "     match (& ($ left), & ($ right))"
                        },
                        {
                            "highlight_end": 7,
                            "highlight_start": 1,
                            "text": "     {"
                        },
                        {
                            "highlight_end": 34,
                            "highlight_start": 1,
                            "text": "         (left_val, right_val) =>"
                        },
                        {
                            "highlight_end": 11,
                            "highlight_start": 1,
                            "text": "         {"
                        },
                        {
                            "highlight_end": 46,
                            "highlight_start": 1,
                            "text": "             if ! (* left_val == * right_val)"
                        },
                        {
                            "highlight_end": 15,
                            "highlight_start": 1,
                            "text": "             {"
                        },
                        {
                            "highlight_end": 25,
                            "highlight_start": 1,
                            "text": "                 panic !"
                        },
                        {
                            "highlight_end": 57,
                            "highlight_start": 1,
                            "text": "                 (r#\"assertion failed: `(left == right)`"
                        },
                        {
                            "highlight_end": 16,
                            "highlight_start": 1,
                            "text": "  left: `{:?}`,"
                        },
                        {
                            "highlight_end": 22,
                            "highlight_start": 1,
                            "text": " right: `{:?}`: {}\"#,"
                        },
                        {
                            "highlight_end": 72,
                            "highlight_start": 1,
                            "text": "                  & * left_val, & * right_val, $ crate :: format_args !"
                        },
                        {
                            "highlight_end": 33,
                            "highlight_start": 1,
                            "text": "                  ($ ($ arg) +))"
                        },
                        {
                            "highlight_end": 15,
                            "highlight_start": 1,
                            "text": "             }"
                        },
                        {
                            "highlight_end": 11,
                            "highlight_start": 1,
                            "text": "         }"
                        },
                        {
                            "highlight_end": 7,
                            "highlight_start": 1,
                            "text": "     }"
                        },
                        {
                            "highlight_end": 6,
                            "highlight_start": 1,
                            "text": " }) ;"
                        }
                    ]
                },
                "macro_decl_name": "assert_eq!",
                "span": {
                    "byte_end": 38,
                    "byte_start": 16,
                    "column_end": 27,
                    "column_start": 5,
                    "expansion": null,
                    "file_name": "src/main.rs",
                    "is_primary": false,
                    "label": null,
                    "line_end": 2,
                    "line_start": 2,
                    "suggested_replacement": null,
                    "suggestion_applicability": null,
                    "text": [
                        {
                            "highlight_end": 27,
                            "highlight_start": 5,
                            "text": "    assert_eq!(1, \"love\");"
                        }
                    ]
                }
            },
            "file_name": "<::core::macros::assert_eq macros>",
            "is_primary": true,
            "label": "no implementation for `{integer} == &str`",
            "line_end": 7,
            "line_start": 7,
            "suggested_replacement": null,
            "suggestion_applicability": null,
            "text": [
                {
                    "highlight_end": 33,
                    "highlight_start": 31,
                    "text": "             if ! (* left_val == * right_val)"
                }
            ]
        }
    ]
    }"##,
            expect_file!["./test_data/handles_macro_location.txt"],
        );
    }

    #[test]
    fn macro_compiler_error() {
        check(
            r##"{
        "rendered": "error: Please register your known path in the path module\n   --> crates/hir_def/src/path.rs:265:9\n    |\n265 |         compile_error!(\"Please register your known path in the path module\")\n    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n    | \n   ::: crates/hir_def/src/data.rs:80:16\n    |\n80  |     let path = path![std::future::Future];\n    |                -------------------------- in this macro invocation\n\n",
        "children": [],
        "code": null,
        "level": "error",
        "message": "Please register your known path in the path module",
        "spans": [
            {
                "byte_end": 8285,
                "byte_start": 8217,
                "column_end": 77,
                "column_start": 9,
                "expansion": {
                    "def_site_span": {
                        "byte_end": 8294,
                        "byte_start": 7858,
                        "column_end": 2,
                        "column_start": 1,
                        "expansion": null,
                        "file_name": "crates/hir_def/src/path.rs",
                        "is_primary": false,
                        "label": null,
                        "line_end": 267,
                        "line_start": 254,
                        "suggested_replacement": null,
                        "suggestion_applicability": null,
                        "text": [
                            {
                                "highlight_end": 28,
                                "highlight_start": 1,
                                "text": "macro_rules! __known_path {"
                            },
                            {
                                "highlight_end": 37,
                                "highlight_start": 1,
                                "text": "    (std::iter::IntoIterator) => {};"
                            },
                            {
                                "highlight_end": 33,
                                "highlight_start": 1,
                                "text": "    (std::result::Result) => {};"
                            },
                            {
                                "highlight_end": 29,
                                "highlight_start": 1,
                                "text": "    (std::ops::Range) => {};"
                            },
                            {
                                "highlight_end": 33,
                                "highlight_start": 1,
                                "text": "    (std::ops::RangeFrom) => {};"
                            },
                            {
                                "highlight_end": 33,
                                "highlight_start": 1,
                                "text": "    (std::ops::RangeFull) => {};"
                            },
                            {
                                "highlight_end": 31,
                                "highlight_start": 1,
                                "text": "    (std::ops::RangeTo) => {};"
                            },
                            {
                                "highlight_end": 40,
                                "highlight_start": 1,
                                "text": "    (std::ops::RangeToInclusive) => {};"
                            },
                            {
                                "highlight_end": 38,
                                "highlight_start": 1,
                                "text": "    (std::ops::RangeInclusive) => {};"
                            },
                            {
                                "highlight_end": 27,
                                "highlight_start": 1,
                                "text": "    (std::ops::Try) => {};"
                            },
                            {
                                "highlight_end": 22,
                                "highlight_start": 1,
                                "text": "    ($path:path) => {"
                            },
                            {
                                "highlight_end": 77,
                                "highlight_start": 1,
                                "text": "        compile_error!(\"Please register your known path in the path module\")"
                            },
                            {
                                "highlight_end": 7,
                                "highlight_start": 1,
                                "text": "    };"
                            },
                            {
                                "highlight_end": 2,
                                "highlight_start": 1,
                                "text": "}"
                            }
                        ]
                    },
                    "macro_decl_name": "$crate::__known_path!",
                    "span": {
                        "byte_end": 8427,
                        "byte_start": 8385,
                        "column_end": 51,
                        "column_start": 9,
                        "expansion": {
                            "def_site_span": {
                                "byte_end": 8611,
                                "byte_start": 8312,
                                "column_end": 2,
                                "column_start": 1,
                                "expansion": null,
                                "file_name": "crates/hir_def/src/path.rs",
                                "is_primary": false,
                                "label": null,
                                "line_end": 277,
                                "line_start": 270,
                                "suggested_replacement": null,
                                "suggestion_applicability": null,
                                "text": [
                                    {
                                        "highlight_end": 22,
                                        "highlight_start": 1,
                                        "text": "macro_rules! __path {"
                                    },
                                    {
                                        "highlight_end": 43,
                                        "highlight_start": 1,
                                        "text": "    ($start:ident $(:: $seg:ident)*) => ({"
                                    },
                                    {
                                        "highlight_end": 51,
                                        "highlight_start": 1,
                                        "text": "        $crate::__known_path!($start $(:: $seg)*);"
                                    },
                                    {
                                        "highlight_end": 87,
                                        "highlight_start": 1,
                                        "text": "        $crate::path::ModPath::from_simple_segments($crate::path::PathKind::Abs, vec!["
                                    },
                                    {
                                        "highlight_end": 76,
                                        "highlight_start": 1,
                                        "text": "            $crate::path::__name![$start], $($crate::path::__name![$seg],)*"
                                    },
                                    {
                                        "highlight_end": 11,
                                        "highlight_start": 1,
                                        "text": "        ])"
                                    },
                                    {
                                        "highlight_end": 8,
                                        "highlight_start": 1,
                                        "text": "    });"
                                    },
                                    {
                                        "highlight_end": 2,
                                        "highlight_start": 1,
                                        "text": "}"
                                    }
                                ]
                            },
                            "macro_decl_name": "path!",
                            "span": {
                                "byte_end": 2966,
                                "byte_start": 2940,
                                "column_end": 42,
                                "column_start": 16,
                                "expansion": null,
                                "file_name": "crates/hir_def/src/data.rs",
                                "is_primary": false,
                                "label": null,
                                "line_end": 80,
                                "line_start": 80,
                                "suggested_replacement": null,
                                "suggestion_applicability": null,
                                "text": [
                                    {
                                        "highlight_end": 42,
                                        "highlight_start": 16,
                                        "text": "    let path = path![std::future::Future];"
                                    }
                                ]
                            }
                        },
                        "file_name": "crates/hir_def/src/path.rs",
                        "is_primary": false,
                        "label": null,
                        "line_end": 272,
                        "line_start": 272,
                        "suggested_replacement": null,
                        "suggestion_applicability": null,
                        "text": [
                            {
                                "highlight_end": 51,
                                "highlight_start": 9,
                                "text": "        $crate::__known_path!($start $(:: $seg)*);"
                            }
                        ]
                    }
                },
                "file_name": "crates/hir_def/src/path.rs",
                "is_primary": true,
                "label": null,
                "line_end": 265,
                "line_start": 265,
                "suggested_replacement": null,
                "suggestion_applicability": null,
                "text": [
                    {
                        "highlight_end": 77,
                        "highlight_start": 9,
                        "text": "        compile_error!(\"Please register your known path in the path module\")"
                    }
                ]
            }
        ]
    }
            "##,
            expect_file!["./test_data/macro_compiler_error.txt"],
        );
    }

    #[test]
    fn snap_multi_line_fix() {
        check(
            r##"{
                "rendered": "warning: returning the result of a let binding from a block\n --> src/main.rs:4:5\n  |\n3 |     let a = (0..10).collect();\n  |     -------------------------- unnecessary let binding\n4 |     a\n  |     ^\n  |\n  = note: `#[warn(clippy::let_and_return)]` on by default\n  = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#let_and_return\nhelp: return the expression directly\n  |\n3 |     \n4 |     (0..10).collect()\n  |\n\n",
                "children": [
                    {
                    "children": [],
                    "code": null,
                    "level": "note",
                    "message": "`#[warn(clippy::let_and_return)]` on by default",
                    "rendered": null,
                    "spans": []
                    },
                    {
                    "children": [],
                    "code": null,
                    "level": "help",
                    "message": "for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#let_and_return",
                    "rendered": null,
                    "spans": []
                    },
                    {
                    "children": [],
                    "code": null,
                    "level": "help",
                    "message": "return the expression directly",
                    "rendered": null,
                    "spans": [
                        {
                        "byte_end": 55,
                        "byte_start": 29,
                        "column_end": 31,
                        "column_start": 5,
                        "expansion": null,
                        "file_name": "src/main.rs",
                        "is_primary": true,
                        "label": null,
                        "line_end": 3,
                        "line_start": 3,
                        "suggested_replacement": "",
                        "suggestion_applicability": "MachineApplicable",
                        "text": [
                            {
                            "highlight_end": 31,
                            "highlight_start": 5,
                            "text": "    let a = (0..10).collect();"
                            }
                        ]
                        },
                        {
                        "byte_end": 61,
                        "byte_start": 60,
                        "column_end": 6,
                        "column_start": 5,
                        "expansion": null,
                        "file_name": "src/main.rs",
                        "is_primary": true,
                        "label": null,
                        "line_end": 4,
                        "line_start": 4,
                        "suggested_replacement": "(0..10).collect()",
                        "suggestion_applicability": "MachineApplicable",
                        "text": [
                            {
                            "highlight_end": 6,
                            "highlight_start": 5,
                            "text": "    a"
                            }
                        ]
                        }
                    ]
                    }
                ],
                "code": {
                    "code": "clippy::let_and_return",
                    "explanation": null
                },
                "level": "warning",
                "message": "returning the result of a let binding from a block",
                "spans": [
                    {
                    "byte_end": 55,
                    "byte_start": 29,
                    "column_end": 31,
                    "column_start": 5,
                    "expansion": null,
                    "file_name": "src/main.rs",
                    "is_primary": false,
                    "label": "unnecessary let binding",
                    "line_end": 3,
                    "line_start": 3,
                    "suggested_replacement": null,
                    "suggestion_applicability": null,
                    "text": [
                        {
                        "highlight_end": 31,
                        "highlight_start": 5,
                        "text": "    let a = (0..10).collect();"
                        }
                    ]
                    },
                    {
                    "byte_end": 61,
                    "byte_start": 60,
                    "column_end": 6,
                    "column_start": 5,
                    "expansion": null,
                    "file_name": "src/main.rs",
                    "is_primary": true,
                    "label": null,
                    "line_end": 4,
                    "line_start": 4,
                    "suggested_replacement": null,
                    "suggestion_applicability": null,
                    "text": [
                        {
                        "highlight_end": 6,
                        "highlight_start": 5,
                        "text": "    a"
                        }
                    ]
                    }
                ]
            }
            "##,
            expect_file!["./test_data/snap_multi_line_fix.txt"],
        );
    }
}
