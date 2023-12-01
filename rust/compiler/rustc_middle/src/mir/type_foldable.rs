//! `TypeFoldable` implementations for MIR types

use super::*;
use crate::ty;

CloneTypeFoldableAndLiftImpls! {
    BlockTailInfo,
    MirPhase,
    SourceInfo,
    FakeReadCause,
    RetagKind,
    SourceScope,
    SourceScopeLocalData,
    UserTypeAnnotationIndex,
}

impl<'tcx> TypeFoldable<'tcx> for Terminator<'tcx> {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, folder: &mut F) -> Self {
        use crate::mir::TerminatorKind::*;

        let kind = match self.kind {
            Goto { target } => Goto { target },
            SwitchInt { ref discr, switch_ty, ref targets } => SwitchInt {
                discr: discr.fold_with(folder),
                switch_ty: switch_ty.fold_with(folder),
                targets: targets.clone(),
            },
            Drop { ref place, target, unwind } => {
                Drop { place: place.fold_with(folder), target, unwind }
            }
            DropAndReplace { ref place, ref value, target, unwind } => DropAndReplace {
                place: place.fold_with(folder),
                value: value.fold_with(folder),
                target,
                unwind,
            },
            Yield { ref value, resume, ref resume_arg, drop } => Yield {
                value: value.fold_with(folder),
                resume,
                resume_arg: resume_arg.fold_with(folder),
                drop,
            },
            Call { ref func, ref args, ref destination, cleanup, from_hir_call, fn_span } => {
                let dest =
                    destination.as_ref().map(|&(ref loc, dest)| (loc.fold_with(folder), dest));

                Call {
                    func: func.fold_with(folder),
                    args: args.fold_with(folder),
                    destination: dest,
                    cleanup,
                    from_hir_call,
                    fn_span,
                }
            }
            Assert { ref cond, expected, ref msg, target, cleanup } => {
                use AssertKind::*;
                let msg = match msg {
                    BoundsCheck { len, index } => {
                        BoundsCheck { len: len.fold_with(folder), index: index.fold_with(folder) }
                    }
                    Overflow(op, l, r) => Overflow(*op, l.fold_with(folder), r.fold_with(folder)),
                    OverflowNeg(op) => OverflowNeg(op.fold_with(folder)),
                    DivisionByZero(op) => DivisionByZero(op.fold_with(folder)),
                    RemainderByZero(op) => RemainderByZero(op.fold_with(folder)),
                    ResumedAfterReturn(_) | ResumedAfterPanic(_) => msg.clone(),
                };
                Assert { cond: cond.fold_with(folder), expected, msg, target, cleanup }
            }
            GeneratorDrop => GeneratorDrop,
            Resume => Resume,
            Abort => Abort,
            Return => Return,
            Unreachable => Unreachable,
            FalseEdge { real_target, imaginary_target } => {
                FalseEdge { real_target, imaginary_target }
            }
            FalseUnwind { real_target, unwind } => FalseUnwind { real_target, unwind },
            InlineAsm { template, ref operands, options, line_spans, destination } => InlineAsm {
                template,
                operands: operands.fold_with(folder),
                options,
                line_spans,
                destination,
            },
        };
        Terminator { source_info: self.source_info, kind }
    }

    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, visitor: &mut V) -> ControlFlow<()> {
        use crate::mir::TerminatorKind::*;

        match self.kind {
            SwitchInt { ref discr, switch_ty, .. } => {
                discr.visit_with(visitor)?;
                switch_ty.visit_with(visitor)
            }
            Drop { ref place, .. } => place.visit_with(visitor),
            DropAndReplace { ref place, ref value, .. } => {
                place.visit_with(visitor)?;
                value.visit_with(visitor)
            }
            Yield { ref value, .. } => value.visit_with(visitor),
            Call { ref func, ref args, ref destination, .. } => {
                if let Some((ref loc, _)) = *destination {
                    loc.visit_with(visitor)?;
                };
                func.visit_with(visitor)?;
                args.visit_with(visitor)
            }
            Assert { ref cond, ref msg, .. } => {
                cond.visit_with(visitor)?;
                use AssertKind::*;
                match msg {
                    BoundsCheck { ref len, ref index } => {
                        len.visit_with(visitor)?;
                        index.visit_with(visitor)
                    }
                    Overflow(_, l, r) => {
                        l.visit_with(visitor)?;
                        r.visit_with(visitor)
                    }
                    OverflowNeg(op) | DivisionByZero(op) | RemainderByZero(op) => {
                        op.visit_with(visitor)
                    }
                    ResumedAfterReturn(_) | ResumedAfterPanic(_) => ControlFlow::CONTINUE,
                }
            }
            InlineAsm { ref operands, .. } => operands.visit_with(visitor),
            Goto { .. }
            | Resume
            | Abort
            | Return
            | GeneratorDrop
            | Unreachable
            | FalseEdge { .. }
            | FalseUnwind { .. } => ControlFlow::CONTINUE,
        }
    }
}

