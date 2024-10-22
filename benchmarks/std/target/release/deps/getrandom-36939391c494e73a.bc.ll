; ModuleID = 'getrandom-36939391c494e73a.bc'
source_filename = "getrandom.isl9n9ls-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"core::fmt::Formatter" = type { [0 x i64], { i64, i64 }, [0 x i64], { i64, i64 }, [0 x i64], { {}*, [3 x i64]* }, [0 x i32], i32, [0 x i32], i32, [0 x i8], i8, [7 x i8] }
%"core::result::Result<&str, core::str::Utf8Error>" = type { [0 x i64], i64, [2 x i64] }
%"core::fmt::DebugStruct" = type { [0 x i64], %"core::fmt::Formatter"*, [0 x i8], i8, [0 x i8], i8, [6 x i8] }
%"core::fmt::Arguments" = type { [0 x i64], { [0 x { [0 x i8]*, i64 }]*, i64 }, [0 x i64], { i64*, i64 }, [0 x i64], { [0 x { i8*, i64* }]*, i64 }, [0 x i64] }
%"libc::pollfd" = type { [0 x i32], i32, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"libc::pthread_mutex_t" = type { [0 x i8], [40 x i8], [0 x i8] }
%"core::panic::Location" = type { [0 x i64], { [0 x i8]*, i64 }, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unwind::libunwind::_Unwind_Exception" = type { [0 x i64], i64, [0 x i64], void (i32, %"unwind::libunwind::_Unwind_Exception"*)*, [0 x i64], [6 x i64], [0 x i64] }
%"unwind::libunwind::_Unwind_Context" = type { [0 x i8] }

@vtable.0 = private unnamed_addr constant { void (i32*)*, i64, i64, { i8*, i8* } (i32*)*, i64 (i32*)*, i64* (i32*)*, { [0 x i8]*, i64 } (i32*)*, { i8*, i8* } (i32*)*, i1 (i32*, %"core::fmt::Formatter"*)*, i1 (i32*, %"core::fmt::Formatter"*)* } { void (i32*)* @_ZN4core3ptr13drop_in_place17h18d63e2a0e0e1a0fE, i64 4, i64 4, { i8*, i8* } (i32*)* @_ZN3std5error5Error5cause17h4b106e26d770aab4E, i64 (i32*)* @_ZN3std5error5Error7type_id17h84116918af146addE, i64* (i32*)* @_ZN3std5error5Error9backtrace17h68d988974bb5fd13E, { [0 x i8]*, i64 } (i32*)* @_ZN3std5error5Error11description17h987835936db631e0E, { i8*, i8* } (i32*)* @_ZN3std5error5Error5cause17h4b106e26d770aab4E, i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN62_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17hf2e963bf31b2e16fE", i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN60_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h38c9dcf46759f8d7E" }, align 8
@alloc298 = private unnamed_addr constant <{ [40 x i8] }> <{ [40 x i8] c"description() is deprecated; use Display" }>, align 1
@alloc329 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"Error" }>, align 1
@alloc330 = private unnamed_addr constant <{ [12 x i8] }> <{ [12 x i8] c"unknown_code" }>, align 1
@vtable.1 = private unnamed_addr constant { void (i32*)*, i64, i64, i1 (i32*, %"core::fmt::Formatter"*)* } { void (i32*)* @_ZN4core3ptr13drop_in_place17h18d63e2a0e0e1a0fE, i64 4, i64 4, i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E" }, align 8
@alloc331 = private unnamed_addr constant <{ [13 x i8] }> <{ [13 x i8] c"internal_code" }>, align 1
@alloc334 = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"description" }>, align 1
@vtable.2 = private unnamed_addr constant { void ({ [0 x i8]*, i64 }*)*, i64, i64, i1 ({ [0 x i8]*, i64 }*, %"core::fmt::Formatter"*)* } { void ({ [0 x i8]*, i64 }*)* bitcast (void (i32*)* @_ZN4core3ptr13drop_in_place17h18d63e2a0e0e1a0fE to void ({ [0 x i8]*, i64 }*)*), i64 16, i64 8, i1 ({ [0 x i8]*, i64 }*, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h58bbe30fdb47978cE" }, align 8
@alloc333 = private unnamed_addr constant <{ [8 x i8] }> <{ [8 x i8] c"os_error" }>, align 1
@vtable.3 = private unnamed_addr constant { void (i32*)*, i64, i64, i1 (i32*, %"core::fmt::Formatter"*)* } { void (i32*)* @_ZN4core3ptr13drop_in_place17h18d63e2a0e0e1a0fE, i64 4, i64 4, i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17h1632757307ce9a5cE" }, align 8
@alloc290 = private unnamed_addr constant <{ [15 x i8] }> <{ [15 x i8] c"Unknown Error: " }>, align 1
@alloc291 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [15 x i8] }>, <{ [15 x i8] }>* @alloc290, i32 0, i32 0, i32 0), [8 x i8] c"\0F\00\00\00\00\00\00\00" }>, align 8
@alloc285 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"OS Error: " }>, align 1
@alloc286 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc285, i32 0, i32 0, i32 0), [8 x i8] c"\0A\00\00\00\00\00\00\00" }>, align 8
@alloc335 = private unnamed_addr constant <{ [48 x i8] }> <{ [48 x i8] c"Node.js API crypto.randomFillSync is unavailable" }>, align 1
@alloc336 = private unnamed_addr constant <{ [36 x i8] }> <{ [36 x i8] c"Node.js crypto module is unavailable" }>, align 1
@alloc337 = private unnamed_addr constant <{ [49 x i8] }> <{ [49 x i8] c"randSecure: VxWorks RNG module is not initialized" }>, align 1
@alloc338 = private unnamed_addr constant <{ [45 x i8] }> <{ [45 x i8] c"Web API crypto.getRandomValues is unavailable" }>, align 1
@alloc339 = private unnamed_addr constant <{ [29 x i8] }> <{ [29 x i8] c"Web Crypto API is unavailable" }>, align 1
@alloc340 = private unnamed_addr constant <{ [33 x i8] }> <{ [33 x i8] c"RDRAND: instruction not supported" }>, align 1
@alloc341 = private unnamed_addr constant <{ [47 x i8] }> <{ [47 x i8] c"RDRAND: failed multiple times: CPU issue likely" }>, align 1
@alloc342 = private unnamed_addr constant <{ [45 x i8] }> <{ [45 x i8] c"RtlGenRandom: Windows system function failure" }>, align 1
@alloc343 = private unnamed_addr constant <{ [50 x i8] }> <{ [50 x i8] c"SecRandomCopyBytes: iOS Security framework failure" }>, align 1
@alloc344 = private unnamed_addr constant <{ [38 x i8] }> <{ [38 x i8] c"errno: did not return a positive value" }>, align 1
@alloc345 = private unnamed_addr constant <{ [39 x i8] }> <{ [39 x i8] c"getrandom: this target is not supported" }>, align 1
@alloc350 = private unnamed_addr constant <{ [86 x i8] }> <{ [86 x i8] c"/root/.cargo/registry/src/github.com-1ecc6299db9ec823/getrandom-0.2.3/src/util_libc.rs" }>, align 1
@alloc351 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [86 x i8] }>, <{ [86 x i8] }>* @alloc350, i32 0, i32 0, i32 0), [16 x i8] c"V\00\00\00\00\00\00\00A\00\00\00\18\00\00\00" }>, align 8
@alloc352 = private unnamed_addr constant <{ [13 x i8] }> <{ [13 x i8] c"/dev/urandom\00" }>, align 1
@_ZN9getrandom8use_file10get_rng_fd2FD17he8cf6912f079847fE = internal unnamed_addr global <{ [8 x i8] }> <{ [8 x i8] c"\FF\FF\FF\FF\FF\FF\FF\FF" }>, align 8
@_ZN9getrandom8use_file10get_rng_fd5MUTEX17h55be784b7061b53eE = internal global <{ [40 x i8] }> zeroinitializer, align 8
@alloc353 = private unnamed_addr constant <{ [12 x i8] }> <{ [12 x i8] c"/dev/random\00" }>, align 1
@_ZN9getrandom3imp15getrandom_inner13HAS_GETRANDOM17h62473165b92ea4fdE = internal unnamed_addr global <{ [8 x i8] }> <{ [8 x i8] c"\FF\FF\FF\FF\FF\FF\FF\FF" }>, align 8
@"switch.table._ZN60_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h38c9dcf46759f8d7E" = private unnamed_addr constant [14 x i64] [i64 39, i64 38, i64 39, i64 50, i64 45, i64 47, i64 33, i64 29, i64 45, i64 39, i64 39, i64 49, i64 36, i64 48], align 8
@"switch.table._ZN60_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h38c9dcf46759f8d7E.18" = private unnamed_addr constant [14 x i8*] [i8* getelementptr inbounds (<{ [39 x i8] }>, <{ [39 x i8] }>* @alloc345, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [38 x i8] }>, <{ [38 x i8] }>* @alloc344, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [39 x i8] }>, <{ [39 x i8] }>* @alloc345, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [50 x i8] }>, <{ [50 x i8] }>* @alloc343, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [45 x i8] }>, <{ [45 x i8] }>* @alloc342, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [47 x i8] }>, <{ [47 x i8] }>* @alloc341, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [33 x i8] }>, <{ [33 x i8] }>* @alloc340, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [29 x i8] }>, <{ [29 x i8] }>* @alloc339, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [45 x i8] }>, <{ [45 x i8] }>* @alloc338, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [39 x i8] }>, <{ [39 x i8] }>* @alloc345, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [39 x i8] }>, <{ [39 x i8] }>* @alloc345, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [49 x i8] }>, <{ [49 x i8] }>* @alloc337, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [36 x i8] }>, <{ [36 x i8] }>* @alloc336, i64 0, i32 0, i64 0), i8* getelementptr inbounds (<{ [48 x i8] }>, <{ [48 x i8] }>* @alloc335, i64 0, i32 0, i64 0)], align 8

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal { [0 x i8]*, i64 } @_ZN3std5error5Error11description17h987835936db631e0E(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #0 {
start:
  ret { [0 x i8]*, i64 } { [0 x i8]* bitcast (<{ [40 x i8] }>* @alloc298 to [0 x i8]*), i64 40 }
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal { i8*, i8* } @_ZN3std5error5Error5cause17h4b106e26d770aab4E(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #0 {
start:
  ret { i8*, i8* } { i8* null, i8* undef }
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal i64 @_ZN3std5error5Error7type_id17h84116918af146addE(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #0 {
start:
  ret i64 3674886053576987189
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal mpk_immut noalias align 8 dereferenceable_or_null(64) i64* @_ZN3std5error5Error9backtrace17h68d988974bb5fd13E(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #0 {
start:
  ret i64* null
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h58bbe30fdb47978cE"({ [0 x i8]*, i64 }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %0 = getelementptr inbounds { [0 x i8]*, i64 }, { [0 x i8]*, i64 }* %self, i64 0, i32 0
  %_4.0 = load [0 x i8]*, [0 x i8]** %0, align 8, !nonnull !2
  %1 = getelementptr inbounds { [0 x i8]*, i64 }, { [0 x i8]*, i64 }* %self, i64 0, i32 1
  %_4.1 = load i64, i64* %1, align 8
  %2 = tail call zeroext i1 @"_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17h9f4869c9c7acbf05E"([0 x i8]* mpk_immut noalias nonnull readonly align 1 %_4.0, i64 %_4.1, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  ret i1 %2
}

; Function Attrs: inlinehint nonlazybind uwtable
define internal zeroext i1 @"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17h1632757307ce9a5cE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #2 {
start:
  %_3 = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_3, label %bb3, label %bb2

bb2:                                              ; preds = %start
  %_7 = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7, label %bb7, label %bb6

bb3:                                              ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17h3eaaf3997f8f438aE"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb6:                                              ; preds = %bb2
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h614ff315f5bd3ea6E"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb7:                                              ; preds = %bb2
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h08e994e256867223E"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb11:                                             ; preds = %bb7, %bb6, %bb3
  %.0.in = phi i1 [ %0, %bb3 ], [ %2, %bb7 ], [ %1, %bb6 ]
  ret i1 %.0.in
}

; Function Attrs: inlinehint nonlazybind uwtable
define internal zeroext i1 @"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #2 {
start:
  %_3 = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_3, label %bb3, label %bb2

bb2:                                              ; preds = %start
  %_7 = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7, label %bb7, label %bb6

bb3:                                              ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hbdab60765508c6f3E"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb6:                                              ; preds = %bb2
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h6b8b41e24df1a43fE"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb7:                                              ; preds = %bb2
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h4773017a326a508bE"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb11:                                             ; preds = %bb7, %bb6, %bb3
  %.0.in = phi i1 [ %0, %bb3 ], [ %2, %bb7 ], [ %1, %bb6 ]
  ret i1 %.0.in
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal void @_ZN4core3ptr13drop_in_place17h18d63e2a0e0e1a0fE(i32* mpk_unsafe nocapture %_1) unnamed_addr #0 {
start:
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define i32 @_ZN9getrandom5error14internal_error17h0a129fb4ae84379bE(i16 %n) unnamed_addr #0 {
start:
  %_3 = zext i16 %n to i32
  %code1 = or i32 %_3, -2147483648
  ret i32 %code1
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN60_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h38c9dcf46759f8d7E"(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_20.i = alloca %"core::result::Result<&str, core::str::Utf8Error>", align 8
  %_60 = alloca i32, align 4
  %_44 = alloca i32, align 4
  %desc = alloca { [0 x i8]*, i64 }, align 8
  %err = alloca { [0 x i8]*, i64 }, align 8
  %buf = alloca [128 x i8], align 1
  %errno = alloca i32, align 4
  %dbg = alloca %"core::fmt::DebugStruct", align 8
  %0 = bitcast %"core::fmt::DebugStruct"* %dbg to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc329 to [0 x i8]*), i64 5)
  %.0..sroa_cast = bitcast %"core::fmt::DebugStruct"* %dbg to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %_8 = load i32, i32* %self, align 4, !range !3
  %2 = icmp sgt i32 %_8, -1
  br i1 %2, label %bb4, label %bb3

bb3:                                              ; preds = %start
  %switch.tableidx = xor i32 %_8, -2147483648
  %3 = icmp ult i32 %switch.tableidx, 14
  br i1 %3, label %switch.hole_check, label %bb12

bb4:                                              ; preds = %start
  %4 = bitcast i32* %errno to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4)
  store i32 %_8, i32* %errno, align 4
  %_15.0 = bitcast i32* %errno to {}*
  %_11 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %dbg, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc333 to [0 x i8]*), i64 8, {}* mpk_immut nonnull align 1 %_15.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32*)*, i64, i64, i1 (i32*, %"core::fmt::Formatter"*)* }* @vtable.3 to [3 x i64]*))
  %5 = getelementptr inbounds [128 x i8], [128 x i8]* %buf, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %5)
  call void @llvm.memset.p0i8.i64(i8* nonnull align 1 dereferenceable(128) %5, i8 0, i64 128, i1 false)
  %_20 = load i32, i32* %errno, align 4
  %_21.0 = bitcast [128 x i8]* %buf to [0 x i8]*
  %_6.i = call i32 @__xpg_strerror_r(i32 %_20, i8* mpk_unsafe nonnull %5, i64 128)
  %6 = icmp eq i32 %_6.i, 0
  br i1 %6, label %bb4.i, label %bb10

