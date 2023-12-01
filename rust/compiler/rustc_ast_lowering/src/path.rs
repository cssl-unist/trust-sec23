use super::{AnonymousLifetimeMode, ImplTraitContext, LoweringContext, ParamMode};
use super::{GenericArgsCtor, ParenthesizedGenericArgs};

use rustc_ast::{self as ast, *};
use rustc_errors::{struct_span_err, Applicability};
use rustc_hir as hir;
use rustc_hir::def::{DefKind, PartialRes, Res};
use rustc_hir::def_id::DefId;
use rustc_hir::GenericArg;
use rustc_session::lint::builtin::ELIDED_LIFETIMES_IN_PATHS;
use rustc_session::lint::BuiltinLintDiagnostics;
use rustc_span::symbol::Ident;
use rustc_span::Span;

use smallvec::smallvec;
use tracing::debug;

impl<'a, 'hir> LoweringContext<'a, 'hir> {
    crate fn lower_qpath(
        &mut self,
        id: NodeId,
        qself: &Option<QSelf>,
        p: &Path,
        param_mode: ParamMode,
        mut itctx: ImplTraitContext<'_, 'hir>,
    ) -> hir::QPath<'hir> {
        let qself_position = qself.as_ref().map(|q| q.position);
        let qself = qself.as_ref().map(|q| self.lower_ty(&q.ty, itctx.reborrow()));

        let partial_res =
            self.resolver.get_partial_res(id).unwrap_or_else(|| PartialRes::new(Res::Err));

        let proj_start = p.segments.len() - partial_res.unresolved_segments();
        let path = self.arena.alloc(hir::Path {
            res: self.lower_res(partial_res.base_res()),
            segments: self.arena.alloc_from_iter(p.segments[..proj_start].iter().enumerate().map(
                |(i, segment)| {
                    let param_mode = match (qself_position, param_mode) {
                        (Some(j), ParamMode::Optional) if i < j => {
                            // This segment is part of the trait path in a
                            // qualified path - one of `a`, `b` or `Trait`
                            // in `<X as a::b::Trait>::T::U::method`.
                            ParamMode::Explicit
                        }
                        _ => param_mode,
                    };

                    // Figure out if this is a type/trait segment,
                    // which may need lifetime elision performed.
                    let parent_def_id = |this: &mut Self, def_id: DefId| DefId {
                        krate: def_id.krate,
                        index: this.resolver.def_key(def_id).parent.expect("missing parent"),
                    };
                    let type_def_id = match partial_res.base_res() {
                        Res::Def(DefKind::AssocTy, def_id) if i + 2 == proj_start => {
                            Some(parent_def_id(self, def_id))
                        }
                        Res::Def(DefKind::Variant, def_id) if i + 1 == proj_start => {
                            Some(parent_def_id(self, def_id))
                        }
                        Res::Def(DefKind::Struct, def_id)
                        | Res::Def(DefKind::Union, def_id)
                        | Res::Def(DefKind::Enum, def_id)
                        | Res::Def(DefKind::TyAlias, def_id)
                        | Res::Def(DefKind::Trait, def_id)
                            if i + 1 == proj_start =>
                        {
                            Some(def_id)
                        }
                        _ => None,
                    };
                    let parenthesized_generic_args = match partial_res.base_res() {
                        // `a::b::Trait(Args)`
                        Res::Def(DefKind::Trait, _) if i + 1 == proj_start => {
                            ParenthesizedGenericArgs::Ok
                        }
                        // `a::b::Trait(Args)::TraitItem`
                        Res::Def(DefKind::AssocFn, _)
                        | Res::Def(DefKind::AssocConst, _)
                        | Res::Def(DefKind::AssocTy, _)
                            if i + 2 == proj_start =>
                        {
                            ParenthesizedGenericArgs::Ok
                        }
                        // Avoid duplicated errors.
                        Res::Err => ParenthesizedGenericArgs::Ok,
                        // An error
                        _ => ParenthesizedGenericArgs::Err,
                    };

                    let num_lifetimes = type_def_id.map_or(0, |def_id| {
                        if let Some(&n) = self.type_def_lifetime_params.get(&def_id) {
                            return n;
                        }
                        assert!(!def_id.is_local());
                        let n = self.resolver.item_generics_num_lifetimes(def_id, self.sess);
                        self.type_def_lifetime_params.insert(def_id, n);
                        n
                    });
                    self.lower_path_segment(
                        p.span,
                        segment,
                        param_mode,
                        num_lifetimes,
                        parenthesized_generic_args,
                        itctx.reborrow(),
                        None,
                    )
                },
            )),
            span: p.span,
        });

