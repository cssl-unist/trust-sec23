; ModuleID = 'rand_core-d3a5120d11651af7.bc'
source_filename = "rand_core.11oeo4k5-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"core::fmt::Formatter" = type { [0 x i64], { i64, i64 }, [0 x i64], { i64, i64 }, [0 x i64], { {}*, [3 x i64]* }, [0 x i32], i32, [0 x i32], i32, [0 x i8], i8, [7 x i8] }
%"core::fmt::Arguments" = type { [0 x i64], { [0 x { [0 x i8]*, i64 }]*, i64 }, [0 x i64], { i64*, i64 }, [0 x i64], { [0 x { i8*, i64* }]*, i64 }, [0 x i64] }
%"os::OsRng" = type {}
%"core::panic::Location" = type { [0 x i64], { [0 x i8]*, i64 }, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"core::result::Result<usize, std::io::Error>" = type { [0 x i64], i64, [2 x i64] }
%"std::io::Error" = type { [0 x i64], %"std::io::error::Repr", [0 x i64] }
%"std::io::error::Repr" = type { [0 x i8], i8, [15 x i8] }
%"core::fmt::DebugTuple" = type { [0 x i64], %"core::fmt::Formatter"*, [0 x i64], i64, [0 x i8], i8, [0 x i8], i8, [6 x i8] }
%"unwind::libunwind::_Unwind_Exception" = type { [0 x i64], i64, [0 x i64], void (i32, %"unwind::libunwind::_Unwind_Exception"*)*, [0 x i64], [6 x i64], [0 x i64] }
%"unwind::libunwind::_Unwind_Context" = type { [0 x i8] }

@vtable.0 = private unnamed_addr constant { void ({ i8*, i64* }*)*, i64, i64, { i8*, i8* } ({ i8*, i64* }*)*, i64 ({ i8*, i64* }*)*, i64* ({ i8*, i64* }*)*, { [0 x i8]*, i64 } ({ i8*, i64* }*)*, { i8*, i8* } ({ i8*, i64* }*)*, i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)*, i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)* } { void ({ i8*, i64* }*)* @_ZN4core3ptr13drop_in_place17hdea4aab8a761e359E, i64 16, i64 8, { i8*, i8* } ({ i8*, i64* }*)* @"_ZN61_$LT$rand_core..error..Error$u20$as$u20$std..error..Error$GT$6source17h55a4f0b3236e47e5E", i64 ({ i8*, i64* }*)* @_ZN3std5error5Error7type_id17ha061394de7b9cd54E, i64* ({ i8*, i64* }*)* @_ZN3std5error5Error9backtrace17hb8be1fa6088c4f31E, { [0 x i8]*, i64 } ({ i8*, i64* }*)* @_ZN3std5error5Error11description17h87780e57e7850fc9E, { i8*, i8* } ({ i8*, i64* }*)* @_ZN3std5error5Error5cause17h8997cf9ed8601cb6E, i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)* @"_ZN62_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h9df079ff3e7ae672E", i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)* @"_ZN60_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h99494ce050e74d44E" }, align 8
@alloc150 = private unnamed_addr constant <{ [40 x i8] }> <{ [40 x i8] c"description() is deprecated; use Display" }>, align 1
@alloc113 = private unnamed_addr constant <{ [0 x i8] }> zeroinitializer, align 1
@alloc106 = private unnamed_addr constant <{ [15 x i8] }> <{ [15 x i8] c"Error { inner: " }>, align 1
@alloc108 = private unnamed_addr constant <{ [2 x i8] }> <{ [2 x i8] c" }" }>, align 1
@alloc107 = private unnamed_addr constant <{ i8*, [8 x i8], i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [15 x i8] }>, <{ [15 x i8] }>* @alloc106, i32 0, i32 0, i32 0), [8 x i8] c"\0F\00\00\00\00\00\00\00", i8* getelementptr inbounds (<{ [2 x i8] }>, <{ [2 x i8] }>* @alloc108, i32 0, i32 0, i32 0), [8 x i8] c"\02\00\00\00\00\00\00\00" }>, align 8
@alloc114 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [0 x i8] }>, <{ [0 x i8] }>* @alloc113, i32 0, i32 0, i32 0), [8 x i8] zeroinitializer }>, align 8
@vtable.1 = private unnamed_addr constant { void (i32*)*, i64, i64, { i8*, i8* } (i32*)*, i64 (i32*)*, i64* (i32*)*, { [0 x i8]*, i64 } (i32*)*, { i8*, i8* } (i32*)*, i1 (i32*, %"core::fmt::Formatter"*)*, i1 (i32*, %"core::fmt::Formatter"*)* } { void (i32*)* bitcast (void (i32**)* @_ZN4core3ptr13drop_in_place17h94c24941239afbb2E to void (i32*)*), i64 4, i64 4, { i8*, i8* } (i32*)* @_ZN3std5error5Error5cause17hafecdf6f69a52ff2E, i64 (i32*)* @_ZN3std5error5Error7type_id17h40192265680681f0E, i64* (i32*)* @_ZN3std5error5Error9backtrace17hee8271e7eaab3279E, { [0 x i8]*, i64 } (i32*)* @_ZN3std5error5Error11description17ha89cb2f673f7e592E, { i8*, i8* } (i32*)* @_ZN3std5error5Error5cause17hafecdf6f69a52ff2E, i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN62_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17hf2e963bf31b2e16fE", i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN60_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h38c9dcf46759f8d7E" }, align 8
@alloc119 = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"error code " }>, align 1
@alloc120 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [11 x i8] }>, <{ [11 x i8] }>* @alloc119, i32 0, i32 0, i32 0), [8 x i8] c"\0B\00\00\00\00\00\00\00" }>, align 8
@alloc125 = private unnamed_addr constant <{ [7 x i8] }> <{ [7 x i8] c"Error: " }>, align 1
@alloc126 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [7 x i8] }>, <{ [7 x i8] }>* @alloc125, i32 0, i32 0, i32 0), [8 x i8] c"\07\00\00\00\00\00\00\00" }>, align 8
@alloc168 = private unnamed_addr constant <{ [79 x i8] }> <{ [79 x i8] c"/root/.cargo/registry/src/github.com-1ecc6299db9ec823/rand_core-0.6.3/src/os.rs" }>, align 1
@alloc169 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [79 x i8] }>, <{ [79 x i8] }>* @alloc168, i32 0, i32 0, i32 0), [16 x i8] c"O\00\00\00\00\00\00\00?\00\00\00\0D\00\00\00" }>, align 8
@alloc170 = private unnamed_addr constant <{ [9 x i8] }> <{ [9 x i8] c"ErrorCode" }>, align 1
@vtable.2 = private unnamed_addr constant { void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* } { void (i32**)* @_ZN4core3ptr13drop_in_place17h94c24941239afbb2E, i64 8, i64 8, i1 (i32**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h5cbc67c247421bfaE" }, align 8
@alloc171 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"OsRng" }>, align 1

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal { [0 x i8]*, i64 } @_ZN3std5error5Error11description17h87780e57e7850fc9E({ i8*, i64* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #0 {
start:
  ret { [0 x i8]*, i64 } { [0 x i8]* bitcast (<{ [40 x i8] }>* @alloc150 to [0 x i8]*), i64 40 }
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal { [0 x i8]*, i64 } @_ZN3std5error5Error11description17ha89cb2f673f7e592E(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #0 {
start:
  ret { [0 x i8]*, i64 } { [0 x i8]* bitcast (<{ [40 x i8] }>* @alloc150 to [0 x i8]*), i64 40 }
}

; Function Attrs: nonlazybind uwtable
define internal { i8*, i8* } @_ZN3std5error5Error5cause17h8997cf9ed8601cb6E({ i8*, i64* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #1 {
start:
  %0 = bitcast { i8*, i64* }* %self to {}**
  %_2.0.i = load {}*, {}** %0, align 8, !alias.scope !2, !nonnull !5
  %1 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %self, i64 0, i32 1
  %2 = bitcast i64** %1 to { i8*, i8* } ({}*)***
  %_2.11.i = load { i8*, i8* } ({}*)**, { i8*, i8* } ({}*)*** %2, align 8, !alias.scope !2, !nonnull !5
  %3 = getelementptr inbounds { i8*, i8* } ({}*)*, { i8*, i8* } ({}*)** %_2.11.i, i64 3
  %4 = load { i8*, i8* } ({}*)*, { i8*, i8* } ({}*)** %3, align 8, !invariant.load !5, !noalias !2, !nonnull !5
  %5 = tail call { i8*, i8* } %4({}* mpk_immut nonnull align 1 %_2.0.i), !noalias !2
  ret { i8*, i8* } %5
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal { i8*, i8* } @_ZN3std5error5Error5cause17hafecdf6f69a52ff2E(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #0 {
start:
  ret { i8*, i8* } { i8* null, i8* undef }
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal i64 @_ZN3std5error5Error7type_id17h40192265680681f0E(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #0 {
start:
  ret i64 3674886053576987189
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal i64 @_ZN3std5error5Error7type_id17ha061394de7b9cd54E({ i8*, i64* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #0 {
start:
  ret i64 -8622630536848602990
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal mpk_immut noalias align 8 dereferenceable_or_null(64) i64* @_ZN3std5error5Error9backtrace17hb8be1fa6088c4f31E({ i8*, i64* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #0 {
start:
  ret i64* null
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal mpk_immut noalias align 8 dereferenceable_or_null(64) i64* @_ZN3std5error5Error9backtrace17hee8271e7eaab3279E(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #0 {
start:
  ret i64* null
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h5cbc67c247421bfaE"(i32** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %_4.i = alloca i32, align 4
  %_4 = load i32*, i32** %self, align 8, !nonnull !5
  %_4.val = load i32, i32* %_4, align 4
  %0 = bitcast i32* %_4.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0)
  store i32 %_4.val, i32* %_4.i, align 4
  %_3.i.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f), !noalias !6
  br i1 %_3.i.i, label %bb3.i.i, label %bb2.i.i

bb2.i.i:                                          ; preds = %start
  %_7.i.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7.i.i, label %bb7.i.i, label %bb6.i.i

bb3.i.i:                                          ; preds = %start
  %1 = call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hbdab60765508c6f3E"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %_4.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN67_$LT$core..num..nonzero..NonZeroU32$u20$as$u20$core..fmt..Debug$GT$3fmt17h1036e92aa97a64c2E.exit"

bb6.i.i:                                          ; preds = %bb2.i.i
  %2 = call zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h6b8b41e24df1a43fE"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %_4.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN67_$LT$core..num..nonzero..NonZeroU32$u20$as$u20$core..fmt..Debug$GT$3fmt17h1036e92aa97a64c2E.exit"

bb7.i.i:                                          ; preds = %bb2.i.i
  %3 = call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h4773017a326a508bE"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %_4.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN67_$LT$core..num..nonzero..NonZeroU32$u20$as$u20$core..fmt..Debug$GT$3fmt17h1036e92aa97a64c2E.exit"

"_ZN67_$LT$core..num..nonzero..NonZeroU32$u20$as$u20$core..fmt..Debug$GT$3fmt17h1036e92aa97a64c2E.exit": ; preds = %bb7.i.i, %bb6.i.i, %bb3.i.i
  %.0.in.i.i = phi i1 [ %1, %bb3.i.i ], [ %3, %bb7.i.i ], [ %2, %bb6.i.i ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0)
  ret i1 %.0.in.i.i
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal void @_ZN4core3ptr13drop_in_place17h94c24941239afbb2E(i32** mpk_unsafe nocapture %_1) unnamed_addr #0 {
start:
  ret void
}

; Function Attrs: nonlazybind uwtable
define internal void @_ZN4core3ptr13drop_in_place17hdea4aab8a761e359E({ i8*, i64* }* mpk_unsafe nocapture readonly %_1) unnamed_addr #1 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %0 = bitcast { i8*, i64* }* %_1 to {}**
  %1 = load {}*, {}** %0, align 8, !nonnull !5
  %2 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %_1, i64 0, i32 1
  %3 = bitcast i64** %2 to void ({}*)***
  %4 = load void ({}*)**, void ({}*)*** %3, align 8, !nonnull !5
  %5 = load void ({}*)*, void ({}*)** %4, align 8, !invariant.load !5, !nonnull !5
  invoke void %5({}* mpk_unsafe nonnull %1)
          to label %bb3.i unwind label %cleanup.i

bb3.i:                                            ; preds = %start
  %6 = load i64*, i64** %2, align 8, !nonnull !5
  %7 = getelementptr inbounds i64, i64* %6, i64 1
  %8 = load i64, i64* %7, align 8, !invariant.load !5, !alias.scope !9
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %_ZN4core3ptr13drop_in_place17h5cb38259ab1e870eE.exit, label %bb3.i.i.i

bb3.i.i.i:                                        ; preds = %bb3.i
  %10 = getelementptr { i8*, i64* }, { i8*, i64* }* %_1, i64 0, i32 0
  %11 = load i8*, i8** %10, align 8, !nonnull !5
  %12 = getelementptr inbounds i64, i64* %6, i64 2
  %13 = load i64, i64* %12, align 8, !invariant.load !5, !alias.scope !9
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %11, i64 %8, i64 %13) #12, !noalias !9
  br label %_ZN4core3ptr13drop_in_place17h5cb38259ab1e870eE.exit

cleanup.i:                                        ; preds = %start
  %14 = landingpad { i8*, i32 }
          cleanup
  %15 = getelementptr { i8*, i64* }, { i8*, i64* }* %_1, i64 0, i32 0
  %16 = load i8*, i8** %15, align 8, !nonnull !5
  %17 = load i64*, i64** %2, align 8, !nonnull !5
  tail call fastcc void @_ZN5alloc5alloc8box_free17hc92d77d56109ca9eE(i8* mpk_immut mpk_unsafe nonnull %16, i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) %17) #13
  resume { i8*, i32 } %14

_ZN4core3ptr13drop_in_place17h5cb38259ab1e870eE.exit: ; preds = %bb3.i.i.i, %bb3.i
  ret void
}

; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal fastcc void @_ZN5alloc5alloc8box_free17hc92d77d56109ca9eE(i8* mpk_immut mpk_unsafe nonnull %0, i64* mpk_immut noalias readonly align 8 dereferenceable(24) %1) unnamed_addr #2 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %2 = getelementptr inbounds i64, i64* %1, i64 1
  %3 = load i64, i64* %2, align 8, !invariant.load !5
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit", label %bb3.i

bb3.i:                                            ; preds = %start
  %5 = getelementptr inbounds i64, i64* %1, i64 2
  %6 = load i64, i64* %5, align 8, !invariant.load !5
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %0, i64 %3, i64 %6) #12
  br label %"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit"

"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit": ; preds = %bb3.i, %start
  ret void
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN67_$LT$alloc..boxed..Box$LT$T$C$A$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha60fbae60993ac41E"({ {}*, [3 x i64]* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %0 = getelementptr inbounds { {}*, [3 x i64]* }, { {}*, [3 x i64]* }* %self, i64 0, i32 0
  %_4.0 = load {}*, {}** %0, align 8, !nonnull !5
  %1 = getelementptr inbounds { {}*, [3 x i64]* }, { {}*, [3 x i64]* }* %self, i64 0, i32 1
  %2 = bitcast [3 x i64]** %1 to i1 ({}*, %"core::fmt::Formatter"*)***
  %_4.11 = load i1 ({}*, %"core::fmt::Formatter"*)**, i1 ({}*, %"core::fmt::Formatter"*)*** %2, align 8, !nonnull !5
  %3 = getelementptr inbounds i1 ({}*, %"core::fmt::Formatter"*)*, i1 ({}*, %"core::fmt::Formatter"*)** %_4.11, i64 9
  %4 = load i1 ({}*, %"core::fmt::Formatter"*)*, i1 ({}*, %"core::fmt::Formatter"*)** %3, align 8, !invariant.load !5, !nonnull !5
  %5 = tail call zeroext i1 %4({}* mpk_immut nonnull align 1 %_4.0, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  ret i1 %5
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN69_$LT$alloc..boxed..Box$LT$T$C$A$GT$$u20$as$u20$core..fmt..Display$GT$3fmt17ha6ed6c1600bbc7e7E"({ {}*, [3 x i64]* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %0 = getelementptr inbounds { {}*, [3 x i64]* }, { {}*, [3 x i64]* }* %self, i64 0, i32 0
  %_4.0 = load {}*, {}** %0, align 8, !nonnull !5
  %1 = getelementptr inbounds { {}*, [3 x i64]* }, { {}*, [3 x i64]* }* %self, i64 0, i32 1
  %2 = bitcast [3 x i64]** %1 to i1 ({}*, %"core::fmt::Formatter"*)***
  %_4.11 = load i1 ({}*, %"core::fmt::Formatter"*)**, i1 ({}*, %"core::fmt::Formatter"*)*** %2, align 8, !nonnull !5
  %3 = getelementptr inbounds i1 ({}*, %"core::fmt::Formatter"*)*, i1 ({}*, %"core::fmt::Formatter"*)** %_4.11, i64 8
  %4 = load i1 ({}*, %"core::fmt::Formatter"*)*, i1 ({}*, %"core::fmt::Formatter"*)** %3, align 8, !invariant.load !5, !nonnull !5
  %5 = tail call zeroext i1 %4({}* mpk_immut nonnull align 1 %_4.0, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  ret i1 %5
}

; Function Attrs: inlinehint nonlazybind uwtable
define internal zeroext i1 @"_ZN69_$LT$core..num..nonzero..NonZeroU32$u20$as$u20$core..fmt..Display$GT$3fmt17hfafed51f8eeb5a88E"(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #3 {
start:
  %_4 = alloca i32, align 4
  %0 = bitcast i32* %_4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0)
  %_5 = load i32, i32* %self, align 4, !range !12
  store i32 %_5, i32* %_4, align 4
  %1 = call zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h6b8b41e24df1a43fE"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0)
  ret i1 %1
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN60_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h99494ce050e74d44E"({ i8*, i64* }* mpk_immut noalias readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %_11 = alloca [1 x { i8*, i64* }], align 8
  %_4 = alloca %"core::fmt::Arguments", align 8
  %0 = bitcast %"core::fmt::Arguments"* %_4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %0)
  %1 = bitcast [1 x { i8*, i64* }]* %_11 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %1)
  %2 = bitcast [1 x { i8*, i64* }]* %_11 to { i8*, i64* }**
  store { i8*, i64* }* %self, { i8*, i64* }** %2, align 8
  %3 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_11, i64 0, i64 0, i32 1
  store i64* bitcast (i1 ({ {}*, [3 x i64]* }*, %"core::fmt::Formatter"*)* @"_ZN67_$LT$alloc..boxed..Box$LT$T$C$A$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha60fbae60993ac41E" to i64*), i64** %3, align 8
  %4 = bitcast %"core::fmt::Arguments"* %_4 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8], i8*, [8 x i8] }>* @alloc107 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %4, align 8, !alias.scope !13, !noalias !16
  %5 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 1, i32 1
  store i64 2, i64* %5, align 8, !alias.scope !13, !noalias !16
  %6 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 3, i32 0
  store i64* null, i64** %6, align 8, !alias.scope !13, !noalias !16
  %7 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 0
  %8 = bitcast [0 x { i8*, i64* }]** %7 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_11, [1 x { i8*, i64* }]** %8, align 8, !alias.scope !13, !noalias !16
  %9 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 1
  store i64 1, i64* %9, align 8, !alias.scope !13, !noalias !16
  %10 = call zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, %"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_4)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %0)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %1)
  ret i1 %10
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN62_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h9df079ff3e7ae672E"({ i8*, i64* }* mpk_immut noalias readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %_11 = alloca [1 x { i8*, i64* }], align 8
  %_4 = alloca %"core::fmt::Arguments", align 8
  %0 = bitcast %"core::fmt::Arguments"* %_4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %0)
  %1 = bitcast [1 x { i8*, i64* }]* %_11 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %1)
  %2 = bitcast [1 x { i8*, i64* }]* %_11 to { i8*, i64* }**
  store { i8*, i64* }* %self, { i8*, i64* }** %2, align 8
  %3 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_11, i64 0, i64 0, i32 1
  store i64* bitcast (i1 ({ {}*, [3 x i64]* }*, %"core::fmt::Formatter"*)* @"_ZN69_$LT$alloc..boxed..Box$LT$T$C$A$GT$$u20$as$u20$core..fmt..Display$GT$3fmt17ha6ed6c1600bbc7e7E" to i64*), i64** %3, align 8
  %4 = bitcast %"core::fmt::Arguments"* %_4 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc114 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %4, align 8, !alias.scope !19, !noalias !22
  %5 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 1, i32 1
  store i64 1, i64* %5, align 8, !alias.scope !19, !noalias !22
  %6 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 3, i32 0
  store i64* null, i64** %6, align 8, !alias.scope !19, !noalias !22
  %7 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 0
  %8 = bitcast [0 x { i8*, i64* }]** %7 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_11, [1 x { i8*, i64* }]** %8, align 8, !alias.scope !19, !noalias !22
  %9 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 1
  store i64 1, i64* %9, align 8, !alias.scope !19, !noalias !22
  %10 = call zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, %"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_4)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %0)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %1)
  ret i1 %10
}