bb4.i:                                            ; preds = %bb4
  %7 = getelementptr inbounds [128 x i8], [128 x i8]* %buf, i64 0, i64 128
  br label %bb14.i.i

bb14.i.i:                                         ; preds = %bb16.i.i.3, %bb4.i
  %_15.i26.i.i = phi i8* [ %5, %bb4.i ], [ %35, %bb16.i.i.3 ]
  %i.025.i.i = phi i64 [ 0, %bb4.i ], [ %_37.0.i.i.3, %bb16.i.i.3 ]
  %.val.i.i = load i8, i8* %_15.i26.i.i, align 1
  %8 = icmp eq i8 %.val.i.i, 0
  br i1 %8, label %.split.loop.exit37, label %bb16.i.i

bb16.i.i:                                         ; preds = %bb14.i.i
  %9 = getelementptr inbounds i8, i8* %_15.i26.i.i, i64 1
  %.val.i.i.1 = load i8, i8* %9, align 1
  %10 = icmp eq i8 %.val.i.i.1, 0
  br i1 %10, label %.split.loop.exit35, label %bb16.i.i.1

.thread.i:                                        ; preds = %bb16.i.i.3
  %11 = bitcast %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %11)
  br label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i"

.split.loop.exit:                                 ; preds = %bb16.i.i.2
  %_37.0.i.i.2.le = or i64 %i.025.i.i, 3
  br label %.split.loop.exit37

