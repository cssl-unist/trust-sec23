; ModuleID = 'rand_chacha-2bab42ef394b14a8.bc'
source_filename = "rand_chacha.741xqogi-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"std::detect::cache::Cache" = type { [0 x i64], %"std::sync::atomic::AtomicUsize", [0 x i64] }
%"std::sync::atomic::AtomicUsize" = type { [0 x i64], i64, [0 x i64] }
%"std::fmt::Formatter" = type { [0 x i64], { i64, i64 }, [0 x i64], { i64, i64 }, [0 x i64], { {}*, [3 x i64]* }, [0 x i32], i32, [0 x i32], i32, [0 x i8], i8, [7 x i8] }
%"chacha::ChaCha8Core" = type { [0 x i64], %"guts::ChaCha", [0 x i64] }
%"guts::ChaCha" = type { [0 x i64], %"ppv_lite86::vec128_storage", [0 x i64], %"ppv_lite86::vec128_storage", [0 x i64], %"ppv_lite86::vec128_storage", [0 x i64] }
%"ppv_lite86::vec128_storage" = type { [2 x i64] }
%"chacha::ChaCha20Core" = type { [0 x i64], %"guts::ChaCha", [0 x i64] }
%"chacha::ChaCha12Core" = type { [0 x i64], %"guts::ChaCha", [0 x i64] }
%"rand_core::block::BlockRng<chacha::ChaCha20Core>" = type { [0 x i64], i64, [0 x i32], %"chacha::Array64<u32>", [2 x i32], %"chacha::ChaCha20Core", [0 x i64] }
%"chacha::Array64<u32>" = type { [0 x i32], [64 x i32], [0 x i32] }
%"rand_core::block::BlockRng<chacha::ChaCha12Core>" = type { [0 x i64], i64, [0 x i32], %"chacha::Array64<u32>", [2 x i32], %"chacha::ChaCha12Core", [0 x i64] }
%"rand_core::block::BlockRng<chacha::ChaCha8Core>" = type { [0 x i64], i64, [0 x i32], %"chacha::Array64<u32>", [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }
%"chacha::abstract20::ChaCha20Rng" = type { [0 x i64], i64, [0 x i64], i128, [0 x i8], [32 x i8], [0 x i8] }
%"chacha::ChaCha20Rng" = type { [0 x i64], %"rand_core::block::BlockRng<chacha::ChaCha20Core>", [0 x i64] }
%"chacha::abstract12::ChaCha12Rng" = type { [0 x i64], i64, [0 x i64], i128, [0 x i8], [32 x i8], [0 x i8] }
%"chacha::ChaCha12Rng" = type { [0 x i64], %"rand_core::block::BlockRng<chacha::ChaCha12Core>", [0 x i64] }
%"std::fmt::DebugStruct" = type { [0 x i64], %"std::fmt::Formatter"*, [0 x i8], i8, [0 x i8], i8, [6 x i8] }
%"std::fmt::DebugList" = type { [0 x i64], %"core::fmt::builders::DebugInner", [0 x i64] }
%"core::fmt::builders::DebugInner" = type { [0 x i64], %"std::fmt::Formatter"*, [0 x i8], i8, [0 x i8], i8, [6 x i8] }
%"std::fmt::Arguments" = type { [0 x i64], { [0 x { [0 x i8]*, i64 }]*, i64 }, [0 x i64], { i64*, i64 }, [0 x i64], { [0 x { i8*, i64* }]*, i64 }, [0 x i64] }
%"chacha::ChaCha8Rng" = type { [0 x i64], %"rand_core::block::BlockRng<chacha::ChaCha8Core>", [0 x i64] }
%"chacha::abstract8::ChaCha8Rng" = type { [0 x i64], i64, [0 x i64], i128, [0 x i8], [32 x i8], [0 x i8] }
%"std::panic::Location" = type { [0 x i64], { [0 x i8]*, i64 }, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unwind::libunwind::_Unwind_Exception" = type { [0 x i64], i64, [0 x i64], void (i32, %"unwind::libunwind::_Unwind_Exception"*)*, [0 x i64], [6 x i64], [0 x i64] }
%"unwind::libunwind::_Unwind_Context" = type { [0 x i8] }

@alloc2447 = private unnamed_addr constant <{ [0 x i8] }> zeroinitializer, align 8
@alloc2501 = private unnamed_addr constant <{ [90 x i8] }> <{ [90 x i8] c"/root/.cargo/registry/src/github.com-1ecc6299db9ec823/ppv-lite86-0.2.15/src/x86_64/sse2.rs" }>, align 1
@alloc2498 = private unnamed_addr constant <{ [40 x i8] }> <{ [40 x i8] c"internal error: entered unreachable code" }>, align 1
@alloc2494 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [90 x i8] }>, <{ [90 x i8] }>* @alloc2501, i32 0, i32 0, i32 0), [16 x i8] c"Z\00\00\00\00\00\00\008\02\00\00\16\00\00\00" }>, align 8
@alloc2497 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [90 x i8] }>, <{ [90 x i8] }>* @alloc2501, i32 0, i32 0, i32 0), [16 x i8] c"Z\00\00\00\00\00\00\00\1D\02\00\00\09\00\00\00" }>, align 8
@alloc2500 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [90 x i8] }>, <{ [90 x i8] }>* @alloc2501, i32 0, i32 0, i32 0), [16 x i8] c"Z\00\00\00\00\00\00\00\12\02\00\00\16\00\00\00" }>, align 8
@alloc2502 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [90 x i8] }>, <{ [90 x i8] }>* @alloc2501, i32 0, i32 0, i32 0), [16 x i8] c"Z\00\00\00\00\00\00\00\08\02\00\00\09\00\00\00" }>, align 8
@_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E = external local_unnamed_addr global [2 x %"std::detect::cache::Cache"]
@vtable.1 = private unnamed_addr constant { void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* } { void (i8**)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (i8**)*), i64 8, i64 8, i1 (i8**, %"std::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hfded778caa0212edE" }, align 8
@alloc107 = private unnamed_addr constant <{ [8 x i8] }> zeroinitializer, align 8
@alloc3574 = private unnamed_addr constant <{ [8 x i8] }> <{ [8 x i8] c"BlockRng" }>, align 1
@alloc3575 = private unnamed_addr constant <{ [4 x i8] }> <{ [4 x i8] c"core" }>, align 1
@vtable.3 = private unnamed_addr constant { void (%"chacha::ChaCha8Core"*)*, i64, i64, i1 (%"chacha::ChaCha8Core"*, %"std::fmt::Formatter"*)* } { void (%"chacha::ChaCha8Core"*)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (%"chacha::ChaCha8Core"*)*), i64 48, i64 16, i1 (%"chacha::ChaCha8Core"*, %"std::fmt::Formatter"*)* @"_ZN69_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$core..fmt..Debug$GT$3fmt17h35bf5edb5ad589ceE" }, align 8
@alloc3576 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"result_len" }>, align 1
@vtable.4 = private unnamed_addr constant { void (i64*)*, i64, i64, i1 (i64*, %"std::fmt::Formatter"*)* } { void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E, i64 8, i64 8, i1 (i64*, %"std::fmt::Formatter"*)* @"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hd033ec0476f2a15bE" }, align 8
@alloc3577 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"index" }>, align 1
@vtable.5 = private unnamed_addr constant { void (%"chacha::ChaCha20Core"*)*, i64, i64, i1 (%"chacha::ChaCha20Core"*, %"std::fmt::Formatter"*)* } { void (%"chacha::ChaCha20Core"*)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (%"chacha::ChaCha20Core"*)*), i64 48, i64 16, i1 (%"chacha::ChaCha20Core"*, %"std::fmt::Formatter"*)* bitcast (i1 (%"chacha::ChaCha8Core"*, %"std::fmt::Formatter"*)* @"_ZN69_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$core..fmt..Debug$GT$3fmt17h35bf5edb5ad589ceE" to i1 (%"chacha::ChaCha20Core"*, %"std::fmt::Formatter"*)*) }, align 8
@vtable.6 = private unnamed_addr constant { void (%"chacha::ChaCha12Core"*)*, i64, i64, i1 (%"chacha::ChaCha12Core"*, %"std::fmt::Formatter"*)* } { void (%"chacha::ChaCha12Core"*)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (%"chacha::ChaCha12Core"*)*), i64 48, i64 16, i1 (%"chacha::ChaCha12Core"*, %"std::fmt::Formatter"*)* bitcast (i1 (%"chacha::ChaCha8Core"*, %"std::fmt::Formatter"*)* @"_ZN69_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$core..fmt..Debug$GT$3fmt17h35bf5edb5ad589ceE" to i1 (%"chacha::ChaCha12Core"*, %"std::fmt::Formatter"*)*) }, align 8
@alloc3652 = private unnamed_addr constant <{ [83 x i8] }> <{ [83 x i8] c"/root/.cargo/registry/src/github.com-1ecc6299db9ec823/rand_chacha-0.3.1/src/guts.rs" }>, align 1
@alloc2444 = private unnamed_addr constant <{ [14 x i8] }> <{ [14 x i8] c"ChaChaXCore {}" }>, align 1
@alloc2445 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [14 x i8] }>, <{ [14 x i8] }>* @alloc2444, i32 0, i32 0, i32 0), [8 x i8] c"\0E\00\00\00\00\00\00\00" }>, align 8
@alloc3605 = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"ChaCha20Rng" }>, align 1
@alloc3620 = private unnamed_addr constant <{ [3 x i8] }> <{ [3 x i8] c"rng" }>, align 1
@vtable.9 = private unnamed_addr constant { void (%"rand_core::block::BlockRng<chacha::ChaCha20Core>"**)*, i64, i64, i1 (%"rand_core::block::BlockRng<chacha::ChaCha20Core>"**, %"std::fmt::Formatter"*)* } { void (%"rand_core::block::BlockRng<chacha::ChaCha20Core>"**)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (%"rand_core::block::BlockRng<chacha::ChaCha20Core>"**)*), i64 8, i64 8, i1 (%"rand_core::block::BlockRng<chacha::ChaCha20Core>"**, %"std::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h573938c55a051ff0E" }, align 8
@alloc3622 = private unnamed_addr constant <{ [4 x i8] }> <{ [4 x i8] c"seed" }>, align 1
@vtable.a = private unnamed_addr constant { void ([32 x i8]**)*, i64, i64, i1 ([32 x i8]**, %"std::fmt::Formatter"*)* } { void ([32 x i8]**)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void ([32 x i8]**)*), i64 8, i64 8, i1 ([32 x i8]**, %"std::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h90008c9384af52e9E" }, align 8
@alloc3623 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"stream" }>, align 1
@vtable.b = private unnamed_addr constant { void (i64**)*, i64, i64, i1 (i64**, %"std::fmt::Formatter"*)* } { void (i64**)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (i64**)*), i64 8, i64 8, i1 (i64**, %"std::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hf1d2bf062fef8af7E" }, align 8
@alloc3624 = private unnamed_addr constant <{ [8 x i8] }> <{ [8 x i8] c"word_pos" }>, align 1
@vtable.c = private unnamed_addr constant { void (i128**)*, i64, i64, i1 (i128**, %"std::fmt::Formatter"*)* } { void (i128**)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (i128**)*), i64 8, i64 8, i1 (i128**, %"std::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbf111d15688deba5E" }, align 8
@alloc3613 = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"ChaCha12Rng" }>, align 1
@vtable.d = private unnamed_addr constant { void (%"rand_core::block::BlockRng<chacha::ChaCha12Core>"**)*, i64, i64, i1 (%"rand_core::block::BlockRng<chacha::ChaCha12Core>"**, %"std::fmt::Formatter"*)* } { void (%"rand_core::block::BlockRng<chacha::ChaCha12Core>"**)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (%"rand_core::block::BlockRng<chacha::ChaCha12Core>"**)*), i64 8, i64 8, i1 (%"rand_core::block::BlockRng<chacha::ChaCha12Core>"**, %"std::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h658e33932069283fE" }, align 8
@alloc3621 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"ChaCha8Rng" }>, align 1
@vtable.e = private unnamed_addr constant { void (%"rand_core::block::BlockRng<chacha::ChaCha8Core>"**)*, i64, i64, i1 (%"rand_core::block::BlockRng<chacha::ChaCha8Core>"**, %"std::fmt::Formatter"*)* } { void (%"rand_core::block::BlockRng<chacha::ChaCha8Core>"**)* bitcast (void (i64*)* @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E to void (%"rand_core::block::BlockRng<chacha::ChaCha8Core>"**)*), i64 8, i64 8, i1 (%"rand_core::block::BlockRng<chacha::ChaCha8Core>"**, %"std::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h06f69e5a09893271E" }, align 8
@alloc3647 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [83 x i8] }>, <{ [83 x i8] }>* @alloc3652, i32 0, i32 0, i32 0), [16 x i8] c"S\00\00\00\00\00\00\00\F3\00\00\00\19\00\00\00" }>, align 8

@"_ZN128_$LT$rand_chacha..chacha..abstract20..ChaCha20Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha20Rng$GT$$GT$4from17h564745fd4723808bE" = unnamed_addr alias void (%"chacha::abstract20::ChaCha20Rng"*, %"chacha::ChaCha20Rng"*), bitcast (void (%"chacha::abstract8::ChaCha8Rng"*, %"chacha::ChaCha8Rng"*)* @"_ZN125_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha8Rng$GT$$GT$4from17h7d35d0daa8dabf82E" to void (%"chacha::abstract20::ChaCha20Rng"*, %"chacha::ChaCha20Rng"*)*)
@"_ZN128_$LT$rand_chacha..chacha..abstract12..ChaCha12Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha12Rng$GT$$GT$4from17h2902699430811002E" = unnamed_addr alias void (%"chacha::abstract12::ChaCha12Rng"*, %"chacha::ChaCha12Rng"*), bitcast (void (%"chacha::abstract8::ChaCha8Rng"*, %"chacha::ChaCha8Rng"*)* @"_ZN125_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha8Rng$GT$$GT$4from17h7d35d0daa8dabf82E" to void (%"chacha::abstract12::ChaCha12Rng"*, %"chacha::ChaCha12Rng"*)*)
@"_ZN70_$LT$rand_chacha..chacha..ChaCha20Core$u20$as$u20$core..fmt..Debug$GT$3fmt17h3e0330f488e3fe94E" = unnamed_addr alias i1 (%"chacha::ChaCha20Core"*, %"std::fmt::Formatter"*), bitcast (i1 (%"chacha::ChaCha8Core"*, %"std::fmt::Formatter"*)* @"_ZN69_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$core..fmt..Debug$GT$3fmt17h35bf5edb5ad589ceE" to i1 (%"chacha::ChaCha20Core"*, %"std::fmt::Formatter"*)*)
@"_ZN70_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$core..fmt..Debug$GT$3fmt17h5dd6b27b5587e0a0E" = unnamed_addr alias i1 (%"chacha::ChaCha12Core"*, %"std::fmt::Formatter"*), bitcast (i1 (%"chacha::ChaCha8Core"*, %"std::fmt::Formatter"*)* @"_ZN69_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$core..fmt..Debug$GT$3fmt17h35bf5edb5ad589ceE" to i1 (%"chacha::ChaCha12Core"*, %"std::fmt::Formatter"*)*)
@"_ZN113_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$core..convert..From$LT$rand_chacha..chacha..ChaCha20Core$GT$$GT$4from17hb82fb979a50c34baE" = unnamed_addr alias void (%"chacha::ChaCha20Rng"*, %"chacha::ChaCha20Core"*), bitcast (void (%"chacha::ChaCha8Rng"*, %"chacha::ChaCha8Core"*)* @"_ZN111_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$core..convert..From$LT$rand_chacha..chacha..ChaCha8Core$GT$$GT$4from17h9f3cb76d76adf118E" to void (%"chacha::ChaCha20Rng"*, %"chacha::ChaCha20Core"*)*)
@"_ZN113_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$core..convert..From$LT$rand_chacha..chacha..ChaCha12Core$GT$$GT$4from17hc7759fa5918cc2aaE" = unnamed_addr alias void (%"chacha::ChaCha12Rng"*, %"chacha::ChaCha12Core"*), bitcast (void (%"chacha::ChaCha8Rng"*, %"chacha::ChaCha8Core"*)* @"_ZN111_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$core..convert..From$LT$rand_chacha..chacha..ChaCha8Core$GT$$GT$4from17h9f3cb76d76adf118E" to void (%"chacha::ChaCha12Rng"*, %"chacha::ChaCha12Core"*)*)
@"_ZN73_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0eab116279c62bf9E" = unnamed_addr alias i1 (%"chacha::ChaCha20Rng"*, %"chacha::ChaCha20Rng"*), bitcast (i1 (%"chacha::ChaCha12Rng"*, %"chacha::ChaCha12Rng"*)* @"_ZN73_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17ha685a9015f95964aE" to i1 (%"chacha::ChaCha20Rng"*, %"chacha::ChaCha20Rng"*)*)

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h06f69e5a09893271E"(%"rand_core::block::BlockRng<chacha::ChaCha8Core>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_24.i = alloca i64, align 8
  %_10.i = alloca %"std::fmt::DebugStruct", align 8
  %_4 = load %"rand_core::block::BlockRng<chacha::ChaCha8Core>"*, %"rand_core::block::BlockRng<chacha::ChaCha8Core>"** %self, align 8, !nonnull !2
  %0 = bitcast %"std::fmt::DebugStruct"* %_10.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0), !noalias !3
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc3574 to [0 x i8]*), i64 8), !noalias !3
  %.0..sroa_cast.i = bitcast %"std::fmt::DebugStruct"* %_10.i to i128*
  store i128 %1, i128* %.0..sroa_cast.i, align 8, !noalias !3
  %_18.i = getelementptr inbounds %"rand_core::block::BlockRng<chacha::ChaCha8Core>", %"rand_core::block::BlockRng<chacha::ChaCha8Core>"* %_4, i64 0, i32 5
  %_16.0.i = bitcast %"chacha::ChaCha8Core"* %_18.i to {}*
  %_8.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_10.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc3575 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_16.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"chacha::ChaCha8Core"*)*, i64, i64, i1 (%"chacha::ChaCha8Core"*, %"std::fmt::Formatter"*)* }* @vtable.3 to [3 x i64]*))
  %2 = bitcast i64* %_24.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2), !noalias !3
  store i64 64, i64* %_24.i, align 8, !noalias !3
  %_21.0.i = bitcast i64* %_24.i to {}*
  %_6.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_8.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc3576 to [0 x i8]*), i64 10, {}* mpk_immut nonnull align 1 %_21.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64*)*, i64, i64, i1 (i64*, %"std::fmt::Formatter"*)* }* @vtable.4 to [3 x i64]*))
  %_30.0.i = bitcast %"rand_core::block::BlockRng<chacha::ChaCha8Core>"* %_4 to {}*
  %_4.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_6.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc3577 to [0 x i8]*), i64 5, {}* mpk_immut nonnull align 1 %_30.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64*)*, i64, i64, i1 (i64*, %"std::fmt::Formatter"*)* }* @vtable.4 to [3 x i64]*))
  %3 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_4.i)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2), !noalias !3
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0), !noalias !3
  ret i1 %3
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h573938c55a051ff0E"(%"rand_core::block::BlockRng<chacha::ChaCha20Core>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_24.i = alloca i64, align 8
  %_10.i = alloca %"std::fmt::DebugStruct", align 8
  %_4 = load %"rand_core::block::BlockRng<chacha::ChaCha20Core>"*, %"rand_core::block::BlockRng<chacha::ChaCha20Core>"** %self, align 8, !nonnull !2
  %0 = bitcast %"std::fmt::DebugStruct"* %_10.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0), !noalias !6
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc3574 to [0 x i8]*), i64 8), !noalias !6
  %.0..sroa_cast.i = bitcast %"std::fmt::DebugStruct"* %_10.i to i128*
  store i128 %1, i128* %.0..sroa_cast.i, align 8, !noalias !6
  %_18.i = getelementptr inbounds %"rand_core::block::BlockRng<chacha::ChaCha20Core>", %"rand_core::block::BlockRng<chacha::ChaCha20Core>"* %_4, i64 0, i32 5
  %_16.0.i = bitcast %"chacha::ChaCha20Core"* %_18.i to {}*
  %_8.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_10.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc3575 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_16.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"chacha::ChaCha20Core"*)*, i64, i64, i1 (%"chacha::ChaCha20Core"*, %"std::fmt::Formatter"*)* }* @vtable.5 to [3 x i64]*))
  %2 = bitcast i64* %_24.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2), !noalias !6
  store i64 64, i64* %_24.i, align 8, !noalias !6
  %_21.0.i = bitcast i64* %_24.i to {}*
  %_6.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_8.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc3576 to [0 x i8]*), i64 10, {}* mpk_immut nonnull align 1 %_21.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64*)*, i64, i64, i1 (i64*, %"std::fmt::Formatter"*)* }* @vtable.4 to [3 x i64]*))
  %_30.0.i = bitcast %"rand_core::block::BlockRng<chacha::ChaCha20Core>"* %_4 to {}*
  %_4.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_6.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc3577 to [0 x i8]*), i64 5, {}* mpk_immut nonnull align 1 %_30.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64*)*, i64, i64, i1 (i64*, %"std::fmt::Formatter"*)* }* @vtable.4 to [3 x i64]*))
  %3 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_4.i)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2), !noalias !6
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0), !noalias !6
  ret i1 %3
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h658e33932069283fE"(%"rand_core::block::BlockRng<chacha::ChaCha12Core>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_24.i = alloca i64, align 8
  %_10.i = alloca %"std::fmt::DebugStruct", align 8
  %_4 = load %"rand_core::block::BlockRng<chacha::ChaCha12Core>"*, %"rand_core::block::BlockRng<chacha::ChaCha12Core>"** %self, align 8, !nonnull !2
  %0 = bitcast %"std::fmt::DebugStruct"* %_10.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0), !noalias !9
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc3574 to [0 x i8]*), i64 8), !noalias !9
  %.0..sroa_cast.i = bitcast %"std::fmt::DebugStruct"* %_10.i to i128*
  store i128 %1, i128* %.0..sroa_cast.i, align 8, !noalias !9
  %_18.i = getelementptr inbounds %"rand_core::block::BlockRng<chacha::ChaCha12Core>", %"rand_core::block::BlockRng<chacha::ChaCha12Core>"* %_4, i64 0, i32 5
  %_16.0.i = bitcast %"chacha::ChaCha12Core"* %_18.i to {}*
  %_8.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_10.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc3575 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_16.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"chacha::ChaCha12Core"*)*, i64, i64, i1 (%"chacha::ChaCha12Core"*, %"std::fmt::Formatter"*)* }* @vtable.6 to [3 x i64]*))
  %2 = bitcast i64* %_24.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2), !noalias !9
  store i64 64, i64* %_24.i, align 8, !noalias !9
  %_21.0.i = bitcast i64* %_24.i to {}*
  %_6.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_8.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc3576 to [0 x i8]*), i64 10, {}* mpk_immut nonnull align 1 %_21.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64*)*, i64, i64, i1 (i64*, %"std::fmt::Formatter"*)* }* @vtable.4 to [3 x i64]*))
  %_30.0.i = bitcast %"rand_core::block::BlockRng<chacha::ChaCha12Core>"* %_4 to {}*
  %_4.i = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_6.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc3577 to [0 x i8]*), i64 5, {}* mpk_immut nonnull align 1 %_30.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64*)*, i64, i64, i1 (i64*, %"std::fmt::Formatter"*)* }* @vtable.4 to [3 x i64]*))
  %3 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %_4.i)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2), !noalias !9
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0), !noalias !9
  ret i1 %3
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h90008c9384af52e9E"([32 x i8]** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %entry.i.i.i.i = alloca i8*, align 8
  %_6.i.i.i = alloca %"std::fmt::DebugList", align 8
  %_4 = load [32 x i8]*, [32 x i8]** %self, align 8, !nonnull !2
  %0 = bitcast %"std::fmt::DebugList"* %_6.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0), !noalias !12
  %1 = tail call i128 @_ZN4core3fmt9Formatter10debug_list17h8147fa4f8cb43178E(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f), !noalias !17
  %.0..sroa_cast.i.i.i = bitcast %"std::fmt::DebugList"* %_6.i.i.i to i128*
  store i128 %1, i128* %.0..sroa_cast.i.i.i, align 8, !noalias !12
  %2 = getelementptr [32 x i8], [32 x i8]* %_4, i64 0, i64 0
  %3 = bitcast i8** %entry.i.i.i.i to i8*
  %_17.0.i.i.i.i = bitcast i8** %entry.i.i.i.i to {}*
  %4 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 1
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %2, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %5 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 2
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %4, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.1.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %6 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 3
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %5, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.2.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %7 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 4
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %6, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.3.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %8 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 5
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %7, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.4.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %9 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 6
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %8, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.5.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %10 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 7
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %9, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.6.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %11 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 8
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %10, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.7.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %12 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 9
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %11, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.8.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %13 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 10
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %12, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.9.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %14 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 11
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %13, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.10.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %15 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 12
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %14, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.11.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %16 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 13
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %15, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.12.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %17 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 14
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %16, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.13.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %18 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 15
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %17, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.14.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %19 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 16
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %18, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.15.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %20 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 17
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %19, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.16.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %21 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 18
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %20, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.17.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %22 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 19
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %21, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.18.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %23 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 20
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %22, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.19.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %24 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 21
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %23, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.20.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %25 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 22
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %24, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.21.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %26 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 23
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %25, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.22.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %27 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 24
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %26, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.23.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %28 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 25
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %27, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.24.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %29 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 26
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %28, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.25.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %30 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 27
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %29, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.26.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %31 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 28
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %30, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.27.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %32 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 29
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %31, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.28.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %33 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 30
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %32, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.29.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %34 = getelementptr inbounds [32 x i8], [32 x i8]* %_4, i64 0, i64 31
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %33, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.30.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !12
  store i8* %34, i8** %entry.i.i.i.i, align 8, !noalias !12
  %_15.i.i.i.31.i = call align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, i1 (i8**, %"std::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !12
  %35 = call zeroext i1 @_ZN4core3fmt8builders9DebugList6finish17h1110a7134d6ce275E(%"std::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i.i)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0), !noalias !12
  ret i1 %35
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbf111d15688deba5E"(i128** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load i128*, i128** %self, align 8, !nonnull !2
  %_3.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"std::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f), !noalias !18
  br i1 %_3.i, label %bb3.i, label %bb2.i

bb2.i:                                            ; preds = %start
  %_7.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"std::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7.i, label %bb7.i, label %bb6.i

bb3.i:                                            ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num54_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u128$GT$3fmt17hbcef45b08b6c408bE"(i128* mpk_immut noalias nonnull readonly align 8 dereferenceable(16) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num51_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u128$GT$3fmt17h8b9cdc9fe7e4fa43E.exit"

bb6.i:                                            ; preds = %bb2.i
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..Display$u20$for$u20$u128$GT$3fmt17h1c1701825f5cb075E"(i128* mpk_immut noalias nonnull readonly align 8 dereferenceable(16) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num51_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u128$GT$3fmt17h8b9cdc9fe7e4fa43E.exit"

bb7.i:                                            ; preds = %bb2.i
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num54_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u128$GT$3fmt17heedd9089723cd37fE"(i128* mpk_immut noalias nonnull readonly align 8 dereferenceable(16) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num51_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u128$GT$3fmt17h8b9cdc9fe7e4fa43E.exit"

"_ZN4core3fmt3num51_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u128$GT$3fmt17h8b9cdc9fe7e4fa43E.exit": ; preds = %bb7.i, %bb6.i, %bb3.i
  %.0.in.i = phi i1 [ %0, %bb3.i ], [ %2, %bb7.i ], [ %1, %bb6.i ]
  ret i1 %.0.in.i
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hf1d2bf062fef8af7E"(i64** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load i64*, i64** %self, align 8, !nonnull !2
  %_3.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"std::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f), !noalias !21
  br i1 %_3.i, label %bb3.i, label %bb2.i

bb2.i:                                            ; preds = %start
  %_7.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"std::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7.i, label %bb7.i, label %bb6.i

bb3.i:                                            ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17he9d3331e4e8b2618E"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE.exit"

bb6.i:                                            ; preds = %bb2.i
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h4dc2af1a5829180dE"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE.exit"

bb7.i:                                            ; preds = %bb2.i
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u64$GT$3fmt17h46c4aab50ded2d21E"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE.exit"

"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE.exit": ; preds = %bb7.i, %bb6.i, %bb3.i
  %.0.in.i = phi i1 [ %0, %bb3.i ], [ %2, %bb7.i ], [ %1, %bb6.i ]
  ret i1 %.0.in.i
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hfded778caa0212edE"(i8** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load i8*, i8** %self, align 8, !nonnull !2
  %_3.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"std::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f), !noalias !24
  br i1 %_3.i, label %bb3.i, label %bb2.i

bb2.i:                                            ; preds = %start
  %_7.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"std::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7.i, label %bb7.i, label %bb6.i

bb3.i:                                            ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u8$GT$3fmt17h64a79a92366aabc0E"(i8* mpk_immut noalias nonnull readonly align 1 dereferenceable(1) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h93fa8a90e78c8b63E.exit"

bb6.i:                                            ; preds = %bb2.i
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h2c6fa9207fbbb7f5E"(i8* mpk_immut noalias nonnull readonly align 1 dereferenceable(1) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h93fa8a90e78c8b63E.exit"

bb7.i:                                            ; preds = %bb2.i
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u8$GT$3fmt17h4852942f4018ed1aE"(i8* mpk_immut noalias nonnull readonly align 1 dereferenceable(1) %_4, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h93fa8a90e78c8b63E.exit"

"_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h93fa8a90e78c8b63E.exit": ; preds = %bb7.i, %bb6.i, %bb3.i
  %.0.in.i = phi i1 [ %0, %bb3.i ], [ %2, %bb7.i ], [ %1, %bb6.i ]
  ret i1 %.0.in.i
}

; Function Attrs: inlinehint nonlazybind uwtable
define internal zeroext i1 @"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hd033ec0476f2a15bE"(i64* mpk_immut noalias readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #1 {
start:
  %_3 = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"std::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_3, label %bb3, label %bb2

bb2:                                              ; preds = %start
  %_7 = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"std::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7, label %bb7, label %bb6

bb3:                                              ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h3fb07f7e6da8e1c6E"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb6:                                              ; preds = %bb2
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h0f57e3373191c50eE"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb7:                                              ; preds = %bb2
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$usize$GT$3fmt17hf3a9e839be306c07E"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %self, %"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %bb11

bb11:                                             ; preds = %bb7, %bb6, %bb3
  %.0.in = phi i1 [ %0, %bb3 ], [ %2, %bb7 ], [ %1, %bb6 ]
  ret i1 %.0.in
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal void @_ZN4core3ptr13drop_in_place17h289d300cc59dc718E(i64* mpk_unsafe nocapture %_1) unnamed_addr #2 {
start:
  ret void
}

; Function Attrs: nonlazybind uwtable
define void @"_ZN11rand_chacha6chacha10abstract20138_$LT$impl$u20$core..convert..From$LT$$RF$rand_chacha..chacha..abstract20..ChaCha20Rng$GT$$u20$for$u20$rand_chacha..chacha..ChaCha20Rng$GT$4from17h57ef7ade611a71b8E"(%"chacha::ChaCha20Rng"* noalias nocapture sret dereferenceable(320) %r, %"chacha::abstract20::ChaCha20Rng"* mpk_immut noalias nocapture readonly align 8 dereferenceable(56) %a) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_2.i.i = alloca %"guts::ChaCha", align 16
  %_4.sroa.5.i = alloca { [2 x i32], %"chacha::ChaCha20Core", [0 x i64] }, align 8
  %_3.i = alloca [32 x i8], align 8
  %core.sroa.0.i = alloca %"guts::ChaCha", align 16
  %0 = getelementptr inbounds %"chacha::abstract20::ChaCha20Rng", %"chacha::abstract20::ChaCha20Rng"* %a, i64 0, i32 5, i64 0
  %core.sroa.0.0.sroa_cast.i = bitcast %"guts::ChaCha"* %core.sroa.0.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %core.sroa.0.0.sroa_cast.i)
  %1 = getelementptr inbounds [32 x i8], [32 x i8]* %_3.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %1), !noalias !27
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(32) %1, i8* nonnull align 8 dereferenceable(32) %0, i64 32, i1 false)
  %2 = bitcast %"guts::ChaCha"* %_2.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %2), !noalias !31
  %3 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %4 = load atomic i64, i64* %3 monotonic, align 8, !noalias !35
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %bb1.i.i.i.i.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i

bb1.i.i.i.i.i.i.i.i:                              ; preds = %start
  %_2.i.i.i.i.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !35
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i: ; preds = %bb1.i.i.i.i.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i.i.i.i.i = phi i64 [ %_2.i.i.i.i.i.i.i.i.i, %bb1.i.i.i.i.i.i.i.i ], [ %4, %start ]
  %.0.i6.in.in.i.i.i.i.i.i.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i.i, label %bb2.i.i.i.i, label %bb3.i.i.i.i

bb2.i.i.i.i:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i
  %6 = bitcast [32 x i8]* %_3.i to i128*
  %.0.copyload.i.i53102.i.i.i.i.i.i = load i128, i128* %6, align 8, !alias.scope !43, !noalias !52
  %7 = getelementptr inbounds [32 x i8], [32 x i8]* %_3.i, i64 0, i64 16
  %8 = bitcast i8* %7 to i128*
  %.0.copyload.i.i103.i.i.i.i.i.i = load i128, i128* %8, align 8, !alias.scope !59, !noalias !64
  %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i.i.i.i.i.i = bitcast %"guts::ChaCha"* %_2.i.i to i128*
  store i128 %.0.copyload.i.i53102.i.i.i.i.i.i, i128* %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !67, !noalias !68
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i.i.i.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %_2.i.i, i64 0, i32 3
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i.i.i.i.i.i to i128*
  store i128 %.0.copyload.i.i103.i.i.i.i.i.i, i128* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !67, !noalias !68
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i.i.i.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %_2.i.i, i64 0, i32 5
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i.i.i.i.i.i to i128*
  store i128 0, i128* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !67, !noalias !68
  br label %"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E.exit"

bb3.i.i.i.i:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i
  call fastcc void @_ZN11rand_chacha4guts11init_chacha8impl_avx17h3e4f4620b5fbdc3cE(%"guts::ChaCha"* noalias nocapture nonnull dereferenceable(48) %_2.i.i, [32 x i8]* mpk_immut noalias nonnull readonly align 1 dereferenceable(32) %_3.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc107 to [0 x i8]*), i64 8), !noalias !69
  br label %"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E.exit"

"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E.exit": ; preds = %bb3.i.i.i.i, %bb2.i.i.i.i
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(48) %core.sroa.0.0.sroa_cast.i, i8* nonnull align 16 dereferenceable(48) %2, i64 48, i1 false), !noalias !70
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %2), !noalias !31
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %1), !noalias !27
  %_4.sroa.5.0.sroa_cast.i = bitcast { [2 x i32], %"chacha::ChaCha20Core", [0 x i64] }* %_4.sroa.5.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %_4.sroa.5.0.sroa_cast.i)
  %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_idx.i = getelementptr inbounds { [2 x i32], %"chacha::ChaCha20Core", [0 x i64] }, { [2 x i32], %"chacha::ChaCha20Core", [0 x i64] }* %_4.sroa.5.i, i64 0, i32 1
  %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_cast.i = bitcast %"chacha::ChaCha20Core"* %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_idx.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(48) %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_cast.i, i8* nonnull align 16 dereferenceable(48) %core.sroa.0.0.sroa_cast.i, i64 48, i1 false), !noalias !27
  %_4.sroa.0.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha20Rng", %"chacha::ChaCha20Rng"* %r, i64 0, i32 0, i64 0
  store i64 64, i64* %_4.sroa.0.0..sroa_idx.i, align 16, !alias.scope !71, !noalias !72
  %_4.sroa.4.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha20Rng", %"chacha::ChaCha20Rng"* %r, i64 0, i32 1, i32 3
  %_4.sroa.4.0..sroa_cast.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to i8*
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(256) %_4.sroa.4.0..sroa_cast.i, i8 0, i64 256, i1 false), !alias.scope !71, !noalias !72
  %_4.sroa.5.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha20Rng", %"chacha::ChaCha20Rng"* %r, i64 0, i32 1, i32 4
  %_4.sroa.5.0..sroa_cast.i = bitcast [2 x i32]* %_4.sroa.5.0..sroa_idx.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(56) %_4.sroa.5.0..sroa_cast.i, i8* nonnull align 8 dereferenceable(56) %_4.sroa.5.0.sroa_cast.i, i64 56, i1 false), !noalias !72
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %_4.sroa.5.0.sroa_cast.i)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %core.sroa.0.0.sroa_cast.i)
  %9 = getelementptr inbounds %"chacha::abstract20::ChaCha20Rng", %"chacha::abstract20::ChaCha20Rng"* %a, i64 0, i32 0, i64 0
  %_5 = load i64, i64* %9, align 8
  %10 = getelementptr inbounds %"chacha::ChaCha20Rng", %"chacha::ChaCha20Rng"* %r, i64 0, i32 1, i32 5
  %_4.i = bitcast %"chacha::ChaCha20Core"* %10 to %"guts::ChaCha"*
  %11 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %12 = load atomic i64, i64* %11 monotonic, align 8
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %bb1.i.i.i.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i

bb1.i.i.i.i.i.i.i:                                ; preds = %"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E.exit"
  %_2.i.i.i.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i: ; preds = %bb1.i.i.i.i.i.i.i, %"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E.exit"
  %.0.i6.in.in.i.i.in.i.i.i.i = phi i64 [ %_2.i.i.i.i.i.i.i.i, %bb1.i.i.i.i.i.i.i ], [ %12, %"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E.exit" ]
  %.0.i6.in.in.i.i.i.i.i.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i, label %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread, label %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i

_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread: ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i
  %14 = getelementptr inbounds %"chacha::ChaCha20Rng", %"chacha::ChaCha20Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %15 = bitcast %"ppv_lite86::vec128_storage"* %14 to <16 x i8>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i = load <16 x i8>, <16 x i8>* %15, align 16
  %_13.i.i.i.i.i = lshr i64 %_5, 32
  %_12.i.i.i.i.i = trunc i64 %_13.i.i.i.i.i to i32
  %16 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %_7.sroa.0.0.copyload.i.i.i1.i.i, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 undef, i32 undef, i32 undef, i32 undef>
  %.12.vec.insert.i.i18.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 undef>, i32 %_12.i.i.i.i.i, i32 0
  %17 = bitcast <16 x i8> %16 to <4 x i32>
  %18 = or <4 x i32> %.12.vec.insert.i.i18.i.i.i.i.i, %17
  %19 = shufflevector <4 x i32> %18, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 undef, i32 0>
  %_18.i.i.i.i.i = trunc i64 %_5 to i32
  %20 = shufflevector <4 x i32> %19, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 3, i32 undef>
  %21 = bitcast <4 x i32> %20 to <16 x i8>
  %22 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %21, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i7.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i, i32 0
  %23 = bitcast <16 x i8> %22 to <4 x i32>
  %24 = or <4 x i32> %.12.vec.insert.i7.i.i.i.i.i.i, %23
  %25 = shufflevector <4 x i32> %24, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 0, i32 3>
  %26 = bitcast %"ppv_lite86::vec128_storage"* %14 to <4 x i32>*
  store <4 x i32> %25, <4 x i32>* %26, align 16
  br label %_ZN11rand_chacha6chacha11ChaCha20Rng10set_stream17he817990549f8949aE.exit

_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i: ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 1, i64 %_5)
  %.idx.val.i.pre = load i64, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  %27 = icmp eq i64 %.idx.val.i.pre, 64
  br i1 %27, label %_ZN11rand_chacha6chacha11ChaCha20Rng10set_stream17he817990549f8949aE.exit, label %bb4.i

bb4.i:                                            ; preds = %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i
  %28 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %29 = load atomic i64, i64* %28 monotonic, align 8, !noalias !73
  %30 = icmp eq i64 %29, 0
  br i1 %30, label %bb1.i.i.i.i.i.i.i.i2, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6

bb1.i.i.i.i.i.i.i.i2:                             ; preds = %bb4.i
  %_2.i.i.i.i.i.i.i.i.i1 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !73
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6: ; preds = %bb1.i.i.i.i.i.i.i.i2, %bb4.i
  %.0.i6.in.in.i.i.in.i.i.i.i.i3 = phi i64 [ %_2.i.i.i.i.i.i.i.i.i1, %bb1.i.i.i.i.i.i.i.i2 ], [ %29, %bb4.i ]
  %.0.i6.in.in.i.i.i.i.i.i.i4 = and i64 %.0.i6.in.in.i.i.in.i.i.i.i.i3, 16384
  %.0.i6.in.i.i.i.not.i.i.i.i5 = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i.i4, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i.i5, label %bb2.i.i.i.i7, label %bb3.i.i.i.i8

bb2.i.i.i.i7:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6
  %31 = getelementptr inbounds %"chacha::ChaCha20Rng", %"chacha::ChaCha20Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_6.sroa.0.0..sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %31 to <2 x i64>*
  %_6.sroa.0.0.copyload.i.i.i.i.i.i = load <2 x i64>, <2 x i64>* %_6.sroa.0.0..sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !80
  %32 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i.i.i.i.i.i, i32 0
  br label %_ZN11rand_chacha6chacha11ChaCha20Rng12get_word_pos17h391d271e5c0204b8E.exit.i

bb3.i.i.i.i8:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6
  %33 = tail call fastcc i64 @_ZN11rand_chacha4guts16get_stream_param8impl_avx17h0b434e849102fe12E(%"guts::ChaCha"* mpk_immut noalias nonnull readonly align 16 dereferenceable(48) %_4.i, i32 0)
  br label %_ZN11rand_chacha6chacha11ChaCha20Rng12get_word_pos17h391d271e5c0204b8E.exit.i

_ZN11rand_chacha6chacha11ChaCha20Rng12get_word_pos17h391d271e5c0204b8E.exit.i: ; preds = %bb3.i.i.i.i8, %bb2.i.i.i.i7
  %.0.i.i.i.i = phi i64 [ %33, %bb3.i.i.i.i8 ], [ %32, %bb2.i.i.i.i7 ]
  %blocks_part.i.i = lshr i64 %.idx.val.i.pre, 4
  %words_part.i.i = and i64 %.idx.val.i.pre, 15
  %34 = add nsw i64 %blocks_part.i.i, -4
  %35 = add i64 %34, %.0.i.i.i.i
  %36 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %37 = load atomic i64, i64* %36 monotonic, align 8
  %38 = icmp eq i64 %37, 0
  br i1 %38, label %bb1.i.i.i.i.i.i.i2.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i

bb1.i.i.i.i.i.i.i2.i:                             ; preds = %_ZN11rand_chacha6chacha11ChaCha20Rng12get_word_pos17h391d271e5c0204b8E.exit.i
  %_2.i.i.i.i.i.i.i.i1.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i: ; preds = %bb1.i.i.i.i.i.i.i2.i, %_ZN11rand_chacha6chacha11ChaCha20Rng12get_word_pos17h391d271e5c0204b8E.exit.i
  %.0.i6.in.in.i.i.in.i.i.i.i3.i = phi i64 [ %_2.i.i.i.i.i.i.i.i1.i, %bb1.i.i.i.i.i.i.i2.i ], [ %37, %_ZN11rand_chacha6chacha11ChaCha20Rng12get_word_pos17h391d271e5c0204b8E.exit.i ]
  %.0.i6.in.in.i.i.i.i.i.i4.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i3.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i5.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i4.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i5.i, label %bb2.i.i.i7.i, label %bb3.i.i.i8.i

bb2.i.i.i7.i:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i
  %39 = getelementptr inbounds %"chacha::ChaCha20Rng", %"chacha::ChaCha20Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_7.sroa.0.0..sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %39 to <2 x i64>*
  %40 = bitcast %"ppv_lite86::vec128_storage"* %39 to <4 x i32>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i.i = load <4 x i32>, <4 x i32>* %40, align 16
  %_13.i.i.i.i2.i.i = lshr i64 %35, 32
  %41 = trunc i64 %_13.i.i.i.i2.i.i to i32
  %42 = shufflevector <4 x i32> %_7.sroa.0.0.copyload.i.i.i1.i.i.i, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 3, i32 undef>
  %43 = bitcast <4 x i32> %42 to <16 x i8>
  %44 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %43, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i14.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %41, i32 0
  %45 = bitcast <16 x i8> %44 to <4 x i32>
  %46 = or <4 x i32> %.12.vec.insert.i13.i14.i.i.i.i.i.i, %45
  %47 = shufflevector <4 x i32> %46, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %_18.i.i.i.i.i.i = trunc i64 %35 to i32
  %_4.0.i20.i.i.i.i.i.i = bitcast <4 x i32> %47 to <2 x i64>
  %48 = and <2 x i64> %_4.0.i20.i.i.i.i.i.i, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i.i, i32 0
  %49 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i.i.i.i.i to <2 x i64>
  %50 = or <2 x i64> %48, %49
  store <2 x i64> %50, <2 x i64>* %_7.sroa.0.0..sroa_cast.i.i.i.i.i.i, align 16
  br label %_ZN11rand_chacha6chacha11ChaCha20Rng12set_word_pos17hb0eee065b627eccbE.exit.i

bb3.i.i.i8.i:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 0, i64 %35)
  br label %_ZN11rand_chacha6chacha11ChaCha20Rng12set_word_pos17hb0eee065b627eccbE.exit.i

_ZN11rand_chacha6chacha11ChaCha20Rng12set_word_pos17hb0eee065b627eccbE.exit.i: ; preds = %bb3.i.i.i8.i, %bb2.i.i.i7.i
  %_8.i.i.i.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to [256 x i8]*
  tail call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 10, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i.i.i.i)
  store i64 %words_part.i.i, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  br label %_ZN11rand_chacha6chacha11ChaCha20Rng10set_stream17he817990549f8949aE.exit

_ZN11rand_chacha6chacha11ChaCha20Rng10set_stream17he817990549f8949aE.exit: ; preds = %_ZN11rand_chacha6chacha11ChaCha20Rng12set_word_pos17hb0eee065b627eccbE.exit.i, %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i, %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread
  %51 = getelementptr inbounds %"chacha::abstract20::ChaCha20Rng", %"chacha::abstract20::ChaCha20Rng"* %a, i64 0, i32 3
  %_8 = load i128, i128* %51, align 8
  %_4.i9 = lshr i128 %_8, 4
  %block.i = trunc i128 %_4.i9 to i64
  %52 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %53 = load atomic i64, i64* %52 monotonic, align 8
  %54 = icmp eq i64 %53, 0
  br i1 %54, label %bb1.i.i.i.i.i.i.i11, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15

bb1.i.i.i.i.i.i.i11:                              ; preds = %_ZN11rand_chacha6chacha11ChaCha20Rng10set_stream17he817990549f8949aE.exit
  %_2.i.i.i.i.i.i.i.i10 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15: ; preds = %bb1.i.i.i.i.i.i.i11, %_ZN11rand_chacha6chacha11ChaCha20Rng10set_stream17he817990549f8949aE.exit
  %.0.i6.in.in.i.i.in.i.i.i.i12 = phi i64 [ %_2.i.i.i.i.i.i.i.i10, %bb1.i.i.i.i.i.i.i11 ], [ %53, %_ZN11rand_chacha6chacha11ChaCha20Rng10set_stream17he817990549f8949aE.exit ]
  %.0.i6.in.in.i.i.i.i.i.i13 = and i64 %.0.i6.in.in.i.i.in.i.i.i.i12, 16384
  %.0.i6.in.i.i.i.not.i.i.i14 = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i13, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i14, label %bb2.i.i.i18, label %bb3.i.i.i19

bb2.i.i.i18:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15
  %55 = getelementptr inbounds %"chacha::ChaCha20Rng", %"chacha::ChaCha20Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_7.sroa.0.0..sroa_cast.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %55 to <2 x i64>*
  %56 = bitcast %"ppv_lite86::vec128_storage"* %55 to <4 x i32>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i16 = load <4 x i32>, <4 x i32>* %56, align 16
  %_13.i.i.i.i2.i = lshr i128 %_8, 36
  %57 = trunc i128 %_13.i.i.i.i2.i to i32
  %58 = shufflevector <4 x i32> %_7.sroa.0.0.copyload.i.i.i1.i.i16, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 3, i32 undef>
  %59 = bitcast <4 x i32> %58 to <16 x i8>
  %60 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %59, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i14.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %57, i32 0
  %61 = bitcast <16 x i8> %60 to <4 x i32>
  %62 = or <4 x i32> %.12.vec.insert.i13.i14.i.i.i.i.i, %61
  %63 = shufflevector <4 x i32> %62, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %_18.i.i.i.i.i17 = trunc i128 %_4.i9 to i32
  %_4.0.i20.i.i.i.i.i = bitcast <4 x i32> %63 to <2 x i64>
  %64 = and <2 x i64> %_4.0.i20.i.i.i.i.i, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i17, i32 0
  %65 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i.i.i.i to <2 x i64>
  %66 = or <2 x i64> %64, %65
  store <2 x i64> %66, <2 x i64>* %_7.sroa.0.0..sroa_cast.i.i.i.i.i, align 16
  br label %_ZN11rand_chacha6chacha11ChaCha20Rng12set_word_pos17hb0eee065b627eccbE.exit

bb3.i.i.i19:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 0, i64 %block.i)
  br label %_ZN11rand_chacha6chacha11ChaCha20Rng12set_word_pos17hb0eee065b627eccbE.exit

_ZN11rand_chacha6chacha11ChaCha20Rng12set_word_pos17hb0eee065b627eccbE.exit: ; preds = %bb3.i.i.i19, %bb2.i.i.i18
  %67 = trunc i128 %_8 to i64
  %_13.i = and i64 %67, 15
  %_8.i.i.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to [256 x i8]*
  tail call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 10, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i.i.i)
  store i64 %_13.i, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  ret void
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN69_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$core..fmt..Debug$GT$3fmt17h489c288f49f53e76E"(%"chacha::ChaCha20Rng"* mpk_immut noalias readonly align 16 dereferenceable(320) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_15 = alloca %"rand_core::block::BlockRng<chacha::ChaCha20Core>"*, align 8
  %debug_trait_builder = alloca %"std::fmt::DebugStruct", align 8
  %0 = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [11 x i8] }>* @alloc3605 to [0 x i8]*), i64 11)
  %.0..sroa_cast = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha20Core>"** %_15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha20Core>"** %_15 to %"chacha::ChaCha20Rng"**
  store %"chacha::ChaCha20Rng"* %self, %"chacha::ChaCha20Rng"** %3, align 8
  %_12.0 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha20Core>"** %_15 to {}*
  %_8 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc3620 to [0 x i8]*), i64 3, {}* mpk_immut nonnull align 1 %_12.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"rand_core::block::BlockRng<chacha::ChaCha20Core>"**)*, i64, i64, i1 (%"rand_core::block::BlockRng<chacha::ChaCha20Core>"**, %"std::fmt::Formatter"*)* }* @vtable.9 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %4 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %4
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN81_$LT$rand_chacha..chacha..abstract20..ChaCha20Rng$u20$as$u20$core..fmt..Debug$GT$3fmt17hf6df398eda42a5ceE"(%"chacha::abstract20::ChaCha20Rng"* mpk_immut noalias readonly align 8 dereferenceable(56) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_33 = alloca i128*, align 8
  %_25 = alloca i64*, align 8
  %_17 = alloca [32 x i8]*, align 8
  %debug_trait_builder = alloca %"std::fmt::DebugStruct", align 8
  %__self_0_0 = getelementptr inbounds %"chacha::abstract20::ChaCha20Rng", %"chacha::abstract20::ChaCha20Rng"* %self, i64 0, i32 5
  %__self_0_1 = getelementptr inbounds %"chacha::abstract20::ChaCha20Rng", %"chacha::abstract20::ChaCha20Rng"* %self, i64 0, i32 0, i64 0
  %__self_0_2 = getelementptr inbounds %"chacha::abstract20::ChaCha20Rng", %"chacha::abstract20::ChaCha20Rng"* %self, i64 0, i32 3
  %0 = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [11 x i8] }>* @alloc3605 to [0 x i8]*), i64 11)
  %.0..sroa_cast = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast [32 x i8]** %_17 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  store [32 x i8]* %__self_0_0, [32 x i8]** %_17, align 8
  %_14.0 = bitcast [32 x i8]** %_17 to {}*
  %_10 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc3622 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_14.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ([32 x i8]**)*, i64, i64, i1 ([32 x i8]**, %"std::fmt::Formatter"*)* }* @vtable.a to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast i64** %_25 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  store i64* %__self_0_1, i64** %_25, align 8
  %_22.0 = bitcast i64** %_25 to {}*
  %_18 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc3623 to [0 x i8]*), i64 6, {}* mpk_immut nonnull align 1 %_22.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"std::fmt::Formatter"*)* }* @vtable.b to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  %4 = bitcast i128** %_33 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4)
  store i128* %__self_0_2, i128** %_33, align 8
  %_30.0 = bitcast i128** %_33 to {}*
  %_26 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc3624 to [0 x i8]*), i64 8, {}* mpk_immut nonnull align 1 %_30.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i128**)*, i64, i64, i1 (i128**, %"std::fmt::Formatter"*)* }* @vtable.c to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4)
  %5 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %5
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN73_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17ha685a9015f95964aE"(%"chacha::ChaCha12Rng"* mpk_immut noalias nocapture readonly align 16 dereferenceable(320) %self, %"chacha::ChaCha12Rng"* mpk_immut noalias nocapture readonly align 16 dereferenceable(320) %rhs) unnamed_addr #0 {
start:
  %b = alloca %"chacha::abstract12::ChaCha12Rng", align 8
  %a = alloca %"chacha::abstract12::ChaCha12Rng", align 8
  %0 = bitcast %"chacha::abstract12::ChaCha12Rng"* %a to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %0)
  call void bitcast (void (%"chacha::abstract8::ChaCha8Rng"*, %"chacha::ChaCha8Rng"*)* @"_ZN125_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha8Rng$GT$$GT$4from17h7d35d0daa8dabf82E" to void (%"chacha::abstract12::ChaCha12Rng"*, %"chacha::ChaCha12Rng"*)*)(%"chacha::abstract12::ChaCha12Rng"* noalias nocapture nonnull sret dereferenceable(56) %a, %"chacha::ChaCha12Rng"* mpk_immut noalias nonnull readonly align 16 dereferenceable(320) %self)
  %1 = bitcast %"chacha::abstract12::ChaCha12Rng"* %b to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %1)
  call void bitcast (void (%"chacha::abstract8::ChaCha8Rng"*, %"chacha::ChaCha8Rng"*)* @"_ZN125_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha8Rng$GT$$GT$4from17h7d35d0daa8dabf82E" to void (%"chacha::abstract12::ChaCha12Rng"*, %"chacha::ChaCha12Rng"*)*)(%"chacha::abstract12::ChaCha12Rng"* noalias nocapture nonnull sret dereferenceable(56) %b, %"chacha::ChaCha12Rng"* mpk_immut noalias nonnull readonly align 16 dereferenceable(320) %rhs)
  %__self_1_2.i = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %b, i64 0, i32 3
  %__self_0_2.i = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %a, i64 0, i32 3
  %2 = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %b, i64 0, i32 5, i64 0
  %3 = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %a, i64 0, i32 5, i64 0
  %bcmp.i.i.i.i = call i32 @bcmp(i8* nonnull dereferenceable(32) %3, i8* nonnull dereferenceable(32) %2, i64 32) #14
  %4 = icmp eq i32 %bcmp.i.i.i.i, 0
  br i1 %4, label %bb7.i, label %bb2.i

bb2.i:                                            ; preds = %bb7.i, %bb3.i, %start
  br label %"_ZN85_$LT$rand_chacha..chacha..abstract12..ChaCha12Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h31374eb7e10bff25E.exit"

bb3.i:                                            ; preds = %bb7.i
  %_17.i = load i128, i128* %__self_0_2.i, align 8, !alias.scope !85, !noalias !88
  %_18.i = load i128, i128* %__self_1_2.i, align 8, !alias.scope !88, !noalias !85
  %_16.i = icmp eq i128 %_17.i, %_18.i
  br i1 %_16.i, label %"_ZN85_$LT$rand_chacha..chacha..abstract12..ChaCha12Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h31374eb7e10bff25E.exit", label %bb2.i

bb7.i:                                            ; preds = %start
  %__self_0_1.i = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %a, i64 0, i32 0, i64 0
  %__self_1_1.i = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %b, i64 0, i32 0, i64 0
  %_14.i = load i64, i64* %__self_0_1.i, align 8, !alias.scope !85, !noalias !88
  %_15.i = load i64, i64* %__self_1_1.i, align 8, !alias.scope !88, !noalias !85
  %_13.i = icmp eq i64 %_14.i, %_15.i
  br i1 %_13.i, label %bb3.i, label %bb2.i

"_ZN85_$LT$rand_chacha..chacha..abstract12..ChaCha12Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h31374eb7e10bff25E.exit": ; preds = %bb3.i, %bb2.i
  %.0.i = phi i1 [ false, %bb2.i ], [ true, %bb3.i ]
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %1)
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %0)
  ret i1 %.0.i
}

; Function Attrs: nonlazybind uwtable
define void @"_ZN11rand_chacha6chacha10abstract12138_$LT$impl$u20$core..convert..From$LT$$RF$rand_chacha..chacha..abstract12..ChaCha12Rng$GT$$u20$for$u20$rand_chacha..chacha..ChaCha12Rng$GT$4from17hb36f3ab4642cc902E"(%"chacha::ChaCha12Rng"* noalias nocapture sret dereferenceable(320) %r, %"chacha::abstract12::ChaCha12Rng"* mpk_immut noalias nocapture readonly align 8 dereferenceable(56) %a) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_2.i.i = alloca %"guts::ChaCha", align 16
  %_4.sroa.5.i = alloca { [2 x i32], %"chacha::ChaCha12Core", [0 x i64] }, align 8
  %_3.i = alloca [32 x i8], align 8
  %core.sroa.0.i = alloca %"guts::ChaCha", align 16
  %0 = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %a, i64 0, i32 5, i64 0
  %core.sroa.0.0.sroa_cast.i = bitcast %"guts::ChaCha"* %core.sroa.0.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %core.sroa.0.0.sroa_cast.i)
  %1 = getelementptr inbounds [32 x i8], [32 x i8]* %_3.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %1), !noalias !90
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(32) %1, i8* nonnull align 8 dereferenceable(32) %0, i64 32, i1 false)
  %2 = bitcast %"guts::ChaCha"* %_2.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %2), !noalias !94
  %3 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %4 = load atomic i64, i64* %3 monotonic, align 8, !noalias !98
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %bb1.i.i.i.i.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i

bb1.i.i.i.i.i.i.i.i:                              ; preds = %start
  %_2.i.i.i.i.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !98
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i: ; preds = %bb1.i.i.i.i.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i.i.i.i.i = phi i64 [ %_2.i.i.i.i.i.i.i.i.i, %bb1.i.i.i.i.i.i.i.i ], [ %4, %start ]
  %.0.i6.in.in.i.i.i.i.i.i.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i.i, label %bb2.i.i.i.i, label %bb3.i.i.i.i

bb2.i.i.i.i:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i
  %6 = bitcast [32 x i8]* %_3.i to i128*
  %.0.copyload.i.i53102.i.i.i.i.i.i = load i128, i128* %6, align 8, !alias.scope !106, !noalias !115
  %7 = getelementptr inbounds [32 x i8], [32 x i8]* %_3.i, i64 0, i64 16
  %8 = bitcast i8* %7 to i128*
  %.0.copyload.i.i103.i.i.i.i.i.i = load i128, i128* %8, align 8, !alias.scope !122, !noalias !127
  %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i.i.i.i.i.i = bitcast %"guts::ChaCha"* %_2.i.i to i128*
  store i128 %.0.copyload.i.i53102.i.i.i.i.i.i, i128* %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !130, !noalias !131
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i.i.i.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %_2.i.i, i64 0, i32 3
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i.i.i.i.i.i to i128*
  store i128 %.0.copyload.i.i103.i.i.i.i.i.i, i128* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !130, !noalias !131
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i.i.i.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %_2.i.i, i64 0, i32 5
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i.i.i.i.i.i to i128*
  store i128 0, i128* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !130, !noalias !131
  br label %"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E.exit"

bb3.i.i.i.i:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i
  call fastcc void @_ZN11rand_chacha4guts11init_chacha8impl_avx17h3e4f4620b5fbdc3cE(%"guts::ChaCha"* noalias nocapture nonnull dereferenceable(48) %_2.i.i, [32 x i8]* mpk_immut noalias nonnull readonly align 1 dereferenceable(32) %_3.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc107 to [0 x i8]*), i64 8), !noalias !132
  br label %"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E.exit"

"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E.exit": ; preds = %bb3.i.i.i.i, %bb2.i.i.i.i
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(48) %core.sroa.0.0.sroa_cast.i, i8* nonnull align 16 dereferenceable(48) %2, i64 48, i1 false), !noalias !133
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %2), !noalias !94
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %1), !noalias !90
  %_4.sroa.5.0.sroa_cast.i = bitcast { [2 x i32], %"chacha::ChaCha12Core", [0 x i64] }* %_4.sroa.5.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %_4.sroa.5.0.sroa_cast.i)
  %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_idx.i = getelementptr inbounds { [2 x i32], %"chacha::ChaCha12Core", [0 x i64] }, { [2 x i32], %"chacha::ChaCha12Core", [0 x i64] }* %_4.sroa.5.i, i64 0, i32 1
  %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_cast.i = bitcast %"chacha::ChaCha12Core"* %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_idx.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(48) %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_cast.i, i8* nonnull align 16 dereferenceable(48) %core.sroa.0.0.sroa_cast.i, i64 48, i1 false), !noalias !90
  %_4.sroa.0.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha12Rng", %"chacha::ChaCha12Rng"* %r, i64 0, i32 0, i64 0
  store i64 64, i64* %_4.sroa.0.0..sroa_idx.i, align 16, !alias.scope !134, !noalias !135
  %_4.sroa.4.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha12Rng", %"chacha::ChaCha12Rng"* %r, i64 0, i32 1, i32 3
  %_4.sroa.4.0..sroa_cast.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to i8*
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(256) %_4.sroa.4.0..sroa_cast.i, i8 0, i64 256, i1 false), !alias.scope !134, !noalias !135
  %_4.sroa.5.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha12Rng", %"chacha::ChaCha12Rng"* %r, i64 0, i32 1, i32 4
  %_4.sroa.5.0..sroa_cast.i = bitcast [2 x i32]* %_4.sroa.5.0..sroa_idx.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(56) %_4.sroa.5.0..sroa_cast.i, i8* nonnull align 8 dereferenceable(56) %_4.sroa.5.0.sroa_cast.i, i64 56, i1 false), !noalias !135
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %_4.sroa.5.0.sroa_cast.i)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %core.sroa.0.0.sroa_cast.i)
  %9 = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %a, i64 0, i32 0, i64 0
  %_5 = load i64, i64* %9, align 8
  %10 = getelementptr inbounds %"chacha::ChaCha12Rng", %"chacha::ChaCha12Rng"* %r, i64 0, i32 1, i32 5
  %_4.i = bitcast %"chacha::ChaCha12Core"* %10 to %"guts::ChaCha"*
  %11 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %12 = load atomic i64, i64* %11 monotonic, align 8
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %bb1.i.i.i.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i

bb1.i.i.i.i.i.i.i:                                ; preds = %"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E.exit"
  %_2.i.i.i.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i: ; preds = %bb1.i.i.i.i.i.i.i, %"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E.exit"
  %.0.i6.in.in.i.i.in.i.i.i.i = phi i64 [ %_2.i.i.i.i.i.i.i.i, %bb1.i.i.i.i.i.i.i ], [ %12, %"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E.exit" ]
  %.0.i6.in.in.i.i.i.i.i.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i, label %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread, label %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i

_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread: ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i
  %14 = getelementptr inbounds %"chacha::ChaCha12Rng", %"chacha::ChaCha12Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %15 = bitcast %"ppv_lite86::vec128_storage"* %14 to <16 x i8>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i = load <16 x i8>, <16 x i8>* %15, align 16
  %_13.i.i.i.i.i = lshr i64 %_5, 32
  %_12.i.i.i.i.i = trunc i64 %_13.i.i.i.i.i to i32
  %16 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %_7.sroa.0.0.copyload.i.i.i1.i.i, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 undef, i32 undef, i32 undef, i32 undef>
  %.12.vec.insert.i.i18.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 undef>, i32 %_12.i.i.i.i.i, i32 0
  %17 = bitcast <16 x i8> %16 to <4 x i32>
  %18 = or <4 x i32> %.12.vec.insert.i.i18.i.i.i.i.i, %17
  %19 = shufflevector <4 x i32> %18, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 undef, i32 0>
  %_18.i.i.i.i.i = trunc i64 %_5 to i32
  %20 = shufflevector <4 x i32> %19, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 3, i32 undef>
  %21 = bitcast <4 x i32> %20 to <16 x i8>
  %22 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %21, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i7.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i, i32 0
  %23 = bitcast <16 x i8> %22 to <4 x i32>
  %24 = or <4 x i32> %.12.vec.insert.i7.i.i.i.i.i.i, %23
  %25 = shufflevector <4 x i32> %24, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 0, i32 3>
  %26 = bitcast %"ppv_lite86::vec128_storage"* %14 to <4 x i32>*
  store <4 x i32> %25, <4 x i32>* %26, align 16
  br label %_ZN11rand_chacha6chacha11ChaCha12Rng10set_stream17ha7b1eb6f21de0a85E.exit

_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i: ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 1, i64 %_5)
  %.idx.val.i.pre = load i64, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  %27 = icmp eq i64 %.idx.val.i.pre, 64
  br i1 %27, label %_ZN11rand_chacha6chacha11ChaCha12Rng10set_stream17ha7b1eb6f21de0a85E.exit, label %bb4.i

bb4.i:                                            ; preds = %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i
  %28 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %29 = load atomic i64, i64* %28 monotonic, align 8, !noalias !136
  %30 = icmp eq i64 %29, 0
  br i1 %30, label %bb1.i.i.i.i.i.i.i.i2, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6

bb1.i.i.i.i.i.i.i.i2:                             ; preds = %bb4.i
  %_2.i.i.i.i.i.i.i.i.i1 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !136
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6: ; preds = %bb1.i.i.i.i.i.i.i.i2, %bb4.i
  %.0.i6.in.in.i.i.in.i.i.i.i.i3 = phi i64 [ %_2.i.i.i.i.i.i.i.i.i1, %bb1.i.i.i.i.i.i.i.i2 ], [ %29, %bb4.i ]
  %.0.i6.in.in.i.i.i.i.i.i.i4 = and i64 %.0.i6.in.in.i.i.in.i.i.i.i.i3, 16384
  %.0.i6.in.i.i.i.not.i.i.i.i5 = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i.i4, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i.i5, label %bb2.i.i.i.i7, label %bb3.i.i.i.i8

bb2.i.i.i.i7:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6
  %31 = getelementptr inbounds %"chacha::ChaCha12Rng", %"chacha::ChaCha12Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_6.sroa.0.0..sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %31 to <2 x i64>*
  %_6.sroa.0.0.copyload.i.i.i.i.i.i = load <2 x i64>, <2 x i64>* %_6.sroa.0.0..sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !143
  %32 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i.i.i.i.i.i, i32 0
  br label %_ZN11rand_chacha6chacha11ChaCha12Rng12get_word_pos17h68aafae48ddad3a6E.exit.i

bb3.i.i.i.i8:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6
  %33 = tail call fastcc i64 @_ZN11rand_chacha4guts16get_stream_param8impl_avx17h0b434e849102fe12E(%"guts::ChaCha"* mpk_immut noalias nonnull readonly align 16 dereferenceable(48) %_4.i, i32 0)
  br label %_ZN11rand_chacha6chacha11ChaCha12Rng12get_word_pos17h68aafae48ddad3a6E.exit.i

_ZN11rand_chacha6chacha11ChaCha12Rng12get_word_pos17h68aafae48ddad3a6E.exit.i: ; preds = %bb3.i.i.i.i8, %bb2.i.i.i.i7
  %.0.i.i.i.i = phi i64 [ %33, %bb3.i.i.i.i8 ], [ %32, %bb2.i.i.i.i7 ]
  %blocks_part.i.i = lshr i64 %.idx.val.i.pre, 4
  %words_part.i.i = and i64 %.idx.val.i.pre, 15
  %34 = add nsw i64 %blocks_part.i.i, -4
  %35 = add i64 %34, %.0.i.i.i.i
  %36 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %37 = load atomic i64, i64* %36 monotonic, align 8
  %38 = icmp eq i64 %37, 0
  br i1 %38, label %bb1.i.i.i.i.i.i.i2.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i

bb1.i.i.i.i.i.i.i2.i:                             ; preds = %_ZN11rand_chacha6chacha11ChaCha12Rng12get_word_pos17h68aafae48ddad3a6E.exit.i
  %_2.i.i.i.i.i.i.i.i1.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i: ; preds = %bb1.i.i.i.i.i.i.i2.i, %_ZN11rand_chacha6chacha11ChaCha12Rng12get_word_pos17h68aafae48ddad3a6E.exit.i
  %.0.i6.in.in.i.i.in.i.i.i.i3.i = phi i64 [ %_2.i.i.i.i.i.i.i.i1.i, %bb1.i.i.i.i.i.i.i2.i ], [ %37, %_ZN11rand_chacha6chacha11ChaCha12Rng12get_word_pos17h68aafae48ddad3a6E.exit.i ]
  %.0.i6.in.in.i.i.i.i.i.i4.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i3.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i5.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i4.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i5.i, label %bb2.i.i.i7.i, label %bb3.i.i.i8.i

bb2.i.i.i7.i:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i
  %39 = getelementptr inbounds %"chacha::ChaCha12Rng", %"chacha::ChaCha12Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_7.sroa.0.0..sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %39 to <2 x i64>*
  %40 = bitcast %"ppv_lite86::vec128_storage"* %39 to <4 x i32>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i.i = load <4 x i32>, <4 x i32>* %40, align 16
  %_13.i.i.i.i2.i.i = lshr i64 %35, 32
  %41 = trunc i64 %_13.i.i.i.i2.i.i to i32
  %42 = shufflevector <4 x i32> %_7.sroa.0.0.copyload.i.i.i1.i.i.i, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 3, i32 undef>
  %43 = bitcast <4 x i32> %42 to <16 x i8>
  %44 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %43, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i14.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %41, i32 0
  %45 = bitcast <16 x i8> %44 to <4 x i32>
  %46 = or <4 x i32> %.12.vec.insert.i13.i14.i.i.i.i.i.i, %45
  %47 = shufflevector <4 x i32> %46, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %_18.i.i.i.i.i.i = trunc i64 %35 to i32
  %_4.0.i20.i.i.i.i.i.i = bitcast <4 x i32> %47 to <2 x i64>
  %48 = and <2 x i64> %_4.0.i20.i.i.i.i.i.i, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i.i, i32 0
  %49 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i.i.i.i.i to <2 x i64>
  %50 = or <2 x i64> %48, %49
  store <2 x i64> %50, <2 x i64>* %_7.sroa.0.0..sroa_cast.i.i.i.i.i.i, align 16
  br label %_ZN11rand_chacha6chacha11ChaCha12Rng12set_word_pos17h40681a1c04c41252E.exit.i

bb3.i.i.i8.i:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 0, i64 %35)
  br label %_ZN11rand_chacha6chacha11ChaCha12Rng12set_word_pos17h40681a1c04c41252E.exit.i

_ZN11rand_chacha6chacha11ChaCha12Rng12set_word_pos17h40681a1c04c41252E.exit.i: ; preds = %bb3.i.i.i8.i, %bb2.i.i.i7.i
  %_8.i.i.i.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to [256 x i8]*
  tail call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 6, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i.i.i.i)
  store i64 %words_part.i.i, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  br label %_ZN11rand_chacha6chacha11ChaCha12Rng10set_stream17ha7b1eb6f21de0a85E.exit

_ZN11rand_chacha6chacha11ChaCha12Rng10set_stream17ha7b1eb6f21de0a85E.exit: ; preds = %_ZN11rand_chacha6chacha11ChaCha12Rng12set_word_pos17h40681a1c04c41252E.exit.i, %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i, %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread
  %51 = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %a, i64 0, i32 3
  %_8 = load i128, i128* %51, align 8
  %_4.i9 = lshr i128 %_8, 4
  %block.i = trunc i128 %_4.i9 to i64
  %52 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %53 = load atomic i64, i64* %52 monotonic, align 8
  %54 = icmp eq i64 %53, 0
  br i1 %54, label %bb1.i.i.i.i.i.i.i11, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15

bb1.i.i.i.i.i.i.i11:                              ; preds = %_ZN11rand_chacha6chacha11ChaCha12Rng10set_stream17ha7b1eb6f21de0a85E.exit
  %_2.i.i.i.i.i.i.i.i10 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15: ; preds = %bb1.i.i.i.i.i.i.i11, %_ZN11rand_chacha6chacha11ChaCha12Rng10set_stream17ha7b1eb6f21de0a85E.exit
  %.0.i6.in.in.i.i.in.i.i.i.i12 = phi i64 [ %_2.i.i.i.i.i.i.i.i10, %bb1.i.i.i.i.i.i.i11 ], [ %53, %_ZN11rand_chacha6chacha11ChaCha12Rng10set_stream17ha7b1eb6f21de0a85E.exit ]
  %.0.i6.in.in.i.i.i.i.i.i13 = and i64 %.0.i6.in.in.i.i.in.i.i.i.i12, 16384
  %.0.i6.in.i.i.i.not.i.i.i14 = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i13, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i14, label %bb2.i.i.i18, label %bb3.i.i.i19

bb2.i.i.i18:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15
  %55 = getelementptr inbounds %"chacha::ChaCha12Rng", %"chacha::ChaCha12Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_7.sroa.0.0..sroa_cast.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %55 to <2 x i64>*
  %56 = bitcast %"ppv_lite86::vec128_storage"* %55 to <4 x i32>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i16 = load <4 x i32>, <4 x i32>* %56, align 16
  %_13.i.i.i.i2.i = lshr i128 %_8, 36
  %57 = trunc i128 %_13.i.i.i.i2.i to i32
  %58 = shufflevector <4 x i32> %_7.sroa.0.0.copyload.i.i.i1.i.i16, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 3, i32 undef>
  %59 = bitcast <4 x i32> %58 to <16 x i8>
  %60 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %59, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i14.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %57, i32 0
  %61 = bitcast <16 x i8> %60 to <4 x i32>
  %62 = or <4 x i32> %.12.vec.insert.i13.i14.i.i.i.i.i, %61
  %63 = shufflevector <4 x i32> %62, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %_18.i.i.i.i.i17 = trunc i128 %_4.i9 to i32
  %_4.0.i20.i.i.i.i.i = bitcast <4 x i32> %63 to <2 x i64>
  %64 = and <2 x i64> %_4.0.i20.i.i.i.i.i, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i17, i32 0
  %65 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i.i.i.i to <2 x i64>
  %66 = or <2 x i64> %64, %65
  store <2 x i64> %66, <2 x i64>* %_7.sroa.0.0..sroa_cast.i.i.i.i.i, align 16
  br label %_ZN11rand_chacha6chacha11ChaCha12Rng12set_word_pos17h40681a1c04c41252E.exit

bb3.i.i.i19:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 0, i64 %block.i)
  br label %_ZN11rand_chacha6chacha11ChaCha12Rng12set_word_pos17h40681a1c04c41252E.exit

_ZN11rand_chacha6chacha11ChaCha12Rng12set_word_pos17h40681a1c04c41252E.exit: ; preds = %bb3.i.i.i19, %bb2.i.i.i18
  %67 = trunc i128 %_8 to i64
  %_13.i = and i64 %67, 15
  %_8.i.i.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to [256 x i8]*
  tail call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 6, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i.i.i)
  store i64 %_13.i, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  ret void
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN69_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$core..fmt..Debug$GT$3fmt17h59b609cdf02c63acE"(%"chacha::ChaCha12Rng"* mpk_immut noalias readonly align 16 dereferenceable(320) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_15 = alloca %"rand_core::block::BlockRng<chacha::ChaCha12Core>"*, align 8
  %debug_trait_builder = alloca %"std::fmt::DebugStruct", align 8
  %0 = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [11 x i8] }>* @alloc3613 to [0 x i8]*), i64 11)
  %.0..sroa_cast = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha12Core>"** %_15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha12Core>"** %_15 to %"chacha::ChaCha12Rng"**
  store %"chacha::ChaCha12Rng"* %self, %"chacha::ChaCha12Rng"** %3, align 8
  %_12.0 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha12Core>"** %_15 to {}*
  %_8 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc3620 to [0 x i8]*), i64 3, {}* mpk_immut nonnull align 1 %_12.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"rand_core::block::BlockRng<chacha::ChaCha12Core>"**)*, i64, i64, i1 (%"rand_core::block::BlockRng<chacha::ChaCha12Core>"**, %"std::fmt::Formatter"*)* }* @vtable.d to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %4 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %4
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN81_$LT$rand_chacha..chacha..abstract12..ChaCha12Rng$u20$as$u20$core..fmt..Debug$GT$3fmt17h9575856c7e6b6357E"(%"chacha::abstract12::ChaCha12Rng"* mpk_immut noalias readonly align 8 dereferenceable(56) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_33 = alloca i128*, align 8
  %_25 = alloca i64*, align 8
  %_17 = alloca [32 x i8]*, align 8
  %debug_trait_builder = alloca %"std::fmt::DebugStruct", align 8
  %__self_0_0 = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %self, i64 0, i32 5
  %__self_0_1 = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %self, i64 0, i32 0, i64 0
  %__self_0_2 = getelementptr inbounds %"chacha::abstract12::ChaCha12Rng", %"chacha::abstract12::ChaCha12Rng"* %self, i64 0, i32 3
  %0 = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [11 x i8] }>* @alloc3613 to [0 x i8]*), i64 11)
  %.0..sroa_cast = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast [32 x i8]** %_17 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  store [32 x i8]* %__self_0_0, [32 x i8]** %_17, align 8
  %_14.0 = bitcast [32 x i8]** %_17 to {}*
  %_10 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc3622 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_14.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ([32 x i8]**)*, i64, i64, i1 ([32 x i8]**, %"std::fmt::Formatter"*)* }* @vtable.a to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast i64** %_25 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  store i64* %__self_0_1, i64** %_25, align 8
  %_22.0 = bitcast i64** %_25 to {}*
  %_18 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc3623 to [0 x i8]*), i64 6, {}* mpk_immut nonnull align 1 %_22.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"std::fmt::Formatter"*)* }* @vtable.b to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  %4 = bitcast i128** %_33 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4)
  store i128* %__self_0_2, i128** %_33, align 8
  %_30.0 = bitcast i128** %_33 to {}*
  %_26 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc3624 to [0 x i8]*), i64 8, {}* mpk_immut nonnull align 1 %_30.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i128**)*, i64, i64, i1 (i128**, %"std::fmt::Formatter"*)* }* @vtable.c to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4)
  %5 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %5
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN69_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$core..fmt..Debug$GT$3fmt17h35bf5edb5ad589ceE"(%"chacha::ChaCha8Core"* mpk_immut noalias nocapture readonly align 16 dereferenceable(48) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = alloca %"std::fmt::Arguments", align 8
  %0 = bitcast %"std::fmt::Arguments"* %_4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %0)
  %1 = bitcast %"std::fmt::Arguments"* %_4 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc2445 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %1, align 8, !alias.scope !148, !noalias !151
  %2 = getelementptr inbounds %"std::fmt::Arguments", %"std::fmt::Arguments"* %_4, i64 0, i32 1, i32 1
  store i64 1, i64* %2, align 8, !alias.scope !148, !noalias !151
  %3 = getelementptr inbounds %"std::fmt::Arguments", %"std::fmt::Arguments"* %_4, i64 0, i32 3, i32 0
  store i64* null, i64** %3, align 8, !alias.scope !148, !noalias !151
  %4 = getelementptr inbounds %"std::fmt::Arguments", %"std::fmt::Arguments"* %_4, i64 0, i32 5, i32 0
  store [0 x { i8*, i64* }]* bitcast (<{ [0 x i8] }>* @alloc2447 to [0 x { i8*, i64* }]*), [0 x { i8*, i64* }]** %4, align 8, !alias.scope !148, !noalias !151
  %5 = getelementptr inbounds %"std::fmt::Arguments", %"std::fmt::Arguments"* %_4, i64 0, i32 5, i32 1
  store i64 0, i64* %5, align 8, !alias.scope !148, !noalias !151
  %6 = call zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, %"std::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_4)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %0)
  ret i1 %6
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN111_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$core..convert..From$LT$rand_chacha..chacha..ChaCha8Core$GT$$GT$4from17h9f3cb76d76adf118E"(%"chacha::ChaCha8Rng"* noalias nocapture sret dereferenceable(320) %0, %"chacha::ChaCha8Core"* noalias nocapture readonly dereferenceable(48) %core) unnamed_addr #3 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_2.sroa.5 = alloca { [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }, align 8
  %_2.sroa.5.0.sroa_cast = bitcast { [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }* %_2.sroa.5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %_2.sroa.5.0.sroa_cast)
  %_3.sroa.0.0..sroa_cast = bitcast %"chacha::ChaCha8Core"* %core to i8*
  %_3.sroa.0.0._2.sroa.5.272.sroa_cast.sroa_idx = getelementptr inbounds { [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }, { [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }* %_2.sroa.5, i64 0, i32 1
  %_3.sroa.0.0._2.sroa.5.272.sroa_cast.sroa_cast = bitcast %"chacha::ChaCha8Core"* %_3.sroa.0.0._2.sroa.5.272.sroa_cast.sroa_idx to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(48) %_3.sroa.0.0._2.sroa.5.272.sroa_cast.sroa_cast, i8* nonnull align 16 dereferenceable(48) %_3.sroa.0.0..sroa_cast, i64 48, i1 false)
  %_2.sroa.0.0..sroa_idx = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %0, i64 0, i32 0, i64 0
  store i64 64, i64* %_2.sroa.0.0..sroa_idx, align 16
  %_2.sroa.4.0..sroa_idx = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %0, i64 0, i32 1, i32 3
  %_2.sroa.4.0..sroa_cast = bitcast %"chacha::Array64<u32>"* %_2.sroa.4.0..sroa_idx to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(256) %_2.sroa.4.0..sroa_cast, i8 0, i64 256, i1 false)
  %_2.sroa.5.0..sroa_idx = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %0, i64 0, i32 1, i32 4
  %_2.sroa.5.0..sroa_cast = bitcast [2 x i32]* %_2.sroa.5.0..sroa_idx to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(56) %_2.sroa.5.0..sroa_cast, i8* nonnull align 8 dereferenceable(56) %_2.sroa.5.0.sroa_cast, i64 56, i1 false)
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %_2.sroa.5.0.sroa_cast)
  ret void
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN72_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h05c5a653687b1e66E"(%"chacha::ChaCha8Rng"* mpk_immut noalias nocapture readonly align 16 dereferenceable(320) %self, %"chacha::ChaCha8Rng"* mpk_immut noalias nocapture readonly align 16 dereferenceable(320) %rhs) unnamed_addr #0 {
start:
  %b = alloca %"chacha::abstract8::ChaCha8Rng", align 8
  %a = alloca %"chacha::abstract8::ChaCha8Rng", align 8
  %0 = bitcast %"chacha::abstract8::ChaCha8Rng"* %a to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %0)
  call void @"_ZN125_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha8Rng$GT$$GT$4from17h7d35d0daa8dabf82E"(%"chacha::abstract8::ChaCha8Rng"* noalias nocapture nonnull sret dereferenceable(56) %a, %"chacha::ChaCha8Rng"* mpk_immut noalias nonnull readonly align 16 dereferenceable(320) %self)
  %1 = bitcast %"chacha::abstract8::ChaCha8Rng"* %b to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %1)
  call void @"_ZN125_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha8Rng$GT$$GT$4from17h7d35d0daa8dabf82E"(%"chacha::abstract8::ChaCha8Rng"* noalias nocapture nonnull sret dereferenceable(56) %b, %"chacha::ChaCha8Rng"* mpk_immut noalias nonnull readonly align 16 dereferenceable(320) %rhs)
  %__self_1_2.i = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %b, i64 0, i32 3
  %__self_0_2.i = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %a, i64 0, i32 3
  %2 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %b, i64 0, i32 5, i64 0
  %3 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %a, i64 0, i32 5, i64 0
  %bcmp.i.i.i.i = call i32 @bcmp(i8* nonnull dereferenceable(32) %3, i8* nonnull dereferenceable(32) %2, i64 32) #14
  %4 = icmp eq i32 %bcmp.i.i.i.i, 0
  br i1 %4, label %bb7.i, label %bb2.i

bb2.i:                                            ; preds = %bb7.i, %bb3.i, %start
  br label %"_ZN83_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0d8c2f5733c089e3E.exit"

bb3.i:                                            ; preds = %bb7.i
  %_17.i = load i128, i128* %__self_0_2.i, align 8, !alias.scope !154, !noalias !157
  %_18.i = load i128, i128* %__self_1_2.i, align 8, !alias.scope !157, !noalias !154
  %_16.i = icmp eq i128 %_17.i, %_18.i
  br i1 %_16.i, label %"_ZN83_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0d8c2f5733c089e3E.exit", label %bb2.i

bb7.i:                                            ; preds = %start
  %__self_0_1.i = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %a, i64 0, i32 0, i64 0
  %__self_1_1.i = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %b, i64 0, i32 0, i64 0
  %_14.i = load i64, i64* %__self_0_1.i, align 8, !alias.scope !154, !noalias !157
  %_15.i = load i64, i64* %__self_1_1.i, align 8, !alias.scope !157, !noalias !154
  %_13.i = icmp eq i64 %_14.i, %_15.i
  br i1 %_13.i, label %bb3.i, label %bb2.i

"_ZN83_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0d8c2f5733c089e3E.exit": ; preds = %bb3.i, %bb2.i
  %.0.i = phi i1 [ false, %bb2.i ], [ true, %bb3.i ]
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %1)
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %0)
  ret i1 %.0.i
}

; Function Attrs: nonlazybind uwtable
define void @"_ZN125_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..convert..From$LT$$RF$rand_chacha..chacha..ChaCha8Rng$GT$$GT$4from17h7d35d0daa8dabf82E"(%"chacha::abstract8::ChaCha8Rng"* noalias nocapture sret dereferenceable(56) %0, %"chacha::ChaCha8Rng"* mpk_immut noalias nocapture readonly align 16 dereferenceable(320) %r) unnamed_addr #0 {
start:
  %_2 = alloca [32 x i8], align 16
  %1 = getelementptr inbounds [32 x i8], [32 x i8]* %_2, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %1)
  %2 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5
  %_2.i = bitcast %"chacha::ChaCha8Core"* %2 to %"guts::ChaCha"*
  %3 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %4 = load atomic i64, i64* %3 monotonic, align 8, !noalias !159
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %bb1.i.i.i.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i

bb1.i.i.i.i.i.i.i:                                ; preds = %start
  %_2.i.i.i.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !159
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i: ; preds = %bb1.i.i.i.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i.i.i.i = phi i64 [ %_2.i.i.i.i.i.i.i.i, %bb1.i.i.i.i.i.i.i ], [ %4, %start ]
  %.0.i6.in.in.i.i.i.i.i.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i, label %bb2.i.i.i, label %bb3.i.i.i

bb2.i.i.i:                                        ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i
  %_5.sroa.0.0..sroa_cast.i.i.i.i.i = bitcast %"chacha::ChaCha8Core"* %2 to <2 x i64>*
  %_5.sroa.0.0.copyload.i.i.i.i.i = load <2 x i64>, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i.i.i.i, align 16, !alias.scope !169, !noalias !174
  %6 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 3
  %_8.sroa.0.0..sroa_cast.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %6 to <2 x i64>*
  %_8.sroa.0.0.copyload.i.i.i.i.i = load <2 x i64>, <2 x i64>* %_8.sroa.0.0..sroa_cast.i.i.i.i.i, align 16, !alias.scope !169, !noalias !174
  %_36.i12.i.i.i.i.i = bitcast [32 x i8]* %_2 to <2 x i64>*
  store <2 x i64> %_5.sroa.0.0.copyload.i.i.i.i.i, <2 x i64>* %_36.i12.i.i.i.i.i, align 16, !alias.scope !174, !noalias !177
  %7 = getelementptr inbounds [32 x i8], [32 x i8]* %_2, i64 0, i64 16
  %_36.i.i.i.i.i.i = bitcast i8* %7 to <2 x i64>*
  store <2 x i64> %_8.sroa.0.0.copyload.i.i.i.i.i, <2 x i64>* %_36.i.i.i.i.i.i, align 16, !alias.scope !174, !noalias !180
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E.exit

bb3.i.i.i:                                        ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i
  call fastcc void @_ZN11rand_chacha4guts8get_seed8impl_avx17hc884a559519a2b94E([32 x i8]* noalias nocapture nonnull dereferenceable(32) %_2, %"guts::ChaCha"* mpk_immut noalias nonnull readonly align 16 dereferenceable(48) %_2.i)
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E.exit

_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E.exit: ; preds = %bb3.i.i.i, %bb2.i.i.i
  %8 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %9 = load atomic i64, i64* %8 monotonic, align 8, !noalias !183
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %bb1.i.i.i.i.i.i.i3, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i7

bb1.i.i.i.i.i.i.i3:                               ; preds = %_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E.exit
  %_2.i.i.i.i.i.i.i.i2 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !183
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i7

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i7: ; preds = %bb1.i.i.i.i.i.i.i3, %_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E.exit
  %.0.i6.in.in.i.i.in.i.i.i.i4 = phi i64 [ %_2.i.i.i.i.i.i.i.i2, %bb1.i.i.i.i.i.i.i3 ], [ %9, %_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E.exit ]
  %.0.i6.in.in.i.i.i.i.i.i5 = and i64 %.0.i6.in.in.i.i.in.i.i.i.i4, 16384
  %.0.i6.in.i.i.i.not.i.i.i6 = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i5, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i6, label %bb2.i.i.i8, label %bb3.i.i.i9

bb2.i.i.i8:                                       ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i7
  %11 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %12 = bitcast %"ppv_lite86::vec128_storage"* %11 to <2 x i64>*
  %_6.sroa.0.0.copyload.i.i.i7.i.i19 = load <2 x i64>, <2 x i64>* %12, align 16, !alias.scope !190
  %13 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i.i.i7.i.i19, i32 1
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng10get_stream17h6d8fe0628e64dfd5E.exit

bb3.i.i.i9:                                       ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i7
  %14 = tail call fastcc i64 @_ZN11rand_chacha4guts16get_stream_param8impl_avx17h0b434e849102fe12E(%"guts::ChaCha"* mpk_immut noalias nonnull readonly align 16 dereferenceable(48) %_2.i, i32 1)
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng10get_stream17h6d8fe0628e64dfd5E.exit

_ZN11rand_chacha6chacha10ChaCha8Rng10get_stream17h6d8fe0628e64dfd5E.exit: ; preds = %bb3.i.i.i9, %bb2.i.i.i8
  %.0.i.i.i = phi i64 [ %14, %bb3.i.i.i9 ], [ %13, %bb2.i.i.i8 ]
  %15 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %16 = load atomic i64, i64* %15 monotonic, align 8, !noalias !195
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %bb1.i.i.i.i.i.i.i11, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15

bb1.i.i.i.i.i.i.i11:                              ; preds = %_ZN11rand_chacha6chacha10ChaCha8Rng10get_stream17h6d8fe0628e64dfd5E.exit
  %_2.i.i.i.i.i.i.i.i10 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !195
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15: ; preds = %bb1.i.i.i.i.i.i.i11, %_ZN11rand_chacha6chacha10ChaCha8Rng10get_stream17h6d8fe0628e64dfd5E.exit
  %.0.i6.in.in.i.i.in.i.i.i.i12 = phi i64 [ %_2.i.i.i.i.i.i.i.i10, %bb1.i.i.i.i.i.i.i11 ], [ %16, %_ZN11rand_chacha6chacha10ChaCha8Rng10get_stream17h6d8fe0628e64dfd5E.exit ]
  %.0.i6.in.in.i.i.i.i.i.i13 = and i64 %.0.i6.in.in.i.i.in.i.i.i.i12, 16384
  %.0.i6.in.i.i.i.not.i.i.i14 = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i13, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i14, label %bb2.i.i.i16, label %bb3.i.i.i17

bb2.i.i.i16:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15
  %18 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_6.sroa.0.0..sroa_cast.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %18 to <2 x i64>*
  %_6.sroa.0.0.copyload.i.i.i.i.i = load <2 x i64>, <2 x i64>* %_6.sroa.0.0..sroa_cast.i.i.i.i.i, align 16, !alias.scope !202
  %19 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i.i.i.i.i, i32 0
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit

bb3.i.i.i17:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15
  %20 = tail call fastcc i64 @_ZN11rand_chacha4guts16get_stream_param8impl_avx17h0b434e849102fe12E(%"guts::ChaCha"* mpk_immut noalias nonnull readonly align 16 dereferenceable(48) %_2.i, i32 0)
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit

_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit: ; preds = %bb3.i.i.i17, %bb2.i.i.i16
  %.0.i.i.i18 = phi i64 [ %20, %bb3.i.i.i17 ], [ %19, %bb2.i.i.i16 ]
  %21 = add i64 %.0.i.i.i18, -4
  %.idx.i = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 0, i64 0
  %.idx.val.i = load i64, i64* %.idx.i, align 16, !alias.scope !207
  %blocks_part.i = lshr i64 %.idx.val.i, 4
  %words_part.i = and i64 %.idx.val.i, 15
  %22 = add i64 %21, %blocks_part.i
  %23 = zext i64 %22 to i128
  %pos_block_words.i = shl nuw nsw i128 %23, 4
  %24 = zext i64 %words_part.i to i128
  %25 = or i128 %pos_block_words.i, %24
  %26 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %0, i64 0, i32 5, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(32) %26, i8* nonnull align 16 dereferenceable(32) %1, i64 32, i1 false)
  %27 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %0, i64 0, i32 0, i64 0
  store i64 %.0.i.i.i, i64* %27, align 8
  %28 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %0, i64 0, i32 3
  store i128 %25, i128* %28, align 8
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %1)
  ret void
}

; Function Attrs: nonlazybind uwtable
define void @"_ZN11rand_chacha6chacha9abstract8135_$LT$impl$u20$core..convert..From$LT$$RF$rand_chacha..chacha..abstract8..ChaCha8Rng$GT$$u20$for$u20$rand_chacha..chacha..ChaCha8Rng$GT$4from17hd4da3bfb155db083E"(%"chacha::ChaCha8Rng"* noalias nocapture sret dereferenceable(320) %r, %"chacha::abstract8::ChaCha8Rng"* mpk_immut noalias nocapture readonly align 8 dereferenceable(56) %a) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_2.i.i = alloca %"guts::ChaCha", align 16
  %_4.sroa.5.i = alloca { [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }, align 8
  %_3.i = alloca [32 x i8], align 8
  %core.sroa.0.i = alloca %"guts::ChaCha", align 16
  %0 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %a, i64 0, i32 5, i64 0
  %core.sroa.0.0.sroa_cast.i = bitcast %"guts::ChaCha"* %core.sroa.0.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %core.sroa.0.0.sroa_cast.i)
  %1 = getelementptr inbounds [32 x i8], [32 x i8]* %_3.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %1), !noalias !208
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(32) %1, i8* nonnull align 8 dereferenceable(32) %0, i64 32, i1 false)
  %2 = bitcast %"guts::ChaCha"* %_2.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %2), !noalias !212
  %3 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %4 = load atomic i64, i64* %3 monotonic, align 8, !noalias !216
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %bb1.i.i.i.i.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i

bb1.i.i.i.i.i.i.i.i:                              ; preds = %start
  %_2.i.i.i.i.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !216
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i: ; preds = %bb1.i.i.i.i.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i.i.i.i.i = phi i64 [ %_2.i.i.i.i.i.i.i.i.i, %bb1.i.i.i.i.i.i.i.i ], [ %4, %start ]
  %.0.i6.in.in.i.i.i.i.i.i.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i.i, label %bb2.i.i.i.i, label %bb3.i.i.i.i

bb2.i.i.i.i:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i
  %6 = bitcast [32 x i8]* %_3.i to i128*
  %.0.copyload.i.i53102.i.i.i.i.i.i = load i128, i128* %6, align 8, !alias.scope !224, !noalias !233
  %7 = getelementptr inbounds [32 x i8], [32 x i8]* %_3.i, i64 0, i64 16
  %8 = bitcast i8* %7 to i128*
  %.0.copyload.i.i103.i.i.i.i.i.i = load i128, i128* %8, align 8, !alias.scope !240, !noalias !245
  %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i.i.i.i.i.i = bitcast %"guts::ChaCha"* %_2.i.i to i128*
  store i128 %.0.copyload.i.i53102.i.i.i.i.i.i, i128* %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !248, !noalias !249
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i.i.i.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %_2.i.i, i64 0, i32 3
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i.i.i.i.i.i to i128*
  store i128 %.0.copyload.i.i103.i.i.i.i.i.i, i128* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !248, !noalias !249
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i.i.i.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %_2.i.i, i64 0, i32 5
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i.i.i.i.i.i to i128*
  store i128 0, i128* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !248, !noalias !249
  br label %"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E.exit"

bb3.i.i.i.i:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i
  call fastcc void @_ZN11rand_chacha4guts11init_chacha8impl_avx17h3e4f4620b5fbdc3cE(%"guts::ChaCha"* noalias nocapture nonnull dereferenceable(48) %_2.i.i, [32 x i8]* mpk_immut noalias nonnull readonly align 1 dereferenceable(32) %_3.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc107 to [0 x i8]*), i64 8), !noalias !250
  br label %"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E.exit"

"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E.exit": ; preds = %bb3.i.i.i.i, %bb2.i.i.i.i
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(48) %core.sroa.0.0.sroa_cast.i, i8* nonnull align 16 dereferenceable(48) %2, i64 48, i1 false), !noalias !251
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %2), !noalias !212
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %1), !noalias !208
  %_4.sroa.5.0.sroa_cast.i = bitcast { [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }* %_4.sroa.5.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %_4.sroa.5.0.sroa_cast.i)
  %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_idx.i = getelementptr inbounds { [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }, { [2 x i32], %"chacha::ChaCha8Core", [0 x i64] }* %_4.sroa.5.i, i64 0, i32 1
  %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_cast.i = bitcast %"chacha::ChaCha8Core"* %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_idx.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(48) %_5.sroa.0.0._4.sroa.5.272.sroa_cast.sroa_cast.i, i8* nonnull align 16 dereferenceable(48) %core.sroa.0.0.sroa_cast.i, i64 48, i1 false), !noalias !208
  %_4.sroa.0.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 0, i64 0
  store i64 64, i64* %_4.sroa.0.0..sroa_idx.i, align 16, !alias.scope !252, !noalias !253
  %_4.sroa.4.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 3
  %_4.sroa.4.0..sroa_cast.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to i8*
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(256) %_4.sroa.4.0..sroa_cast.i, i8 0, i64 256, i1 false), !alias.scope !252, !noalias !253
  %_4.sroa.5.0..sroa_idx.i = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 4
  %_4.sroa.5.0..sroa_cast.i = bitcast [2 x i32]* %_4.sroa.5.0..sroa_idx.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(56) %_4.sroa.5.0..sroa_cast.i, i8* nonnull align 8 dereferenceable(56) %_4.sroa.5.0.sroa_cast.i, i64 56, i1 false), !noalias !253
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %_4.sroa.5.0.sroa_cast.i)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %core.sroa.0.0.sroa_cast.i)
  %9 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %a, i64 0, i32 0, i64 0
  %_5 = load i64, i64* %9, align 8
  %10 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5
  %_4.i = bitcast %"chacha::ChaCha8Core"* %10 to %"guts::ChaCha"*
  %11 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %12 = load atomic i64, i64* %11 monotonic, align 8
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %bb1.i.i.i.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i

bb1.i.i.i.i.i.i.i:                                ; preds = %"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E.exit"
  %_2.i.i.i.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i: ; preds = %bb1.i.i.i.i.i.i.i, %"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E.exit"
  %.0.i6.in.in.i.i.in.i.i.i.i = phi i64 [ %_2.i.i.i.i.i.i.i.i, %bb1.i.i.i.i.i.i.i ], [ %12, %"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E.exit" ]
  %.0.i6.in.in.i.i.i.i.i.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i, label %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread, label %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i

_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread: ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i
  %14 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %15 = bitcast %"ppv_lite86::vec128_storage"* %14 to <16 x i8>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i = load <16 x i8>, <16 x i8>* %15, align 16
  %_13.i.i.i.i.i = lshr i64 %_5, 32
  %_12.i.i.i.i.i = trunc i64 %_13.i.i.i.i.i to i32
  %16 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %_7.sroa.0.0.copyload.i.i.i1.i.i, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 undef, i32 undef, i32 undef, i32 undef>
  %.12.vec.insert.i.i18.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 undef>, i32 %_12.i.i.i.i.i, i32 0
  %17 = bitcast <16 x i8> %16 to <4 x i32>
  %18 = or <4 x i32> %.12.vec.insert.i.i18.i.i.i.i.i, %17
  %19 = shufflevector <4 x i32> %18, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 undef, i32 0>
  %_18.i.i.i.i.i = trunc i64 %_5 to i32
  %20 = shufflevector <4 x i32> %19, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 3, i32 undef>
  %21 = bitcast <4 x i32> %20 to <16 x i8>
  %22 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %21, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i7.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i, i32 0
  %23 = bitcast <16 x i8> %22 to <4 x i32>
  %24 = or <4 x i32> %.12.vec.insert.i7.i.i.i.i.i.i, %23
  %25 = shufflevector <4 x i32> %24, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 0, i32 3>
  %26 = bitcast %"ppv_lite86::vec128_storage"* %14 to <4 x i32>*
  store <4 x i32> %25, <4 x i32>* %26, align 16
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng10set_stream17h7d5ebdc4570e64f5E.exit

_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i: ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 1, i64 %_5)
  %.idx.val.i.pre = load i64, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  %27 = icmp eq i64 %.idx.val.i.pre, 64
  br i1 %27, label %_ZN11rand_chacha6chacha10ChaCha8Rng10set_stream17h7d5ebdc4570e64f5E.exit, label %bb4.i

bb4.i:                                            ; preds = %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i
  %28 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %29 = load atomic i64, i64* %28 monotonic, align 8, !noalias !254
  %30 = icmp eq i64 %29, 0
  br i1 %30, label %bb1.i.i.i.i.i.i.i.i2, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6

bb1.i.i.i.i.i.i.i.i2:                             ; preds = %bb4.i
  %_2.i.i.i.i.i.i.i.i.i1 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE(), !noalias !254
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6: ; preds = %bb1.i.i.i.i.i.i.i.i2, %bb4.i
  %.0.i6.in.in.i.i.in.i.i.i.i.i3 = phi i64 [ %_2.i.i.i.i.i.i.i.i.i1, %bb1.i.i.i.i.i.i.i.i2 ], [ %29, %bb4.i ]
  %.0.i6.in.in.i.i.i.i.i.i.i4 = and i64 %.0.i6.in.in.i.i.in.i.i.i.i.i3, 16384
  %.0.i6.in.i.i.i.not.i.i.i.i5 = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i.i4, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i.i5, label %bb2.i.i.i.i7, label %bb3.i.i.i.i8

bb2.i.i.i.i7:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6
  %31 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_6.sroa.0.0..sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %31 to <2 x i64>*
  %_6.sroa.0.0.copyload.i.i.i.i.i.i = load <2 x i64>, <2 x i64>* %_6.sroa.0.0..sroa_cast.i.i.i.i.i.i, align 16, !alias.scope !261
  %32 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i.i.i.i.i.i, i32 0
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit.i

bb3.i.i.i.i8:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i.i6
  %33 = tail call fastcc i64 @_ZN11rand_chacha4guts16get_stream_param8impl_avx17h0b434e849102fe12E(%"guts::ChaCha"* mpk_immut noalias nonnull readonly align 16 dereferenceable(48) %_4.i, i32 0)
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit.i

_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit.i: ; preds = %bb3.i.i.i.i8, %bb2.i.i.i.i7
  %.0.i.i.i.i = phi i64 [ %33, %bb3.i.i.i.i8 ], [ %32, %bb2.i.i.i.i7 ]
  %blocks_part.i.i = lshr i64 %.idx.val.i.pre, 4
  %words_part.i.i = and i64 %.idx.val.i.pre, 15
  %34 = add nsw i64 %blocks_part.i.i, -4
  %35 = add i64 %34, %.0.i.i.i.i
  %36 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %37 = load atomic i64, i64* %36 monotonic, align 8
  %38 = icmp eq i64 %37, 0
  br i1 %38, label %bb1.i.i.i.i.i.i.i2.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i

bb1.i.i.i.i.i.i.i2.i:                             ; preds = %_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit.i
  %_2.i.i.i.i.i.i.i.i1.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i: ; preds = %bb1.i.i.i.i.i.i.i2.i, %_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit.i
  %.0.i6.in.in.i.i.in.i.i.i.i3.i = phi i64 [ %_2.i.i.i.i.i.i.i.i1.i, %bb1.i.i.i.i.i.i.i2.i ], [ %37, %_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE.exit.i ]
  %.0.i6.in.in.i.i.i.i.i.i4.i = and i64 %.0.i6.in.in.i.i.in.i.i.i.i3.i, 16384
  %.0.i6.in.i.i.i.not.i.i.i5.i = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i4.i, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i5.i, label %bb2.i.i.i7.i, label %bb3.i.i.i8.i

bb2.i.i.i7.i:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i
  %39 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_7.sroa.0.0..sroa_cast.i.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %39 to <2 x i64>*
  %40 = bitcast %"ppv_lite86::vec128_storage"* %39 to <4 x i32>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i.i = load <4 x i32>, <4 x i32>* %40, align 16
  %_13.i.i.i.i2.i.i = lshr i64 %35, 32
  %41 = trunc i64 %_13.i.i.i.i2.i.i to i32
  %42 = shufflevector <4 x i32> %_7.sroa.0.0.copyload.i.i.i1.i.i.i, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 3, i32 undef>
  %43 = bitcast <4 x i32> %42 to <16 x i8>
  %44 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %43, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i14.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %41, i32 0
  %45 = bitcast <16 x i8> %44 to <4 x i32>
  %46 = or <4 x i32> %.12.vec.insert.i13.i14.i.i.i.i.i.i, %45
  %47 = shufflevector <4 x i32> %46, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %_18.i.i.i.i.i.i = trunc i64 %35 to i32
  %_4.0.i20.i.i.i.i.i.i = bitcast <4 x i32> %47 to <2 x i64>
  %48 = and <2 x i64> %_4.0.i20.i.i.i.i.i.i, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i.i, i32 0
  %49 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i.i.i.i.i to <2 x i64>
  %50 = or <2 x i64> %48, %49
  store <2 x i64> %50, <2 x i64>* %_7.sroa.0.0..sroa_cast.i.i.i.i.i.i, align 16
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng12set_word_pos17h6b98073b5d7d047aE.exit.i

bb3.i.i.i8.i:                                     ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i6.i
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 0, i64 %35)
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng12set_word_pos17h6b98073b5d7d047aE.exit.i

_ZN11rand_chacha6chacha10ChaCha8Rng12set_word_pos17h6b98073b5d7d047aE.exit.i: ; preds = %bb3.i.i.i8.i, %bb2.i.i.i7.i
  %_8.i.i.i.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to [256 x i8]*
  tail call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 4, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i.i.i.i)
  store i64 %words_part.i.i, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng10set_stream17h7d5ebdc4570e64f5E.exit

_ZN11rand_chacha6chacha10ChaCha8Rng10set_stream17h7d5ebdc4570e64f5E.exit: ; preds = %_ZN11rand_chacha6chacha10ChaCha8Rng12set_word_pos17h6b98073b5d7d047aE.exit.i, %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i, %_ZN11rand_chacha4guts6ChaCha9set_nonce17hfa0c75860cec0ff4E.exit.i.thread
  %51 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %a, i64 0, i32 3
  %_8 = load i128, i128* %51, align 8
  %_4.i9 = lshr i128 %_8, 4
  %block.i = trunc i128 %_4.i9 to i64
  %52 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %53 = load atomic i64, i64* %52 monotonic, align 8
  %54 = icmp eq i64 %53, 0
  br i1 %54, label %bb1.i.i.i.i.i.i.i11, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15

bb1.i.i.i.i.i.i.i11:                              ; preds = %_ZN11rand_chacha6chacha10ChaCha8Rng10set_stream17h7d5ebdc4570e64f5E.exit
  %_2.i.i.i.i.i.i.i.i10 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15: ; preds = %bb1.i.i.i.i.i.i.i11, %_ZN11rand_chacha6chacha10ChaCha8Rng10set_stream17h7d5ebdc4570e64f5E.exit
  %.0.i6.in.in.i.i.in.i.i.i.i12 = phi i64 [ %_2.i.i.i.i.i.i.i.i10, %bb1.i.i.i.i.i.i.i11 ], [ %53, %_ZN11rand_chacha6chacha10ChaCha8Rng10set_stream17h7d5ebdc4570e64f5E.exit ]
  %.0.i6.in.in.i.i.i.i.i.i13 = and i64 %.0.i6.in.in.i.i.in.i.i.i.i12, 16384
  %.0.i6.in.i.i.i.not.i.i.i14 = icmp eq i64 %.0.i6.in.in.i.i.i.i.i.i13, 0
  br i1 %.0.i6.in.i.i.i.not.i.i.i14, label %bb2.i.i.i18, label %bb3.i.i.i19

bb2.i.i.i18:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15
  %55 = getelementptr inbounds %"chacha::ChaCha8Rng", %"chacha::ChaCha8Rng"* %r, i64 0, i32 1, i32 5, i32 1, i32 5
  %_7.sroa.0.0..sroa_cast.i.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %55 to <2 x i64>*
  %56 = bitcast %"ppv_lite86::vec128_storage"* %55 to <4 x i32>*
  %_7.sroa.0.0.copyload.i.i.i1.i.i16 = load <4 x i32>, <4 x i32>* %56, align 16
  %_13.i.i.i.i2.i = lshr i128 %_8, 36
  %57 = trunc i128 %_13.i.i.i.i2.i to i32
  %58 = shufflevector <4 x i32> %_7.sroa.0.0.copyload.i.i.i1.i.i16, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 3, i32 undef>
  %59 = bitcast <4 x i32> %58 to <16 x i8>
  %60 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %59, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i14.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %57, i32 0
  %61 = bitcast <16 x i8> %60 to <4 x i32>
  %62 = or <4 x i32> %.12.vec.insert.i13.i14.i.i.i.i.i, %61
  %63 = shufflevector <4 x i32> %62, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %_18.i.i.i.i.i17 = trunc i128 %_4.i9 to i32
  %_4.0.i20.i.i.i.i.i = bitcast <4 x i32> %63 to <2 x i64>
  %64 = and <2 x i64> %_4.0.i20.i.i.i.i.i, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i.i.i.i17, i32 0
  %65 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i.i.i.i to <2 x i64>
  %66 = or <2 x i64> %64, %65
  store <2 x i64> %66, <2 x i64>* %_7.sroa.0.0..sroa_cast.i.i.i.i.i, align 16
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng12set_word_pos17h6b98073b5d7d047aE.exit

bb3.i.i.i19:                                      ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit.i.i.i15
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 0, i64 %block.i)
  br label %_ZN11rand_chacha6chacha10ChaCha8Rng12set_word_pos17h6b98073b5d7d047aE.exit

_ZN11rand_chacha6chacha10ChaCha8Rng12set_word_pos17h6b98073b5d7d047aE.exit: ; preds = %bb3.i.i.i19, %bb2.i.i.i18
  %67 = trunc i128 %_8 to i64
  %_13.i = and i64 %67, 15
  %_8.i.i.i = bitcast %"chacha::Array64<u32>"* %_4.sroa.4.0..sroa_idx.i to [256 x i8]*
  tail call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 4, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i.i.i)
  store i64 %_13.i, i64* %_4.sroa.0.0..sroa_idx.i, align 16
  ret void
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN68_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$core..fmt..Debug$GT$3fmt17h4c409c977e1f6dd7E"(%"chacha::ChaCha8Rng"* mpk_immut noalias readonly align 16 dereferenceable(320) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_15 = alloca %"rand_core::block::BlockRng<chacha::ChaCha8Core>"*, align 8
  %debug_trait_builder = alloca %"std::fmt::DebugStruct", align 8
  %0 = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc3621 to [0 x i8]*), i64 10)
  %.0..sroa_cast = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha8Core>"** %_15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha8Core>"** %_15 to %"chacha::ChaCha8Rng"**
  store %"chacha::ChaCha8Rng"* %self, %"chacha::ChaCha8Rng"** %3, align 8
  %_12.0 = bitcast %"rand_core::block::BlockRng<chacha::ChaCha8Core>"** %_15 to {}*
  %_8 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc3620 to [0 x i8]*), i64 3, {}* mpk_immut nonnull align 1 %_12.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"rand_core::block::BlockRng<chacha::ChaCha8Core>"**)*, i64, i64, i1 (%"rand_core::block::BlockRng<chacha::ChaCha8Core>"**, %"std::fmt::Formatter"*)* }* @vtable.e to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %4 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %4
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN79_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..fmt..Debug$GT$3fmt17ha12d478365af200dE"(%"chacha::abstract8::ChaCha8Rng"* mpk_immut noalias readonly align 8 dereferenceable(56) %self, %"std::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_33 = alloca i128*, align 8
  %_25 = alloca i64*, align 8
  %_17 = alloca [32 x i8]*, align 8
  %debug_trait_builder = alloca %"std::fmt::DebugStruct", align 8
  %__self_0_0 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %self, i64 0, i32 5
  %__self_0_1 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %self, i64 0, i32 0, i64 0
  %__self_0_2 = getelementptr inbounds %"chacha::abstract8::ChaCha8Rng", %"chacha::abstract8::ChaCha8Rng"* %self, i64 0, i32 3
  %0 = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc3621 to [0 x i8]*), i64 10)
  %.0..sroa_cast = bitcast %"std::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast [32 x i8]** %_17 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  store [32 x i8]* %__self_0_0, [32 x i8]** %_17, align 8
  %_14.0 = bitcast [32 x i8]** %_17 to {}*
  %_10 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc3622 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_14.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ([32 x i8]**)*, i64, i64, i1 ([32 x i8]**, %"std::fmt::Formatter"*)* }* @vtable.a to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast i64** %_25 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  store i64* %__self_0_1, i64** %_25, align 8
  %_22.0 = bitcast i64** %_25 to {}*
  %_18 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc3623 to [0 x i8]*), i64 6, {}* mpk_immut nonnull align 1 %_22.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"std::fmt::Formatter"*)* }* @vtable.b to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  %4 = bitcast i128** %_33 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4)
  store i128* %__self_0_2, i128** %_33, align 8
  %_30.0 = bitcast i128** %_33 to {}*
  %_26 = call align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc3624 to [0 x i8]*), i64 8, {}* mpk_immut nonnull align 1 %_30.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i128**)*, i64, i64, i1 (i128**, %"std::fmt::Formatter"*)* }* @vtable.c to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4)
  %5 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %5
}

; Function Attrs: nonlazybind uwtable
define void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"guts::ChaCha"* nocapture align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nocapture align 1 dereferenceable(256) %out) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %0 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %1 = load atomic i64, i64* %0 monotonic, align 8
  %2 = icmp eq i64 %1, 0
  br i1 %2, label %bb1.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected4avx217hb48ae83d25c7993aE.exit

bb1.i.i.i.i:                                      ; preds = %start
  %_2.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected4avx217hb48ae83d25c7993aE.exit

_ZN3std10std_detect6detect4arch21__is_feature_detected4avx217hb48ae83d25c7993aE.exit: ; preds = %bb1.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i = phi i64 [ %_2.i.i.i.i.i, %bb1.i.i.i.i ], [ %1, %start ]
  %3 = trunc i64 %.0.i6.in.in.i.i.in.i to i16
  %.0.i6.in.i.i.i = icmp slt i16 %3, 0
  br i1 %.0.i6.in.i.i.i, label %bb3, label %bb2

bb2:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected4avx217hb48ae83d25c7993aE.exit
  %4 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %5 = load atomic i64, i64* %4 monotonic, align 8
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %bb1.i.i.i.i2, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

bb1.i.i.i.i2:                                     ; preds = %bb2
  %_2.i.i.i.i.i1 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit: ; preds = %bb1.i.i.i.i2, %bb2
  %.0.i6.in.in.i.i.in.i3 = phi i64 [ %_2.i.i.i.i.i1, %bb1.i.i.i.i2 ], [ %5, %bb2 ]
  %.0.i6.in.in.i.i.i = and i64 %.0.i6.in.in.i.i.in.i3, 16384
  %.0.i6.in.i.i.i4.not = icmp eq i64 %.0.i6.in.in.i.i.i, 0
  br i1 %.0.i6.in.i.i.i4.not, label %bb6, label %bb7

bb3:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected4avx217hb48ae83d25c7993aE.exit
  tail call fastcc void @_ZN11rand_chacha4guts11refill_wide9impl_avx217he92eaa75c54690e4E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nonnull align 1 dereferenceable(256) %out)
  br label %bb24

bb6:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  %7 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %8 = load atomic i64, i64* %7 monotonic, align 8
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %bb1.i.i.i.i6, label %_ZN3std10std_detect6detect4arch21__is_feature_detected6sse4_117h9e6406a22742a46bE.exit

bb1.i.i.i.i6:                                     ; preds = %bb6
  %_2.i.i.i.i.i5 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected6sse4_117h9e6406a22742a46bE.exit

_ZN3std10std_detect6detect4arch21__is_feature_detected6sse4_117h9e6406a22742a46bE.exit: ; preds = %bb1.i.i.i.i6, %bb6
  %.0.i6.in.in.i.i.in.i7 = phi i64 [ %_2.i.i.i.i.i5, %bb1.i.i.i.i6 ], [ %8, %bb6 ]
  %.0.i6.in.in.i.i.i8 = and i64 %.0.i6.in.in.i.i.in.i7, 1024
  %.0.i6.in.i.i.i9.not = icmp eq i64 %.0.i6.in.in.i.i.i8, 0
  br i1 %.0.i6.in.i.i.i9.not, label %bb10, label %bb11

bb7:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  tail call fastcc void @_ZN11rand_chacha4guts11refill_wide8impl_avx17headc73f5fe348c9bE(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nonnull align 1 dereferenceable(256) %out)
  br label %bb24

bb10:                                             ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected6sse4_117h9e6406a22742a46bE.exit
  %10 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %11 = load atomic i64, i64* %10 monotonic, align 8
  %12 = icmp eq i64 %11, 0
  br i1 %12, label %bb1.i.i.i.i11, label %_ZN3std10std_detect6detect4arch21__is_feature_detected5ssse317h502267245b48fc30E.exit

bb1.i.i.i.i11:                                    ; preds = %bb10
  %_2.i.i.i.i.i10 = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected5ssse317h502267245b48fc30E.exit

_ZN3std10std_detect6detect4arch21__is_feature_detected5ssse317h502267245b48fc30E.exit: ; preds = %bb1.i.i.i.i11, %bb10
  %.0.i6.in.in.i.i.in.i12 = phi i64 [ %_2.i.i.i.i.i10, %bb1.i.i.i.i11 ], [ %11, %bb10 ]
  %.0.i6.in.in.i.i.i13 = and i64 %.0.i6.in.in.i.i.in.i12, 512
  %.0.i6.in.i.i.i14.not = icmp eq i64 %.0.i6.in.in.i.i.i13, 0
  br i1 %.0.i6.in.i.i.i14.not, label %bb14, label %bb15

bb11:                                             ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected6sse4_117h9e6406a22742a46bE.exit
  tail call fastcc void @_ZN11rand_chacha4guts11refill_wide10impl_sse4117hfa5f15f9763c224aE(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nonnull align 1 dereferenceable(256) %out)
  br label %bb24

bb14:                                             ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected5ssse317h502267245b48fc30E.exit
  %_5.sroa.0.0..sroa_idx.i.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_5.sroa.0.0..sroa_cast.i.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i.i to <2 x i64>*
  %_5.sroa.0.0.copyload.i.i.i.i = load <2 x i64>, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i.i.i, align 16, !alias.scope !266
  %13 = extractelement <2 x i64> %_5.sroa.0.0.copyload.i.i.i.i, i32 0
  %14 = add i64 %13, 1
  %_20.i.i.i = lshr i64 %14, 32
  %_19.i.i.i = trunc i64 %_20.i.i.i to i32
  %15 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i.i to <4 x i32>
  %16 = shufflevector <4 x i32> %15, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 3, i32 undef>
  %17 = bitcast <4 x i32> %16 to <16 x i8>
  %18 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %17, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_19.i.i.i, i32 0
  %19 = bitcast <16 x i8> %18 to <4 x i32>
  %20 = or <4 x i32> %.12.vec.insert.i13.i.i.i.i, %19
  %21 = shufflevector <4 x i32> %20, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %22 = bitcast <4 x i32> %21 to <2 x i64>
  %_22.i.i.i = trunc i64 %14 to i32
  %23 = and <2 x i64> %22, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_22.i.i.i, i32 0
  %24 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i.i to <2 x i64>
  %25 = or <2 x i64> %23, %24
  %26 = add i64 %13, 2
  %_30.i.i.i = lshr i64 %26, 32
  %_29.i.i.i = trunc i64 %_30.i.i.i to i32
  %.12.vec.insert.i13.i166.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_29.i.i.i, i32 0
  %27 = or <4 x i32> %.12.vec.insert.i13.i166.i.i.i, %19
  %28 = shufflevector <4 x i32> %27, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %29 = bitcast <4 x i32> %28 to <2 x i64>
  %_32.i.i.i = trunc i64 %26 to i32
  %30 = and <2 x i64> %29, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i170.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_32.i.i.i, i32 0
  %31 = bitcast <4 x i32> %.12.vec.insert.i18.i170.i.i.i to <2 x i64>
  %32 = or <2 x i64> %30, %31
  %33 = add i64 %13, 3
  %_40.i.i.i = lshr i64 %33, 32
  %_39.i.i.i = trunc i64 %_40.i.i.i to i32
  %.12.vec.insert.i13.i328.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_39.i.i.i, i32 0
  %34 = or <4 x i32> %.12.vec.insert.i13.i328.i.i.i, %19
  %35 = shufflevector <4 x i32> %34, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %36 = bitcast <4 x i32> %35 to <2 x i64>
  %_42.i.i.i = trunc i64 %33 to i32
  %37 = and <2 x i64> %36, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i327.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_42.i.i.i, i32 0
  %38 = bitcast <4 x i32> %.12.vec.insert.i18.i327.i.i.i to <2 x i64>
  %39 = or <2 x i64> %37, %38
  %_46.sroa.0.0..sroa_cast.i.i.i = bitcast %"guts::ChaCha"* %state to <2 x i64>*
  %_46.sroa.0.0.copyload.i.i.i = load <2 x i64>, <2 x i64>* %_46.sroa.0.0..sroa_cast.i.i.i, align 16
  %_49.sroa.0.0..sroa_idx.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 3
  %_49.sroa.0.0..sroa_cast.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i.i to <2 x i64>*
  %_49.sroa.0.0.copyload.i.i.i = load <2 x i64>, <2 x i64>* %_49.sroa.0.0..sroa_cast.i.i.i, align 16
  %.not.i.i.i = icmp eq i32 %drounds, 0
  br i1 %.not.i.i.i, label %_ZN11rand_chacha4guts11refill_wide9impl_sse217hb0574db456a45ab5E.exit, label %bb26.i.i.i

bb26.i.i.i:                                       ; preds = %bb26.i.i.i, %bb14
  %iter.sroa.0.01370.i.i.i = phi i32 [ %44, %bb26.i.i.i ], [ 0, %bb14 ]
  %40 = phi <4 x i32> [ %197, %bb26.i.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %bb14 ]
  %41 = phi <4 x i32> [ %198, %bb26.i.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %bb14 ]
  %42 = phi <4 x i32> [ %199, %bb26.i.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %bb14 ]
  %43 = phi <4 x i32> [ %200, %bb26.i.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %bb14 ]
  %x.sroa.15.sroa.10.01369.i.i.i = phi <2 x i64> [ %260, %bb26.i.i.i ], [ %39, %bb14 ]
  %x.sroa.15.sroa.9.01368.i.i.i = phi <2 x i64> [ %259, %bb26.i.i.i ], [ %32, %bb14 ]
  %x.sroa.15.sroa.8.01367.i.i.i = phi <2 x i64> [ %258, %bb26.i.i.i ], [ %25, %bb14 ]
  %x.sroa.15.sroa.0.01366.i.i.i = phi <2 x i64> [ %257, %bb26.i.i.i ], [ %_5.sroa.0.0.copyload.i.i.i.i, %bb14 ]
  %x.sroa.13.sroa.10.01365.i.i.i = phi <2 x i64> [ %252, %bb26.i.i.i ], [ %_49.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.13.sroa.9.01364.i.i.i = phi <2 x i64> [ %251, %bb26.i.i.i ], [ %_49.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.13.sroa.8.01363.i.i.i = phi <2 x i64> [ %250, %bb26.i.i.i ], [ %_49.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.11.sroa.0.01362.i.i.i = phi <2 x i64> [ %241, %bb26.i.i.i ], [ %_46.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.11.sroa.8.01361.i.i.i = phi <2 x i64> [ %242, %bb26.i.i.i ], [ %_46.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.11.sroa.9.01360.i.i.i = phi <2 x i64> [ %243, %bb26.i.i.i ], [ %_46.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.11.sroa.10.01359.i.i.i = phi <2 x i64> [ %244, %bb26.i.i.i ], [ %_46.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.13.sroa.0.01358.i.i.i = phi <2 x i64> [ %249, %bb26.i.i.i ], [ %_49.sroa.0.0.copyload.i.i.i, %bb14 ]
  %44 = add nuw i32 %iter.sroa.0.01370.i.i.i, 1
  %45 = bitcast <2 x i64> %x.sroa.11.sroa.0.01362.i.i.i to <4 x i32>
  %46 = bitcast <2 x i64> %x.sroa.11.sroa.8.01361.i.i.i to <4 x i32>
  %47 = bitcast <2 x i64> %x.sroa.11.sroa.9.01360.i.i.i to <4 x i32>
  %48 = bitcast <2 x i64> %x.sroa.11.sroa.10.01359.i.i.i to <4 x i32>
  %49 = add <4 x i32> %40, %45
  %50 = add <4 x i32> %41, %46
  %51 = add <4 x i32> %42, %47
  %52 = add <4 x i32> %43, %48
  %53 = bitcast <4 x i32> %49 to <2 x i64>
  %54 = bitcast <4 x i32> %50 to <2 x i64>
  %55 = bitcast <4 x i32> %51 to <2 x i64>
  %56 = bitcast <4 x i32> %52 to <2 x i64>
  %57 = xor <2 x i64> %x.sroa.15.sroa.0.01366.i.i.i, %53
  %58 = xor <2 x i64> %x.sroa.15.sroa.8.01367.i.i.i, %54
  %59 = xor <2 x i64> %x.sroa.15.sroa.9.01368.i.i.i, %55
  %60 = xor <2 x i64> %x.sroa.15.sroa.10.01369.i.i.i, %56
  %61 = bitcast <2 x i64> %57 to <8 x i16>
  %62 = shufflevector <8 x i16> %61, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 4, i32 5, i32 6, i32 7>
  %63 = shufflevector <8 x i16> %62, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 4, i32 7, i32 6>
  %64 = bitcast <2 x i64> %58 to <8 x i16>
  %65 = shufflevector <8 x i16> %64, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 4, i32 5, i32 6, i32 7>
  %66 = shufflevector <8 x i16> %65, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 4, i32 7, i32 6>
  %67 = bitcast <2 x i64> %59 to <8 x i16>
  %68 = shufflevector <8 x i16> %67, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 4, i32 5, i32 6, i32 7>
  %69 = shufflevector <8 x i16> %68, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 4, i32 7, i32 6>
  %70 = bitcast <2 x i64> %60 to <8 x i16>
  %71 = shufflevector <8 x i16> %70, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 4, i32 5, i32 6, i32 7>
  %72 = shufflevector <8 x i16> %71, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 4, i32 7, i32 6>
  %73 = bitcast <8 x i16> %63 to <4 x i32>
  %74 = bitcast <8 x i16> %66 to <4 x i32>
  %75 = bitcast <8 x i16> %69 to <4 x i32>
  %76 = bitcast <8 x i16> %72 to <4 x i32>
  %77 = bitcast <2 x i64> %x.sroa.13.sroa.0.01358.i.i.i to <4 x i32>
  %78 = add <4 x i32> %73, %77
  %79 = bitcast <2 x i64> %x.sroa.13.sroa.8.01363.i.i.i to <4 x i32>
  %80 = add <4 x i32> %74, %79
  %81 = bitcast <2 x i64> %x.sroa.13.sroa.9.01364.i.i.i to <4 x i32>
  %82 = add <4 x i32> %75, %81
  %83 = bitcast <2 x i64> %x.sroa.13.sroa.10.01365.i.i.i to <4 x i32>
  %84 = add <4 x i32> %76, %83
  %85 = xor <4 x i32> %84, %48
  %86 = xor <4 x i32> %78, %45
  %87 = lshr <4 x i32> %86, <i32 20, i32 20, i32 20, i32 20>
  %88 = shl <4 x i32> %86, <i32 12, i32 12, i32 12, i32 12>
  %89 = or <4 x i32> %88, %87
  %90 = xor <4 x i32> %80, %46
  %91 = lshr <4 x i32> %90, <i32 20, i32 20, i32 20, i32 20>
  %92 = shl <4 x i32> %90, <i32 12, i32 12, i32 12, i32 12>
  %93 = or <4 x i32> %92, %91
  %94 = xor <4 x i32> %82, %47
  %95 = lshr <4 x i32> %94, <i32 20, i32 20, i32 20, i32 20>
  %96 = shl <4 x i32> %94, <i32 12, i32 12, i32 12, i32 12>
  %97 = or <4 x i32> %96, %95
  %98 = lshr <4 x i32> %85, <i32 20, i32 20, i32 20, i32 20>
  %99 = shl <4 x i32> %85, <i32 12, i32 12, i32 12, i32 12>
  %100 = or <4 x i32> %99, %98
  %101 = add <4 x i32> %89, %49
  %102 = add <4 x i32> %93, %50
  %103 = add <4 x i32> %97, %51
  %104 = add <4 x i32> %100, %52
  %105 = xor <4 x i32> %101, %73
  %106 = lshr <4 x i32> %105, <i32 24, i32 24, i32 24, i32 24>
  %107 = shl <4 x i32> %105, <i32 8, i32 8, i32 8, i32 8>
  %108 = or <4 x i32> %107, %106
  %109 = xor <4 x i32> %102, %74
  %110 = lshr <4 x i32> %109, <i32 24, i32 24, i32 24, i32 24>
  %111 = shl <4 x i32> %109, <i32 8, i32 8, i32 8, i32 8>
  %112 = or <4 x i32> %111, %110
  %113 = xor <4 x i32> %103, %75
  %114 = lshr <4 x i32> %113, <i32 24, i32 24, i32 24, i32 24>
  %115 = shl <4 x i32> %113, <i32 8, i32 8, i32 8, i32 8>
  %116 = or <4 x i32> %115, %114
  %117 = xor <4 x i32> %104, %76
  %118 = lshr <4 x i32> %117, <i32 24, i32 24, i32 24, i32 24>
  %119 = shl <4 x i32> %117, <i32 8, i32 8, i32 8, i32 8>
  %120 = or <4 x i32> %119, %118
  %121 = add <4 x i32> %108, %78
  %122 = add <4 x i32> %112, %80
  %123 = add <4 x i32> %116, %82
  %124 = add <4 x i32> %120, %84
  %125 = xor <4 x i32> %121, %89
  %126 = xor <4 x i32> %122, %93
  %127 = xor <4 x i32> %123, %97
  %128 = xor <4 x i32> %124, %100
  %129 = lshr <4 x i32> %125, <i32 25, i32 25, i32 25, i32 25>
  %130 = shl <4 x i32> %125, <i32 7, i32 7, i32 7, i32 7>
  %131 = or <4 x i32> %130, %129
  %132 = lshr <4 x i32> %126, <i32 25, i32 25, i32 25, i32 25>
  %133 = shl <4 x i32> %126, <i32 7, i32 7, i32 7, i32 7>
  %134 = or <4 x i32> %133, %132
  %135 = lshr <4 x i32> %127, <i32 25, i32 25, i32 25, i32 25>
  %136 = shl <4 x i32> %127, <i32 7, i32 7, i32 7, i32 7>
  %137 = or <4 x i32> %136, %135
  %138 = lshr <4 x i32> %128, <i32 25, i32 25, i32 25, i32 25>
  %139 = shl <4 x i32> %128, <i32 7, i32 7, i32 7, i32 7>
  %140 = or <4 x i32> %139, %138
  %141 = shufflevector <4 x i32> %131, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %142 = shufflevector <4 x i32> %134, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %143 = shufflevector <4 x i32> %137, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %144 = shufflevector <4 x i32> %140, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %145 = shufflevector <4 x i32> %121, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %146 = shufflevector <4 x i32> %122, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %147 = shufflevector <4 x i32> %123, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %148 = shufflevector <4 x i32> %124, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %149 = shufflevector <4 x i32> %108, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %150 = shufflevector <4 x i32> %112, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %151 = shufflevector <4 x i32> %116, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %152 = shufflevector <4 x i32> %120, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %153 = add <4 x i32> %141, %101
  %154 = add <4 x i32> %142, %102
  %155 = add <4 x i32> %143, %103
  %156 = add <4 x i32> %144, %104
  %157 = xor <4 x i32> %153, %149
  %158 = xor <4 x i32> %154, %150
  %159 = xor <4 x i32> %155, %151
  %160 = xor <4 x i32> %156, %152
  %161 = bitcast <4 x i32> %157 to <8 x i16>
  %162 = shufflevector <8 x i16> %161, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 4, i32 5, i32 6, i32 7>
  %163 = shufflevector <8 x i16> %162, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 4, i32 7, i32 6>
  %164 = bitcast <4 x i32> %158 to <8 x i16>
  %165 = shufflevector <8 x i16> %164, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 4, i32 5, i32 6, i32 7>
  %166 = shufflevector <8 x i16> %165, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 4, i32 7, i32 6>
  %167 = bitcast <4 x i32> %159 to <8 x i16>
  %168 = shufflevector <8 x i16> %167, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 4, i32 5, i32 6, i32 7>
  %169 = shufflevector <8 x i16> %168, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 4, i32 7, i32 6>
  %170 = bitcast <4 x i32> %160 to <8 x i16>
  %171 = shufflevector <8 x i16> %170, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 4, i32 5, i32 6, i32 7>
  %172 = shufflevector <8 x i16> %171, <8 x i16> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 5, i32 4, i32 7, i32 6>
  %173 = bitcast <8 x i16> %163 to <4 x i32>
  %174 = bitcast <8 x i16> %166 to <4 x i32>
  %175 = bitcast <8 x i16> %169 to <4 x i32>
  %176 = bitcast <8 x i16> %172 to <4 x i32>
  %177 = add <4 x i32> %145, %173
  %178 = add <4 x i32> %146, %174
  %179 = add <4 x i32> %147, %175
  %180 = add <4 x i32> %148, %176
  %181 = xor <4 x i32> %180, %144
  %182 = xor <4 x i32> %177, %141
  %183 = lshr <4 x i32> %182, <i32 20, i32 20, i32 20, i32 20>
  %184 = shl <4 x i32> %182, <i32 12, i32 12, i32 12, i32 12>
  %185 = or <4 x i32> %184, %183
  %186 = xor <4 x i32> %178, %142
  %187 = lshr <4 x i32> %186, <i32 20, i32 20, i32 20, i32 20>
  %188 = shl <4 x i32> %186, <i32 12, i32 12, i32 12, i32 12>
  %189 = or <4 x i32> %188, %187
  %190 = xor <4 x i32> %179, %143
  %191 = lshr <4 x i32> %190, <i32 20, i32 20, i32 20, i32 20>
  %192 = shl <4 x i32> %190, <i32 12, i32 12, i32 12, i32 12>
  %193 = or <4 x i32> %192, %191
  %194 = lshr <4 x i32> %181, <i32 20, i32 20, i32 20, i32 20>
  %195 = shl <4 x i32> %181, <i32 12, i32 12, i32 12, i32 12>
  %196 = or <4 x i32> %195, %194
  %197 = add <4 x i32> %185, %153
  %198 = add <4 x i32> %189, %154
  %199 = add <4 x i32> %193, %155
  %200 = add <4 x i32> %196, %156
  %201 = xor <4 x i32> %197, %173
  %202 = lshr <4 x i32> %201, <i32 24, i32 24, i32 24, i32 24>
  %203 = shl <4 x i32> %201, <i32 8, i32 8, i32 8, i32 8>
  %204 = or <4 x i32> %203, %202
  %205 = xor <4 x i32> %198, %174
  %206 = lshr <4 x i32> %205, <i32 24, i32 24, i32 24, i32 24>
  %207 = shl <4 x i32> %205, <i32 8, i32 8, i32 8, i32 8>
  %208 = or <4 x i32> %207, %206
  %209 = xor <4 x i32> %199, %175
  %210 = lshr <4 x i32> %209, <i32 24, i32 24, i32 24, i32 24>
  %211 = shl <4 x i32> %209, <i32 8, i32 8, i32 8, i32 8>
  %212 = or <4 x i32> %211, %210
  %213 = xor <4 x i32> %200, %176
  %214 = lshr <4 x i32> %213, <i32 24, i32 24, i32 24, i32 24>
  %215 = shl <4 x i32> %213, <i32 8, i32 8, i32 8, i32 8>
  %216 = or <4 x i32> %215, %214
  %217 = add <4 x i32> %204, %177
  %218 = add <4 x i32> %208, %178
  %219 = add <4 x i32> %212, %179
  %220 = add <4 x i32> %216, %180
  %221 = xor <4 x i32> %217, %185
  %222 = xor <4 x i32> %218, %189
  %223 = xor <4 x i32> %219, %193
  %224 = xor <4 x i32> %220, %196
  %225 = lshr <4 x i32> %221, <i32 25, i32 25, i32 25, i32 25>
  %226 = shl <4 x i32> %221, <i32 7, i32 7, i32 7, i32 7>
  %227 = or <4 x i32> %226, %225
  %228 = lshr <4 x i32> %222, <i32 25, i32 25, i32 25, i32 25>
  %229 = shl <4 x i32> %222, <i32 7, i32 7, i32 7, i32 7>
  %230 = or <4 x i32> %229, %228
  %231 = lshr <4 x i32> %223, <i32 25, i32 25, i32 25, i32 25>
  %232 = shl <4 x i32> %223, <i32 7, i32 7, i32 7, i32 7>
  %233 = or <4 x i32> %232, %231
  %234 = lshr <4 x i32> %224, <i32 25, i32 25, i32 25, i32 25>
  %235 = shl <4 x i32> %224, <i32 7, i32 7, i32 7, i32 7>
  %236 = or <4 x i32> %235, %234
  %237 = shufflevector <4 x i32> %227, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %238 = shufflevector <4 x i32> %230, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %239 = shufflevector <4 x i32> %233, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %240 = shufflevector <4 x i32> %236, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %241 = bitcast <4 x i32> %237 to <2 x i64>
  %242 = bitcast <4 x i32> %238 to <2 x i64>
  %243 = bitcast <4 x i32> %239 to <2 x i64>
  %244 = bitcast <4 x i32> %240 to <2 x i64>
  %245 = shufflevector <4 x i32> %217, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %246 = shufflevector <4 x i32> %218, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %247 = shufflevector <4 x i32> %219, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %248 = shufflevector <4 x i32> %220, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %249 = bitcast <4 x i32> %245 to <2 x i64>
  %250 = bitcast <4 x i32> %246 to <2 x i64>
  %251 = bitcast <4 x i32> %247 to <2 x i64>
  %252 = bitcast <4 x i32> %248 to <2 x i64>
  %253 = shufflevector <4 x i32> %204, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %254 = shufflevector <4 x i32> %208, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %255 = shufflevector <4 x i32> %212, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %256 = shufflevector <4 x i32> %216, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %257 = bitcast <4 x i32> %253 to <2 x i64>
  %258 = bitcast <4 x i32> %254 to <2 x i64>
  %259 = bitcast <4 x i32> %255 to <2 x i64>
  %260 = bitcast <4 x i32> %256 to <2 x i64>
  %exitcond.not.i.i.i = icmp eq i32 %44, %drounds
  br i1 %exitcond.not.i.i.i, label %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i, label %bb26.i.i.i

_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i: ; preds = %bb26.i.i.i
  %261 = bitcast <4 x i32> %237 to <2 x i64>
  %262 = bitcast <4 x i32> %238 to <2 x i64>
  %263 = bitcast <4 x i32> %239 to <2 x i64>
  %264 = bitcast <4 x i32> %240 to <2 x i64>
  %265 = bitcast <4 x i32> %245 to <2 x i64>
  %266 = bitcast <4 x i32> %246 to <2 x i64>
  %267 = bitcast <4 x i32> %247 to <2 x i64>
  %268 = bitcast <4 x i32> %248 to <2 x i64>
  %269 = bitcast <4 x i32> %254 to <2 x i64>
  %270 = bitcast <4 x i32> %255 to <2 x i64>
  %271 = bitcast <4 x i32> %256 to <2 x i64>
  %phi.bo.i.i = add <4 x i32> %197, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo47.i.i = add <4 x i32> %198, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo48.i.i = add <4 x i32> %199, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo49.i.i = add <4 x i32> %200, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  br label %_ZN11rand_chacha4guts11refill_wide9impl_sse217hb0574db456a45ab5E.exit

_ZN11rand_chacha4guts11refill_wide9impl_sse217hb0574db456a45ab5E.exit: ; preds = %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i, %bb14
  %.pre-phi.i.i = phi <4 x i32> [ %253, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %15, %bb14 ]
  %x.sroa.13.sroa.0.0.lcssa.i.i.i = phi <2 x i64> [ %265, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %_49.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.11.sroa.10.0.lcssa.i.i.i = phi <2 x i64> [ %264, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %_46.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.11.sroa.9.0.lcssa.i.i.i = phi <2 x i64> [ %263, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %_46.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.11.sroa.8.0.lcssa.i.i.i = phi <2 x i64> [ %262, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %_46.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.11.sroa.0.0.lcssa.i.i.i = phi <2 x i64> [ %261, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %_46.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.13.sroa.8.0.lcssa.i.i.i = phi <2 x i64> [ %266, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %_49.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.13.sroa.9.0.lcssa.i.i.i = phi <2 x i64> [ %267, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %_49.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.13.sroa.10.0.lcssa.i.i.i = phi <2 x i64> [ %268, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %_49.sroa.0.0.copyload.i.i.i, %bb14 ]
  %x.sroa.15.sroa.8.0.lcssa.i.i.i = phi <2 x i64> [ %269, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %25, %bb14 ]
  %x.sroa.15.sroa.9.0.lcssa.i.i.i = phi <2 x i64> [ %270, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %32, %bb14 ]
  %x.sroa.15.sroa.10.0.lcssa.i.i.i = phi <2 x i64> [ %271, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ %39, %bb14 ]
  %.lcssa1354.i.i.i = phi <4 x i32> [ %phi.bo49.i.i, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %bb14 ]
  %.lcssa1353.i.i.i = phi <4 x i32> [ %phi.bo48.i.i, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %bb14 ]
  %.lcssa1352.i.i.i = phi <4 x i32> [ %phi.bo47.i.i, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %bb14 ]
  %a101347.i.i.i = phi <4 x i32> [ %phi.bo.i.i, %_ZN11rand_chacha4guts16refill_wide_impl17h95d495e1f48da00eE.exit.loopexit.i.i ], [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %bb14 ]
  %272 = add i64 %13, 4
  %_137.i.i.i = lshr i64 %272, 32
  %_136.i.i.i = trunc i64 %_137.i.i.i to i32
  %.12.vec.insert.i13.i298.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_136.i.i.i, i32 0
  %273 = or <4 x i32> %.12.vec.insert.i13.i298.i.i.i, %19
  %274 = shufflevector <4 x i32> %273, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %275 = bitcast <4 x i32> %274 to <2 x i64>
  %_139.i.i.i = trunc i64 %272 to i32
  %276 = and <2 x i64> %275, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i297.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_139.i.i.i, i32 0
  %277 = bitcast <4 x i32> %.12.vec.insert.i18.i297.i.i.i to <2 x i64>
  %278 = or <2 x i64> %276, %277
  store <2 x i64> %278, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i.i.i, align 16
  %279 = bitcast <2 x i64> %_46.sroa.0.0.copyload.i.i.i to <4 x i32>
  %280 = bitcast <2 x i64> %_49.sroa.0.0.copyload.i.i.i to <4 x i32>
  %281 = bitcast <2 x i64> %x.sroa.11.sroa.0.0.lcssa.i.i.i to <4 x i32>
  %282 = bitcast <2 x i64> %x.sroa.13.sroa.0.0.lcssa.i.i.i to <4 x i32>
  %283 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 16
  %284 = bitcast [256 x i8]* %out to <4 x i32>*
  store <4 x i32> %a101347.i.i.i, <4 x i32>* %284, align 1, !noalias !269
  %285 = add <4 x i32> %281, %279
  %286 = bitcast i8* %283 to <4 x i32>*
  store <4 x i32> %285, <4 x i32>* %286, align 1, !noalias !272
  %287 = add <4 x i32> %282, %280
  %288 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 32
  %289 = bitcast i8* %288 to <4 x i32>*
  store <4 x i32> %287, <4 x i32>* %289, align 1, !noalias !275
  %290 = add <4 x i32> %.pre-phi.i.i, %15
  %291 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 48
  %292 = bitcast i8* %291 to <4 x i32>*
  store <4 x i32> %290, <4 x i32>* %292, align 1, !noalias !278
  %293 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 64
  %294 = bitcast <2 x i64> %25 to <4 x i32>
  %295 = bitcast <2 x i64> %x.sroa.15.sroa.8.0.lcssa.i.i.i to <4 x i32>
  %296 = bitcast <2 x i64> %x.sroa.13.sroa.8.0.lcssa.i.i.i to <4 x i32>
  %297 = bitcast <2 x i64> %x.sroa.11.sroa.8.0.lcssa.i.i.i to <4 x i32>
  %298 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 80
  %299 = bitcast i8* %293 to <4 x i32>*
  store <4 x i32> %.lcssa1352.i.i.i, <4 x i32>* %299, align 1, !noalias !269
  %300 = add <4 x i32> %297, %279
  %301 = bitcast i8* %298 to <4 x i32>*
  store <4 x i32> %300, <4 x i32>* %301, align 1, !noalias !272
  %302 = add <4 x i32> %296, %280
  %303 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 96
  %304 = bitcast i8* %303 to <4 x i32>*
  store <4 x i32> %302, <4 x i32>* %304, align 1, !noalias !275
  %305 = add <4 x i32> %295, %294
  %306 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 112
  %307 = bitcast i8* %306 to <4 x i32>*
  store <4 x i32> %305, <4 x i32>* %307, align 1, !noalias !278
  %308 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 128
  %309 = bitcast <2 x i64> %32 to <4 x i32>
  %310 = bitcast <2 x i64> %x.sroa.15.sroa.9.0.lcssa.i.i.i to <4 x i32>
  %311 = bitcast <2 x i64> %x.sroa.13.sroa.9.0.lcssa.i.i.i to <4 x i32>
  %312 = bitcast <2 x i64> %x.sroa.11.sroa.9.0.lcssa.i.i.i to <4 x i32>
  %313 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 144
  %314 = bitcast i8* %308 to <4 x i32>*
  store <4 x i32> %.lcssa1353.i.i.i, <4 x i32>* %314, align 1, !noalias !269
  %315 = add <4 x i32> %312, %279
  %316 = bitcast i8* %313 to <4 x i32>*
  store <4 x i32> %315, <4 x i32>* %316, align 1, !noalias !272
  %317 = add <4 x i32> %311, %280
  %318 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 160
  %319 = bitcast i8* %318 to <4 x i32>*
  store <4 x i32> %317, <4 x i32>* %319, align 1, !noalias !275
  %320 = add <4 x i32> %310, %309
  %321 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 176
  %322 = bitcast i8* %321 to <4 x i32>*
  store <4 x i32> %320, <4 x i32>* %322, align 1, !noalias !278
  %323 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 192
  %324 = bitcast <2 x i64> %39 to <4 x i32>
  %325 = bitcast <2 x i64> %x.sroa.15.sroa.10.0.lcssa.i.i.i to <4 x i32>
  %326 = bitcast <2 x i64> %x.sroa.13.sroa.10.0.lcssa.i.i.i to <4 x i32>
  %327 = bitcast <2 x i64> %x.sroa.11.sroa.10.0.lcssa.i.i.i to <4 x i32>
  %328 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 208
  %329 = bitcast i8* %323 to <4 x i32>*
  store <4 x i32> %.lcssa1354.i.i.i, <4 x i32>* %329, align 1, !noalias !269
  %330 = add <4 x i32> %327, %279
  %331 = bitcast i8* %328 to <4 x i32>*
  store <4 x i32> %330, <4 x i32>* %331, align 1, !noalias !272
  %332 = add <4 x i32> %326, %280
  %333 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 224
  %334 = bitcast i8* %333 to <4 x i32>*
  store <4 x i32> %332, <4 x i32>* %334, align 1, !noalias !275
  %335 = add <4 x i32> %325, %324
  %336 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 240
  %337 = bitcast i8* %336 to <4 x i32>*
  store <4 x i32> %335, <4 x i32>* %337, align 1, !noalias !278
  br label %bb24

bb15:                                             ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected5ssse317h502267245b48fc30E.exit
  tail call fastcc void @_ZN11rand_chacha4guts11refill_wide10impl_ssse317hd134e0c870da37d7E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nonnull align 1 dereferenceable(256) %out)
  br label %bb24

bb24:                                             ; preds = %bb15, %_ZN11rand_chacha4guts11refill_wide9impl_sse217hb0574db456a45ab5E.exit, %bb11, %bb7, %bb3
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @_ZN11rand_chacha4guts11refill_wide9impl_avx217he92eaa75c54690e4E(%"guts::ChaCha"* nocapture align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nocapture align 1 dereferenceable(256) %out) unnamed_addr #4 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_5.sroa.0.0..sroa_idx.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_5.sroa.0.0..sroa_cast.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <2 x i64>*
  %_5.sroa.0.0.copyload.i.i.i = load <2 x i64>, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i.i, align 16, !alias.scope !281
  %0 = extractelement <2 x i64> %_5.sroa.0.0.copyload.i.i.i, i32 0
  %1 = add i64 %0, 1
  %_20.i.i = lshr i64 %1, 32
  %_19.i.i = trunc i64 %_20.i.i to i32
  %2 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <4 x i32>
  %3 = insertelement <4 x i32> %2, i32 %_19.i.i, i32 1
  %_22.i.i = trunc i64 %1 to i32
  %4 = insertelement <4 x i32> %3, i32 %_22.i.i, i32 0
  %5 = add i64 %0, 2
  %_30.i.i = lshr i64 %5, 32
  %_29.i.i = trunc i64 %_30.i.i to i32
  %6 = insertelement <4 x i32> %2, i32 %_29.i.i, i32 1
  %_32.i.i = trunc i64 %5 to i32
  %7 = insertelement <4 x i32> %6, i32 %_32.i.i, i32 0
  %8 = add i64 %0, 3
  %_40.i.i = lshr i64 %8, 32
  %_39.i.i = trunc i64 %_40.i.i to i32
  %9 = insertelement <4 x i32> %2, i32 %_39.i.i, i32 1
  %_42.i.i = trunc i64 %8 to i32
  %10 = insertelement <4 x i32> %9, i32 %_42.i.i, i32 0
  %11 = bitcast %"guts::ChaCha"* %state to <4 x float>*
  %_46.sroa.0.0.copyload.i.i1021 = load <4 x float>, <4 x float>* %11, align 16
  %_49.sroa.0.0..sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 3
  %12 = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i to <4 x float>*
  %_49.sroa.0.0.copyload.i.i1022 = load <4 x float>, <4 x float>* %12, align 16
  %13 = shufflevector <4 x float> %_46.sroa.0.0.copyload.i.i1021, <4 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  %14 = bitcast <8 x float> %13 to <4 x i64>
  %15 = shufflevector <4 x float> %_49.sroa.0.0.copyload.i.i1022, <4 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 0, i32 1, i32 2, i32 3>
  %16 = bitcast <8 x float> %15 to <4 x i64>
  %17 = bitcast <4 x i32> %4 to <4 x float>
  %18 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <4 x float>
  %19 = shufflevector <4 x float> %18, <4 x float> %17, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %20 = bitcast <8 x float> %19 to <4 x i64>
  %21 = bitcast <4 x i32> %10 to <4 x float>
  %22 = bitcast <4 x i32> %7 to <4 x float>
  %23 = shufflevector <4 x float> %22, <4 x float> %21, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %24 = bitcast <8 x float> %23 to <4 x i64>
  %.not.i.i = icmp eq i32 %drounds, 0
  br i1 %.not.i.i, label %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge, label %bb26.i.i

start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge: ; preds = %start
  %25 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <4 x i32>
  %26 = bitcast <4 x float> %_49.sroa.0.0.copyload.i.i1022 to <4 x i32>
  %27 = bitcast <4 x float> %_46.sroa.0.0.copyload.i.i1021 to <4 x i32>
  %.pre1051 = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <4 x i32>*
  br label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit

bb26.i.i:                                         ; preds = %bb26.i.i, %start
  %x.sroa.0.sroa.20.01082.i.i = phi <4 x i64> [ %130, %bb26.i.i ], [ %16, %start ]
  %x.sroa.0.sroa.16.01081.i.i = phi <4 x i64> [ %128, %bb26.i.i ], [ %16, %start ]
  %x.sroa.0.sroa.14.01080.i.i = phi <4 x i64> [ %126, %bb26.i.i ], [ %14, %start ]
  %x.sroa.0.sroa.10.01079.i.i = phi <4 x i64> [ %124, %bb26.i.i ], [ %14, %start ]
  %28 = phi <8 x i32> [ %104, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236, i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %29 = phi <8 x i32> [ %103, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236, i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %iter.sroa.0.01076.i.i = phi i32 [ %30, %bb26.i.i ], [ 0, %start ]
  %x.sroa.14.01075.i.i = phi <4 x i64> [ %134, %bb26.i.i ], [ %24, %start ]
  %x.sroa.12.01074.i.i = phi <4 x i64> [ %132, %bb26.i.i ], [ %20, %start ]
  %30 = add nuw i32 %iter.sroa.0.01076.i.i, 1
  %31 = bitcast <4 x i64> %x.sroa.0.sroa.10.01079.i.i to <8 x i32>
  %32 = add <8 x i32> %29, %31
  %33 = bitcast <8 x i32> %32 to <4 x i64>
  %34 = bitcast <4 x i64> %x.sroa.0.sroa.14.01080.i.i to <8 x i32>
  %35 = add <8 x i32> %28, %34
  %36 = bitcast <8 x i32> %35 to <4 x i64>
  %37 = xor <4 x i64> %x.sroa.12.01074.i.i, %33
  %38 = xor <4 x i64> %x.sroa.14.01075.i.i, %36
  %39 = bitcast <4 x i64> %37 to <32 x i8>
  %40 = shufflevector <32 x i8> %39, <32 x i8> undef, <32 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13, i32 18, i32 19, i32 16, i32 17, i32 22, i32 23, i32 20, i32 21, i32 26, i32 27, i32 24, i32 25, i32 30, i32 31, i32 28, i32 29>
  %41 = bitcast <4 x i64> %38 to <32 x i8>
  %42 = shufflevector <32 x i8> %41, <32 x i8> undef, <32 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13, i32 18, i32 19, i32 16, i32 17, i32 22, i32 23, i32 20, i32 21, i32 26, i32 27, i32 24, i32 25, i32 30, i32 31, i32 28, i32 29>
  %43 = bitcast <4 x i64> %x.sroa.0.sroa.16.01081.i.i to <8 x i32>
  %44 = bitcast <32 x i8> %40 to <8 x i32>
  %45 = add <8 x i32> %44, %43
  %46 = bitcast <4 x i64> %x.sroa.0.sroa.20.01082.i.i to <8 x i32>
  %47 = bitcast <32 x i8> %42 to <8 x i32>
  %48 = add <8 x i32> %47, %46
  %49 = xor <8 x i32> %45, %31
  %50 = lshr <8 x i32> %49, <i32 20, i32 20, i32 20, i32 20, i32 20, i32 20, i32 20, i32 20>
  %51 = shl <8 x i32> %49, <i32 12, i32 12, i32 12, i32 12, i32 12, i32 12, i32 12, i32 12>
  %52 = or <8 x i32> %51, %50
  %53 = xor <8 x i32> %48, %34
  %54 = lshr <8 x i32> %53, <i32 20, i32 20, i32 20, i32 20, i32 20, i32 20, i32 20, i32 20>
  %55 = shl <8 x i32> %53, <i32 12, i32 12, i32 12, i32 12, i32 12, i32 12, i32 12, i32 12>
  %56 = or <8 x i32> %55, %54
  %57 = add <8 x i32> %52, %32
  %58 = add <8 x i32> %56, %35
  %59 = bitcast <8 x i32> %57 to <32 x i8>
  %60 = xor <32 x i8> %40, %59
  %61 = shufflevector <32 x i8> %60, <32 x i8> undef, <32 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14, i32 19, i32 16, i32 17, i32 18, i32 23, i32 20, i32 21, i32 22, i32 27, i32 24, i32 25, i32 26, i32 31, i32 28, i32 29, i32 30>
  %62 = bitcast <8 x i32> %58 to <32 x i8>
  %63 = xor <32 x i8> %42, %62
  %64 = shufflevector <32 x i8> %63, <32 x i8> undef, <32 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14, i32 19, i32 16, i32 17, i32 18, i32 23, i32 20, i32 21, i32 22, i32 27, i32 24, i32 25, i32 26, i32 31, i32 28, i32 29, i32 30>
  %65 = bitcast <32 x i8> %61 to <8 x i32>
  %66 = add <8 x i32> %45, %65
  %67 = bitcast <32 x i8> %64 to <8 x i32>
  %68 = add <8 x i32> %48, %67
  %69 = xor <8 x i32> %66, %52
  %70 = xor <8 x i32> %68, %56
  %71 = lshr <8 x i32> %69, <i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25>
  %72 = shl <8 x i32> %69, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %73 = or <8 x i32> %72, %71
  %74 = lshr <8 x i32> %70, <i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25>
  %75 = shl <8 x i32> %70, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %76 = or <8 x i32> %75, %74
  %77 = shufflevector <8 x i32> %73, <8 x i32> undef, <8 x i32> <i32 1, i32 2, i32 3, i32 0, i32 5, i32 6, i32 7, i32 4>
  %78 = shufflevector <8 x i32> %76, <8 x i32> undef, <8 x i32> <i32 1, i32 2, i32 3, i32 0, i32 5, i32 6, i32 7, i32 4>
  %79 = shufflevector <8 x i32> %66, <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5>
  %80 = shufflevector <8 x i32> %68, <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5>
  %81 = shufflevector <8 x i32> %65, <8 x i32> undef, <8 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6>
  %82 = shufflevector <8 x i32> %67, <8 x i32> undef, <8 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6>
  %83 = add <8 x i32> %77, %57
  %84 = add <8 x i32> %78, %58
  %85 = xor <8 x i32> %83, %81
  %86 = xor <8 x i32> %84, %82
  %87 = bitcast <8 x i32> %85 to <32 x i8>
  %88 = shufflevector <32 x i8> %87, <32 x i8> undef, <32 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13, i32 18, i32 19, i32 16, i32 17, i32 22, i32 23, i32 20, i32 21, i32 26, i32 27, i32 24, i32 25, i32 30, i32 31, i32 28, i32 29>
  %89 = bitcast <8 x i32> %86 to <32 x i8>
  %90 = shufflevector <32 x i8> %89, <32 x i8> undef, <32 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13, i32 18, i32 19, i32 16, i32 17, i32 22, i32 23, i32 20, i32 21, i32 26, i32 27, i32 24, i32 25, i32 30, i32 31, i32 28, i32 29>
  %91 = bitcast <32 x i8> %88 to <8 x i32>
  %92 = add <8 x i32> %79, %91
  %93 = bitcast <32 x i8> %90 to <8 x i32>
  %94 = add <8 x i32> %80, %93
  %95 = xor <8 x i32> %92, %77
  %96 = xor <8 x i32> %94, %78
  %97 = lshr <8 x i32> %95, <i32 20, i32 20, i32 20, i32 20, i32 20, i32 20, i32 20, i32 20>
  %98 = shl <8 x i32> %95, <i32 12, i32 12, i32 12, i32 12, i32 12, i32 12, i32 12, i32 12>
  %99 = or <8 x i32> %98, %97
  %100 = lshr <8 x i32> %96, <i32 20, i32 20, i32 20, i32 20, i32 20, i32 20, i32 20, i32 20>
  %101 = shl <8 x i32> %96, <i32 12, i32 12, i32 12, i32 12, i32 12, i32 12, i32 12, i32 12>
  %102 = or <8 x i32> %101, %100
  %103 = add <8 x i32> %99, %83
  %104 = add <8 x i32> %102, %84
  %105 = bitcast <8 x i32> %103 to <32 x i8>
  %106 = xor <32 x i8> %88, %105
  %107 = shufflevector <32 x i8> %106, <32 x i8> undef, <32 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14, i32 19, i32 16, i32 17, i32 18, i32 23, i32 20, i32 21, i32 22, i32 27, i32 24, i32 25, i32 26, i32 31, i32 28, i32 29, i32 30>
  %108 = bitcast <8 x i32> %104 to <32 x i8>
  %109 = xor <32 x i8> %90, %108
  %110 = shufflevector <32 x i8> %109, <32 x i8> undef, <32 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14, i32 19, i32 16, i32 17, i32 18, i32 23, i32 20, i32 21, i32 22, i32 27, i32 24, i32 25, i32 26, i32 31, i32 28, i32 29, i32 30>
  %111 = bitcast <32 x i8> %107 to <8 x i32>
  %112 = add <8 x i32> %92, %111
  %113 = bitcast <32 x i8> %110 to <8 x i32>
  %114 = add <8 x i32> %94, %113
  %115 = xor <8 x i32> %112, %99
  %116 = xor <8 x i32> %114, %102
  %117 = lshr <8 x i32> %115, <i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25>
  %118 = shl <8 x i32> %115, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %119 = or <8 x i32> %118, %117
  %120 = lshr <8 x i32> %116, <i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25, i32 25>
  %121 = shl <8 x i32> %116, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %122 = or <8 x i32> %121, %120
  %123 = shufflevector <8 x i32> %119, <8 x i32> undef, <8 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6>
  %124 = bitcast <8 x i32> %123 to <4 x i64>
  %125 = shufflevector <8 x i32> %122, <8 x i32> undef, <8 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6>
  %126 = bitcast <8 x i32> %125 to <4 x i64>
  %127 = shufflevector <8 x i32> %112, <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5>
  %128 = bitcast <8 x i32> %127 to <4 x i64>
  %129 = shufflevector <8 x i32> %114, <8 x i32> undef, <8 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5>
  %130 = bitcast <8 x i32> %129 to <4 x i64>
  %131 = shufflevector <8 x i32> %111, <8 x i32> undef, <8 x i32> <i32 1, i32 2, i32 3, i32 0, i32 5, i32 6, i32 7, i32 4>
  %132 = bitcast <8 x i32> %131 to <4 x i64>
  %133 = shufflevector <8 x i32> %113, <8 x i32> undef, <8 x i32> <i32 1, i32 2, i32 3, i32 0, i32 5, i32 6, i32 7, i32 4>
  %134 = bitcast <8 x i32> %133 to <4 x i64>
  %exitcond.not.i.i = icmp eq i32 %30, %drounds
  br i1 %exitcond.not.i.i, label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit, label %bb26.i.i

_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit: ; preds = %bb26.i.i
  %135 = bitcast <8 x i32> %123 to <4 x i64>
  %136 = bitcast <8 x i32> %125 to <4 x i64>
  %137 = bitcast <8 x i32> %127 to <4 x i64>
  %138 = bitcast <8 x i32> %129 to <4 x i64>
  %139 = bitcast <8 x i32> %131 to <4 x i64>
  %140 = bitcast <8 x i32> %133 to <4 x i64>
  %141 = bitcast <8 x i32> %103 to <4 x i64>
  %142 = bitcast <8 x i32> %104 to <4 x i64>
  %.phi.trans.insert = bitcast %"guts::ChaCha"* %state to <4 x i32>*
  %_156.sroa.0.0.copyload1064.i.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert, align 16
  %.phi.trans.insert1045 = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i to <4 x i32>*
  %_159.sroa.0.0.copyload1065.i.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert1045, align 16
  %.phi.trans.insert1047 = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <4 x i32>*
  %_163.sroa.0.0.copyload.i29.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert1047, align 16
  br label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit

_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit: ; preds = %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge
  %.pre-phi1052 = phi <4 x i32>* [ %.pre1051, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %.phi.trans.insert1047, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %_163.sroa.0.0.copyload.i29.i = phi <4 x i32> [ %25, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %_163.sroa.0.0.copyload.i29.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %_159.sroa.0.0.copyload1065.i.i = phi <4 x i32> [ %26, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %_159.sroa.0.0.copyload1065.i.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %_156.sroa.0.0.copyload1064.i.i = phi <4 x i32> [ %27, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %_156.sroa.0.0.copyload1064.i.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %x.sroa.12.0.lcssa.i.i = phi <4 x i64> [ %20, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %139, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %x.sroa.14.0.lcssa.i.i = phi <4 x i64> [ %24, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %140, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %x.sroa.0.sroa.0.0.lcssa.i.i = phi <4 x i64> [ <i64 3684054920433006693, i64 7719281312240119090, i64 3684054920433006693, i64 7719281312240119090>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %141, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %x.sroa.0.sroa.8.0.lcssa.i.i = phi <4 x i64> [ <i64 3684054920433006693, i64 7719281312240119090, i64 3684054920433006693, i64 7719281312240119090>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %142, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %x.sroa.0.sroa.10.0.lcssa.i.i = phi <4 x i64> [ %14, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %135, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %x.sroa.0.sroa.14.0.lcssa.i.i = phi <4 x i64> [ %14, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %136, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %x.sroa.0.sroa.16.0.lcssa.i.i = phi <4 x i64> [ %16, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %137, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %x.sroa.0.sroa.20.0.lcssa.i.i = phi <4 x i64> [ %16, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit_crit_edge ], [ %138, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h3df53dca2e5a8314E.exit.loopexit ]
  %143 = add i64 %0, 4
  %_137.i.i = lshr i64 %143, 32
  %_136.i.i = trunc i64 %_137.i.i to i32
  %144 = insertelement <4 x i32> %2, i32 %_136.i.i, i32 1
  %_139.i.i = trunc i64 %143 to i32
  %145 = insertelement <4 x i32> %144, i32 %_139.i.i, i32 0
  %146 = shufflevector <4 x i64> %x.sroa.0.sroa.0.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %147 = shufflevector <4 x i64> %x.sroa.0.sroa.0.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %148 = bitcast <2 x i64> %146 to <4 x i32>
  %149 = shufflevector <4 x i64> %x.sroa.0.sroa.8.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %150 = shufflevector <4 x i64> %x.sroa.0.sroa.8.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %151 = bitcast <2 x i64> %149 to <4 x i32>
  %152 = shufflevector <4 x i64> %x.sroa.0.sroa.10.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %153 = shufflevector <4 x i64> %x.sroa.0.sroa.10.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %154 = bitcast <2 x i64> %152 to <4 x i32>
  %155 = shufflevector <4 x i64> %x.sroa.0.sroa.14.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %156 = shufflevector <4 x i64> %x.sroa.0.sroa.14.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %157 = bitcast <2 x i64> %155 to <4 x i32>
  %158 = shufflevector <4 x i64> %x.sroa.0.sroa.16.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %159 = shufflevector <4 x i64> %x.sroa.0.sroa.16.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %160 = bitcast <2 x i64> %158 to <4 x i32>
  %161 = shufflevector <4 x i64> %x.sroa.0.sroa.20.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %162 = shufflevector <4 x i64> %x.sroa.0.sroa.20.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %163 = bitcast <2 x i64> %161 to <4 x i32>
  %164 = shufflevector <4 x i64> %x.sroa.12.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %165 = shufflevector <4 x i64> %x.sroa.12.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %166 = bitcast <2 x i64> %164 to <4 x i32>
  %167 = shufflevector <4 x i64> %x.sroa.14.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 0, i32 1>
  %168 = shufflevector <4 x i64> %x.sroa.14.0.lcssa.i.i, <4 x i64> undef, <2 x i32> <i32 2, i32 3>
  %169 = bitcast <2 x i64> %167 to <4 x i32>
  store <4 x i32> %145, <4 x i32>* %.pre-phi1052, align 16
  %170 = add <4 x i32> %148, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %171 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 16
  %172 = bitcast [256 x i8]* %out to <4 x i32>*
  store <4 x i32> %170, <4 x i32>* %172, align 1, !noalias !284
  %173 = add <4 x i32> %_156.sroa.0.0.copyload1064.i.i, %154
  %174 = bitcast i8* %171 to <4 x i32>*
  store <4 x i32> %173, <4 x i32>* %174, align 1, !noalias !287
  %175 = add <4 x i32> %_159.sroa.0.0.copyload1065.i.i, %160
  %176 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 32
  %177 = bitcast i8* %176 to <4 x i32>*
  store <4 x i32> %175, <4 x i32>* %177, align 1, !noalias !290
  %178 = add <4 x i32> %_163.sroa.0.0.copyload.i29.i, %166
  %179 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 48
  %180 = bitcast i8* %179 to <4 x i32>*
  store <4 x i32> %178, <4 x i32>* %180, align 1, !noalias !293
  %181 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 64
  %182 = bitcast <2 x i64> %147 to <4 x i32>
  %183 = add <4 x i32> %182, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %184 = bitcast <2 x i64> %165 to <4 x i32>
  %185 = bitcast <2 x i64> %159 to <4 x i32>
  %186 = bitcast <2 x i64> %153 to <4 x i32>
  %187 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 80
  %188 = bitcast i8* %181 to <4 x i32>*
  store <4 x i32> %183, <4 x i32>* %188, align 1, !noalias !284
  %189 = add <4 x i32> %_156.sroa.0.0.copyload1064.i.i, %186
  %190 = bitcast i8* %187 to <4 x i32>*
  store <4 x i32> %189, <4 x i32>* %190, align 1, !noalias !287
  %191 = add <4 x i32> %_159.sroa.0.0.copyload1065.i.i, %185
  %192 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 96
  %193 = bitcast i8* %192 to <4 x i32>*
  store <4 x i32> %191, <4 x i32>* %193, align 1, !noalias !290
  %194 = add <4 x i32> %4, %184
  %195 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 112
  %196 = bitcast i8* %195 to <4 x i32>*
  store <4 x i32> %194, <4 x i32>* %196, align 1, !noalias !293
  %197 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 128
  %198 = add <4 x i32> %151, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %199 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 144
  %200 = bitcast i8* %197 to <4 x i32>*
  store <4 x i32> %198, <4 x i32>* %200, align 1, !noalias !284
  %201 = add <4 x i32> %_156.sroa.0.0.copyload1064.i.i, %157
  %202 = bitcast i8* %199 to <4 x i32>*
  store <4 x i32> %201, <4 x i32>* %202, align 1, !noalias !287
  %203 = add <4 x i32> %_159.sroa.0.0.copyload1065.i.i, %163
  %204 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 160
  %205 = bitcast i8* %204 to <4 x i32>*
  store <4 x i32> %203, <4 x i32>* %205, align 1, !noalias !290
  %206 = add <4 x i32> %7, %169
  %207 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 176
  %208 = bitcast i8* %207 to <4 x i32>*
  store <4 x i32> %206, <4 x i32>* %208, align 1, !noalias !293
  %209 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 192
  %210 = bitcast <2 x i64> %150 to <4 x i32>
  %211 = add <4 x i32> %210, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %212 = bitcast <2 x i64> %168 to <4 x i32>
  %213 = bitcast <2 x i64> %162 to <4 x i32>
  %214 = bitcast <2 x i64> %156 to <4 x i32>
  %215 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 208
  %216 = bitcast i8* %209 to <4 x i32>*
  store <4 x i32> %211, <4 x i32>* %216, align 1, !noalias !284
  %217 = add <4 x i32> %_156.sroa.0.0.copyload1064.i.i, %214
  %218 = bitcast i8* %215 to <4 x i32>*
  store <4 x i32> %217, <4 x i32>* %218, align 1, !noalias !287
  %219 = add <4 x i32> %_159.sroa.0.0.copyload1065.i.i, %213
  %220 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 224
  %221 = bitcast i8* %220 to <4 x i32>*
  store <4 x i32> %219, <4 x i32>* %221, align 1, !noalias !290
  %222 = add <4 x i32> %10, %212
  %223 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 240
  %224 = bitcast i8* %223 to <4 x i32>*
  store <4 x i32> %222, <4 x i32>* %224, align 1, !noalias !293
  tail call void @llvm.x86.avx.vzeroupper() #14
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @_ZN11rand_chacha4guts11refill_wide8impl_avx17headc73f5fe348c9bE(%"guts::ChaCha"* nocapture align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nocapture align 1 dereferenceable(256) %out) unnamed_addr #5 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_5.sroa.0.0..sroa_idx.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_5.sroa.0.0..sroa_cast.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <2 x i64>*
  %_5.sroa.0.0.copyload.i.i.i = load <2 x i64>, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i.i, align 16, !alias.scope !296
  %0 = extractelement <2 x i64> %_5.sroa.0.0.copyload.i.i.i, i32 0
  %1 = add i64 %0, 1
  %_20.i.i = lshr i64 %1, 32
  %_19.i.i = trunc i64 %_20.i.i to i32
  %2 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <4 x i32>
  %3 = insertelement <4 x i32> %2, i32 %_19.i.i, i32 1
  %_22.i.i = trunc i64 %1 to i32
  %4 = insertelement <4 x i32> %3, i32 %_22.i.i, i32 0
  %5 = add i64 %0, 2
  %_30.i.i = lshr i64 %5, 32
  %_29.i.i = trunc i64 %_30.i.i to i32
  %6 = insertelement <4 x i32> %2, i32 %_29.i.i, i32 1
  %_32.i.i = trunc i64 %5 to i32
  %7 = insertelement <4 x i32> %6, i32 %_32.i.i, i32 0
  %8 = add i64 %0, 3
  %_40.i.i = lshr i64 %8, 32
  %_39.i.i = trunc i64 %_40.i.i to i32
  %9 = insertelement <4 x i32> %2, i32 %_39.i.i, i32 1
  %_42.i.i = trunc i64 %8 to i32
  %10 = insertelement <4 x i32> %9, i32 %_42.i.i, i32 0
  %_46.sroa.0.0..sroa_cast.i.i = bitcast %"guts::ChaCha"* %state to <2 x i64>*
  %_46.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_46.sroa.0.0..sroa_cast.i.i, align 16
  %_49.sroa.0.0..sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 3
  %_49.sroa.0.0..sroa_cast.i.i = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i to <2 x i64>*
  %_49.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_49.sroa.0.0..sroa_cast.i.i, align 16
  %.not.i.i = icmp eq i32 %drounds, 0
  br i1 %.not.i.i, label %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge, label %bb26.i.i

start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge: ; preds = %start
  %11 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <4 x i32>
  %12 = bitcast <2 x i64> %_49.sroa.0.0.copyload.i.i to <4 x i32>
  %13 = bitcast <2 x i64> %_46.sroa.0.0.copyload.i.i to <4 x i32>
  %.pre341 = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <4 x i32>*
  br label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit

bb26.i.i:                                         ; preds = %bb26.i.i, %start
  %iter.sroa.0.01478.i.i = phi i32 [ %18, %bb26.i.i ], [ 0, %start ]
  %14 = phi <4 x i32> [ %160, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %15 = phi <4 x i32> [ %161, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %16 = phi <4 x i32> [ %162, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %17 = phi <4 x i32> [ %163, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %x.sroa.15.sroa.10.01473.i.i.in = phi <4 x i32> [ %219, %bb26.i.i ], [ %10, %start ]
  %x.sroa.15.sroa.9.01472.i.i.in = phi <4 x i32> [ %218, %bb26.i.i ], [ %7, %start ]
  %x.sroa.15.sroa.8.01471.i.i.in = phi <4 x i32> [ %217, %bb26.i.i ], [ %4, %start ]
  %x.sroa.15.sroa.0.01470.i.i = phi <2 x i64> [ %220, %bb26.i.i ], [ %_5.sroa.0.0.copyload.i.i.i, %start ]
  %x.sroa.13.sroa.10.01469.i.i = phi <2 x i64> [ %215, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.9.01468.i.i = phi <2 x i64> [ %214, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.8.01467.i.i = phi <2 x i64> [ %213, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.0.01466.i.i = phi <2 x i64> [ %204, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.8.01465.i.i = phi <2 x i64> [ %205, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.9.01464.i.i = phi <2 x i64> [ %206, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.10.01463.i.i = phi <2 x i64> [ %207, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.0.01462.i.i = phi <2 x i64> [ %212, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %18 = add nuw i32 %iter.sroa.0.01478.i.i, 1
  %19 = bitcast <2 x i64> %x.sroa.11.sroa.0.01466.i.i to <4 x i32>
  %20 = bitcast <2 x i64> %x.sroa.11.sroa.8.01465.i.i to <4 x i32>
  %21 = bitcast <2 x i64> %x.sroa.11.sroa.9.01464.i.i to <4 x i32>
  %22 = bitcast <2 x i64> %x.sroa.11.sroa.10.01463.i.i to <4 x i32>
  %23 = add <4 x i32> %14, %19
  %24 = bitcast <4 x i32> %23 to <2 x i64>
  %25 = add <4 x i32> %15, %20
  %26 = add <4 x i32> %16, %21
  %27 = add <4 x i32> %17, %22
  %28 = xor <2 x i64> %x.sroa.15.sroa.0.01470.i.i, %24
  %29 = xor <4 x i32> %25, %x.sroa.15.sroa.8.01471.i.i.in
  %30 = xor <4 x i32> %26, %x.sroa.15.sroa.9.01472.i.i.in
  %31 = xor <4 x i32> %27, %x.sroa.15.sroa.10.01473.i.i.in
  %32 = bitcast <2 x i64> %28 to <16 x i8>
  %33 = shufflevector <16 x i8> %32, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %34 = bitcast <16 x i8> %33 to <4 x i32>
  %35 = bitcast <4 x i32> %29 to <16 x i8>
  %36 = shufflevector <16 x i8> %35, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %37 = bitcast <4 x i32> %30 to <16 x i8>
  %38 = shufflevector <16 x i8> %37, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %39 = bitcast <4 x i32> %31 to <16 x i8>
  %40 = shufflevector <16 x i8> %39, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %41 = bitcast <16 x i8> %36 to <4 x i32>
  %42 = bitcast <16 x i8> %38 to <4 x i32>
  %43 = bitcast <16 x i8> %40 to <4 x i32>
  %44 = bitcast <2 x i64> %x.sroa.13.sroa.0.01462.i.i to <4 x i32>
  %45 = add <4 x i32> %34, %44
  %46 = bitcast <2 x i64> %x.sroa.13.sroa.8.01467.i.i to <4 x i32>
  %47 = add <4 x i32> %41, %46
  %48 = bitcast <2 x i64> %x.sroa.13.sroa.9.01468.i.i to <4 x i32>
  %49 = add <4 x i32> %42, %48
  %50 = bitcast <2 x i64> %x.sroa.13.sroa.10.01469.i.i to <4 x i32>
  %51 = add <4 x i32> %43, %50
  %52 = xor <4 x i32> %45, %19
  %53 = lshr <4 x i32> %52, <i32 20, i32 20, i32 20, i32 20>
  %54 = shl <4 x i32> %52, <i32 12, i32 12, i32 12, i32 12>
  %55 = or <4 x i32> %54, %53
  %56 = xor <4 x i32> %47, %20
  %57 = lshr <4 x i32> %56, <i32 20, i32 20, i32 20, i32 20>
  %58 = shl <4 x i32> %56, <i32 12, i32 12, i32 12, i32 12>
  %59 = or <4 x i32> %58, %57
  %60 = xor <4 x i32> %49, %21
  %61 = lshr <4 x i32> %60, <i32 20, i32 20, i32 20, i32 20>
  %62 = shl <4 x i32> %60, <i32 12, i32 12, i32 12, i32 12>
  %63 = or <4 x i32> %62, %61
  %64 = xor <4 x i32> %51, %22
  %65 = lshr <4 x i32> %64, <i32 20, i32 20, i32 20, i32 20>
  %66 = shl <4 x i32> %64, <i32 12, i32 12, i32 12, i32 12>
  %67 = or <4 x i32> %66, %65
  %68 = add <4 x i32> %55, %23
  %69 = add <4 x i32> %59, %25
  %70 = add <4 x i32> %63, %26
  %71 = add <4 x i32> %67, %27
  %72 = xor <4 x i32> %68, %34
  %73 = xor <4 x i32> %69, %41
  %74 = xor <4 x i32> %70, %42
  %75 = xor <4 x i32> %71, %43
  %76 = bitcast <4 x i32> %72 to <16 x i8>
  %77 = shufflevector <16 x i8> %76, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %78 = bitcast <16 x i8> %77 to <4 x i32>
  %79 = bitcast <4 x i32> %73 to <16 x i8>
  %80 = shufflevector <16 x i8> %79, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %81 = bitcast <4 x i32> %74 to <16 x i8>
  %82 = shufflevector <16 x i8> %81, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %83 = bitcast <4 x i32> %75 to <16 x i8>
  %84 = shufflevector <16 x i8> %83, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %85 = bitcast <16 x i8> %80 to <4 x i32>
  %86 = bitcast <16 x i8> %82 to <4 x i32>
  %87 = bitcast <16 x i8> %84 to <4 x i32>
  %88 = add <4 x i32> %45, %78
  %89 = add <4 x i32> %47, %85
  %90 = add <4 x i32> %49, %86
  %91 = add <4 x i32> %51, %87
  %92 = xor <4 x i32> %88, %55
  %93 = lshr <4 x i32> %92, <i32 25, i32 25, i32 25, i32 25>
  %94 = shl <4 x i32> %92, <i32 7, i32 7, i32 7, i32 7>
  %95 = or <4 x i32> %94, %93
  %96 = xor <4 x i32> %89, %59
  %97 = lshr <4 x i32> %96, <i32 25, i32 25, i32 25, i32 25>
  %98 = shl <4 x i32> %96, <i32 7, i32 7, i32 7, i32 7>
  %99 = or <4 x i32> %98, %97
  %100 = xor <4 x i32> %90, %63
  %101 = lshr <4 x i32> %100, <i32 25, i32 25, i32 25, i32 25>
  %102 = shl <4 x i32> %100, <i32 7, i32 7, i32 7, i32 7>
  %103 = or <4 x i32> %102, %101
  %104 = xor <4 x i32> %91, %67
  %105 = lshr <4 x i32> %104, <i32 25, i32 25, i32 25, i32 25>
  %106 = shl <4 x i32> %104, <i32 7, i32 7, i32 7, i32 7>
  %107 = or <4 x i32> %106, %105
  %108 = shufflevector <4 x i32> %95, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %109 = shufflevector <4 x i32> %99, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %110 = shufflevector <4 x i32> %103, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %111 = shufflevector <4 x i32> %107, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %112 = shufflevector <4 x i32> %88, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %113 = shufflevector <4 x i32> %89, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %114 = shufflevector <4 x i32> %90, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %115 = shufflevector <4 x i32> %91, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %116 = shufflevector <4 x i32> %78, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %117 = shufflevector <4 x i32> %85, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %118 = shufflevector <4 x i32> %86, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %119 = shufflevector <4 x i32> %87, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %120 = add <4 x i32> %108, %68
  %121 = add <4 x i32> %109, %69
  %122 = add <4 x i32> %110, %70
  %123 = add <4 x i32> %111, %71
  %124 = xor <4 x i32> %120, %116
  %125 = xor <4 x i32> %121, %117
  %126 = xor <4 x i32> %122, %118
  %127 = xor <4 x i32> %123, %119
  %128 = bitcast <4 x i32> %124 to <16 x i8>
  %129 = shufflevector <16 x i8> %128, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %130 = bitcast <16 x i8> %129 to <4 x i32>
  %131 = bitcast <4 x i32> %125 to <16 x i8>
  %132 = shufflevector <16 x i8> %131, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %133 = bitcast <4 x i32> %126 to <16 x i8>
  %134 = shufflevector <16 x i8> %133, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %135 = bitcast <4 x i32> %127 to <16 x i8>
  %136 = shufflevector <16 x i8> %135, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %137 = bitcast <16 x i8> %132 to <4 x i32>
  %138 = bitcast <16 x i8> %134 to <4 x i32>
  %139 = bitcast <16 x i8> %136 to <4 x i32>
  %140 = add <4 x i32> %112, %130
  %141 = add <4 x i32> %113, %137
  %142 = add <4 x i32> %114, %138
  %143 = add <4 x i32> %115, %139
  %144 = xor <4 x i32> %140, %108
  %145 = lshr <4 x i32> %144, <i32 20, i32 20, i32 20, i32 20>
  %146 = shl <4 x i32> %144, <i32 12, i32 12, i32 12, i32 12>
  %147 = or <4 x i32> %146, %145
  %148 = xor <4 x i32> %141, %109
  %149 = lshr <4 x i32> %148, <i32 20, i32 20, i32 20, i32 20>
  %150 = shl <4 x i32> %148, <i32 12, i32 12, i32 12, i32 12>
  %151 = or <4 x i32> %150, %149
  %152 = xor <4 x i32> %142, %110
  %153 = lshr <4 x i32> %152, <i32 20, i32 20, i32 20, i32 20>
  %154 = shl <4 x i32> %152, <i32 12, i32 12, i32 12, i32 12>
  %155 = or <4 x i32> %154, %153
  %156 = xor <4 x i32> %143, %111
  %157 = lshr <4 x i32> %156, <i32 20, i32 20, i32 20, i32 20>
  %158 = shl <4 x i32> %156, <i32 12, i32 12, i32 12, i32 12>
  %159 = or <4 x i32> %158, %157
  %160 = add <4 x i32> %147, %120
  %161 = add <4 x i32> %151, %121
  %162 = add <4 x i32> %155, %122
  %163 = add <4 x i32> %159, %123
  %164 = xor <4 x i32> %160, %130
  %165 = xor <4 x i32> %161, %137
  %166 = xor <4 x i32> %162, %138
  %167 = xor <4 x i32> %163, %139
  %168 = bitcast <4 x i32> %164 to <16 x i8>
  %169 = shufflevector <16 x i8> %168, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %170 = bitcast <16 x i8> %169 to <4 x i32>
  %171 = bitcast <4 x i32> %165 to <16 x i8>
  %172 = shufflevector <16 x i8> %171, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %173 = bitcast <4 x i32> %166 to <16 x i8>
  %174 = shufflevector <16 x i8> %173, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %175 = bitcast <4 x i32> %167 to <16 x i8>
  %176 = shufflevector <16 x i8> %175, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %177 = bitcast <16 x i8> %172 to <4 x i32>
  %178 = bitcast <16 x i8> %174 to <4 x i32>
  %179 = bitcast <16 x i8> %176 to <4 x i32>
  %180 = add <4 x i32> %140, %170
  %181 = add <4 x i32> %141, %177
  %182 = add <4 x i32> %142, %178
  %183 = add <4 x i32> %143, %179
  %184 = xor <4 x i32> %180, %147
  %185 = lshr <4 x i32> %184, <i32 25, i32 25, i32 25, i32 25>
  %186 = shl <4 x i32> %184, <i32 7, i32 7, i32 7, i32 7>
  %187 = or <4 x i32> %186, %185
  %188 = xor <4 x i32> %181, %151
  %189 = lshr <4 x i32> %188, <i32 25, i32 25, i32 25, i32 25>
  %190 = shl <4 x i32> %188, <i32 7, i32 7, i32 7, i32 7>
  %191 = or <4 x i32> %190, %189
  %192 = xor <4 x i32> %182, %155
  %193 = lshr <4 x i32> %192, <i32 25, i32 25, i32 25, i32 25>
  %194 = shl <4 x i32> %192, <i32 7, i32 7, i32 7, i32 7>
  %195 = or <4 x i32> %194, %193
  %196 = xor <4 x i32> %183, %159
  %197 = lshr <4 x i32> %196, <i32 25, i32 25, i32 25, i32 25>
  %198 = shl <4 x i32> %196, <i32 7, i32 7, i32 7, i32 7>
  %199 = or <4 x i32> %198, %197
  %200 = shufflevector <4 x i32> %187, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %201 = shufflevector <4 x i32> %191, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %202 = shufflevector <4 x i32> %195, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %203 = shufflevector <4 x i32> %199, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %204 = bitcast <4 x i32> %200 to <2 x i64>
  %205 = bitcast <4 x i32> %201 to <2 x i64>
  %206 = bitcast <4 x i32> %202 to <2 x i64>
  %207 = bitcast <4 x i32> %203 to <2 x i64>
  %208 = shufflevector <4 x i32> %180, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %209 = shufflevector <4 x i32> %181, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %210 = shufflevector <4 x i32> %182, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %211 = shufflevector <4 x i32> %183, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %212 = bitcast <4 x i32> %208 to <2 x i64>
  %213 = bitcast <4 x i32> %209 to <2 x i64>
  %214 = bitcast <4 x i32> %210 to <2 x i64>
  %215 = bitcast <4 x i32> %211 to <2 x i64>
  %216 = shufflevector <4 x i32> %170, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %217 = shufflevector <4 x i32> %177, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %218 = shufflevector <4 x i32> %178, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %219 = shufflevector <4 x i32> %179, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %220 = bitcast <4 x i32> %216 to <2 x i64>
  %exitcond.not.i.i = icmp eq i32 %18, %drounds
  br i1 %exitcond.not.i.i, label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit, label %bb26.i.i

_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit: ; preds = %bb26.i.i
  %221 = bitcast <4 x i32> %200 to <2 x i64>
  %222 = bitcast <4 x i32> %201 to <2 x i64>
  %223 = bitcast <4 x i32> %202 to <2 x i64>
  %224 = bitcast <4 x i32> %203 to <2 x i64>
  %225 = bitcast <4 x i32> %208 to <2 x i64>
  %226 = bitcast <4 x i32> %209 to <2 x i64>
  %227 = bitcast <4 x i32> %210 to <2 x i64>
  %228 = bitcast <4 x i32> %211 to <2 x i64>
  %phi.bo = add <4 x i32> %160, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo314 = add <4 x i32> %161, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo315 = add <4 x i32> %162, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo316 = add <4 x i32> %163, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %.phi.trans.insert = bitcast %"guts::ChaCha"* %state to <4 x i32>*
  %_156.sroa.0.0.copyload1448.i.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert, align 16
  %.phi.trans.insert333 = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i to <4 x i32>*
  %_159.sroa.0.0.copyload1449.i.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert333, align 16
  %.phi.trans.insert335 = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <4 x i32>*
  %_163.sroa.0.0.copyload.i21.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert335, align 16
  br label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit

_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit: ; preds = %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge
  %.pre-phi342 = phi <4 x i32>* [ %.pre341, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %.phi.trans.insert335, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %.pre-phi = phi <4 x i32> [ %2, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %216, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %_163.sroa.0.0.copyload.i21.i = phi <4 x i32> [ %11, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %_163.sroa.0.0.copyload.i21.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %_159.sroa.0.0.copyload1449.i.i = phi <4 x i32> [ %12, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %_159.sroa.0.0.copyload1449.i.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %_156.sroa.0.0.copyload1448.i.i = phi <4 x i32> [ %13, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %_156.sroa.0.0.copyload1448.i.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.13.sroa.0.0.lcssa.i.i = phi <2 x i64> [ %_49.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %225, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.11.sroa.10.0.lcssa.i.i = phi <2 x i64> [ %_46.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %224, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.11.sroa.9.0.lcssa.i.i = phi <2 x i64> [ %_46.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %223, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.11.sroa.8.0.lcssa.i.i = phi <2 x i64> [ %_46.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %222, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.11.sroa.0.0.lcssa.i.i = phi <2 x i64> [ %_46.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %221, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.13.sroa.8.0.lcssa.i.i = phi <2 x i64> [ %_49.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %226, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.13.sroa.9.0.lcssa.i.i = phi <2 x i64> [ %_49.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %227, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.13.sroa.10.0.lcssa.i.i = phi <2 x i64> [ %_49.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %228, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %229 = phi <4 x i32> [ %4, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %217, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %230 = phi <4 x i32> [ %7, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %218, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %231 = phi <4 x i32> [ %10, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %219, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %232 = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %phi.bo316, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %233 = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %phi.bo315, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %234 = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %phi.bo314, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %235 = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %phi.bo, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %236 = add i64 %0, 4
  %_137.i.i = lshr i64 %236, 32
  %_136.i.i = trunc i64 %_137.i.i to i32
  %237 = insertelement <4 x i32> %2, i32 %_136.i.i, i32 1
  %_139.i.i = trunc i64 %236 to i32
  %238 = insertelement <4 x i32> %237, i32 %_139.i.i, i32 0
  store <4 x i32> %238, <4 x i32>* %.pre-phi342, align 16
  %239 = bitcast <2 x i64> %x.sroa.11.sroa.0.0.lcssa.i.i to <4 x i32>
  %240 = bitcast <2 x i64> %x.sroa.13.sroa.0.0.lcssa.i.i to <4 x i32>
  %241 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 16
  %242 = bitcast [256 x i8]* %out to <4 x i32>*
  store <4 x i32> %235, <4 x i32>* %242, align 1, !noalias !299
  %243 = add <4 x i32> %_156.sroa.0.0.copyload1448.i.i, %239
  %244 = bitcast i8* %241 to <4 x i32>*
  store <4 x i32> %243, <4 x i32>* %244, align 1, !noalias !302
  %245 = add <4 x i32> %_159.sroa.0.0.copyload1449.i.i, %240
  %246 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 32
  %247 = bitcast i8* %246 to <4 x i32>*
  store <4 x i32> %245, <4 x i32>* %247, align 1, !noalias !305
  %248 = add <4 x i32> %_163.sroa.0.0.copyload.i21.i, %.pre-phi
  %249 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 48
  %250 = bitcast i8* %249 to <4 x i32>*
  store <4 x i32> %248, <4 x i32>* %250, align 1, !noalias !308
  %251 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 64
  %252 = bitcast <2 x i64> %x.sroa.13.sroa.8.0.lcssa.i.i to <4 x i32>
  %253 = bitcast <2 x i64> %x.sroa.11.sroa.8.0.lcssa.i.i to <4 x i32>
  %254 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 80
  %255 = bitcast i8* %251 to <4 x i32>*
  store <4 x i32> %234, <4 x i32>* %255, align 1, !noalias !299
  %256 = add <4 x i32> %_156.sroa.0.0.copyload1448.i.i, %253
  %257 = bitcast i8* %254 to <4 x i32>*
  store <4 x i32> %256, <4 x i32>* %257, align 1, !noalias !302
  %258 = add <4 x i32> %_159.sroa.0.0.copyload1449.i.i, %252
  %259 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 96
  %260 = bitcast i8* %259 to <4 x i32>*
  store <4 x i32> %258, <4 x i32>* %260, align 1, !noalias !305
  %261 = add <4 x i32> %229, %4
  %262 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 112
  %263 = bitcast i8* %262 to <4 x i32>*
  store <4 x i32> %261, <4 x i32>* %263, align 1, !noalias !308
  %264 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 128
  %265 = bitcast <2 x i64> %x.sroa.13.sroa.9.0.lcssa.i.i to <4 x i32>
  %266 = bitcast <2 x i64> %x.sroa.11.sroa.9.0.lcssa.i.i to <4 x i32>
  %267 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 144
  %268 = bitcast i8* %264 to <4 x i32>*
  store <4 x i32> %233, <4 x i32>* %268, align 1, !noalias !299
  %269 = add <4 x i32> %_156.sroa.0.0.copyload1448.i.i, %266
  %270 = bitcast i8* %267 to <4 x i32>*
  store <4 x i32> %269, <4 x i32>* %270, align 1, !noalias !302
  %271 = add <4 x i32> %_159.sroa.0.0.copyload1449.i.i, %265
  %272 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 160
  %273 = bitcast i8* %272 to <4 x i32>*
  store <4 x i32> %271, <4 x i32>* %273, align 1, !noalias !305
  %274 = add <4 x i32> %230, %7
  %275 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 176
  %276 = bitcast i8* %275 to <4 x i32>*
  store <4 x i32> %274, <4 x i32>* %276, align 1, !noalias !308
  %277 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 192
  %278 = bitcast <2 x i64> %x.sroa.13.sroa.10.0.lcssa.i.i to <4 x i32>
  %279 = bitcast <2 x i64> %x.sroa.11.sroa.10.0.lcssa.i.i to <4 x i32>
  %280 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 208
  %281 = bitcast i8* %277 to <4 x i32>*
  store <4 x i32> %232, <4 x i32>* %281, align 1, !noalias !299
  %282 = add <4 x i32> %_156.sroa.0.0.copyload1448.i.i, %279
  %283 = bitcast i8* %280 to <4 x i32>*
  store <4 x i32> %282, <4 x i32>* %283, align 1, !noalias !302
  %284 = add <4 x i32> %_159.sroa.0.0.copyload1449.i.i, %278
  %285 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 224
  %286 = bitcast i8* %285 to <4 x i32>*
  store <4 x i32> %284, <4 x i32>* %286, align 1, !noalias !305
  %287 = add <4 x i32> %231, %10
  %288 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 240
  %289 = bitcast i8* %288 to <4 x i32>*
  store <4 x i32> %287, <4 x i32>* %289, align 1, !noalias !308
  tail call void @llvm.x86.avx.vzeroupper() #14
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @_ZN11rand_chacha4guts11refill_wide10impl_sse4117hfa5f15f9763c224aE(%"guts::ChaCha"* nocapture align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nocapture align 1 dereferenceable(256) %out) unnamed_addr #6 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_5.sroa.0.0..sroa_idx.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_5.sroa.0.0..sroa_cast.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <2 x i64>*
  %_5.sroa.0.0.copyload.i.i.i = load <2 x i64>, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i.i, align 16, !alias.scope !311
  %0 = extractelement <2 x i64> %_5.sroa.0.0.copyload.i.i.i, i32 0
  %1 = add i64 %0, 1
  %_20.i.i = lshr i64 %1, 32
  %_19.i.i = trunc i64 %_20.i.i to i32
  %2 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <4 x i32>
  %3 = insertelement <4 x i32> %2, i32 %_19.i.i, i32 1
  %_22.i.i = trunc i64 %1 to i32
  %4 = insertelement <4 x i32> %3, i32 %_22.i.i, i32 0
  %5 = add i64 %0, 2
  %_30.i.i = lshr i64 %5, 32
  %_29.i.i = trunc i64 %_30.i.i to i32
  %6 = insertelement <4 x i32> %2, i32 %_29.i.i, i32 1
  %_32.i.i = trunc i64 %5 to i32
  %7 = insertelement <4 x i32> %6, i32 %_32.i.i, i32 0
  %8 = add i64 %0, 3
  %_40.i.i = lshr i64 %8, 32
  %_39.i.i = trunc i64 %_40.i.i to i32
  %9 = insertelement <4 x i32> %2, i32 %_39.i.i, i32 1
  %_42.i.i = trunc i64 %8 to i32
  %10 = insertelement <4 x i32> %9, i32 %_42.i.i, i32 0
  %_46.sroa.0.0..sroa_cast.i.i = bitcast %"guts::ChaCha"* %state to <2 x i64>*
  %_46.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_46.sroa.0.0..sroa_cast.i.i, align 16
  %_49.sroa.0.0..sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 3
  %_49.sroa.0.0..sroa_cast.i.i = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i to <2 x i64>*
  %_49.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_49.sroa.0.0..sroa_cast.i.i, align 16
  %.not.i.i = icmp eq i32 %drounds, 0
  br i1 %.not.i.i, label %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge, label %bb26.i.i

start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge: ; preds = %start
  %11 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <4 x i32>
  %12 = bitcast <2 x i64> %_49.sroa.0.0.copyload.i.i to <4 x i32>
  %13 = bitcast <2 x i64> %_46.sroa.0.0.copyload.i.i to <4 x i32>
  %.pre341 = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <4 x i32>*
  br label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit

bb26.i.i:                                         ; preds = %bb26.i.i, %start
  %iter.sroa.0.01478.i.i = phi i32 [ %18, %bb26.i.i ], [ 0, %start ]
  %14 = phi <4 x i32> [ %160, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %15 = phi <4 x i32> [ %161, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %16 = phi <4 x i32> [ %162, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %17 = phi <4 x i32> [ %163, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %x.sroa.15.sroa.10.01473.i.i.in = phi <4 x i32> [ %219, %bb26.i.i ], [ %10, %start ]
  %x.sroa.15.sroa.9.01472.i.i.in = phi <4 x i32> [ %218, %bb26.i.i ], [ %7, %start ]
  %x.sroa.15.sroa.8.01471.i.i.in = phi <4 x i32> [ %217, %bb26.i.i ], [ %4, %start ]
  %x.sroa.15.sroa.0.01470.i.i = phi <2 x i64> [ %220, %bb26.i.i ], [ %_5.sroa.0.0.copyload.i.i.i, %start ]
  %x.sroa.13.sroa.10.01469.i.i = phi <2 x i64> [ %215, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.9.01468.i.i = phi <2 x i64> [ %214, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.8.01467.i.i = phi <2 x i64> [ %213, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.0.01466.i.i = phi <2 x i64> [ %204, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.8.01465.i.i = phi <2 x i64> [ %205, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.9.01464.i.i = phi <2 x i64> [ %206, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.10.01463.i.i = phi <2 x i64> [ %207, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.0.01462.i.i = phi <2 x i64> [ %212, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %18 = add nuw i32 %iter.sroa.0.01478.i.i, 1
  %19 = bitcast <2 x i64> %x.sroa.11.sroa.0.01466.i.i to <4 x i32>
  %20 = bitcast <2 x i64> %x.sroa.11.sroa.8.01465.i.i to <4 x i32>
  %21 = bitcast <2 x i64> %x.sroa.11.sroa.9.01464.i.i to <4 x i32>
  %22 = bitcast <2 x i64> %x.sroa.11.sroa.10.01463.i.i to <4 x i32>
  %23 = add <4 x i32> %14, %19
  %24 = bitcast <4 x i32> %23 to <2 x i64>
  %25 = add <4 x i32> %15, %20
  %26 = add <4 x i32> %16, %21
  %27 = add <4 x i32> %17, %22
  %28 = xor <2 x i64> %x.sroa.15.sroa.0.01470.i.i, %24
  %29 = xor <4 x i32> %25, %x.sroa.15.sroa.8.01471.i.i.in
  %30 = xor <4 x i32> %26, %x.sroa.15.sroa.9.01472.i.i.in
  %31 = xor <4 x i32> %27, %x.sroa.15.sroa.10.01473.i.i.in
  %32 = bitcast <2 x i64> %28 to <16 x i8>
  %33 = shufflevector <16 x i8> %32, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %34 = bitcast <16 x i8> %33 to <4 x i32>
  %35 = bitcast <4 x i32> %29 to <16 x i8>
  %36 = shufflevector <16 x i8> %35, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %37 = bitcast <4 x i32> %30 to <16 x i8>
  %38 = shufflevector <16 x i8> %37, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %39 = bitcast <4 x i32> %31 to <16 x i8>
  %40 = shufflevector <16 x i8> %39, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %41 = bitcast <16 x i8> %36 to <4 x i32>
  %42 = bitcast <16 x i8> %38 to <4 x i32>
  %43 = bitcast <16 x i8> %40 to <4 x i32>
  %44 = bitcast <2 x i64> %x.sroa.13.sroa.0.01462.i.i to <4 x i32>
  %45 = add <4 x i32> %34, %44
  %46 = bitcast <2 x i64> %x.sroa.13.sroa.8.01467.i.i to <4 x i32>
  %47 = add <4 x i32> %41, %46
  %48 = bitcast <2 x i64> %x.sroa.13.sroa.9.01468.i.i to <4 x i32>
  %49 = add <4 x i32> %42, %48
  %50 = bitcast <2 x i64> %x.sroa.13.sroa.10.01469.i.i to <4 x i32>
  %51 = add <4 x i32> %43, %50
  %52 = xor <4 x i32> %45, %19
  %53 = lshr <4 x i32> %52, <i32 20, i32 20, i32 20, i32 20>
  %54 = shl <4 x i32> %52, <i32 12, i32 12, i32 12, i32 12>
  %55 = or <4 x i32> %54, %53
  %56 = xor <4 x i32> %47, %20
  %57 = lshr <4 x i32> %56, <i32 20, i32 20, i32 20, i32 20>
  %58 = shl <4 x i32> %56, <i32 12, i32 12, i32 12, i32 12>
  %59 = or <4 x i32> %58, %57
  %60 = xor <4 x i32> %49, %21
  %61 = lshr <4 x i32> %60, <i32 20, i32 20, i32 20, i32 20>
  %62 = shl <4 x i32> %60, <i32 12, i32 12, i32 12, i32 12>
  %63 = or <4 x i32> %62, %61
  %64 = xor <4 x i32> %51, %22
  %65 = lshr <4 x i32> %64, <i32 20, i32 20, i32 20, i32 20>
  %66 = shl <4 x i32> %64, <i32 12, i32 12, i32 12, i32 12>
  %67 = or <4 x i32> %66, %65
  %68 = add <4 x i32> %55, %23
  %69 = add <4 x i32> %59, %25
  %70 = add <4 x i32> %63, %26
  %71 = add <4 x i32> %67, %27
  %72 = xor <4 x i32> %68, %34
  %73 = xor <4 x i32> %69, %41
  %74 = xor <4 x i32> %70, %42
  %75 = xor <4 x i32> %71, %43
  %76 = bitcast <4 x i32> %72 to <16 x i8>
  %77 = shufflevector <16 x i8> %76, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %78 = bitcast <16 x i8> %77 to <4 x i32>
  %79 = bitcast <4 x i32> %73 to <16 x i8>
  %80 = shufflevector <16 x i8> %79, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %81 = bitcast <4 x i32> %74 to <16 x i8>
  %82 = shufflevector <16 x i8> %81, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %83 = bitcast <4 x i32> %75 to <16 x i8>
  %84 = shufflevector <16 x i8> %83, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %85 = bitcast <16 x i8> %80 to <4 x i32>
  %86 = bitcast <16 x i8> %82 to <4 x i32>
  %87 = bitcast <16 x i8> %84 to <4 x i32>
  %88 = add <4 x i32> %45, %78
  %89 = add <4 x i32> %47, %85
  %90 = add <4 x i32> %49, %86
  %91 = add <4 x i32> %51, %87
  %92 = xor <4 x i32> %88, %55
  %93 = lshr <4 x i32> %92, <i32 25, i32 25, i32 25, i32 25>
  %94 = shl <4 x i32> %92, <i32 7, i32 7, i32 7, i32 7>
  %95 = or <4 x i32> %94, %93
  %96 = xor <4 x i32> %89, %59
  %97 = lshr <4 x i32> %96, <i32 25, i32 25, i32 25, i32 25>
  %98 = shl <4 x i32> %96, <i32 7, i32 7, i32 7, i32 7>
  %99 = or <4 x i32> %98, %97
  %100 = xor <4 x i32> %90, %63
  %101 = lshr <4 x i32> %100, <i32 25, i32 25, i32 25, i32 25>
  %102 = shl <4 x i32> %100, <i32 7, i32 7, i32 7, i32 7>
  %103 = or <4 x i32> %102, %101
  %104 = xor <4 x i32> %91, %67
  %105 = lshr <4 x i32> %104, <i32 25, i32 25, i32 25, i32 25>
  %106 = shl <4 x i32> %104, <i32 7, i32 7, i32 7, i32 7>
  %107 = or <4 x i32> %106, %105
  %108 = shufflevector <4 x i32> %95, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %109 = shufflevector <4 x i32> %99, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %110 = shufflevector <4 x i32> %103, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %111 = shufflevector <4 x i32> %107, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %112 = shufflevector <4 x i32> %88, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %113 = shufflevector <4 x i32> %89, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %114 = shufflevector <4 x i32> %90, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %115 = shufflevector <4 x i32> %91, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %116 = shufflevector <4 x i32> %78, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %117 = shufflevector <4 x i32> %85, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %118 = shufflevector <4 x i32> %86, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %119 = shufflevector <4 x i32> %87, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %120 = add <4 x i32> %108, %68
  %121 = add <4 x i32> %109, %69
  %122 = add <4 x i32> %110, %70
  %123 = add <4 x i32> %111, %71
  %124 = xor <4 x i32> %120, %116
  %125 = xor <4 x i32> %121, %117
  %126 = xor <4 x i32> %122, %118
  %127 = xor <4 x i32> %123, %119
  %128 = bitcast <4 x i32> %124 to <16 x i8>
  %129 = shufflevector <16 x i8> %128, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %130 = bitcast <16 x i8> %129 to <4 x i32>
  %131 = bitcast <4 x i32> %125 to <16 x i8>
  %132 = shufflevector <16 x i8> %131, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %133 = bitcast <4 x i32> %126 to <16 x i8>
  %134 = shufflevector <16 x i8> %133, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %135 = bitcast <4 x i32> %127 to <16 x i8>
  %136 = shufflevector <16 x i8> %135, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %137 = bitcast <16 x i8> %132 to <4 x i32>
  %138 = bitcast <16 x i8> %134 to <4 x i32>
  %139 = bitcast <16 x i8> %136 to <4 x i32>
  %140 = add <4 x i32> %112, %130
  %141 = add <4 x i32> %113, %137
  %142 = add <4 x i32> %114, %138
  %143 = add <4 x i32> %115, %139
  %144 = xor <4 x i32> %140, %108
  %145 = lshr <4 x i32> %144, <i32 20, i32 20, i32 20, i32 20>
  %146 = shl <4 x i32> %144, <i32 12, i32 12, i32 12, i32 12>
  %147 = or <4 x i32> %146, %145
  %148 = xor <4 x i32> %141, %109
  %149 = lshr <4 x i32> %148, <i32 20, i32 20, i32 20, i32 20>
  %150 = shl <4 x i32> %148, <i32 12, i32 12, i32 12, i32 12>
  %151 = or <4 x i32> %150, %149
  %152 = xor <4 x i32> %142, %110
  %153 = lshr <4 x i32> %152, <i32 20, i32 20, i32 20, i32 20>
  %154 = shl <4 x i32> %152, <i32 12, i32 12, i32 12, i32 12>
  %155 = or <4 x i32> %154, %153
  %156 = xor <4 x i32> %143, %111
  %157 = lshr <4 x i32> %156, <i32 20, i32 20, i32 20, i32 20>
  %158 = shl <4 x i32> %156, <i32 12, i32 12, i32 12, i32 12>
  %159 = or <4 x i32> %158, %157
  %160 = add <4 x i32> %147, %120
  %161 = add <4 x i32> %151, %121
  %162 = add <4 x i32> %155, %122
  %163 = add <4 x i32> %159, %123
  %164 = xor <4 x i32> %160, %130
  %165 = xor <4 x i32> %161, %137
  %166 = xor <4 x i32> %162, %138
  %167 = xor <4 x i32> %163, %139
  %168 = bitcast <4 x i32> %164 to <16 x i8>
  %169 = shufflevector <16 x i8> %168, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %170 = bitcast <16 x i8> %169 to <4 x i32>
  %171 = bitcast <4 x i32> %165 to <16 x i8>
  %172 = shufflevector <16 x i8> %171, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %173 = bitcast <4 x i32> %166 to <16 x i8>
  %174 = shufflevector <16 x i8> %173, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %175 = bitcast <4 x i32> %167 to <16 x i8>
  %176 = shufflevector <16 x i8> %175, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %177 = bitcast <16 x i8> %172 to <4 x i32>
  %178 = bitcast <16 x i8> %174 to <4 x i32>
  %179 = bitcast <16 x i8> %176 to <4 x i32>
  %180 = add <4 x i32> %140, %170
  %181 = add <4 x i32> %141, %177
  %182 = add <4 x i32> %142, %178
  %183 = add <4 x i32> %143, %179
  %184 = xor <4 x i32> %180, %147
  %185 = lshr <4 x i32> %184, <i32 25, i32 25, i32 25, i32 25>
  %186 = shl <4 x i32> %184, <i32 7, i32 7, i32 7, i32 7>
  %187 = or <4 x i32> %186, %185
  %188 = xor <4 x i32> %181, %151
  %189 = lshr <4 x i32> %188, <i32 25, i32 25, i32 25, i32 25>
  %190 = shl <4 x i32> %188, <i32 7, i32 7, i32 7, i32 7>
  %191 = or <4 x i32> %190, %189
  %192 = xor <4 x i32> %182, %155
  %193 = lshr <4 x i32> %192, <i32 25, i32 25, i32 25, i32 25>
  %194 = shl <4 x i32> %192, <i32 7, i32 7, i32 7, i32 7>
  %195 = or <4 x i32> %194, %193
  %196 = xor <4 x i32> %183, %159
  %197 = lshr <4 x i32> %196, <i32 25, i32 25, i32 25, i32 25>
  %198 = shl <4 x i32> %196, <i32 7, i32 7, i32 7, i32 7>
  %199 = or <4 x i32> %198, %197
  %200 = shufflevector <4 x i32> %187, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %201 = shufflevector <4 x i32> %191, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %202 = shufflevector <4 x i32> %195, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %203 = shufflevector <4 x i32> %199, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %204 = bitcast <4 x i32> %200 to <2 x i64>
  %205 = bitcast <4 x i32> %201 to <2 x i64>
  %206 = bitcast <4 x i32> %202 to <2 x i64>
  %207 = bitcast <4 x i32> %203 to <2 x i64>
  %208 = shufflevector <4 x i32> %180, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %209 = shufflevector <4 x i32> %181, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %210 = shufflevector <4 x i32> %182, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %211 = shufflevector <4 x i32> %183, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %212 = bitcast <4 x i32> %208 to <2 x i64>
  %213 = bitcast <4 x i32> %209 to <2 x i64>
  %214 = bitcast <4 x i32> %210 to <2 x i64>
  %215 = bitcast <4 x i32> %211 to <2 x i64>
  %216 = shufflevector <4 x i32> %170, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %217 = shufflevector <4 x i32> %177, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %218 = shufflevector <4 x i32> %178, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %219 = shufflevector <4 x i32> %179, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %220 = bitcast <4 x i32> %216 to <2 x i64>
  %exitcond.not.i.i = icmp eq i32 %18, %drounds
  br i1 %exitcond.not.i.i, label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit, label %bb26.i.i

_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit: ; preds = %bb26.i.i
  %221 = bitcast <4 x i32> %200 to <2 x i64>
  %222 = bitcast <4 x i32> %201 to <2 x i64>
  %223 = bitcast <4 x i32> %202 to <2 x i64>
  %224 = bitcast <4 x i32> %203 to <2 x i64>
  %225 = bitcast <4 x i32> %208 to <2 x i64>
  %226 = bitcast <4 x i32> %209 to <2 x i64>
  %227 = bitcast <4 x i32> %210 to <2 x i64>
  %228 = bitcast <4 x i32> %211 to <2 x i64>
  %phi.bo = add <4 x i32> %160, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo314 = add <4 x i32> %161, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo315 = add <4 x i32> %162, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo316 = add <4 x i32> %163, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %.phi.trans.insert = bitcast %"guts::ChaCha"* %state to <4 x i32>*
  %_156.sroa.0.0.copyload1448.i.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert, align 16
  %.phi.trans.insert333 = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i to <4 x i32>*
  %_159.sroa.0.0.copyload1449.i.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert333, align 16
  %.phi.trans.insert335 = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <4 x i32>*
  %_163.sroa.0.0.copyload.i21.i.pre = load <4 x i32>, <4 x i32>* %.phi.trans.insert335, align 16
  br label %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit

_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit: ; preds = %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge
  %.pre-phi342 = phi <4 x i32>* [ %.pre341, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %.phi.trans.insert335, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %.pre-phi = phi <4 x i32> [ %2, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %216, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %_163.sroa.0.0.copyload.i21.i = phi <4 x i32> [ %11, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %_163.sroa.0.0.copyload.i21.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %_159.sroa.0.0.copyload1449.i.i = phi <4 x i32> [ %12, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %_159.sroa.0.0.copyload1449.i.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %_156.sroa.0.0.copyload1448.i.i = phi <4 x i32> [ %13, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %_156.sroa.0.0.copyload1448.i.i.pre, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.13.sroa.0.0.lcssa.i.i = phi <2 x i64> [ %_49.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %225, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.11.sroa.10.0.lcssa.i.i = phi <2 x i64> [ %_46.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %224, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.11.sroa.9.0.lcssa.i.i = phi <2 x i64> [ %_46.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %223, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.11.sroa.8.0.lcssa.i.i = phi <2 x i64> [ %_46.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %222, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.11.sroa.0.0.lcssa.i.i = phi <2 x i64> [ %_46.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %221, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.13.sroa.8.0.lcssa.i.i = phi <2 x i64> [ %_49.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %226, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.13.sroa.9.0.lcssa.i.i = phi <2 x i64> [ %_49.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %227, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %x.sroa.13.sroa.10.0.lcssa.i.i = phi <2 x i64> [ %_49.sroa.0.0.copyload.i.i, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %228, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %229 = phi <4 x i32> [ %4, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %217, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %230 = phi <4 x i32> [ %7, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %218, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %231 = phi <4 x i32> [ %10, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %219, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %232 = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %phi.bo316, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %233 = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %phi.bo315, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %234 = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %phi.bo314, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %235 = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit_crit_edge ], [ %phi.bo, %_ZN11rand_chacha4guts11refill_wide7fn_impl17h0770db8e4af0d77aE.exit.loopexit ]
  %236 = add i64 %0, 4
  %_137.i.i = lshr i64 %236, 32
  %_136.i.i = trunc i64 %_137.i.i to i32
  %237 = insertelement <4 x i32> %2, i32 %_136.i.i, i32 1
  %_139.i.i = trunc i64 %236 to i32
  %238 = insertelement <4 x i32> %237, i32 %_139.i.i, i32 0
  store <4 x i32> %238, <4 x i32>* %.pre-phi342, align 16
  %239 = bitcast <2 x i64> %x.sroa.11.sroa.0.0.lcssa.i.i to <4 x i32>
  %240 = bitcast <2 x i64> %x.sroa.13.sroa.0.0.lcssa.i.i to <4 x i32>
  %241 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 16
  %242 = bitcast [256 x i8]* %out to <4 x i32>*
  store <4 x i32> %235, <4 x i32>* %242, align 1, !noalias !314
  %243 = add <4 x i32> %_156.sroa.0.0.copyload1448.i.i, %239
  %244 = bitcast i8* %241 to <4 x i32>*
  store <4 x i32> %243, <4 x i32>* %244, align 1, !noalias !317
  %245 = add <4 x i32> %_159.sroa.0.0.copyload1449.i.i, %240
  %246 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 32
  %247 = bitcast i8* %246 to <4 x i32>*
  store <4 x i32> %245, <4 x i32>* %247, align 1, !noalias !320
  %248 = add <4 x i32> %_163.sroa.0.0.copyload.i21.i, %.pre-phi
  %249 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 48
  %250 = bitcast i8* %249 to <4 x i32>*
  store <4 x i32> %248, <4 x i32>* %250, align 1, !noalias !323
  %251 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 64
  %252 = bitcast <2 x i64> %x.sroa.13.sroa.8.0.lcssa.i.i to <4 x i32>
  %253 = bitcast <2 x i64> %x.sroa.11.sroa.8.0.lcssa.i.i to <4 x i32>
  %254 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 80
  %255 = bitcast i8* %251 to <4 x i32>*
  store <4 x i32> %234, <4 x i32>* %255, align 1, !noalias !314
  %256 = add <4 x i32> %_156.sroa.0.0.copyload1448.i.i, %253
  %257 = bitcast i8* %254 to <4 x i32>*
  store <4 x i32> %256, <4 x i32>* %257, align 1, !noalias !317
  %258 = add <4 x i32> %_159.sroa.0.0.copyload1449.i.i, %252
  %259 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 96
  %260 = bitcast i8* %259 to <4 x i32>*
  store <4 x i32> %258, <4 x i32>* %260, align 1, !noalias !320
  %261 = add <4 x i32> %229, %4
  %262 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 112
  %263 = bitcast i8* %262 to <4 x i32>*
  store <4 x i32> %261, <4 x i32>* %263, align 1, !noalias !323
  %264 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 128
  %265 = bitcast <2 x i64> %x.sroa.13.sroa.9.0.lcssa.i.i to <4 x i32>
  %266 = bitcast <2 x i64> %x.sroa.11.sroa.9.0.lcssa.i.i to <4 x i32>
  %267 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 144
  %268 = bitcast i8* %264 to <4 x i32>*
  store <4 x i32> %233, <4 x i32>* %268, align 1, !noalias !314
  %269 = add <4 x i32> %_156.sroa.0.0.copyload1448.i.i, %266
  %270 = bitcast i8* %267 to <4 x i32>*
  store <4 x i32> %269, <4 x i32>* %270, align 1, !noalias !317
  %271 = add <4 x i32> %_159.sroa.0.0.copyload1449.i.i, %265
  %272 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 160
  %273 = bitcast i8* %272 to <4 x i32>*
  store <4 x i32> %271, <4 x i32>* %273, align 1, !noalias !320
  %274 = add <4 x i32> %230, %7
  %275 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 176
  %276 = bitcast i8* %275 to <4 x i32>*
  store <4 x i32> %274, <4 x i32>* %276, align 1, !noalias !323
  %277 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 192
  %278 = bitcast <2 x i64> %x.sroa.13.sroa.10.0.lcssa.i.i to <4 x i32>
  %279 = bitcast <2 x i64> %x.sroa.11.sroa.10.0.lcssa.i.i to <4 x i32>
  %280 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 208
  %281 = bitcast i8* %277 to <4 x i32>*
  store <4 x i32> %232, <4 x i32>* %281, align 1, !noalias !314
  %282 = add <4 x i32> %_156.sroa.0.0.copyload1448.i.i, %279
  %283 = bitcast i8* %280 to <4 x i32>*
  store <4 x i32> %282, <4 x i32>* %283, align 1, !noalias !317
  %284 = add <4 x i32> %_159.sroa.0.0.copyload1449.i.i, %278
  %285 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 224
  %286 = bitcast i8* %285 to <4 x i32>*
  store <4 x i32> %284, <4 x i32>* %286, align 1, !noalias !320
  %287 = add <4 x i32> %231, %10
  %288 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 240
  %289 = bitcast i8* %288 to <4 x i32>*
  store <4 x i32> %287, <4 x i32>* %289, align 1, !noalias !323
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @_ZN11rand_chacha4guts11refill_wide10impl_ssse317hd134e0c870da37d7E(%"guts::ChaCha"* nocapture align 16 dereferenceable(48) %state, i32 %drounds, [256 x i8]* nocapture align 1 dereferenceable(256) %out) unnamed_addr #7 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_5.sroa.0.0..sroa_idx.i.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_5.sroa.0.0..sroa_cast.i.i.i = bitcast %"ppv_lite86::vec128_storage"* %_5.sroa.0.0..sroa_idx.i.i.i to <2 x i64>*
  %_5.sroa.0.0.copyload.i.i.i = load <2 x i64>, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i.i, align 16, !alias.scope !326
  %0 = extractelement <2 x i64> %_5.sroa.0.0.copyload.i.i.i, i32 0
  %1 = add i64 %0, 1
  %_20.i.i = lshr i64 %1, 32
  %_19.i.i = trunc i64 %_20.i.i to i32
  %2 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <4 x i32>
  %3 = bitcast <2 x i64> %_5.sroa.0.0.copyload.i.i.i to <16 x i8>
  %4 = shufflevector <16 x i8> %3, <16 x i8> undef, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef>
  %5 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %4, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_19.i.i, i32 0
  %6 = bitcast <16 x i8> %5 to <4 x i32>
  %7 = or <4 x i32> %.12.vec.insert.i13.i.i.i, %6
  %8 = shufflevector <4 x i32> %7, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %9 = bitcast <4 x i32> %8 to <2 x i64>
  %_22.i.i = trunc i64 %1 to i32
  %10 = and <2 x i64> %9, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_22.i.i, i32 0
  %11 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i to <2 x i64>
  %12 = or <2 x i64> %10, %11
  %13 = add i64 %0, 2
  %_30.i.i = lshr i64 %13, 32
  %_29.i.i = trunc i64 %_30.i.i to i32
  %.12.vec.insert.i13.i166.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_29.i.i, i32 0
  %14 = or <4 x i32> %.12.vec.insert.i13.i166.i.i, %6
  %15 = shufflevector <4 x i32> %14, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %16 = bitcast <4 x i32> %15 to <2 x i64>
  %_32.i.i = trunc i64 %13 to i32
  %17 = and <2 x i64> %16, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i170.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_32.i.i, i32 0
  %18 = bitcast <4 x i32> %.12.vec.insert.i18.i170.i.i to <2 x i64>
  %19 = or <2 x i64> %17, %18
  %20 = add i64 %0, 3
  %_40.i.i = lshr i64 %20, 32
  %_39.i.i = trunc i64 %_40.i.i to i32
  %.12.vec.insert.i13.i196.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_39.i.i, i32 0
  %21 = or <4 x i32> %.12.vec.insert.i13.i196.i.i, %6
  %22 = shufflevector <4 x i32> %21, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %23 = bitcast <4 x i32> %22 to <2 x i64>
  %_42.i.i = trunc i64 %20 to i32
  %24 = and <2 x i64> %23, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i197.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_42.i.i, i32 0
  %25 = bitcast <4 x i32> %.12.vec.insert.i18.i197.i.i to <2 x i64>
  %26 = or <2 x i64> %24, %25
  %_46.sroa.0.0..sroa_cast.i.i = bitcast %"guts::ChaCha"* %state to <2 x i64>*
  %_46.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_46.sroa.0.0..sroa_cast.i.i, align 16
  %_49.sroa.0.0..sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 3
  %_49.sroa.0.0..sroa_cast.i.i = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i to <2 x i64>*
  %_49.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_49.sroa.0.0..sroa_cast.i.i, align 16
  %.not.i.i = icmp eq i32 %drounds, 0
  br i1 %.not.i.i, label %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i, label %bb26.i.i

start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i: ; preds = %start
  %27 = bitcast <2 x i64> %_49.sroa.0.0.copyload.i.i to <4 x i32>
  %28 = bitcast <2 x i64> %_46.sroa.0.0.copyload.i.i to <4 x i32>
  br label %_ZN11rand_chacha4guts11refill_wide7fn_impl17he6e7751bcf722e1aE.exit

bb22.bb24_crit_edge.i.i:                          ; preds = %bb26.i.i
  %29 = bitcast <4 x i32> %238 to <2 x i64>
  %30 = bitcast <4 x i32> %239 to <2 x i64>
  %31 = bitcast <4 x i32> %240 to <2 x i64>
  %phi.bo.i = add <4 x i32> %181, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo21.i = add <4 x i32> %182, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo22.i = add <4 x i32> %183, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %phi.bo23.i = add <4 x i32> %184, <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>
  %.phi.trans.insert.i = bitcast %"guts::ChaCha"* %state to <4 x i32>*
  %_156.sroa.0.0.copyload1449.i.pre.i = load <4 x i32>, <4 x i32>* %.phi.trans.insert.i, align 16
  %.phi.trans.insert66.i = bitcast %"ppv_lite86::vec128_storage"* %_49.sroa.0.0..sroa_idx.i.i to <4 x i32>*
  %_159.sroa.0.0.copyload1450.i.pre.i = load <4 x i32>, <4 x i32>* %.phi.trans.insert66.i, align 16
  br label %_ZN11rand_chacha4guts11refill_wide7fn_impl17he6e7751bcf722e1aE.exit

bb26.i.i:                                         ; preds = %bb26.i.i, %start
  %iter.sroa.0.01478.i.i = phi i32 [ %36, %bb26.i.i ], [ 0, %start ]
  %32 = phi <4 x i32> [ %181, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %33 = phi <4 x i32> [ %182, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %34 = phi <4 x i32> [ %183, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %35 = phi <4 x i32> [ %184, %bb26.i.i ], [ <i32 1634760805, i32 857760878, i32 2036477234, i32 1797285236>, %start ]
  %x.sroa.15.sroa.10.01477.i.i = phi <2 x i64> [ %244, %bb26.i.i ], [ %26, %start ]
  %x.sroa.15.sroa.9.01476.i.i = phi <2 x i64> [ %243, %bb26.i.i ], [ %19, %start ]
  %x.sroa.15.sroa.8.01475.i.i = phi <2 x i64> [ %242, %bb26.i.i ], [ %12, %start ]
  %x.sroa.15.sroa.0.01474.i.i = phi <2 x i64> [ %241, %bb26.i.i ], [ %_5.sroa.0.0.copyload.i.i.i, %start ]
  %x.sroa.13.sroa.10.01473.i.i = phi <2 x i64> [ %236, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.9.01472.i.i = phi <2 x i64> [ %235, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.8.01471.i.i = phi <2 x i64> [ %234, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.0.01470.i.i = phi <2 x i64> [ %225, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.8.01469.i.i = phi <2 x i64> [ %226, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.9.01468.i.i = phi <2 x i64> [ %227, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.11.sroa.10.01467.i.i = phi <2 x i64> [ %228, %bb26.i.i ], [ %_46.sroa.0.0.copyload.i.i, %start ]
  %x.sroa.13.sroa.0.01466.i.i = phi <2 x i64> [ %233, %bb26.i.i ], [ %_49.sroa.0.0.copyload.i.i, %start ]
  %36 = add nuw i32 %iter.sroa.0.01478.i.i, 1
  %37 = bitcast <2 x i64> %x.sroa.11.sroa.0.01470.i.i to <4 x i32>
  %38 = bitcast <2 x i64> %x.sroa.11.sroa.8.01469.i.i to <4 x i32>
  %39 = bitcast <2 x i64> %x.sroa.11.sroa.9.01468.i.i to <4 x i32>
  %40 = bitcast <2 x i64> %x.sroa.11.sroa.10.01467.i.i to <4 x i32>
  %41 = add <4 x i32> %32, %37
  %42 = bitcast <4 x i32> %41 to <2 x i64>
  %43 = add <4 x i32> %33, %38
  %44 = bitcast <4 x i32> %43 to <2 x i64>
  %45 = add <4 x i32> %34, %39
  %46 = bitcast <4 x i32> %45 to <2 x i64>
  %47 = add <4 x i32> %35, %40
  %48 = bitcast <4 x i32> %47 to <2 x i64>
  %49 = xor <2 x i64> %x.sroa.15.sroa.0.01474.i.i, %42
  %50 = xor <2 x i64> %x.sroa.15.sroa.8.01475.i.i, %44
  %51 = xor <2 x i64> %x.sroa.15.sroa.9.01476.i.i, %46
  %52 = xor <2 x i64> %x.sroa.15.sroa.10.01477.i.i, %48
  %53 = bitcast <2 x i64> %49 to <16 x i8>
  %54 = shufflevector <16 x i8> %53, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %55 = bitcast <16 x i8> %54 to <4 x i32>
  %56 = bitcast <2 x i64> %50 to <16 x i8>
  %57 = shufflevector <16 x i8> %56, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %58 = bitcast <2 x i64> %51 to <16 x i8>
  %59 = shufflevector <16 x i8> %58, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %60 = bitcast <2 x i64> %52 to <16 x i8>
  %61 = shufflevector <16 x i8> %60, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %62 = bitcast <16 x i8> %57 to <4 x i32>
  %63 = bitcast <16 x i8> %59 to <4 x i32>
  %64 = bitcast <16 x i8> %61 to <4 x i32>
  %65 = bitcast <2 x i64> %x.sroa.13.sroa.0.01466.i.i to <4 x i32>
  %66 = add <4 x i32> %55, %65
  %67 = bitcast <2 x i64> %x.sroa.13.sroa.8.01471.i.i to <4 x i32>
  %68 = add <4 x i32> %62, %67
  %69 = bitcast <2 x i64> %x.sroa.13.sroa.9.01472.i.i to <4 x i32>
  %70 = add <4 x i32> %63, %69
  %71 = bitcast <2 x i64> %x.sroa.13.sroa.10.01473.i.i to <4 x i32>
  %72 = add <4 x i32> %64, %71
  %73 = xor <4 x i32> %66, %37
  %74 = lshr <4 x i32> %73, <i32 20, i32 20, i32 20, i32 20>
  %75 = shl <4 x i32> %73, <i32 12, i32 12, i32 12, i32 12>
  %76 = or <4 x i32> %75, %74
  %77 = xor <4 x i32> %68, %38
  %78 = lshr <4 x i32> %77, <i32 20, i32 20, i32 20, i32 20>
  %79 = shl <4 x i32> %77, <i32 12, i32 12, i32 12, i32 12>
  %80 = or <4 x i32> %79, %78
  %81 = xor <4 x i32> %70, %39
  %82 = lshr <4 x i32> %81, <i32 20, i32 20, i32 20, i32 20>
  %83 = shl <4 x i32> %81, <i32 12, i32 12, i32 12, i32 12>
  %84 = or <4 x i32> %83, %82
  %85 = xor <4 x i32> %72, %40
  %86 = lshr <4 x i32> %85, <i32 20, i32 20, i32 20, i32 20>
  %87 = shl <4 x i32> %85, <i32 12, i32 12, i32 12, i32 12>
  %88 = or <4 x i32> %87, %86
  %89 = add <4 x i32> %76, %41
  %90 = add <4 x i32> %80, %43
  %91 = add <4 x i32> %84, %45
  %92 = add <4 x i32> %88, %47
  %93 = xor <4 x i32> %89, %55
  %94 = xor <4 x i32> %90, %62
  %95 = xor <4 x i32> %91, %63
  %96 = xor <4 x i32> %92, %64
  %97 = bitcast <4 x i32> %93 to <16 x i8>
  %98 = shufflevector <16 x i8> %97, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %99 = bitcast <16 x i8> %98 to <4 x i32>
  %100 = bitcast <4 x i32> %94 to <16 x i8>
  %101 = shufflevector <16 x i8> %100, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %102 = bitcast <4 x i32> %95 to <16 x i8>
  %103 = shufflevector <16 x i8> %102, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %104 = bitcast <4 x i32> %96 to <16 x i8>
  %105 = shufflevector <16 x i8> %104, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %106 = bitcast <16 x i8> %101 to <4 x i32>
  %107 = bitcast <16 x i8> %103 to <4 x i32>
  %108 = bitcast <16 x i8> %105 to <4 x i32>
  %109 = add <4 x i32> %66, %99
  %110 = add <4 x i32> %68, %106
  %111 = add <4 x i32> %70, %107
  %112 = add <4 x i32> %72, %108
  %113 = xor <4 x i32> %109, %76
  %114 = lshr <4 x i32> %113, <i32 25, i32 25, i32 25, i32 25>
  %115 = shl <4 x i32> %113, <i32 7, i32 7, i32 7, i32 7>
  %116 = or <4 x i32> %115, %114
  %117 = xor <4 x i32> %110, %80
  %118 = lshr <4 x i32> %117, <i32 25, i32 25, i32 25, i32 25>
  %119 = shl <4 x i32> %117, <i32 7, i32 7, i32 7, i32 7>
  %120 = or <4 x i32> %119, %118
  %121 = xor <4 x i32> %111, %84
  %122 = lshr <4 x i32> %121, <i32 25, i32 25, i32 25, i32 25>
  %123 = shl <4 x i32> %121, <i32 7, i32 7, i32 7, i32 7>
  %124 = or <4 x i32> %123, %122
  %125 = xor <4 x i32> %112, %88
  %126 = lshr <4 x i32> %125, <i32 25, i32 25, i32 25, i32 25>
  %127 = shl <4 x i32> %125, <i32 7, i32 7, i32 7, i32 7>
  %128 = or <4 x i32> %127, %126
  %129 = shufflevector <4 x i32> %116, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %130 = shufflevector <4 x i32> %120, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %131 = shufflevector <4 x i32> %124, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %132 = shufflevector <4 x i32> %128, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %133 = shufflevector <4 x i32> %109, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %134 = shufflevector <4 x i32> %110, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %135 = shufflevector <4 x i32> %111, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %136 = shufflevector <4 x i32> %112, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %137 = shufflevector <4 x i32> %99, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %138 = shufflevector <4 x i32> %106, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %139 = shufflevector <4 x i32> %107, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %140 = shufflevector <4 x i32> %108, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %141 = add <4 x i32> %129, %89
  %142 = add <4 x i32> %130, %90
  %143 = add <4 x i32> %131, %91
  %144 = add <4 x i32> %132, %92
  %145 = xor <4 x i32> %141, %137
  %146 = xor <4 x i32> %142, %138
  %147 = xor <4 x i32> %143, %139
  %148 = xor <4 x i32> %144, %140
  %149 = bitcast <4 x i32> %145 to <16 x i8>
  %150 = shufflevector <16 x i8> %149, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %151 = bitcast <16 x i8> %150 to <4 x i32>
  %152 = bitcast <4 x i32> %146 to <16 x i8>
  %153 = shufflevector <16 x i8> %152, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %154 = bitcast <4 x i32> %147 to <16 x i8>
  %155 = shufflevector <16 x i8> %154, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %156 = bitcast <4 x i32> %148 to <16 x i8>
  %157 = shufflevector <16 x i8> %156, <16 x i8> undef, <16 x i32> <i32 2, i32 3, i32 0, i32 1, i32 6, i32 7, i32 4, i32 5, i32 10, i32 11, i32 8, i32 9, i32 14, i32 15, i32 12, i32 13>
  %158 = bitcast <16 x i8> %153 to <4 x i32>
  %159 = bitcast <16 x i8> %155 to <4 x i32>
  %160 = bitcast <16 x i8> %157 to <4 x i32>
  %161 = add <4 x i32> %133, %151
  %162 = add <4 x i32> %134, %158
  %163 = add <4 x i32> %135, %159
  %164 = add <4 x i32> %136, %160
  %165 = xor <4 x i32> %161, %129
  %166 = lshr <4 x i32> %165, <i32 20, i32 20, i32 20, i32 20>
  %167 = shl <4 x i32> %165, <i32 12, i32 12, i32 12, i32 12>
  %168 = or <4 x i32> %167, %166
  %169 = xor <4 x i32> %162, %130
  %170 = lshr <4 x i32> %169, <i32 20, i32 20, i32 20, i32 20>
  %171 = shl <4 x i32> %169, <i32 12, i32 12, i32 12, i32 12>
  %172 = or <4 x i32> %171, %170
  %173 = xor <4 x i32> %163, %131
  %174 = lshr <4 x i32> %173, <i32 20, i32 20, i32 20, i32 20>
  %175 = shl <4 x i32> %173, <i32 12, i32 12, i32 12, i32 12>
  %176 = or <4 x i32> %175, %174
  %177 = xor <4 x i32> %164, %132
  %178 = lshr <4 x i32> %177, <i32 20, i32 20, i32 20, i32 20>
  %179 = shl <4 x i32> %177, <i32 12, i32 12, i32 12, i32 12>
  %180 = or <4 x i32> %179, %178
  %181 = add <4 x i32> %168, %141
  %182 = add <4 x i32> %172, %142
  %183 = add <4 x i32> %176, %143
  %184 = add <4 x i32> %180, %144
  %185 = xor <4 x i32> %181, %151
  %186 = xor <4 x i32> %182, %158
  %187 = xor <4 x i32> %183, %159
  %188 = xor <4 x i32> %184, %160
  %189 = bitcast <4 x i32> %185 to <16 x i8>
  %190 = shufflevector <16 x i8> %189, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %191 = bitcast <16 x i8> %190 to <4 x i32>
  %192 = bitcast <4 x i32> %186 to <16 x i8>
  %193 = shufflevector <16 x i8> %192, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %194 = bitcast <4 x i32> %187 to <16 x i8>
  %195 = shufflevector <16 x i8> %194, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %196 = bitcast <4 x i32> %188 to <16 x i8>
  %197 = shufflevector <16 x i8> %196, <16 x i8> undef, <16 x i32> <i32 3, i32 0, i32 1, i32 2, i32 7, i32 4, i32 5, i32 6, i32 11, i32 8, i32 9, i32 10, i32 15, i32 12, i32 13, i32 14>
  %198 = bitcast <16 x i8> %193 to <4 x i32>
  %199 = bitcast <16 x i8> %195 to <4 x i32>
  %200 = bitcast <16 x i8> %197 to <4 x i32>
  %201 = add <4 x i32> %161, %191
  %202 = add <4 x i32> %162, %198
  %203 = add <4 x i32> %163, %199
  %204 = add <4 x i32> %164, %200
  %205 = xor <4 x i32> %201, %168
  %206 = lshr <4 x i32> %205, <i32 25, i32 25, i32 25, i32 25>
  %207 = shl <4 x i32> %205, <i32 7, i32 7, i32 7, i32 7>
  %208 = or <4 x i32> %207, %206
  %209 = xor <4 x i32> %202, %172
  %210 = lshr <4 x i32> %209, <i32 25, i32 25, i32 25, i32 25>
  %211 = shl <4 x i32> %209, <i32 7, i32 7, i32 7, i32 7>
  %212 = or <4 x i32> %211, %210
  %213 = xor <4 x i32> %203, %176
  %214 = lshr <4 x i32> %213, <i32 25, i32 25, i32 25, i32 25>
  %215 = shl <4 x i32> %213, <i32 7, i32 7, i32 7, i32 7>
  %216 = or <4 x i32> %215, %214
  %217 = xor <4 x i32> %204, %180
  %218 = lshr <4 x i32> %217, <i32 25, i32 25, i32 25, i32 25>
  %219 = shl <4 x i32> %217, <i32 7, i32 7, i32 7, i32 7>
  %220 = or <4 x i32> %219, %218
  %221 = shufflevector <4 x i32> %208, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %222 = shufflevector <4 x i32> %212, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %223 = shufflevector <4 x i32> %216, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %224 = shufflevector <4 x i32> %220, <4 x i32> undef, <4 x i32> <i32 3, i32 0, i32 1, i32 2>
  %225 = bitcast <4 x i32> %221 to <2 x i64>
  %226 = bitcast <4 x i32> %222 to <2 x i64>
  %227 = bitcast <4 x i32> %223 to <2 x i64>
  %228 = bitcast <4 x i32> %224 to <2 x i64>
  %229 = shufflevector <4 x i32> %201, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %230 = shufflevector <4 x i32> %202, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %231 = shufflevector <4 x i32> %203, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %232 = shufflevector <4 x i32> %204, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 0, i32 1>
  %233 = bitcast <4 x i32> %229 to <2 x i64>
  %234 = bitcast <4 x i32> %230 to <2 x i64>
  %235 = bitcast <4 x i32> %231 to <2 x i64>
  %236 = bitcast <4 x i32> %232 to <2 x i64>
  %237 = shufflevector <4 x i32> %191, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %238 = shufflevector <4 x i32> %198, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %239 = shufflevector <4 x i32> %199, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %240 = shufflevector <4 x i32> %200, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  %241 = bitcast <4 x i32> %237 to <2 x i64>
  %242 = bitcast <4 x i32> %238 to <2 x i64>
  %243 = bitcast <4 x i32> %239 to <2 x i64>
  %244 = bitcast <4 x i32> %240 to <2 x i64>
  %exitcond.not.i.i = icmp eq i32 %36, %drounds
  br i1 %exitcond.not.i.i, label %bb22.bb24_crit_edge.i.i, label %bb26.i.i

_ZN11rand_chacha4guts11refill_wide7fn_impl17he6e7751bcf722e1aE.exit: ; preds = %bb22.bb24_crit_edge.i.i, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i
  %.pre-phi259 = phi <4 x i32> [ %28, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %224, %bb22.bb24_crit_edge.i.i ]
  %.pre-phi257 = phi <4 x i32> [ %27, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %232, %bb22.bb24_crit_edge.i.i ]
  %.pre-phi255 = phi <4 x i32> [ %28, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %223, %bb22.bb24_crit_edge.i.i ]
  %.pre-phi253 = phi <4 x i32> [ %27, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %231, %bb22.bb24_crit_edge.i.i ]
  %.pre-phi251 = phi <4 x i32> [ %28, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %222, %bb22.bb24_crit_edge.i.i ]
  %.pre-phi249 = phi <4 x i32> [ %27, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %230, %bb22.bb24_crit_edge.i.i ]
  %.pre-phi247 = phi <4 x i32> [ %27, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %229, %bb22.bb24_crit_edge.i.i ]
  %.pre-phi = phi <4 x i32> [ %28, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %221, %bb22.bb24_crit_edge.i.i ]
  %.pre-phi.i = phi <4 x i32> [ %2, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %237, %bb22.bb24_crit_edge.i.i ]
  %_159.sroa.0.0.copyload1450.i.i = phi <4 x i32> [ %27, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %_159.sroa.0.0.copyload1450.i.pre.i, %bb22.bb24_crit_edge.i.i ]
  %_156.sroa.0.0.copyload1449.i.i = phi <4 x i32> [ %28, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %_156.sroa.0.0.copyload1449.i.pre.i, %bb22.bb24_crit_edge.i.i ]
  %x.sroa.15.sroa.8.0.lcssa.i.i = phi <2 x i64> [ %12, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %29, %bb22.bb24_crit_edge.i.i ]
  %x.sroa.15.sroa.9.0.lcssa.i.i = phi <2 x i64> [ %19, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %30, %bb22.bb24_crit_edge.i.i ]
  %x.sroa.15.sroa.10.0.lcssa.i.i = phi <2 x i64> [ %26, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %31, %bb22.bb24_crit_edge.i.i ]
  %.lcssa1462.i.i = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %phi.bo23.i, %bb22.bb24_crit_edge.i.i ]
  %.lcssa1461.i.i = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %phi.bo22.i, %bb22.bb24_crit_edge.i.i ]
  %.lcssa1460.i.i = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %phi.bo21.i, %bb22.bb24_crit_edge.i.i ]
  %a101451.i.i = phi <4 x i32> [ <i32 -1025445686, i32 1715521756, i32 -222012828, i32 -700396824>, %start._ZN11rand_chacha4guts16refill_wide_impl17ha3539215d689c26fE.exit_crit_edge.i ], [ %phi.bo.i, %bb22.bb24_crit_edge.i.i ]
  %245 = add i64 %0, 4
  %_137.i.i = lshr i64 %245, 32
  %_136.i.i = trunc i64 %_137.i.i to i32
  %.12.vec.insert.i13.i350.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_136.i.i, i32 0
  %246 = or <4 x i32> %.12.vec.insert.i13.i350.i.i, %6
  %247 = shufflevector <4 x i32> %246, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  %248 = bitcast <4 x i32> %247 to <2 x i64>
  %_139.i.i = trunc i64 %245 to i32
  %249 = and <2 x i64> %248, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i349.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_139.i.i, i32 0
  %250 = bitcast <4 x i32> %.12.vec.insert.i18.i349.i.i to <2 x i64>
  %251 = or <2 x i64> %249, %250
  store <2 x i64> %251, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i.i, align 16
  %252 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 16
  %253 = bitcast [256 x i8]* %out to <4 x i32>*
  store <4 x i32> %a101451.i.i, <4 x i32>* %253, align 1, !noalias !329
  %254 = add <4 x i32> %_156.sroa.0.0.copyload1449.i.i, %.pre-phi
  %255 = bitcast i8* %252 to <4 x i32>*
  store <4 x i32> %254, <4 x i32>* %255, align 1, !noalias !332
  %256 = add <4 x i32> %_159.sroa.0.0.copyload1450.i.i, %.pre-phi247
  %257 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 32
  %258 = bitcast i8* %257 to <4 x i32>*
  store <4 x i32> %256, <4 x i32>* %258, align 1, !noalias !335
  %259 = add <4 x i32> %.pre-phi.i, %2
  %260 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 48
  %261 = bitcast i8* %260 to <4 x i32>*
  store <4 x i32> %259, <4 x i32>* %261, align 1, !noalias !338
  %262 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 64
  %263 = bitcast <2 x i64> %12 to <4 x i32>
  %264 = bitcast <2 x i64> %x.sroa.15.sroa.8.0.lcssa.i.i to <4 x i32>
  %265 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 80
  %266 = bitcast i8* %262 to <4 x i32>*
  store <4 x i32> %.lcssa1460.i.i, <4 x i32>* %266, align 1, !noalias !329
  %267 = add <4 x i32> %_156.sroa.0.0.copyload1449.i.i, %.pre-phi251
  %268 = bitcast i8* %265 to <4 x i32>*
  store <4 x i32> %267, <4 x i32>* %268, align 1, !noalias !332
  %269 = add <4 x i32> %_159.sroa.0.0.copyload1450.i.i, %.pre-phi249
  %270 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 96
  %271 = bitcast i8* %270 to <4 x i32>*
  store <4 x i32> %269, <4 x i32>* %271, align 1, !noalias !335
  %272 = add <4 x i32> %264, %263
  %273 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 112
  %274 = bitcast i8* %273 to <4 x i32>*
  store <4 x i32> %272, <4 x i32>* %274, align 1, !noalias !338
  %275 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 128
  %276 = bitcast <2 x i64> %19 to <4 x i32>
  %277 = bitcast <2 x i64> %x.sroa.15.sroa.9.0.lcssa.i.i to <4 x i32>
  %278 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 144
  %279 = bitcast i8* %275 to <4 x i32>*
  store <4 x i32> %.lcssa1461.i.i, <4 x i32>* %279, align 1, !noalias !329
  %280 = add <4 x i32> %_156.sroa.0.0.copyload1449.i.i, %.pre-phi255
  %281 = bitcast i8* %278 to <4 x i32>*
  store <4 x i32> %280, <4 x i32>* %281, align 1, !noalias !332
  %282 = add <4 x i32> %_159.sroa.0.0.copyload1450.i.i, %.pre-phi253
  %283 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 160
  %284 = bitcast i8* %283 to <4 x i32>*
  store <4 x i32> %282, <4 x i32>* %284, align 1, !noalias !335
  %285 = add <4 x i32> %277, %276
  %286 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 176
  %287 = bitcast i8* %286 to <4 x i32>*
  store <4 x i32> %285, <4 x i32>* %287, align 1, !noalias !338
  %288 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 192
  %289 = bitcast <2 x i64> %26 to <4 x i32>
  %290 = bitcast <2 x i64> %x.sroa.15.sroa.10.0.lcssa.i.i to <4 x i32>
  %291 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 208
  %292 = bitcast i8* %288 to <4 x i32>*
  store <4 x i32> %.lcssa1462.i.i, <4 x i32>* %292, align 1, !noalias !329
  %293 = add <4 x i32> %_156.sroa.0.0.copyload1449.i.i, %.pre-phi259
  %294 = bitcast i8* %291 to <4 x i32>*
  store <4 x i32> %293, <4 x i32>* %294, align 1, !noalias !332
  %295 = add <4 x i32> %_159.sroa.0.0.copyload1450.i.i, %.pre-phi257
  %296 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 224
  %297 = bitcast i8* %296 to <4 x i32>*
  store <4 x i32> %295, <4 x i32>* %297, align 1, !noalias !335
  %298 = add <4 x i32> %290, %289
  %299 = getelementptr inbounds [256 x i8], [256 x i8]* %out, i64 0, i64 240
  %300 = bitcast i8* %299 to <4 x i32>*
  store <4 x i32> %298, <4 x i32>* %300, align 1, !noalias !338
  ret void
}

; Function Attrs: nonlazybind uwtable
define void @_ZN11rand_chacha4guts16set_stream_param17hc8164007baeaabeeE(%"guts::ChaCha"* nocapture align 16 dereferenceable(48) %state, i32 %param, i64 %value) unnamed_addr #0 {
start:
  %0 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %1 = load atomic i64, i64* %0 monotonic, align 8
  %2 = icmp eq i64 %1, 0
  br i1 %2, label %bb1.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

bb1.i.i.i.i:                                      ; preds = %start
  %_2.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit: ; preds = %bb1.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i = phi i64 [ %_2.i.i.i.i.i, %bb1.i.i.i.i ], [ %1, %start ]
  %.0.i6.in.in.i.i.i = and i64 %.0.i6.in.in.i.i.in.i, 16384
  %.0.i6.in.i.i.i.not = icmp eq i64 %.0.i6.in.in.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not, label %bb2, label %bb3

bb2:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  %_7.sroa.0.0..sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_7.sroa.0.0..sroa_cast.i.i = bitcast %"ppv_lite86::vec128_storage"* %_7.sroa.0.0..sroa_idx.i.i to <2 x i64>*
  %_7.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_7.sroa.0.0..sroa_cast.i.i, align 16
  %_13.i.i = lshr i64 %value, 32
  %_12.i.i = trunc i64 %_13.i.i to i32
  %_16.i.i = shl i32 %param, 1
  %_15.i.i = or i32 %_16.i.i, 1
  switch i32 %_15.i.i, label %bb1.i11.i.i [
    i32 3, label %bb19.i19.i.i
    i32 1, label %bb7.i15.i.i
  ]

bb1.i11.i.i:                                      ; preds = %bb2
  tail call void @_ZN4core9panicking5panic17hc14ab8d72efd34afE([0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [40 x i8] }>* @alloc2498 to [0 x i8]*), i64 40, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc2494 to %"std::panic::Location"*)), !noalias !341
  br label %UnifiedUnreachableBlock

bb7.i15.i.i:                                      ; preds = %bb2
  %3 = bitcast <2 x i64> %_7.sroa.0.0.copyload.i.i to <4 x i32>
  %4 = shufflevector <4 x i32> %3, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 3, i32 undef>
  %5 = bitcast <4 x i32> %4 to <16 x i8>
  %6 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %5, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i13.i14.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_12.i.i, i32 0
  %7 = bitcast <16 x i8> %6 to <4 x i32>
  %8 = or <4 x i32> %.12.vec.insert.i13.i14.i.i, %7
  %9 = shufflevector <4 x i32> %8, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 2, i32 3>
  br label %"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E.exit21.i.i"

bb19.i19.i.i:                                     ; preds = %bb2
  %10 = bitcast <2 x i64> %_7.sroa.0.0.copyload.i.i to <16 x i8>
  %11 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %10, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i.i18.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_12.i.i, i32 0
  %12 = bitcast <16 x i8> %11 to <4 x i32>
  %13 = or <4 x i32> %.12.vec.insert.i.i18.i.i, %12
  %14 = shufflevector <4 x i32> %13, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 3, i32 0>
  br label %"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E.exit21.i.i"

"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E.exit21.i.i": ; preds = %bb19.i19.i.i, %bb7.i15.i.i
  %_4.0.i20.in.i.i = phi <4 x i32> [ %14, %bb19.i19.i.i ], [ %9, %bb7.i15.i.i ]
  %_18.i.i = trunc i64 %value to i32
  switch i32 %_16.i.i, label %bb1.i.i.i [
    i32 0, label %bb2.i.i.i
    i32 2, label %bb13.i.i.i
  ]

bb1.i.i.i:                                        ; preds = %"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E.exit21.i.i"
  tail call void @_ZN4core9panicking5panic17hc14ab8d72efd34afE([0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [40 x i8] }>* @alloc2498 to [0 x i8]*), i64 40, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc2494 to %"std::panic::Location"*)), !noalias !344
  br label %UnifiedUnreachableBlock

bb2.i.i.i:                                        ; preds = %"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E.exit21.i.i"
  %_4.0.i20.i.i = bitcast <4 x i32> %_4.0.i20.in.i.i to <2 x i64>
  %15 = and <2 x i64> %_4.0.i20.i.i, <i64 -4294967296, i64 -1>
  %.12.vec.insert.i18.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i, i32 0
  %16 = bitcast <4 x i32> %.12.vec.insert.i18.i.i.i to <2 x i64>
  %17 = or <2 x i64> %15, %16
  br label %_ZN11rand_chacha4guts16set_stream_param9impl_sse217h9abfc4cc33beaa55E.exit

bb13.i.i.i:                                       ; preds = %"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E.exit21.i.i"
  %18 = shufflevector <4 x i32> %_4.0.i20.in.i.i, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 3, i32 undef>
  %19 = bitcast <4 x i32> %18 to <16 x i8>
  %20 = shufflevector <16 x i8> <i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 undef, i8 0, i8 0, i8 0, i8 0>, <16 x i8> %19, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27>
  %.12.vec.insert.i7.i.i.i = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %_18.i.i, i32 0
  %21 = bitcast <16 x i8> %20 to <4 x i32>
  %22 = or <4 x i32> %.12.vec.insert.i7.i.i.i, %21
  %23 = shufflevector <4 x i32> %22, <4 x i32> undef, <4 x i32> <i32 1, i32 2, i32 0, i32 3>
  %24 = bitcast <4 x i32> %23 to <2 x i64>
  br label %_ZN11rand_chacha4guts16set_stream_param9impl_sse217h9abfc4cc33beaa55E.exit

_ZN11rand_chacha4guts16set_stream_param9impl_sse217h9abfc4cc33beaa55E.exit: ; preds = %bb13.i.i.i, %bb2.i.i.i
  %_4.0.i.i.i = phi <2 x i64> [ %24, %bb13.i.i.i ], [ %17, %bb2.i.i.i ]
  store <2 x i64> %_4.0.i.i.i, <2 x i64>* %_7.sroa.0.0..sroa_cast.i.i, align 16
  br label %bb9

bb3:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  tail call fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nonnull align 16 dereferenceable(48) %state, i32 %param, i64 %value)
  br label %bb9

bb9:                                              ; preds = %bb3, %_ZN11rand_chacha4guts16set_stream_param9impl_sse217h9abfc4cc33beaa55E.exit
  ret void

UnifiedUnreachableBlock:                          ; preds = %bb1.i.i.i, %bb1.i11.i.i
  unreachable
}

; Function Attrs: nonlazybind uwtable
define internal fastcc void @_ZN11rand_chacha4guts16set_stream_param8impl_avx17h01200fb8e42764c2E(%"guts::ChaCha"* nocapture align 16 dereferenceable(48) %state, i32 %param, i64 %value) unnamed_addr #8 {
start:
  %_7.sroa.0.0..sroa_idx.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_16.i = shl i32 %param, 1
  %_15.i = or i32 %_16.i, 1
  switch i32 %_15.i, label %bb1.i12.i [
    i32 3, label %"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E.exit17.i"
    i32 1, label %"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E.exit17.i"
  ]

bb1.i12.i:                                        ; preds = %start
  tail call void @_ZN4core9panicking5panic17hc14ab8d72efd34afE([0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [40 x i8] }>* @alloc2498 to [0 x i8]*), i64 40, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc2500 to %"std::panic::Location"*)), !noalias !347
  br label %UnifiedUnreachableBlock

"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E.exit17.i": ; preds = %start, %start
  switch i32 %_16.i, label %bb1.i.i [
    i32 0, label %_ZN11rand_chacha4guts16set_stream_param7fn_impl17hf7f3ba3a1e1d70f4E.exit
    i32 2, label %_ZN11rand_chacha4guts16set_stream_param7fn_impl17hf7f3ba3a1e1d70f4E.exit
  ]

bb1.i.i:                                          ; preds = %"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E.exit17.i"
  tail call void @_ZN4core9panicking5panic17hc14ab8d72efd34afE([0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [40 x i8] }>* @alloc2498 to [0 x i8]*), i64 40, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc2500 to %"std::panic::Location"*)), !noalias !350
  br label %UnifiedUnreachableBlock

_ZN11rand_chacha4guts16set_stream_param7fn_impl17hf7f3ba3a1e1d70f4E.exit: ; preds = %"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E.exit17.i", %"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E.exit17.i"
  %_18.i = trunc i64 %value to i32
  %0 = bitcast %"ppv_lite86::vec128_storage"* %_7.sroa.0.0..sroa_idx.i to <4 x i32>*
  %_7.sroa.0.0.copyload.i19 = load <4 x i32>, <4 x i32>* %0, align 16
  %_13.i = lshr i64 %value, 32
  %_12.i = trunc i64 %_13.i to i32
  %1 = insertelement <4 x i32> %_7.sroa.0.0.copyload.i19, i32 %_12.i, i32 %_15.i
  %2 = insertelement <4 x i32> %1, i32 %_18.i, i32 %_16.i
  %3 = bitcast %"ppv_lite86::vec128_storage"* %_7.sroa.0.0..sroa_idx.i to <4 x i32>*
  store <4 x i32> %2, <4 x i32>* %3, align 16
  ret void

UnifiedUnreachableBlock:                          ; preds = %bb1.i.i, %bb1.i12.i
  unreachable
}

; Function Attrs: nonlazybind uwtable
define i64 @_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE(%"guts::ChaCha"* mpk_immut noalias nocapture readonly align 16 dereferenceable(48) %state, i32 %param) unnamed_addr #0 {
start:
  %_3.i2.i.i = alloca i128, align 8
  %_3.i.i.i = alloca i128, align 8
  %0 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %1 = load atomic i64, i64* %0 monotonic, align 8
  %2 = icmp eq i64 %1, 0
  br i1 %2, label %bb1.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

bb1.i.i.i.i:                                      ; preds = %start
  %_2.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit: ; preds = %bb1.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i = phi i64 [ %_2.i.i.i.i.i, %bb1.i.i.i.i ], [ %1, %start ]
  %.0.i6.in.in.i.i.i = and i64 %.0.i6.in.in.i.i.in.i, 16384
  %.0.i6.in.i.i.i.not = icmp eq i64 %.0.i6.in.in.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not, label %bb2, label %bb3

bb2:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  %_6.sroa.0.0..sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_6.sroa.0.0..sroa_cast.i.i = bitcast %"ppv_lite86::vec128_storage"* %_6.sroa.0.0..sroa_idx.i.i to <2 x i64>*
  %_6.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_6.sroa.0.0..sroa_cast.i.i, align 16, !alias.scope !353
  %_12.i.i = shl i32 %param, 1
  %_11.i.i = or i32 %_12.i.i, 1
  %3 = bitcast i128* %_3.i2.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3), !noalias !353
  %4 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i.i, i32 0
  %5 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i.i, i32 1
  %_17.i.i3.i.i = lshr i64 %5, 32
  %.sroa.4.0.insert.ext.i.i4.i.i = zext i64 %_17.i.i3.i.i to i128
  %.sroa.4.0.insert.shift.i.i5.i.i = shl nuw i128 %.sroa.4.0.insert.ext.i.i4.i.i, 96
  %_14.mask.i.i6.i.i = and i64 %5, 4294967295
  %.sroa.3.0.insert.ext.i.i7.i.i = zext i64 %_14.mask.i.i6.i.i to i128
  %.sroa.3.0.insert.shift.i.i8.i.i = shl nuw nsw i128 %.sroa.3.0.insert.ext.i.i7.i.i, 64
  %.sroa.3.0.insert.insert.i.i9.i.i = zext i64 %4 to i128
  %.sroa.2.0.insert.insert.i.i10.i.i = or i128 %.sroa.3.0.insert.shift.i.i8.i.i, %.sroa.3.0.insert.insert.i.i9.i.i
  %.sroa.0.0.insert.insert.i.i11.i.i = or i128 %.sroa.2.0.insert.insert.i.i10.i.i, %.sroa.4.0.insert.shift.i.i5.i.i
  store i128 %.sroa.0.0.insert.insert.i.i11.i.i, i128* %_3.i2.i.i, align 8, !noalias !353
  %_5.i12.i.i = zext i32 %_11.i.i to i64
  %_8.i13.i.i = icmp ult i32 %_11.i.i, 4
  br i1 %_8.i13.i.i, label %_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE.exit, label %panic.i15.i.i, !prof !358, !misexpect !359

panic.i15.i.i:                                    ; preds = %bb2
  tail call void @_ZN4core9panicking18panic_bounds_check17h29d829799621eb42E(i64 %_5.i12.i.i, i64 4, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc2497 to %"std::panic::Location"*)), !noalias !353
  unreachable

_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE.exit: ; preds = %bb2
  %tmpcast.i14.i.i = bitcast i128* %_3.i2.i.i to [4 x i32]*
  %6 = getelementptr inbounds [4 x i32], [4 x i32]* %tmpcast.i14.i.i, i64 0, i64 %_5.i12.i.i
  %7 = load i32, i32* %6, align 4, !noalias !353
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3), !noalias !353
  %_8.i.i = zext i32 %7 to i64
  %_7.i.i = shl nuw i64 %_8.i.i, 32
  %8 = bitcast i128* %_3.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %8), !noalias !353
  store i128 %.sroa.0.0.insert.insert.i.i11.i.i, i128* %_3.i.i.i, align 8, !noalias !353
  %_5.i.i.i = zext i32 %_12.i.i to i64
  %tmpcast.i.i.i = bitcast i128* %_3.i.i.i to [4 x i32]*
  %9 = getelementptr inbounds [4 x i32], [4 x i32]* %tmpcast.i.i.i, i64 0, i64 %_5.i.i.i
  %10 = load i32, i32* %9, align 8, !noalias !353
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %8), !noalias !353
  %_14.i.i = zext i32 %10 to i64
  %11 = or i64 %_7.i.i, %_14.i.i
  br label %bb9

bb3:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  %12 = tail call fastcc i64 @_ZN11rand_chacha4guts16get_stream_param8impl_avx17h0b434e849102fe12E(%"guts::ChaCha"* mpk_immut noalias nonnull readonly align 16 dereferenceable(48) %state, i32 %param)
  br label %bb9

bb9:                                              ; preds = %bb3, %_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE.exit
  %.0 = phi i64 [ %12, %bb3 ], [ %11, %_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE.exit ]
  ret i64 %.0
}

; Function Attrs: nonlazybind uwtable
define internal fastcc i64 @_ZN11rand_chacha4guts16get_stream_param8impl_avx17h0b434e849102fe12E(%"guts::ChaCha"* mpk_immut noalias nocapture readonly align 16 dereferenceable(48) %state, i32 %param) unnamed_addr #8 {
start:
  %_3.i2.i = alloca i128, align 8
  %_3.i.i = alloca i128, align 8
  %_6.sroa.0.0..sroa_idx.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 5
  %_6.sroa.0.0..sroa_cast.i = bitcast %"ppv_lite86::vec128_storage"* %_6.sroa.0.0..sroa_idx.i to <2 x i64>*
  %_6.sroa.0.0.copyload.i = load <2 x i64>, <2 x i64>* %_6.sroa.0.0..sroa_cast.i, align 16, !alias.scope !360
  %_12.i = shl i32 %param, 1
  %_11.i = or i32 %_12.i, 1
  %0 = bitcast i128* %_3.i2.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0), !noalias !360
  %1 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i, i32 0
  %2 = extractelement <2 x i64> %_6.sroa.0.0.copyload.i, i32 1
  %_16.i.i4.i = lshr i64 %2, 32
  %.sroa.4.0.insert.ext.i.i5.i = zext i64 %_16.i.i4.i to i128
  %.sroa.4.0.insert.shift.i.i6.i = shl nuw i128 %.sroa.4.0.insert.ext.i.i5.i, 96
  %_13.mask.i.i7.i = and i64 %2, 4294967295
  %.sroa.3.0.insert.ext.i.i8.i = zext i64 %_13.mask.i.i7.i to i128
  %.sroa.3.0.insert.shift.i.i9.i = shl nuw nsw i128 %.sroa.3.0.insert.ext.i.i8.i, 64
  %.sroa.3.0.insert.insert.i.i10.i = zext i64 %1 to i128
  %.sroa.2.0.insert.insert.i.i11.i = or i128 %.sroa.3.0.insert.shift.i.i9.i, %.sroa.3.0.insert.insert.i.i10.i
  %.sroa.0.0.insert.insert.i.i12.i = or i128 %.sroa.2.0.insert.insert.i.i11.i, %.sroa.4.0.insert.shift.i.i6.i
  store i128 %.sroa.0.0.insert.insert.i.i12.i, i128* %_3.i2.i, align 8, !noalias !360
  %_5.i13.i = zext i32 %_11.i to i64
  %_8.i14.i = icmp ult i32 %_11.i, 4
  br i1 %_8.i14.i, label %_ZN11rand_chacha4guts16get_stream_param7fn_impl17h2ef49ebb3351ba2eE.exit, label %panic.i16.i, !prof !358, !misexpect !359

panic.i16.i:                                      ; preds = %start
  tail call void @_ZN4core9panicking18panic_bounds_check17h29d829799621eb42E(i64 %_5.i13.i, i64 4, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc2502 to %"std::panic::Location"*)), !noalias !360
  unreachable

_ZN11rand_chacha4guts16get_stream_param7fn_impl17h2ef49ebb3351ba2eE.exit: ; preds = %start
  %tmpcast.i15.i = bitcast i128* %_3.i2.i to [4 x i32]*
  %3 = getelementptr inbounds [4 x i32], [4 x i32]* %tmpcast.i15.i, i64 0, i64 %_5.i13.i
  %4 = load i32, i32* %3, align 4, !noalias !360
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0), !noalias !360
  %_8.i = zext i32 %4 to i64
  %_7.i = shl nuw i64 %_8.i, 32
  %5 = bitcast i128* %_3.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %5), !noalias !360
  store i128 %.sroa.0.0.insert.insert.i.i12.i, i128* %_3.i.i, align 8, !noalias !360
  %_5.i.i = zext i32 %_12.i to i64
  %tmpcast.i.i = bitcast i128* %_3.i.i to [4 x i32]*
  %6 = getelementptr inbounds [4 x i32], [4 x i32]* %tmpcast.i.i, i64 0, i64 %_5.i.i
  %7 = load i32, i32* %6, align 8, !noalias !360
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %5), !noalias !360
  %_14.i = zext i32 %7 to i64
  %8 = or i64 %_7.i, %_14.i
  ret i64 %8
}

; Function Attrs: nonlazybind uwtable
define void @_ZN11rand_chacha4guts8get_seed17h20f1d0d58e58025dE([32 x i8]* noalias nocapture sret dereferenceable(32) %0, %"guts::ChaCha"* mpk_immut noalias nocapture readonly align 16 dereferenceable(48) %state) unnamed_addr #0 {
start:
  %1 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %2 = load atomic i64, i64* %1 monotonic, align 8
  %3 = icmp eq i64 %2, 0
  br i1 %3, label %bb1.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

bb1.i.i.i.i:                                      ; preds = %start
  %_2.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit: ; preds = %bb1.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i = phi i64 [ %_2.i.i.i.i.i, %bb1.i.i.i.i ], [ %2, %start ]
  %.0.i6.in.in.i.i.i = and i64 %.0.i6.in.in.i.i.in.i, 16384
  %.0.i6.in.i.i.i.not = icmp eq i64 %.0.i6.in.in.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not, label %bb2, label %bb3

bb2:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  %_5.sroa.0.0..sroa_cast.i.i = bitcast %"guts::ChaCha"* %state to <2 x i64>*
  %_5.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_5.sroa.0.0..sroa_cast.i.i, align 16, !alias.scope !363, !noalias !368
  %_8.sroa.0.0..sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 3
  %_8.sroa.0.0..sroa_cast.i.i = bitcast %"ppv_lite86::vec128_storage"* %_8.sroa.0.0..sroa_idx.i.i to <2 x i64>*
  %_8.sroa.0.0.copyload.i.i = load <2 x i64>, <2 x i64>* %_8.sroa.0.0..sroa_cast.i.i, align 16, !alias.scope !363, !noalias !368
  %_36.i12.i.i = bitcast [32 x i8]* %0 to <2 x i64>*
  store <2 x i64> %_5.sroa.0.0.copyload.i.i, <2 x i64>* %_36.i12.i.i, align 1, !alias.scope !368, !noalias !371
  %4 = getelementptr inbounds [32 x i8], [32 x i8]* %0, i64 0, i64 16
  %_36.i.i.i = bitcast i8* %4 to <2 x i64>*
  store <2 x i64> %_8.sroa.0.0.copyload.i.i, <2 x i64>* %_36.i.i.i, align 1, !alias.scope !368, !noalias !374
  br label %bb9

bb3:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  tail call fastcc void @_ZN11rand_chacha4guts8get_seed8impl_avx17hc884a559519a2b94E([32 x i8]* noalias nocapture nonnull dereferenceable(32) %0, %"guts::ChaCha"* mpk_immut noalias nonnull readonly align 16 dereferenceable(48) %state)
  br label %bb9

bb9:                                              ; preds = %bb3, %bb2
  ret void
}

; Function Attrs: nofree norecurse nounwind nonlazybind uwtable
define internal fastcc void @_ZN11rand_chacha4guts8get_seed8impl_avx17hc884a559519a2b94E([32 x i8]* noalias nocapture dereferenceable(32) %0, %"guts::ChaCha"* mpk_immut noalias nocapture readonly align 16 dereferenceable(48) %state) unnamed_addr #9 {
start:
  %_5.sroa.0.0..sroa_cast.i = bitcast %"guts::ChaCha"* %state to <2 x i64>*
  %_5.sroa.0.0.copyload.i = load <2 x i64>, <2 x i64>* %_5.sroa.0.0..sroa_cast.i, align 16, !alias.scope !377, !noalias !380
  %_8.sroa.0.0..sroa_idx.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %state, i64 0, i32 3
  %_8.sroa.0.0..sroa_cast.i = bitcast %"ppv_lite86::vec128_storage"* %_8.sroa.0.0..sroa_idx.i to <2 x i64>*
  %_8.sroa.0.0.copyload.i = load <2 x i64>, <2 x i64>* %_8.sroa.0.0..sroa_cast.i, align 16, !alias.scope !377, !noalias !380
  %_36.i12.i = bitcast [32 x i8]* %0 to <2 x i64>*
  store <2 x i64> %_5.sroa.0.0.copyload.i, <2 x i64>* %_36.i12.i, align 1, !alias.scope !380, !noalias !382
  %1 = getelementptr inbounds [32 x i8], [32 x i8]* %0, i64 0, i64 16
  %_36.i.i = bitcast i8* %1 to <2 x i64>*
  store <2 x i64> %_8.sroa.0.0.copyload.i, <2 x i64>* %_36.i.i, align 1, !alias.scope !380, !noalias !385
  ret void
}

; Function Attrs: nonlazybind uwtable
define void @_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE(%"guts::ChaCha"* noalias nocapture sret dereferenceable(48) %0, [32 x i8]* mpk_immut noalias nocapture readonly align 1 dereferenceable(32) %key, [0 x i8]* mpk_immut noalias nocapture nonnull readonly align 1 %nonce.0, i64 %nonce.1) unnamed_addr #0 {
start:
  %1 = getelementptr [2 x %"std::detect::cache::Cache"], [2 x %"std::detect::cache::Cache"]* @_ZN3std10std_detect6detect5cache5CACHE17h60872c4924ca9687E, i64 0, i64 0, i32 1, i32 1
  %2 = load atomic i64, i64* %1 monotonic, align 8
  %3 = icmp eq i64 %2, 0
  br i1 %3, label %bb1.i.i.i.i, label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

bb1.i.i.i.i:                                      ; preds = %start
  %_2.i.i.i.i.i = tail call i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE()
  br label %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit

_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit: ; preds = %bb1.i.i.i.i, %start
  %.0.i6.in.in.i.i.in.i = phi i64 [ %_2.i.i.i.i.i, %bb1.i.i.i.i ], [ %2, %start ]
  %.0.i6.in.in.i.i.i = and i64 %.0.i6.in.in.i.i.in.i, 16384
  %.0.i6.in.i.i.i.not = icmp eq i64 %.0.i6.in.in.i.i.i, 0
  br i1 %.0.i6.in.i.i.i.not, label %bb2, label %bb3

bb2:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  %4 = icmp eq i64 %nonce.1, 12
  br i1 %4, label %bb6.thread.i.i, label %bb6.i.i

bb6.i.i:                                          ; preds = %bb2
  %_19.i.i = add i64 %nonce.1, -8
  %_22.i.i = add i64 %nonce.1, -4
  %_3.i.i.i.i = icmp ult i64 %_22.i.i, %_19.i.i
  br i1 %_3.i.i.i.i, label %bb2.i.i.i.i, label %bb1.i.i.i.i1

bb6.thread.i.i:                                   ; preds = %bb2
  %5 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 0
  %_39.i.i.i = load i8, i8* %5, align 1, !alias.scope !388, !noalias !395
  %6 = zext i8 %_39.i.i.i to i32
  %7 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 1
  %_45.i.i.i = load i8, i8* %7, align 1, !alias.scope !388, !noalias !395
  %8 = zext i8 %_45.i.i.i to i32
  %9 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 2
  %_51.i.i.i = load i8, i8* %9, align 1, !alias.scope !388, !noalias !395
  %10 = zext i8 %_51.i.i.i to i32
  %_43.i.i.i = shl nuw nsw i32 %8, 8
  %_37.i.i.i = or i32 %_43.i.i.i, %6
  %_49.i.i.i = shl nuw nsw i32 %10, 16
  %_36.i.i.i = or i32 %_37.i.i.i, %_49.i.i.i
  %11 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 3
  %_57.i.i.i = load i8, i8* %11, align 1, !alias.scope !388, !noalias !395
  %12 = zext i8 %_57.i.i.i to i32
  %_55.i.i.i = shl nuw i32 %12, 24
  %13 = or i32 %_36.i.i.i, %_55.i.i.i
  br label %_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE.exit

bb1.i.i.i.i1:                                     ; preds = %bb6.i.i
  %_8.i.i71.i.i = icmp ult i64 %nonce.1, 4
  br i1 %_8.i.i71.i.i, label %bb5.i.i72.i.i, label %_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE.exit

bb2.i.i.i.i:                                      ; preds = %bb6.i.i
  tail call void @_ZN4core5slice5index22slice_index_order_fail17hff3773a512c2a4b8E(i64 %_19.i.i, i64 %_22.i.i, %"std::panic::Location"* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc3647 to %"std::panic::Location"*)), !noalias !400
  br label %UnifiedUnreachableBlock

bb5.i.i72.i.i:                                    ; preds = %bb1.i.i.i.i1
  tail call void @_ZN4core5slice5index24slice_end_index_len_fail17h63be533cc6b8936fE(i64 %_22.i.i, i64 %nonce.1, %"std::panic::Location"* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc3647 to %"std::panic::Location"*)), !noalias !400
  br label %UnifiedUnreachableBlock

_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE.exit: ; preds = %bb1.i.i.i.i1, %bb6.thread.i.i
  %_5.0108119.i.i = phi i32 [ 0, %bb1.i.i.i.i1 ], [ %13, %bb6.thread.i.i ]
  %_19109118.i.i = phi i64 [ %_19.i.i, %bb1.i.i.i.i1 ], [ 4, %bb6.thread.i.i ]
  %_22111117.i.i = phi i64 [ %_22.i.i, %bb1.i.i.i.i1 ], [ 8, %bb6.thread.i.i ]
  %14 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 %_19109118.i.i
  %_39.i80.i.i = load i8, i8* %14, align 1, !alias.scope !401, !noalias !395
  %15 = zext i8 %_39.i80.i.i to i32
  %16 = getelementptr inbounds i8, i8* %14, i64 1
  %_45.i81.i.i = load i8, i8* %16, align 1, !alias.scope !401, !noalias !395
  %17 = zext i8 %_45.i81.i.i to i32
  %18 = getelementptr inbounds i8, i8* %14, i64 2
  %_51.i82.i.i = load i8, i8* %18, align 1, !alias.scope !401, !noalias !395
  %19 = zext i8 %_51.i82.i.i to i32
  %_43.i83.i.i = shl nuw nsw i32 %17, 8
  %_37.i84.i.i = or i32 %_43.i83.i.i, %15
  %_49.i85.i.i = shl nuw nsw i32 %19, 16
  %_36.i86.i.i = or i32 %_37.i84.i.i, %_49.i85.i.i
  %20 = getelementptr inbounds i8, i8* %14, i64 3
  %_57.i87.i.i = load i8, i8* %20, align 1, !alias.scope !401, !noalias !395
  %21 = zext i8 %_57.i87.i.i to i32
  %_55.i88.i.i = shl nuw i32 %21, 24
  %22 = or i32 %_36.i86.i.i, %_55.i88.i.i
  %23 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 %_22111117.i.i
  %_39.i61.i.i = load i8, i8* %23, align 1, !alias.scope !404, !noalias !395
  %24 = zext i8 %_39.i61.i.i to i32
  %25 = getelementptr inbounds i8, i8* %23, i64 1
  %_45.i62.i.i = load i8, i8* %25, align 1, !alias.scope !404, !noalias !395
  %26 = zext i8 %_45.i62.i.i to i32
  %27 = getelementptr inbounds i8, i8* %23, i64 2
  %_51.i63.i.i = load i8, i8* %27, align 1, !alias.scope !404, !noalias !395
  %28 = zext i8 %_51.i63.i.i to i32
  %_43.i64.i.i = shl nuw nsw i32 %26, 8
  %_37.i65.i.i = or i32 %_43.i64.i.i, %24
  %_49.i66.i.i = shl nuw nsw i32 %28, 16
  %_36.i67.i.i = or i32 %_37.i65.i.i, %_49.i66.i.i
  %29 = getelementptr inbounds i8, i8* %23, i64 3
  %_57.i68.i.i = load i8, i8* %29, align 1, !alias.scope !404, !noalias !395
  %30 = zext i8 %_57.i68.i.i to i32
  %_55.i69.i.i = shl nuw i32 %30, 24
  %31 = or i32 %_36.i67.i.i, %_55.i69.i.i
  %32 = bitcast [32 x i8]* %key to i128*
  %.0.copyload.i.i53102.i.i = load i128, i128* %32, align 1, !alias.scope !407, !noalias !412
  %33 = getelementptr inbounds [32 x i8], [32 x i8]* %key, i64 0, i64 16
  %34 = bitcast i8* %33 to i128*
  %.0.copyload.i.i103.i.i = load i128, i128* %34, align 1, !alias.scope !415, !noalias !420
  %_55.sroa.6.0.insert.ext.i.i = zext i32 %31 to i128
  %_55.sroa.6.0.insert.shift.i.i = shl nuw i128 %_55.sroa.6.0.insert.ext.i.i, 96
  %_55.sroa.5.0.insert.ext.i.i = zext i32 %22 to i128
  %_55.sroa.5.0.insert.shift.i.i = shl nuw nsw i128 %_55.sroa.5.0.insert.ext.i.i, 64
  %_55.sroa.4.0.insert.ext.i.i = zext i32 %_5.0108119.i.i to i128
  %_55.sroa.4.0.insert.shift.i.i = shl nuw nsw i128 %_55.sroa.4.0.insert.ext.i.i, 32
  %_55.sroa.5.0.insert.insert.i.i = or i128 %_55.sroa.5.0.insert.shift.i.i, %_55.sroa.4.0.insert.shift.i.i
  %_55.sroa.4.0.insert.insert.i.i = or i128 %_55.sroa.5.0.insert.insert.i.i, %_55.sroa.6.0.insert.shift.i.i
  %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i.i = bitcast %"guts::ChaCha"* %0 to i128*
  store i128 %.0.copyload.i.i53102.i.i, i128* %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i.i, align 16, !alias.scope !423, !noalias !424
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %0, i64 0, i32 3
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i.i = bitcast %"ppv_lite86::vec128_storage"* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i.i to i128*
  store i128 %.0.copyload.i.i103.i.i, i128* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i.i, align 16, !alias.scope !423, !noalias !424
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %0, i64 0, i32 5
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i.i = bitcast %"ppv_lite86::vec128_storage"* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i.i to i128*
  store i128 %_55.sroa.4.0.insert.insert.i.i, i128* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i.i, align 16, !alias.scope !423, !noalias !424
  br label %bb9

bb3:                                              ; preds = %_ZN3std10std_detect6detect4arch21__is_feature_detected3avx17h5a3ce2d8a95fa099E.exit
  tail call fastcc void @_ZN11rand_chacha4guts11init_chacha8impl_avx17h3e4f4620b5fbdc3cE(%"guts::ChaCha"* noalias nocapture nonnull dereferenceable(48) %0, [32 x i8]* mpk_immut noalias nonnull readonly align 1 dereferenceable(32) %key, [0 x i8]* mpk_immut noalias nonnull readonly align 1 %nonce.0, i64 %nonce.1)
  br label %bb9

bb9:                                              ; preds = %bb3, %_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE.exit
  ret void

UnifiedUnreachableBlock:                          ; preds = %bb5.i.i72.i.i, %bb2.i.i.i.i
  unreachable
}

; Function Attrs: nonlazybind uwtable
define internal fastcc void @_ZN11rand_chacha4guts11init_chacha8impl_avx17h3e4f4620b5fbdc3cE(%"guts::ChaCha"* noalias nocapture dereferenceable(48) %0, [32 x i8]* mpk_immut noalias nocapture readonly align 1 dereferenceable(32) %key, [0 x i8]* mpk_immut noalias nocapture nonnull readonly align 1 %nonce.0, i64 %nonce.1) unnamed_addr #8 {
start:
  %1 = icmp eq i64 %nonce.1, 12
  br i1 %1, label %bb6.thread.i, label %bb6.i

bb6.i:                                            ; preds = %start
  %_19.i = add i64 %nonce.1, -8
  %_22.i = add i64 %nonce.1, -4
  %_3.i.i.i = icmp ult i64 %_22.i, %_19.i
  br i1 %_3.i.i.i, label %bb2.i.i.i, label %bb1.i.i.i

bb6.thread.i:                                     ; preds = %start
  %2 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 0
  %_39.i.i = load i8, i8* %2, align 1, !alias.scope !425, !noalias !430
  %3 = zext i8 %_39.i.i to i32
  %4 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 1
  %_45.i.i = load i8, i8* %4, align 1, !alias.scope !425, !noalias !430
  %5 = zext i8 %_45.i.i to i32
  %6 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 2
  %_51.i.i = load i8, i8* %6, align 1, !alias.scope !425, !noalias !430
  %7 = zext i8 %_51.i.i to i32
  %_43.i.i = shl nuw nsw i32 %5, 8
  %_37.i.i = or i32 %_43.i.i, %3
  %_49.i.i = shl nuw nsw i32 %7, 16
  %_36.i.i = or i32 %_37.i.i, %_49.i.i
  %8 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 3
  %_57.i.i = load i8, i8* %8, align 1, !alias.scope !425, !noalias !430
  %9 = zext i8 %_57.i.i to i32
  %_55.i.i = shl nuw i32 %9, 24
  %10 = or i32 %_36.i.i, %_55.i.i
  br label %_ZN11rand_chacha4guts11init_chacha7fn_impl17ha62230c7b837ffabE.exit

bb1.i.i.i:                                        ; preds = %bb6.i
  %_8.i.i71.i = icmp ult i64 %nonce.1, 4
  br i1 %_8.i.i71.i, label %bb5.i.i72.i, label %_ZN11rand_chacha4guts11init_chacha7fn_impl17ha62230c7b837ffabE.exit

bb2.i.i.i:                                        ; preds = %bb6.i
  tail call void @_ZN4core5slice5index22slice_index_order_fail17hff3773a512c2a4b8E(i64 %_19.i, i64 %_22.i, %"std::panic::Location"* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc3647 to %"std::panic::Location"*)), !noalias !433
  br label %UnifiedUnreachableBlock

bb5.i.i72.i:                                      ; preds = %bb1.i.i.i
  tail call void @_ZN4core5slice5index24slice_end_index_len_fail17h63be533cc6b8936fE(i64 %_22.i, i64 %nonce.1, %"std::panic::Location"* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc3647 to %"std::panic::Location"*)), !noalias !433
  br label %UnifiedUnreachableBlock

_ZN11rand_chacha4guts11init_chacha7fn_impl17ha62230c7b837ffabE.exit: ; preds = %bb1.i.i.i, %bb6.thread.i
  %_5.0108119.i = phi i32 [ 0, %bb1.i.i.i ], [ %10, %bb6.thread.i ]
  %_19109118.i = phi i64 [ %_19.i, %bb1.i.i.i ], [ 4, %bb6.thread.i ]
  %_22111117.i = phi i64 [ %_22.i, %bb1.i.i.i ], [ 8, %bb6.thread.i ]
  %11 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 %_19109118.i
  %_39.i80.i = load i8, i8* %11, align 1, !alias.scope !434, !noalias !430
  %12 = zext i8 %_39.i80.i to i32
  %13 = getelementptr inbounds i8, i8* %11, i64 1
  %_45.i81.i = load i8, i8* %13, align 1, !alias.scope !434, !noalias !430
  %14 = zext i8 %_45.i81.i to i32
  %15 = getelementptr inbounds i8, i8* %11, i64 2
  %_51.i82.i = load i8, i8* %15, align 1, !alias.scope !434, !noalias !430
  %16 = zext i8 %_51.i82.i to i32
  %_43.i83.i = shl nuw nsw i32 %14, 8
  %_37.i84.i = or i32 %_43.i83.i, %12
  %_49.i85.i = shl nuw nsw i32 %16, 16
  %_36.i86.i = or i32 %_37.i84.i, %_49.i85.i
  %17 = getelementptr inbounds i8, i8* %11, i64 3
  %_57.i87.i = load i8, i8* %17, align 1, !alias.scope !434, !noalias !430
  %18 = zext i8 %_57.i87.i to i32
  %_55.i88.i = shl nuw i32 %18, 24
  %19 = or i32 %_36.i86.i, %_55.i88.i
  %20 = getelementptr inbounds [0 x i8], [0 x i8]* %nonce.0, i64 0, i64 %_22111117.i
  %_39.i61.i = load i8, i8* %20, align 1, !alias.scope !437, !noalias !430
  %21 = zext i8 %_39.i61.i to i32
  %22 = getelementptr inbounds i8, i8* %20, i64 1
  %_45.i62.i = load i8, i8* %22, align 1, !alias.scope !437, !noalias !430
  %23 = zext i8 %_45.i62.i to i32
  %24 = getelementptr inbounds i8, i8* %20, i64 2
  %_51.i63.i = load i8, i8* %24, align 1, !alias.scope !437, !noalias !430
  %25 = zext i8 %_51.i63.i to i32
  %_43.i64.i = shl nuw nsw i32 %23, 8
  %_37.i65.i = or i32 %_43.i64.i, %21
  %_49.i66.i = shl nuw nsw i32 %25, 16
  %_36.i67.i = or i32 %_37.i65.i, %_49.i66.i
  %26 = getelementptr inbounds i8, i8* %20, i64 3
  %_57.i68.i = load i8, i8* %26, align 1, !alias.scope !437, !noalias !430
  %27 = zext i8 %_57.i68.i to i32
  %_55.i69.i = shl nuw i32 %27, 24
  %28 = or i32 %_36.i67.i, %_55.i69.i
  %29 = bitcast [32 x i8]* %key to i128*
  %.0.copyload.i.i53102.i = load i128, i128* %29, align 1, !alias.scope !440, !noalias !445
  %30 = getelementptr inbounds [32 x i8], [32 x i8]* %key, i64 0, i64 16
  %31 = bitcast i8* %30 to i128*
  %.0.copyload.i.i103.i = load i128, i128* %31, align 1, !alias.scope !448, !noalias !453
  %_55.sroa.6.0.insert.ext.i = zext i32 %28 to i128
  %_55.sroa.6.0.insert.shift.i = shl nuw i128 %_55.sroa.6.0.insert.ext.i, 96
  %_55.sroa.5.0.insert.ext.i = zext i32 %19 to i128
  %_55.sroa.5.0.insert.shift.i = shl nuw nsw i128 %_55.sroa.5.0.insert.ext.i, 64
  %_55.sroa.4.0.insert.ext.i = zext i32 %_5.0108119.i to i128
  %_55.sroa.4.0.insert.shift.i = shl nuw nsw i128 %_55.sroa.4.0.insert.ext.i, 32
  %_55.sroa.5.0.insert.insert.i = or i128 %_55.sroa.5.0.insert.shift.i, %_55.sroa.4.0.insert.shift.i
  %_55.sroa.4.0.insert.insert.i = or i128 %_55.sroa.5.0.insert.insert.i, %_55.sroa.6.0.insert.shift.i
  %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i = bitcast %"guts::ChaCha"* %0 to i128*
  store i128 %.0.copyload.i.i53102.i, i128* %_50.sroa.0.sroa.0.0._50.sroa.0.0..sroa_cast17.sroa_cast.i, align 16, !alias.scope !456, !noalias !457
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %0, i64 0, i32 3
  %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i = bitcast %"ppv_lite86::vec128_storage"* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_idx.i to i128*
  store i128 %.0.copyload.i.i103.i, i128* %_52.sroa.0.sroa.0.0._52.sroa.0.0..sroa_cast23.sroa_cast.i, align 16, !alias.scope !456, !noalias !457
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i = getelementptr inbounds %"guts::ChaCha", %"guts::ChaCha"* %0, i64 0, i32 5
  %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i = bitcast %"ppv_lite86::vec128_storage"* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_idx.i to i128*
  store i128 %_55.sroa.4.0.insert.insert.i, i128* %_54.sroa.0.sroa.0.0._54.sroa.0.0..sroa_cast29.sroa_cast.i, align 16, !alias.scope !456, !noalias !457
  ret void

UnifiedUnreachableBlock:                          ; preds = %bb5.i.i72.i, %bb2.i.i.i
  unreachable
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #10

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #10

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core5slice5index22slice_index_order_fail17hff3773a512c2a4b8E(i64, i64, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #11

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core5slice5index24slice_end_index_len_fail17h63be533cc6b8936fE(i64, i64, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #11

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #10

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @rust_eh_personality(i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"* mpk_unsafe, %"unwind::libunwind::_Unwind_Context"* mpk_unsafe) unnamed_addr #12

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking5panic17hc14ab8d72efd34afE([0 x i8]* mpk_immut noalias nonnull readonly align 1, i64, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #11

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking18panic_bounds_check17h29d829799621eb42E(i64, i64, %"std::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #11

; Function Attrs: cold nonlazybind uwtable
declare i64 @_ZN3std10std_detect6detect5cache21detect_and_initialize17h7ae939a472c1809eE() unnamed_addr #13

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN4core3fmt9Formatter10debug_list17h8147fa4f8cb43178E(%"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt8builders9DebugList6finish17h1110a7134d6ce275E(%"std::fmt::DebugList"* align 8 dereferenceable(16)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"std::fmt::Formatter"* mpk_immut noalias readonly align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u8$GT$3fmt17h64a79a92366aabc0E"(i8* mpk_immut noalias readonly align 1 dereferenceable(1), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"std::fmt::Formatter"* mpk_immut noalias readonly align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u8$GT$3fmt17h4852942f4018ed1aE"(i8* mpk_immut noalias readonly align 1 dereferenceable(1), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h2c6fa9207fbbb7f5E"(i8* mpk_immut noalias readonly align 1 dereferenceable(1), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17he9d3331e4e8b2618E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u64$GT$3fmt17h46c4aab50ded2d21E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h4dc2af1a5829180dE"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num54_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u128$GT$3fmt17hbcef45b08b6c408bE"(i128* mpk_immut noalias readonly align 8 dereferenceable(16), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num54_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u128$GT$3fmt17heedd9089723cd37fE"(i128* mpk_immut noalias readonly align 8 dereferenceable(16), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..Display$u20$for$u20$u128$GT$3fmt17h1c1701825f5cb075E"(i128* mpk_immut noalias readonly align 8 dereferenceable(16), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h3fb07f7e6da8e1c6E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$usize$GT$3fmt17hf3a9e839be306c07E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h0f57e3373191c50eE"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"std::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare align 8 dereferenceable(16) %"std::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"std::fmt::DebugList"* align 8 dereferenceable(16), {}* mpk_immut nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #0

; Function Attrs: nounwind
declare void @llvm.x86.avx.vzeroupper() unnamed_addr #14

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"std::fmt::Formatter"* align 8 dereferenceable(64), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare align 8 dereferenceable(16) %"std::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"std::fmt::DebugStruct"* align 8 dereferenceable(16), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64, {}* mpk_immut nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"std::fmt::DebugStruct"* align 8 dereferenceable(16)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"std::fmt::Formatter"* align 8 dereferenceable(64), %"std::fmt::Arguments"* noalias nocapture dereferenceable(48)) unnamed_addr #0

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #15

; Function Attrs: nofree nounwind nonlazybind readonly
declare i32 @bcmp(i8* nocapture, i8* nocapture, i64) local_unnamed_addr #16

attributes #0 = { nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #1 = { inlinehint nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #2 = { norecurse nounwind nonlazybind readnone uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #3 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #4 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" "target-features"="+avx2" }
attributes #5 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" "target-features"="+avx,+sse4.1,+ssse3" }
attributes #6 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" "target-features"="+sse4.1,+ssse3" }
attributes #7 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" "target-features"="+ssse3" }
attributes #8 = { nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" "target-features"="+avx" }
attributes #9 = { nofree norecurse nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" "target-features"="+avx" }
attributes #10 = { argmemonly nounwind willreturn }
attributes #11 = { cold noinline noreturn nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #12 = { mpk_extern nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #13 = { cold nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #14 = { nounwind }
attributes #15 = { argmemonly nounwind willreturn writeonly }
attributes #16 = { nofree nounwind nonlazybind readonly }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
!3 = !{!4}
!4 = distinct !{!4, !5, !"_ZN72_$LT$rand_core..block..BlockRng$LT$R$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h0b902c968353fb8fE: %self"}
!5 = distinct !{!5, !"_ZN72_$LT$rand_core..block..BlockRng$LT$R$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h0b902c968353fb8fE"}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_ZN72_$LT$rand_core..block..BlockRng$LT$R$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h101247175fa6d56eE: %self"}
!8 = distinct !{!8, !"_ZN72_$LT$rand_core..block..BlockRng$LT$R$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h101247175fa6d56eE"}
!9 = !{!10}
!10 = distinct !{!10, !11, !"_ZN72_$LT$rand_core..block..BlockRng$LT$R$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5ab650120db72b33E: %self"}
!11 = distinct !{!11, !"_ZN72_$LT$rand_core..block..BlockRng$LT$R$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5ab650120db72b33E"}
!12 = !{!13, !15}
!13 = distinct !{!13, !14, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h4d6bab18bb3e0c15E: %self.0"}
!14 = distinct !{!14, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h4d6bab18bb3e0c15E"}
!15 = distinct !{!15, !16, !"_ZN4core5array69_$LT$impl$u20$core..fmt..Debug$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$3fmt17h90199578321eeeeeE: %self"}
!16 = distinct !{!16, !"_ZN4core5array69_$LT$impl$u20$core..fmt..Debug$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$3fmt17h90199578321eeeeeE"}
!17 = !{!13}
!18 = !{!19}
!19 = distinct !{!19, !20, !"_ZN4core3fmt3num51_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u128$GT$3fmt17h8b9cdc9fe7e4fa43E: %self"}
!20 = distinct !{!20, !"_ZN4core3fmt3num51_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u128$GT$3fmt17h8b9cdc9fe7e4fa43E"}
!21 = !{!22}
!22 = distinct !{!22, !23, !"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE: %self"}
!23 = distinct !{!23, !"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE"}
!24 = !{!25}
!25 = distinct !{!25, !26, !"_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h93fa8a90e78c8b63E: %self"}
!26 = distinct !{!26, !"_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h93fa8a90e78c8b63E"}
!27 = !{!28, !30}
!28 = distinct !{!28, !29, !"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E: argument 0"}
!29 = distinct !{!29, !"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E"}
!30 = distinct !{!30, !29, !"_ZN75_$LT$rand_chacha..chacha..ChaCha20Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h486a6fa9150b86b3E: %seed"}
!31 = !{!32, !34, !28, !30}
!32 = distinct !{!32, !33, !"_ZN76_$LT$rand_chacha..chacha..ChaCha20Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h4c0ee7404227d616E: argument 0"}
!33 = distinct !{!33, !"_ZN76_$LT$rand_chacha..chacha..ChaCha20Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h4c0ee7404227d616E"}
!34 = distinct !{!34, !33, !"_ZN76_$LT$rand_chacha..chacha..ChaCha20Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h4c0ee7404227d616E: %seed"}
!35 = !{!36, !38, !39, !40, !42, !32, !34, !28, !30}
!36 = distinct !{!36, !37, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: argument 0"}
!37 = distinct !{!37, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE"}
!38 = distinct !{!38, !37, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: %key"}
!39 = distinct !{!39, !37, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: %nonce.0"}
!40 = distinct !{!40, !41, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E: argument 0"}
!41 = distinct !{!41, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E"}
!42 = distinct !{!42, !41, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E: %key"}
!43 = !{!44, !46, !48, !50, !38, !42, !34}
!44 = distinct !{!44, !45, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: %input.0"}
!45 = distinct !{!45, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E"}
!46 = distinct !{!46, !47, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: %input.0"}
!47 = distinct !{!47, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E"}
!48 = distinct !{!48, !49, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: %key"}
!49 = distinct !{!49, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE"}
!50 = distinct !{!50, !51, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: %key"}
!51 = distinct !{!51, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE"}
!52 = !{!53, !54, !55, !56, !57, !58, !36, !39, !40, !32, !28, !30}
!53 = distinct !{!53, !45, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: argument 0"}
!54 = distinct !{!54, !47, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: argument 0"}
!55 = distinct !{!55, !49, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: argument 0"}
!56 = distinct !{!56, !49, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: %nonce.0"}
!57 = distinct !{!57, !51, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: argument 0"}
!58 = distinct !{!58, !51, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: %nonce.0"}
!59 = !{!60, !62, !48, !50, !38, !42, !34}
!60 = distinct !{!60, !61, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: %input.0"}
!61 = distinct !{!61, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E"}
!62 = distinct !{!62, !63, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: %input.0"}
!63 = distinct !{!63, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E"}
!64 = !{!65, !66, !55, !56, !57, !58, !36, !39, !40, !32, !28, !30}
!65 = distinct !{!65, !61, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: argument 0"}
!66 = distinct !{!66, !63, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: argument 0"}
!67 = !{!55, !57, !36, !40}
!68 = !{!48, !56, !50, !58, !38, !39, !42, !32, !34, !28, !30}
!69 = !{!32, !28, !30}
!70 = !{!34, !28, !30}
!71 = !{!28}
!72 = !{!30}
!73 = !{!74, !76, !78}
!74 = distinct !{!74, !75, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE: %state"}
!75 = distinct !{!75, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE"}
!76 = distinct !{!76, !77, !"_ZN11rand_chacha4guts6ChaCha13get_block_pos17h51fa6f679a2049e0E: %self"}
!77 = distinct !{!77, !"_ZN11rand_chacha4guts6ChaCha13get_block_pos17h51fa6f679a2049e0E"}
!78 = distinct !{!78, !79, !"_ZN11rand_chacha6chacha11ChaCha20Rng12get_word_pos17h391d271e5c0204b8E: %self"}
!79 = distinct !{!79, !"_ZN11rand_chacha6chacha11ChaCha20Rng12get_word_pos17h391d271e5c0204b8E"}
!80 = !{!81, !83, !74, !76, !78}
!81 = distinct !{!81, !82, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE: %state"}
!82 = distinct !{!82, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE"}
!83 = distinct !{!83, !84, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE: %state"}
!84 = distinct !{!84, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE"}
!85 = !{!86}
!86 = distinct !{!86, !87, !"_ZN85_$LT$rand_chacha..chacha..abstract12..ChaCha12Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h31374eb7e10bff25E: %self"}
!87 = distinct !{!87, !"_ZN85_$LT$rand_chacha..chacha..abstract12..ChaCha12Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h31374eb7e10bff25E"}
!88 = !{!89}
!89 = distinct !{!89, !87, !"_ZN85_$LT$rand_chacha..chacha..abstract12..ChaCha12Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h31374eb7e10bff25E: %other"}
!90 = !{!91, !93}
!91 = distinct !{!91, !92, !"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E: argument 0"}
!92 = distinct !{!92, !"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E"}
!93 = distinct !{!93, !92, !"_ZN75_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17hb8f2ea0837b569b7E: %seed"}
!94 = !{!95, !97, !91, !93}
!95 = distinct !{!95, !96, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E: argument 0"}
!96 = distinct !{!96, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E"}
!97 = distinct !{!97, !96, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E: %seed"}
!98 = !{!99, !101, !102, !103, !105, !95, !97, !91, !93}
!99 = distinct !{!99, !100, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: argument 0"}
!100 = distinct !{!100, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE"}
!101 = distinct !{!101, !100, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: %key"}
!102 = distinct !{!102, !100, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: %nonce.0"}
!103 = distinct !{!103, !104, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E: argument 0"}
!104 = distinct !{!104, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E"}
!105 = distinct !{!105, !104, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E: %key"}
!106 = !{!107, !109, !111, !113, !101, !105, !97}
!107 = distinct !{!107, !108, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: %input.0"}
!108 = distinct !{!108, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E"}
!109 = distinct !{!109, !110, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: %input.0"}
!110 = distinct !{!110, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E"}
!111 = distinct !{!111, !112, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: %key"}
!112 = distinct !{!112, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE"}
!113 = distinct !{!113, !114, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: %key"}
!114 = distinct !{!114, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE"}
!115 = !{!116, !117, !118, !119, !120, !121, !99, !102, !103, !95, !91, !93}
!116 = distinct !{!116, !108, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: argument 0"}
!117 = distinct !{!117, !110, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: argument 0"}
!118 = distinct !{!118, !112, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: argument 0"}
!119 = distinct !{!119, !112, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: %nonce.0"}
!120 = distinct !{!120, !114, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: argument 0"}
!121 = distinct !{!121, !114, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: %nonce.0"}
!122 = !{!123, !125, !111, !113, !101, !105, !97}
!123 = distinct !{!123, !124, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: %input.0"}
!124 = distinct !{!124, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E"}
!125 = distinct !{!125, !126, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: %input.0"}
!126 = distinct !{!126, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E"}
!127 = !{!128, !129, !118, !119, !120, !121, !99, !102, !103, !95, !91, !93}
!128 = distinct !{!128, !124, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: argument 0"}
!129 = distinct !{!129, !126, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: argument 0"}
!130 = !{!118, !120, !99, !103}
!131 = !{!111, !119, !113, !121, !101, !102, !105, !95, !97, !91, !93}
!132 = !{!95, !91, !93}
!133 = !{!97, !91, !93}
!134 = !{!91}
!135 = !{!93}
!136 = !{!137, !139, !141}
!137 = distinct !{!137, !138, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE: %state"}
!138 = distinct !{!138, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE"}
!139 = distinct !{!139, !140, !"_ZN11rand_chacha4guts6ChaCha13get_block_pos17h51fa6f679a2049e0E: %self"}
!140 = distinct !{!140, !"_ZN11rand_chacha4guts6ChaCha13get_block_pos17h51fa6f679a2049e0E"}
!141 = distinct !{!141, !142, !"_ZN11rand_chacha6chacha11ChaCha12Rng12get_word_pos17h68aafae48ddad3a6E: %self"}
!142 = distinct !{!142, !"_ZN11rand_chacha6chacha11ChaCha12Rng12get_word_pos17h68aafae48ddad3a6E"}
!143 = !{!144, !146, !137, !139, !141}
!144 = distinct !{!144, !145, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE: %state"}
!145 = distinct !{!145, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE"}
!146 = distinct !{!146, !147, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE: %state"}
!147 = distinct !{!147, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE"}
!148 = !{!149}
!149 = distinct !{!149, !150, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!150 = distinct !{!150, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!151 = !{!152, !153}
!152 = distinct !{!152, !150, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!153 = distinct !{!153, !150, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!154 = !{!155}
!155 = distinct !{!155, !156, !"_ZN83_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0d8c2f5733c089e3E: %self"}
!156 = distinct !{!156, !"_ZN83_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0d8c2f5733c089e3E"}
!157 = !{!158}
!158 = distinct !{!158, !156, !"_ZN83_$LT$rand_chacha..chacha..abstract8..ChaCha8Rng$u20$as$u20$core..cmp..PartialEq$GT$2eq17h0d8c2f5733c089e3E: %other"}
!159 = !{!160, !162, !163, !165, !166, !168}
!160 = distinct !{!160, !161, !"_ZN11rand_chacha4guts8get_seed17h20f1d0d58e58025dE: argument 0"}
!161 = distinct !{!161, !"_ZN11rand_chacha4guts8get_seed17h20f1d0d58e58025dE"}
!162 = distinct !{!162, !161, !"_ZN11rand_chacha4guts8get_seed17h20f1d0d58e58025dE: %state"}
!163 = distinct !{!163, !164, !"_ZN11rand_chacha4guts6ChaCha8get_seed17h5a6955c8a76c88c9E: argument 0"}
!164 = distinct !{!164, !"_ZN11rand_chacha4guts6ChaCha8get_seed17h5a6955c8a76c88c9E"}
!165 = distinct !{!165, !164, !"_ZN11rand_chacha4guts6ChaCha8get_seed17h5a6955c8a76c88c9E: %self"}
!166 = distinct !{!166, !167, !"_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E: argument 0"}
!167 = distinct !{!167, !"_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E"}
!168 = distinct !{!168, !167, !"_ZN11rand_chacha6chacha10ChaCha8Rng8get_seed17ha17848bd710de214E: %self"}
!169 = !{!170, !172, !162, !165, !168}
!170 = distinct !{!170, !171, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h26da63f0e3209928E: %state"}
!171 = distinct !{!171, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h26da63f0e3209928E"}
!172 = distinct !{!172, !173, !"_ZN11rand_chacha4guts8get_seed9impl_sse217h29dd530ba776b7abE: %state"}
!173 = distinct !{!173, !"_ZN11rand_chacha4guts8get_seed9impl_sse217h29dd530ba776b7abE"}
!174 = !{!175, !176, !160, !163, !166}
!175 = distinct !{!175, !171, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h26da63f0e3209928E: %key"}
!176 = distinct !{!176, !173, !"_ZN11rand_chacha4guts8get_seed9impl_sse217h29dd530ba776b7abE: argument 0"}
!177 = !{!178, !170, !172, !162, !165, !168}
!178 = distinct !{!178, !179, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!179 = distinct !{!179, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!180 = !{!181, !170, !172, !162, !165, !168}
!181 = distinct !{!181, !182, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!182 = distinct !{!182, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!183 = !{!184, !186, !188}
!184 = distinct !{!184, !185, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE: %state"}
!185 = distinct !{!185, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE"}
!186 = distinct !{!186, !187, !"_ZN11rand_chacha4guts6ChaCha9get_nonce17h0059471ddd6720c4E: %self"}
!187 = distinct !{!187, !"_ZN11rand_chacha4guts6ChaCha9get_nonce17h0059471ddd6720c4E"}
!188 = distinct !{!188, !189, !"_ZN11rand_chacha6chacha10ChaCha8Rng10get_stream17h6d8fe0628e64dfd5E: %self"}
!189 = distinct !{!189, !"_ZN11rand_chacha6chacha10ChaCha8Rng10get_stream17h6d8fe0628e64dfd5E"}
!190 = !{!191, !193, !184, !186, !188}
!191 = distinct !{!191, !192, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE: %state"}
!192 = distinct !{!192, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE"}
!193 = distinct !{!193, !194, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE: %state"}
!194 = distinct !{!194, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE"}
!195 = !{!196, !198, !200}
!196 = distinct !{!196, !197, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE: %state"}
!197 = distinct !{!197, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE"}
!198 = distinct !{!198, !199, !"_ZN11rand_chacha4guts6ChaCha13get_block_pos17h51fa6f679a2049e0E: %self"}
!199 = distinct !{!199, !"_ZN11rand_chacha4guts6ChaCha13get_block_pos17h51fa6f679a2049e0E"}
!200 = distinct !{!200, !201, !"_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE: %self"}
!201 = distinct !{!201, !"_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE"}
!202 = !{!203, !205, !196, !198, !200}
!203 = distinct !{!203, !204, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE: %state"}
!204 = distinct !{!204, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE"}
!205 = distinct !{!205, !206, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE: %state"}
!206 = distinct !{!206, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE"}
!207 = !{!200}
!208 = !{!209, !211}
!209 = distinct !{!209, !210, !"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E: argument 0"}
!210 = distinct !{!210, !"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E"}
!211 = distinct !{!211, !210, !"_ZN74_$LT$rand_chacha..chacha..ChaCha8Rng$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h2fce7036f0d269a4E: %seed"}
!212 = !{!213, !215, !209, !211}
!213 = distinct !{!213, !214, !"_ZN75_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h8097f785153bcc1dE: argument 0"}
!214 = distinct !{!214, !"_ZN75_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h8097f785153bcc1dE"}
!215 = distinct !{!215, !214, !"_ZN75_$LT$rand_chacha..chacha..ChaCha8Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h8097f785153bcc1dE: %seed"}
!216 = !{!217, !219, !220, !221, !223, !213, !215, !209, !211}
!217 = distinct !{!217, !218, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: argument 0"}
!218 = distinct !{!218, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE"}
!219 = distinct !{!219, !218, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: %key"}
!220 = distinct !{!220, !218, !"_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE: %nonce.0"}
!221 = distinct !{!221, !222, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E: argument 0"}
!222 = distinct !{!222, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E"}
!223 = distinct !{!223, !222, !"_ZN11rand_chacha4guts6ChaCha3new17h2d62fc0b240ae264E: %key"}
!224 = !{!225, !227, !229, !231, !219, !223, !215}
!225 = distinct !{!225, !226, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: %input.0"}
!226 = distinct !{!226, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E"}
!227 = distinct !{!227, !228, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: %input.0"}
!228 = distinct !{!228, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E"}
!229 = distinct !{!229, !230, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: %key"}
!230 = distinct !{!230, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE"}
!231 = distinct !{!231, !232, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: %key"}
!232 = distinct !{!232, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE"}
!233 = !{!234, !235, !236, !237, !238, !239, !217, !220, !221, !213, !209, !211}
!234 = distinct !{!234, !226, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: argument 0"}
!235 = distinct !{!235, !228, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: argument 0"}
!236 = distinct !{!236, !230, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: argument 0"}
!237 = distinct !{!237, !230, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: %nonce.0"}
!238 = distinct !{!238, !232, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: argument 0"}
!239 = distinct !{!239, !232, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: %nonce.0"}
!240 = !{!241, !243, !229, !231, !219, !223, !215}
!241 = distinct !{!241, !242, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: %input.0"}
!242 = distinct !{!242, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E"}
!243 = distinct !{!243, !244, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: %input.0"}
!244 = distinct !{!244, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E"}
!245 = !{!246, !247, !236, !237, !238, !239, !217, !220, !221, !213, !209, !211}
!246 = distinct !{!246, !242, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: argument 0"}
!247 = distinct !{!247, !244, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: argument 0"}
!248 = !{!236, !238, !217, !221}
!249 = !{!229, !237, !231, !239, !219, !220, !223, !213, !215, !209, !211}
!250 = !{!213, !209, !211}
!251 = !{!215, !209, !211}
!252 = !{!209}
!253 = !{!211}
!254 = !{!255, !257, !259}
!255 = distinct !{!255, !256, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE: %state"}
!256 = distinct !{!256, !"_ZN11rand_chacha4guts16get_stream_param17h0179015a1f2db20bE"}
!257 = distinct !{!257, !258, !"_ZN11rand_chacha4guts6ChaCha13get_block_pos17h51fa6f679a2049e0E: %self"}
!258 = distinct !{!258, !"_ZN11rand_chacha4guts6ChaCha13get_block_pos17h51fa6f679a2049e0E"}
!259 = distinct !{!259, !260, !"_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE: %self"}
!260 = distinct !{!260, !"_ZN11rand_chacha6chacha10ChaCha8Rng12get_word_pos17hf29502951ff28eefE"}
!261 = !{!262, !264, !255, !257, !259}
!262 = distinct !{!262, !263, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE: %state"}
!263 = distinct !{!263, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE"}
!264 = distinct !{!264, !265, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE: %state"}
!265 = distinct !{!265, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE"}
!266 = !{!267}
!267 = distinct !{!267, !268, !"_ZN11rand_chacha4guts6ChaCha5pos6417h1b3a29e9c0970937E: %self"}
!268 = distinct !{!268, !"_ZN11rand_chacha4guts6ChaCha5pos6417h1b3a29e9c0970937E"}
!269 = !{!270}
!270 = distinct !{!270, !271, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!271 = distinct !{!271, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!272 = !{!273}
!273 = distinct !{!273, !274, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!274 = distinct !{!274, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!275 = !{!276}
!276 = distinct !{!276, !277, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!277 = distinct !{!277, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!278 = !{!279}
!279 = distinct !{!279, !280, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!280 = distinct !{!280, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!281 = !{!282}
!282 = distinct !{!282, !283, !"_ZN11rand_chacha4guts6ChaCha5pos6417h15ab54b2ba09a5abE: %self"}
!283 = distinct !{!283, !"_ZN11rand_chacha4guts6ChaCha5pos6417h15ab54b2ba09a5abE"}
!284 = !{!285}
!285 = distinct !{!285, !286, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!286 = distinct !{!286, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!287 = !{!288}
!288 = distinct !{!288, !289, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!289 = distinct !{!289, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!290 = !{!291}
!291 = distinct !{!291, !292, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!292 = distinct !{!292, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!293 = !{!294}
!294 = distinct !{!294, !295, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!295 = distinct !{!295, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!296 = !{!297}
!297 = distinct !{!297, !298, !"_ZN11rand_chacha4guts6ChaCha5pos6417h851c3f82c0d401e5E: %self"}
!298 = distinct !{!298, !"_ZN11rand_chacha4guts6ChaCha5pos6417h851c3f82c0d401e5E"}
!299 = !{!300}
!300 = distinct !{!300, !301, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!301 = distinct !{!301, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!302 = !{!303}
!303 = distinct !{!303, !304, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!304 = distinct !{!304, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!305 = !{!306}
!306 = distinct !{!306, !307, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!307 = distinct !{!307, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!308 = !{!309}
!309 = distinct !{!309, !310, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!310 = distinct !{!310, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!311 = !{!312}
!312 = distinct !{!312, !313, !"_ZN11rand_chacha4guts6ChaCha5pos6417h851c3f82c0d401e5E: %self"}
!313 = distinct !{!313, !"_ZN11rand_chacha4guts6ChaCha5pos6417h851c3f82c0d401e5E"}
!314 = !{!315}
!315 = distinct !{!315, !316, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!316 = distinct !{!316, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!317 = !{!318}
!318 = distinct !{!318, !319, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!319 = distinct !{!319, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!320 = !{!321}
!321 = distinct !{!321, !322, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!322 = distinct !{!322, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!323 = !{!324}
!324 = distinct !{!324, !325, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!325 = distinct !{!325, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!326 = !{!327}
!327 = distinct !{!327, !328, !"_ZN11rand_chacha4guts6ChaCha5pos6417h1fd04917492c06f7E: %self"}
!328 = distinct !{!328, !"_ZN11rand_chacha4guts6ChaCha5pos6417h1fd04917492c06f7E"}
!329 = !{!330}
!330 = distinct !{!330, !331, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!331 = distinct !{!331, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!332 = !{!333}
!333 = distinct !{!333, !334, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!334 = distinct !{!334, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!335 = !{!336}
!336 = distinct !{!336, !337, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!337 = distinct !{!337, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!338 = !{!339}
!339 = distinct !{!339, !340, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!340 = distinct !{!340, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!341 = !{!342}
!342 = distinct !{!342, !343, !"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E: argument 0"}
!343 = distinct !{!343, !"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E"}
!344 = !{!345}
!345 = distinct !{!345, !346, !"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E: argument 0"}
!346 = distinct !{!346, !"_ZN133_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..NoS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17hb49c346eb52d3835E"}
!347 = !{!348}
!348 = distinct !{!348, !349, !"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E: argument 0"}
!349 = distinct !{!349, !"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E"}
!350 = !{!351}
!351 = distinct !{!351, !352, !"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E: argument 0"}
!352 = distinct !{!352, !"_ZN134_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$ppv_lite86..x86_64..YesS4$C$NI$GT$$u20$as$u20$ppv_lite86..types..Vec4$LT$u32$GT$$GT$6insert17h4323ea6a890f3e57E"}
!353 = !{!354, !356}
!354 = distinct !{!354, !355, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE: %state"}
!355 = distinct !{!355, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h845caf345c64fe4cE"}
!356 = distinct !{!356, !357, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE: %state"}
!357 = distinct !{!357, !"_ZN11rand_chacha4guts16get_stream_param9impl_sse217h144ce6a9b72b112bE"}
!358 = !{!"branch_weights", i32 2000, i32 1}
!359 = !{!"misexpect", i64 0, i64 2000, i64 1}
!360 = !{!361}
!361 = distinct !{!361, !362, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h2ef49ebb3351ba2eE: %state"}
!362 = distinct !{!362, !"_ZN11rand_chacha4guts16get_stream_param7fn_impl17h2ef49ebb3351ba2eE"}
!363 = !{!364, !366}
!364 = distinct !{!364, !365, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h26da63f0e3209928E: %state"}
!365 = distinct !{!365, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h26da63f0e3209928E"}
!366 = distinct !{!366, !367, !"_ZN11rand_chacha4guts8get_seed9impl_sse217h29dd530ba776b7abE: %state"}
!367 = distinct !{!367, !"_ZN11rand_chacha4guts8get_seed9impl_sse217h29dd530ba776b7abE"}
!368 = !{!369, !370}
!369 = distinct !{!369, !365, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h26da63f0e3209928E: %key"}
!370 = distinct !{!370, !367, !"_ZN11rand_chacha4guts8get_seed9impl_sse217h29dd530ba776b7abE: argument 0"}
!371 = !{!372, !364, !366}
!372 = distinct !{!372, !373, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!373 = distinct !{!373, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!374 = !{!375, !364, !366}
!375 = distinct !{!375, !376, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!376 = distinct !{!376, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!377 = !{!378}
!378 = distinct !{!378, !379, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h496d0dd55de3e7eaE: %state"}
!379 = distinct !{!379, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h496d0dd55de3e7eaE"}
!380 = !{!381}
!381 = distinct !{!381, !379, !"_ZN11rand_chacha4guts8get_seed7fn_impl17h496d0dd55de3e7eaE: %key"}
!382 = !{!383, !378}
!383 = distinct !{!383, !384, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!384 = distinct !{!384, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!385 = !{!386, !378}
!386 = distinct !{!386, !387, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E: %a"}
!387 = distinct !{!387, !"_ZN4core9core_arch3x864sse216_mm_storeu_si12817h1e848e06eaa76886E"}
!388 = !{!389, !391, !393}
!389 = distinct !{!389, !390, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE: %xs.0"}
!390 = distinct !{!390, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE"}
!391 = distinct !{!391, !392, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: %nonce.0"}
!392 = distinct !{!392, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE"}
!393 = distinct !{!393, !394, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: %nonce.0"}
!394 = distinct !{!394, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE"}
!395 = !{!396, !397, !398, !399}
!396 = distinct !{!396, !392, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: argument 0"}
!397 = distinct !{!397, !392, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17hfd0295ed6783fc1aE: %key"}
!398 = distinct !{!398, !394, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: argument 0"}
!399 = distinct !{!399, !394, !"_ZN11rand_chacha4guts11init_chacha9impl_sse217h47f86765bece689bE: %key"}
!400 = !{!396, !397, !391, !398, !399, !393}
!401 = !{!402, !391, !393}
!402 = distinct !{!402, !403, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE: %xs.0"}
!403 = distinct !{!403, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE"}
!404 = !{!405, !391, !393}
!405 = distinct !{!405, !406, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE: %xs.0"}
!406 = distinct !{!406, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE"}
!407 = !{!408, !410, !397, !399}
!408 = distinct !{!408, !409, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: %input.0"}
!409 = distinct !{!409, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E"}
!410 = distinct !{!410, !411, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: %input.0"}
!411 = distinct !{!411, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E"}
!412 = !{!413, !414, !396, !391, !398, !393}
!413 = distinct !{!413, !409, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: argument 0"}
!414 = distinct !{!414, !411, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: argument 0"}
!415 = !{!416, !418, !397, !399}
!416 = distinct !{!416, !417, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: %input.0"}
!417 = distinct !{!417, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E"}
!418 = distinct !{!418, !419, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: %input.0"}
!419 = distinct !{!419, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E"}
!420 = !{!421, !422, !396, !391, !398, !393}
!421 = distinct !{!421, !417, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h396a375d7601aa94E: argument 0"}
!422 = distinct !{!422, !419, !"_ZN10ppv_lite865types7Machine7read_le17hf048a33726087a23E: argument 0"}
!423 = !{!396, !398}
!424 = !{!397, !391, !399, !393}
!425 = !{!426, !428}
!426 = distinct !{!426, !427, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE: %xs.0"}
!427 = distinct !{!427, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE"}
!428 = distinct !{!428, !429, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17ha62230c7b837ffabE: %nonce.0"}
!429 = distinct !{!429, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17ha62230c7b837ffabE"}
!430 = !{!431, !432}
!431 = distinct !{!431, !429, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17ha62230c7b837ffabE: argument 0"}
!432 = distinct !{!432, !429, !"_ZN11rand_chacha4guts11init_chacha7fn_impl17ha62230c7b837ffabE: %key"}
!433 = !{!431, !432, !428}
!434 = !{!435, !428}
!435 = distinct !{!435, !436, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE: %xs.0"}
!436 = distinct !{!436, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE"}
!437 = !{!438, !428}
!438 = distinct !{!438, !439, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE: %xs.0"}
!439 = distinct !{!439, !"_ZN11rand_chacha4guts10read_u32le17h1cb640a927078f4cE"}
!440 = !{!441, !443, !432}
!441 = distinct !{!441, !442, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h576161d53b68bdc6E: %input.0"}
!442 = distinct !{!442, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h576161d53b68bdc6E"}
!443 = distinct !{!443, !444, !"_ZN10ppv_lite865types7Machine7read_le17hd5fe3f3ad8c733eeE: %input.0"}
!444 = distinct !{!444, !"_ZN10ppv_lite865types7Machine7read_le17hd5fe3f3ad8c733eeE"}
!445 = !{!446, !447, !431, !428}
!446 = distinct !{!446, !442, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h576161d53b68bdc6E: argument 0"}
!447 = distinct !{!447, !444, !"_ZN10ppv_lite865types7Machine7read_le17hd5fe3f3ad8c733eeE: argument 0"}
!448 = !{!449, !451, !432}
!449 = distinct !{!449, !450, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h576161d53b68bdc6E: %input.0"}
!450 = distinct !{!450, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h576161d53b68bdc6E"}
!451 = distinct !{!451, !452, !"_ZN10ppv_lite865types7Machine7read_le17hd5fe3f3ad8c733eeE: %input.0"}
!452 = distinct !{!452, !"_ZN10ppv_lite865types7Machine7read_le17hd5fe3f3ad8c733eeE"}
!453 = !{!454, !455, !431, !428}
!454 = distinct !{!454, !450, !"_ZN106_$LT$ppv_lite86..x86_64..sse2..u32x4_sse2$LT$S3$C$S4$C$NI$GT$$u20$as$u20$ppv_lite86..types..StoreBytes$GT$14unsafe_read_le17h576161d53b68bdc6E: argument 0"}
!455 = distinct !{!455, !452, !"_ZN10ppv_lite865types7Machine7read_le17hd5fe3f3ad8c733eeE: argument 0"}
!456 = !{!431}
!457 = !{!432, !428}