; Function Attrs: inlinehint nonlazybind uwtable
define internal { i8*, i8* } @"_ZN61_$LT$rand_core..error..Error$u20$as$u20$std..error..Error$GT$6source17h55a4f0b3236e47e5E"({ i8*, i64* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #3 {
start:
  %0 = bitcast { i8*, i64* }* %self to {}**
  %_2.0 = load {}*, {}** %0, align 8, !nonnull !5
  %1 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %self, i64 0, i32 1
  %2 = bitcast i64** %1 to { i8*, i8* } ({}*)***
  %_2.11 = load { i8*, i8* } ({}*)**, { i8*, i8* } ({}*)*** %2, align 8, !nonnull !5
  %3 = getelementptr inbounds { i8*, i8* } ({}*)*, { i8*, i8* } ({}*)** %_2.11, i64 3
  %4 = load { i8*, i8* } ({}*)*, { i8*, i8* } ({}*)** %3, align 8, !invariant.load !5, !nonnull !5
  %5 = tail call { i8*, i8* } %4({}* mpk_immut nonnull align 1 %_2.0)
  ret { i8*, i8* } %5
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN66_$LT$rand_core..error..ErrorCode$u20$as$u20$core..fmt..Display$GT$3fmt17hcfde6da3d63fc394E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %_11 = alloca [1 x { i8*, i64* }], align 8
  %_4 = alloca %"core::fmt::Arguments", align 8
  %0 = bitcast %"core::fmt::Arguments"* %_4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %0)
  %1 = bitcast [1 x { i8*, i64* }]* %_11 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %1)
  %2 = bitcast [1 x { i8*, i64* }]* %_11 to i32**
  store i32* %self, i32** %2, align 8
  %3 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_11, i64 0, i64 0, i32 1
  store i64* bitcast (i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN69_$LT$core..num..nonzero..NonZeroU32$u20$as$u20$core..fmt..Display$GT$3fmt17hfafed51f8eeb5a88E" to i64*), i64** %3, align 8
  %4 = bitcast %"core::fmt::Arguments"* %_4 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc120 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %4, align 8, !alias.scope !25, !noalias !28
  %5 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 1, i32 1
  store i64 1, i64* %5, align 8, !alias.scope !25, !noalias !28
  %6 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 3, i32 0
  store i64* null, i64** %6, align 8, !alias.scope !25, !noalias !28
  %7 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 0
  %8 = bitcast [0 x { i8*, i64* }]** %7 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_11, [1 x { i8*, i64* }]** %8, align 8, !alias.scope !25, !noalias !28
  %9 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 1
  store i64 1, i64* %9, align 8, !alias.scope !25, !noalias !28
  %10 = call zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, %"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_4)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %0)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %1)
  ret i1 %10
}