.split.loop.exit33:                               ; preds = %bb16.i.i.1
  %_37.0.i.i.1.le = or i64 %i.025.i.i, 2
  br label %.split.loop.exit37

.split.loop.exit35:                               ; preds = %bb16.i.i
  %_37.0.i.i.le = or i64 %i.025.i.i, 1
  br label %.split.loop.exit37

.split.loop.exit37:                               ; preds = %.split.loop.exit35, %.split.loop.exit33, %.split.loop.exit, %bb14.i.i
  %i.025.i.i.lcssa = phi i64 [ %_37.0.i.i.2.le, %.split.loop.exit ], [ %_37.0.i.i.1.le, %.split.loop.exit33 ], [ %_37.0.i.i.le, %.split.loop.exit35 ], [ %i.025.i.i, %bb14.i.i ]
  %_33.i.i = icmp ult i64 %i.025.i.i.lcssa, 128
  call void @llvm.assume(i1 %_33.i.i) #11
  %12 = bitcast %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %12)
  br label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i"

"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i": ; preds = %.split.loop.exit37, %.thread.i
  %13 = phi i8* [ %11, %.thread.i ], [ %12, %.split.loop.exit37 ]
  %14 = phi i64 [ 128, %.thread.i ], [ %i.025.i.i.lcssa, %.split.loop.exit37 ]
  call void @_ZN4core3str8converts9from_utf817h5fef343fb410e7cdE(%"core::result::Result<&str, core::str::Utf8Error>"* noalias nocapture nonnull sret dereferenceable(24) %_20.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 %_21.0, i64 %14)
  %15 = getelementptr inbounds %"core::result::Result<&str, core::str::Utf8Error>", %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i, i64 0, i32 0, i64 0
  %_2.i.i = load i64, i64* %15, align 8, !range !4, !alias.scope !5
  %switch.not.i.i = icmp eq i64 %_2.i.i, 1
  %16 = getelementptr inbounds %"core::result::Result<&str, core::str::Utf8Error>", %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i, i64 0, i32 2
  %17 = bitcast [2 x i64]* %16 to i8**
  %x.02.i.i = load i8*, i8** %17, align 8
  %18 = getelementptr inbounds %"core::result::Result<&str, core::str::Utf8Error>", %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i, i64 0, i32 2, i64 1
  %x.1.i.i = load i64, i64* %18, align 8
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %13)
  %.not14 = icmp eq i8* %x.02.i.i, null
  %or.cond = or i1 %switch.not.i.i, %.not14
  br i1 %or.cond, label %bb10, label %bb8

bb8:                                              ; preds = %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i"
  %19 = bitcast { [0 x i8]*, i64 }* %err to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %19)
  %20 = bitcast { [0 x i8]*, i64 }* %err to i8**
  store i8* %x.02.i.i, i8** %20, align 8
  %21 = getelementptr inbounds { [0 x i8]*, i64 }, { [0 x i8]*, i64 }* %err, i64 0, i32 1
  store i64 %x.1.i.i, i64* %21, align 8
  %_30.0 = bitcast { [0 x i8]*, i64 }* %err to {}*
  %_26 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %dbg, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [11 x i8] }>* @alloc334 to [0 x i8]*), i64 11, {}* mpk_immut nonnull align 1 %_30.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ [0 x i8]*, i64 }*)*, i64, i64, i1 ({ [0 x i8]*, i64 }*, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %19)
  br label %bb10

bb10:                                             ; preds = %bb8, %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i", %bb4
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %5)
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4)
  br label %bb20

bb12:                                             ; preds = %switch.hole_check, %bb3
  %22 = bitcast i32* %_60 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %22)
  store i32 %_8, i32* %_60, align 4
  %_57.0 = bitcast i32* %_60 to {}*
  %_53 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %dbg, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [12 x i8] }>* @alloc330 to [0 x i8]*), i64 12, {}* mpk_immut nonnull align 1 %_57.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32*)*, i64, i64, i1 (i32*, %"core::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %22)
  br label %bb20

switch.hole_check:                                ; preds = %bb3
  %switch.maskindex = trunc i32 %_8 to i16
  %switch.shifted = lshr i16 14843, %switch.maskindex
  %23 = and i16 %switch.shifted, 1
  %switch.lobit.not = icmp eq i16 %23, 0
  br i1 %switch.lobit.not, label %bb12, label %switch.lookup

switch.lookup:                                    ; preds = %switch.hole_check
  %24 = sext i32 %switch.tableidx to i64
  %switch.gep = getelementptr inbounds [14 x i64], [14 x i64]* @"switch.table._ZN60_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h38c9dcf46759f8d7E", i64 0, i64 %24
  %switch.load = load i64, i64* %switch.gep, align 8
  %25 = sext i32 %switch.tableidx to i64
  %switch.gep29 = getelementptr inbounds [14 x i8*], [14 x i8*]* @"switch.table._ZN60_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h38c9dcf46759f8d7E.18", i64 0, i64 %25
  %26 = bitcast i8** %switch.gep29 to i64*
  %switch.load3031 = load i64, i64* %26, align 8
  %27 = bitcast { [0 x i8]*, i64 }* %desc to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %27)
  %28 = bitcast { [0 x i8]*, i64 }* %desc to i64*
  store i64 %switch.load3031, i64* %28, align 8
  %29 = getelementptr inbounds { [0 x i8]*, i64 }, { [0 x i8]*, i64 }* %desc, i64 0, i32 1
  store i64 %switch.load, i64* %29, align 8
  %30 = bitcast i32* %_44 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %30)
  store i32 %_8, i32* %_44, align 4
  %_41.0 = bitcast i32* %_44 to {}*
  %_37 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %dbg, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [13 x i8] }>* @alloc331 to [0 x i8]*), i64 13, {}* mpk_immut nonnull align 1 %_41.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32*)*, i64, i64, i1 (i32*, %"core::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %30)
  %_50.0 = bitcast { [0 x i8]*, i64 }* %desc to {}*
  %_46 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %dbg, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [11 x i8] }>* @alloc334 to [0 x i8]*), i64 11, {}* mpk_immut nonnull align 1 %_50.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ [0 x i8]*, i64 }*)*, i64, i64, i1 ({ [0 x i8]*, i64 }*, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %27)
  br label %bb20

bb20:                                             ; preds = %switch.lookup, %bb12, %bb10
  %31 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %dbg)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %31

bb16.i.i.1:                                       ; preds = %bb16.i.i
  %32 = getelementptr inbounds i8, i8* %_15.i26.i.i, i64 2
  %.val.i.i.2 = load i8, i8* %32, align 1
  %33 = icmp eq i8 %.val.i.i.2, 0
  br i1 %33, label %.split.loop.exit33, label %bb16.i.i.2

bb16.i.i.2:                                       ; preds = %bb16.i.i.1
  %34 = getelementptr inbounds i8, i8* %_15.i26.i.i, i64 3
  %35 = getelementptr inbounds i8, i8* %_15.i26.i.i, i64 4
  %.val.i.i.3 = load i8, i8* %34, align 1
  %36 = icmp eq i8 %.val.i.i.3, 0
  br i1 %36, label %.split.loop.exit, label %bb16.i.i.3

bb16.i.i.3:                                       ; preds = %bb16.i.i.2
  %_37.0.i.i.3 = add nuw nsw i64 %i.025.i.i, 4
  %_12.i.i.i.3 = icmp eq i8* %35, %7
  br i1 %_12.i.i.i.3, label %.thread.i, label %bb14.i.i
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN62_$LT$getrandom..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17hf2e963bf31b2e16fE"(i32* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_20.i = alloca %"core::result::Result<&str, core::str::Utf8Error>", align 8
  %_49 = alloca i32, align 4
  %_46 = alloca [1 x { i8*, i64* }], align 8
  %_39 = alloca %"core::fmt::Arguments", align 8
  %_25 = alloca [1 x { i8*, i64* }], align 8
  %_18 = alloca %"core::fmt::Arguments", align 8
  %buf = alloca [128 x i8], align 1
  %errno = alloca i32, align 4
  %_4 = load i32, i32* %self, align 4, !range !3
  %0 = icmp sgt i32 %_4, -1
  br i1 %0, label %bb3, label %bb2

bb2:                                              ; preds = %start
  switch i32 %_4, label %bb14 [
    i32 -2147483648, label %bb15
    i32 -2147483647, label %bb3.i
    i32 -2147483645, label %bb4.i15
    i32 -2147483644, label %bb5.i
    i32 -2147483643, label %bb6.i
    i32 -2147483642, label %bb7.i
    i32 -2147483641, label %bb8.i
    i32 -2147483640, label %bb9.i
    i32 -2147483637, label %bb10.i
    i32 -2147483636, label %bb11.i
    i32 -2147483635, label %bb12.i
  ]