impl<'tcx> TypeFoldable<'tcx> for GeneratorKind {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, _: &mut F) -> Self {
        *self
    }

    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, _: &mut V) -> ControlFlow<()> {
        ControlFlow::CONTINUE
    }
}

impl<'tcx> TypeFoldable<'tcx> for Place<'tcx> {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, folder: &mut F) -> Self {
        Place { local: self.local.fold_with(folder), projection: self.projection.fold_with(folder) }
    }

    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, visitor: &mut V) -> ControlFlow<()> {
        self.local.visit_with(visitor)?;
        self.projection.visit_with(visitor)
    }
}

impl<'tcx> TypeFoldable<'tcx> for &'tcx ty::List<PlaceElem<'tcx>> {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, folder: &mut F) -> Self {
        let v = self.iter().map(|t| t.fold_with(folder)).collect::<Vec<_>>();
        folder.tcx().intern_place_elems(&v)
    }

    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, visitor: &mut V) -> ControlFlow<()> {
        self.iter().try_for_each(|t| t.visit_with(visitor))
    }
}

impl<'tcx> TypeFoldable<'tcx> for Rvalue<'tcx> {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, folder: &mut F) -> Self {
        use crate::mir::Rvalue::*;
        match *self {
            Use(ref op) => Use(op.fold_with(folder)),
            Repeat(ref op, len) => Repeat(op.fold_with(folder), len.fold_with(folder)),
            ThreadLocalRef(did) => ThreadLocalRef(did.fold_with(folder)),
            Ref(region, bk, ref place) => {
                Ref(region.fold_with(folder), bk, place.fold_with(folder))
            }
            AddressOf(mutability, ref place) => AddressOf(mutability, place.fold_with(folder)),
            Len(ref place) => Len(place.fold_with(folder)),
            Cast(kind, ref op, ty) => Cast(kind, op.fold_with(folder), ty.fold_with(folder)),
            BinaryOp(op, ref rhs, ref lhs) => {
                BinaryOp(op, rhs.fold_with(folder), lhs.fold_with(folder))
            }
            CheckedBinaryOp(op, ref rhs, ref lhs) => {
                CheckedBinaryOp(op, rhs.fold_with(folder), lhs.fold_with(folder))
            }
            UnaryOp(op, ref val) => UnaryOp(op, val.fold_with(folder)),
            Discriminant(ref place) => Discriminant(place.fold_with(folder)),
            NullaryOp(op, ty) => NullaryOp(op, ty.fold_with(folder)),
            Aggregate(ref kind, ref fields) => {
                let kind = box match **kind {
                    AggregateKind::Array(ty) => AggregateKind::Array(ty.fold_with(folder)),
                    AggregateKind::Tuple => AggregateKind::Tuple,
                    AggregateKind::Adt(def, v, substs, user_ty, n) => AggregateKind::Adt(
                        def,
                        v,
                        substs.fold_with(folder),
                        user_ty.fold_with(folder),
                        n,
                    ),
                    AggregateKind::Closure(id, substs) => {
                        AggregateKind::Closure(id, substs.fold_with(folder))
                    }
                    AggregateKind::Generator(id, substs, movablity) => {
                        AggregateKind::Generator(id, substs.fold_with(folder), movablity)
                    }
                };
                Aggregate(kind, fields.fold_with(folder))
            }
        }
    }

    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, visitor: &mut V) -> ControlFlow<()> {
        use crate::mir::Rvalue::*;
        match *self {
            Use(ref op) => op.visit_with(visitor),
            Repeat(ref op, _) => op.visit_with(visitor),
            ThreadLocalRef(did) => did.visit_with(visitor),
            Ref(region, _, ref place) => {
                region.visit_with(visitor)?;
                place.visit_with(visitor)
            }
            AddressOf(_, ref place) => place.visit_with(visitor),
            Len(ref place) => place.visit_with(visitor),
            Cast(_, ref op, ty) => {
                op.visit_with(visitor)?;
                ty.visit_with(visitor)
            }
            BinaryOp(_, ref rhs, ref lhs) | CheckedBinaryOp(_, ref rhs, ref lhs) => {
                rhs.visit_with(visitor)?;
                lhs.visit_with(visitor)
            }
            UnaryOp(_, ref val) => val.visit_with(visitor),
            Discriminant(ref place) => place.visit_with(visitor),
            NullaryOp(_, ty) => ty.visit_with(visitor),
            Aggregate(ref kind, ref fields) => {
                match **kind {
                    AggregateKind::Array(ty) => {
                        ty.visit_with(visitor)?;
                    }
                    AggregateKind::Tuple => {}
                    AggregateKind::Adt(_, _, substs, user_ty, _) => {
                        substs.visit_with(visitor)?;
                        user_ty.visit_with(visitor)?;
                    }
                    AggregateKind::Closure(_, substs) => {
                        substs.visit_with(visitor)?;
                    }
                    AggregateKind::Generator(_, substs, _) => {
                        substs.visit_with(visitor)?;
                    }
                }
                fields.visit_with(visitor)
            }
        }
    }
}