; Function Attrs: nounwind nonlazybind uwtable
define { i64, i64 } @_ZN9rand_core5impls19fill_via_u32_chunks17h6f6c6e3fe88df0c3E([0 x i32]* mpk_immut noalias nocapture nonnull readonly align 4 %src.0, i64 %src.1, [0 x i8]* nocapture nonnull align 1 %dest.0, i64 %dest.1) unnamed_addr #4 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_4 = shl i64 %src.1, 2
  %0 = icmp ugt i64 %_4, %dest.1
  %.0.sroa.speculated.i.i.i = select i1 %0, i64 %dest.1, i64 %_4
  %_10 = add i64 %.0.sroa.speculated.i.i.i, 3
  %chunk_size = lshr i64 %_10, 2
  %_14 = bitcast [0 x i32]* %src.0 to i8*
  %1 = getelementptr [0 x i8], [0 x i8]* %dest.0, i64 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %1, i8* nonnull align 4 %_14, i64 %.0.sroa.speculated.i.i.i, i1 false) #12
  %2 = insertvalue { i64, i64 } undef, i64 %chunk_size, 0
  %3 = insertvalue { i64, i64 } %2, i64 %.0.sroa.speculated.i.i.i, 1
  ret { i64, i64 } %3
}

; Function Attrs: nounwind nonlazybind uwtable
define { i64, i64 } @_ZN9rand_core5impls19fill_via_u64_chunks17h5e59a745ab3a416bE([0 x i64]* mpk_immut noalias nocapture nonnull readonly align 8 %src.0, i64 %src.1, [0 x i8]* nocapture nonnull align 1 %dest.0, i64 %dest.1) unnamed_addr #4 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_4 = shl i64 %src.1, 3
  %0 = icmp ugt i64 %_4, %dest.1
  %.0.sroa.speculated.i.i.i = select i1 %0, i64 %dest.1, i64 %_4
  %_10 = add i64 %.0.sroa.speculated.i.i.i, 7
  %chunk_size = lshr i64 %_10, 3
  %_14 = bitcast [0 x i64]* %src.0 to i8*
  %1 = getelementptr [0 x i8], [0 x i8]* %dest.0, i64 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %1, i8* nonnull align 8 %_14, i64 %.0.sroa.speculated.i.i.i, i1 false) #12
  %2 = insertvalue { i64, i64 } undef, i64 %chunk_size, 0
  %3 = insertvalue { i64, i64 } %2, i64 %.0.sroa.speculated.i.i.i, 1
  ret { i64, i64 } %3
}