bb3.i:                                            ; preds = %bb2
  br label %bb15

bb4.i15:                                          ; preds = %bb2
  br label %bb15

bb5.i:                                            ; preds = %bb2
  br label %bb15

bb6.i:                                            ; preds = %bb2
  br label %bb15

bb7.i:                                            ; preds = %bb2
  br label %bb15

bb8.i:                                            ; preds = %bb2
  br label %bb15

bb9.i:                                            ; preds = %bb2
  br label %bb15

bb10.i:                                           ; preds = %bb2
  br label %bb15

bb11.i:                                           ; preds = %bb2
  br label %bb15

bb12.i:                                           ; preds = %bb2
  br label %bb15

bb3:                                              ; preds = %start
  %1 = bitcast i32* %errno to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %1)
  store i32 %_4, i32* %errno, align 4
  %2 = getelementptr inbounds [128 x i8], [128 x i8]* %buf, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %2)
  call void @llvm.memset.p0i8.i64(i8* nonnull align 1 dereferenceable(128) %2, i8 0, i64 128, i1 false)
  %_10.0 = bitcast [128 x i8]* %buf to [0 x i8]*
  %_6.i = call i32 @__xpg_strerror_r(i32 %_4, i8* mpk_unsafe nonnull %2, i64 128)
  %3 = icmp eq i32 %_6.i, 0
  br i1 %3, label %bb4.i, label %bb5

bb4.i:                                            ; preds = %bb3
  %4 = getelementptr inbounds [128 x i8], [128 x i8]* %buf, i64 0, i64 128
  br label %bb14.i.i

bb14.i.i:                                         ; preds = %bb16.i.i.3, %bb4.i
  %_15.i26.i.i = phi i8* [ %2, %bb4.i ], [ %47, %bb16.i.i.3 ]
  %i.025.i.i = phi i64 [ 0, %bb4.i ], [ %_37.0.i.i.3, %bb16.i.i.3 ]
  %.val.i.i = load i8, i8* %_15.i26.i.i, align 1
  %5 = icmp eq i8 %.val.i.i, 0
  br i1 %5, label %.split.loop.exit33, label %bb16.i.i

bb16.i.i:                                         ; preds = %bb14.i.i
  %6 = getelementptr inbounds i8, i8* %_15.i26.i.i, i64 1
  %.val.i.i.1 = load i8, i8* %6, align 1
  %7 = icmp eq i8 %.val.i.i.1, 0
  br i1 %7, label %.split.loop.exit31, label %bb16.i.i.1

.thread.i:                                        ; preds = %bb16.i.i.3
  %8 = bitcast %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %8)
  br label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i"

.split.loop.exit:                                 ; preds = %bb16.i.i.2
  %_37.0.i.i.2.le = or i64 %i.025.i.i, 3
  br label %.split.loop.exit33

.split.loop.exit29:                               ; preds = %bb16.i.i.1
  %_37.0.i.i.1.le = or i64 %i.025.i.i, 2
  br label %.split.loop.exit33

.split.loop.exit31:                               ; preds = %bb16.i.i
  %_37.0.i.i.le = or i64 %i.025.i.i, 1
  br label %.split.loop.exit33

.split.loop.exit33:                               ; preds = %.split.loop.exit31, %.split.loop.exit29, %.split.loop.exit, %bb14.i.i
  %i.025.i.i.lcssa = phi i64 [ %_37.0.i.i.2.le, %.split.loop.exit ], [ %_37.0.i.i.1.le, %.split.loop.exit29 ], [ %_37.0.i.i.le, %.split.loop.exit31 ], [ %i.025.i.i, %bb14.i.i ]
  %_33.i.i = icmp ult i64 %i.025.i.i.lcssa, 128
  call void @llvm.assume(i1 %_33.i.i) #11
  %9 = bitcast %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %9)
  br label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i"

"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i": ; preds = %.split.loop.exit33, %.thread.i
  %10 = phi i8* [ %8, %.thread.i ], [ %9, %.split.loop.exit33 ]
  %11 = phi i64 [ 128, %.thread.i ], [ %i.025.i.i.lcssa, %.split.loop.exit33 ]
  call void @_ZN4core3str8converts9from_utf817h5fef343fb410e7cdE(%"core::result::Result<&str, core::str::Utf8Error>"* noalias nocapture nonnull sret dereferenceable(24) %_20.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 %_10.0, i64 %11)
  %12 = getelementptr inbounds %"core::result::Result<&str, core::str::Utf8Error>", %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i, i64 0, i32 0, i64 0
  %_2.i.i = load i64, i64* %12, align 8, !range !4, !alias.scope !8
  %switch.not.i.i = icmp eq i64 %_2.i.i, 1
  %13 = getelementptr inbounds %"core::result::Result<&str, core::str::Utf8Error>", %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i, i64 0, i32 2
  %14 = bitcast [2 x i64]* %13 to i8**
  %x.02.i.i = load i8*, i8** %14, align 8
  %15 = getelementptr inbounds %"core::result::Result<&str, core::str::Utf8Error>", %"core::result::Result<&str, core::str::Utf8Error>"* %_20.i, i64 0, i32 2, i64 1
  %x.1.i.i = load i64, i64* %15, align 8
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %10)
  %16 = icmp eq i8* %x.02.i.i, null
  %or.cond = or i1 %switch.not.i.i, %16
  br i1 %or.cond, label %bb5, label %bb7

bb5:                                              ; preds = %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i", %bb3
  %17 = bitcast %"core::fmt::Arguments"* %_18 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %17)
  %18 = bitcast [1 x { i8*, i64* }]* %_25 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %18)
  %19 = bitcast [1 x { i8*, i64* }]* %_25 to i32**
  store i32* %errno, i32** %19, align 8
  %20 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_25, i64 0, i64 0, i32 1
  store i64* bitcast (i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h614ff315f5bd3ea6E" to i64*), i64** %20, align 8
  %21 = bitcast %"core::fmt::Arguments"* %_18 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc286 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %21, align 8, !alias.scope !11, !noalias !14
  %22 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_18, i64 0, i32 1, i32 1
  store i64 1, i64* %22, align 8, !alias.scope !11, !noalias !14
  %23 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_18, i64 0, i32 3, i32 0
  store i64* null, i64** %23, align 8, !alias.scope !11, !noalias !14
  %24 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_18, i64 0, i32 5, i32 0
  %25 = bitcast [0 x { i8*, i64* }]** %24 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_25, [1 x { i8*, i64* }]** %25, align 8, !alias.scope !11, !noalias !14
  %26 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_18, i64 0, i32 5, i32 1
  store i64 1, i64* %26, align 8, !alias.scope !11, !noalias !14
  %27 = call zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, %"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_18)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %18)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %17)
  br label %bb12

bb7:                                              ; preds = %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h753b8f80512945d9E.exit.i"
  %28 = bitcast i8* %x.02.i.i to [0 x i8]*
  %29 = call zeroext i1 @"_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h8d32920bf513d1aeE"([0 x i8]* mpk_immut noalias nonnull readonly align 1 %28, i64 %x.1.i.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb12

bb12:                                             ; preds = %bb7, %bb5
  %.0 = phi i1 [ %27, %bb5 ], [ %29, %bb7 ]
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %1)
  br label %bb22

bb14:                                             ; preds = %bb2
  %30 = bitcast %"core::fmt::Arguments"* %_39 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %30)
  %31 = bitcast [1 x { i8*, i64* }]* %_46 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %31)
  %32 = bitcast i32* %_49 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %32)
  store i32 %_4, i32* %_49, align 4
  %33 = bitcast [1 x { i8*, i64* }]* %_46 to i32**
  store i32* %_49, i32** %33, align 8
  %34 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_46, i64 0, i64 0, i32 1
  store i64* bitcast (i1 (i32*, %"core::fmt::Formatter"*)* @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h6b8b41e24df1a43fE" to i64*), i64** %34, align 8
  %35 = bitcast %"core::fmt::Arguments"* %_39 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc291 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %35, align 8, !alias.scope !17, !noalias !20
  %36 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_39, i64 0, i32 1, i32 1
  store i64 1, i64* %36, align 8, !alias.scope !17, !noalias !20
  %37 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_39, i64 0, i32 3, i32 0
  store i64* null, i64** %37, align 8, !alias.scope !17, !noalias !20
  %38 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_39, i64 0, i32 5, i32 0
  %39 = bitcast [0 x { i8*, i64* }]** %38 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_46, [1 x { i8*, i64* }]** %39, align 8, !alias.scope !17, !noalias !20
  %40 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_39, i64 0, i32 5, i32 1
  store i64 1, i64* %40, align 8, !alias.scope !17, !noalias !20
  %41 = call zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, %"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_39)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %30)
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %32)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %31)
  br label %bb22