        // Simple case, either no projections, or only fully-qualified.
        // E.g., `std::mem::size_of` or `<I as Iterator>::Item`.
        if partial_res.unresolved_segments() == 0 {
            return hir::QPath::Resolved(qself, path);
        }

        // Create the innermost type that we're projecting from.
        let mut ty = if path.segments.is_empty() {
            // If the base path is empty that means there exists a
            // syntactical `Self`, e.g., `&i32` in `<&i32>::clone`.
            qself.expect("missing QSelf for <T>::...")
        } else {
            // Otherwise, the base path is an implicit `Self` type path,
            // e.g., `Vec` in `Vec::new` or `<I as Iterator>::Item` in
            // `<I as Iterator>::Item::default`.
            let new_id = self.next_id();
            self.arena.alloc(self.ty_path(new_id, p.span, hir::QPath::Resolved(qself, path)))
        };

        // Anything after the base path are associated "extensions",
        // out of which all but the last one are associated types,
        // e.g., for `std::vec::Vec::<T>::IntoIter::Item::clone`:
        // * base path is `std::vec::Vec<T>`
        // * "extensions" are `IntoIter`, `Item` and `clone`
        // * type nodes are:
        //   1. `std::vec::Vec<T>` (created above)
        //   2. `<std::vec::Vec<T>>::IntoIter`
        //   3. `<<std::vec::Vec<T>>::IntoIter>::Item`
        // * final path is `<<<std::vec::Vec<T>>::IntoIter>::Item>::clone`
        for (i, segment) in p.segments.iter().enumerate().skip(proj_start) {
            let segment = self.arena.alloc(self.lower_path_segment(
                p.span,
                segment,
                param_mode,
                0,
                ParenthesizedGenericArgs::Err,
                itctx.reborrow(),
                None,
            ));
            let qpath = hir::QPath::TypeRelative(ty, segment);

            // It's finished, return the extension of the right node type.
            if i == p.segments.len() - 1 {
                return qpath;
            }

            // Wrap the associated extension in another type node.
            let new_id = self.next_id();
            ty = self.arena.alloc(self.ty_path(new_id, p.span, qpath));
        }

        // We should've returned in the for loop above.