; Function Attrs: nonlazybind uwtable
define i32 @"_ZN59_$LT$rand_core..os..OsRng$u20$as$u20$rand_core..RngCore$GT$8next_u3217hbfaff524bfb2705dE"(%"os::OsRng"* nocapture nonnull readnone align 1 %self) unnamed_addr #1 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_15.i.i = alloca [1 x { i8*, i64* }], align 8
  %_8.i.i = alloca %"core::fmt::Arguments", align 8
  %e.i.i = alloca { i8*, i64* }, align 8
  %buf.i = alloca i32, align 4
  %0 = bitcast i32* %buf.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0)
  store i32 0, i32* %buf.i, align 4
  %_5.0.i = bitcast i32* %buf.i to [0 x i8]*
  %_4.i.i.i = call i32 @_ZN9getrandom9getrandom17h5fda40e5c88ad1f2E([0 x i8]* nonnull align 1 %_5.0.i, i64 4)
  %1 = icmp eq i32 %_4.i.i.i, 0
  br i1 %1, label %_ZN9rand_core5impls17next_u32_via_fill17hee0b70540cf05bd6E.exit, label %bb5.i.i.i

bb5.i.i.i:                                        ; preds = %start
  %2 = call mpk_unsafe dereferenceable_or_null(4) i8* @__rust_alloc(i64 4, i64 4) #12
  %3 = icmp eq i8* %2, null
  br i1 %3, label %bb3.i.i.i.i.i.i, label %bb5.i.i

bb3.i.i.i.i.i.i:                                  ; preds = %bb5.i.i.i
  call void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64 4, i64 4) #12
  br label %UnifiedUnreachableBlock

bb5.i.i:                                          ; preds = %bb5.i.i.i
  %4 = bitcast i8* %2 to i32*
  store i32 %_4.i.i.i, i32* %4, align 4
  %5 = ptrtoint i8* %2 to i64
  %6 = bitcast { i8*, i64* }* %e.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %6)
  %7 = bitcast { i8*, i64* }* %e.i.i to i64*
  store i64 %5, i64* %7, align 8
  %8 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %e.i.i, i64 0, i32 1
  %9 = bitcast i64** %8 to i64*
  store i64 ptrtoint ({ void (i32*)*, i64, i64, { i8*, i8* } (i32*)*, i64 (i32*)*, i64* (i32*)*, { [0 x i8]*, i64 } (i32*)*, { i8*, i8* } (i32*)*, i1 (i32*, %"core::fmt::Formatter"*)*, i1 (i32*, %"core::fmt::Formatter"*)* }* @vtable.1 to i64), i64* %9, align 8
  %10 = bitcast %"core::fmt::Arguments"* %_8.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %10)
  %11 = bitcast [1 x { i8*, i64* }]* %_15.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %11)
  %12 = bitcast [1 x { i8*, i64* }]* %_15.i.i to { i8*, i64* }**
  store { i8*, i64* }* %e.i.i, { i8*, i64* }** %12, align 8
  %13 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_15.i.i, i64 0, i64 0, i32 1
  store i64* bitcast (i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)* @"_ZN62_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h9df079ff3e7ae672E" to i64*), i64** %13, align 8
  %14 = bitcast %"core::fmt::Arguments"* %_8.i.i to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc126 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %14, align 8, !alias.scope !31, !noalias !34
  %15 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8.i.i, i64 0, i32 1, i32 1
  store i64 1, i64* %15, align 8, !alias.scope !31, !noalias !34
  %16 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8.i.i, i64 0, i32 3, i32 0
  store i64* null, i64** %16, align 8, !alias.scope !31, !noalias !34
  %17 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8.i.i, i64 0, i32 5, i32 0
  %18 = bitcast [0 x { i8*, i64* }]** %17 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_15.i.i, [1 x { i8*, i64* }]** %18, align 8, !alias.scope !31, !noalias !34
  %19 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8.i.i, i64 0, i32 5, i32 1
  store i64 1, i64* %19, align 8, !alias.scope !31, !noalias !34
  invoke void @_ZN4core9panicking9panic_fmt17h08461824ca4df3e0E(%"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_8.i.i, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc169 to %"core::panic::Location"*))
          to label %unreachable.i.i unwind label %cleanup.i.i

cleanup.i.i:                                      ; preds = %bb5.i.i
  %20 = landingpad { i8*, i32 }
          cleanup
  call void @_ZN4core3ptr13drop_in_place17hdea4aab8a761e359E({ i8*, i64* }* mpk_unsafe nonnull %e.i.i) #13
  resume { i8*, i32 } %20

unreachable.i.i:                                  ; preds = %bb5.i.i
  br label %UnifiedUnreachableBlock

_ZN9rand_core5impls17next_u32_via_fill17hee0b70540cf05bd6E.exit: ; preds = %start
  %_8.sroa.0.0.copyload.i = load i32, i32* %buf.i, align 4
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0)
  ret i32 %_8.sroa.0.0.copyload.i

UnifiedUnreachableBlock:                          ; preds = %unreachable.i.i, %bb3.i.i.i.i.i.i
  unreachable
}

; Function Attrs: nonlazybind uwtable
define i64 @"_ZN59_$LT$rand_core..os..OsRng$u20$as$u20$rand_core..RngCore$GT$8next_u6417hafccfc673db38ba7E"(%"os::OsRng"* nocapture nonnull readnone align 1 %self) unnamed_addr #1 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_15.i.i = alloca [1 x { i8*, i64* }], align 8
  %_8.i.i = alloca %"core::fmt::Arguments", align 8
  %e.i.i = alloca { i8*, i64* }, align 8
  %buf.i = alloca i64, align 8
  %0 = bitcast i64* %buf.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %0)
  store i64 0, i64* %buf.i, align 8
  %_5.0.i = bitcast i64* %buf.i to [0 x i8]*
  %_4.i.i.i = call i32 @_ZN9getrandom9getrandom17h5fda40e5c88ad1f2E([0 x i8]* nonnull align 1 %_5.0.i, i64 8)
  %1 = icmp eq i32 %_4.i.i.i, 0
  br i1 %1, label %_ZN9rand_core5impls17next_u64_via_fill17hfce9dba75bd8fa05E.exit, label %bb5.i.i.i