bb15:                                             ; preds = %bb12.i, %bb11.i, %bb10.i, %bb9.i, %bb8.i, %bb7.i, %bb6.i, %bb5.i, %bb4.i15, %bb3.i, %bb2
  %.sroa.13.0.i.ph = phi i64 [ 38, %bb3.i ], [ 50, %bb4.i15 ], [ 45, %bb5.i ], [ 47, %bb6.i ], [ 33, %bb7.i ], [ 29, %bb8.i ], [ 45, %bb9.i ], [ 49, %bb10.i ], [ 36, %bb11.i ], [ 48, %bb12.i ], [ 39, %bb2 ]
  %42 = phi [0 x i8]* [ bitcast (<{ [38 x i8] }>* @alloc344 to [0 x i8]*), %bb3.i ], [ bitcast (<{ [50 x i8] }>* @alloc343 to [0 x i8]*), %bb4.i15 ], [ bitcast (<{ [45 x i8] }>* @alloc342 to [0 x i8]*), %bb5.i ], [ bitcast (<{ [47 x i8] }>* @alloc341 to [0 x i8]*), %bb6.i ], [ bitcast (<{ [33 x i8] }>* @alloc340 to [0 x i8]*), %bb7.i ], [ bitcast (<{ [29 x i8] }>* @alloc339 to [0 x i8]*), %bb8.i ], [ bitcast (<{ [45 x i8] }>* @alloc338 to [0 x i8]*), %bb9.i ], [ bitcast (<{ [49 x i8] }>* @alloc337 to [0 x i8]*), %bb10.i ], [ bitcast (<{ [36 x i8] }>* @alloc336 to [0 x i8]*), %bb11.i ], [ bitcast (<{ [48 x i8] }>* @alloc335 to [0 x i8]*), %bb12.i ], [ bitcast (<{ [39 x i8] }>* @alloc345 to [0 x i8]*), %bb2 ]
  %43 = tail call zeroext i1 @_ZN4core3fmt9Formatter9write_str17hdd0117a4487b56c4E(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 %42, i64 %.sroa.13.0.i.ph)
  br label %bb22

bb22:                                             ; preds = %bb15, %bb14, %bb12
  %.2 = phi i1 [ %.0, %bb12 ], [ %43, %bb15 ], [ %41, %bb14 ]
  ret i1 %.2

bb16.i.i.1:                                       ; preds = %bb16.i.i
  %44 = getelementptr inbounds i8, i8* %_15.i26.i.i, i64 2
  %.val.i.i.2 = load i8, i8* %44, align 1
  %45 = icmp eq i8 %.val.i.i.2, 0
  br i1 %45, label %.split.loop.exit29, label %bb16.i.i.2

bb16.i.i.2:                                       ; preds = %bb16.i.i.1
  %46 = getelementptr inbounds i8, i8* %_15.i26.i.i, i64 3
  %47 = getelementptr inbounds i8, i8* %_15.i26.i.i, i64 4
  %.val.i.i.3 = load i8, i8* %46, align 1
  %48 = icmp eq i8 %.val.i.i.3, 0
  br i1 %48, label %.split.loop.exit, label %bb16.i.i.3

bb16.i.i.3:                                       ; preds = %bb16.i.i.2
  %_37.0.i.i.3 = add nuw nsw i64 %i.025.i.i, 4
  %_12.i.i.i.3 = icmp eq i8* %47, %4
  br i1 %_12.i.i.i.3, label %.thread.i, label %bb14.i.i
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define i32 @"_ZN101_$LT$getrandom..error..Error$u20$as$u20$core..convert..From$LT$core..num..nonzero..NonZeroU32$GT$$GT$4from17h642716db17bed307E"(i32 returned %code) unnamed_addr #0 {
start:
  ret i32 %code
}

; Function Attrs: nonlazybind uwtable
define i128 @"_ZN9getrandom11error_impls102_$LT$impl$u20$core..convert..From$LT$getrandom..error..Error$GT$$u20$for$u20$std..io..error..Error$GT$4from17h0d2c53d3dc09c315E"(i32 %err) unnamed_addr #1 {
start:
  %switch = icmp slt i32 %err, 0
  br i1 %switch, label %bb2, label %bb4

bb2:                                              ; preds = %start
  %0 = tail call mpk_unsafe dereferenceable_or_null(4) i8* @__rust_alloc(i64 4, i64 4) #11
  %1 = icmp eq i8* %0, null
  br i1 %1, label %bb3.i.i.i.i.i, label %_ZN3std2io5error5Error3new17hc37535c6a0169f8aE.exit

bb3.i.i.i.i.i:                                    ; preds = %bb2
  tail call void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64 4, i64 4) #11
  unreachable

_ZN3std2io5error5Error3new17hc37535c6a0169f8aE.exit: ; preds = %bb2
  %2 = bitcast i8* %0 to i32*
  store i32 %err, i32* %2, align 4
  %3 = bitcast i8* %0 to {}*
  %4 = tail call i128 @_ZN3std2io5error5Error4_new17h4dbd541810de7dbdE(i8 16, {}* mpk_immut noalias nonnull align 1 %3, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32*)*, i64, i64, { i8*, i8* } (i32*)*, i64 (i32*)*, i64* (i32*)*, { [0 x i8]*, i64 } (i32*)*, { i8*, i8* } (i32*)*, i1 (i32*, %"core::fmt::Formatter"*)*, i1 (i32*, %"core::fmt::Formatter"*)* }* @vtable.0 to [3 x i64]*))
  br label %bb7

bb4:                                              ; preds = %start
  %5 = tail call i128 @_ZN3std2io5error5Error17from_raw_os_error17hb36e5239199ebffeE(i32 %err)
  br label %bb7

bb7:                                              ; preds = %bb4, %_ZN3std2io5error5Error3new17hc37535c6a0169f8aE.exit
  %.sroa.0.0 = phi i128 [ %4, %_ZN3std2io5error5Error3new17hc37535c6a0169f8aE.exit ], [ %5, %bb4 ]
  ret i128 %.sroa.0.0
}

; Function Attrs: nonlazybind uwtable
define i32 @_ZN9getrandom9getrandom17h5fda40e5c88ad1f2E([0 x i8]* nonnull align 1 %dest.0, i64 %dest.1) unnamed_addr #1 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %pfd.i.i.i.i = alloca %"libc::pollfd", align 4
  %0 = icmp eq i64 %dest.1, 0
  br i1 %0, label %bb5, label %bb2

bb2:                                              ; preds = %start
  %1 = load atomic i64, i64* bitcast (<{ [8 x i8] }>* @_ZN9getrandom3imp15getrandom_inner13HAS_GETRANDOM17h62473165b92ea4fdE to i64*) monotonic, align 8
  %_6.i.i.i = icmp eq i64 %1, -1
  br i1 %_6.i.i.i, label %bb3.i.i.i, label %_ZN9getrandom4util8LazyBool11unsync_init17h50be71a695da3dfcE.exit.i

bb3.i.i.i:                                        ; preds = %bb2
  %_4.i.i.i.i.i.i.i = tail call i64 (i64, ...) @syscall(i64 318, i8* mpk_unsafe null, i64 0, i32 1) #11
  %_3.i.i.i.i.i.i = icmp slt i64 %_4.i.i.i.i.i.i.i, 0
  br i1 %_3.i.i.i.i.i.i, label %bb4.i.i.i.i.i.i, label %"_ZN9getrandom4util8LazyBool11unsync_init28_$u7b$$u7b$closure$u7d$$u7d$17h9d5edad55622e4cbE.exit.i.i.i"