        self.sess.diagnostic().span_bug(
            p.span,
            &format!(
                "lower_qpath: no final extension segment in {}..{}",
                proj_start,
                p.segments.len()
            ),
        );
    }

    crate fn lower_path_extra(
        &mut self,
        res: Res,
        p: &Path,
        param_mode: ParamMode,
        explicit_owner: Option<NodeId>,
    ) -> &'hir hir::Path<'hir> {
        self.arena.alloc(hir::Path {
            res,
            segments: self.arena.alloc_from_iter(p.segments.iter().map(|segment| {
                self.lower_path_segment(
                    p.span,
                    segment,
                    param_mode,
                    0,
                    ParenthesizedGenericArgs::Err,
                    ImplTraitContext::disallowed(),
                    explicit_owner,
                )
            })),
            span: p.span,
        })
    }

    crate fn lower_path(
        &mut self,
        id: NodeId,
        p: &Path,
        param_mode: ParamMode,
    ) -> &'hir hir::Path<'hir> {
        let res = self.expect_full_res(id);
        let res = self.lower_res(res);
        self.lower_path_extra(res, p, param_mode, None)
    }

    crate fn lower_path_segment(
        &mut self,
        path_span: Span,
        segment: &PathSegment,
        param_mode: ParamMode,
        expected_lifetimes: usize,
        parenthesized_generic_args: ParenthesizedGenericArgs,
        itctx: ImplTraitContext<'_, 'hir>,
        explicit_owner: Option<NodeId>,
    ) -> hir::PathSegment<'hir> {
        let (mut generic_args, infer_args) = if let Some(ref generic_args) = segment.args {
            let msg = "parenthesized type parameters may only be used with a `Fn` trait";
            match **generic_args {
                GenericArgs::AngleBracketed(ref data) => {
                    self.lower_angle_bracketed_parameter_data(data, param_mode, itctx)
                }
                GenericArgs::Parenthesized(ref data) => match parenthesized_generic_args {
                    ParenthesizedGenericArgs::Ok => self.lower_parenthesized_parameter_data(data),
                    ParenthesizedGenericArgs::Err => {
                        let mut err = struct_span_err!(self.sess, data.span, E0214, "{}", msg);
                        err.span_label(data.span, "only `Fn` traits may use parentheses");
                        if let Ok(snippet) = self.sess.source_map().span_to_snippet(data.span) {
                            // Do not suggest going from `Trait()` to `Trait<>`
                            if !data.inputs.is_empty() {
                                if let Some(split) = snippet.find('(') {
                                    let trait_name = &snippet[0..split];
                                    let args = &snippet[split + 1..snippet.len() - 1];
                                    err.span_suggestion(
                                        data.span,
                                        "use angle brackets instead",
                                        format!("{}<{}>", trait_name, args),
                                        Applicability::MaybeIncorrect,
                                    );
                                }
                            }
                        };
                        err.emit();
                        (
                            self.lower_angle_bracketed_parameter_data(
                                &data.as_angle_bracketed_args(),
                                param_mode,
                                itctx,
                            )
                            .0,
                            false,
                        )
                    }
                },
            }
        } else {
            self.lower_angle_bracketed_parameter_data(&Default::default(), param_mode, itctx)
        };

        let has_lifetimes =
            generic_args.args.iter().any(|arg| matches!(arg, GenericArg::Lifetime(_)));
        let first_generic_span = generic_args
            .args
            .iter()
            .map(|a| a.span())
            .chain(generic_args.bindings.iter().map(|b| b.span))
            .next();
        if !generic_args.parenthesized && !has_lifetimes {
            generic_args.args = self
                .elided_path_lifetimes(
                    first_generic_span.map(|s| s.shrink_to_lo()).unwrap_or(segment.ident.span),
                    expected_lifetimes,
                )
                .map(GenericArg::Lifetime)
                .chain(generic_args.args.into_iter())
                .collect();
            if expected_lifetimes > 0 && param_mode == ParamMode::Explicit {
                let anon_lt_suggestion = vec!["'_"; expected_lifetimes].join(", ");
                let no_non_lt_args = generic_args.args.len() == expected_lifetimes;
                let no_bindings = generic_args.bindings.is_empty();
                let (incl_angl_brckt, insertion_sp, suggestion) = if no_non_lt_args && no_bindings {
                    // If there are no (non-implicit) generic args or associated type
                    // bindings, our suggestion includes the angle brackets.
                    (true, path_span.shrink_to_hi(), format!("<{}>", anon_lt_suggestion))
                } else {
                    // Otherwise (sorry, this is kind of gross) we need to infer the
                    // place to splice in the `'_, ` from the generics that do exist.
                    let first_generic_span = first_generic_span
                        .expect("already checked that non-lifetime args or bindings exist");
                    (false, first_generic_span.shrink_to_lo(), format!("{}, ", anon_lt_suggestion))
                };
                match self.anonymous_lifetime_mode {
                    // In create-parameter mode we error here because we don't want to support
                    // deprecated impl elision in new features like impl elision and `async fn`,
                    // both of which work using the `CreateParameter` mode:
                    //
                    //     impl Foo for std::cell::Ref<u32> // note lack of '_
                    //     async fn foo(_: std::cell::Ref<u32>) { ... }
                    AnonymousLifetimeMode::CreateParameter => {
                        let mut err = struct_span_err!(
                            self.sess,
                            path_span,
                            E0726,
                            "implicit elided lifetime not allowed here"
                        );
                        rustc_errors::add_elided_lifetime_in_path_suggestion(
                            &self.sess.source_map(),
                            &mut err,
                            expected_lifetimes,
                            path_span,
                            incl_angl_brckt,
                            insertion_sp,
                            suggestion,
                        );
                        err.emit();
                    }
                    AnonymousLifetimeMode::PassThrough | AnonymousLifetimeMode::ReportError => {
                        self.resolver.lint_buffer().buffer_lint_with_diagnostic(
                            ELIDED_LIFETIMES_IN_PATHS,
                            CRATE_NODE_ID,
                            path_span,
                            "hidden lifetime parameters in types are deprecated",
                            BuiltinLintDiagnostics::ElidedLifetimesInPaths(
                                expected_lifetimes,
                                path_span,
                                incl_angl_brckt,
                                insertion_sp,
                                suggestion,
                            ),
                        );
                    }
                }
            }
        }

        let res = self.expect_full_res(segment.id);
        let id = if let Some(owner) = explicit_owner {
            self.lower_node_id_with_owner(segment.id, owner)
        } else {
            self.lower_node_id(segment.id)
        };
        debug!(
            "lower_path_segment: ident={:?} original-id={:?} new-id={:?}",
            segment.ident, segment.id, id,
        );

        hir::PathSegment {
            ident: segment.ident,
            hir_id: Some(id),
            res: Some(self.lower_res(res)),
            infer_args,
            args: if generic_args.is_empty() {
                None
            } else {
                Some(self.arena.alloc(generic_args.into_generic_args(self.arena)))
            },
        }
    }

    fn lower_angle_bracketed_parameter_data(
        &mut self,
        data: &AngleBracketedArgs,
        param_mode: ParamMode,
        mut itctx: ImplTraitContext<'_, 'hir>,
    ) -> (GenericArgsCtor<'hir>, bool) {
        let has_non_lt_args = data.args.iter().any(|arg| match arg {
            AngleBracketedArg::Arg(ast::GenericArg::Lifetime(_))
            | AngleBracketedArg::Constraint(_) => false,
            AngleBracketedArg::Arg(ast::GenericArg::Type(_) | ast::GenericArg::Const(_)) => true,
        });
        let args = data
            .args
            .iter()
            .filter_map(|arg| match arg {
                AngleBracketedArg::Arg(arg) => Some(self.lower_generic_arg(arg, itctx.reborrow())),
                AngleBracketedArg::Constraint(_) => None,
            })
            .collect();
        let bindings = self.arena.alloc_from_iter(data.args.iter().filter_map(|arg| match arg {
            AngleBracketedArg::Constraint(c) => {
                Some(self.lower_assoc_ty_constraint(c, itctx.reborrow()))
            }
            AngleBracketedArg::Arg(_) => None,
        }));
        let ctor = GenericArgsCtor { args, bindings, parenthesized: false };
        (ctor, !has_non_lt_args && param_mode == ParamMode::Optional)
    }

    fn lower_parenthesized_parameter_data(
        &mut self,
        data: &ParenthesizedArgs,
    ) -> (GenericArgsCtor<'hir>, bool) {
        // Switch to `PassThrough` mode for anonymous lifetimes; this
        // means that we permit things like `&Ref<T>`, where `Ref` has
        // a hidden lifetime parameter. This is needed for backwards
        // compatibility, even in contexts like an impl header where
        // we generally don't permit such things (see #51008).
        self.with_anonymous_lifetime_mode(AnonymousLifetimeMode::PassThrough, |this| {
            let &ParenthesizedArgs { ref inputs, ref output, span } = data;
            let inputs = this.arena.alloc_from_iter(
                inputs.iter().map(|ty| this.lower_ty_direct(ty, ImplTraitContext::disallowed())),
            );
            let output_ty = match output {
                FnRetTy::Ty(ty) => this.lower_ty(&ty, ImplTraitContext::disallowed()),
                FnRetTy::Default(_) => this.arena.alloc(this.ty_tup(span, &[])),
            };
            let args = smallvec![GenericArg::Type(this.ty_tup(span, inputs))];
            let binding = this.output_ty_binding(output_ty.span, output_ty);
            (
                GenericArgsCtor { args, bindings: arena_vec![this; binding], parenthesized: true },
                false,
            )
        })
    }

    /// An associated type binding `Output = $ty`.
    crate fn output_ty_binding(
        &mut self,
        span: Span,
        ty: &'hir hir::Ty<'hir>,
    ) -> hir::TypeBinding<'hir> {
        let ident = Ident::with_dummy_span(hir::FN_OUTPUT_NAME);
        let kind = hir::TypeBindingKind::Equality { ty };
        hir::TypeBinding { hir_id: self.next_id(), span, ident, kind }
    }
}