bb5.i.i.i:                                        ; preds = %start
  %2 = call mpk_unsafe dereferenceable_or_null(4) i8* @__rust_alloc(i64 4, i64 4) #12
  %3 = icmp eq i8* %2, null
  br i1 %3, label %bb3.i.i.i.i.i.i, label %bb5.i.i

bb3.i.i.i.i.i.i:                                  ; preds = %bb5.i.i.i
  call void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64 4, i64 4) #12
  br label %UnifiedUnreachableBlock

bb5.i.i:                                          ; preds = %bb5.i.i.i
  %4 = bitcast i8* %2 to i32*
  store i32 %_4.i.i.i, i32* %4, align 4
  %5 = ptrtoint i8* %2 to i64
  %6 = bitcast { i8*, i64* }* %e.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %6)
  %7 = bitcast { i8*, i64* }* %e.i.i to i64*
  store i64 %5, i64* %7, align 8
  %8 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %e.i.i, i64 0, i32 1
  %9 = bitcast i64** %8 to i64*
  store i64 ptrtoint ({ void (i32*)*, i64, i64, { i8*, i8* } (i32*)*, i64 (i32*)*, i64* (i32*)*, { [0 x i8]*, i64 } (i32*)*, { i8*, i8* } (i32*)*, i1 (i32*, %"core::fmt::Formatter"*)*, i1 (i32*, %"core::fmt::Formatter"*)* }* @vtable.1 to i64), i64* %9, align 8
  %10 = bitcast %"core::fmt::Arguments"* %_8.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %10)
  %11 = bitcast [1 x { i8*, i64* }]* %_15.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %11)
  %12 = bitcast [1 x { i8*, i64* }]* %_15.i.i to { i8*, i64* }**
  store { i8*, i64* }* %e.i.i, { i8*, i64* }** %12, align 8
  %13 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_15.i.i, i64 0, i64 0, i32 1
  store i64* bitcast (i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)* @"_ZN62_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h9df079ff3e7ae672E" to i64*), i64** %13, align 8
  %14 = bitcast %"core::fmt::Arguments"* %_8.i.i to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc126 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %14, align 8, !alias.scope !37, !noalias !40
  %15 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8.i.i, i64 0, i32 1, i32 1
  store i64 1, i64* %15, align 8, !alias.scope !37, !noalias !40
  %16 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8.i.i, i64 0, i32 3, i32 0
  store i64* null, i64** %16, align 8, !alias.scope !37, !noalias !40
  %17 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8.i.i, i64 0, i32 5, i32 0
  %18 = bitcast [0 x { i8*, i64* }]** %17 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_15.i.i, [1 x { i8*, i64* }]** %18, align 8, !alias.scope !37, !noalias !40
  %19 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8.i.i, i64 0, i32 5, i32 1
  store i64 1, i64* %19, align 8, !alias.scope !37, !noalias !40
  invoke void @_ZN4core9panicking9panic_fmt17h08461824ca4df3e0E(%"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_8.i.i, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc169 to %"core::panic::Location"*))
          to label %unreachable.i.i unwind label %cleanup.i.i

cleanup.i.i:                                      ; preds = %bb5.i.i
  %20 = landingpad { i8*, i32 }
          cleanup
  call void @_ZN4core3ptr13drop_in_place17hdea4aab8a761e359E({ i8*, i64* }* mpk_unsafe nonnull %e.i.i) #13
  resume { i8*, i32 } %20

unreachable.i.i:                                  ; preds = %bb5.i.i
  br label %UnifiedUnreachableBlock

_ZN9rand_core5impls17next_u64_via_fill17hfce9dba75bd8fa05E.exit: ; preds = %start
  %_8.sroa.0.0.copyload.i = load i64, i64* %buf.i, align 8
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %0)
  ret i64 %_8.sroa.0.0.copyload.i

UnifiedUnreachableBlock:                          ; preds = %unreachable.i.i, %bb3.i.i.i.i.i.i
  unreachable
}

; Function Attrs: nonlazybind uwtable
define void @"_ZN59_$LT$rand_core..os..OsRng$u20$as$u20$rand_core..RngCore$GT$10fill_bytes17h9d270fcd0d6cb273E"(%"os::OsRng"* nocapture nonnull readnone align 1 %self, [0 x i8]* nonnull align 1 %dest.0, i64 %dest.1) unnamed_addr #1 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_15 = alloca [1 x { i8*, i64* }], align 8
  %_8 = alloca %"core::fmt::Arguments", align 8
  %e = alloca { i8*, i64* }, align 8
  %_4.i = tail call i32 @_ZN9getrandom9getrandom17h5fda40e5c88ad1f2E([0 x i8]* nonnull align 1 %dest.0, i64 %dest.1)
  %0 = icmp eq i32 %_4.i, 0
  br i1 %0, label %_ZN4core3ptr13drop_in_place17h458e1da0d4500f26E.exit, label %bb5.i

bb5.i:                                            ; preds = %start
  %1 = tail call mpk_unsafe dereferenceable_or_null(4) i8* @__rust_alloc(i64 4, i64 4) #12
  %2 = icmp eq i8* %1, null
  br i1 %2, label %bb3.i.i.i.i, label %bb5

bb3.i.i.i.i:                                      ; preds = %bb5.i
  tail call void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64 4, i64 4) #12
  br label %UnifiedUnreachableBlock

_ZN4core3ptr13drop_in_place17h458e1da0d4500f26E.exit: ; preds = %start
  ret void

bb5:                                              ; preds = %bb5.i
  %3 = bitcast i8* %1 to i32*
  store i32 %_4.i, i32* %3, align 4
  %4 = ptrtoint i8* %1 to i64
  %5 = bitcast { i8*, i64* }* %e to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %5)
  %6 = bitcast { i8*, i64* }* %e to i64*
  store i64 %4, i64* %6, align 8
  %7 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %e, i64 0, i32 1
  %8 = bitcast i64** %7 to i64*
  store i64 ptrtoint ({ void (i32*)*, i64, i64, { i8*, i8* } (i32*)*, i64 (i32*)*, i64* (i32*)*, { [0 x i8]*, i64 } (i32*)*, { i8*, i8* } (i32*)*, i1 (i32*, %"core::fmt::Formatter"*)*, i1 (i32*, %"core::fmt::Formatter"*)* }* @vtable.1 to i64), i64* %8, align 8
  %9 = bitcast %"core::fmt::Arguments"* %_8 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %9)
  %10 = bitcast [1 x { i8*, i64* }]* %_15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %10)
  %11 = bitcast [1 x { i8*, i64* }]* %_15 to { i8*, i64* }**
  store { i8*, i64* }* %e, { i8*, i64* }** %11, align 8
  %12 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_15, i64 0, i64 0, i32 1
  store i64* bitcast (i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)* @"_ZN62_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h9df079ff3e7ae672E" to i64*), i64** %12, align 8
  %13 = bitcast %"core::fmt::Arguments"* %_8 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc126 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %13, align 8, !alias.scope !43, !noalias !46
  %14 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8, i64 0, i32 1, i32 1
  store i64 1, i64* %14, align 8, !alias.scope !43, !noalias !46
  %15 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8, i64 0, i32 3, i32 0
  store i64* null, i64** %15, align 8, !alias.scope !43, !noalias !46
  %16 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8, i64 0, i32 5, i32 0
  %17 = bitcast [0 x { i8*, i64* }]** %16 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_15, [1 x { i8*, i64* }]** %17, align 8, !alias.scope !43, !noalias !46
  %18 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_8, i64 0, i32 5, i32 1
  store i64 1, i64* %18, align 8, !alias.scope !43, !noalias !46
  invoke void @_ZN4core9panicking9panic_fmt17h08461824ca4df3e0E(%"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_8, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc169 to %"core::panic::Location"*))
          to label %unreachable unwind label %cleanup

cleanup:                                          ; preds = %bb5
  %19 = landingpad { i8*, i32 }
          cleanup
  call void @_ZN4core3ptr13drop_in_place17hdea4aab8a761e359E({ i8*, i64* }* mpk_unsafe nonnull %e) #13
  resume { i8*, i32 } %19

unreachable:                                      ; preds = %bb5
  br label %UnifiedUnreachableBlock

UnifiedUnreachableBlock:                          ; preds = %unreachable, %bb3.i.i.i.i
  unreachable
}