bb4.i.i.i.i.i.i:                                  ; preds = %bb3.i.i.i
  %_1.i.i.i.i.i.i.i.i = tail call mpk_unsafe i32* @__errno_location() #11
  %2 = load i32, i32* %_1.i.i.i.i.i.i.i.i, align 4
  %_2.i.i.i.i.i.i.i = icmp sgt i32 %2, 0
  %spec.select.i.i.i.i.i.i.i = select i1 %_2.i.i.i.i.i.i.i, i32 %2, i32 -2147483647
  %3 = icmp sgt i32 %spec.select.i.i.i.i.i.i.i, -1
  br i1 %3, label %bb8.i.i.i.i.i.i, label %"_ZN9getrandom4util8LazyBool11unsync_init28_$u7b$$u7b$closure$u7d$$u7d$17h9d5edad55622e4cbE.exit.i.i.i"

bb8.i.i.i.i.i.i:                                  ; preds = %bb4.i.i.i.i.i.i
  switch i32 %spec.select.i.i.i.i.i.i.i, label %"_ZN9getrandom4util8LazyBool11unsync_init28_$u7b$$u7b$closure$u7d$$u7d$17h9d5edad55622e4cbE.exit.i.i.i" [
    i32 38, label %bb9.i.i.i.i.i.i
    i32 1, label %bb10.i.i.i.i.i.i
  ]

bb9.i.i.i.i.i.i:                                  ; preds = %bb8.i.i.i.i.i.i
  br label %"_ZN9getrandom4util8LazyBool11unsync_init28_$u7b$$u7b$closure$u7d$$u7d$17h9d5edad55622e4cbE.exit.i.i.i"

bb10.i.i.i.i.i.i:                                 ; preds = %bb8.i.i.i.i.i.i
  br label %"_ZN9getrandom4util8LazyBool11unsync_init28_$u7b$$u7b$closure$u7d$$u7d$17h9d5edad55622e4cbE.exit.i.i.i"

"_ZN9getrandom4util8LazyBool11unsync_init28_$u7b$$u7b$closure$u7d$$u7d$17h9d5edad55622e4cbE.exit.i.i.i": ; preds = %bb10.i.i.i.i.i.i, %bb9.i.i.i.i.i.i, %bb8.i.i.i.i.i.i, %bb4.i.i.i.i.i.i, %bb3.i.i.i
  %.1.i.i.i.i.i.i = phi i64 [ 1, %bb3.i.i.i ], [ 0, %bb10.i.i.i.i.i.i ], [ 0, %bb9.i.i.i.i.i.i ], [ 1, %bb8.i.i.i.i.i.i ], [ 1, %bb4.i.i.i.i.i.i ]
  store atomic i64 %.1.i.i.i.i.i.i, i64* bitcast (<{ [8 x i8] }>* @_ZN9getrandom3imp15getrandom_inner13HAS_GETRANDOM17h62473165b92ea4fdE to i64*) monotonic, align 8
  br label %_ZN9getrandom4util8LazyBool11unsync_init17h50be71a695da3dfcE.exit.i

_ZN9getrandom4util8LazyBool11unsync_init17h50be71a695da3dfcE.exit.i: ; preds = %"_ZN9getrandom4util8LazyBool11unsync_init28_$u7b$$u7b$closure$u7d$$u7d$17h9d5edad55622e4cbE.exit.i.i.i", %bb2
  %val.0.i.i.i = phi i64 [ %1, %bb2 ], [ %.1.i.i.i.i.i.i, %"_ZN9getrandom4util8LazyBool11unsync_init28_$u7b$$u7b$closure$u7d$$u7d$17h9d5edad55622e4cbE.exit.i.i.i" ]
  %.not.i = icmp eq i64 %val.0.i.i.i, 0
  br i1 %.not.i, label %bb2.i, label %bb4.i.i

bb2.i:                                            ; preds = %_ZN9getrandom4util8LazyBool11unsync_init17h50be71a695da3dfcE.exit.i
  %4 = load atomic i64, i64* bitcast (<{ [8 x i8] }>* @_ZN9getrandom8use_file10get_rng_fd2FD17he8cf6912f079847fE to i64*) monotonic, align 8
  %.not.i.i.i = icmp eq i64 %4, -1
  %_6.i.i.i.i = trunc i64 %4 to i32
  br i1 %.not.i.i.i, label %bb5.i.i.i, label %bb3.i.i

bb5.i.i.i:                                        ; preds = %bb2.i
  %r.i.i.i.i = tail call i32 @pthread_mutex_lock(%"libc::pthread_mutex_t"* mpk_unsafe bitcast (<{ [40 x i8] }>* @_ZN9getrandom8use_file10get_rng_fd5MUTEX17h55be784b7061b53eE to %"libc::pthread_mutex_t"*)) #11
  %5 = load atomic i64, i64* bitcast (<{ [8 x i8] }>* @_ZN9getrandom8use_file10get_rng_fd2FD17he8cf6912f079847fE to i64*) monotonic, align 8
  %.not67.i.i.i = icmp eq i64 %5, -1
  br i1 %.not67.i.i.i, label %bb6.i.i.i, label %_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.i

bb6.i.i.i:                                        ; preds = %bb5.i.i.i
  %6 = getelementptr <{ [12 x i8] }>, <{ [12 x i8] }>* @alloc353, i64 0, i32 0, i64 0
  %fd.i.i.i.i.i = tail call i32 (i8*, i32, ...) @open64(i8* mpk_immut mpk_unsafe nonnull %6, i32 524288) #11
  %_12.i.i.i.i.i = icmp slt i32 %fd.i.i.i.i.i, 0
  br i1 %_12.i.i.i.i.i, label %bb5.i.i.i.i, label %bb3.i.i.i.i

bb3.i.i.i.i:                                      ; preds = %bb6.i.i.i
  %7 = bitcast %"libc::pollfd"* %pfd.i.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %7) #11
  %8 = getelementptr inbounds %"libc::pollfd", %"libc::pollfd"* %pfd.i.i.i.i, i64 0, i32 0, i64 0
  store i32 %fd.i.i.i.i.i, i32* %8, align 4
  %9 = getelementptr inbounds %"libc::pollfd", %"libc::pollfd"* %pfd.i.i.i.i, i64 0, i32 3
  store i16 1, i16* %9, align 4
  %10 = getelementptr inbounds %"libc::pollfd", %"libc::pollfd"* %pfd.i.i.i.i, i64 0, i32 5
  store i16 0, i16* %10, align 2
  %res33.i.i.i.i = call i32 @poll(%"libc::pollfd"* mpk_unsafe nonnull %pfd.i.i.i.i, i64 1, i32 -1) #11
  %_1934.i.i.i.i = icmp sgt i32 %res33.i.i.i.i, -1
  br i1 %_1934.i.i.i.i, label %bb9.i.i.i, label %bb13.i.i.i.i

bb5.i.i.i.i:                                      ; preds = %bb6.i.i.i
  %_1.i.i.i.i.i.i.i = tail call mpk_unsafe i32* @__errno_location() #11, !noalias !23
  %11 = load i32, i32* %_1.i.i.i.i.i.i.i, align 4, !noalias !23
  %_2.i.i.i.i.i.i = icmp sgt i32 %11, 0
  %spec.select.i.i.i = select i1 %_2.i.i.i.i.i.i, i32 %11, i32 -2147483647
  br label %_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.thread.i

bb13.i.i.i.i:                                     ; preds = %bb16.i.i.i.i, %bb3.i.i.i.i
  %_1.i.i.i.i.i.i = call mpk_unsafe i32* @__errno_location() #11
  %12 = load i32, i32* %_1.i.i.i.i.i.i, align 4
  %_2.i.i.i.i.i = icmp sgt i32 %12, 0
  %spec.select.i.i.i.i.i = select i1 %_2.i.i.i.i.i, i32 %12, i32 -2147483647
  %13 = icmp sgt i32 %spec.select.i.i.i.i.i, -1
  br i1 %13, label %bb15.i.i.i.i, label %bb9.i.i.i

bb15.i.i.i.i:                                     ; preds = %bb13.i.i.i.i
  switch i32 %spec.select.i.i.i.i.i, label %bb9.i.i.i [
    i32 4, label %bb16.i.i.i.i
    i32 11, label %bb16.i.i.i.i
  ]

bb16.i.i.i.i:                                     ; preds = %bb15.i.i.i.i, %bb15.i.i.i.i
  %res.i.i.i.i = call i32 @poll(%"libc::pollfd"* mpk_unsafe nonnull %pfd.i.i.i.i, i64 1, i32 -1) #11
  %_19.i.i.i.i = icmp sgt i32 %res.i.i.i.i, -1
  br i1 %_19.i.i.i.i, label %bb9.i.i.i, label %bb13.i.i.i.i

