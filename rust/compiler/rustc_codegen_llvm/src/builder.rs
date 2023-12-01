use crate::common::Funclet;
use crate::context::CodegenCx;
use crate::llvm::{self, BasicBlock, False, LLVMSetInUnsafeMetadata};
use crate::llvm::{AtomicOrdering, AtomicRmwBinOp, SynchronizationScope};
use crate::type_::Type;
use crate::type_of::LayoutLlvmExt;
use crate::value::Value;
use libc::{c_char, c_uint};
use rustc_codegen_ssa::common::{IntPredicate, RealPredicate, TypeKind};
use rustc_codegen_ssa::mir::operand::{OperandRef, OperandValue};
use rustc_codegen_ssa::mir::place::PlaceRef;
use rustc_codegen_ssa::traits::*;
use rustc_codegen_ssa::MemFlags;
use rustc_data_structures::const_cstr;
use rustc_data_structures::small_c_str::SmallCStr;
use rustc_hir::def_id::DefId;
use rustc_middle::ty::layout::TyAndLayout;
use rustc_middle::ty::{self, Ty, TyCtxt};
use rustc_span::{sym, Span};
use rustc_target::abi::{self, Align, Size};
use rustc_target::spec::{HasTargetSpec, Target};
use std::borrow::Cow;
use std::ffi::CStr;
use std::ops::{Deref, Range};
use std::ptr;
use tracing::debug;

// All Builders must have an llfn associated with them
#[must_use]
pub struct Builder<'a, 'll, 'tcx> {
    pub llbuilder: &'ll mut llvm::Builder<'ll>,
    pub cx: &'a CodegenCx<'ll, 'tcx>,
    pub in_unsafe: bool,
}

impl Drop for Builder<'a, 'll, 'tcx> {
    fn drop(&mut self) {
        unsafe {
            llvm::LLVMDisposeBuilder(&mut *(self.llbuilder as *mut _));
        }
    }
}

// FIXME(eddyb) use a checked constructor when they become `const fn`.
const EMPTY_C_STR: &CStr = unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") };

/// Empty string, to be used where LLVM expects an instruction name, indicating
/// that the instruction is to be left unnamed (i.e. numbered, in textual IR).
// FIXME(eddyb) pass `&CStr` directly to FFI once it's a thin pointer.
const UNNAMED: *const c_char = EMPTY_C_STR.as_ptr();

impl BackendTypes for Builder<'_, 'll, 'tcx> {
    type Value = <CodegenCx<'ll, 'tcx> as BackendTypes>::Value;
    type Function = <CodegenCx<'ll, 'tcx> as BackendTypes>::Function;
    type BasicBlock = <CodegenCx<'ll, 'tcx> as BackendTypes>::BasicBlock;
    type Type = <CodegenCx<'ll, 'tcx> as BackendTypes>::Type;
    type Funclet = <CodegenCx<'ll, 'tcx> as BackendTypes>::Funclet;

    type DIScope = <CodegenCx<'ll, 'tcx> as BackendTypes>::DIScope;
    type DILocation = <CodegenCx<'ll, 'tcx> as BackendTypes>::DILocation;
    type DIVariable = <CodegenCx<'ll, 'tcx> as BackendTypes>::DIVariable;
}

impl abi::HasDataLayout for Builder<'_, '_, '_> {
    fn data_layout(&self) -> &abi::TargetDataLayout {
        self.cx.data_layout()
    }
}

impl ty::layout::HasTyCtxt<'tcx> for Builder<'_, '_, 'tcx> {
    fn tcx(&self) -> TyCtxt<'tcx> {
        self.cx.tcx
    }
}

impl ty::layout::HasParamEnv<'tcx> for Builder<'_, '_, 'tcx> {
    fn param_env(&self) -> ty::ParamEnv<'tcx> {
        self.cx.param_env()
    }
}

impl HasTargetSpec for Builder<'_, '_, 'tcx> {
    fn target_spec(&self) -> &Target {
        &self.cx.target_spec()
    }
}

impl abi::LayoutOf for Builder<'_, '_, 'tcx> {
    type Ty = Ty<'tcx>;
    type TyAndLayout = TyAndLayout<'tcx>;

    fn layout_of(&self, ty: Ty<'tcx>) -> Self::TyAndLayout {
        self.cx.layout_of(ty)
    }
}

impl Deref for Builder<'_, 'll, 'tcx> {
    type Target = CodegenCx<'ll, 'tcx>;

    fn deref(&self) -> &Self::Target {
        self.cx
    }
}

impl HasCodegen<'tcx> for Builder<'_, 'll, 'tcx> {
    type CodegenCx = CodegenCx<'ll, 'tcx>;
}