; Function Attrs: nonlazybind uwtable
define { i8*, i8* } @"_ZN59_$LT$rand_core..os..OsRng$u20$as$u20$rand_core..RngCore$GT$14try_fill_bytes17h856c329c7890d82bE"(%"os::OsRng"* nocapture nonnull readnone align 1 %self, [0 x i8]* nonnull align 1 %dest.0, i64 %dest.1) unnamed_addr #1 {
start:
  %_4 = tail call i32 @_ZN9getrandom9getrandom17h5fda40e5c88ad1f2E([0 x i8]* nonnull align 1 %dest.0, i64 %dest.1)
  %0 = icmp eq i32 %_4, 0
  br i1 %0, label %bb8, label %bb5

bb5:                                              ; preds = %start
  %1 = tail call mpk_unsafe dereferenceable_or_null(4) i8* @__rust_alloc(i64 4, i64 4) #12
  %2 = icmp eq i8* %1, null
  br i1 %2, label %bb3.i.i.i, label %"_ZN94_$LT$rand_core..error..Error$u20$as$u20$core..convert..From$LT$getrandom..error..Error$GT$$GT$4from17h837a8b9dd1612df8E.exit"

bb3.i.i.i:                                        ; preds = %bb5
  tail call void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64 4, i64 4) #12
  unreachable

"_ZN94_$LT$rand_core..error..Error$u20$as$u20$core..convert..From$LT$getrandom..error..Error$GT$$GT$4from17h837a8b9dd1612df8E.exit": ; preds = %bb5
  %3 = bitcast i8* %1 to i32*
  store i32 %_4, i32* %3, align 4
  br label %bb8

bb8:                                              ; preds = %"_ZN94_$LT$rand_core..error..Error$u20$as$u20$core..convert..From$LT$getrandom..error..Error$GT$$GT$4from17h837a8b9dd1612df8E.exit", %start
  %.sroa.0.0 = phi i8* [ %1, %"_ZN94_$LT$rand_core..error..Error$u20$as$u20$core..convert..From$LT$getrandom..error..Error$GT$$GT$4from17h837a8b9dd1612df8E.exit" ], [ null, %start ]
  %4 = insertvalue { i8*, i8* } undef, i8* %.sroa.0.0, 0
  %5 = insertvalue { i8*, i8* } %4, i8* bitcast ({ void (i32*)*, i64, i64, { i8*, i8* } (i32*)*, i64 (i32*)*, i64* (i32*)*, { [0 x i8]*, i64 } (i32*)*, { i8*, i8* } (i32*)*, i1 (i32*, %"core::fmt::Formatter"*)*, i1 (i32*, %"core::fmt::Formatter"*)* }* @vtable.1 to i8*), 1
  ret { i8*, i8* } %5
}

; Function Attrs: nofree nounwind nonlazybind uwtable
define i32 @_ZN9rand_core11SeedableRng13seed_from_u645pcg3217h4258163356d01653E(i64* nocapture align 8 dereferenceable(8) %state) unnamed_addr #5 {
start:
  %_4 = load i64, i64* %state, align 8
  %0 = mul i64 %_4, 6364136223846793005
  %1 = add i64 %0, -6812164046247290893
  store i64 %1, i64* %state, align 8
  %2 = lshr i64 %1, 45
  %3 = lshr i64 %1, 27
  %_7 = xor i64 %2, %3
  %xorshifted = trunc i64 %_7 to i32
  %_13 = lshr i64 %1, 59
  %rot = trunc i64 %_13 to i32
  %4 = tail call i32 @llvm.fshr.i32(i32 %xorshifted, i32 %xorshifted, i32 %rot) #12
  ret i32 %4
}

; Function Attrs: nonlazybind uwtable
define void @"_ZN60_$LT$dyn$u20$rand_core..RngCore$u20$as$u20$std..io..Read$GT$4read17h331dcbe3ddff5359E"(%"core::result::Result<usize, std::io::Error>"* noalias nocapture sret dereferenceable(24) %0, {}* nonnull align 1 %self.0, [3 x i64]* mpk_immut noalias nocapture readonly align 8 dereferenceable(24) %self.1, [0 x i8]* nonnull align 1 %buf.0, i64 %buf.1) unnamed_addr #1 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %error.i = alloca { i8*, i64* }, align 8
  %1 = getelementptr inbounds [3 x i64], [3 x i64]* %self.1, i64 0, i64 6
  %2 = bitcast i64* %1 to { i8*, i8* } ({}*, [0 x i8]*, i64)**
  %3 = load { i8*, i8* } ({}*, [0 x i8]*, i64)*, { i8*, i8* } ({}*, [0 x i8]*, i64)** %2, align 8, !invariant.load !5, !nonnull !5
  %4 = tail call { i8*, i8* } %3({}* nonnull align 1 %self.0, [0 x i8]* nonnull align 1 %buf.0, i64 %buf.1)
  %.fca.0.extract = extractvalue { i8*, i8* } %4, 0
  %.fca.1.extract = extractvalue { i8*, i8* } %4, 1
  %5 = icmp eq i8* %.fca.0.extract, null
  br i1 %5, label %bb3, label %bb5

bb3:                                              ; preds = %start
  %6 = getelementptr inbounds %"core::result::Result<usize, std::io::Error>", %"core::result::Result<usize, std::io::Error>"* %0, i64 0, i32 2, i64 0
  store i64 %buf.1, i64* %6, align 8
  br label %bb9

bb5:                                              ; preds = %start
  %7 = icmp ne i8* %.fca.1.extract, null
  tail call void @llvm.assume(i1 %7)
  %8 = bitcast i8* %.fca.1.extract to i64*
  %9 = bitcast { i8*, i64* }* %error.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %9)
  %10 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %error.i, i64 0, i32 0
  store i8* %.fca.0.extract, i8** %10, align 8, !noalias !49
  %11 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %error.i, i64 0, i32 1
  %12 = bitcast i64** %11 to i8**
  store i8* %.fca.1.extract, i8** %12, align 8, !noalias !49
  %_3.0.i.cast.i = bitcast i8* %.fca.0.extract to {}*
  %13 = getelementptr inbounds i8, i8* %.fca.1.extract, i64 32
  %14 = bitcast i8* %13 to i64 ({}*)**
  %15 = load i64 ({}*)*, i64 ({}*)** %14, align 8, !invariant.load !5, !alias.scope !53, !noalias !60, !nonnull !5
  %16 = bitcast i8* %.fca.1.extract to void ({}*)**
  %17 = invoke i64 %15({}* mpk_immut nonnull align 1 %_3.0.i.cast.i)
          to label %.noexc.i unwind label %bb10.i

.noexc.i:                                         ; preds = %bb5
  %.not.i.i = icmp eq i64 %17, 8497881545150036703
  br i1 %.not.i.i, label %bb3.i.i, label %bb2.i.i

bb2.i.i:                                          ; preds = %.noexc.i
  %18 = invoke i64 %15({}* mpk_immut nonnull align 1 %_3.0.i.cast.i)
          to label %.noexc13.i unwind label %bb10.i

.noexc13.i:                                       ; preds = %bb2.i.i
  %.not.i.i.i = icmp eq i64 %18, 5109959414169232138
  br i1 %.not.i.i.i, label %_ZN9rand_core5error5Error4code17h4b74ce7216da0ab5E.exit.i.i, label %bb2.i

_ZN9rand_core5error5Error4code17h4b74ce7216da0ab5E.exit.i.i: ; preds = %.noexc13.i
  %_6.i.i.i.i.i = bitcast i8* %.fca.0.extract to i32*
  %.val.i.i.i.i = load i32, i32* %_6.i.i.i.i.i, align 4, !alias.scope !63, !noalias !66
  %19 = icmp sgt i32 %.val.i.i.i.i, 0
  %spec.select10.i.i = zext i1 %19 to i32
  br label %bb1.i

bb3.i.i:                                          ; preds = %.noexc.i
  %20 = bitcast i8* %.fca.0.extract to %"std::io::Error"*
  %21 = invoke { i32, i32 } @_ZN3std2io5error5Error12raw_os_error17haf734d731fac2467E(%"std::io::Error"* mpk_immut noalias nonnull readonly align 8 dereferenceable(16) %20)
          to label %.noexc14.i unwind label %bb10.i