bb9.i.i.i:                                        ; preds = %bb16.i.i.i.i, %bb15.i.i.i.i, %bb13.i.i.i.i, %bb3.i.i.i.i
  %.0.i.i.i.i = phi i32 [ 0, %bb3.i.i.i.i ], [ %spec.select.i.i.i.i.i, %bb13.i.i.i.i ], [ %12, %bb15.i.i.i.i ], [ 0, %bb16.i.i.i.i ]
  %_2.i.i.i.i.i.i1.i = call i32 @close(i32 %fd.i.i.i.i.i) #11
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %7) #11
  %14 = icmp eq i32 %.0.i.i.i.i, 0
  br i1 %14, label %bb10.i.i.i, label %_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.thread.i

bb10.i.i.i:                                       ; preds = %bb9.i.i.i
  %15 = getelementptr <{ [13 x i8] }>, <{ [13 x i8] }>* @alloc352, i64 0, i32 0, i64 0
  %fd.i.i.i.i = call i32 (i8*, i32, ...) @open64(i8* mpk_immut mpk_unsafe nonnull %15, i32 524288) #11
  %_12.i.i.i.i = icmp slt i32 %fd.i.i.i.i, 0
  br i1 %_12.i.i.i.i, label %bb21.i.i.i, label %bb22.i.i.i

bb21.i.i.i:                                       ; preds = %bb10.i.i.i
  %_1.i.i.i49.i.i.i = call mpk_unsafe i32* @__errno_location() #11, !noalias !26
  %16 = load i32, i32* %_1.i.i.i49.i.i.i, align 4, !noalias !26
  %_2.i.i50.i.i.i = icmp sgt i32 %16, 0
  %spec.select.i.i51.i.i.i = select i1 %_2.i.i50.i.i.i, i32 %16, i32 -2147483647
  br label %_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.thread.i

bb22.i.i.i:                                       ; preds = %bb10.i.i.i
  %.sroa.3.0.insert.ext.i61.i.i.i = zext i32 %fd.i.i.i.i to i64
  store atomic i64 %.sroa.3.0.insert.ext.i61.i.i.i, i64* bitcast (<{ [8 x i8] }>* @_ZN9getrandom8use_file10get_rng_fd2FD17he8cf6912f079847fE to i64*) monotonic, align 8
  %r.i.i.i.i48.i.i.i = call i32 @pthread_mutex_unlock(%"libc::pthread_mutex_t"* mpk_unsafe bitcast (<{ [40 x i8] }>* @_ZN9getrandom8use_file10get_rng_fd5MUTEX17h55be784b7061b53eE to %"libc::pthread_mutex_t"*)) #11
  br label %bb3.i.i

_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.thread.i: ; preds = %bb21.i.i.i, %bb9.i.i.i, %bb5.i.i.i.i
  %.sroa.6.0.i.i.ph.i = phi i32 [ %spec.select.i.i.i, %bb5.i.i.i.i ], [ %.0.i.i.i.i, %bb9.i.i.i ], [ %spec.select.i.i51.i.i.i, %bb21.i.i.i ]
  %r.i.i.i.i.i.i29.i = call i32 @pthread_mutex_unlock(%"libc::pthread_mutex_t"* mpk_unsafe bitcast (<{ [40 x i8] }>* @_ZN9getrandom8use_file10get_rng_fd5MUTEX17h55be784b7061b53eE to %"libc::pthread_mutex_t"*)) #11
  br label %bb5

_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.i: ; preds = %bb5.i.i.i
  %_6.i46.i.i.i = trunc i64 %5 to i32
  %r.i.i.i.i.i.i.i = tail call i32 @pthread_mutex_unlock(%"libc::pthread_mutex_t"* mpk_unsafe bitcast (<{ [40 x i8] }>* @_ZN9getrandom8use_file10get_rng_fd5MUTEX17h55be784b7061b53eE to %"libc::pthread_mutex_t"*)) #11
  br label %bb3.i.i

bb3.i.i:                                          ; preds = %_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.i, %bb22.i.i.i, %bb2.i
  %.sroa.4.0.extract.trunc.i11.i = phi i32 [ %_6.i46.i.i.i, %_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.i ], [ %_6.i.i.i.i, %bb2.i ], [ %fd.i.i.i.i, %bb22.i.i.i ]
  br label %bb4.i.i.i

bb4.i.i.i:                                        ; preds = %bb14.i.i.i, %bb3.i.i
  %buf.sroa.0.015.i.i.i = phi [0 x i8]* [ %buf.sroa.0.1.i.i.i, %bb14.i.i.i ], [ %dest.0, %bb3.i.i ]
  %buf.sroa.5.014.i.i.i = phi i64 [ %buf.sroa.5.1.i.i.i, %bb14.i.i.i ], [ %dest.1, %bb3.i.i ]
  %17 = getelementptr [0 x i8], [0 x i8]* %buf.sroa.0.015.i.i.i, i64 0, i64 0
  %18 = call i64 @read(i32 %.sroa.4.0.extract.trunc.i11.i, i8* mpk_unsafe nonnull %17, i64 %buf.sroa.5.014.i.i.i) #11, !noalias !29
  %_10.i.i.i = icmp slt i64 %18, 0
  br i1 %_10.i.i.i, label %bb7.i.i.i, label %bb6.i19.i.i

bb6.i19.i.i:                                      ; preds = %bb4.i.i.i
  %_4.i.i.i.i.i = icmp ult i64 %buf.sroa.5.014.i.i.i, %18
  br i1 %_4.i.i.i.i.i, label %bb3.i.i.i.i.i, label %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i.i"

bb3.i.i.i.i.i:                                    ; preds = %bb6.i19.i.i
  call void @_ZN4core5slice5index26slice_start_index_len_fail17h2ad4471ff7be2fa2E(i64 %18, i64 %buf.sroa.5.014.i.i.i, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc351 to %"core::panic::Location"*)), !noalias !29
  br label %UnifiedUnreachableBlock

"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i.i": ; preds = %bb6.i19.i.i
  %19 = getelementptr inbounds [0 x i8], [0 x i8]* %buf.sroa.0.015.i.i.i, i64 0, i64 %18
  %_7.i.i.i.i.i.i.i = sub i64 %buf.sroa.5.014.i.i.i, %18
  %20 = bitcast i8* %19 to [0 x i8]*
  br label %bb14.i.i.i

bb7.i.i.i:                                        ; preds = %bb4.i.i.i
  %_1.i.i.i.i.i = call mpk_unsafe i32* @__errno_location() #11, !noalias !29
  %21 = load i32, i32* %_1.i.i.i.i.i, align 4, !noalias !29
  %_2.i.i.i.i = icmp sgt i32 %21, 0
  %spec.select.i10.i.i.i = select i1 %_2.i.i.i.i, i32 %21, i32 -2147483647
  %cond = icmp eq i32 %spec.select.i10.i.i.i, 4
  br i1 %cond, label %bb14.i.i.i, label %bb5