macro_rules! builder_methods_for_value_instructions {
    ($($name:ident($($arg:ident),*) => $llvm_capi:ident),+ $(,)?) => {
        $(fn $name(&mut self, $($arg: &'ll Value),*) -> &'ll Value {
            unsafe {
                llvm::$llvm_capi(self.llbuilder, $($arg,)* UNNAMED)
            }
        })+
    }
}

impl BuilderMethods<'a, 'tcx> for Builder<'a, 'll, 'tcx> {
    fn new_block<'b>(cx: &'a CodegenCx<'ll, 'tcx>, llfn: &'ll Value, name: &'b str) -> Self {
        let mut bx = Builder::with_cx(cx);
        let llbb = unsafe {
            let name = SmallCStr::new(name);
            llvm::LLVMAppendBasicBlockInContext(cx.llcx, llfn, name.as_ptr())
        };
        bx.position_at_end(llbb);
        bx
    }

    fn set_in_unsafe(&mut self, unsafety: bool){
        self.in_unsafe = unsafety;
    }

    fn with_cx(cx: &'a CodegenCx<'ll, 'tcx>) -> Self {
        // Create a fresh builder from the crate context.
        let llbuilder = unsafe { llvm::LLVMCreateBuilderInContext(cx.llcx) };
        Builder { llbuilder, cx,  in_unsafe:false }
    }

    fn build_sibling_block(&self, name: &str) -> Self {
        Builder::new_block(self.cx, self.llfn(), name)
    }

    fn llbb(&self) -> &'ll BasicBlock {
        unsafe { llvm::LLVMGetInsertBlock(self.llbuilder) }
    }

    fn set_span(&mut self, _span: Span) {}

    fn position_at_end(&mut self, llbb: &'ll BasicBlock) {
        unsafe {
            llvm::LLVMPositionBuilderAtEnd(self.llbuilder, llbb);
        }
    }

    fn ret_void(&mut self) {
        unsafe {
            llvm::LLVMBuildRetVoid(self.llbuilder);
        }
    }

    fn ret(&mut self, v: &'ll Value) {
        unsafe {
            llvm::LLVMBuildRet(self.llbuilder, v);
        }
    }

    fn br(&mut self, dest: &'ll BasicBlock) {
        unsafe {
            llvm::LLVMBuildBr(self.llbuilder, dest);
        }
    }

    fn cond_br(
        &mut self,
        cond: &'ll Value,
        then_llbb: &'ll BasicBlock,
        else_llbb: &'ll BasicBlock,
    ) {
        unsafe {
            llvm::LLVMBuildCondBr(self.llbuilder, cond, then_llbb, else_llbb);
        }
    }

    fn switch(
        &mut self,
        v: &'ll Value,
        else_llbb: &'ll BasicBlock,
        cases: impl ExactSizeIterator<Item = (u128, &'ll BasicBlock)>,
    ) {
        let switch =
            unsafe { llvm::LLVMBuildSwitch(self.llbuilder, v, else_llbb, cases.len() as c_uint) };
        for (on_val, dest) in cases {
            let on_val = self.const_uint_big(self.val_ty(v), on_val);
            unsafe { llvm::LLVMAddCase(switch, on_val, dest) }
        }
    }

    fn invoke(
        &mut self,
        llfn: &'ll Value,
        args: &[&'ll Value],
        then: &'ll BasicBlock,
        catch: &'ll BasicBlock,
        funclet: Option<&Funclet<'ll>>,
    ) -> &'ll Value {
        debug!("invoke {:?} with args ({:?})", llfn, args);

        let args = self.check_call("invoke", llfn, args);
        let bundle = funclet.map(|funclet| funclet.bundle());
        let bundle = bundle.as_ref().map(|b| &*b.raw);

        unsafe {
            let instr = llvm::LLVMRustBuildInvoke(
                self.llbuilder,
                llfn,
                args.as_ptr(),
                args.len() as c_uint,
                then,
                catch,
                bundle,
                UNNAMED,
            );
            if self.in_unsafe {
                llvm::LLVMSetInUnsafeMetadata(instr);
            }
            instr
        }
    }

    fn unreachable(&mut self) {
        unsafe {
            llvm::LLVMBuildUnreachable(self.llbuilder);
        }
    }

    builder_methods_for_value_instructions! {
        add(a, b) => LLVMBuildAdd,
        fadd(a, b) => LLVMBuildFAdd,
        sub(a, b) => LLVMBuildSub,
        fsub(a, b) => LLVMBuildFSub,
        mul(a, b) => LLVMBuildMul,
        fmul(a, b) => LLVMBuildFMul,
        udiv(a, b) => LLVMBuildUDiv,
        exactudiv(a, b) => LLVMBuildExactUDiv,
        sdiv(a, b) => LLVMBuildSDiv,
        exactsdiv(a, b) => LLVMBuildExactSDiv,
        fdiv(a, b) => LLVMBuildFDiv,
        urem(a, b) => LLVMBuildURem,
        srem(a, b) => LLVMBuildSRem,
        frem(a, b) => LLVMBuildFRem,
        shl(a, b) => LLVMBuildShl,
        lshr(a, b) => LLVMBuildLShr,
        ashr(a, b) => LLVMBuildAShr,
        and(a, b) => LLVMBuildAnd,
        or(a, b) => LLVMBuildOr,
        xor(a, b) => LLVMBuildXor,
        neg(x) => LLVMBuildNeg,
        fneg(x) => LLVMBuildFNeg,
        not(x) => LLVMBuildNot,
        unchecked_sadd(x, y) => LLVMBuildNSWAdd,
        unchecked_uadd(x, y) => LLVMBuildNUWAdd,
        unchecked_ssub(x, y) => LLVMBuildNSWSub,
        unchecked_usub(x, y) => LLVMBuildNUWSub,
        unchecked_smul(x, y) => LLVMBuildNSWMul,
        unchecked_umul(x, y) => LLVMBuildNUWMul,
    }

    fn fadd_fast(&mut self, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        unsafe {
            let instr = llvm::LLVMBuildFAdd(self.llbuilder, lhs, rhs, UNNAMED);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }

    fn fsub_fast(&mut self, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        unsafe {
            let instr = llvm::LLVMBuildFSub(self.llbuilder, lhs, rhs, UNNAMED);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }

    fn fmul_fast(&mut self, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        unsafe {
            let instr = llvm::LLVMBuildFMul(self.llbuilder, lhs, rhs, UNNAMED);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }

    fn fdiv_fast(&mut self, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        unsafe {
            let instr = llvm::LLVMBuildFDiv(self.llbuilder, lhs, rhs, UNNAMED);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }

    fn frem_fast(&mut self, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        unsafe {
            let instr = llvm::LLVMBuildFRem(self.llbuilder, lhs, rhs, UNNAMED);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }

    fn checked_binop(
        &mut self,
        oop: OverflowOp,
        ty: Ty<'_>,
        lhs: Self::Value,
        rhs: Self::Value,
    ) -> (Self::Value, Self::Value) {
        use rustc_ast::IntTy::*;
        use rustc_ast::UintTy::*;
        use rustc_middle::ty::{Int, Uint};

        let new_kind = match ty.kind() {
            Int(t @ Isize) => Int(t.normalize(self.tcx.sess.target.pointer_width)),
            Uint(t @ Usize) => Uint(t.normalize(self.tcx.sess.target.pointer_width)),
            t @ (Uint(_) | Int(_)) => t.clone(),
            _ => panic!("tried to get overflow intrinsic for op applied to non-int type"),
        };

        let name = match oop {
            OverflowOp::Add => match new_kind {
                Int(I8) => "llvm.sadd.with.overflow.i8",
                Int(I16) => "llvm.sadd.with.overflow.i16",
                Int(I32) => "llvm.sadd.with.overflow.i32",
                Int(I64) => "llvm.sadd.with.overflow.i64",
                Int(I128) => "llvm.sadd.with.overflow.i128",

                Uint(U8) => "llvm.uadd.with.overflow.i8",
                Uint(U16) => "llvm.uadd.with.overflow.i16",
                Uint(U32) => "llvm.uadd.with.overflow.i32",
                Uint(U64) => "llvm.uadd.with.overflow.i64",
                Uint(U128) => "llvm.uadd.with.overflow.i128",

                _ => unreachable!(),
            },
            OverflowOp::Sub => match new_kind {
                Int(I8) => "llvm.ssub.with.overflow.i8",
                Int(I16) => "llvm.ssub.with.overflow.i16",
                Int(I32) => "llvm.ssub.with.overflow.i32",
                Int(I64) => "llvm.ssub.with.overflow.i64",
                Int(I128) => "llvm.ssub.with.overflow.i128",

                Uint(U8) => "llvm.usub.with.overflow.i8",
                Uint(U16) => "llvm.usub.with.overflow.i16",
                Uint(U32) => "llvm.usub.with.overflow.i32",
                Uint(U64) => "llvm.usub.with.overflow.i64",
                Uint(U128) => "llvm.usub.with.overflow.i128",

                _ => unreachable!(),
            },
            OverflowOp::Mul => match new_kind {
                Int(I8) => "llvm.smul.with.overflow.i8",
                Int(I16) => "llvm.smul.with.overflow.i16",
                Int(I32) => "llvm.smul.with.overflow.i32",
                Int(I64) => "llvm.smul.with.overflow.i64",
                Int(I128) => "llvm.smul.with.overflow.i128",

                Uint(U8) => "llvm.umul.with.overflow.i8",
                Uint(U16) => "llvm.umul.with.overflow.i16",
                Uint(U32) => "llvm.umul.with.overflow.i32",
                Uint(U64) => "llvm.umul.with.overflow.i64",
                Uint(U128) => "llvm.umul.with.overflow.i128",

                _ => unreachable!(),
            },
        };

        let intrinsic = self.get_intrinsic(&name);
        let res = self.call(intrinsic, &[lhs, rhs], None);
        (self.extract_value(res, 0), self.extract_value(res, 1))
    }

    fn from_immediate(&mut self, val: Self::Value) -> Self::Value {
        if self.cx().val_ty(val) == self.cx().type_i1() {
            self.zext(val, self.cx().type_i8())
        } else {
            val
        }
    }
    fn to_immediate_scalar(&mut self, val: Self::Value, scalar: &abi::Scalar) -> Self::Value {
        if scalar.is_bool() {
            return self.trunc(val, self.cx().type_i1());
        }
        val
    }

    fn alloca(&mut self, ty: &'ll Type, align: Align) -> &'ll Value {
        let mut bx = Builder::with_cx(self.cx);
        bx.position_at_start(unsafe { llvm::LLVMGetFirstBasicBlock(self.llfn()) });
        let instr = bx.dynamic_alloca(ty, align);
        if self.in_unsafe {
            unsafe {
                llvm::LLVMSetInUnsafeMetadata(instr);
            }
        }
        instr
    }

    fn dynamic_alloca(&mut self, ty: &'ll Type, align: Align) -> &'ll Value {
        unsafe {
            let alloca = llvm::LLVMBuildAlloca(self.llbuilder, ty, UNNAMED);
            llvm::LLVMSetAlignment(alloca, align.bytes() as c_uint);
            alloca
        }
    }

    fn array_alloca(&mut self, ty: &'ll Type, len: &'ll Value, align: Align) -> &'ll Value {
        unsafe {
            let alloca = llvm::LLVMBuildArrayAlloca(self.llbuilder, ty, len, UNNAMED);
            llvm::LLVMSetAlignment(alloca, align.bytes() as c_uint);
            alloca
        }
    }

    fn load(&mut self, ptr: &'ll Value, align: Align) -> &'ll Value {
        unsafe {
            let load = llvm::LLVMBuildLoad(self.llbuilder, ptr, UNNAMED);
            llvm::LLVMSetAlignment(load, align.bytes() as c_uint);
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(load);
            }
            load
        }
    }

    fn volatile_load(&mut self, ptr: &'ll Value) -> &'ll Value {
        unsafe {
            let load = llvm::LLVMBuildLoad(self.llbuilder, ptr, UNNAMED);
            llvm::LLVMSetVolatile(load, llvm::True);
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(load);
            }
            load
        }
    }

    fn atomic_load(
        &mut self,
        ptr: &'ll Value,
        order: rustc_codegen_ssa::common::AtomicOrdering,
        size: Size,
    ) -> &'ll Value {
        unsafe {
            let load = llvm::LLVMRustBuildAtomicLoad(
                self.llbuilder,
                ptr,
                UNNAMED,
                AtomicOrdering::from_generic(order),
            );
            // LLVM requires the alignment of atomic loads to be at least the size of the type.
            llvm::LLVMSetAlignment(load, size.bytes() as c_uint);
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(load);
            }
            load
        }
    }

    fn load_operand(&mut self, place: PlaceRef<'tcx, &'ll Value>) -> OperandRef<'tcx, &'ll Value> {
        debug!("PlaceRef::load: {:?}", place);

        assert_eq!(place.llextra.is_some(), place.layout.is_unsized());

        if place.layout.is_zst() {
            return OperandRef::new_zst(self, place.layout);
        }

        fn scalar_load_metadata<'a, 'll, 'tcx>(
            bx: &mut Builder<'a, 'll, 'tcx>,
            load: &'ll Value,
            scalar: &abi::Scalar,
        ) {
            let vr = scalar.valid_range.clone();
            match scalar.value {
                abi::Int(..) => {
                    let range = scalar.valid_range_exclusive(bx);
                    if range.start != range.end {
                        bx.range_metadata(load, range);
                    }
                }
                abi::Pointer if vr.start() < vr.end() && !vr.contains(&0) => {
                    bx.nonnull_metadata(load);
                }
                _ => {}
            }
        }

        let val = if let Some(llextra) = place.llextra {
            OperandValue::Ref(place.llval, Some(llextra), place.align)
        } else if place.layout.is_llvm_immediate() {
            let mut const_llval = None;
            unsafe {
                if let Some(global) = llvm::LLVMIsAGlobalVariable(place.llval) {
                    if llvm::LLVMIsGlobalConstant(global) == llvm::True {
                        const_llval = llvm::LLVMGetInitializer(global);
                    }
                }
            }
            let llval = const_llval.unwrap_or_else(|| {
                let load = self.load(place.llval, place.align);
                if let abi::Abi::Scalar(ref scalar) = place.layout.abi {
                    scalar_load_metadata(self, load, scalar);
                }
                load
            });
            OperandValue::Immediate(self.to_immediate(llval, place.layout))
        } else if let abi::Abi::ScalarPair(ref a, ref b) = place.layout.abi {
            let b_offset = a.value.size(self).align_to(b.value.align(self).abi);

            let mut load = |i, scalar: &abi::Scalar, align| {
                let llptr = self.struct_gep(place.llval, i as u64);
                let load = self.load(llptr, align);
                scalar_load_metadata(self, load, scalar);
                self.to_immediate_scalar(load, scalar)
            };

            OperandValue::Pair(
                load(0, a, place.align),
                load(1, b, place.align.restrict_for_offset(b_offset)),
            )
        } else {
            OperandValue::Ref(place.llval, None, place.align)
        };

        OperandRef { val, layout: place.layout }
    }

    fn write_operand_repeatedly(
        mut self,
        cg_elem: OperandRef<'tcx, &'ll Value>,
        count: u64,
        dest: PlaceRef<'tcx, &'ll Value>,
    ) -> Self {
        let zero = self.const_usize(0);
        let count = self.const_usize(count);
        let start = dest.project_index(&mut self, zero).llval;
        let end = dest.project_index(&mut self, count).llval;

        let mut header_bx = self.build_sibling_block("repeat_loop_header");
        let mut body_bx = self.build_sibling_block("repeat_loop_body");
        let next_bx = self.build_sibling_block("repeat_loop_next");

        self.br(header_bx.llbb());
        let current = header_bx.phi(self.val_ty(start), &[start], &[self.llbb()]);

        let keep_going = header_bx.icmp(IntPredicate::IntNE, current, end);
        header_bx.cond_br(keep_going, body_bx.llbb(), next_bx.llbb());

        let align = dest.align.restrict_for_offset(dest.layout.field(self.cx(), 0).size);
        cg_elem
            .val
            .store(&mut body_bx, PlaceRef::new_sized_aligned(current, cg_elem.layout, align));

        let next = body_bx.inbounds_gep(current, &[self.const_usize(1)]);
        body_bx.br(header_bx.llbb());
        header_bx.add_incoming_to_phi(current, next, body_bx.llbb());

        next_bx
    }

    fn range_metadata(&mut self, load: &'ll Value, range: Range<u128>) {
        if self.sess().target.arch == "amdgpu" {
            // amdgpu/LLVM does something weird and thinks a i64 value is
            // split into a v2i32, halving the bitwidth LLVM expects,
            // tripping an assertion. So, for now, just disable this
            // optimization.
            return;
        }

        unsafe {
            let llty = self.cx.val_ty(load);
            let v = [
                self.cx.const_uint_big(llty, range.start),
                self.cx.const_uint_big(llty, range.end),
            ];

            llvm::LLVMSetMetadata(
                load,
                llvm::MD_range as c_uint,
                llvm::LLVMMDNodeInContext(self.cx.llcx, v.as_ptr(), v.len() as c_uint),
            );
        }
    }

    fn nonnull_metadata(&mut self, load: &'ll Value) {
        unsafe {
            llvm::LLVMSetMetadata(
                load,
                llvm::MD_nonnull as c_uint,
                llvm::LLVMMDNodeInContext(self.cx.llcx, ptr::null(), 0),
            );
        }
    }

    fn store(&mut self, val: &'ll Value, ptr: &'ll Value, align: Align) -> &'ll Value {
        self.store_with_flags(val, ptr, align, MemFlags::empty())
    }

    fn store_with_flags(
        &mut self,
        val: &'ll Value,
        ptr: &'ll Value,
        align: Align,
        flags: MemFlags,
    ) -> &'ll Value {
        debug!("Store {:?} -> {:?} ({:?})", val, ptr, flags);
        let ptr = self.check_store(val, ptr);
        unsafe {
            let store = llvm::LLVMBuildStore(self.llbuilder, val, ptr);
            let align =
                if flags.contains(MemFlags::UNALIGNED) { 1 } else { align.bytes() as c_uint };
            llvm::LLVMSetAlignment(store, align);
            if flags.contains(MemFlags::VOLATILE) {
                llvm::LLVMSetVolatile(store, llvm::True);
            }
            if flags.contains(MemFlags::NONTEMPORAL) {
                // According to LLVM [1] building a nontemporal store must
                // *always* point to a metadata value of the integer 1.
                //
                // [1]: http://llvm.org/docs/LangRef.html#store-instruction
                let one = self.cx.const_i32(1);
                let node = llvm::LLVMMDNodeInContext(self.cx.llcx, &one, 1);
                llvm::LLVMSetMetadata(store, llvm::MD_nontemporal as c_uint, node);
            }
            if self.in_unsafe {
                llvm::LLVMSetInUnsafeMetadata(store);
            }
            store
        }
    }

    // fn set_in_unsafe_metadata(
    //     val: &'ll Value,
    // ){
    //     unsafe{
    //         let named_metadata = llvm::LLVMMDStringInContext(
    //             self.cx.llcx,
    //             const_cstr!("mpk-unsafe").as_ptr(),
    //             10,
    //         );
    //     }
    // }

    fn atomic_store(
        &mut self,
        val: &'ll Value,
        ptr: &'ll Value,
        order: rustc_codegen_ssa::common::AtomicOrdering,
        size: Size,
    ) {
        debug!("Store {:?} -> {:?}", val, ptr);
        let ptr = self.check_store(val, ptr);
        unsafe {
            let store = llvm::LLVMRustBuildAtomicStore(
                self.llbuilder,
                val,
                ptr,
                AtomicOrdering::from_generic(order),
            );
            // LLVM requires the alignment of atomic stores to be at least the size of the type.
            llvm::LLVMSetAlignment(store, size.bytes() as c_uint);
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(store);
            }
        }
    }

    fn gep(&mut self, ptr: &'ll Value, indices: &[&'ll Value]) -> &'ll Value {
        unsafe {
            llvm::LLVMBuildGEP(
                self.llbuilder,
                ptr,
                indices.as_ptr(),
                indices.len() as c_uint,
                UNNAMED,
            )
        }
    }

    fn inbounds_gep(&mut self, ptr: &'ll Value, indices: &[&'ll Value]) -> &'ll Value {
        unsafe {
            llvm::LLVMBuildInBoundsGEP(
                self.llbuilder,
                ptr,
                indices.as_ptr(),
                indices.len() as c_uint,
                UNNAMED,
            )
        }
    }

    fn struct_gep(&mut self, ptr: &'ll Value, idx: u64) -> &'ll Value {
        assert_eq!(idx as c_uint as u64, idx);
        unsafe { llvm::LLVMBuildStructGEP(self.llbuilder, ptr, idx as c_uint, UNNAMED) }
    }

    /* Casts */
    fn trunc(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildTrunc(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn sext(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildSExt(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn fptoui_sat(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> Option<&'ll Value> {
        // WebAssembly has saturating floating point to integer casts if the
        // `nontrapping-fptoint` target feature is activated. We'll use those if
        // they are available.
        if self.sess().target.arch == "wasm32"
            && self.sess().target_features.contains(&sym::nontrapping_dash_fptoint)
        {
            let src_ty = self.cx.val_ty(val);
            let float_width = self.cx.float_width(src_ty);
            let int_width = self.cx.int_width(dest_ty);
            let name = match (int_width, float_width) {
                (32, 32) => Some("llvm.wasm.trunc.saturate.unsigned.i32.f32"),
                (32, 64) => Some("llvm.wasm.trunc.saturate.unsigned.i32.f64"),
                (64, 32) => Some("llvm.wasm.trunc.saturate.unsigned.i64.f32"),
                (64, 64) => Some("llvm.wasm.trunc.saturate.unsigned.i64.f64"),
                _ => None,
            };
            if let Some(name) = name {
                let intrinsic = self.get_intrinsic(name);
                return Some(self.call(intrinsic, &[val], None));
            }
        }
        None
    }

    fn fptosi_sat(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> Option<&'ll Value> {
        // WebAssembly has saturating floating point to integer casts if the
        // `nontrapping-fptoint` target feature is activated. We'll use those if
        // they are available.
        if self.sess().target.arch == "wasm32"
            && self.sess().target_features.contains(&sym::nontrapping_dash_fptoint)
        {
            let src_ty = self.cx.val_ty(val);
            let float_width = self.cx.float_width(src_ty);
            let int_width = self.cx.int_width(dest_ty);
            let name = match (int_width, float_width) {
                (32, 32) => Some("llvm.wasm.trunc.saturate.signed.i32.f32"),
                (32, 64) => Some("llvm.wasm.trunc.saturate.signed.i32.f64"),
                (64, 32) => Some("llvm.wasm.trunc.saturate.signed.i64.f32"),
                (64, 64) => Some("llvm.wasm.trunc.saturate.signed.i64.f64"),
                _ => None,
            };
            if let Some(name) = name {
                let intrinsic = self.get_intrinsic(name);
                return Some(self.call(intrinsic, &[val], None));
            }
        }
        None
    }

    fn fptosui_may_trap(&self, val: &'ll Value, dest_ty: &'ll Type) -> bool {
        // Most of the time we'll be generating the `fptosi` or `fptoui`
        // instruction for floating-point-to-integer conversions. These
        // instructions by definition in LLVM do not trap. For the WebAssembly
        // target, however, we'll lower in some cases to intrinsic calls instead
        // which may trap. If we detect that this is a situation where we'll be
        // using the intrinsics then we report that the call map trap, which
        // callers might need to handle.
        if !self.wasm_and_missing_nontrapping_fptoint() {
            return false;
        }
        let src_ty = self.cx.val_ty(val);
        let float_width = self.cx.float_width(src_ty);
        let int_width = self.cx.int_width(dest_ty);
        matches!((int_width, float_width), (32, 32) | (32, 64) | (64, 32) | (64, 64))
    }

    fn fptoui(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        // When we can, use the native wasm intrinsics which have tighter
        // codegen. Note that this has a semantic difference in that the
        // intrinsic can trap whereas `fptoui` never traps. That difference,
        // however, is handled by `fptosui_may_trap` above.
        //
        // Note that we skip the wasm intrinsics for vector types where `fptoui`
        // must be used instead.
        if self.wasm_and_missing_nontrapping_fptoint() {
            let src_ty = self.cx.val_ty(val);
            if self.cx.type_kind(src_ty) != TypeKind::Vector {
                let float_width = self.cx.float_width(src_ty);
                let int_width = self.cx.int_width(dest_ty);
                let name = match (int_width, float_width) {
                    (32, 32) => Some("llvm.wasm.trunc.unsigned.i32.f32"),
                    (32, 64) => Some("llvm.wasm.trunc.unsigned.i32.f64"),
                    (64, 32) => Some("llvm.wasm.trunc.unsigned.i64.f32"),
                    (64, 64) => Some("llvm.wasm.trunc.unsigned.i64.f64"),
                    _ => None,
                };
                if let Some(name) = name {
                    let intrinsic = self.get_intrinsic(name);
                    return self.call(intrinsic, &[val], None);
                }
            }
        }
        unsafe { llvm::LLVMBuildFPToUI(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn fptosi(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        if self.wasm_and_missing_nontrapping_fptoint() {
            let src_ty = self.cx.val_ty(val);
            if self.cx.type_kind(src_ty) != TypeKind::Vector {
                let float_width = self.cx.float_width(src_ty);
                let int_width = self.cx.int_width(dest_ty);
                let name = match (int_width, float_width) {
                    (32, 32) => Some("llvm.wasm.trunc.signed.i32.f32"),
                    (32, 64) => Some("llvm.wasm.trunc.signed.i32.f64"),
                    (64, 32) => Some("llvm.wasm.trunc.signed.i64.f32"),
                    (64, 64) => Some("llvm.wasm.trunc.signed.i64.f64"),
                    _ => None,
                };
                if let Some(name) = name {
                    let intrinsic = self.get_intrinsic(name);
                    return self.call(intrinsic, &[val], None);
                }
            }
        }
        unsafe { llvm::LLVMBuildFPToSI(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn uitofp(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildUIToFP(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn sitofp(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildSIToFP(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn fptrunc(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildFPTrunc(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn fpext(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildFPExt(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn ptrtoint(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildPtrToInt(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn inttoptr(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildIntToPtr(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn bitcast(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildBitCast(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    fn intcast(&mut self, val: &'ll Value, dest_ty: &'ll Type, is_signed: bool) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildIntCast(self.llbuilder, val, dest_ty, is_signed) }
    }

    fn pointercast(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildPointerCast(self.llbuilder, val, dest_ty, UNNAMED) }
    }

    /* Comparisons */
    fn icmp(&mut self, op: IntPredicate, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        let op = llvm::IntPredicate::from_generic(op);
        unsafe { llvm::LLVMBuildICmp(self.llbuilder, op as c_uint, lhs, rhs, UNNAMED) }
    }

    fn fcmp(&mut self, op: RealPredicate, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMBuildFCmp(self.llbuilder, op as c_uint, lhs, rhs, UNNAMED) }
    }

    /* Miscellaneous instructions */
    fn memcpy(
        &mut self,
        dst: &'ll Value,
        dst_align: Align,
        src: &'ll Value,
        src_align: Align,
        size: &'ll Value,
        flags: MemFlags,
    ) {
        if flags.contains(MemFlags::NONTEMPORAL) {
            // HACK(nox): This is inefficient but there is no nontemporal memcpy.
            let val = self.load(src, src_align);
            let ptr = self.pointercast(dst, self.type_ptr_to(self.val_ty(val)));
            self.store_with_flags(val, ptr, dst_align, flags);
            return;
        }
        let size = self.intcast(size, self.type_isize(), false);
        let is_volatile = flags.contains(MemFlags::VOLATILE);
        let dst = self.pointercast(dst, self.type_i8p());
        let src = self.pointercast(src, self.type_i8p());
        unsafe {
            let instr = llvm::LLVMRustBuildMemCpy(
                self.llbuilder,
                dst,
                dst_align.bytes() as c_uint,
                src,
                src_align.bytes() as c_uint,
                size,
                is_volatile,
            );
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(instr);
            }
        }
    }

    fn memmove(
        &mut self,
        dst: &'ll Value,
        dst_align: Align,
        src: &'ll Value,
        src_align: Align,
        size: &'ll Value,
        flags: MemFlags,
    ) {
        if flags.contains(MemFlags::NONTEMPORAL) {
            // HACK(nox): This is inefficient but there is no nontemporal memmove.
            let val = self.load(src, src_align);
            let ptr = self.pointercast(dst, self.type_ptr_to(self.val_ty(val)));
            self.store_with_flags(val, ptr, dst_align, flags);
            return;
        }
        let size = self.intcast(size, self.type_isize(), false);
        let is_volatile = flags.contains(MemFlags::VOLATILE);
        let dst = self.pointercast(dst, self.type_i8p());
        let src = self.pointercast(src, self.type_i8p());
        unsafe {
            let instr = llvm::LLVMRustBuildMemMove(
                self.llbuilder,
                dst,
                dst_align.bytes() as c_uint,
                src,
                src_align.bytes() as c_uint,
                size,
                is_volatile,
            );
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(instr);
            }
        }
    }

    fn memset(
        &mut self,
        ptr: &'ll Value,
        fill_byte: &'ll Value,
        size: &'ll Value,
        align: Align,
        flags: MemFlags,
    ) {
        let is_volatile = flags.contains(MemFlags::VOLATILE);
        let ptr = self.pointercast(ptr, self.type_i8p());
        unsafe {
            let instr = llvm::LLVMRustBuildMemSet(
                self.llbuilder,
                ptr,
                align.bytes() as c_uint,
                fill_byte,
                size,
                is_volatile,
            );
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(instr);
            }
        }
    }

    fn select(
        &mut self,
        cond: &'ll Value,
        then_val: &'ll Value,
        else_val: &'ll Value,
    ) -> &'ll Value {
        unsafe { llvm::LLVMBuildSelect(self.llbuilder, cond, then_val, else_val, UNNAMED) }
    }

    fn va_arg(&mut self, list: &'ll Value, ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildVAArg(self.llbuilder, list, ty, UNNAMED) }
    }

    fn extract_element(&mut self, vec: &'ll Value, idx: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMBuildExtractElement(self.llbuilder, vec, idx, UNNAMED) }
    }

    fn vector_splat(&mut self, num_elts: usize, elt: &'ll Value) -> &'ll Value {
        unsafe {
            let elt_ty = self.cx.val_ty(elt);
            let undef = llvm::LLVMGetUndef(self.type_vector(elt_ty, num_elts as u64));
            let vec = self.insert_element(undef, elt, self.cx.const_i32(0));
            let vec_i32_ty = self.type_vector(self.type_i32(), num_elts as u64);
            self.shuffle_vector(vec, undef, self.const_null(vec_i32_ty))
        }
    }

    fn extract_value(&mut self, agg_val: &'ll Value, idx: u64) -> &'ll Value {
        assert_eq!(idx as c_uint as u64, idx);
        unsafe { llvm::LLVMBuildExtractValue(self.llbuilder, agg_val, idx as c_uint, UNNAMED) }
    }

    fn insert_value(&mut self, agg_val: &'ll Value, elt: &'ll Value, idx: u64) -> &'ll Value {
        assert_eq!(idx as c_uint as u64, idx);
        unsafe { llvm::LLVMBuildInsertValue(self.llbuilder, agg_val, elt, idx as c_uint, UNNAMED) }
    }

    fn landing_pad(
        &mut self,
        ty: &'ll Type,
        pers_fn: &'ll Value,
        num_clauses: usize,
    ) -> &'ll Value {
        unsafe {
            llvm::LLVMBuildLandingPad(self.llbuilder, ty, pers_fn, num_clauses as c_uint, UNNAMED)
        }
    }

    fn set_cleanup(&mut self, landing_pad: &'ll Value) {
        unsafe {
            llvm::LLVMSetCleanup(landing_pad, llvm::True);
        }
    }

    fn resume(&mut self, exn: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMBuildResume(self.llbuilder, exn) }
    }

    fn cleanup_pad(&mut self, parent: Option<&'ll Value>, args: &[&'ll Value]) -> Funclet<'ll> {
        let name = const_cstr!("cleanuppad");
        let ret = unsafe {
            llvm::LLVMRustBuildCleanupPad(
                self.llbuilder,
                parent,
                args.len() as c_uint,
                args.as_ptr(),
                name.as_ptr(),
            )
        };
        Funclet::new(ret.expect("LLVM does not have support for cleanuppad"))
    }

    fn cleanup_ret(
        &mut self,
        funclet: &Funclet<'ll>,
        unwind: Option<&'ll BasicBlock>,
    ) -> &'ll Value {
        let ret =
            unsafe { llvm::LLVMRustBuildCleanupRet(self.llbuilder, funclet.cleanuppad(), unwind) };
        ret.expect("LLVM does not have support for cleanupret")
    }

    fn catch_pad(&mut self, parent: &'ll Value, args: &[&'ll Value]) -> Funclet<'ll> {
        let name = const_cstr!("catchpad");
        let ret = unsafe {
            llvm::LLVMRustBuildCatchPad(
                self.llbuilder,
                parent,
                args.len() as c_uint,
                args.as_ptr(),
                name.as_ptr(),
            )
        };
        Funclet::new(ret.expect("LLVM does not have support for catchpad"))
    }

    fn catch_switch(
        &mut self,
        parent: Option<&'ll Value>,
        unwind: Option<&'ll BasicBlock>,
        num_handlers: usize,
    ) -> &'ll Value {
        let name = const_cstr!("catchswitch");
        let ret = unsafe {
            llvm::LLVMRustBuildCatchSwitch(
                self.llbuilder,
                parent,
                unwind,
                num_handlers as c_uint,
                name.as_ptr(),
            )
        };
        ret.expect("LLVM does not have support for catchswitch")
    }

    fn add_handler(&mut self, catch_switch: &'ll Value, handler: &'ll BasicBlock) {
        unsafe {
            llvm::LLVMRustAddHandler(catch_switch, handler);
        }
    }

    fn set_personality_fn(&mut self, personality: &'ll Value) {
        unsafe {
            llvm::LLVMSetPersonalityFn(self.llfn(), personality);
        }
    }

    // Atomic Operations
    fn atomic_cmpxchg(
        &mut self,
        dst: &'ll Value,
        cmp: &'ll Value,
        src: &'ll Value,
        order: rustc_codegen_ssa::common::AtomicOrdering,
        failure_order: rustc_codegen_ssa::common::AtomicOrdering,
        weak: bool,
    ) -> &'ll Value {
        let weak = if weak { llvm::True } else { llvm::False };
        unsafe {
            llvm::LLVMRustBuildAtomicCmpXchg(
                self.llbuilder,
                dst,
                cmp,
                src,
                AtomicOrdering::from_generic(order),
                AtomicOrdering::from_generic(failure_order),
                weak,
            )
        }
    }
    fn atomic_rmw(
        &mut self,
        op: rustc_codegen_ssa::common::AtomicRmwBinOp,
        dst: &'ll Value,
        src: &'ll Value,
        order: rustc_codegen_ssa::common::AtomicOrdering,
    ) -> &'ll Value {
        unsafe {
            llvm::LLVMBuildAtomicRMW(
                self.llbuilder,
                AtomicRmwBinOp::from_generic(op),
                dst,
                src,
                AtomicOrdering::from_generic(order),
                False,
            )
        }
    }

    fn atomic_fence(
        &mut self,
        order: rustc_codegen_ssa::common::AtomicOrdering,
        scope: rustc_codegen_ssa::common::SynchronizationScope,
    ) {
        unsafe {
            llvm::LLVMRustBuildAtomicFence(
                self.llbuilder,
                AtomicOrdering::from_generic(order),
                SynchronizationScope::from_generic(scope),
            );
        }
    }

    fn set_invariant_load(&mut self, load: &'ll Value) {
        unsafe {
            llvm::LLVMSetMetadata(
                load,
                llvm::MD_invariant_load as c_uint,
                llvm::LLVMMDNodeInContext(self.cx.llcx, ptr::null(), 0),
            );
        }
    }

    fn lifetime_start(&mut self, ptr: &'ll Value, size: Size) {
        self.call_lifetime_intrinsic("llvm.lifetime.start.p0i8", ptr, size);
    }

    fn lifetime_end(&mut self, ptr: &'ll Value, size: Size) {
        self.call_lifetime_intrinsic("llvm.lifetime.end.p0i8", ptr, size);
    }

    fn instrprof_increment(
        &mut self,
        fn_name: &'ll Value,
        hash: &'ll Value,
        num_counters: &'ll Value,
        index: &'ll Value,
    ) {
        debug!(
            "instrprof_increment() with args ({:?}, {:?}, {:?}, {:?})",
            fn_name, hash, num_counters, index
        );

        let llfn = unsafe { llvm::LLVMRustGetInstrProfIncrementIntrinsic(self.cx().llmod) };
        let args = &[fn_name, hash, num_counters, index];
        let args = self.check_call("call", llfn, args);

        unsafe {
            let call = llvm::LLVMRustBuildCall(
                self.llbuilder,
                llfn,
                args.as_ptr() as *const &llvm::Value,
                args.len() as c_uint,
                None,
            );
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(call);
            }
        }
    }

    fn call(
        &mut self,
        llfn: &'ll Value,
        args: &[&'ll Value],
        funclet: Option<&Funclet<'ll>>,
    ) -> &'ll Value {
        debug!("call {:?} with args ({:?})", llfn, args);

        let args = self.check_call("call", llfn, args);
        let bundle = funclet.map(|funclet| funclet.bundle());
        let bundle = bundle.as_ref().map(|b| &*b.raw);

        unsafe {
            let call = llvm::LLVMRustBuildCall(
                self.llbuilder,
                llfn,
                args.as_ptr() as *const &llvm::Value,
                args.len() as c_uint,
                bundle,
            );
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(call);
            }
            call
        }
    }

    fn zext(&mut self, val: &'ll Value, dest_ty: &'ll Type) -> &'ll Value {
        unsafe {
            let instr = llvm::LLVMBuildZExt(self.llbuilder, val, dest_ty, UNNAMED);
            if self.in_unsafe {
                LLVMSetInUnsafeMetadata(instr);
            }
            instr
        }
    }

    fn cx(&self) -> &CodegenCx<'ll, 'tcx> {
        self.cx
    }

    unsafe fn delete_basic_block(&mut self, bb: &'ll BasicBlock) {
        llvm::LLVMDeleteBasicBlock(bb);
    }

    fn do_not_inline(&mut self, llret: &'ll Value) {
        llvm::Attribute::NoInline.apply_callsite(llvm::AttributePlace::Function, llret);
    }
}

impl StaticBuilderMethods for Builder<'a, 'll, 'tcx> {
    fn get_static(&mut self, def_id: DefId) -> &'ll Value {
        // Forward to the `get_static` method of `CodegenCx`
        self.cx().get_static(def_id)
    }
}

impl Builder<'a, 'll, 'tcx> {
    pub fn llfn(&self) -> &'ll Value {
        unsafe { llvm::LLVMGetBasicBlockParent(self.llbb()) }
    }

    fn position_at_start(&mut self, llbb: &'ll BasicBlock) {
        unsafe {
            llvm::LLVMRustPositionBuilderAtStart(self.llbuilder, llbb);
        }
    }

    pub fn minnum(&mut self, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildMinNum(self.llbuilder, lhs, rhs) }
    }

    pub fn maxnum(&mut self, lhs: &'ll Value, rhs: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildMaxNum(self.llbuilder, lhs, rhs) }
    }

    pub fn insert_element(
        &mut self,
        vec: &'ll Value,
        elt: &'ll Value,
        idx: &'ll Value,
    ) -> &'ll Value {
        unsafe { llvm::LLVMBuildInsertElement(self.llbuilder, vec, elt, idx, UNNAMED) }
    }

    pub fn shuffle_vector(
        &mut self,
        v1: &'ll Value,
        v2: &'ll Value,
        mask: &'ll Value,
    ) -> &'ll Value {
        unsafe { llvm::LLVMBuildShuffleVector(self.llbuilder, v1, v2, mask, UNNAMED) }
    }

    pub fn vector_reduce_fadd(&mut self, acc: &'ll Value, src: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceFAdd(self.llbuilder, acc, src) }
    }
    pub fn vector_reduce_fmul(&mut self, acc: &'ll Value, src: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceFMul(self.llbuilder, acc, src) }
    }
    pub fn vector_reduce_fadd_fast(&mut self, acc: &'ll Value, src: &'ll Value) -> &'ll Value {
        unsafe {
            let instr = llvm::LLVMRustBuildVectorReduceFAdd(self.llbuilder, acc, src);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }
    pub fn vector_reduce_fmul_fast(&mut self, acc: &'ll Value, src: &'ll Value) -> &'ll Value {
        unsafe {
            let instr = llvm::LLVMRustBuildVectorReduceFMul(self.llbuilder, acc, src);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }
    pub fn vector_reduce_add(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceAdd(self.llbuilder, src) }
    }
    pub fn vector_reduce_mul(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceMul(self.llbuilder, src) }
    }
    pub fn vector_reduce_and(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceAnd(self.llbuilder, src) }
    }
    pub fn vector_reduce_or(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceOr(self.llbuilder, src) }
    }
    pub fn vector_reduce_xor(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceXor(self.llbuilder, src) }
    }
    pub fn vector_reduce_fmin(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe {
            llvm::LLVMRustBuildVectorReduceFMin(self.llbuilder, src, /*NoNaNs:*/ false)
        }
    }
    pub fn vector_reduce_fmax(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe {
            llvm::LLVMRustBuildVectorReduceFMax(self.llbuilder, src, /*NoNaNs:*/ false)
        }
    }
    pub fn vector_reduce_fmin_fast(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe {
            let instr =
                llvm::LLVMRustBuildVectorReduceFMin(self.llbuilder, src, /*NoNaNs:*/ true);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }
    pub fn vector_reduce_fmax_fast(&mut self, src: &'ll Value) -> &'ll Value {
        unsafe {
            let instr =
                llvm::LLVMRustBuildVectorReduceFMax(self.llbuilder, src, /*NoNaNs:*/ true);
            llvm::LLVMRustSetHasUnsafeAlgebra(instr);
            instr
        }
    }
    pub fn vector_reduce_min(&mut self, src: &'ll Value, is_signed: bool) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceMin(self.llbuilder, src, is_signed) }
    }
    pub fn vector_reduce_max(&mut self, src: &'ll Value, is_signed: bool) -> &'ll Value {
        unsafe { llvm::LLVMRustBuildVectorReduceMax(self.llbuilder, src, is_signed) }
    }

    pub fn add_clause(&mut self, landing_pad: &'ll Value, clause: &'ll Value) {
        unsafe {
            llvm::LLVMAddClause(landing_pad, clause);
        }
    }

    pub fn catch_ret(&mut self, funclet: &Funclet<'ll>, unwind: &'ll BasicBlock) -> &'ll Value {
        let ret =
            unsafe {
                let instr = llvm::LLVMRustBuildCatchRet(self.llbuilder, funclet.cleanuppad(), unwind);
                match instr {
                    None => {}
                    _ => if self.in_unsafe {
                        LLVMSetInUnsafeMetadata(instr.unwrap());
                    }
                }
                instr
            };
        ret.expect("LLVM does not have support for catchret")
    }

    fn check_store(&mut self, val: &'ll Value, ptr: &'ll Value) -> &'ll Value {
        let dest_ptr_ty = self.cx.val_ty(ptr);
        let stored_ty = self.cx.val_ty(val);
        let stored_ptr_ty = self.cx.type_ptr_to(stored_ty);

        assert_eq!(self.cx.type_kind(dest_ptr_ty), TypeKind::Pointer);

        if dest_ptr_ty == stored_ptr_ty {
            ptr
        } else {
            debug!(
                "type mismatch in store. \
                    Expected {:?}, got {:?}; inserting bitcast",
                dest_ptr_ty, stored_ptr_ty
            );
            self.bitcast(ptr, stored_ptr_ty)
        }
    }

    fn check_call<'b>(
        &mut self,
        typ: &str,
        llfn: &'ll Value,
        args: &'b [&'ll Value],
    ) -> Cow<'b, [&'ll Value]> {
        let mut fn_ty = self.cx.val_ty(llfn);
        // Strip off pointers
        while self.cx.type_kind(fn_ty) == TypeKind::Pointer {
            fn_ty = self.cx.element_type(fn_ty);
        }

        assert!(
            self.cx.type_kind(fn_ty) == TypeKind::Function,
            "builder::{} not passed a function, but {:?}",
            typ,
            fn_ty
        );

        let param_tys = self.cx.func_params_types(fn_ty);

        let all_args_match = param_tys
            .iter()
            .zip(args.iter().map(|&v| self.val_ty(v)))
            .all(|(expected_ty, actual_ty)| *expected_ty == actual_ty);

        if all_args_match {
            return Cow::Borrowed(args);
        }

        let casted_args: Vec<_> = param_tys
            .into_iter()
            .zip(args.iter())
            .enumerate()
            .map(|(i, (expected_ty, &actual_val))| {
                let actual_ty = self.val_ty(actual_val);
                if expected_ty != actual_ty {
                    debug!(
                        "type mismatch in function call of {:?}. \
                            Expected {:?} for param {}, got {:?}; injecting bitcast",
                        llfn, expected_ty, i, actual_ty
                    );
                    self.bitcast(actual_val, expected_ty)
                } else {
                    actual_val
                }
            })
            .collect();

        Cow::Owned(casted_args)
    }

    pub fn va_arg(&mut self, list: &'ll Value, ty: &'ll Type) -> &'ll Value {
        unsafe { llvm::LLVMBuildVAArg(self.llbuilder, list, ty, UNNAMED) }
    }

    fn call_lifetime_intrinsic(&mut self, intrinsic: &str, ptr: &'ll Value, size: Size) {
        let size = size.bytes();
        if size == 0 {
            return;
        }

        if !self.cx().sess().emit_lifetime_markers() {
            return;
        }

        let lifetime_intrinsic = self.cx.get_intrinsic(intrinsic);

        let ptr = self.pointercast(ptr, self.cx.type_i8p());
        self.call(lifetime_intrinsic, &[self.cx.const_u64(size), ptr], None);
    }

    pub(crate) fn phi(
        &mut self,
        ty: &'ll Type,
        vals: &[&'ll Value],
        bbs: &[&'ll BasicBlock],
    ) -> &'ll Value {
        assert_eq!(vals.len(), bbs.len());
        let phi = unsafe { llvm::LLVMBuildPhi(self.llbuilder, ty, UNNAMED) };
        unsafe {
            llvm::LLVMAddIncoming(phi, vals.as_ptr(), bbs.as_ptr(), vals.len() as c_uint);
            phi
        }
    }

    fn add_incoming_to_phi(&mut self, phi: &'ll Value, val: &'ll Value, bb: &'ll BasicBlock) {
        unsafe {
            llvm::LLVMAddIncoming(phi, &val, &bb, 1 as c_uint);
        }
    }

    fn wasm_and_missing_nontrapping_fptoint(&self) -> bool {
        self.sess().target.arch == "wasm32"
            && !self.sess().target_features.contains(&sym::nontrapping_dash_fptoint)
    }
}