.noexc14.i:                                       ; preds = %bb3.i.i
  %.fca.0.extract.i.i = extractvalue { i32, i32 } %21, 0
  %.fca.1.extract.i.i = extractvalue { i32, i32 } %21, 1
  br label %bb1.i

bb1.i:                                            ; preds = %.noexc14.i, %_ZN9rand_core5error5Error4code17h4b74ce7216da0ab5E.exit.i.i
  %.sroa.4.1.i.i = phi i32 [ %.fca.1.extract.i.i, %.noexc14.i ], [ %.val.i.i.i.i, %_ZN9rand_core5error5Error4code17h4b74ce7216da0ab5E.exit.i.i ]
  %.sroa.0.1.i.i = phi i32 [ %.fca.0.extract.i.i, %.noexc14.i ], [ %spec.select10.i.i, %_ZN9rand_core5error5Error4code17h4b74ce7216da0ab5E.exit.i.i ]
  %22 = icmp eq i32 %.sroa.0.1.i.i, 1
  br i1 %22, label %bb3.i, label %bb2.i

bb2.i:                                            ; preds = %bb1.i, %.noexc13.i
  %23 = tail call mpk_unsafe dereferenceable_or_null(16) i8* @__rust_alloc(i64 16, i64 8) #12, !noalias !69
  %24 = icmp eq i8* %23, null
  br i1 %24, label %bb3.i.i.i.i.i.i, label %"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h92e6f927a5e0fea7E.exit.i.i"

bb3.i.i.i.i.i.i:                                  ; preds = %bb2.i
  tail call void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64 16, i64 8) #12
  unreachable

"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h92e6f927a5e0fea7E.exit.i.i": ; preds = %bb2.i
  %25 = bitcast i8* %23 to i8**
  store i8* %.fca.0.extract, i8** %25, align 8, !noalias !82
  %26 = getelementptr inbounds i8, i8* %23, i64 8
  %27 = bitcast i8* %26 to i8**
  store i8* %.fca.1.extract, i8** %27, align 8, !noalias !82
  %28 = bitcast i8* %23 to {}*
  %29 = tail call i128 @_ZN3std2io5error5Error4_new17h4dbd541810de7dbdE(i8 16, {}* mpk_immut noalias nonnull align 1 %28, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ i8*, i64* }*)*, i64, i64, { i8*, i8* } ({ i8*, i64* }*)*, i64 ({ i8*, i64* }*)*, i64* ({ i8*, i64* }*)*, { [0 x i8]*, i64 } ({ i8*, i64* }*)*, { i8*, i8* } ({ i8*, i64* }*)*, i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)*, i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)* }* @vtable.0 to [3 x i64]*))
  br label %"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E.exit"

bb3.i:                                            ; preds = %bb1.i
  %30 = invoke i128 @_ZN3std2io5error5Error17from_raw_os_error17hb36e5239199ebffeE(i32 %.sroa.4.1.i.i)
          to label %bb9.i unwind label %bb10.i

bb9.i:                                            ; preds = %bb3.i
  %31 = load void ({}*)*, void ({}*)** %16, align 8, !invariant.load !5, !alias.scope !83, !noalias !84, !nonnull !5
  invoke void %31({}* mpk_unsafe nonnull %_3.0.i.cast.i)
          to label %bb3.i.i.i unwind label %cleanup.i.i.i

bb3.i.i.i:                                        ; preds = %bb9.i
  %32 = getelementptr inbounds i8, i8* %.fca.1.extract, i64 8
  %33 = bitcast i8* %32 to i64*
  %34 = load i64, i64* %33, align 8, !invariant.load !5, !alias.scope !85, !noalias !84
  %35 = icmp eq i64 %34, 0
  br i1 %35, label %"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E.exit", label %bb3.i.i.i.i.i

bb3.i.i.i.i.i:                                    ; preds = %bb3.i.i.i
  %36 = getelementptr inbounds i8, i8* %.fca.1.extract, i64 16
  %37 = bitcast i8* %36 to i64*
  %38 = load i64, i64* %37, align 8, !invariant.load !5, !alias.scope !85, !noalias !84
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %.fca.0.extract, i64 %34, i64 %38) #12, !noalias !88
  br label %"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E.exit"

cleanup.i.i.i:                                    ; preds = %bb9.i
  %39 = landingpad { i8*, i32 }
          cleanup
  tail call fastcc void @_ZN5alloc5alloc8box_free17hc92d77d56109ca9eE(i8* mpk_immut mpk_unsafe nonnull %.fca.0.extract, i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) %8) #13
  resume { i8*, i32 } %39

bb10.i:                                           ; preds = %bb3.i, %bb3.i.i, %bb2.i.i, %bb5
  %lpad.thr_comm.i = landingpad { i8*, i32 }
          cleanup
  call void @_ZN4core3ptr13drop_in_place17hdea4aab8a761e359E({ i8*, i64* }* mpk_unsafe nonnull %error.i) #13
  resume { i8*, i32 } %lpad.thr_comm.i

"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E.exit": ; preds = %bb3.i.i.i.i.i, %bb3.i.i.i, %"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h92e6f927a5e0fea7E.exit.i.i"
  %.sroa.0.020.i = phi i128 [ %29, %"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h92e6f927a5e0fea7E.exit.i.i" ], [ %30, %bb3.i.i.i ], [ %30, %bb3.i.i.i.i.i ]
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %9)
  %_9.sroa.0.0._2.sroa.0.0..sroa_cast3.i.sroa_idx = getelementptr inbounds %"core::result::Result<usize, std::io::Error>", %"core::result::Result<usize, std::io::Error>"* %0, i64 0, i32 2
  %_9.sroa.0.0._2.sroa.0.0..sroa_cast3.i.sroa_cast = bitcast [2 x i64]* %_9.sroa.0.0._2.sroa.0.0..sroa_cast3.i.sroa_idx to i128*
  store i128 %.sroa.0.020.i, i128* %_9.sroa.0.0._2.sroa.0.0..sroa_cast3.i.sroa_cast, align 8, !alias.scope !89
  br label %bb9