bb14.i.i.i:                                       ; preds = %bb7.i.i.i, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i.i"
  %buf.sroa.5.1.i.i.i = phi i64 [ %buf.sroa.5.014.i.i.i, %bb7.i.i.i ], [ %_7.i.i.i.i.i.i.i, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i.i" ]
  %buf.sroa.0.1.i.i.i = phi [0 x i8]* [ %buf.sroa.0.015.i.i.i, %bb7.i.i.i ], [ %20, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i.i" ]
  %22 = icmp eq i64 %buf.sroa.5.1.i.i.i, 0
  br i1 %22, label %bb5, label %bb4.i.i.i

bb4.i.i:                                          ; preds = %bb14.i.i, %_ZN9getrandom4util8LazyBool11unsync_init17h50be71a695da3dfcE.exit.i
  %buf.sroa.0.016.i.i = phi [0 x i8]* [ %buf.sroa.0.1.i.i, %bb14.i.i ], [ %dest.0, %_ZN9getrandom4util8LazyBool11unsync_init17h50be71a695da3dfcE.exit.i ]
  %buf.sroa.5.015.i.i = phi i64 [ %buf.sroa.5.1.i.i, %bb14.i.i ], [ %dest.1, %_ZN9getrandom4util8LazyBool11unsync_init17h50be71a695da3dfcE.exit.i ]
  %23 = getelementptr [0 x i8], [0 x i8]* %buf.sroa.0.016.i.i, i64 0, i64 0
  %_4.i.i.i.i = tail call i64 (i64, ...) @syscall(i64 318, i8* mpk_unsafe nonnull %23, i64 %buf.sroa.5.015.i.i, i32 0) #11
  %_10.i.i = icmp slt i64 %_4.i.i.i.i, 0
  br i1 %_10.i.i, label %bb7.i.i, label %bb6.i.i

bb6.i.i:                                          ; preds = %bb4.i.i
  %_4.i.i11.i.i = icmp ult i64 %buf.sroa.5.015.i.i, %_4.i.i.i.i
  br i1 %_4.i.i11.i.i, label %bb3.i.i.i2.i, label %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i"

bb3.i.i.i2.i:                                     ; preds = %bb6.i.i
  tail call void @_ZN4core5slice5index26slice_start_index_len_fail17h2ad4471ff7be2fa2E(i64 %_4.i.i.i.i, i64 %buf.sroa.5.015.i.i, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc351 to %"core::panic::Location"*))
  br label %UnifiedUnreachableBlock

"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i": ; preds = %bb6.i.i
  %24 = getelementptr inbounds [0 x i8], [0 x i8]* %buf.sroa.0.016.i.i, i64 0, i64 %_4.i.i.i.i
  %_7.i.i.i.i.i.i = sub i64 %buf.sroa.5.015.i.i, %_4.i.i.i.i
  %25 = bitcast i8* %24 to [0 x i8]*
  br label %bb14.i.i

bb7.i.i:                                          ; preds = %bb4.i.i
  %_1.i.i.i.i = tail call mpk_unsafe i32* @__errno_location() #11
  %26 = load i32, i32* %_1.i.i.i.i, align 4
  %_2.i.i.i = icmp sgt i32 %26, 0
  %spec.select.i10.i.i = select i1 %_2.i.i.i, i32 %26, i32 -2147483647
  %.not.i.i = icmp eq i32 %spec.select.i10.i.i, 4
  br i1 %.not.i.i, label %bb14.i.i, label %bb5

bb14.i.i:                                         ; preds = %bb7.i.i, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i"
  %buf.sroa.5.1.i.i = phi i64 [ %buf.sroa.5.015.i.i, %bb7.i.i ], [ %_7.i.i.i.i.i.i, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i" ]
  %buf.sroa.0.1.i.i = phi [0 x i8]* [ %buf.sroa.0.016.i.i, %bb7.i.i ], [ %25, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h61e0f60ae404997dE.exit.i.i" ]
  %27 = icmp eq i64 %buf.sroa.5.1.i.i, 0
  br i1 %27, label %bb5, label %bb4.i.i

bb5:                                              ; preds = %bb14.i.i, %bb7.i.i, %bb14.i.i.i, %bb7.i.i.i, %_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.thread.i, %start
  %.0 = phi i32 [ 0, %start ], [ %.sroa.6.0.i.i.ph.i, %_ZN9getrandom8use_file10get_rng_fd17h921c5c2fb2e0f4ddE.exit.i.thread.i ], [ %spec.select.i10.i.i.i, %bb7.i.i.i ], [ 0, %bb14.i.i.i ], [ %spec.select.i10.i.i, %bb7.i.i ], [ 0, %bb14.i.i ]
  ret i32 %.0

UnifiedUnreachableBlock:                          ; preds = %bb3.i.i.i2.i, %bb3.i.i.i.i.i
  unreachable
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core5slice5index26slice_start_index_len_fail17h2ad4471ff7be2fa2E(i64, i64, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #4

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN3std2io5error5Error4_new17h4dbd541810de7dbdE(i8, {}* mpk_immut noalias nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17h9f4869c9c7acbf05E"([0 x i8]* mpk_immut noalias nonnull readonly align 1, i64, %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias readonly align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17h3eaaf3997f8f438aE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias readonly align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h08e994e256867223E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h614ff315f5bd3ea6E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hbdab60765508c6f3E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h4773017a326a508bE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h6b8b41e24df1a43fE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #5

; Function Attrs: noreturn nounwind nonlazybind uwtable
declare void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64, i64) unnamed_addr #6

; Function Attrs: nounwind nonlazybind uwtable
declare mpk_unsafe noalias i8* @__rust_alloc(i64, i64) unnamed_addr #7

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @rust_eh_personality(i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"* mpk_unsafe, %"unwind::libunwind::_Unwind_Context"* mpk_unsafe) unnamed_addr #8

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* align 8 dereferenceable(64), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* align 8 dereferenceable(16), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64, {}* mpk_immut nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #1

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #9

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* align 8 dereferenceable(16)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* align 8 dereferenceable(64), %"core::fmt::Arguments"* noalias nocapture dereferenceable(48)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter9write_str17hdd0117a4487b56c4E(%"core::fmt::Formatter"* align 8 dereferenceable(64), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h8d32920bf513d1aeE"([0 x i8]* mpk_immut noalias nonnull readonly align 1, i64, %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN3std2io5error5Error17from_raw_os_error17hb36e5239199ebffeE(i32) unnamed_addr #1

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @__xpg_strerror_r(i32, i8* mpk_unsafe, i64) unnamed_addr #8

; Function Attrs: nonlazybind uwtable
declare void @_ZN4core3str8converts9from_utf817h5fef343fb410e7cdE(%"core::result::Result<&str, core::str::Utf8Error>"* noalias nocapture sret dereferenceable(24), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #1

; Function Attrs: mpk_extern nofree nounwind nonlazybind uwtable
declare i32 @open64(i8* mpk_immut mpk_unsafe nocapture readonly, i32, ...) unnamed_addr #10

; Function Attrs: mpk_extern nofree nounwind nonlazybind uwtable
declare i64 @read(i32, i8* mpk_unsafe nocapture, i64) unnamed_addr #10

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @poll(%"libc::pollfd"* mpk_unsafe, i64, i32) unnamed_addr #8

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @close(i32) unnamed_addr #8

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @pthread_mutex_lock(%"libc::pthread_mutex_t"* mpk_unsafe) unnamed_addr #8

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @pthread_mutex_unlock(%"libc::pthread_mutex_t"* mpk_unsafe) unnamed_addr #8

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i64 @syscall(i64, ...) unnamed_addr #8

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare mpk_unsafe i32* @__errno_location() unnamed_addr #8

attributes #0 = { norecurse nounwind nonlazybind readnone uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #1 = { nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #2 = { inlinehint nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { cold noinline noreturn nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #5 = { nounwind willreturn }
attributes #6 = { noreturn nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #7 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #8 = { mpk_extern nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #9 = { argmemonly nounwind willreturn writeonly }
attributes #10 = { mpk_extern nofree nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #11 = { nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
!3 = !{i32 1, i32 0}
!4 = !{i64 0, i64 2}
!5 = !{!6}
!6 = distinct !{!6, !7, !"_ZN4core6result19Result$LT$T$C$E$GT$2ok17hb444ca6d39de05cfE: %self"}
!7 = distinct !{!7, !"_ZN4core6result19Result$LT$T$C$E$GT$2ok17hb444ca6d39de05cfE"}
!8 = !{!9}
!9 = distinct !{!9, !10, !"_ZN4core6result19Result$LT$T$C$E$GT$2ok17hb444ca6d39de05cfE: %self"}
!10 = distinct !{!10, !"_ZN4core6result19Result$LT$T$C$E$GT$2ok17hb444ca6d39de05cfE"}
!11 = !{!12}
!12 = distinct !{!12, !13, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!13 = distinct !{!13, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!14 = !{!15, !16}
!15 = distinct !{!15, !13, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!16 = distinct !{!16, !13, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!17 = !{!18}
!18 = distinct !{!18, !19, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!19 = distinct !{!19, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!20 = !{!21, !22}
!21 = distinct !{!21, !19, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!22 = distinct !{!22, !19, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!23 = !{!24}
!24 = distinct !{!24, !25, !"_ZN9getrandom9util_libc13open_readonly17h229046ef483b5b1eE: %path.0"}
!25 = distinct !{!25, !"_ZN9getrandom9util_libc13open_readonly17h229046ef483b5b1eE"}
!26 = !{!27}
!27 = distinct !{!27, !28, !"_ZN9getrandom9util_libc13open_readonly17h229046ef483b5b1eE: %path.0"}
!28 = distinct !{!28, !"_ZN9getrandom9util_libc13open_readonly17h229046ef483b5b1eE"}
!29 = !{!30}
!30 = distinct !{!30, !31, !"_ZN9getrandom9util_libc14sys_fill_exact17hc19f830093c85c86E: argument 0"}
!31 = distinct !{!31, !"_ZN9getrandom9util_libc14sys_fill_exact17hc19f830093c85c86E"}