impl<'tcx> TypeFoldable<'tcx> for Operand<'tcx> {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, folder: &mut F) -> Self {
        match *self {
            Operand::Copy(ref place) => Operand::Copy(place.fold_with(folder)),
            Operand::Move(ref place) => Operand::Move(place.fold_with(folder)),
            Operand::Constant(ref c) => Operand::Constant(c.fold_with(folder)),
        }
    }

    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, visitor: &mut V) -> ControlFlow<()> {
        match *self {
            Operand::Copy(ref place) | Operand::Move(ref place) => place.visit_with(visitor),
            Operand::Constant(ref c) => c.visit_with(visitor),
        }
    }
}

impl<'tcx> TypeFoldable<'tcx> for PlaceElem<'tcx> {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, folder: &mut F) -> Self {
        use crate::mir::ProjectionElem::*;

        match *self {
            Deref => Deref,
            Field(f, ty) => Field(f, ty.fold_with(folder)),
            Index(v) => Index(v.fold_with(folder)),
            Downcast(symbol, variantidx) => Downcast(symbol, variantidx),
            ConstantIndex { offset, min_length, from_end } => {
                ConstantIndex { offset, min_length, from_end }
            }
            Subslice { from, to, from_end } => Subslice { from, to, from_end },
        }
    }

    fn super_visit_with<Vs: TypeVisitor<'tcx>>(&self, visitor: &mut Vs) -> ControlFlow<()> {
        use crate::mir::ProjectionElem::*;

        match self {
            Field(_, ty) => ty.visit_with(visitor),
            Index(v) => v.visit_with(visitor),
            _ => ControlFlow::CONTINUE,
        }
    }
}

impl<'tcx> TypeFoldable<'tcx> for Field {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, _: &mut F) -> Self {
        *self
    }
    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, _: &mut V) -> ControlFlow<()> {
        ControlFlow::CONTINUE
    }
}

impl<'tcx> TypeFoldable<'tcx> for GeneratorSavedLocal {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, _: &mut F) -> Self {
        *self
    }
    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, _: &mut V) -> ControlFlow<()> {
        ControlFlow::CONTINUE
    }
}

impl<'tcx, R: Idx, C: Idx> TypeFoldable<'tcx> for BitMatrix<R, C> {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, _: &mut F) -> Self {
        self.clone()
    }
    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, _: &mut V) -> ControlFlow<()> {
        ControlFlow::CONTINUE
    }
}

impl<'tcx> TypeFoldable<'tcx> for Constant<'tcx> {
    fn super_fold_with<F: TypeFolder<'tcx>>(&self, folder: &mut F) -> Self {
        Constant {
            span: self.span,
            user_ty: self.user_ty.fold_with(folder),
            literal: self.literal.fold_with(folder),
        }
    }
    fn super_visit_with<V: TypeVisitor<'tcx>>(&self, visitor: &mut V) -> ControlFlow<()> {
        self.literal.visit_with(visitor)
    }
}