bb9:                                              ; preds = %"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E.exit", %bb3
  %.sink = phi i64 [ 0, %bb3 ], [ 1, %"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E.exit" ]
  %40 = getelementptr inbounds %"core::result::Result<usize, std::io::Error>", %"core::result::Result<usize, std::io::Error>"* %0, i64 0, i32 0, i64 0
  store i64 %.sink, i64* %40, align 8
  ret void
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN64_$LT$rand_core..error..ErrorCode$u20$as$u20$core..fmt..Debug$GT$3fmt17h3ae603aeb7007f69E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %_13 = alloca i32*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [9 x i8] }>* @alloc170 to [0 x i8]*), i64 9)
  %1 = bitcast i32** %_13 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %1)
  store i32* %self, i32** %_13, align 8
  %_10.0 = bitcast i32** %_13 to {}*
  %_8 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder, {}* mpk_immut nonnull align 1 %_10.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %1)
  %2 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %2
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN57_$LT$rand_core..os..OsRng$u20$as$u20$core..fmt..Debug$GT$3fmt17hd3f8ee53fc5249afE"(%"os::OsRng"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc171 to [0 x i8]*), i64 5)
  %1 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %1
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #6

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #6

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN3std2io5error5Error4_new17h4dbd541810de7dbdE(i8, {}* mpk_immut noalias nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @rust_eh_personality(i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"* mpk_unsafe, %"unwind::libunwind::_Unwind_Context"* mpk_unsafe) unnamed_addr #7

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias readonly align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hbdab60765508c6f3E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias readonly align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h4773017a326a508bE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h6b8b41e24df1a43fE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.fshr.i32(i32, i32, i32) #8

; Function Attrs: noreturn nounwind nonlazybind uwtable
declare void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64, i64) unnamed_addr #9

; Function Attrs: nounwind nonlazybind uwtable
declare mpk_unsafe noalias i8* @__rust_alloc(i64, i64) unnamed_addr #4

; Function Attrs: nounwind nonlazybind uwtable
declare void @__rust_dealloc(i8* mpk_unsafe, i64, i64) unnamed_addr #4

; Function Attrs: nonlazybind uwtable
declare { i32, i32 } @_ZN3std2io5error5Error12raw_os_error17haf734d731fac2467E(%"std::io::Error"* mpk_immut noalias readonly align 8 dereferenceable(16)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* align 8 dereferenceable(64), %"core::fmt::Arguments"* noalias nocapture dereferenceable(48)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN62_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17hf2e963bf31b2e16fE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN60_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h38c9dcf46759f8d7E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN3std2io5error5Error17from_raw_os_error17hb36e5239199ebffeE(i32) unnamed_addr #1

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking9panic_fmt17h08461824ca4df3e0E(%"core::fmt::Arguments"* noalias nocapture dereferenceable(48), %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #10

; Function Attrs: nonlazybind uwtable
declare i32 @_ZN9getrandom9getrandom17h5fda40e5c88ad1f2E([0 x i8]* nonnull align 1, i64) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture sret dereferenceable(24), %"core::fmt::Formatter"* align 8 dereferenceable(64), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* align 8 dereferenceable(24), {}* mpk_immut nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* align 8 dereferenceable(24)) unnamed_addr #1

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #11

attributes #0 = { norecurse nounwind nonlazybind readnone uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #1 = { nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #2 = { inlinehint nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #3 = { inlinehint nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #4 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #5 = { nofree nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #6 = { argmemonly nounwind willreturn }
attributes #7 = { mpk_extern nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #8 = { nounwind readnone speculatable willreturn }
attributes #9 = { noreturn nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #10 = { cold noinline noreturn nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #11 = { nounwind willreturn }
attributes #12 = { nounwind }
attributes #13 = { noinline }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{!3}
!3 = distinct !{!3, !4, !"_ZN61_$LT$rand_core..error..Error$u20$as$u20$std..error..Error$GT$6source17h55a4f0b3236e47e5E: %self"}
!4 = distinct !{!4, !"_ZN61_$LT$rand_core..error..Error$u20$as$u20$std..error..Error$GT$6source17h55a4f0b3236e47e5E"}
!5 = !{}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E: %self"}
!8 = distinct !{!8, !"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E"}
!9 = !{!10}
!10 = distinct !{!10, !11, !"_ZN5alloc5alloc8box_free17hc92d77d56109ca9eE: argument 0"}
!11 = distinct !{!11, !"_ZN5alloc5alloc8box_free17hc92d77d56109ca9eE"}
!12 = !{i32 1, i32 0}
!13 = !{!14}
!14 = distinct !{!14, !15, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!15 = distinct !{!15, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!16 = !{!17, !18}
!17 = distinct !{!17, !15, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!18 = distinct !{!18, !15, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!19 = !{!20}
!20 = distinct !{!20, !21, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!21 = distinct !{!21, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!22 = !{!23, !24}
!23 = distinct !{!23, !21, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!24 = distinct !{!24, !21, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!25 = !{!26}
!26 = distinct !{!26, !27, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!27 = distinct !{!27, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!28 = !{!29, !30}
!29 = distinct !{!29, !27, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!30 = distinct !{!30, !27, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!31 = !{!32}
!32 = distinct !{!32, !33, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!33 = distinct !{!33, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!34 = !{!35, !36}
!35 = distinct !{!35, !33, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!36 = distinct !{!36, !33, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!37 = !{!38}
!38 = distinct !{!38, !39, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!39 = distinct !{!39, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!40 = !{!41, !42}
!41 = distinct !{!41, !39, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!42 = distinct !{!42, !39, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!43 = !{!44}
!44 = distinct !{!44, !45, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!45 = distinct !{!45, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!46 = !{!47, !48}
!47 = distinct !{!47, !45, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!48 = distinct !{!48, !45, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!49 = !{!50, !52}
!50 = distinct !{!50, !51, !"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E: argument 0"}
!51 = distinct !{!51, !"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E"}
!52 = distinct !{!52, !51, !"_ZN9rand_core5error102_$LT$impl$u20$core..convert..From$LT$rand_core..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h3ec01fedfefe4a51E: argument 1"}
!53 = !{!54, !56, !58, !52}
!54 = distinct !{!54, !55, !"_ZN34_$LT$dyn$u20$std..error..Error$GT$2is17h34e90cf287841deeE: %self.1"}
!55 = distinct !{!55, !"_ZN34_$LT$dyn$u20$std..error..Error$GT$2is17h34e90cf287841deeE"}
!56 = distinct !{!56, !57, !"_ZN34_$LT$dyn$u20$std..error..Error$GT$12downcast_ref17hb6f24f19f7bfe1abE: %self.1"}
!57 = distinct !{!57, !"_ZN34_$LT$dyn$u20$std..error..Error$GT$12downcast_ref17hb6f24f19f7bfe1abE"}
!58 = distinct !{!58, !59, !"_ZN80_$LT$dyn$u20$std..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$12downcast_ref17h546d5a8b40836917E: %self.1"}
!59 = distinct !{!59, !"_ZN80_$LT$dyn$u20$std..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$12downcast_ref17h546d5a8b40836917E"}
!60 = !{!61, !50}
!61 = distinct !{!61, !62, !"_ZN9rand_core5error5Error12raw_os_error17h5461f666d3316b93E: %self"}
!62 = distinct !{!62, !"_ZN9rand_core5error5Error12raw_os_error17h5461f666d3316b93E"}
!63 = !{!64, !50}
!64 = distinct !{!64, !65, !"_ZN4core6option15Option$LT$T$GT$3map17h76a999b57c877e62E: argument 0"}
!65 = distinct !{!65, !"_ZN4core6option15Option$LT$T$GT$3map17h76a999b57c877e62E"}
!66 = !{!67, !61, !52}
!67 = distinct !{!67, !68, !"_ZN9rand_core5error5Error4code17h4b74ce7216da0ab5E: %self"}
!68 = distinct !{!68, !"_ZN9rand_core5error5Error4code17h4b74ce7216da0ab5E"}
!69 = !{!70, !72, !73, !75, !76, !78, !79, !81}
!70 = distinct !{!70, !71, !"_ZN5alloc5boxed12Box$LT$T$GT$3new17h6015e12b525f5231E: %x.0"}
!71 = distinct !{!71, !"_ZN5alloc5boxed12Box$LT$T$GT$3new17h6015e12b525f5231E"}
!72 = distinct !{!72, !71, !"_ZN5alloc5boxed12Box$LT$T$GT$3new17h6015e12b525f5231E: %x.1"}
!73 = distinct !{!73, !74, !"_ZN3std5error155_$LT$impl$u20$core..convert..From$LT$E$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$std..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$4from17he6b2395adaae5f60E: %err.0"}
!74 = distinct !{!74, !"_ZN3std5error155_$LT$impl$u20$core..convert..From$LT$E$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$std..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$4from17he6b2395adaae5f60E"}
!75 = distinct !{!75, !74, !"_ZN3std5error155_$LT$impl$u20$core..convert..From$LT$E$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$std..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$4from17he6b2395adaae5f60E: %err.1"}
!76 = distinct !{!76, !77, !"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h92e6f927a5e0fea7E: %self.0"}
!77 = distinct !{!77, !"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h92e6f927a5e0fea7E"}
!78 = distinct !{!78, !77, !"_ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h92e6f927a5e0fea7E: %self.1"}
!79 = distinct !{!79, !80, !"_ZN3std2io5error5Error3new17h0143fcc33e08ad82E: %error.0"}
!80 = distinct !{!80, !"_ZN3std2io5error5Error3new17h0143fcc33e08ad82E"}
!81 = distinct !{!81, !80, !"_ZN3std2io5error5Error3new17h0143fcc33e08ad82E: %error.1"}
!82 = !{!70, !72, !73, !75, !76, !78, !79, !81, !50, !52}
!83 = !{!52}
!84 = !{!50}
!85 = !{!86, !52}
!86 = distinct !{!86, !87, !"_ZN5alloc5alloc8box_free17hc92d77d56109ca9eE: argument 0"}
!87 = distinct !{!87, !"_ZN5alloc5alloc8box_free17hc92d77d56109ca9eE"}
!88 = !{!86}
!89 = !{!90, !92}
!90 = distinct !{!90, !91, !"_ZN73_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try..Try$GT$10from_error17hb2d9ec351a419c60E: argument 0"}
!91 = distinct !{!91, !"_ZN73_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try..Try$GT$10from_error17hb2d9ec351a419c60E"}
!92 = distinct !{!92, !91, !"_ZN73_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try..Try$GT$10from_error17hb2d9ec351a419c60E: %v"}
