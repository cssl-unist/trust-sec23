; ModuleID = 'rand-41d2c4f10a47baa0.bc'
source_filename = "rand.6ua2iz6v-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"core::fmt::Formatter" = type { [0 x i64], { i64, i64 }, [0 x i64], { i64, i64 }, [0 x i64], { {}*, [3 x i64]* }, [0 x i32], i32, [0 x i32], i32, [0 x i8], i8, [7 x i8] }
%"std::thread::AccessError" = type { [0 x i8], {}, [0 x i8] }
%"std::io::Error" = type { [0 x i64], %"std::io::error::Repr", [0 x i64] }
%"std::io::error::Repr" = type { [0 x i8], i8, [15 x i8] }
%"distributions::uniform::UniformInt<u64>" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"distributions::uniform::UniformInt<u32>" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"distributions::uniform::UniformDurationMode" = type { [0 x i32], i32, [9 x i32] }
%"distributions::uniform::Uniform<u64>" = type { [0 x i64], %"distributions::uniform::UniformInt<u64>", [0 x i64] }
%"distributions::uniform::Uniform<u32>" = type { [0 x i32], %"distributions::uniform::UniformInt<u32>", [0 x i32] }
%"rand_chacha::ChaCha12Rng" = type { [0 x i64], %"rand_core::block::BlockRng<rand_chacha::ChaCha12Core>", [0 x i64] }
%"rand_core::block::BlockRng<rand_chacha::ChaCha12Core>" = type { [0 x i64], i64, [0 x i32], %"rand_chacha::chacha::Array64<u32>", [2 x i32], %"rand_chacha::ChaCha12Core", [0 x i64] }
%"rand_chacha::chacha::Array64<u32>" = type { [0 x i32], [64 x i32], [0 x i32] }
%"rand_chacha::ChaCha12Core" = type { [0 x i64], %"rand_chacha::guts::ChaCha", [0 x i64] }
%"rand_chacha::guts::ChaCha" = type { [0 x i64], %"ppv_lite86::x86_64::vec128_storage", [0 x i64], %"ppv_lite86::x86_64::vec128_storage", [0 x i64], %"ppv_lite86::x86_64::vec128_storage", [0 x i64] }
%"ppv_lite86::x86_64::vec128_storage" = type { [2 x i64] }
%"std::vec::Vec<usize>" = type { [0 x i64], { i64*, i64 }, [0 x i64], i64, [0 x i64] }
%"std::vec::Vec<u32>" = type { [0 x i64], { i32*, i64 }, [0 x i64], i64, [0 x i64] }
%"std::vec::IntoIter<usize>" = type { [0 x i8], %"core::marker::PhantomData<usize>", [0 x i8], i64*, [0 x i64], i64, [0 x i64], i64*, [0 x i64], i64*, [0 x i64] }
%"core::marker::PhantomData<usize>" = type {}
%"std::vec::IntoIter<u32>" = type { [0 x i8], %"core::marker::PhantomData<u32>", [0 x i8], i32*, [0 x i64], i64, [0 x i64], i32*, [0 x i64], i32*, [0 x i64] }
%"core::marker::PhantomData<u32>" = type {}
%"core::panic::Location" = type { [0 x i64], { [0 x i8]*, i64 }, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"rand_core::OsRng" = type {}
%"std::sync::Once" = type { [0 x i8], %"core::marker::PhantomData<*const std::sync::once::Waiter>", [0 x i8], %"core::sync::atomic::AtomicUsize", [0 x i64] }
%"core::marker::PhantomData<*const std::sync::once::Waiter>" = type {}
%"core::sync::atomic::AtomicUsize" = type { [0 x i64], i64, [0 x i64] }
%"core::fmt::DebugTuple" = type { [0 x i64], %"core::fmt::Formatter"*, [0 x i64], i64, [0 x i8], i8, [0 x i8], i8, [6 x i8] }
%"core::fmt::DebugList" = type { [0 x i64], %"core::fmt::builders::DebugInner", [0 x i64] }
%"core::fmt::builders::DebugInner" = type { [0 x i64], %"core::fmt::Formatter"*, [0 x i8], i8, [0 x i8], i8, [6 x i8] }
%"core::fmt::DebugStruct" = type { [0 x i64], %"core::fmt::Formatter"*, [0 x i8], i8, [0 x i8], i8, [6 x i8] }
%"std::io::error::Custom" = type { [0 x i64], { {}*, [3 x i64]* }, [0 x i8], i8, [7 x i8] }
%"distributions::bernoulli::BernoulliError::InvalidProbability" = type {}
%"distributions::slice::EmptySlice" = type {}
%"core::fmt::Arguments" = type { [0 x i64], { [0 x { [0 x i8]*, i64 }]*, i64 }, [0 x i64], { i64*, i64 }, [0 x i64], { [0 x { i8*, i64* }]*, i64 }, [0 x i64] }
%"rngs::adapter::read::ReadError" = type { [0 x i64], %"std::io::Error", [0 x i64] }
%"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>" = type { [0 x i8], %"rand_core::OsRng", [0 x i8], %"rand_chacha::ChaCha12Core", [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [1 x i64] }
%"rand_core::block::BlockRng<rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>>" = type { [0 x i64], i64, [0 x i32], %"rand_chacha::chacha::Array64<u32>", [2 x i32], %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>", [0 x i64] }
%"seq::index::IndexVec" = type { [0 x i64], i64, [3 x i64] }
%"distributions::float::OpenClosed01" = type {}
%"distributions::float::Open01" = type {}
%"distributions::other::Alphanumeric" = type {}
%"distributions::uniform::UniformChar" = type { [0 x i32], %"distributions::uniform::UniformInt<u32>", [0 x i32] }
%"distributions::uniform::UniformDuration" = type { [0 x i64], %"distributions::uniform::UniformDurationMode", [0 x i32], i32, [1 x i32] }
%"distributions::Standard" = type {}
%"rngs::std::StdRng" = type { [0 x i64], %"rand_chacha::ChaCha12Rng", [0 x i64] }
%"seq::index::IndexVecIter" = type { [0 x i64], i64, [2 x i64] }
%"seq::index::IndexVecIntoIter" = type { [0 x i64], i64, [4 x i64] }
%"unwind::libunwind::_Unwind_Exception" = type { [0 x i64], i64, [0 x i64], void (i32, %"unwind::libunwind::_Unwind_Exception"*)*, [0 x i64], [6 x i64], [0 x i64] }
%"unwind::libunwind::_Unwind_Context" = type { [0 x i8] }

@vtable.0 = private unnamed_addr constant { void (i8**)*, i64, i64, void (i8**, { i64, i8 }*)*, void (i8**, { i64, i8 }*)* } { void (i8**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (i8**)*), i64 8, i64 8, void (i8**, { i64, i8 }*)* @"_ZN3std4sync4once4Once9call_once28_$u7b$$u7b$closure$u7d$$u7d$17h6e7ecf2f120c6503E", void (i8**, { i64, i8 }*)* @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17ha86f48d5e874fe76E" }, align 8
@alloc1179 = private unnamed_addr constant <{ [40 x i8] }> <{ [40 x i8] c"/trust/rust/library/std/src/sync/once.rs" }>, align 1
@alloc1180 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [40 x i8] }>, <{ [40 x i8] }>* @alloc1179, i32 0, i32 0, i32 0), [16 x i8] c"(\00\00\00\00\00\00\00\05\01\00\002\00\00\00" }>, align 8
@alloc1181 = private unnamed_addr constant <{ [70 x i8] }> <{ [70 x i8] c"cannot access a Thread Local Storage value during or after destruction" }>, align 1
@alloc1182 = private unnamed_addr constant <{ [43 x i8] }> <{ [43 x i8] c"/trust/rust/library/std/src/thread/local.rs" }>, align 1
@alloc1183 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [43 x i8] }>, <{ [43 x i8] }>* @alloc1182, i32 0, i32 0, i32 0), [16 x i8] c"+\00\00\00\00\00\00\00\F8\00\00\00\1A\00\00\00" }>, align 8
@vtable.1 = private unnamed_addr constant { void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* } { void (i64**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (i64**)*), i64 8, i64 8, i1 (i64**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h9633ef4b088cdc0aE" }, align 8
@vtable.2 = private unnamed_addr constant { void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* } { void (i32**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (i32**)*), i64 8, i64 8, i1 (i32**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hee72a8456183bcc4E" }, align 8
@alloc1198 = private unnamed_addr constant <{ [43 x i8] }> <{ [43 x i8] c"called `Option::unwrap()` on a `None` value" }>, align 1
@vtable.3 = private unnamed_addr constant { void (%"std::thread::AccessError"*)*, i64, i64, i1 (%"std::thread::AccessError"*, %"core::fmt::Formatter"*)* } { void (%"std::thread::AccessError"*)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"std::thread::AccessError"*)*), i64 0, i64 1, i1 (%"std::thread::AccessError"*, %"core::fmt::Formatter"*)* @"_ZN68_$LT$std..thread..local..AccessError$u20$as$u20$core..fmt..Debug$GT$3fmt17ha315f601bcb7816fE" }, align 8
@alloc1006 = private unnamed_addr constant <{ [0 x i8] }> zeroinitializer, align 8
@alloc1200 = private unnamed_addr constant <{ [8 x i8] }> <{ [8 x i8] c"IntoIter" }>, align 1
@vtable.4 = private unnamed_addr constant { void ({ [0 x i64]*, i64 }*)*, i64, i64, i1 ({ [0 x i64]*, i64 }*, %"core::fmt::Formatter"*)* } { void ({ [0 x i64]*, i64 }*)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void ({ [0 x i64]*, i64 }*)*), i64 16, i64 8, i1 ({ [0 x i64]*, i64 }*, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb1b60f9d2f50b2daE" }, align 8
@vtable.5 = private unnamed_addr constant { void ({ [0 x i32]*, i64 }*)*, i64, i64, i1 ({ [0 x i32]*, i64 }*, %"core::fmt::Formatter"*)* } { void ({ [0 x i32]*, i64 }*)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void ({ [0 x i32]*, i64 }*)*), i64 16, i64 8, i1 ({ [0 x i32]*, i64 }*, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h817059568843a302E" }, align 8
@alloc1203 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"UnsafeCell" }>, align 1
@alloc1205 = private unnamed_addr constant <{ [4 x i8] }> <{ [4 x i8] c"Iter" }>, align 1
@alloc1213 = private unnamed_addr constant <{ [82 x i8] }> <{ [82 x i8] c"/root/.cargo/registry/src/github.com-1ecc6299db9ec823/rand_core-0.6.3/src/block.rs" }>, align 1
@alloc1209 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [82 x i8] }>, <{ [82 x i8] }>* @alloc1213, i32 0, i32 0, i32 0), [16 x i8] c"R\00\00\00\00\00\00\00\E5\00\00\00P\00\00\00" }>, align 8
@alloc992 = private unnamed_addr constant <{ [8 x i8] }> zeroinitializer, align 1
@alloc1215 = private unnamed_addr constant <{ [45 x i8] }> <{ [45 x i8] c"p is outside [0, 1] in Bernoulli distribution" }>, align 1
@alloc1003 = private unnamed_addr constant <{ [60 x i8] }> <{ [60 x i8] c"Tried to create a `distributions::Slice` with an empty slice" }>, align 1
@alloc1004 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [60 x i8] }>, <{ [60 x i8] }>* @alloc1003, i32 0, i32 0, i32 0), [8 x i8] c"<\00\00\00\00\00\00\00" }>, align 8
@alloc1216 = private unnamed_addr constant <{ [47 x i8] }> <{ [47 x i8] c"Too many weights (hit u32::MAX) in distribution" }>, align 1
@alloc1217 = private unnamed_addr constant <{ [36 x i8] }> <{ [36 x i8] c"All weights are zero in distribution" }>, align 1
@alloc1218 = private unnamed_addr constant <{ [35 x i8] }> <{ [35 x i8] c"A weight is invalid in distribution" }>, align 1
@alloc1219 = private unnamed_addr constant <{ [35 x i8] }> <{ [35 x i8] c"No weights provided in distribution" }>, align 1
@alloc1018 = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"ReadError: " }>, align 1
@alloc1019 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [11 x i8] }>, <{ [11 x i8] }>* @alloc1018, i32 0, i32 0, i32 0), [8 x i8] c"\0B\00\00\00\00\00\00\00" }>, align 8
@vtable.6 = private unnamed_addr constant { void (%"std::io::Error"*)*, i64, i64, { i8*, i8* } (%"std::io::Error"*)*, i64 (%"std::io::Error"*)*, i64* (%"std::io::Error"*)*, { [0 x i8]*, i64 } (%"std::io::Error"*)*, { i8*, i8* } (%"std::io::Error"*)*, i1 (%"std::io::Error"*, %"core::fmt::Formatter"*)*, i1 (%"std::io::Error"*, %"core::fmt::Formatter"*)* } { void (%"std::io::Error"*)* @_ZN4core3ptr13drop_in_place17hbc017d5edc7bec99E, i64 16, i64 8, { i8*, i8* } (%"std::io::Error"*)* @"_ZN59_$LT$std..io..error..Error$u20$as$u20$std..error..Error$GT$6source17h58eb92854d84e79fE", i64 (%"std::io::Error"*)* @_ZN3std5error5Error7type_id17h387f56ffd192d452E, i64* (%"std::io::Error"*)* @_ZN3std5error5Error9backtrace17h7dc068b48f6f4dd3E, { [0 x i8]*, i64 } (%"std::io::Error"*)* @"_ZN59_$LT$std..io..error..Error$u20$as$u20$std..error..Error$GT$11description17hdc6ea995e10d5d20E", { i8*, i8* } (%"std::io::Error"*)* @"_ZN59_$LT$std..io..error..Error$u20$as$u20$std..error..Error$GT$5cause17h1043acf78dfb3752E", i1 (%"std::io::Error"*, %"core::fmt::Formatter"*)* @"_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17ha444a7daee083529E", i1 (%"std::io::Error"*, %"core::fmt::Formatter"*)* @"_ZN58_$LT$std..io..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h92bc210ff9abc8b7E" }, align 8
@_ZN4rand4rngs7adapter9reseeding4fork26RESEEDING_RNG_FORK_COUNTER17h9a9bdcd883a666abE = internal global <{ [8 x i8] }> zeroinitializer, align 8
@_ZN4rand4rngs7adapter9reseeding4fork21register_fork_handler8REGISTER17haea42ddb7cd0f47dE = internal global <{ [8 x i8] }> zeroinitializer, align 8
@alloc1220 = private unnamed_addr constant <{ [9 x i8] }> <{ [9 x i8] c"Bernoulli" }>, align 1
@alloc1221 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"p_int" }>, align 1
@vtable.7 = private unnamed_addr constant { void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* } { void (i64**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (i64**)*), i64 8, i64 8, i1 (i64**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h86e40719d832eda4E" }, align 8
@alloc1222 = private unnamed_addr constant <{ [18 x i8] }> <{ [18 x i8] c"InvalidProbability" }>, align 1
@alloc1223 = private unnamed_addr constant <{ [12 x i8] }> <{ [12 x i8] c"OpenClosed01" }>, align 1
@alloc1224 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"Open01" }>, align 1
@alloc1225 = private unnamed_addr constant <{ [12 x i8] }> <{ [12 x i8] c"Alphanumeric" }>, align 1
@alloc1226 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"EmptySlice" }>, align 1
@alloc1227 = private unnamed_addr constant <{ [7 x i8] }> <{ [7 x i8] c"TooMany" }>, align 1
@alloc1228 = private unnamed_addr constant <{ [14 x i8] }> <{ [14 x i8] c"AllWeightsZero" }>, align 1
@alloc1229 = private unnamed_addr constant <{ [13 x i8] }> <{ [13 x i8] c"InvalidWeight" }>, align 1
@alloc1230 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"NoItem" }>, align 1
@alloc1232 = private unnamed_addr constant <{ [7 x i8] }> <{ [7 x i8] c"Uniform" }>, align 1
@vtable.8 = private unnamed_addr constant { void (%"distributions::uniform::UniformInt<u64>"**)*, i64, i64, i1 (%"distributions::uniform::UniformInt<u64>"**, %"core::fmt::Formatter"*)* } { void (%"distributions::uniform::UniformInt<u64>"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"distributions::uniform::UniformInt<u64>"**)*), i64 8, i64 8, i1 (%"distributions::uniform::UniformInt<u64>"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha4149295b33a0b62E" }, align 8
@vtable.9 = private unnamed_addr constant { void (%"distributions::uniform::UniformInt<u32>"**)*, i64, i64, i1 (%"distributions::uniform::UniformInt<u32>"**, %"core::fmt::Formatter"*)* } { void (%"distributions::uniform::UniformInt<u32>"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"distributions::uniform::UniformInt<u32>"**)*), i64 8, i64 8, i1 (%"distributions::uniform::UniformInt<u32>"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbda29d2ac4617786E" }, align 8
@alloc1237 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"UniformInt" }>, align 1
@alloc1238 = private unnamed_addr constant <{ [3 x i8] }> <{ [3 x i8] c"low" }>, align 1
@alloc1239 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"range" }>, align 1
@alloc1240 = private unnamed_addr constant <{ [1 x i8] }> <{ [1 x i8] c"z" }>, align 1
@alloc1241 = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"UniformChar" }>, align 1
@alloc1242 = private unnamed_addr constant <{ [7 x i8] }> <{ [7 x i8] c"sampler" }>, align 1
@alloc1243 = private unnamed_addr constant <{ [15 x i8] }> <{ [15 x i8] c"UniformDuration" }>, align 1
@alloc1244 = private unnamed_addr constant <{ [4 x i8] }> <{ [4 x i8] c"mode" }>, align 1
@vtable.a = private unnamed_addr constant { void (%"distributions::uniform::UniformDurationMode"**)*, i64, i64, i1 (%"distributions::uniform::UniformDurationMode"**, %"core::fmt::Formatter"*)* } { void (%"distributions::uniform::UniformDurationMode"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"distributions::uniform::UniformDurationMode"**)*), i64 8, i64 8, i1 (%"distributions::uniform::UniformDurationMode"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h53bd0ea524f9d07cE" }, align 8
@alloc1245 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"offset" }>, align 1
@alloc1246 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"Large" }>, align 1
@alloc1247 = private unnamed_addr constant <{ [8 x i8] }> <{ [8 x i8] c"max_secs" }>, align 1
@alloc1248 = private unnamed_addr constant <{ [9 x i8] }> <{ [9 x i8] c"max_nanos" }>, align 1
@alloc1253 = private unnamed_addr constant <{ [4 x i8] }> <{ [4 x i8] c"secs" }>, align 1
@vtable.b = private unnamed_addr constant { void (%"distributions::uniform::Uniform<u64>"**)*, i64, i64, i1 (%"distributions::uniform::Uniform<u64>"**, %"core::fmt::Formatter"*)* } { void (%"distributions::uniform::Uniform<u64>"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"distributions::uniform::Uniform<u64>"**)*), i64 8, i64 8, i1 (%"distributions::uniform::Uniform<u64>"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h76009fecdd873ad2E" }, align 8
@alloc1250 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"Medium" }>, align 1
@alloc1254 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"nanos" }>, align 1
@alloc1252 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"Small" }>, align 1
@vtable.c = private unnamed_addr constant { void (%"distributions::uniform::Uniform<u32>"**)*, i64, i64, i1 (%"distributions::uniform::Uniform<u32>"**, %"core::fmt::Formatter"*)* } { void (%"distributions::uniform::Uniform<u32>"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"distributions::uniform::Uniform<u32>"**)*), i64 8, i64 8, i1 (%"distributions::uniform::Uniform<u32>"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h039130c6296bcea7E" }, align 8
@alloc1255 = private unnamed_addr constant <{ [8 x i8] }> <{ [8 x i8] c"Standard" }>, align 1
@alloc1256 = private unnamed_addr constant <{ [9 x i8] }> <{ [9 x i8] c"ReadError" }>, align 1
@vtable.d = private unnamed_addr constant { void (%"std::io::Error"**)*, i64, i64, i1 (%"std::io::Error"**, %"core::fmt::Formatter"*)* } { void (%"std::io::Error"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"std::io::Error"**)*), i64 8, i64 8, i1 (%"std::io::Error"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha2ad1c8f62c73869E" }, align 8
@alloc1257 = private unnamed_addr constant <{ [7 x i8] }> <{ [7 x i8] c"StepRng" }>, align 1
@alloc1258 = private unnamed_addr constant <{ [1 x i8] }> <{ [1 x i8] c"v" }>, align 1
@alloc1259 = private unnamed_addr constant <{ [1 x i8] }> <{ [1 x i8] c"a" }>, align 1
@alloc1260 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"StdRng" }>, align 1
@vtable.e = private unnamed_addr constant { void (%"rand_chacha::ChaCha12Rng"**)*, i64, i64, i1 (%"rand_chacha::ChaCha12Rng"**, %"core::fmt::Formatter"*)* } { void (%"rand_chacha::ChaCha12Rng"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"rand_chacha::ChaCha12Rng"**)*), i64 8, i64 8, i1 (%"rand_chacha::ChaCha12Rng"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha49d4adf2bb8fce0E" }, align 8
@alloc1261 = private unnamed_addr constant <{ [9 x i8] }> <{ [9 x i8] c"ThreadRng" }>, align 1
@alloc1262 = private unnamed_addr constant <{ [3 x i8] }> <{ [3 x i8] c"rng" }>, align 1
@vtable.f = private unnamed_addr constant { void (i64***)*, i64, i64, i1 (i64***, %"core::fmt::Formatter"*)* } { void (i64***)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (i64***)*), i64 8, i64 8, i1 (i64***, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h04bc593c1a772388E" }, align 8
@alloc994 = private unnamed_addr constant <{ [33 x i8] }> <{ [33 x i8] c"could not initialize thread_rng: " }>, align 1
@alloc995 = private unnamed_addr constant <{ i8*, [8 x i8] }> <{ i8* getelementptr inbounds (<{ [33 x i8] }>, <{ [33 x i8] }>* @alloc994, i32 0, i32 0, i32 0), [8 x i8] c"!\00\00\00\00\00\00\00" }>, align 8
@alloc1263 = private unnamed_addr constant <{ [83 x i8] }> <{ [83 x i8] c"/root/.cargo/registry/src/github.com-1ecc6299db9ec823/rand-0.8.4/src/rngs/thread.rs" }>, align 1
@alloc1264 = private unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [83 x i8] }>, <{ [83 x i8] }>* @alloc1263, i32 0, i32 0, i32 0), [16 x i8] c"S\00\00\00\00\00\00\00G\00\00\00\11\00\00\00" }>, align 8
@_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E = internal thread_local global <{ [16 x i8] }> zeroinitializer, align 8
@alloc1269 = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"USize" }>, align 1
@vtable.g = private unnamed_addr constant { void (%"std::vec::Vec<usize>"**)*, i64, i64, i1 (%"std::vec::Vec<usize>"**, %"core::fmt::Formatter"*)* } { void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E, i64 8, i64 8, i1 (%"std::vec::Vec<usize>"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h41a93829653e0c8dE" }, align 8
@alloc1270 = private unnamed_addr constant <{ [3 x i8] }> <{ [3 x i8] c"U32" }>, align 1
@vtable.h = private unnamed_addr constant { void (%"std::vec::Vec<u32>"**)*, i64, i64, i1 (%"std::vec::Vec<u32>"**, %"core::fmt::Formatter"*)* } { void (%"std::vec::Vec<u32>"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"std::vec::Vec<u32>"**)*), i64 8, i64 8, i1 (%"std::vec::Vec<u32>"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hc8dae25808d1ef2dE" }, align 8
@vtable.i = private unnamed_addr constant { void ({ i64*, i64* }**)*, i64, i64, i1 ({ i64*, i64* }**, %"core::fmt::Formatter"*)* } { void ({ i64*, i64* }**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void ({ i64*, i64* }**)*), i64 8, i64 8, i1 ({ i64*, i64* }**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d4459423a121dc3E" }, align 8
@vtable.j = private unnamed_addr constant { void ({ i32*, i32* }**)*, i64, i64, i1 ({ i32*, i32* }**, %"core::fmt::Formatter"*)* } { void ({ i32*, i32* }**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void ({ i32*, i32* }**)*), i64 8, i64 8, i1 ({ i32*, i32* }**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h0d781fe16112ed6fE" }, align 8
@vtable.k = private unnamed_addr constant { void (%"std::vec::IntoIter<usize>"**)*, i64, i64, i1 (%"std::vec::IntoIter<usize>"**, %"core::fmt::Formatter"*)* } { void (%"std::vec::IntoIter<usize>"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"std::vec::IntoIter<usize>"**)*), i64 8, i64 8, i1 (%"std::vec::IntoIter<usize>"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3208077ea16feda8E" }, align 8
@vtable.l = private unnamed_addr constant { void (%"std::vec::IntoIter<u32>"**)*, i64, i64, i1 (%"std::vec::IntoIter<u32>"**, %"core::fmt::Formatter"*)* } { void (%"std::vec::IntoIter<u32>"**)* bitcast (void (%"std::vec::Vec<usize>"**)* @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E to void (%"std::vec::IntoIter<u32>"**)*), i64 8, i64 8, i1 (%"std::vec::IntoIter<u32>"**, %"core::fmt::Formatter"*)* @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he01dd123247b523aE" }, align 8

@"_ZN72_$LT$rand..rngs..thread..ThreadRng$u20$as$u20$core..default..Default$GT$7default17h53d20db0c2c7b375E" = unnamed_addr alias i64* (), i64* ()* @_ZN4rand4rngs6thread10thread_rng17h2cb0672f860288ceE

; Function Attrs: nonlazybind uwtable
define internal void @"_ZN3std4sync4once4Once9call_once28_$u7b$$u7b$closure$u7d$$u7d$17h6e7ecf2f120c6503E"(i8** nocapture readonly align 8 dereferenceable(8) %_1, { i64, i8 }* mpk_immut nocapture readnone align 8 dereferenceable(16) %_2) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_5 = load i8*, i8** %_1, align 8, !nonnull !2
  %x.val.i.i.i.i.i = load i8, i8* %_5, align 1
  %0 = and i8 %x.val.i.i.i.i.i, 1
  store i8 0, i8* %_5, align 1
  %.not = icmp eq i8 %0, 0
  br i1 %.not, label %bb1.i, label %"_ZN4core6option15Option$LT$T$GT$6unwrap17h6c5b45a30cb86864E.exit"

bb1.i:                                            ; preds = %start
  tail call void @_ZN4core9panicking5panic17hc14ab8d72efd34afE([0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [43 x i8] }>* @alloc1198 to [0 x i8]*), i64 43, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc1180 to %"core::panic::Location"*))
  unreachable

"_ZN4core6option15Option$LT$T$GT$6unwrap17h6c5b45a30cb86864E.exit": ; preds = %start
  %_2.i = tail call i32 @pthread_atfork(i64* mpk_immut null, i64* mpk_immut null, i64* mpk_immut bitcast (void ()* @_ZN4rand4rngs7adapter9reseeding4fork12fork_handler17h6bff1484396c250eE to i64*)) #17
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal i64 @_ZN3std5error5Error7type_id17h387f56ffd192d452E(%"std::io::Error"* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #1 {
start:
  ret i64 8497881545150036703
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal mpk_immut noalias align 8 dereferenceable_or_null(64) i64* @_ZN3std5error5Error9backtrace17h7dc068b48f6f4dd3E(%"std::io::Error"* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #1 {
start:
  ret i64* null
}

; Function Attrs: noinline nonlazybind uwtable
define internal fastcc mpk_immut align 8 dereferenceable_or_null(8) i64* @"_ZN3std6thread5local4fast12Key$LT$T$GT$14try_initialize17hd1125a449f5d2dc8E"() unnamed_addr #2 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %rng.i.i.i.i = alloca %"rand_core::OsRng", align 1
  %_12.i.i.i.i.i.i.i = alloca i8*, align 8
  %f.i.i.i.i.i.i.i = alloca i8, align 1
  %_6.sroa.0.i.sroa.4.i.i.i = alloca [40 x i8], align 8
  %_2.i.i.i.i.i = alloca %"rand_chacha::guts::ChaCha", align 16
  %_15.i.i.i.i = alloca [32 x i8], align 1
  %seed.i.i.i.i = alloca [32 x i8], align 1
  %_8.sroa.0.sroa.4.i.i.i = alloca [64 x i32], align 8
  %_8.sroa.0.sroa.5.sroa.5.i.i.i = alloca [40 x i8], align 8
  %rng.sroa.5.sroa.5.i.i.i = alloca [40 x i8], align 8
  %r.sroa.0.sroa.4.i.i.i = alloca [5 x i64], align 8
  %0 = getelementptr <{ [16 x i8] }>, <{ [16 x i8] }>* @_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E, i64 0, i32 0, i64 8
  %1 = load i8, i8* %0, align 8, !range !3
  switch i8 %1, label %bb3.i1 [
    i8 0, label %bb4.i
    i8 1, label %bb8
    i8 2, label %bb10
  ]

bb3.i1:                                           ; preds = %start
  br label %UnifiedUnreachableBlock

bb4.i:                                            ; preds = %start
  %2 = getelementptr <{ [16 x i8] }>, <{ [16 x i8] }>* @_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E, i64 0, i32 0, i64 0
  tail call void @_ZN3std3sys4unix17thread_local_dtor13register_dtor17h55b3b522a1e219b3E(i8* mpk_unsafe %2, void (i8*)* mpk_immut nonnull @_ZN3std6thread5local4fast13destroy_value17h68e464754736844bE)
  %3 = getelementptr <{ [16 x i8] }>, <{ [16 x i8] }>* @_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E, i64 0, i32 0, i64 8
  store i8 1, i8* %3, align 8
  br label %bb8

bb8:                                              ; preds = %bb4.i, %start
  %r.sroa.0.sroa.4.0.sroa_idx.i.i.i = bitcast [5 x i64]* %r.sroa.0.sroa.4.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %r.sroa.0.sroa.4.0.sroa_idx.i.i.i)
  %4 = bitcast %"rand_core::OsRng"* %rng.i.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 0, i8* nonnull %4)
  %5 = getelementptr inbounds [32 x i8], [32 x i8]* %seed.i.i.i.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %5), !noalias !4
  call void @llvm.memset.p0i8.i64(i8* nonnull align 1 dereferenceable(32) %5, i8 0, i64 32, i1 false), !alias.scope !7, !noalias !4
  %_5.0.i.i.i.i.i = bitcast [32 x i8]* %seed.i.i.i.i to [0 x i8]*
  %6 = call { i8*, i8* } @"_ZN59_$LT$rand_core..os..OsRng$u20$as$u20$rand_core..RngCore$GT$14try_fill_bytes17h856c329c7890d82bE"(%"rand_core::OsRng"* nonnull align 1 %rng.i.i.i.i, [0 x i8]* nonnull align 1 %_5.0.i.i.i.i.i, i64 32), !noalias !4
  %.fca.0.extract.i.i.i.i = extractvalue { i8*, i8* } %6, 0
  %.fca.1.extract.i.i.i.i = extractvalue { i8*, i8* } %6, 1
  %7 = icmp eq i8* %.fca.0.extract.i.i.i.i, null
  br i1 %7, label %"_ZN4core6result19Result$LT$T$C$E$GT$14unwrap_or_else17h89eb03b8df1920f1E.exit.i.i.i", label %bb1.i.i.i.i

bb1.i.i.i.i:                                      ; preds = %bb8
  %8 = icmp ne i8* %.fca.1.extract.i.i.i.i, null
  call void @llvm.assume(i1 %8), !noalias !4
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %5), !noalias !4
  call void @llvm.lifetime.end.p0i8(i64 0, i8* nonnull %4)
  %9 = bitcast i8* %.fca.1.extract.i.i.i.i to i64*
  call fastcc void @"_ZN4rand4rngs6thread14THREAD_RNG_KEY6__init28_$u7b$$u7b$closure$u7d$$u7d$17h2d208157d1a52da6E"(i8* mpk_immut noalias nonnull align 1 %.fca.0.extract.i.i.i.i, i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) %9), !noalias !10
  br label %UnifiedUnreachableBlock

"_ZN4core6result19Result$LT$T$C$E$GT$14unwrap_or_else17h89eb03b8df1920f1E.exit.i.i.i": ; preds = %bb8
  %10 = getelementptr inbounds [32 x i8], [32 x i8]* %_15.i.i.i.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %10), !noalias !4
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(32) %10, i8* nonnull align 1 dereferenceable(32) %5, i64 32, i1 false), !noalias !4
  %11 = bitcast %"rand_chacha::guts::ChaCha"* %_2.i.i.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %11), !noalias !14
  call void @_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE(%"rand_chacha::guts::ChaCha"* noalias nocapture nonnull sret dereferenceable(48) %_2.i.i.i.i.i, [32 x i8]* mpk_immut noalias nonnull readonly align 1 dereferenceable(32) %_15.i.i.i.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc992 to [0 x i8]*), i64 8), !noalias !4
  %_14.sroa.0.i.sroa.0.0..sroa_idx.i.i.i = getelementptr inbounds %"rand_chacha::guts::ChaCha", %"rand_chacha::guts::ChaCha"* %_2.i.i.i.i.i, i64 0, i32 0, i64 0
  %_14.sroa.0.i.sroa.0.0.copyload.i.i.i = load i64, i64* %_14.sroa.0.i.sroa.0.0..sroa_idx.i.i.i, align 16, !noalias !18
  %_14.sroa.0.i.sroa.4.0..sroa_idx.i.i.i = getelementptr inbounds %"rand_chacha::guts::ChaCha", %"rand_chacha::guts::ChaCha"* %_2.i.i.i.i.i, i64 0, i32 1, i32 0, i64 1
  %_14.sroa.0.i.sroa.4.0..sroa_cast.i.i.i = bitcast i64* %_14.sroa.0.i.sroa.4.0..sroa_idx.i.i.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %r.sroa.0.sroa.4.0.sroa_idx.i.i.i, i8* nonnull align 8 dereferenceable(40) %_14.sroa.0.i.sroa.4.0..sroa_cast.i.i.i, i64 40, i1 false)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %11), !noalias !14
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %10), !noalias !4
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %5), !noalias !4
  call void @llvm.lifetime.end.p0i8(i64 0, i8* nonnull %4)
  %rng.sroa.5.sroa.5.0.sroa_idx.i.i.i = getelementptr inbounds [40 x i8], [40 x i8]* %rng.sroa.5.sroa.5.i.i.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %rng.sroa.5.sroa.5.0.sroa_idx.i.i.i)
  %_6.sroa.0.i.sroa.4.0.sroa_idx.i.i.i = getelementptr inbounds [40 x i8], [40 x i8]* %_6.sroa.0.i.sroa.4.i.i.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %_6.sroa.0.i.sroa.4.0.sroa_idx.i.i.i)
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %_6.sroa.0.i.sroa.4.0.sroa_idx.i.i.i, i8* nonnull align 8 dereferenceable(40) %r.sroa.0.sroa.4.0.sroa_idx.i.i.i, i64 40, i1 false)
  %12 = load atomic i64, i64* bitcast (<{ [8 x i8] }>* @_ZN4rand4rngs7adapter9reseeding4fork21register_fork_handler8REGISTER17haea42ddb7cd0f47dE to i64*) acquire, align 8, !noalias !19
  %13 = icmp eq i64 %12, 3
  br i1 %13, label %"_ZN4rand4rngs7adapter9reseeding28ReseedingRng$LT$R$C$Rsdr$GT$3new17h042d496b358a6704E.exit.i.i.i", label %bb2.i.i.i.i.i.i.i

bb2.i.i.i.i.i.i.i:                                ; preds = %"_ZN4core6result19Result$LT$T$C$E$GT$14unwrap_or_else17h89eb03b8df1920f1E.exit.i.i.i"
  call void @llvm.lifetime.start.p0i8(i64 1, i8* nonnull %f.i.i.i.i.i.i.i), !noalias !19
  store i8 1, i8* %f.i.i.i.i.i.i.i, align 1, !noalias !19
  %14 = bitcast i8** %_12.i.i.i.i.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %14), !noalias !19
  store i8* %f.i.i.i.i.i.i.i, i8** %_12.i.i.i.i.i.i.i, align 8, !noalias !19
  %_9.0.i.i.i.i.i.i.i = bitcast i8** %_12.i.i.i.i.i.i.i to {}*
  call void @_ZN3std4sync4once4Once10call_inner17hddcf8ee610748361E(%"std::sync::Once"* mpk_immut align 8 dereferenceable(8) bitcast (<{ [8 x i8] }>* @_ZN4rand4rngs7adapter9reseeding4fork21register_fork_handler8REGISTER17haea42ddb7cd0f47dE to %"std::sync::Once"*), i1 zeroext false, {}* nonnull align 1 %_9.0.i.i.i.i.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, void (i8**, { i64, i8 }*)*, void (i8**, { i64, i8 }*)* }* @vtable.0 to [3 x i64]*)), !noalias !19
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %14), !noalias !19
  call void @llvm.lifetime.end.p0i8(i64 1, i8* nonnull %f.i.i.i.i.i.i.i), !noalias !19
  br label %"_ZN4rand4rngs7adapter9reseeding28ReseedingRng$LT$R$C$Rsdr$GT$3new17h042d496b358a6704E.exit.i.i.i"

"_ZN4rand4rngs7adapter9reseeding28ReseedingRng$LT$R$C$Rsdr$GT$3new17h042d496b358a6704E.exit.i.i.i": ; preds = %bb2.i.i.i.i.i.i.i, %"_ZN4core6result19Result$LT$T$C$E$GT$14unwrap_or_else17h89eb03b8df1920f1E.exit.i.i.i"
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %rng.sroa.5.sroa.5.0.sroa_idx.i.i.i, i8* nonnull align 8 dereferenceable(40) %_6.sroa.0.i.sroa.4.0.sroa_idx.i.i.i, i64 40, i1 false), !noalias !26
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %_6.sroa.0.i.sroa.4.0.sroa_idx.i.i.i)
  %_8.sroa.0.sroa.4.0.sroa_cast82.i.i.i = bitcast [64 x i32]* %_8.sroa.0.sroa.4.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 256, i8* nonnull %_8.sroa.0.sroa.4.0.sroa_cast82.i.i.i)
  %_8.sroa.0.sroa.5.sroa.5.0.sroa_idx131.i.i.i = getelementptr inbounds [40 x i8], [40 x i8]* %_8.sroa.0.sroa.5.sroa.5.i.i.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %_8.sroa.0.sroa.5.sroa.5.0.sroa_idx131.i.i.i)
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 dereferenceable(256) %_8.sroa.0.sroa.4.0.sroa_cast82.i.i.i, i8 0, i64 256, i1 false)
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %_8.sroa.0.sroa.5.sroa.5.0.sroa_idx131.i.i.i, i8* nonnull align 8 dereferenceable(40) %rng.sroa.5.sroa.5.0.sroa_idx.i.i.i, i64 40, i1 false)
  %15 = call mpk_unsafe dereferenceable_or_null(368) i8* @__rust_alloc(i64 368, i64 16) #17, !noalias !27
  %16 = icmp eq i8* %15, null
  br i1 %16, label %bb3.i.i.i.i.i, label %bb3.i

bb3.i.i.i.i.i:                                    ; preds = %"_ZN4rand4rngs7adapter9reseeding28ReseedingRng$LT$R$C$Rsdr$GT$3new17h042d496b358a6704E.exit.i.i.i"
  call void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64 368, i64 16) #17, !noalias !27
  br label %UnifiedUnreachableBlock

bb3.i:                                            ; preds = %"_ZN4rand4rngs7adapter9reseeding28ReseedingRng$LT$R$C$Rsdr$GT$3new17h042d496b358a6704E.exit.i.i.i"
  %17 = bitcast i8* %15 to <2 x i64>*
  store <2 x i64> <i64 1, i64 1>, <2 x i64>* %17, align 16, !noalias !27
  %_8.sroa.0.sroa.0.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_idx.i.i.i = getelementptr inbounds i8, i8* %15, i64 16
  %_8.sroa.0.sroa.0.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_cast.i.i.i = bitcast i8* %_8.sroa.0.sroa.0.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_idx.i.i.i to i64*
  store i64 64, i64* %_8.sroa.0.sroa.0.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_cast.i.i.i, align 16
  %_8.sroa.0.sroa.4.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_raw_idx.i.i.i = getelementptr inbounds i8, i8* %15, i64 24
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(256) %_8.sroa.0.sroa.4.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_raw_idx.i.i.i, i8* nonnull align 8 dereferenceable(256) %_8.sroa.0.sroa.4.0.sroa_cast82.i.i.i, i64 256, i1 false)
  %_8.sroa.0.sroa.5.sroa.4.0._8.sroa.0.sroa.5.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_raw_idx.sroa_idx.i.i.i = getelementptr inbounds i8, i8* %15, i64 288
  %_8.sroa.0.sroa.5.sroa.4.0._8.sroa.0.sroa.5.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_raw_idx.sroa_cast.i.i.i = bitcast i8* %_8.sroa.0.sroa.5.sroa.4.0._8.sroa.0.sroa.5.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_raw_idx.sroa_idx.i.i.i to i64*
  store i64 %_14.sroa.0.i.sroa.0.0.copyload.i.i.i, i64* %_8.sroa.0.sroa.5.sroa.4.0._8.sroa.0.sroa.5.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_raw_idx.sroa_cast.i.i.i, align 8
  %_8.sroa.0.sroa.5.sroa.5.0._8.sroa.0.sroa.5.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_raw_idx.sroa_raw_idx.i.i.i = getelementptr inbounds i8, i8* %15, i64 296
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %_8.sroa.0.sroa.5.sroa.5.0._8.sroa.0.sroa.5.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_raw_idx.sroa_raw_idx.i.i.i, i8* nonnull align 8 dereferenceable(40) %_8.sroa.0.sroa.5.sroa.5.0.sroa_idx131.i.i.i, i64 40, i1 false)
  %_8.sroa.0.sroa.6.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_idx.i.i.i = getelementptr inbounds i8, i8* %15, i64 336
  %18 = bitcast i8* %_8.sroa.0.sroa.6.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_idx.i.i.i to <2 x i64>*
  store <2 x i64> <i64 65536, i64 65536>, <2 x i64>* %18, align 16
  %_8.sroa.0.sroa.8.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_idx.i.i.i = getelementptr inbounds i8, i8* %15, i64 352
  %_8.sroa.0.sroa.8.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_cast.i.i.i = bitcast i8* %_8.sroa.0.sroa.8.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_idx.i.i.i to i64*
  store i64 0, i64* %_8.sroa.0.sroa.8.0._8.sroa.0.0._9.sroa.0.0..sroa_idx.i.sroa_raw_idx.sroa_cast.i.i.i, align 16
  call void @llvm.lifetime.end.p0i8(i64 256, i8* nonnull %_8.sroa.0.sroa.4.0.sroa_cast82.i.i.i)
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %_8.sroa.0.sroa.5.sroa.5.0.sroa_idx131.i.i.i)
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %rng.sroa.5.sroa.5.0.sroa_idx.i.i.i)
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %r.sroa.0.sroa.4.0.sroa_idx.i.i.i)
  %19 = ptrtoint i8* %15 to i64
  %20 = load i64*, i64** bitcast (<{ [16 x i8] }>* @_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E to i64**), align 8
  store i64 %19, i64* bitcast (<{ [16 x i8] }>* @_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E to i64*), align 8
  %21 = icmp eq i64* %20, null
  %22 = bitcast i8* %15 to {}*
  br i1 %21, label %"_ZN3std6thread5local4lazy21LazyKeyInner$LT$T$GT$10initialize17h0cad79390b2c9818E.exit", label %bb2.i.i

bb2.i.i:                                          ; preds = %bb3.i
  %self.idx.val.i.i.i.i.i = load i64, i64* %20, align 16
  %_6.i.i.i.i.i = add i64 %self.idx.val.i.i.i.i.i, -1
  store i64 %_6.i.i.i.i.i, i64* %20, align 16
  %23 = icmp eq i64 %_6.i.i.i.i.i, 0
  br i1 %23, label %bb6.i.i.i.i, label %bb4thread-pre-split.i

bb6.i.i.i.i:                                      ; preds = %bb2.i.i
  %24 = getelementptr i64, i64* %20, i64 1
  %self.idx.val.i7.i.i.i.i = load i64, i64* %24, align 8
  %_6.i8.i.i.i.i = add i64 %self.idx.val.i7.i.i.i.i, -1
  store i64 %_6.i8.i.i.i.i, i64* %24, align 8
  %25 = icmp eq i64 %_6.i8.i.i.i.i, 0
  br i1 %25, label %"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit.i.i.i.i", label %bb4thread-pre-split.i

"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit.i.i.i.i": ; preds = %bb6.i.i.i.i
  %_2.i.i.i.i1.i = bitcast i64* %20 to i8*
  call void @__rust_dealloc(i8* mpk_unsafe nonnull %_2.i.i.i.i1.i, i64 368, i64 16) #17
  br label %bb4thread-pre-split.i

bb4thread-pre-split.i:                            ; preds = %"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit.i.i.i.i", %bb6.i.i.i.i, %bb2.i.i
  %.pr.i = load {}*, {}** bitcast (<{ [16 x i8] }>* @_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E to {}**), align 8
  br label %"_ZN3std6thread5local4lazy21LazyKeyInner$LT$T$GT$10initialize17h0cad79390b2c9818E.exit"

"_ZN3std6thread5local4lazy21LazyKeyInner$LT$T$GT$10initialize17h0cad79390b2c9818E.exit": ; preds = %bb4thread-pre-split.i, %bb3.i
  %26 = phi {}* [ %.pr.i, %bb4thread-pre-split.i ], [ %22, %bb3.i ]
  %27 = icmp ne {}* %26, null
  call void @llvm.assume(i1 %27)
  br label %bb10

bb10:                                             ; preds = %"_ZN3std6thread5local4lazy21LazyKeyInner$LT$T$GT$10initialize17h0cad79390b2c9818E.exit", %start
  %.0 = phi i64* [ bitcast (<{ [16 x i8] }>* @_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E to i64*), %"_ZN3std6thread5local4lazy21LazyKeyInner$LT$T$GT$10initialize17h0cad79390b2c9818E.exit" ], [ null, %start ]
  ret i64* %.0

UnifiedUnreachableBlock:                          ; preds = %bb3.i.i.i.i.i, %bb1.i.i.i.i, %bb3.i1
  unreachable
}

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
define internal void @_ZN3std6thread5local4fast13destroy_value17h68e464754736844bE(i8* mpk_unsafe nocapture %ptr) unnamed_addr #3 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
bb2:
  %_5 = bitcast i8* %ptr to i64**
  %0 = bitcast i8* %ptr to i64*
  %1 = load i64*, i64** %_5, align 8
  store i64 0, i64* %0, align 8
  %2 = getelementptr inbounds i8, i8* %ptr, i64 8
  store i8 2, i8* %2, align 1
  %3 = icmp eq i64* %1, null
  br i1 %3, label %bb3, label %bb2.i.i

bb2.i.i:                                          ; preds = %bb2
  %self.idx.val.i.i.i.i.i = load i64, i64* %1, align 16
  %_6.i.i.i.i.i = add i64 %self.idx.val.i.i.i.i.i, -1
  store i64 %_6.i.i.i.i.i, i64* %1, align 16
  %4 = icmp eq i64 %_6.i.i.i.i.i, 0
  br i1 %4, label %bb6.i.i.i.i, label %bb3

bb6.i.i.i.i:                                      ; preds = %bb2.i.i
  %5 = getelementptr i64, i64* %1, i64 1
  %self.idx.val.i7.i.i.i.i = load i64, i64* %5, align 8
  %_6.i8.i.i.i.i = add i64 %self.idx.val.i7.i.i.i.i, -1
  store i64 %_6.i8.i.i.i.i, i64* %5, align 8
  %6 = icmp eq i64 %_6.i8.i.i.i.i, 0
  br i1 %6, label %"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit.i.i.i.i", label %bb3

"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit.i.i.i.i": ; preds = %bb6.i.i.i.i
  %_2.i.i.i.i.i = bitcast i64* %1 to i8*
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %_2.i.i.i.i.i, i64 368, i64 16) #17
  br label %bb3

bb3:                                              ; preds = %"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit.i.i.i.i", %bb6.i.i.i.i, %bb2.i.i, %bb2
  ret void
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h039130c6296bcea7E"(%"distributions::uniform::Uniform<u32>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_13.i = alloca %"distributions::uniform::UniformInt<u32>"*, align 8
  %debug_trait_builder.i = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"distributions::uniform::Uniform<u32>"** %self to i64*
  %_41 = load i64, i64* %0, align 8, !range !30
  %1 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1), !noalias !31
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [7 x i8] }>* @alloc1232 to [0 x i8]*), i64 7), !noalias !31
  %2 = bitcast %"distributions::uniform::UniformInt<u32>"** %_13.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2), !noalias !31
  %3 = bitcast %"distributions::uniform::UniformInt<u32>"** %_13.i to i64*
  store i64 %_41, i64* %3, align 8, !noalias !31
  %_10.0.i = bitcast %"distributions::uniform::UniformInt<u32>"** %_13.i to {}*
  %_8.i = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder.i, {}* mpk_immut nonnull align 1 %_10.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"distributions::uniform::UniformInt<u32>"**)*, i64, i64, i1 (%"distributions::uniform::UniformInt<u32>"**, %"core::fmt::Formatter"*)* }* @vtable.9 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2), !noalias !31
  %4 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder.i)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1), !noalias !31
  ret i1 %4
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h04bc593c1a772388E"(i64*** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %0 = tail call zeroext i1 @_ZN4core3fmt9Formatter3pad17h77c5e3cc34c58830E(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc1203 to [0 x i8]*), i64 10)
  ret i1 %0
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h0d781fe16112ed6fE"({ i32*, i32* }** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_13.i = alloca { [0 x i32]*, i64 }, align 8
  %_6.i = alloca %"core::fmt::DebugTuple", align 8
  %_4 = load { i32*, i32* }*, { i32*, i32* }** %self, align 8, !nonnull !2
  %0 = bitcast %"core::fmt::DebugTuple"* %_6.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0), !noalias !34
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %_6.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc1205 to [0 x i8]*), i64 4), !noalias !34
  %1 = bitcast { [0 x i32]*, i64 }* %_13.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %1), !noalias !34
  %2 = getelementptr inbounds { i32*, i32* }, { i32*, i32* }* %_4, i64 0, i32 0
  %_4.i.i.i = load i32*, i32** %2, align 8, !alias.scope !37, !nonnull !2
  %3 = getelementptr inbounds { i32*, i32* }, { i32*, i32* }* %_4, i64 0, i32 1
  %4 = bitcast i32** %3 to i64*
  %_134.i.i.i = load i64, i64* %4, align 8, !alias.scope !37
  %_14.i.i.i = ptrtoint i32* %_4.i.i.i to i64
  %5 = sub nuw i64 %_134.i.i.i, %_14.i.i.i
  %6 = lshr exact i64 %5, 2
  %7 = bitcast { [0 x i32]*, i64 }* %_13.i to i32**
  store i32* %_4.i.i.i, i32** %7, align 8, !noalias !34
  %.fca.1.gep.i = getelementptr inbounds { [0 x i32]*, i64 }, { [0 x i32]*, i64 }* %_13.i, i64 0, i32 1
  store i64 %6, i64* %.fca.1.gep.i, align 8, !noalias !34
  %_10.0.i = bitcast { [0 x i32]*, i64 }* %_13.i to {}*
  %_4.i = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %_6.i, {}* mpk_immut nonnull align 1 %_10.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ [0 x i32]*, i64 }*)*, i64, i64, i1 ({ [0 x i32]*, i64 }*, %"core::fmt::Formatter"*)* }* @vtable.5 to [3 x i64]*)), !noalias !34
  %8 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %_4.i), !noalias !34
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %1), !noalias !34
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0), !noalias !34
  ret i1 %8
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3208077ea16feda8E"(%"std::vec::IntoIter<usize>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_13.i = alloca { [0 x i64]*, i64 }, align 8
  %_6.i = alloca %"core::fmt::DebugTuple", align 8
  %_4 = load %"std::vec::IntoIter<usize>"*, %"std::vec::IntoIter<usize>"** %self, align 8, !nonnull !2
  %_4.idx = getelementptr %"std::vec::IntoIter<usize>", %"std::vec::IntoIter<usize>"* %_4, i64 0, i32 7
  %_4.idx.val = load i64*, i64** %_4.idx, align 8
  %_4.idx1 = getelementptr %"std::vec::IntoIter<usize>", %"std::vec::IntoIter<usize>"* %_4, i64 0, i32 9
  %0 = bitcast i64** %_4.idx1 to i64*
  %_4.idx1.val2 = load i64, i64* %0, align 8
  %1 = bitcast %"core::fmt::DebugTuple"* %_6.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %_6.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc1200 to [0 x i8]*), i64 8)
  %2 = bitcast { [0 x i64]*, i64 }* %_13.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %2)
  %3 = ptrtoint i64* %_4.idx.val to i64
  %4 = sub i64 %_4.idx1.val2, %3
  %5 = ashr exact i64 %4, 3
  %6 = bitcast { [0 x i64]*, i64 }* %_13.i to i64**
  store i64* %_4.idx.val, i64** %6, align 8
  %.fca.1.gep.i = getelementptr inbounds { [0 x i64]*, i64 }, { [0 x i64]*, i64 }* %_13.i, i64 0, i32 1
  store i64 %5, i64* %.fca.1.gep.i, align 8
  %_10.0.i = bitcast { [0 x i64]*, i64 }* %_13.i to {}*
  %_4.i = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %_6.i, {}* mpk_immut nonnull align 1 %_10.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ [0 x i64]*, i64 }*)*, i64, i64, i1 ({ [0 x i64]*, i64 }*, %"core::fmt::Formatter"*)* }* @vtable.4 to [3 x i64]*))
  %7 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %_4.i)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
  ret i1 %7
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d4459423a121dc3E"({ i64*, i64* }** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_13.i = alloca { [0 x i64]*, i64 }, align 8
  %_6.i = alloca %"core::fmt::DebugTuple", align 8
  %_4 = load { i64*, i64* }*, { i64*, i64* }** %self, align 8, !nonnull !2
  %0 = bitcast %"core::fmt::DebugTuple"* %_6.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0), !noalias !42
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %_6.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc1205 to [0 x i8]*), i64 4), !noalias !42
  %1 = bitcast { [0 x i64]*, i64 }* %_13.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %1), !noalias !42
  %2 = getelementptr inbounds { i64*, i64* }, { i64*, i64* }* %_4, i64 0, i32 0
  %_4.i.i.i = load i64*, i64** %2, align 8, !alias.scope !45, !nonnull !2
  %3 = getelementptr inbounds { i64*, i64* }, { i64*, i64* }* %_4, i64 0, i32 1
  %4 = bitcast i64** %3 to i64*
  %_134.i.i.i = load i64, i64* %4, align 8, !alias.scope !45
  %_14.i.i.i = ptrtoint i64* %_4.i.i.i to i64
  %5 = sub nuw i64 %_134.i.i.i, %_14.i.i.i
  %6 = lshr exact i64 %5, 3
  %7 = bitcast { [0 x i64]*, i64 }* %_13.i to i64**
  store i64* %_4.i.i.i, i64** %7, align 8, !noalias !42
  %.fca.1.gep.i = getelementptr inbounds { [0 x i64]*, i64 }, { [0 x i64]*, i64 }* %_13.i, i64 0, i32 1
  store i64 %6, i64* %.fca.1.gep.i, align 8, !noalias !42
  %_10.0.i = bitcast { [0 x i64]*, i64 }* %_13.i to {}*
  %_4.i = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %_6.i, {}* mpk_immut nonnull align 1 %_10.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ [0 x i64]*, i64 }*)*, i64, i64, i1 ({ [0 x i64]*, i64 }*, %"core::fmt::Formatter"*)* }* @vtable.4 to [3 x i64]*)), !noalias !42
  %8 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %_4.i), !noalias !42
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %1), !noalias !42
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0), !noalias !42
  ret i1 %8
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h41a93829653e0c8dE"(%"std::vec::Vec<usize>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %entry.i.i.i = alloca i64*, align 8
  %_6.i.i = alloca %"core::fmt::DebugList", align 8
  %_4 = load %"std::vec::Vec<usize>"*, %"std::vec::Vec<usize>"** %self, align 8, !nonnull !2
  %0 = bitcast %"std::vec::Vec<usize>"* %_4 to [0 x i64]**
  %_3.idx.val.i1.i.i = load [0 x i64]*, [0 x i64]** %0, align 8, !alias.scope !50, !nonnull !2
  %1 = getelementptr inbounds %"std::vec::Vec<usize>", %"std::vec::Vec<usize>"* %_4, i64 0, i32 3
  %_4.i.i = load i64, i64* %1, align 8, !alias.scope !57
  %2 = bitcast %"core::fmt::DebugList"* %_6.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %2), !noalias !58
  %3 = tail call i128 @_ZN4core3fmt9Formatter10debug_list17h8147fa4f8cb43178E(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f), !noalias !58
  %.0..sroa_cast.i.i = bitcast %"core::fmt::DebugList"* %_6.i.i to i128*
  store i128 %3, i128* %.0..sroa_cast.i.i, align 8, !noalias !58
  %4 = getelementptr inbounds [0 x i64], [0 x i64]* %_3.idx.val.i1.i.i, i64 0, i64 %_4.i.i
  %_12.i14.i.i.i = icmp eq i64 %_4.i.i, 0
  br i1 %_12.i14.i.i.i, label %"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h201e74c9a9a42197E.exit", label %bb3.lr.ph.i.i.i

bb3.lr.ph.i.i.i:                                  ; preds = %start
  %5 = getelementptr [0 x i64], [0 x i64]* %_3.idx.val.i1.i.i, i64 0, i64 0
  %6 = bitcast i64** %entry.i.i.i to i8*
  %_17.0.i.i.i = bitcast i64** %entry.i.i.i to {}*
  br label %bb3.i.i.i

bb3.i.i.i:                                        ; preds = %bb3.i.i.i, %bb3.lr.ph.i.i.i
  %iter.sroa.0.015.i.i.i = phi i64* [ %5, %bb3.lr.ph.i.i.i ], [ %7, %bb3.i.i.i ]
  %7 = getelementptr inbounds i64, i64* %iter.sroa.0.015.i.i.i, i64 1
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %6), !noalias !58
  store i64* %iter.sroa.0.015.i.i.i, i64** %entry.i.i.i, align 8, !noalias !58
  %_15.i.i.i = call align 8 dereferenceable(16) %"core::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"core::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*)), !noalias !61
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %6), !noalias !58
  %_12.i.i.i.i = icmp eq i64* %7, %4
  br i1 %_12.i.i.i.i, label %"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h201e74c9a9a42197E.exit", label %bb3.i.i.i

"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h201e74c9a9a42197E.exit": ; preds = %bb3.i.i.i, %start
  %8 = call zeroext i1 @_ZN4core3fmt8builders9DebugList6finish17h1110a7134d6ce275E(%"core::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i), !noalias !61
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %2), !noalias !58
  ret i1 %8
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h53bd0ea524f9d07cE"(%"distributions::uniform::UniformDurationMode"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load %"distributions::uniform::UniformDurationMode"*, %"distributions::uniform::UniformDurationMode"** %self, align 8, !nonnull !2
  %0 = tail call zeroext i1 @"_ZN86_$LT$rand..distributions..uniform..UniformDurationMode$u20$as$u20$core..fmt..Debug$GT$3fmt17h6c2e8ee4c2eab8abE"(%"distributions::uniform::UniformDurationMode"* mpk_immut noalias nonnull readonly align 8 dereferenceable(40) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  ret i1 %0
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h76009fecdd873ad2E"(%"distributions::uniform::Uniform<u64>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_13.i = alloca %"distributions::uniform::UniformInt<u64>"*, align 8
  %debug_trait_builder.i = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"distributions::uniform::Uniform<u64>"** %self to i64*
  %_41 = load i64, i64* %0, align 8, !range !30
  %1 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1), !noalias !62
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [7 x i8] }>* @alloc1232 to [0 x i8]*), i64 7), !noalias !62
  %2 = bitcast %"distributions::uniform::UniformInt<u64>"** %_13.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2), !noalias !62
  %3 = bitcast %"distributions::uniform::UniformInt<u64>"** %_13.i to i64*
  store i64 %_41, i64* %3, align 8, !noalias !62
  %_10.0.i = bitcast %"distributions::uniform::UniformInt<u64>"** %_13.i to {}*
  %_8.i = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder.i, {}* mpk_immut nonnull align 1 %_10.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"distributions::uniform::UniformInt<u64>"**)*, i64, i64, i1 (%"distributions::uniform::UniformInt<u64>"**, %"core::fmt::Formatter"*)* }* @vtable.8 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2), !noalias !62
  %4 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder.i)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1), !noalias !62
  ret i1 %4
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h817059568843a302E"({ [0 x i32]*, i64 }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %entry.i.i = alloca i32*, align 8
  %_6.i = alloca %"core::fmt::DebugList", align 8
  %0 = getelementptr inbounds { [0 x i32]*, i64 }, { [0 x i32]*, i64 }* %self, i64 0, i32 0
  %_4.0 = load [0 x i32]*, [0 x i32]** %0, align 8, !nonnull !2
  %1 = getelementptr inbounds { [0 x i32]*, i64 }, { [0 x i32]*, i64 }* %self, i64 0, i32 1
  %_4.1 = load i64, i64* %1, align 8
  %2 = bitcast %"core::fmt::DebugList"* %_6.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %2), !noalias !65
  %3 = tail call i128 @_ZN4core3fmt9Formatter10debug_list17h8147fa4f8cb43178E(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f), !noalias !65
  %.0..sroa_cast.i = bitcast %"core::fmt::DebugList"* %_6.i to i128*
  store i128 %3, i128* %.0..sroa_cast.i, align 8, !noalias !65
  %4 = getelementptr inbounds [0 x i32], [0 x i32]* %_4.0, i64 0, i64 %_4.1
  %_12.i14.i.i = icmp eq i64 %_4.1, 0
  br i1 %_12.i14.i.i, label %"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h33e1ff7d249818ecE.exit", label %bb3.lr.ph.i.i

bb3.lr.ph.i.i:                                    ; preds = %start
  %5 = getelementptr [0 x i32], [0 x i32]* %_4.0, i64 0, i64 0
  %6 = bitcast i32** %entry.i.i to i8*
  %_17.0.i.i = bitcast i32** %entry.i.i to {}*
  br label %bb3.i.i

bb3.i.i:                                          ; preds = %bb3.i.i, %bb3.lr.ph.i.i
  %iter.sroa.0.015.i.i = phi i32* [ %5, %bb3.lr.ph.i.i ], [ %7, %bb3.i.i ]
  %7 = getelementptr inbounds i32, i32* %iter.sroa.0.015.i.i, i64 1
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %6), !noalias !65
  store i32* %iter.sroa.0.015.i.i, i32** %entry.i.i, align 8, !noalias !65
  %_15.i.i = call align 8 dereferenceable(16) %"core::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"core::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i, {}* mpk_immut nonnull align 1 %_17.0.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %6), !noalias !65
  %_12.i.i.i = icmp eq i32* %7, %4
  br i1 %_12.i.i.i, label %"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h33e1ff7d249818ecE.exit", label %bb3.i.i

"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h33e1ff7d249818ecE.exit": ; preds = %bb3.i.i, %start
  %8 = call zeroext i1 @_ZN4core3fmt8builders9DebugList6finish17h1110a7134d6ce275E(%"core::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %2), !noalias !65
  ret i1 %8
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h86e40719d832eda4E"(i64** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load i64*, i64** %self, align 8, !nonnull !2
  %_3.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f), !noalias !68
  br i1 %_3.i, label %bb3.i, label %bb2.i

bb2.i:                                            ; preds = %start
  %_7.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7.i, label %bb7.i, label %bb6.i

bb3.i:                                            ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17he9d3331e4e8b2618E"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE.exit"

bb6.i:                                            ; preds = %bb2.i
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h4dc2af1a5829180dE"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE.exit"

bb7.i:                                            ; preds = %bb2.i
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u64$GT$3fmt17h46c4aab50ded2d21E"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE.exit"

"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE.exit": ; preds = %bb7.i, %bb6.i, %bb3.i
  %.0.in.i = phi i1 [ %0, %bb3.i ], [ %2, %bb7.i ], [ %1, %bb6.i ]
  ret i1 %.0.in.i
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h9633ef4b088cdc0aE"(i64** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load i64*, i64** %self, align 8, !nonnull !2
  %_3.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f), !noalias !71
  br i1 %_3.i, label %bb3.i, label %bb2.i

bb2.i:                                            ; preds = %start
  %_7.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7.i, label %bb7.i, label %bb6.i

bb3.i:                                            ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h3fb07f7e6da8e1c6E"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hd033ec0476f2a15bE.exit"

bb6.i:                                            ; preds = %bb2.i
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h0f57e3373191c50eE"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hd033ec0476f2a15bE.exit"

bb7.i:                                            ; preds = %bb2.i
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$usize$GT$3fmt17hf3a9e839be306c07E"(i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(8) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hd033ec0476f2a15bE.exit"

"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hd033ec0476f2a15bE.exit": ; preds = %bb7.i, %bb6.i, %bb3.i
  %.0.in.i = phi i1 [ %0, %bb3.i ], [ %2, %bb7.i ], [ %1, %bb6.i ]
  ret i1 %.0.in.i
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha2ad1c8f62c73869E"(%"std::io::Error"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load %"std::io::Error"*, %"std::io::Error"** %self, align 8, !nonnull !2
  %0 = tail call zeroext i1 @"_ZN58_$LT$std..io..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h92bc210ff9abc8b7E"(%"std::io::Error"* mpk_immut noalias nonnull readonly align 8 dereferenceable(16) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  ret i1 %0
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha4149295b33a0b62E"(%"distributions::uniform::UniformInt<u64>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_33.i = alloca i64*, align 8
  %_25.i = alloca i64*, align 8
  %_17.i = alloca i64*, align 8
  %debug_trait_builder.i = alloca %"core::fmt::DebugStruct", align 8
  %_4 = load %"distributions::uniform::UniformInt<u64>"*, %"distributions::uniform::UniformInt<u64>"** %self, align 8, !nonnull !2
  %__self_0_0.i = getelementptr inbounds %"distributions::uniform::UniformInt<u64>", %"distributions::uniform::UniformInt<u64>"* %_4, i64 0, i32 0, i64 0
  %__self_0_1.i = getelementptr inbounds %"distributions::uniform::UniformInt<u64>", %"distributions::uniform::UniformInt<u64>"* %_4, i64 0, i32 3
  %__self_0_2.i = getelementptr inbounds %"distributions::uniform::UniformInt<u64>", %"distributions::uniform::UniformInt<u64>"* %_4, i64 0, i32 5
  %0 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0), !noalias !74
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc1237 to [0 x i8]*), i64 10), !noalias !74
  %.0..sroa_cast.i = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder.i to i128*
  store i128 %1, i128* %.0..sroa_cast.i, align 8, !noalias !74
  %2 = bitcast i64** %_17.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2), !noalias !74
  store i64* %__self_0_0.i, i64** %_17.i, align 8, !noalias !74
  %_14.0.i = bitcast i64** %_17.i to {}*
  %_10.i = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc1238 to [0 x i8]*), i64 3, {}* mpk_immut nonnull align 1 %_14.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.7 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2), !noalias !74
  %3 = bitcast i64** %_25.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !74
  store i64* %__self_0_1.i, i64** %_25.i, align 8, !noalias !74
  %_22.0.i = bitcast i64** %_25.i to {}*
  %_18.i = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1239 to [0 x i8]*), i64 5, {}* mpk_immut nonnull align 1 %_22.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.7 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !74
  %4 = bitcast i64** %_33.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4), !noalias !74
  store i64* %__self_0_2.i, i64** %_33.i, align 8, !noalias !74
  %_30.0.i = bitcast i64** %_33.i to {}*
  %_26.i = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [1 x i8] }>* @alloc1240 to [0 x i8]*), i64 1, {}* mpk_immut nonnull align 1 %_30.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.7 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4), !noalias !74
  %5 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder.i)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0), !noalias !74
  ret i1 %5
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17ha49d4adf2bb8fce0E"(%"rand_chacha::ChaCha12Rng"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load %"rand_chacha::ChaCha12Rng"*, %"rand_chacha::ChaCha12Rng"** %self, align 8, !nonnull !2
  %0 = tail call zeroext i1 @"_ZN69_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$core..fmt..Debug$GT$3fmt17h59b609cdf02c63acE"(%"rand_chacha::ChaCha12Rng"* mpk_immut noalias nonnull readonly align 16 dereferenceable(320) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  ret i1 %0
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb1b60f9d2f50b2daE"({ [0 x i64]*, i64 }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %entry.i.i = alloca i64*, align 8
  %_6.i = alloca %"core::fmt::DebugList", align 8
  %0 = getelementptr inbounds { [0 x i64]*, i64 }, { [0 x i64]*, i64 }* %self, i64 0, i32 0
  %_4.0 = load [0 x i64]*, [0 x i64]** %0, align 8, !nonnull !2
  %1 = getelementptr inbounds { [0 x i64]*, i64 }, { [0 x i64]*, i64 }* %self, i64 0, i32 1
  %_4.1 = load i64, i64* %1, align 8
  %2 = bitcast %"core::fmt::DebugList"* %_6.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %2), !noalias !77
  %3 = tail call i128 @_ZN4core3fmt9Formatter10debug_list17h8147fa4f8cb43178E(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f), !noalias !77
  %.0..sroa_cast.i = bitcast %"core::fmt::DebugList"* %_6.i to i128*
  store i128 %3, i128* %.0..sroa_cast.i, align 8, !noalias !77
  %4 = getelementptr inbounds [0 x i64], [0 x i64]* %_4.0, i64 0, i64 %_4.1
  %_12.i14.i.i = icmp eq i64 %_4.1, 0
  br i1 %_12.i14.i.i, label %"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha6bc647d97a69d12E.exit", label %bb3.lr.ph.i.i

bb3.lr.ph.i.i:                                    ; preds = %start
  %5 = getelementptr [0 x i64], [0 x i64]* %_4.0, i64 0, i64 0
  %6 = bitcast i64** %entry.i.i to i8*
  %_17.0.i.i = bitcast i64** %entry.i.i to {}*
  br label %bb3.i.i

bb3.i.i:                                          ; preds = %bb3.i.i, %bb3.lr.ph.i.i
  %iter.sroa.0.015.i.i = phi i64* [ %5, %bb3.lr.ph.i.i ], [ %7, %bb3.i.i ]
  %7 = getelementptr inbounds i64, i64* %iter.sroa.0.015.i.i, i64 1
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %6), !noalias !77
  store i64* %iter.sroa.0.015.i.i, i64** %entry.i.i, align 8, !noalias !77
  %_15.i.i = call align 8 dereferenceable(16) %"core::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"core::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i, {}* mpk_immut nonnull align 1 %_17.0.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.1 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %6), !noalias !77
  %_12.i.i.i = icmp eq i64* %7, %4
  br i1 %_12.i.i.i, label %"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha6bc647d97a69d12E.exit", label %bb3.i.i

"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha6bc647d97a69d12E.exit": ; preds = %bb3.i.i, %start
  %8 = call zeroext i1 @_ZN4core3fmt8builders9DebugList6finish17h1110a7134d6ce275E(%"core::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %2), !noalias !77
  ret i1 %8
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbda29d2ac4617786E"(%"distributions::uniform::UniformInt<u32>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_33.i = alloca i32*, align 8
  %_25.i = alloca i32*, align 8
  %_17.i = alloca i32*, align 8
  %debug_trait_builder.i = alloca %"core::fmt::DebugStruct", align 8
  %_4 = load %"distributions::uniform::UniformInt<u32>"*, %"distributions::uniform::UniformInt<u32>"** %self, align 8, !nonnull !2
  %__self_0_0.i = getelementptr inbounds %"distributions::uniform::UniformInt<u32>", %"distributions::uniform::UniformInt<u32>"* %_4, i64 0, i32 0, i64 0
  %__self_0_1.i = getelementptr inbounds %"distributions::uniform::UniformInt<u32>", %"distributions::uniform::UniformInt<u32>"* %_4, i64 0, i32 3
  %__self_0_2.i = getelementptr inbounds %"distributions::uniform::UniformInt<u32>", %"distributions::uniform::UniformInt<u32>"* %_4, i64 0, i32 5
  %0 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0), !noalias !80
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc1237 to [0 x i8]*), i64 10), !noalias !80
  %.0..sroa_cast.i = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder.i to i128*
  store i128 %1, i128* %.0..sroa_cast.i, align 8, !noalias !80
  %2 = bitcast i32** %_17.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2), !noalias !80
  store i32* %__self_0_0.i, i32** %_17.i, align 8, !noalias !80
  %_14.0.i = bitcast i32** %_17.i to {}*
  %_10.i = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc1238 to [0 x i8]*), i64 3, {}* mpk_immut nonnull align 1 %_14.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2), !noalias !80
  %3 = bitcast i32** %_25.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3), !noalias !80
  store i32* %__self_0_1.i, i32** %_25.i, align 8, !noalias !80
  %_22.0.i = bitcast i32** %_25.i to {}*
  %_18.i = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1239 to [0 x i8]*), i64 5, {}* mpk_immut nonnull align 1 %_22.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3), !noalias !80
  %4 = bitcast i32** %_33.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4), !noalias !80
  store i32* %__self_0_2.i, i32** %_33.i, align 8, !noalias !80
  %_30.0.i = bitcast i32** %_33.i to {}*
  %_26.i = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [1 x i8] }>* @alloc1240 to [0 x i8]*), i64 1, {}* mpk_immut nonnull align 1 %_30.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4), !noalias !80
  %5 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder.i)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0), !noalias !80
  ret i1 %5
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hc8dae25808d1ef2dE"(%"std::vec::Vec<u32>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %entry.i.i.i = alloca i32*, align 8
  %_6.i.i = alloca %"core::fmt::DebugList", align 8
  %_4 = load %"std::vec::Vec<u32>"*, %"std::vec::Vec<u32>"** %self, align 8, !nonnull !2
  %0 = bitcast %"std::vec::Vec<u32>"* %_4 to [0 x i32]**
  %_3.idx.val.i1.i.i = load [0 x i32]*, [0 x i32]** %0, align 8, !alias.scope !83, !nonnull !2
  %1 = getelementptr inbounds %"std::vec::Vec<u32>", %"std::vec::Vec<u32>"* %_4, i64 0, i32 3
  %_4.i.i = load i64, i64* %1, align 8, !alias.scope !90
  %2 = bitcast %"core::fmt::DebugList"* %_6.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %2), !noalias !91
  %3 = tail call i128 @_ZN4core3fmt9Formatter10debug_list17h8147fa4f8cb43178E(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f), !noalias !91
  %.0..sroa_cast.i.i = bitcast %"core::fmt::DebugList"* %_6.i.i to i128*
  store i128 %3, i128* %.0..sroa_cast.i.i, align 8, !noalias !91
  %4 = getelementptr inbounds [0 x i32], [0 x i32]* %_3.idx.val.i1.i.i, i64 0, i64 %_4.i.i
  %_12.i14.i.i.i = icmp eq i64 %_4.i.i, 0
  br i1 %_12.i14.i.i.i, label %"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d606f9843fd6f65E.exit", label %bb3.lr.ph.i.i.i

bb3.lr.ph.i.i.i:                                  ; preds = %start
  %5 = getelementptr [0 x i32], [0 x i32]* %_3.idx.val.i1.i.i, i64 0, i64 0
  %6 = bitcast i32** %entry.i.i.i to i8*
  %_17.0.i.i.i = bitcast i32** %entry.i.i.i to {}*
  br label %bb3.i.i.i

bb3.i.i.i:                                        ; preds = %bb3.i.i.i, %bb3.lr.ph.i.i.i
  %iter.sroa.0.015.i.i.i = phi i32* [ %5, %bb3.lr.ph.i.i.i ], [ %7, %bb3.i.i.i ]
  %7 = getelementptr inbounds i32, i32* %iter.sroa.0.015.i.i.i, i64 1
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %6), !noalias !91
  store i32* %iter.sroa.0.015.i.i.i, i32** %entry.i.i.i, align 8, !noalias !91
  %_15.i.i.i = call align 8 dereferenceable(16) %"core::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"core::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i, {}* mpk_immut nonnull align 1 %_17.0.i.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*)), !noalias !94
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %6), !noalias !91
  %_12.i.i.i.i = icmp eq i32* %7, %4
  br i1 %_12.i.i.i.i, label %"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d606f9843fd6f65E.exit", label %bb3.i.i.i

"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d606f9843fd6f65E.exit": ; preds = %bb3.i.i.i, %start
  %8 = call zeroext i1 @_ZN4core3fmt8builders9DebugList6finish17h1110a7134d6ce275E(%"core::fmt::DebugList"* nonnull align 8 dereferenceable(16) %_6.i.i), !noalias !94
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %2), !noalias !91
  ret i1 %8
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he01dd123247b523aE"(%"std::vec::IntoIter<u32>"** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_13.i = alloca { [0 x i32]*, i64 }, align 8
  %_6.i = alloca %"core::fmt::DebugTuple", align 8
  %_4 = load %"std::vec::IntoIter<u32>"*, %"std::vec::IntoIter<u32>"** %self, align 8, !nonnull !2
  %_4.idx = getelementptr %"std::vec::IntoIter<u32>", %"std::vec::IntoIter<u32>"* %_4, i64 0, i32 7
  %_4.idx.val = load i32*, i32** %_4.idx, align 8
  %_4.idx1 = getelementptr %"std::vec::IntoIter<u32>", %"std::vec::IntoIter<u32>"* %_4, i64 0, i32 9
  %0 = bitcast i32** %_4.idx1 to i64*
  %_4.idx1.val2 = load i64, i64* %0, align 8
  %1 = bitcast %"core::fmt::DebugTuple"* %_6.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %_6.i, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc1200 to [0 x i8]*), i64 8)
  %2 = bitcast { [0 x i32]*, i64 }* %_13.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %2)
  %3 = ptrtoint i32* %_4.idx.val to i64
  %4 = sub i64 %_4.idx1.val2, %3
  %5 = ashr exact i64 %4, 2
  %6 = bitcast { [0 x i32]*, i64 }* %_13.i to i32**
  store i32* %_4.idx.val, i32** %6, align 8
  %.fca.1.gep.i = getelementptr inbounds { [0 x i32]*, i64 }, { [0 x i32]*, i64 }* %_13.i, i64 0, i32 1
  store i64 %5, i64* %.fca.1.gep.i, align 8
  %_10.0.i = bitcast { [0 x i32]*, i64 }* %_13.i to {}*
  %_4.i = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %_6.i, {}* mpk_immut nonnull align 1 %_10.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ [0 x i32]*, i64 }*)*, i64, i64, i1 ({ [0 x i32]*, i64 }*, %"core::fmt::Formatter"*)* }* @vtable.5 to [3 x i64]*))
  %7 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %_4.i)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
  ret i1 %7
}

; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hee72a8456183bcc4E"(i32** mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = load i32*, i32** %self, align 8, !nonnull !2
  %_3.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f), !noalias !95
  br i1 %_3.i, label %bb3.i, label %bb2.i

bb2.i:                                            ; preds = %start
  %_7.i = tail call zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias nonnull readonly align 8 dereferenceable(64) %f)
  br i1 %_7.i, label %bb7.i, label %bb6.i

bb3.i:                                            ; preds = %start
  %0 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hbdab60765508c6f3E"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E.exit"

bb6.i:                                            ; preds = %bb2.i
  %1 = tail call zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h6b8b41e24df1a43fE"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E.exit"

bb7.i:                                            ; preds = %bb2.i
  %2 = tail call zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h4773017a326a508bE"(i32* mpk_immut noalias nonnull readonly align 4 dereferenceable(4) %_4, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f)
  br label %"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E.exit"

"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E.exit": ; preds = %bb7.i, %bb6.i, %bb3.i
  %.0.in.i = phi i1 [ %0, %bb3.i ], [ %2, %bb7.i ], [ %1, %bb6.i ]
  ret i1 %.0.in.i
}

; Function Attrs: nonlazybind uwtable
define internal void @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17ha86f48d5e874fe76E"(i8** nocapture readonly %_1, { i64, i8 }* mpk_immut nocapture readnone align 8 dereferenceable(16) %0) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %1 = load i8*, i8** %_1, align 8, !nonnull !2
  %x.val.i.i.i.i.i.i.i = load i8, i8* %1, align 1
  %2 = and i8 %x.val.i.i.i.i.i.i.i, 1
  store i8 0, i8* %1, align 1
  %.not.i.i = icmp eq i8 %2, 0
  br i1 %.not.i.i, label %bb1.i.i.i, label %_ZN4core3ops8function6FnOnce9call_once17ha6370114dd0a2b0aE.exit

bb1.i.i.i:                                        ; preds = %start
  tail call void @_ZN4core9panicking5panic17hc14ab8d72efd34afE([0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [43 x i8] }>* @alloc1198 to [0 x i8]*), i64 43, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc1180 to %"core::panic::Location"*))
  unreachable

_ZN4core3ops8function6FnOnce9call_once17ha6370114dd0a2b0aE.exit: ; preds = %start
  %_2.i.i.i = tail call i32 @pthread_atfork(i64* mpk_immut null, i64* mpk_immut null, i64* mpk_immut bitcast (void ()* @_ZN4rand4rngs7adapter9reseeding4fork12fork_handler17h6bff1484396c250eE to i64*)) #17
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define internal void @_ZN4core3ptr13drop_in_place17h0647f522a1173a30E(%"std::vec::Vec<usize>"** mpk_unsafe nocapture %_1) unnamed_addr #1 {
start:
  ret void
}

; Function Attrs: nonlazybind uwtable
define internal fastcc void @_ZN4core3ptr13drop_in_place17h3a402e9bd9e0af26E({ i8*, i64* }* mpk_unsafe nocapture readonly %_1) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %0 = bitcast { i8*, i64* }* %_1 to {}**
  %1 = load {}*, {}** %0, align 8, !nonnull !2
  %2 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %_1, i64 0, i32 1
  %3 = bitcast i64** %2 to void ({}*)***
  %4 = load void ({}*)**, void ({}*)*** %3, align 8, !nonnull !2
  %5 = load void ({}*)*, void ({}*)** %4, align 8, !invariant.load !2, !nonnull !2
  invoke void %5({}* mpk_unsafe nonnull %1)
          to label %bb3.i unwind label %cleanup.i

bb3.i:                                            ; preds = %start
  %6 = load i64*, i64** %2, align 8, !nonnull !2
  %7 = getelementptr inbounds i64, i64* %6, i64 1
  %8 = load i64, i64* %7, align 8, !invariant.load !2, !alias.scope !98
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %_ZN4core3ptr13drop_in_place17h79a3fb6d78755720E.exit, label %bb3.i.i.i

bb3.i.i.i:                                        ; preds = %bb3.i
  %10 = getelementptr { i8*, i64* }, { i8*, i64* }* %_1, i64 0, i32 0
  %11 = load i8*, i8** %10, align 8, !nonnull !2
  %12 = getelementptr inbounds i64, i64* %6, i64 2
  %13 = load i64, i64* %12, align 8, !invariant.load !2, !alias.scope !98
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %11, i64 %8, i64 %13) #17, !noalias !98
  br label %_ZN4core3ptr13drop_in_place17h79a3fb6d78755720E.exit

cleanup.i:                                        ; preds = %start
  %14 = landingpad { i8*, i32 }
          cleanup
  %15 = getelementptr { i8*, i64* }, { i8*, i64* }* %_1, i64 0, i32 0
  %16 = load i8*, i8** %15, align 8, !nonnull !2
  %17 = load i64*, i64** %2, align 8, !nonnull !2
  tail call fastcc void @_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E(i8* mpk_immut mpk_unsafe nonnull %16, i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) %17) #18
  resume { i8*, i32 } %14

_ZN4core3ptr13drop_in_place17h79a3fb6d78755720E.exit: ; preds = %bb3.i.i.i, %bb3.i
  ret void
}

; Function Attrs: nonlazybind uwtable
define internal void @_ZN4core3ptr13drop_in_place17hbc017d5edc7bec99E(%"std::io::Error"* mpk_unsafe nocapture readonly %_1) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %0 = bitcast %"std::io::Error"* %_1 to i8*
  %1 = load i8, i8* %0, align 8, !range !3
  %switch.i = icmp ult i8 %1, 2
  br i1 %switch.i, label %_ZN4core3ptr13drop_in_place17he6082cab77d34f65E.exit, label %bb2.i

bb2.i:                                            ; preds = %start
  %2 = getelementptr inbounds %"std::io::Error", %"std::io::Error"* %_1, i64 0, i32 1, i32 2, i64 7
  %3 = bitcast i8* %2 to %"std::io::error::Custom"**
  %4 = load %"std::io::error::Custom"*, %"std::io::error::Custom"** %3, align 8, !nonnull !2
  %5 = bitcast %"std::io::error::Custom"* %4 to {}**
  %6 = load {}*, {}** %5, align 8, !nonnull !2
  %7 = getelementptr inbounds %"std::io::error::Custom", %"std::io::error::Custom"* %4, i64 0, i32 1, i32 1
  %8 = bitcast [3 x i64]** %7 to void ({}*)***
  %9 = load void ({}*)**, void ({}*)*** %8, align 8, !nonnull !2
  %10 = load void ({}*)*, void ({}*)** %9, align 8, !invariant.load !2, !nonnull !2
  invoke void %10({}* mpk_unsafe nonnull %6)
          to label %bb3.i.i.i.i unwind label %cleanup.i.i.i.i

bb3.i.i.i.i:                                      ; preds = %bb2.i
  %11 = bitcast [3 x i64]** %7 to i64**
  %12 = load i64*, i64** %11, align 8, !nonnull !2
  %13 = getelementptr inbounds i64, i64* %12, i64 1
  %14 = load i64, i64* %13, align 8, !invariant.load !2, !alias.scope !101
  %15 = icmp eq i64 %14, 0
  br i1 %15, label %_ZN4core3ptr13drop_in_place17he93c203c18ccbb2fE.exit.i, label %bb3.i.i.i.i.i.i

bb3.i.i.i.i.i.i:                                  ; preds = %bb3.i.i.i.i
  %16 = bitcast %"std::io::error::Custom"* %4 to i8**
  %17 = load i8*, i8** %16, align 8, !nonnull !2
  %18 = getelementptr inbounds i64, i64* %12, i64 2
  %19 = load i64, i64* %18, align 8, !invariant.load !2, !alias.scope !101
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %17, i64 %14, i64 %19) #17, !noalias !101
  br label %_ZN4core3ptr13drop_in_place17he93c203c18ccbb2fE.exit.i

cleanup.i.i.i.i:                                  ; preds = %bb2.i
  %20 = landingpad { i8*, i32 }
          cleanup
  %21 = bitcast %"std::io::error::Custom"* %4 to i8**
  %22 = load i8*, i8** %21, align 8, !nonnull !2
  %23 = bitcast [3 x i64]** %7 to i64**
  %24 = load i64*, i64** %23, align 8, !nonnull !2
  tail call fastcc void @_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E(i8* mpk_immut mpk_unsafe nonnull %22, i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) %24) #18
  %25 = bitcast i8* %2 to i64**
  %26 = load i64*, i64** %25, align 8, !nonnull !2
  tail call fastcc void @_ZN5alloc5alloc8box_free17h7e16c4d8d2467375E(i64* mpk_immut mpk_unsafe nonnull %26) #18
  resume { i8*, i32 } %20

_ZN4core3ptr13drop_in_place17he93c203c18ccbb2fE.exit.i: ; preds = %bb3.i.i.i.i.i.i, %bb3.i.i.i.i
  %27 = bitcast i8* %2 to i8**
  %28 = load i8*, i8** %27, align 8, !nonnull !2
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %28, i64 24, i64 8) #17
  br label %_ZN4core3ptr13drop_in_place17he6082cab77d34f65E.exit

_ZN4core3ptr13drop_in_place17he6082cab77d34f65E.exit: ; preds = %_ZN4core3ptr13drop_in_place17he93c203c18ccbb2fE.exit.i, %start
  ret void
}

; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal fastcc void @_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E(i8* mpk_immut mpk_unsafe nonnull %0, i64* mpk_immut noalias readonly align 8 dereferenceable(24) %1) unnamed_addr #4 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %2 = getelementptr inbounds i64, i64* %1, i64 1
  %3 = load i64, i64* %2, align 8, !invariant.load !2
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit", label %bb3.i

bb3.i:                                            ; preds = %start
  %5 = getelementptr inbounds i64, i64* %1, i64 2
  %6 = load i64, i64* %5, align 8, !invariant.load !2
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %0, i64 %3, i64 %6) #17
  br label %"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit"

"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit": ; preds = %bb3.i, %start
  ret void
}

; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal fastcc void @_ZN5alloc5alloc8box_free17h7e16c4d8d2467375E(i64* mpk_immut mpk_unsafe nonnull %0) unnamed_addr #4 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
"_ZN62_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..AllocRef$GT$7dealloc17h0793a411d1f40a48E.exit":
  %_2.i = bitcast i64* %0 to i8*
  tail call void @__rust_dealloc(i8* mpk_unsafe nonnull %_2.i, i64 24, i64 8) #17
  ret void
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN85_$LT$rand..distributions..bernoulli..BernoulliError$u20$as$u20$core..fmt..Display$GT$3fmt17h6dde0cfe8df7066eE"(%"distributions::bernoulli::BernoulliError::InvalidProbability"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %0 = tail call zeroext i1 @_ZN4core3fmt9Formatter9write_str17hdd0117a4487b56c4E(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [45 x i8] }>* @alloc1215 to [0 x i8]*), i64 45)
  ret i1 %0
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN77_$LT$rand..distributions..slice..EmptySlice$u20$as$u20$core..fmt..Display$GT$3fmt17h25de40dbfc04b40aE"(%"distributions::slice::EmptySlice"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_4 = alloca %"core::fmt::Arguments", align 8
  %0 = bitcast %"core::fmt::Arguments"* %_4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %0)
  %1 = bitcast %"core::fmt::Arguments"* %_4 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc1004 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %1, align 8, !alias.scope !104, !noalias !107
  %2 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 1, i32 1
  store i64 1, i64* %2, align 8, !alias.scope !104, !noalias !107
  %3 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 3, i32 0
  store i64* null, i64** %3, align 8, !alias.scope !104, !noalias !107
  %4 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 0
  store [0 x { i8*, i64* }]* bitcast (<{ [0 x i8] }>* @alloc1006 to [0 x { i8*, i64* }]*), [0 x { i8*, i64* }]** %4, align 8, !alias.scope !104, !noalias !107
  %5 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 1
  store i64 0, i64* %5, align 8, !alias.scope !104, !noalias !107
  %6 = call zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, %"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_4)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %0)
  ret i1 %6
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN89_$LT$rand..distributions..weighted_index..WeightedError$u20$as$u20$core..fmt..Display$GT$3fmt17hc57f37e40b9c05f8E"(i8* mpk_immut noalias nocapture readonly align 1 dereferenceable(1) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %0 = load i8, i8* %self, align 1, !range !110
  %_5 = zext i8 %0 to i64
  switch i64 %_5, label %bb2 [
    i64 0, label %bb3
    i64 1, label %bb4
    i64 2, label %bb5
    i64 3, label %bb6
  ]

bb2:                                              ; preds = %start
  unreachable

bb3:                                              ; preds = %start
  br label %bb6

bb4:                                              ; preds = %start
  br label %bb6

bb5:                                              ; preds = %start
  br label %bb6

bb6:                                              ; preds = %bb5, %bb4, %bb3, %start
  %_4.sroa.7.0 = phi i64 [ 36, %bb5 ], [ 35, %bb4 ], [ 35, %bb3 ], [ 47, %start ]
  %_4.sroa.0.0 = phi [0 x i8]* [ bitcast (<{ [36 x i8] }>* @alloc1217 to [0 x i8]*), %bb5 ], [ bitcast (<{ [35 x i8] }>* @alloc1218 to [0 x i8]*), %bb4 ], [ bitcast (<{ [35 x i8] }>* @alloc1219 to [0 x i8]*), %bb3 ], [ bitcast (<{ [47 x i8] }>* @alloc1216 to [0 x i8]*), %start ]
  %1 = tail call zeroext i1 @_ZN4core3fmt9Formatter9write_str17hdd0117a4487b56c4E(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 %_4.sroa.0.0, i64 %_4.sroa.7.0)
  ret i1 %1
}

; Function Attrs: nounwind nonlazybind uwtable
define i32 @_ZN4rand13distributions7uniform16char_to_comp_u3217hbc025b2187da5355E(i32 %c) unnamed_addr #5 {
start:
  %0 = icmp ult i32 %c, 1114112
  tail call void @llvm.assume(i1 %0)
  %_6 = icmp ugt i32 %c, 55295
  %1 = add nsw i32 %c, -2048
  %.0 = select i1 %_6, i32 %1, i32 %c
  ret i32 %.0
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN75_$LT$rand..rngs..adapter..read..ReadError$u20$as$u20$core..fmt..Display$GT$3fmt17h45513c5e93de1697E"(%"rngs::adapter::read::ReadError"* mpk_immut noalias readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_11 = alloca [1 x { i8*, i64* }], align 8
  %_4 = alloca %"core::fmt::Arguments", align 8
  %0 = bitcast %"core::fmt::Arguments"* %_4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %0)
  %1 = bitcast [1 x { i8*, i64* }]* %_11 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %1)
  %2 = bitcast [1 x { i8*, i64* }]* %_11 to %"rngs::adapter::read::ReadError"**
  store %"rngs::adapter::read::ReadError"* %self, %"rngs::adapter::read::ReadError"** %2, align 8
  %3 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_11, i64 0, i64 0, i32 1
  store i64* bitcast (i1 (%"std::io::Error"*, %"core::fmt::Formatter"*)* @"_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17ha444a7daee083529E" to i64*), i64** %3, align 8
  %4 = bitcast %"core::fmt::Arguments"* %_4 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc1019 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %4, align 8, !alias.scope !111, !noalias !114
  %5 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 1, i32 1
  store i64 1, i64* %5, align 8, !alias.scope !111, !noalias !114
  %6 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 3, i32 0
  store i64* null, i64** %6, align 8, !alias.scope !111, !noalias !114
  %7 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 0
  %8 = bitcast [0 x { i8*, i64* }]** %7 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_11, [1 x { i8*, i64* }]** %8, align 8, !alias.scope !111, !noalias !114
  %9 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_4, i64 0, i32 5, i32 1
  store i64 1, i64* %9, align 8, !alias.scope !111, !noalias !114
  %10 = call zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, %"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_4)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %0)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %1)
  ret i1 %10
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define { i8*, i8* } @"_ZN74_$LT$rand..rngs..adapter..read..ReadError$u20$as$u20$std..error..Error$GT$6source17hffb300b3bf171b06E"(%"rngs::adapter::read::ReadError"* mpk_immut noalias readonly align 8 dereferenceable(16) %self) unnamed_addr #1 {
start:
  %0 = bitcast %"rngs::adapter::read::ReadError"* %self to i8*
  %1 = insertvalue { i8*, i8* } undef, i8* %0, 0
  %2 = insertvalue { i8*, i8* } %1, i8* bitcast ({ void (%"std::io::Error"*)*, i64, i64, { i8*, i8* } (%"std::io::Error"*)*, i64 (%"std::io::Error"*)*, i64* (%"std::io::Error"*)*, { [0 x i8]*, i64 } (%"std::io::Error"*)*, { i8*, i8* } (%"std::io::Error"*)*, i1 (%"std::io::Error"*, %"core::fmt::Formatter"*)*, i1 (%"std::io::Error"*, %"core::fmt::Formatter"*)* }* @vtable.6 to i8*), 1
  ret { i8*, i8* } %2
}

; Function Attrs: noinline nonlazybind uwtable
define internal fastcc void @"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$19reseed_and_generate17h0fe9ab5bf0f0e242E"(%"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* align 16 dereferenceable(80) %self, %"rand_chacha::chacha::Array64<u32>"* align 4 dereferenceable(256) %0, i64 %global_fork_counter) unnamed_addr #2 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_2.i.i.i = alloca %"rand_chacha::guts::ChaCha", align 16
  %_15.i.i = alloca [32 x i8], align 1
  %seed.i.i = alloca [32 x i8], align 1
  %_2.sroa.11.i = alloca [5 x i64], align 8
  %_2.sroa.11.0.sroa_cast.i = bitcast [5 x i64]* %_2.sroa.11.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %_2.sroa.11.0.sroa_cast.i)
  %.cast.i = bitcast %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self to %"rand_core::OsRng"*
  %1 = getelementptr inbounds [32 x i8], [32 x i8]* %seed.i.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %1), !noalias !117
  call void @llvm.memset.p0i8.i64(i8* nonnull align 1 dereferenceable(32) %1, i8 0, i64 32, i1 false), !alias.scope !120, !noalias !117
  %_5.0.i.i.i = bitcast [32 x i8]* %seed.i.i to [0 x i8]*
  %2 = call { i8*, i8* } @"_ZN59_$LT$rand_core..os..OsRng$u20$as$u20$rand_core..RngCore$GT$14try_fill_bytes17h856c329c7890d82bE"(%"rand_core::OsRng"* nonnull align 1 %.cast.i, [0 x i8]* nonnull align 1 %_5.0.i.i.i, i64 32), !noalias !117
  %.fca.0.extract.i.i = extractvalue { i8*, i8* } %2, 0
  %.fca.1.extract.i.i = extractvalue { i8*, i8* } %2, 1
  %3 = icmp eq i8* %.fca.0.extract.i.i, null
  br i1 %3, label %"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$6reseed17h4886e7ef3ab52b66E.exit.thread", label %bb10

"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$6reseed17h4886e7ef3ab52b66E.exit.thread": ; preds = %start
  %4 = getelementptr inbounds [32 x i8], [32 x i8]* %_15.i.i, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %4), !noalias !117
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(32) %4, i8* nonnull align 1 dereferenceable(32) %1, i64 32, i1 false), !noalias !117
  %5 = bitcast %"rand_chacha::guts::ChaCha"* %_2.i.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %5), !noalias !123
  call void @_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE(%"rand_chacha::guts::ChaCha"* noalias nocapture nonnull sret dereferenceable(48) %_2.i.i.i, [32 x i8]* mpk_immut noalias nonnull readonly align 1 dereferenceable(32) %_15.i.i, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc992 to [0 x i8]*), i64 8), !noalias !117
  %6 = getelementptr inbounds %"rand_chacha::guts::ChaCha", %"rand_chacha::guts::ChaCha"* %_2.i.i.i, i64 0, i32 0, i64 0
  %_14.sroa.0.i.sroa.0.0.copyload.i27 = load i64, i64* %6, align 16, !noalias !127
  %_14.sroa.0.i.sroa.4.0..sroa_idx.i = getelementptr inbounds %"rand_chacha::guts::ChaCha", %"rand_chacha::guts::ChaCha"* %_2.i.i.i, i64 0, i32 1, i32 0, i64 1
  %_14.sroa.0.i.sroa.4.0..sroa_cast.i = bitcast i64* %_14.sroa.0.i.sroa.4.0..sroa_idx.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %_2.sroa.11.0.sroa_cast.i, i8* nonnull align 8 dereferenceable(40) %_14.sroa.0.i.sroa.4.0..sroa_cast.i, i64 40, i1 false)
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %5), !noalias !123
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %4), !noalias !117
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %1), !noalias !117
  %7 = getelementptr inbounds %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>", %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self, i64 0, i32 5
  %_3.i.i.i = load i64, i64* %7, align 16, !noalias !128
  %8 = getelementptr inbounds %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>", %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self, i64 0, i32 7
  store i64 %_3.i.i.i, i64* %8, align 8, !noalias !128
  %9 = bitcast %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self to i64*
  store i64 %_14.sroa.0.i.sroa.0.0.copyload.i27, i64* %9, align 16
  %_2.sroa.11.16._7.sroa.0.0._4.sroa.0.0..sroa_idx.i.sroa_idx.i.sroa_idx.i = getelementptr inbounds %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>", %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self, i64 0, i32 3, i32 1, i32 1, i32 0, i64 1
  %_2.sroa.11.16._7.sroa.0.0._4.sroa.0.0..sroa_idx.i.sroa_idx.i.sroa_cast.i = bitcast i64* %_2.sroa.11.16._7.sroa.0.0._4.sroa.0.0..sroa_idx.i.sroa_idx.i.sroa_idx.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %_2.sroa.11.16._7.sroa.0.0._4.sroa.0.0..sroa_idx.i.sroa_idx.i.sroa_cast.i, i8* nonnull align 8 dereferenceable(40) %_2.sroa.11.0.sroa_cast.i, i64 40, i1 false)
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %_2.sroa.11.0.sroa_cast.i)
  br label %bb13

bb10:                                             ; preds = %start
  %10 = icmp ne i8* %.fca.1.extract.i.i, null
  call void @llvm.assume(i1 %10), !noalias !117
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %1), !noalias !117
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %_2.sroa.11.0.sroa_cast.i)
  %11 = bitcast i8* %.fca.0.extract.i.i to {}*
  %12 = bitcast i8* %.fca.1.extract.i.i to void ({}*)**
  %13 = load void ({}*)*, void ({}*)** %12, align 8, !invariant.load !2, !nonnull !2
  invoke void %13({}* mpk_unsafe nonnull %11)
          to label %bb3.i.i3 unwind label %cleanup.i.i5

bb3.i.i3:                                         ; preds = %bb10
  %14 = getelementptr inbounds i8, i8* %.fca.1.extract.i.i, i64 8
  %15 = bitcast i8* %14 to i64*
  %16 = load i64, i64* %15, align 8, !invariant.load !2, !alias.scope !133
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %bb13, label %bb3.i.i.i.i4

bb3.i.i.i.i4:                                     ; preds = %bb3.i.i3
  %18 = getelementptr inbounds i8, i8* %.fca.1.extract.i.i, i64 16
  %19 = bitcast i8* %18 to i64*
  %20 = load i64, i64* %19, align 8, !invariant.load !2, !alias.scope !133
  call void @__rust_dealloc(i8* mpk_unsafe nonnull %.fca.0.extract.i.i, i64 %16, i64 %20) #17, !noalias !133
  br label %bb13

cleanup.i.i5:                                     ; preds = %bb10
  %21 = landingpad { i8*, i32 }
          cleanup
  %22 = bitcast i8* %.fca.1.extract.i.i to i64*
  call fastcc void @_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E(i8* mpk_immut mpk_unsafe nonnull %.fca.0.extract.i.i, i64* mpk_immut noalias nonnull readonly align 8 dereferenceable(24) %22) #18
  resume { i8*, i32 } %21

bb13:                                             ; preds = %bb3.i.i.i.i4, %bb3.i.i3, %"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$6reseed17h4886e7ef3ab52b66E.exit.thread"
  %self.idx = getelementptr %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>", %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self, i64 0, i32 9
  store i64 %global_fork_counter, i64* %self.idx, align 16
  %23 = getelementptr inbounds %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>", %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self, i64 0, i32 5
  %_18 = load i64, i64* %23, align 16
  %24 = getelementptr inbounds %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>", %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self, i64 0, i32 7
  %25 = add i64 %_18, -256
  store i64 %25, i64* %24, align 8
  %_4.i = bitcast %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* %self to %"rand_chacha::guts::ChaCha"*
  %_8.i = bitcast %"rand_chacha::chacha::Array64<u32>"* %0 to [256 x i8]*
  call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"rand_chacha::guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i, i32 6, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i)
  ret void
}

; Function Attrs: nofree norecurse nounwind nonlazybind uwtable
define i64 @_ZN4rand4rngs7adapter9reseeding4fork16get_fork_counter17h7fbc1acd56a32364E() unnamed_addr #6 {
start:
  %0 = load atomic i64, i64* bitcast (<{ [8 x i8] }>* @_ZN4rand4rngs7adapter9reseeding4fork26RESEEDING_RNG_FORK_COUNTER17h9a9bdcd883a666abE to i64*) monotonic, align 8
  ret i64 %0
}

; Function Attrs: mpk_extern nofree norecurse nounwind nonlazybind uwtable
define internal void @_ZN4rand4rngs7adapter9reseeding4fork12fork_handler17h6bff1484396c250eE() unnamed_addr #7 {
start:
  %0 = atomicrmw add i64* bitcast (<{ [8 x i8] }>* @_ZN4rand4rngs7adapter9reseeding4fork26RESEEDING_RNG_FORK_COUNTER17h9a9bdcd883a666abE to i64*), i64 1 monotonic
  ret void
}

; Function Attrs: nonlazybind uwtable
define void @_ZN4rand4rngs7adapter9reseeding4fork21register_fork_handler17ha69e938d21d918b9E() unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %_12.i = alloca i8*, align 8
  %f.i = alloca i8, align 1
  %0 = load atomic i64, i64* bitcast (<{ [8 x i8] }>* @_ZN4rand4rngs7adapter9reseeding4fork21register_fork_handler8REGISTER17haea42ddb7cd0f47dE to i64*) acquire, align 8
  %1 = icmp eq i64 %0, 3
  br i1 %1, label %_ZN3std4sync4once4Once9call_once17hcf1a22c179b32ea5E.exit, label %bb2.i

bb2.i:                                            ; preds = %start
  call void @llvm.lifetime.start.p0i8(i64 1, i8* nonnull %f.i)
  store i8 1, i8* %f.i, align 1
  %2 = bitcast i8** %_12.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  store i8* %f.i, i8** %_12.i, align 8
  %_9.0.i = bitcast i8** %_12.i to {}*
  call void @_ZN3std4sync4once4Once10call_inner17hddcf8ee610748361E(%"std::sync::Once"* mpk_immut align 8 dereferenceable(8) bitcast (<{ [8 x i8] }>* @_ZN4rand4rngs7adapter9reseeding4fork21register_fork_handler8REGISTER17haea42ddb7cd0f47dE to %"std::sync::Once"*), i1 zeroext false, {}* nonnull align 1 %_9.0.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i8**)*, i64, i64, void (i8**, { i64, i8 }*)*, void (i8**, { i64, i8 }*)* }* @vtable.0 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  call void @llvm.lifetime.end.p0i8(i64 1, i8* nonnull %f.i)
  br label %_ZN3std4sync4once4Once9call_once17hcf1a22c179b32ea5E.exit

_ZN3std4sync4once4Once9call_once17hcf1a22c179b32ea5E.exit: ; preds = %bb2.i, %start
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readnone uwtable
define { i64, i64 } @_ZN4rand4rngs4mock7StepRng3new17hb4473b388a946d86E(i64 %initial, i64 %increment) unnamed_addr #1 {
start:
  %0 = insertvalue { i64, i64 } undef, i64 %initial, 0
  %1 = insertvalue { i64, i64 } %0, i64 %increment, 1
  ret { i64, i64 } %1
}

; Function Attrs: nonlazybind uwtable
define mpk_immut nonnull i64* @_ZN4rand4rngs6thread10thread_rng17h2cb0672f860288ceE() unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %e.i.i = alloca %"std::thread::AccessError", align 1
  %0 = load {}*, {}** bitcast (<{ [16 x i8] }>* @_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit5__KEY17h1640751eb8a80c47E to {}**), align 8, !alias.scope !136
  %1 = icmp eq {}* %0, null
  br i1 %1, label %_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit17h1d9bc0e3edef73abE.exit.i.i, label %start.bb4_crit_edge.i.i

start.bb4_crit_edge.i.i:                          ; preds = %start
  %2 = bitcast {}* %0 to i64*
  br label %bb4.i.i

_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit17h1d9bc0e3edef73abE.exit.i.i: ; preds = %start
  %3 = tail call fastcc mpk_immut align 8 dereferenceable_or_null(8) i64* @"_ZN3std6thread5local4fast12Key$LT$T$GT$14try_initialize17hd1125a449f5d2dc8E"()
  %4 = icmp eq i64* %3, null
  br i1 %4, label %"_ZN3std6thread5local17LocalKey$LT$T$GT$8try_with17h867a74f576e016b5E.exit.thread.i", label %_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit17h1d9bc0e3edef73abE.exit.bb4_crit_edge.i.i

"_ZN3std6thread5local17LocalKey$LT$T$GT$8try_with17h867a74f576e016b5E.exit.thread.i": ; preds = %_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit17h1d9bc0e3edef73abE.exit.i.i
  %5 = getelementptr inbounds %"std::thread::AccessError", %"std::thread::AccessError"* %e.i.i, i64 0, i32 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 0, i8* nonnull %5)
  %_6.0.i.i = bitcast %"std::thread::AccessError"* %e.i.i to {}*
  call void @_ZN4core6result13unwrap_failed17hf1bf530e85f5bb70E([0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [70 x i8] }>* @alloc1181 to [0 x i8]*), i64 70, {}* mpk_immut nonnull align 1 %_6.0.i.i, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"std::thread::AccessError"*)*, i64, i64, i1 (%"std::thread::AccessError"*, %"core::fmt::Formatter"*)* }* @vtable.3 to [3 x i64]*), %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc1183 to %"core::panic::Location"*))
  br label %UnifiedUnreachableBlock

_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit17h1d9bc0e3edef73abE.exit.bb4_crit_edge.i.i: ; preds = %_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit17h1d9bc0e3edef73abE.exit.i.i
  %.phi.trans.insert.i.i = bitcast i64* %3 to i64**
  %.val.pre.i.i = load i64*, i64** %.phi.trans.insert.i.i, align 8
  br label %bb4.i.i

bb4.i.i:                                          ; preds = %_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit17h1d9bc0e3edef73abE.exit.bb4_crit_edge.i.i, %start.bb4_crit_edge.i.i
  %.val.i.i = phi i64* [ %.val.pre.i.i, %_ZN4rand4rngs6thread14THREAD_RNG_KEY7__getit17h1d9bc0e3edef73abE.exit.bb4_crit_edge.i.i ], [ %2, %start.bb4_crit_edge.i.i ]
  %self.idx.val.i.i.i.i.i = load i64, i64* %.val.i.i, align 16
  switch i64 %self.idx.val.i.i.i.i.i, label %"_ZN3std6thread5local17LocalKey$LT$T$GT$4with17h15d8ca7407aa3e18E.exit" [
    i64 0, label %bb7.i.i.i.i.i
    i64 -1, label %bb7.i.i.i.i.i
  ]

bb7.i.i.i.i.i:                                    ; preds = %bb4.i.i, %bb4.i.i
  tail call void @llvm.trap() #17
  br label %UnifiedUnreachableBlock

"_ZN3std6thread5local17LocalKey$LT$T$GT$4with17h15d8ca7407aa3e18E.exit": ; preds = %bb4.i.i
  %_12.i.i.i.i.i = add nuw i64 %self.idx.val.i.i.i.i.i, 1
  store i64 %_12.i.i.i.i.i, i64* %.val.i.i, align 16
  ret i64* %.val.i.i

UnifiedUnreachableBlock:                          ; preds = %bb7.i.i.i.i.i, %"_ZN3std6thread5local17LocalKey$LT$T$GT$8try_with17h867a74f576e016b5E.exit.thread.i"
  unreachable
}

; Function Attrs: nonlazybind uwtable
define void @"_ZN68_$LT$rand..rngs..thread..ThreadRng$u20$as$u20$rand_core..RngCore$GT$10fill_bytes17h1d61929f860ce64aE"(i64** nocapture readonly align 8 dereferenceable(8) %self, [0 x i8]* nonnull align 1 %dest.0, i64 %dest.1) unnamed_addr #0 {
start:
  %self.val = load i64*, i64** %self, align 8
  %0 = getelementptr inbounds i64, i64* %self.val, i64 2
  %_3.i = bitcast i64* %0 to %"rand_core::block::BlockRng<rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>>"*
  %_410.not.i.i = icmp eq i64 %dest.1, 0
  br i1 %_410.not.i.i, label %"_ZN99_$LT$rand..rngs..adapter..reseeding..ReseedingRng$LT$R$C$Rsdr$GT$$u20$as$u20$rand_core..RngCore$GT$10fill_bytes17ha46d578dd99235a9E.exit", label %bb4.lr.ph.i.i

bb4.lr.ph.i.i:                                    ; preds = %start
  %1 = getelementptr inbounds i64, i64* %self.val, i64 3
  %2 = bitcast i64* %1 to %"rand_chacha::chacha::Array64<u32>"*
  %3 = getelementptr inbounds i64, i64* %self.val, i64 36
  %4 = bitcast i64* %3 to %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"*
  %5 = getelementptr inbounds i64, i64* %self.val, i64 43
  %6 = getelementptr i64, i64* %self.val, i64 44
  %_4.i.i.i.i.i = bitcast i64* %3 to %"rand_chacha::guts::ChaCha"*
  %_8.i.i.i.i.i = bitcast i64* %1 to [256 x i8]*
  %_9.pre.i.i = load i64, i64* %0, align 16
  br label %bb4.i.i

bb4.i.i:                                          ; preds = %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i", %bb4.lr.ph.i.i
  %_9.i.i = phi i64 [ %_9.pre.i.i, %bb4.lr.ph.i.i ], [ %17, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i" ]
  %read_len.011.i.i = phi i64 [ 0, %bb4.lr.ph.i.i ], [ %18, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i" ]
  %_8.not.i.i = icmp ult i64 %_9.i.i, 64
  br i1 %_8.not.i.i, label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i", label %bb8.i.i

bb8.i.i:                                          ; preds = %bb4.i.i
  %7 = load atomic i64, i64* bitcast (<{ [8 x i8] }>* @_ZN4rand4rngs7adapter9reseeding4fork26RESEEDING_RNG_FORK_COUNTER17h9a9bdcd883a666abE to i64*) monotonic, align 8
  %_6.i.i.i.i = load i64, i64* %5, align 8
  %_5.i.i.i.i = icmp slt i64 %_6.i.i.i.i, 1
  br i1 %_5.i.i.i.i, label %bb8.i.i.i.i, label %bb4.i.i.i.i

bb4.i.i.i.i:                                      ; preds = %bb8.i.i
  %self.idx.val.i.i.i.i = load i64, i64* %6, align 16
  %8 = sub i64 %self.idx.val.i.i.i.i, %7
  %9 = icmp slt i64 %8, 0
  br i1 %9, label %bb8.i.i.i.i, label %bb7.i.i.i.i

bb7.i.i.i.i:                                      ; preds = %bb4.i.i.i.i
  %10 = add nsw i64 %_6.i.i.i.i, -256
  store i64 %10, i64* %5, align 8
  tail call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"rand_chacha::guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i.i.i.i.i, i32 6, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i.i.i.i.i)
  br label %"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i"

bb8.i.i.i.i:                                      ; preds = %bb4.i.i.i.i, %bb8.i.i
  tail call fastcc void @"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$19reseed_and_generate17h0fe9ab5bf0f0e242E"(%"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* nonnull align 16 dereferenceable(80) %4, %"rand_chacha::chacha::Array64<u32>"* nonnull align 4 dereferenceable(256) %2, i64 %7)
  br label %"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i"

"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i": ; preds = %bb8.i.i.i.i, %bb7.i.i.i.i
  store i64 0, i64* %0, align 16
  br label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i"

"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i": ; preds = %"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i", %bb4.i.i
  %_26.i.i = phi i64 [ %_9.i.i, %bb4.i.i ], [ 0, %"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i" ]
  %_4.i.i.i.i = icmp ugt i64 %read_len.011.i.i, %dest.1
  br i1 %_4.i.i.i.i, label %bb3.i.i.i.i, label %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i"

bb3.i.i.i.i:                                      ; preds = %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i"
  tail call void @_ZN4core5slice5index26slice_start_index_len_fail17h2ad4471ff7be2fa2E(i64 %read_len.011.i.i, i64 %dest.1, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc1209 to %"core::panic::Location"*))
  unreachable

"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i": ; preds = %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i"
  %11 = getelementptr inbounds %"rand_core::block::BlockRng<rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>>", %"rand_core::block::BlockRng<rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>>"* %_3.i, i64 0, i32 3, i32 0, i64 %_26.i.i
  %12 = bitcast i32* %11 to [0 x i32]*
  %_7.i.i.i.i8.i.i = sub nuw nsw i64 64, %_26.i.i
  %13 = getelementptr inbounds [0 x i8], [0 x i8]* %dest.0, i64 0, i64 %read_len.011.i.i
  %_7.i.i.i.i.i.i = sub i64 %dest.1, %read_len.011.i.i
  %14 = bitcast i8* %13 to [0 x i8]*
  %15 = tail call { i64, i64 } @_ZN9rand_core5impls19fill_via_u32_chunks17h6f6c6e3fe88df0c3E([0 x i32]* mpk_immut noalias nonnull readonly align 4 %12, i64 %_7.i.i.i.i8.i.i, [0 x i8]* nonnull align 1 %14, i64 %_7.i.i.i.i.i.i)
  %_18.0.i.i = extractvalue { i64, i64 } %15, 0
  %_18.1.i.i = extractvalue { i64, i64 } %15, 1
  %16 = load i64, i64* %0, align 16
  %17 = add i64 %16, %_18.0.i.i
  store i64 %17, i64* %0, align 16
  %18 = add i64 %_18.1.i.i, %read_len.011.i.i
  %_4.i.i = icmp ult i64 %18, %dest.1
  br i1 %_4.i.i, label %bb4.i.i, label %"_ZN99_$LT$rand..rngs..adapter..reseeding..ReseedingRng$LT$R$C$Rsdr$GT$$u20$as$u20$rand_core..RngCore$GT$10fill_bytes17ha46d578dd99235a9E.exit"

"_ZN99_$LT$rand..rngs..adapter..reseeding..ReseedingRng$LT$R$C$Rsdr$GT$$u20$as$u20$rand_core..RngCore$GT$10fill_bytes17ha46d578dd99235a9E.exit": ; preds = %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i", %start
  ret void
}

; Function Attrs: nonlazybind uwtable
define { i8*, i8* } @"_ZN68_$LT$rand..rngs..thread..ThreadRng$u20$as$u20$rand_core..RngCore$GT$14try_fill_bytes17he76a8d3f6b2b351fE"(i64** nocapture readonly align 8 dereferenceable(8) %self, [0 x i8]* nonnull align 1 %dest.0, i64 %dest.1) unnamed_addr #0 {
start:
  %self.val = load i64*, i64** %self, align 8
  %0 = getelementptr inbounds i64, i64* %self.val, i64 2
  %_3.i = bitcast i64* %0 to %"rand_core::block::BlockRng<rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>>"*
  %_410.not.i.i.i = icmp eq i64 %dest.1, 0
  br i1 %_410.not.i.i.i, label %"_ZN99_$LT$rand..rngs..adapter..reseeding..ReseedingRng$LT$R$C$Rsdr$GT$$u20$as$u20$rand_core..RngCore$GT$14try_fill_bytes17h394d27be2442cf21E.exit", label %bb4.lr.ph.i.i.i

bb4.lr.ph.i.i.i:                                  ; preds = %start
  %1 = getelementptr inbounds i64, i64* %self.val, i64 3
  %2 = bitcast i64* %1 to %"rand_chacha::chacha::Array64<u32>"*
  %3 = getelementptr inbounds i64, i64* %self.val, i64 36
  %4 = bitcast i64* %3 to %"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"*
  %5 = getelementptr inbounds i64, i64* %self.val, i64 43
  %6 = getelementptr i64, i64* %self.val, i64 44
  %_4.i.i.i.i.i.i = bitcast i64* %3 to %"rand_chacha::guts::ChaCha"*
  %_8.i.i.i.i.i.i = bitcast i64* %1 to [256 x i8]*
  %_9.pre.i.i.i = load i64, i64* %0, align 16
  br label %bb4.i.i.i

bb4.i.i.i:                                        ; preds = %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i.i", %bb4.lr.ph.i.i.i
  %_9.i.i.i = phi i64 [ %_9.pre.i.i.i, %bb4.lr.ph.i.i.i ], [ %17, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i.i" ]
  %read_len.011.i.i.i = phi i64 [ 0, %bb4.lr.ph.i.i.i ], [ %18, %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i.i" ]
  %_8.not.i.i.i = icmp ult i64 %_9.i.i.i, 64
  br i1 %_8.not.i.i.i, label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i.i", label %bb8.i.i.i

bb8.i.i.i:                                        ; preds = %bb4.i.i.i
  %7 = load atomic i64, i64* bitcast (<{ [8 x i8] }>* @_ZN4rand4rngs7adapter9reseeding4fork26RESEEDING_RNG_FORK_COUNTER17h9a9bdcd883a666abE to i64*) monotonic, align 8
  %_6.i.i.i.i.i = load i64, i64* %5, align 8
  %_5.i.i.i.i.i = icmp slt i64 %_6.i.i.i.i.i, 1
  br i1 %_5.i.i.i.i.i, label %bb8.i.i.i.i.i, label %bb4.i.i.i.i.i

bb4.i.i.i.i.i:                                    ; preds = %bb8.i.i.i
  %self.idx.val.i.i.i.i.i = load i64, i64* %6, align 16
  %8 = sub i64 %self.idx.val.i.i.i.i.i, %7
  %9 = icmp slt i64 %8, 0
  br i1 %9, label %bb8.i.i.i.i.i, label %bb7.i.i.i.i.i

bb7.i.i.i.i.i:                                    ; preds = %bb4.i.i.i.i.i
  %10 = add nsw i64 %_6.i.i.i.i.i, -256
  store i64 %10, i64* %5, align 8
  tail call void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"rand_chacha::guts::ChaCha"* nonnull align 16 dereferenceable(48) %_4.i.i.i.i.i.i, i32 6, [256 x i8]* nonnull align 1 dereferenceable(256) %_8.i.i.i.i.i.i)
  br label %"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i.i"

bb8.i.i.i.i.i:                                    ; preds = %bb4.i.i.i.i.i, %bb8.i.i.i
  tail call fastcc void @"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$19reseed_and_generate17h0fe9ab5bf0f0e242E"(%"rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>"* nonnull align 16 dereferenceable(80) %4, %"rand_chacha::chacha::Array64<u32>"* nonnull align 4 dereferenceable(256) %2, i64 %7)
  br label %"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i.i"

"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i.i": ; preds = %bb8.i.i.i.i.i, %bb7.i.i.i.i.i
  store i64 0, i64* %0, align 16
  br label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i.i"

"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i.i": ; preds = %"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i.i", %bb4.i.i.i
  %_26.i.i.i = phi i64 [ %_9.i.i.i, %bb4.i.i.i ], [ 0, %"_ZN9rand_core5block17BlockRng$LT$R$GT$16generate_and_set17hdcb2bf485419a0fdE.exit.i.i.i" ]
  %_4.i.i.i.i.i = icmp ugt i64 %read_len.011.i.i.i, %dest.1
  br i1 %_4.i.i.i.i.i, label %bb3.i.i.i.i.i, label %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i.i"

bb3.i.i.i.i.i:                                    ; preds = %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i.i"
  tail call void @_ZN4core5slice5index26slice_start_index_len_fail17h2ad4471ff7be2fa2E(i64 %read_len.011.i.i.i, i64 %dest.1, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc1209 to %"core::panic::Location"*))
  unreachable

"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i.i": ; preds = %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h6b8a89f07ff6630bE.exit.i.i.i"
  %11 = getelementptr inbounds %"rand_core::block::BlockRng<rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>>", %"rand_core::block::BlockRng<rngs::adapter::reseeding::ReseedingCore<rand_chacha::ChaCha12Core, rand_core::OsRng>>"* %_3.i, i64 0, i32 3, i32 0, i64 %_26.i.i.i
  %12 = bitcast i32* %11 to [0 x i32]*
  %_7.i.i.i.i8.i.i.i = sub nuw nsw i64 64, %_26.i.i.i
  %13 = getelementptr inbounds [0 x i8], [0 x i8]* %dest.0, i64 0, i64 %read_len.011.i.i.i
  %_7.i.i.i.i.i.i.i = sub i64 %dest.1, %read_len.011.i.i.i
  %14 = bitcast i8* %13 to [0 x i8]*
  %15 = tail call { i64, i64 } @_ZN9rand_core5impls19fill_via_u32_chunks17h6f6c6e3fe88df0c3E([0 x i32]* mpk_immut noalias nonnull readonly align 4 %12, i64 %_7.i.i.i.i8.i.i.i, [0 x i8]* nonnull align 1 %14, i64 %_7.i.i.i.i.i.i.i)
  %_18.0.i.i.i = extractvalue { i64, i64 } %15, 0
  %_18.1.i.i.i = extractvalue { i64, i64 } %15, 1
  %16 = load i64, i64* %0, align 16
  %17 = add i64 %16, %_18.0.i.i.i
  store i64 %17, i64* %0, align 16
  %18 = add i64 %_18.1.i.i.i, %read_len.011.i.i.i
  %_4.i.i.i = icmp ult i64 %18, %dest.1
  br i1 %_4.i.i.i, label %bb4.i.i.i, label %"_ZN99_$LT$rand..rngs..adapter..reseeding..ReseedingRng$LT$R$C$Rsdr$GT$$u20$as$u20$rand_core..RngCore$GT$14try_fill_bytes17h394d27be2442cf21E.exit"

"_ZN99_$LT$rand..rngs..adapter..reseeding..ReseedingRng$LT$R$C$Rsdr$GT$$u20$as$u20$rand_core..RngCore$GT$14try_fill_bytes17h394d27be2442cf21E.exit": ; preds = %"_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h9407302db9bec56fE.exit.i.i.i", %start
  ret { i8*, i8* } { i8* null, i8* undef }
}

; Function Attrs: nounwind nonlazybind uwtable
define zeroext i1 @"_ZN67_$LT$rand..seq..index..IndexVec$u20$as$u20$core..cmp..PartialEq$GT$2eq17h503d2edbe1e9658dE"(%"seq::index::IndexVec"* mpk_immut noalias readonly align 8 dereferenceable(32) %self, %"seq::index::IndexVec"* mpk_immut noalias readonly align 8 dereferenceable(32) %other) unnamed_addr #5 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %0 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %self, i64 0, i32 0, i64 0
  %_8 = load i64, i64* %0, align 8, !range !139
  %switch.not = icmp eq i64 %_8, 1
  %1 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %other, i64 0, i32 0, i64 0
  %_6 = load i64, i64* %1, align 8, !range !139
  %switch11.not = icmp eq i64 %_6, 1
  %2 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %self, i64 0, i32 2
  %3 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %other, i64 0, i32 2
  br i1 %switch.not, label %bb3, label %bb1

bb1:                                              ; preds = %start
  br i1 %switch11.not, label %bb9, label %bb5

bb3:                                              ; preds = %start
  br i1 %switch11.not, label %bb7, label %bb4

bb4:                                              ; preds = %bb3
  %4 = getelementptr %"seq::index::IndexVec", %"seq::index::IndexVec"* %self, i64 0, i32 2, i64 2
  %.idx25.val = load i64, i64* %4, align 8
  %5 = getelementptr %"seq::index::IndexVec", %"seq::index::IndexVec"* %other, i64 0, i32 2, i64 2
  %.idx27.val = load i64, i64* %5, align 8
  %_38 = icmp eq i64 %.idx25.val, %.idx27.val
  br i1 %_38, label %bb1.i.preheader.i, label %bb34

bb5:                                              ; preds = %bb1
  %6 = bitcast [3 x i64]* %2 to [0 x i32]**
  %_3.idx.val.i1.i.i.i.i56 = load [0 x i32]*, [0 x i32]** %6, align 8, !alias.scope !140, !noalias !149, !nonnull !2
  %7 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %self, i64 0, i32 2, i64 2
  %_4.i.i.i.i57 = load i64, i64* %7, align 8, !alias.scope !151, !noalias !149
  %8 = bitcast [3 x i64]* %3 to [0 x i32]**
  %_3.idx.val.i1.i.i1.i.i58 = load [0 x i32]*, [0 x i32]** %8, align 8, !alias.scope !152, !noalias !159, !nonnull !2
  %9 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %other, i64 0, i32 2, i64 2
  %_4.i.i2.i.i59 = load i64, i64* %9, align 8, !alias.scope !160, !noalias !159
  %_3.not.i.i.i.i60 = icmp eq i64 %_4.i.i.i.i57, %_4.i.i2.i.i59
  br i1 %_3.not.i.i.i.i60, label %bb3.i.i.i.i61, label %bb34

bb3.i.i.i.i61:                                    ; preds = %bb5
  %10 = icmp eq [0 x i32]* %_3.idx.val.i1.i.i.i.i56, %_3.idx.val.i1.i.i1.i.i58
  br i1 %10, label %bb34, label %bb8.i.i.i.i65

bb8.i.i.i.i65:                                    ; preds = %bb3.i.i.i.i61
  %11 = shl i64 %_4.i.i.i.i57, 2
  %_17.i.i.i.i62 = bitcast [0 x i32]* %_3.idx.val.i1.i.i.i.i56 to i8*
  %_20.i.i.i.i63 = bitcast [0 x i32]* %_3.idx.val.i1.i.i1.i.i58 to i8*
  %bcmp.i.i.i.i64 = tail call i32 @bcmp(i8* nonnull %_17.i.i.i.i62, i8* nonnull %_20.i.i.i.i63, i64 %11) #17, !noalias !161
  %12 = icmp eq i32 %bcmp.i.i.i.i64, 0
  br label %bb34

bb7:                                              ; preds = %bb3
  %13 = bitcast [3 x i64]* %2 to [0 x i64]**
  %_3.idx.val.i1.i.i.i.i = load [0 x i64]*, [0 x i64]** %13, align 8, !alias.scope !162, !noalias !171, !nonnull !2
  %14 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %self, i64 0, i32 2, i64 2
  %_4.i.i.i.i55 = load i64, i64* %14, align 8, !alias.scope !173, !noalias !171
  %15 = bitcast [3 x i64]* %3 to [0 x i64]**
  %_3.idx.val.i1.i.i1.i.i = load [0 x i64]*, [0 x i64]** %15, align 8, !alias.scope !174, !noalias !181, !nonnull !2
  %16 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %other, i64 0, i32 2, i64 2
  %_4.i.i2.i.i = load i64, i64* %16, align 8, !alias.scope !182, !noalias !181
  %_3.not.i.i.i.i = icmp eq i64 %_4.i.i.i.i55, %_4.i.i2.i.i
  br i1 %_3.not.i.i.i.i, label %bb3.i.i.i.i, label %bb34

bb3.i.i.i.i:                                      ; preds = %bb7
  %17 = icmp eq [0 x i64]* %_3.idx.val.i1.i.i.i.i, %_3.idx.val.i1.i.i1.i.i
  br i1 %17, label %bb34, label %bb8.i.i.i.i

bb8.i.i.i.i:                                      ; preds = %bb3.i.i.i.i
  %18 = shl i64 %_4.i.i.i.i55, 3
  %_17.i.i.i.i = bitcast [0 x i64]* %_3.idx.val.i1.i.i.i.i to i8*
  %_20.i.i.i.i = bitcast [0 x i64]* %_3.idx.val.i1.i.i1.i.i to i8*
  %bcmp.i.i.i.i = tail call i32 @bcmp(i8* nonnull %_17.i.i.i.i, i8* nonnull %_20.i.i.i.i, i64 %18) #17, !noalias !183
  %19 = icmp eq i32 %bcmp.i.i.i.i, 0
  br label %bb34

bb9:                                              ; preds = %bb1
  %20 = getelementptr %"seq::index::IndexVec", %"seq::index::IndexVec"* %self, i64 0, i32 2, i64 2
  %.idx26.val = load i64, i64* %20, align 8
  %21 = getelementptr %"seq::index::IndexVec", %"seq::index::IndexVec"* %other, i64 0, i32 2, i64 2
  %.idx.val = load i64, i64* %21, align 8
  %_19 = icmp eq i64 %.idx26.val, %.idx.val
  br i1 %_19, label %bb1.i.preheader.i38, label %bb34

bb1.i.preheader.i38:                              ; preds = %bb9
  %22 = bitcast [3 x i64]* %2 to [0 x i32]**
  %_3.idx.val.i1.i53 = load [0 x i32]*, [0 x i32]** %22, align 8, !alias.scope !184, !nonnull !2
  %23 = bitcast [3 x i64]* %3 to [0 x i64]**
  %_3.idx.val.i1.i51 = load [0 x i64]*, [0 x i64]** %23, align 8, !alias.scope !189, !nonnull !2
  br label %bb1.i.i44

bb1.i.i44:                                        ; preds = %bb2.i.i48, %bb1.i.preheader.i38
  %_3.i.i.i.i42 = phi i64 [ %24, %bb2.i.i48 ], [ 0, %bb1.i.preheader.i38 ]
  %exitcond.not.i43 = icmp eq i64 %_3.i.i.i.i42, %.idx26.val
  br i1 %exitcond.not.i43, label %bb34, label %bb2.i.i48

bb2.i.i48:                                        ; preds = %bb1.i.i44
  %24 = add i64 %_3.i.i.i.i42, 1
  %25 = getelementptr inbounds [0 x i64], [0 x i64]* %_3.idx.val.i1.i51, i64 0, i64 %_3.i.i.i.i42
  %26 = getelementptr inbounds [0 x i32], [0 x i32]* %_3.idx.val.i1.i53, i64 0, i64 %_3.i.i.i.i42
  %.fca.0.extract.val.i.i45 = load i32, i32* %26, align 4
  %.val.i.i46 = load i64, i64* %25, align 8
  %_5.i.i.i.i = zext i32 %.fca.0.extract.val.i.i45 to i64
  %.not24.i.i47 = icmp eq i64 %.val.i.i46, %_5.i.i.i.i
  br i1 %.not24.i.i47, label %bb1.i.i44, label %bb34

bb1.i.preheader.i:                                ; preds = %bb4
  %27 = bitcast [3 x i64]* %2 to [0 x i64]**
  %_3.idx.val.i1.i28 = load [0 x i64]*, [0 x i64]** %27, align 8, !alias.scope !194, !nonnull !2
  %28 = bitcast [3 x i64]* %3 to [0 x i32]**
  %_3.idx.val.i1.i = load [0 x i32]*, [0 x i32]** %28, align 8, !alias.scope !199, !nonnull !2
  br label %bb1.i.i

bb1.i.i:                                          ; preds = %bb2.i.i, %bb1.i.preheader.i
  %_3.i.i.i.i = phi i64 [ %29, %bb2.i.i ], [ 0, %bb1.i.preheader.i ]
  %exitcond.not.i = icmp eq i64 %_3.i.i.i.i, %.idx25.val
  br i1 %exitcond.not.i, label %bb34, label %bb2.i.i

bb2.i.i:                                          ; preds = %bb1.i.i
  %29 = add i64 %_3.i.i.i.i, 1
  %30 = getelementptr inbounds [0 x i32], [0 x i32]* %_3.idx.val.i1.i, i64 0, i64 %_3.i.i.i.i
  %31 = getelementptr inbounds [0 x i64], [0 x i64]* %_3.idx.val.i1.i28, i64 0, i64 %_3.i.i.i.i
  %.fca.0.extract.val.i.i = load i64, i64* %31, align 8
  %.val.i.i = load i32, i32* %30, align 4
  %_6.i.i.i.i = zext i32 %.val.i.i to i64
  %.not24.i.i = icmp eq i64 %.fca.0.extract.val.i.i, %_6.i.i.i.i
  br i1 %.not24.i.i, label %bb1.i.i, label %bb34

bb34:                                             ; preds = %bb2.i.i, %bb1.i.i, %bb2.i.i48, %bb1.i.i44, %bb9, %bb8.i.i.i.i, %bb3.i.i.i.i, %bb7, %bb8.i.i.i.i65, %bb3.i.i.i.i61, %bb5, %bb4
  %.0.shrunk = phi i1 [ %12, %bb8.i.i.i.i65 ], [ false, %bb5 ], [ true, %bb3.i.i.i.i61 ], [ %19, %bb8.i.i.i.i ], [ false, %bb7 ], [ true, %bb3.i.i.i.i ], [ false, %bb9 ], [ false, %bb4 ], [ true, %bb1.i.i ], [ false, %bb2.i.i ], [ true, %bb1.i.i44 ], [ false, %bb2.i.i48 ]
  ret i1 %.0.shrunk
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN78_$LT$rand..distributions..bernoulli..Bernoulli$u20$as$u20$core..fmt..Debug$GT$3fmt17h0c1e2ffb90162b88E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_15 = alloca i64*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugStruct", align 8
  %0 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [9 x i8] }>* @alloc1220 to [0 x i8]*), i64 9)
  %.0..sroa_cast = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast i64** %_15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  store i64* %self, i64** %_15, align 8
  %_12.0 = bitcast i64** %_15 to {}*
  %_8 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1221 to [0 x i8]*), i64 5, {}* mpk_immut nonnull align 1 %_12.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.7 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %3 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %3
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN83_$LT$rand..distributions..bernoulli..BernoulliError$u20$as$u20$core..fmt..Debug$GT$3fmt17h107b70640e17ecdeE"(%"distributions::bernoulli::BernoulliError::InvalidProbability"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [18 x i8] }>* @alloc1222 to [0 x i8]*), i64 18)
  %1 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %1
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN77_$LT$rand..distributions..float..OpenClosed01$u20$as$u20$core..fmt..Debug$GT$3fmt17h2473a3f750517e06E"(%"distributions::float::OpenClosed01"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [12 x i8] }>* @alloc1223 to [0 x i8]*), i64 12)
  %1 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %1
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN71_$LT$rand..distributions..float..Open01$u20$as$u20$core..fmt..Debug$GT$3fmt17h4a14390b8f7fcf89E"(%"distributions::float::Open01"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc1224 to [0 x i8]*), i64 6)
  %1 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %1
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN77_$LT$rand..distributions..other..Alphanumeric$u20$as$u20$core..fmt..Debug$GT$3fmt17h31fd246fb7061e6cE"(%"distributions::other::Alphanumeric"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [12 x i8] }>* @alloc1225 to [0 x i8]*), i64 12)
  %1 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %1
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN75_$LT$rand..distributions..slice..EmptySlice$u20$as$u20$core..fmt..Debug$GT$3fmt17h8158ead9d3deea7aE"(%"distributions::slice::EmptySlice"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [10 x i8] }>* @alloc1226 to [0 x i8]*), i64 10)
  %1 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %1
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN87_$LT$rand..distributions..weighted_index..WeightedError$u20$as$u20$core..fmt..Debug$GT$3fmt17h19e3ccfb81c0e92aE"(i8* mpk_immut noalias nocapture readonly align 1 dereferenceable(1) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %debug_trait_builder3 = alloca %"core::fmt::DebugTuple", align 8
  %debug_trait_builder2 = alloca %"core::fmt::DebugTuple", align 8
  %debug_trait_builder1 = alloca %"core::fmt::DebugTuple", align 8
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = load i8, i8* %self, align 1, !range !110
  %_5 = zext i8 %0 to i64
  switch i64 %_5, label %bb2 [
    i64 0, label %bb3
    i64 1, label %bb6
    i64 2, label %bb9
    i64 3, label %bb1
  ]

bb1:                                              ; preds = %start
  %1 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder3, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [7 x i8] }>* @alloc1227 to [0 x i8]*), i64 7)
  %2 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder3)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
  br label %bb14

bb2:                                              ; preds = %start
  unreachable

bb3:                                              ; preds = %start
  %3 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %3)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc1230 to [0 x i8]*), i64 6)
  %4 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %3)
  br label %bb14

bb6:                                              ; preds = %start
  %5 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %5)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder1, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [13 x i8] }>* @alloc1229 to [0 x i8]*), i64 13)
  %6 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder1)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %5)
  br label %bb14

bb9:                                              ; preds = %start
  %7 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %7)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder2, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [14 x i8] }>* @alloc1228 to [0 x i8]*), i64 14)
  %8 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder2)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %7)
  br label %bb14

bb14:                                             ; preds = %bb9, %bb6, %bb3, %bb1
  %.0.in = phi i1 [ %2, %bb1 ], [ %8, %bb9 ], [ %6, %bb6 ], [ %4, %bb3 ]
  ret i1 %.0.in
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN78_$LT$rand..distributions..uniform..UniformChar$u20$as$u20$core..fmt..Debug$GT$3fmt17h9f42180f1c9e23deE"(%"distributions::uniform::UniformChar"* mpk_immut noalias readonly align 4 dereferenceable(12) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_15 = alloca %"distributions::uniform::UniformInt<u32>"*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugStruct", align 8
  %0 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [11 x i8] }>* @alloc1241 to [0 x i8]*), i64 11)
  %.0..sroa_cast = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast %"distributions::uniform::UniformInt<u32>"** %_15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast %"distributions::uniform::UniformInt<u32>"** %_15 to %"distributions::uniform::UniformChar"**
  store %"distributions::uniform::UniformChar"* %self, %"distributions::uniform::UniformChar"** %3, align 8
  %_12.0 = bitcast %"distributions::uniform::UniformInt<u32>"** %_15 to {}*
  %_8 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [7 x i8] }>* @alloc1242 to [0 x i8]*), i64 7, {}* mpk_immut nonnull align 1 %_12.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"distributions::uniform::UniformInt<u32>"**)*, i64, i64, i1 (%"distributions::uniform::UniformInt<u32>"**, %"core::fmt::Formatter"*)* }* @vtable.9 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %4 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %4
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN82_$LT$rand..distributions..uniform..UniformDuration$u20$as$u20$core..fmt..Debug$GT$3fmt17hd8ed4b740d149804E"(%"distributions::uniform::UniformDuration"* mpk_immut noalias readonly align 8 dereferenceable(48) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_24 = alloca i32*, align 8
  %_16 = alloca %"distributions::uniform::UniformDurationMode"*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugStruct", align 8
  %__self_0_1 = getelementptr inbounds %"distributions::uniform::UniformDuration", %"distributions::uniform::UniformDuration"* %self, i64 0, i32 3
  %0 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [15 x i8] }>* @alloc1243 to [0 x i8]*), i64 15)
  %.0..sroa_cast = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast %"distributions::uniform::UniformDurationMode"** %_16 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast %"distributions::uniform::UniformDurationMode"** %_16 to %"distributions::uniform::UniformDuration"**
  store %"distributions::uniform::UniformDuration"* %self, %"distributions::uniform::UniformDuration"** %3, align 8
  %_13.0 = bitcast %"distributions::uniform::UniformDurationMode"** %_16 to {}*
  %_9 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc1244 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_13.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"distributions::uniform::UniformDurationMode"**)*, i64, i64, i1 (%"distributions::uniform::UniformDurationMode"**, %"core::fmt::Formatter"*)* }* @vtable.a to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %4 = bitcast i32** %_24 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4)
  store i32* %__self_0_1, i32** %_24, align 8
  %_21.0 = bitcast i32** %_24 to {}*
  %_17 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc1245 to [0 x i8]*), i64 6, {}* mpk_immut nonnull align 1 %_21.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4)
  %5 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %5
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN86_$LT$rand..distributions..uniform..UniformDurationMode$u20$as$u20$core..fmt..Debug$GT$3fmt17h6c2e8ee4c2eab8abE"(%"distributions::uniform::UniformDurationMode"* mpk_immut noalias readonly align 8 dereferenceable(40) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_73 = alloca %"distributions::uniform::Uniform<u64>"*, align 8
  %_65 = alloca i32*, align 8
  %_57 = alloca i64*, align 8
  %debug_trait_builder2 = alloca %"core::fmt::DebugStruct", align 8
  %_41 = alloca %"distributions::uniform::Uniform<u64>"*, align 8
  %debug_trait_builder1 = alloca %"core::fmt::DebugStruct", align 8
  %_27 = alloca %"distributions::uniform::Uniform<u32>"*, align 8
  %_19 = alloca i64*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugStruct", align 8
  %0 = getelementptr inbounds %"distributions::uniform::UniformDurationMode", %"distributions::uniform::UniformDurationMode"* %self, i64 0, i32 0, i64 0
  %1 = load i32, i32* %0, align 8, !range !204
  %_5 = zext i32 %1 to i64
  switch i64 %_5, label %bb2 [
    i64 0, label %bb3
    i64 1, label %bb8
    i64 2, label %bb1
  ]

bb1:                                              ; preds = %start
  %__self_0 = getelementptr inbounds %"distributions::uniform::UniformDurationMode", %"distributions::uniform::UniformDurationMode"* %self, i64 0, i32 2, i64 1
  %2 = getelementptr inbounds %"distributions::uniform::UniformDurationMode", %"distributions::uniform::UniformDurationMode"* %self, i64 0, i32 2, i64 0
  %__self_2 = getelementptr inbounds %"distributions::uniform::UniformDurationMode", %"distributions::uniform::UniformDurationMode"* %self, i64 0, i32 2, i64 3
  %3 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %3)
  %4 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1246 to [0 x i8]*), i64 5)
  %.0..sroa_cast = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder2 to i128*
  store i128 %4, i128* %.0..sroa_cast, align 8
  %5 = bitcast i64** %_57 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %5)
  %6 = bitcast i64** %_57 to i32**
  store i32* %__self_0, i32** %6, align 8
  %_54.0 = bitcast i64** %_57 to {}*
  %_50 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder2, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc1247 to [0 x i8]*), i64 8, {}* mpk_immut nonnull align 1 %_54.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.7 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %5)
  %7 = bitcast i32** %_65 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %7)
  store i32* %2, i32** %_65, align 8
  %_62.0 = bitcast i32** %_65 to {}*
  %_58 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder2, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [9 x i8] }>* @alloc1248 to [0 x i8]*), i64 9, {}* mpk_immut nonnull align 1 %_62.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i32**)*, i64, i64, i1 (i32**, %"core::fmt::Formatter"*)* }* @vtable.2 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %7)
  %8 = bitcast %"distributions::uniform::Uniform<u64>"** %_73 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %8)
  %9 = bitcast %"distributions::uniform::Uniform<u64>"** %_73 to i32**
  store i32* %__self_2, i32** %9, align 8
  %_70.0 = bitcast %"distributions::uniform::Uniform<u64>"** %_73 to {}*
  %_66 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder2, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc1253 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_70.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"distributions::uniform::Uniform<u64>"**)*, i64, i64, i1 (%"distributions::uniform::Uniform<u64>"**, %"core::fmt::Formatter"*)* }* @vtable.b to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %8)
  %10 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder2)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %3)
  br label %bb17

bb2:                                              ; preds = %start
  unreachable

bb3:                                              ; preds = %start
  %__self_04 = getelementptr inbounds %"distributions::uniform::UniformDurationMode", %"distributions::uniform::UniformDurationMode"* %self, i64 0, i32 2, i64 3
  %__self_15 = getelementptr inbounds %"distributions::uniform::UniformDurationMode", %"distributions::uniform::UniformDurationMode"* %self, i64 0, i32 2
  %11 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %11)
  %12 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1252 to [0 x i8]*), i64 5)
  %.0..sroa_cast19 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %12, i128* %.0..sroa_cast19, align 8
  %13 = bitcast i64** %_19 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %13)
  %14 = bitcast i64** %_19 to i32**
  store i32* %__self_04, i32** %14, align 8
  %_16.0 = bitcast i64** %_19 to {}*
  %_12 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [4 x i8] }>* @alloc1253 to [0 x i8]*), i64 4, {}* mpk_immut nonnull align 1 %_16.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.7 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %13)
  %15 = bitcast %"distributions::uniform::Uniform<u32>"** %_27 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %15)
  %16 = bitcast %"distributions::uniform::Uniform<u32>"** %_27 to [9 x i32]**
  store [9 x i32]* %__self_15, [9 x i32]** %16, align 8
  %_24.0 = bitcast %"distributions::uniform::Uniform<u32>"** %_27 to {}*
  %_20 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1254 to [0 x i8]*), i64 5, {}* mpk_immut nonnull align 1 %_24.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"distributions::uniform::Uniform<u32>"**)*, i64, i64, i1 (%"distributions::uniform::Uniform<u32>"**, %"core::fmt::Formatter"*)* }* @vtable.c to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %15)
  %17 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %11)
  br label %bb17

bb8:                                              ; preds = %start
  %__self_03 = getelementptr inbounds %"distributions::uniform::UniformDurationMode", %"distributions::uniform::UniformDurationMode"* %self, i64 0, i32 2, i64 1
  %18 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %18)
  %19 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc1250 to [0 x i8]*), i64 6)
  %.0..sroa_cast15 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder1 to i128*
  store i128 %19, i128* %.0..sroa_cast15, align 8
  %20 = bitcast %"distributions::uniform::Uniform<u64>"** %_41 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %20)
  %21 = bitcast %"distributions::uniform::Uniform<u64>"** %_41 to i32**
  store i32* %__self_03, i32** %21, align 8
  %_38.0 = bitcast %"distributions::uniform::Uniform<u64>"** %_41 to {}*
  %_34 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder1, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1254 to [0 x i8]*), i64 5, {}* mpk_immut nonnull align 1 %_38.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"distributions::uniform::Uniform<u64>"**)*, i64, i64, i1 (%"distributions::uniform::Uniform<u64>"**, %"core::fmt::Formatter"*)* }* @vtable.b to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %20)
  %22 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder1)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %18)
  br label %bb17

bb17:                                             ; preds = %bb8, %bb3, %bb1
  %.0.in = phi i1 [ %10, %bb1 ], [ %22, %bb8 ], [ %17, %bb3 ]
  ret i1 %.0.in
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN66_$LT$rand..distributions..Standard$u20$as$u20$core..fmt..Debug$GT$3fmt17ha94e243a92eb3514E"(%"distributions::Standard"* mpk_immut noalias nocapture nonnull readonly align 1 %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [8 x i8] }>* @alloc1255 to [0 x i8]*), i64 8)
  %1 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %1
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN73_$LT$rand..rngs..adapter..read..ReadError$u20$as$u20$core..fmt..Debug$GT$3fmt17h87d86a6a867ffdd8E"(%"rngs::adapter::read::ReadError"* mpk_immut noalias readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_13 = alloca %"std::io::Error"*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [9 x i8] }>* @alloc1256 to [0 x i8]*), i64 9)
  %1 = bitcast %"std::io::Error"** %_13 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %1)
  %2 = bitcast %"std::io::Error"** %_13 to %"rngs::adapter::read::ReadError"**
  store %"rngs::adapter::read::ReadError"* %self, %"rngs::adapter::read::ReadError"** %2, align 8
  %_10.0 = bitcast %"std::io::Error"** %_13 to {}*
  %_8 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder, {}* mpk_immut nonnull align 1 %_10.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"std::io::Error"**)*, i64, i64, i1 (%"std::io::Error"**, %"core::fmt::Formatter"*)* }* @vtable.d to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %1)
  %3 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %3
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN62_$LT$rand..rngs..mock..StepRng$u20$as$u20$core..fmt..Debug$GT$3fmt17h48ebc5bfd9045279E"({ i64, i64 }* mpk_immut noalias readonly align 8 dereferenceable(16) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_24 = alloca i64*, align 8
  %_16 = alloca i64*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugStruct", align 8
  %__self_0_0 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %self, i64 0, i32 0
  %__self_0_1 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %self, i64 0, i32 1
  %0 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [7 x i8] }>* @alloc1257 to [0 x i8]*), i64 7)
  %.0..sroa_cast = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast i64** %_16 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  store i64* %__self_0_0, i64** %_16, align 8
  %_13.0 = bitcast i64** %_16 to {}*
  %_9 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [1 x i8] }>* @alloc1258 to [0 x i8]*), i64 1, {}* mpk_immut nonnull align 1 %_13.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.7 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast i64** %_24 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3)
  store i64* %__self_0_1, i64** %_24, align 8
  %_21.0 = bitcast i64** %_24 to {}*
  %_17 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [1 x i8] }>* @alloc1259 to [0 x i8]*), i64 1, {}* mpk_immut nonnull align 1 %_21.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64**)*, i64, i64, i1 (i64**, %"core::fmt::Formatter"*)* }* @vtable.7 to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3)
  %4 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %4
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN60_$LT$rand..rngs..std..StdRng$u20$as$u20$core..fmt..Debug$GT$3fmt17h5ef89a36e47d58a8E"(%"rngs::std::StdRng"* mpk_immut noalias readonly align 16 dereferenceable(320) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_13 = alloca %"rand_chacha::ChaCha12Rng"*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc1260 to [0 x i8]*), i64 6)
  %1 = bitcast %"rand_chacha::ChaCha12Rng"** %_13 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %1)
  %2 = bitcast %"rand_chacha::ChaCha12Rng"** %_13 to %"rngs::std::StdRng"**
  store %"rngs::std::StdRng"* %self, %"rngs::std::StdRng"** %2, align 8
  %_10.0 = bitcast %"rand_chacha::ChaCha12Rng"** %_13 to {}*
  %_8 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder, {}* mpk_immut nonnull align 1 %_10.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"rand_chacha::ChaCha12Rng"**)*, i64, i64, i1 (%"rand_chacha::ChaCha12Rng"**, %"core::fmt::Formatter"*)* }* @vtable.e to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %1)
  %3 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %0)
  ret i1 %3
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN66_$LT$rand..rngs..thread..ThreadRng$u20$as$u20$core..fmt..Debug$GT$3fmt17h773509bbd112568bE"(i64** mpk_immut noalias readonly align 8 dereferenceable(8) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_15 = alloca i64**, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugStruct", align 8
  %0 = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %0)
  %1 = tail call i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [9 x i8] }>* @alloc1261 to [0 x i8]*), i64 9)
  %.0..sroa_cast = bitcast %"core::fmt::DebugStruct"* %debug_trait_builder to i128*
  store i128 %1, i128* %.0..sroa_cast, align 8
  %2 = bitcast i64*** %_15 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  store i64** %self, i64*** %_15, align 8
  %_12.0 = bitcast i64*** %_15 to {}*
  %_8 = call align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc1262 to [0 x i8]*), i64 3, {}* mpk_immut nonnull align 1 %_12.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (i64***)*, i64, i64, i1 (i64***, %"core::fmt::Formatter"*)* }* @vtable.f to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %3 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* nonnull align 8 dereferenceable(16) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %0)
  ret i1 %3
}

; Function Attrs: noreturn nonlazybind uwtable
define internal fastcc void @"_ZN4rand4rngs6thread14THREAD_RNG_KEY6__init28_$u7b$$u7b$closure$u7d$$u7d$17h2d208157d1a52da6E"(i8* mpk_immut noalias nonnull align 1 %0, i64* mpk_immut noalias readonly align 8 dereferenceable(24) %1) unnamed_addr #8 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
bb2:
  %_10 = alloca [1 x { i8*, i64* }], align 8
  %_3 = alloca %"core::fmt::Arguments", align 8
  %err = alloca { i8*, i64* }, align 8
  %2 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %err, i64 0, i32 0
  store i8* %0, i8** %2, align 8
  %3 = getelementptr inbounds { i8*, i64* }, { i8*, i64* }* %err, i64 0, i32 1
  store i64* %1, i64** %3, align 8
  %4 = bitcast %"core::fmt::Arguments"* %_3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %4)
  %5 = bitcast [1 x { i8*, i64* }]* %_10 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %5)
  %6 = bitcast [1 x { i8*, i64* }]* %_10 to { i8*, i64* }**
  store { i8*, i64* }* %err, { i8*, i64* }** %6, align 8
  %7 = getelementptr inbounds [1 x { i8*, i64* }], [1 x { i8*, i64* }]* %_10, i64 0, i64 0, i32 1
  store i64* bitcast (i1 ({ i8*, i64* }*, %"core::fmt::Formatter"*)* @"_ZN62_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h9df079ff3e7ae672E" to i64*), i64** %7, align 8
  %8 = bitcast %"core::fmt::Arguments"* %_3 to [0 x { [0 x i8]*, i64 }]**
  store [0 x { [0 x i8]*, i64 }]* bitcast (<{ i8*, [8 x i8] }>* @alloc995 to [0 x { [0 x i8]*, i64 }]*), [0 x { [0 x i8]*, i64 }]** %8, align 8, !alias.scope !205, !noalias !208
  %9 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_3, i64 0, i32 1, i32 1
  store i64 1, i64* %9, align 8, !alias.scope !205, !noalias !208
  %10 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_3, i64 0, i32 3, i32 0
  store i64* null, i64** %10, align 8, !alias.scope !205, !noalias !208
  %11 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_3, i64 0, i32 5, i32 0
  %12 = bitcast [0 x { i8*, i64* }]** %11 to [1 x { i8*, i64* }]**
  store [1 x { i8*, i64* }]* %_10, [1 x { i8*, i64* }]** %12, align 8, !alias.scope !205, !noalias !208
  %13 = getelementptr inbounds %"core::fmt::Arguments", %"core::fmt::Arguments"* %_3, i64 0, i32 5, i32 1
  store i64 1, i64* %13, align 8, !alias.scope !205, !noalias !208
  invoke void @_ZN4core9panicking9panic_fmt17h08461824ca4df3e0E(%"core::fmt::Arguments"* noalias nocapture nonnull dereferenceable(48) %_3, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc1264 to %"core::panic::Location"*))
          to label %unreachable unwind label %cleanup

cleanup:                                          ; preds = %bb2
  %14 = landingpad { i8*, i32 }
          cleanup
  call fastcc void @_ZN4core3ptr13drop_in_place17h3a402e9bd9e0af26E({ i8*, i64* }* mpk_unsafe nonnull %err) #18
  resume { i8*, i32 } %14

unreachable:                                      ; preds = %bb2
  unreachable
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN63_$LT$rand..seq..index..IndexVec$u20$as$u20$core..fmt..Debug$GT$3fmt17h6e1684107b006b4fE"(%"seq::index::IndexVec"* mpk_immut noalias readonly align 8 dereferenceable(32) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_28 = alloca %"std::vec::Vec<usize>"*, align 8
  %debug_trait_builder1 = alloca %"core::fmt::DebugTuple", align 8
  %_16 = alloca %"std::vec::Vec<u32>"*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %self, i64 0, i32 0, i64 0
  %_5 = load i64, i64* %0, align 8, !range !139
  %switch.not = icmp eq i64 %_5, 1
  %__self_0 = getelementptr inbounds %"seq::index::IndexVec", %"seq::index::IndexVec"* %self, i64 0, i32 2
  br i1 %switch.not, label %bb1, label %bb3

bb1:                                              ; preds = %start
  %1 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder1, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1269 to [0 x i8]*), i64 5)
  %2 = bitcast %"std::vec::Vec<usize>"** %_28 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast %"std::vec::Vec<usize>"** %_28 to [3 x i64]**
  store [3 x i64]* %__self_0, [3 x i64]** %3, align 8
  %_25.0 = bitcast %"std::vec::Vec<usize>"** %_28 to {}*
  %_23 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder1, {}* mpk_immut nonnull align 1 %_25.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"std::vec::Vec<usize>"**)*, i64, i64, i1 (%"std::vec::Vec<usize>"**, %"core::fmt::Formatter"*)* }* @vtable.g to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %4 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder1)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
  br label %bb10

bb3:                                              ; preds = %start
  %5 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %5)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc1270 to [0 x i8]*), i64 3)
  %6 = bitcast %"std::vec::Vec<u32>"** %_16 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %6)
  %7 = bitcast %"std::vec::Vec<u32>"** %_16 to [3 x i64]**
  store [3 x i64]* %__self_0, [3 x i64]** %7, align 8
  %_13.0 = bitcast %"std::vec::Vec<u32>"** %_16 to {}*
  %_11 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder, {}* mpk_immut nonnull align 1 %_13.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"std::vec::Vec<u32>"**)*, i64, i64, i1 (%"std::vec::Vec<u32>"**, %"core::fmt::Formatter"*)* }* @vtable.h to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %6)
  %8 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %5)
  br label %bb10

bb10:                                             ; preds = %bb3, %bb1
  %.0.in = phi i1 [ %8, %bb3 ], [ %4, %bb1 ]
  ret i1 %.0.in
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN67_$LT$rand..seq..index..IndexVecIter$u20$as$u20$core..fmt..Debug$GT$3fmt17he73e99056a740e77E"(%"seq::index::IndexVecIter"* mpk_immut noalias readonly align 8 dereferenceable(24) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_28 = alloca { i64*, i64* }*, align 8
  %debug_trait_builder1 = alloca %"core::fmt::DebugTuple", align 8
  %_16 = alloca { i32*, i32* }*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = getelementptr inbounds %"seq::index::IndexVecIter", %"seq::index::IndexVecIter"* %self, i64 0, i32 0, i64 0
  %_5 = load i64, i64* %0, align 8, !range !139
  %switch.not = icmp eq i64 %_5, 1
  %__self_0 = getelementptr inbounds %"seq::index::IndexVecIter", %"seq::index::IndexVecIter"* %self, i64 0, i32 2
  br i1 %switch.not, label %bb1, label %bb3

bb1:                                              ; preds = %start
  %1 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder1, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1269 to [0 x i8]*), i64 5)
  %2 = bitcast { i64*, i64* }** %_28 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast { i64*, i64* }** %_28 to [2 x i64]**
  store [2 x i64]* %__self_0, [2 x i64]** %3, align 8
  %_25.0 = bitcast { i64*, i64* }** %_28 to {}*
  %_23 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder1, {}* mpk_immut nonnull align 1 %_25.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ i64*, i64* }**)*, i64, i64, i1 ({ i64*, i64* }**, %"core::fmt::Formatter"*)* }* @vtable.i to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %4 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder1)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
  br label %bb10

bb3:                                              ; preds = %start
  %5 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %5)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc1270 to [0 x i8]*), i64 3)
  %6 = bitcast { i32*, i32* }** %_16 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %6)
  %7 = bitcast { i32*, i32* }** %_16 to [2 x i64]**
  store [2 x i64]* %__self_0, [2 x i64]** %7, align 8
  %_13.0 = bitcast { i32*, i32* }** %_16 to {}*
  %_11 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder, {}* mpk_immut nonnull align 1 %_13.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void ({ i32*, i32* }**)*, i64, i64, i1 ({ i32*, i32* }**, %"core::fmt::Formatter"*)* }* @vtable.j to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %6)
  %8 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %5)
  br label %bb10

bb10:                                             ; preds = %bb3, %bb1
  %.0.in = phi i1 [ %8, %bb3 ], [ %4, %bb1 ]
  ret i1 %.0.in
}

; Function Attrs: nonlazybind uwtable
define zeroext i1 @"_ZN71_$LT$rand..seq..index..IndexVecIntoIter$u20$as$u20$core..fmt..Debug$GT$3fmt17h0ec8f85612534d47E"(%"seq::index::IndexVecIntoIter"* mpk_immut noalias readonly align 8 dereferenceable(40) %self, %"core::fmt::Formatter"* align 8 dereferenceable(64) %f) unnamed_addr #0 {
start:
  %_28 = alloca %"std::vec::IntoIter<usize>"*, align 8
  %debug_trait_builder1 = alloca %"core::fmt::DebugTuple", align 8
  %_16 = alloca %"std::vec::IntoIter<u32>"*, align 8
  %debug_trait_builder = alloca %"core::fmt::DebugTuple", align 8
  %0 = getelementptr inbounds %"seq::index::IndexVecIntoIter", %"seq::index::IndexVecIntoIter"* %self, i64 0, i32 0, i64 0
  %_5 = load i64, i64* %0, align 8, !range !139
  %switch.not = icmp eq i64 %_5, 1
  %__self_0 = getelementptr inbounds %"seq::index::IndexVecIntoIter", %"seq::index::IndexVecIntoIter"* %self, i64 0, i32 2
  br i1 %switch.not, label %bb1, label %bb3

bb1:                                              ; preds = %start
  %1 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder1, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [5 x i8] }>* @alloc1269 to [0 x i8]*), i64 5)
  %2 = bitcast %"std::vec::IntoIter<usize>"** %_28 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %2)
  %3 = bitcast %"std::vec::IntoIter<usize>"** %_28 to [4 x i64]**
  store [4 x i64]* %__self_0, [4 x i64]** %3, align 8
  %_25.0 = bitcast %"std::vec::IntoIter<usize>"** %_28 to {}*
  %_23 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder1, {}* mpk_immut nonnull align 1 %_25.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"std::vec::IntoIter<usize>"**)*, i64, i64, i1 (%"std::vec::IntoIter<usize>"**, %"core::fmt::Formatter"*)* }* @vtable.k to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %2)
  %4 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder1)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
  br label %bb10

bb3:                                              ; preds = %start
  %5 = bitcast %"core::fmt::DebugTuple"* %debug_trait_builder to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %5)
  call void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture nonnull sret dereferenceable(24) %debug_trait_builder, %"core::fmt::Formatter"* nonnull align 8 dereferenceable(64) %f, [0 x i8]* mpk_immut noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc1270 to [0 x i8]*), i64 3)
  %6 = bitcast %"std::vec::IntoIter<u32>"** %_16 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %6)
  %7 = bitcast %"std::vec::IntoIter<u32>"** %_16 to [4 x i64]**
  store [4 x i64]* %__self_0, [4 x i64]** %7, align 8
  %_13.0 = bitcast %"std::vec::IntoIter<u32>"** %_16 to {}*
  %_11 = call align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder, {}* mpk_immut nonnull align 1 %_13.0, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24) bitcast ({ void (%"std::vec::IntoIter<u32>"**)*, i64, i64, i1 (%"std::vec::IntoIter<u32>"**, %"core::fmt::Formatter"*)* }* @vtable.l to [3 x i64]*))
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %6)
  %8 = call zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* nonnull align 8 dereferenceable(24) %debug_trait_builder)
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %5)
  br label %bb10

bb10:                                             ; preds = %bb3, %bb1
  %.0.in = phi i1 [ %8, %bb3 ], [ %4, %bb1 ]
  ret i1 %.0.in
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #9

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #9

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core5slice5index26slice_start_index_len_fail17h2ad4471ff7be2fa2E(i64, i64, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #10

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @rust_eh_personality(i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"* mpk_unsafe, %"unwind::libunwind::_Unwind_Context"* mpk_unsafe) unnamed_addr #3

; Function Attrs: nonlazybind uwtable
declare void @_ZN11rand_chacha4guts11init_chacha17hcda304da48ae938fE(%"rand_chacha::guts::ChaCha"* noalias nocapture sret dereferenceable(48), [32 x i8]* mpk_immut noalias readonly align 1 dereferenceable(32), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare void @_ZN11rand_chacha4guts11refill_wide17hfd3cee71b44f67e4E(%"rand_chacha::guts::ChaCha"* align 16 dereferenceable(48), i32, [256 x i8]* align 1 dereferenceable(256)) unnamed_addr #0

; Function Attrs: cold nonlazybind uwtable
declare void @_ZN3std4sync4once4Once10call_inner17hddcf8ee610748361E(%"std::sync::Once"* mpk_immut align 8 dereferenceable(8), i1 zeroext, {}* nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #11

; Function Attrs: nonlazybind uwtable
declare void @_ZN3std3sys4unix17thread_local_dtor13register_dtor17h55b3b522a1e219b3E(i8* mpk_unsafe, void (i8*)* mpk_immut nonnull) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN58_$LT$std..io..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h92bc210ff9abc8b7E"(%"std::io::Error"* mpk_immut noalias readonly align 8 dereferenceable(16), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN69_$LT$rand_chacha..chacha..ChaCha12Rng$u20$as$u20$core..fmt..Debug$GT$3fmt17h59b609cdf02c63acE"(%"rand_chacha::ChaCha12Rng"* mpk_immut noalias readonly align 16 dereferenceable(320), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN4core3fmt9Formatter10debug_list17h8147fa4f8cb43178E(%"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #9

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt8builders9DebugList6finish17h1110a7134d6ce275E(%"core::fmt::DebugList"* align 8 dereferenceable(16)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter15debug_lower_hex17h6ddb5559176c6045E(%"core::fmt::Formatter"* mpk_immut noalias readonly align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hbdab60765508c6f3E"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter15debug_upper_hex17h61a2e870dc3af9acE(%"core::fmt::Formatter"* mpk_immut noalias readonly align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h4773017a326a508bE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h6b8b41e24df1a43fE"(i32* mpk_immut noalias readonly align 4 dereferenceable(4), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17he9d3331e4e8b2618E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u64$GT$3fmt17h46c4aab50ded2d21E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h4dc2af1a5829180dE"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h3fb07f7e6da8e1c6E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$usize$GT$3fmt17hf3a9e839be306c07E"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h0f57e3373191c50eE"(i64* mpk_immut noalias readonly align 8 dereferenceable(8), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare align 8 dereferenceable(16) %"core::fmt::DebugList"* @_ZN4core3fmt8builders9DebugList5entry17h65db77502f12805cE(%"core::fmt::DebugList"* align 8 dereferenceable(16), {}* mpk_immut nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #0

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking5panic17hc14ab8d72efd34afE([0 x i8]* mpk_immut noalias nonnull readonly align 1, i64, %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #10

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking9panic_fmt17h08461824ca4df3e0E(%"core::fmt::Arguments"* noalias nocapture dereferenceable(48), %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #10

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1) #12

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN68_$LT$std..thread..local..AccessError$u20$as$u20$core..fmt..Debug$GT$3fmt17ha315f601bcb7816fE"(%"std::thread::AccessError"* mpk_immut noalias nonnull readonly align 1, %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core6result13unwrap_failed17hf1bf530e85f5bb70E([0 x i8]* mpk_immut noalias nonnull readonly align 1, i64, {}* mpk_immut nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24), %"core::panic::Location"* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #10

; Function Attrs: nonlazybind uwtable
declare { i8*, i8* } @"_ZN59_$LT$rand_core..os..OsRng$u20$as$u20$rand_core..RngCore$GT$14try_fill_bytes17h856c329c7890d82bE"(%"rand_core::OsRng"* nonnull align 1, [0 x i8]* nonnull align 1, i64) unnamed_addr #0

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #13

; Function Attrs: noreturn nounwind nonlazybind uwtable
declare void @_ZN5alloc5alloc18handle_alloc_error17h988aff758f9fc198E(i64, i64) unnamed_addr #14

; Function Attrs: nounwind nonlazybind uwtable
declare mpk_unsafe noalias i8* @__rust_alloc(i64, i64) unnamed_addr #5

; Function Attrs: nounwind nonlazybind uwtable
declare void @__rust_dealloc(i8* mpk_unsafe, i64, i64) unnamed_addr #5

; Function Attrs: nonlazybind uwtable
declare void @_ZN4core3fmt9Formatter11debug_tuple17had636d1c61c1720cE(%"core::fmt::DebugTuple"* noalias nocapture sret dereferenceable(24), %"core::fmt::Formatter"* align 8 dereferenceable(64), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare align 8 dereferenceable(24) %"core::fmt::DebugTuple"* @_ZN4core3fmt8builders10DebugTuple5field17he382aec0d37198f2E(%"core::fmt::DebugTuple"* align 8 dereferenceable(24), {}* mpk_immut nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt8builders10DebugTuple6finish17hfb7845347804f609E(%"core::fmt::DebugTuple"* align 8 dereferenceable(24)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter3pad17h77c5e3cc34c58830E(%"core::fmt::Formatter"* align 8 dereferenceable(64), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare { i64, i64 } @_ZN9rand_core5impls19fill_via_u32_chunks17h6f6c6e3fe88df0c3E([0 x i32]* mpk_immut noalias nonnull readonly align 4, i64, [0 x i8]* nonnull align 1, i64) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter9write_str17hdd0117a4487b56c4E(%"core::fmt::Formatter"* align 8 dereferenceable(64), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt9Formatter9write_fmt17h767ce03da9bc508fE(%"core::fmt::Formatter"* align 8 dereferenceable(64), %"core::fmt::Arguments"* noalias nocapture dereferenceable(48)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17ha444a7daee083529E"(%"std::io::Error"* mpk_immut noalias readonly align 8 dereferenceable(16), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare { i8*, i8* } @"_ZN59_$LT$std..io..error..Error$u20$as$u20$std..error..Error$GT$6source17h58eb92854d84e79fE"(%"std::io::Error"* mpk_immut noalias readonly align 8 dereferenceable(16)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare { [0 x i8]*, i64 } @"_ZN59_$LT$std..io..error..Error$u20$as$u20$std..error..Error$GT$11description17hdc6ea995e10d5d20E"(%"std::io::Error"* mpk_immut noalias readonly align 8 dereferenceable(16)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare { i8*, i8* } @"_ZN59_$LT$std..io..error..Error$u20$as$u20$std..error..Error$GT$5cause17h1043acf78dfb3752E"(%"std::io::Error"* mpk_immut noalias readonly align 8 dereferenceable(16)) unnamed_addr #0

; Function Attrs: mpk_extern nounwind nonlazybind uwtable
declare i32 @pthread_atfork(i64* mpk_immut, i64* mpk_immut, i64* mpk_immut) unnamed_addr #3

; Function Attrs: nonlazybind uwtable
declare i128 @_ZN4core3fmt9Formatter12debug_struct17h966f42198588d5ffE(%"core::fmt::Formatter"* align 8 dereferenceable(64), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare align 8 dereferenceable(16) %"core::fmt::DebugStruct"* @_ZN4core3fmt8builders11DebugStruct5field17h0ff9ad91302e7217E(%"core::fmt::DebugStruct"* align 8 dereferenceable(16), [0 x i8]* mpk_immut noalias nonnull readonly align 1, i64, {}* mpk_immut nonnull align 1, [3 x i64]* mpk_immut noalias readonly align 8 dereferenceable(24)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt8builders11DebugStruct6finish17h72e9687c51511b31E(%"core::fmt::DebugStruct"* align 8 dereferenceable(16)) unnamed_addr #0

; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN62_$LT$rand_core..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h9df079ff3e7ae672E"({ i8*, i64* }* mpk_immut noalias readonly align 8 dereferenceable(16), %"core::fmt::Formatter"* align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nofree nounwind nonlazybind readonly
declare i32 @bcmp(i8* nocapture, i8* nocapture, i64) local_unnamed_addr #15

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #16

attributes #0 = { nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #1 = { norecurse nounwind nonlazybind readnone uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #2 = { noinline nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #3 = { mpk_extern nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #4 = { inlinehint nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #5 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #6 = { nofree norecurse nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #7 = { mpk_extern nofree norecurse nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #8 = { noreturn nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #9 = { argmemonly nounwind willreturn }
attributes #10 = { cold noinline noreturn nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #11 = { cold nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #12 = { nounwind willreturn }
attributes #13 = { cold noreturn nounwind }
attributes #14 = { noreturn nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #15 = { nofree nounwind nonlazybind readonly }
attributes #16 = { argmemonly nounwind willreturn writeonly }
attributes #17 = { nounwind }
attributes #18 = { noinline }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
!3 = !{i8 0, i8 3}
!4 = !{!5}
!5 = distinct !{!5, !6, !"_ZN9rand_core11SeedableRng8from_rng17hd9a6581211c5d462E: argument 0"}
!6 = distinct !{!6, !"_ZN9rand_core11SeedableRng8from_rng17hd9a6581211c5d462E"}
!7 = !{!8}
!8 = distinct !{!8, !9, !"_ZN4core5array76_$LT$impl$u20$core..default..Default$u20$for$u20$$u5b$T$u3b$$u20$32$u5d$$GT$7default17ha0af058987a24009E: argument 0"}
!9 = distinct !{!9, !"_ZN4core5array76_$LT$impl$u20$core..default..Default$u20$for$u20$$u5b$T$u3b$$u20$32$u5d$$GT$7default17ha0af058987a24009E"}
!10 = !{!11, !13}
!11 = distinct !{!11, !12, !"_ZN4core6result19Result$LT$T$C$E$GT$14unwrap_or_else17h89eb03b8df1920f1E: argument 0"}
!12 = distinct !{!12, !"_ZN4core6result19Result$LT$T$C$E$GT$14unwrap_or_else17h89eb03b8df1920f1E"}
!13 = distinct !{!13, !12, !"_ZN4core6result19Result$LT$T$C$E$GT$14unwrap_or_else17h89eb03b8df1920f1E: %self"}
!14 = !{!15, !17, !5}
!15 = distinct !{!15, !16, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E: argument 0"}
!16 = distinct !{!16, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E"}
!17 = distinct !{!17, !16, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E: %seed"}
!18 = !{!17, !5}
!19 = !{!20, !22, !23, !25}
!20 = distinct !{!20, !21, !"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$3new17ha955930b3db61233E: argument 0"}
!21 = distinct !{!21, !"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$3new17ha955930b3db61233E"}
!22 = distinct !{!22, !21, !"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$3new17ha955930b3db61233E: %rng"}
!23 = distinct !{!23, !24, !"_ZN4rand4rngs7adapter9reseeding28ReseedingRng$LT$R$C$Rsdr$GT$3new17h042d496b358a6704E: argument 0"}
!24 = distinct !{!24, !"_ZN4rand4rngs7adapter9reseeding28ReseedingRng$LT$R$C$Rsdr$GT$3new17h042d496b358a6704E"}
!25 = distinct !{!25, !24, !"_ZN4rand4rngs7adapter9reseeding28ReseedingRng$LT$R$C$Rsdr$GT$3new17h042d496b358a6704E: %rng"}
!26 = !{!25}
!27 = !{!28}
!28 = distinct !{!28, !29, !"_ZN5alloc2rc11Rc$LT$T$GT$3new17h3cb4277146cc8440E: %value"}
!29 = distinct !{!29, !"_ZN5alloc2rc11Rc$LT$T$GT$3new17h3cb4277146cc8440E"}
!30 = !{i64 1, i64 0}
!31 = !{!32}
!32 = distinct !{!32, !33, !"_ZN83_$LT$rand..distributions..uniform..Uniform$LT$X$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hef4f0358794d3102E: %self"}
!33 = distinct !{!33, !"_ZN83_$LT$rand..distributions..uniform..Uniform$LT$X$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hef4f0358794d3102E"}
!34 = !{!35}
!35 = distinct !{!35, !36, !"_ZN69_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hc9d6dc65eeb640cdE: %self"}
!36 = distinct !{!36, !"_ZN69_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hc9d6dc65eeb640cdE"}
!37 = !{!38, !40, !35}
!38 = distinct !{!38, !39, !"_ZN4core5slice4iter13Iter$LT$T$GT$10make_slice17had370a4e92540ac0E: %self"}
!39 = distinct !{!39, !"_ZN4core5slice4iter13Iter$LT$T$GT$10make_slice17had370a4e92540ac0E"}
!40 = distinct !{!40, !41, !"_ZN4core5slice4iter13Iter$LT$T$GT$8as_slice17hb5b98c3d006221a2E: %self"}
!41 = distinct !{!41, !"_ZN4core5slice4iter13Iter$LT$T$GT$8as_slice17hb5b98c3d006221a2E"}
!42 = !{!43}
!43 = distinct !{!43, !44, !"_ZN69_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hcb1e9b2642a63d98E: %self"}
!44 = distinct !{!44, !"_ZN69_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hcb1e9b2642a63d98E"}
!45 = !{!46, !48, !43}
!46 = distinct !{!46, !47, !"_ZN4core5slice4iter13Iter$LT$T$GT$10make_slice17hcfbdc4fa7f763e89E: %self"}
!47 = distinct !{!47, !"_ZN4core5slice4iter13Iter$LT$T$GT$10make_slice17hcfbdc4fa7f763e89E"}
!48 = distinct !{!48, !49, !"_ZN4core5slice4iter13Iter$LT$T$GT$8as_slice17h68ef00e5d828448eE: %self"}
!49 = distinct !{!49, !"_ZN4core5slice4iter13Iter$LT$T$GT$8as_slice17h68ef00e5d828448eE"}
!50 = !{!51, !53, !55}
!51 = distinct !{!51, !52, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E: %self"}
!52 = distinct !{!52, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E"}
!53 = distinct !{!53, !54, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E: %self"}
!54 = distinct !{!54, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E"}
!55 = distinct !{!55, !56, !"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h201e74c9a9a42197E: %self"}
!56 = distinct !{!56, !"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h201e74c9a9a42197E"}
!57 = !{!53, !55}
!58 = !{!59, !55}
!59 = distinct !{!59, !60, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha6bc647d97a69d12E: %self.0"}
!60 = distinct !{!60, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha6bc647d97a69d12E"}
!61 = !{!55}
!62 = !{!63}
!63 = distinct !{!63, !64, !"_ZN83_$LT$rand..distributions..uniform..Uniform$LT$X$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17he2cb1c9b9b35970dE: %self"}
!64 = distinct !{!64, !"_ZN83_$LT$rand..distributions..uniform..Uniform$LT$X$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17he2cb1c9b9b35970dE"}
!65 = !{!66}
!66 = distinct !{!66, !67, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h33e1ff7d249818ecE: %self.0"}
!67 = distinct !{!67, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h33e1ff7d249818ecE"}
!68 = !{!69}
!69 = distinct !{!69, !70, !"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE: %self"}
!70 = distinct !{!70, !"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h53fc6197c54e613bE"}
!71 = !{!72}
!72 = distinct !{!72, !73, !"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hd033ec0476f2a15bE: %self"}
!73 = distinct !{!73, !"_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hd033ec0476f2a15bE"}
!74 = !{!75}
!75 = distinct !{!75, !76, !"_ZN86_$LT$rand..distributions..uniform..UniformInt$LT$X$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17he53e56cd3b657da0E: %self"}
!76 = distinct !{!76, !"_ZN86_$LT$rand..distributions..uniform..UniformInt$LT$X$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17he53e56cd3b657da0E"}
!77 = !{!78}
!78 = distinct !{!78, !79, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha6bc647d97a69d12E: %self.0"}
!79 = distinct !{!79, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17ha6bc647d97a69d12E"}
!80 = !{!81}
!81 = distinct !{!81, !82, !"_ZN86_$LT$rand..distributions..uniform..UniformInt$LT$X$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h1aeac9aabb781b29E: %self"}
!82 = distinct !{!82, !"_ZN86_$LT$rand..distributions..uniform..UniformInt$LT$X$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h1aeac9aabb781b29E"}
!83 = !{!84, !86, !88}
!84 = distinct !{!84, !85, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E: %self"}
!85 = distinct !{!85, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E"}
!86 = distinct !{!86, !87, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E: %self"}
!87 = distinct !{!87, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E"}
!88 = distinct !{!88, !89, !"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d606f9843fd6f65E: %self"}
!89 = distinct !{!89, !"_ZN61_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d606f9843fd6f65E"}
!90 = !{!86, !88}
!91 = !{!92, !88}
!92 = distinct !{!92, !93, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h33e1ff7d249818ecE: %self.0"}
!93 = distinct !{!93, !"_ZN48_$LT$$u5b$T$u5d$$u20$as$u20$core..fmt..Debug$GT$3fmt17h33e1ff7d249818ecE"}
!94 = !{!88}
!95 = !{!96}
!96 = distinct !{!96, !97, !"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E: %self"}
!97 = distinct !{!97, !"_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17h2b0660fe54bf7b67E"}
!98 = !{!99}
!99 = distinct !{!99, !100, !"_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E: argument 0"}
!100 = distinct !{!100, !"_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E"}
!101 = !{!102}
!102 = distinct !{!102, !103, !"_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E: argument 0"}
!103 = distinct !{!103, !"_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E"}
!104 = !{!105}
!105 = distinct !{!105, !106, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!106 = distinct !{!106, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!107 = !{!108, !109}
!108 = distinct !{!108, !106, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!109 = distinct !{!109, !106, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!110 = !{i8 0, i8 4}
!111 = !{!112}
!112 = distinct !{!112, !113, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!113 = distinct !{!113, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!114 = !{!115, !116}
!115 = distinct !{!115, !113, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!116 = distinct !{!116, !113, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
!117 = !{!118}
!118 = distinct !{!118, !119, !"_ZN9rand_core11SeedableRng8from_rng17hf1caf751403e8763E: argument 0"}
!119 = distinct !{!119, !"_ZN9rand_core11SeedableRng8from_rng17hf1caf751403e8763E"}
!120 = !{!121}
!121 = distinct !{!121, !122, !"_ZN4core5array76_$LT$impl$u20$core..default..Default$u20$for$u20$$u5b$T$u3b$$u20$32$u5d$$GT$7default17ha0af058987a24009E: argument 0"}
!122 = distinct !{!122, !"_ZN4core5array76_$LT$impl$u20$core..default..Default$u20$for$u20$$u5b$T$u3b$$u20$32$u5d$$GT$7default17ha0af058987a24009E"}
!123 = !{!124, !126, !118}
!124 = distinct !{!124, !125, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E: argument 0"}
!125 = distinct !{!125, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E"}
!126 = distinct !{!126, !125, !"_ZN76_$LT$rand_chacha..chacha..ChaCha12Core$u20$as$u20$rand_core..SeedableRng$GT$9from_seed17h0c64a55d88fc2908E: %seed"}
!127 = !{!126, !118}
!128 = !{!129, !131}
!129 = distinct !{!129, !130, !"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$6reseed28_$u7b$$u7b$closure$u7d$$u7d$17he6a56dee5b58251dE: %result"}
!130 = distinct !{!130, !"_ZN4rand4rngs7adapter9reseeding29ReseedingCore$LT$R$C$Rsdr$GT$6reseed28_$u7b$$u7b$closure$u7d$$u7d$17he6a56dee5b58251dE"}
!131 = distinct !{!131, !132, !"_ZN4core6result19Result$LT$T$C$E$GT$3map17h9c04e48bbb33cc2cE: %self"}
!132 = distinct !{!132, !"_ZN4core6result19Result$LT$T$C$E$GT$3map17h9c04e48bbb33cc2cE"}
!133 = !{!134}
!134 = distinct !{!134, !135, !"_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E: argument 0"}
!135 = distinct !{!135, !"_ZN5alloc5alloc8box_free17h4f26ef7504d9e544E"}
!136 = !{!137}
!137 = distinct !{!137, !138, !"_ZN4core6option15Option$LT$T$GT$6as_ref17h80b17a2e672e7659E: %self"}
!138 = distinct !{!138, !"_ZN4core6option15Option$LT$T$GT$6as_ref17h80b17a2e672e7659E"}
!139 = !{i64 0, i64 2}
!140 = !{!141, !143, !145, !147}
!141 = distinct !{!141, !142, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E: %self"}
!142 = distinct !{!142, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E"}
!143 = distinct !{!143, !144, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E: %self"}
!144 = distinct !{!144, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E"}
!145 = distinct !{!145, !146, !"_ZN77_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17hf953ec44a9e835fdE: %self"}
!146 = distinct !{!146, !"_ZN77_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17hf953ec44a9e835fdE"}
!147 = distinct !{!147, !148, !"_ZN97_$LT$alloc..vec..Vec$LT$A$GT$$u20$as$u20$core..cmp..PartialEq$LT$alloc..vec..Vec$LT$B$GT$$GT$$GT$2eq17h1065b20d4e665728E: %self"}
!148 = distinct !{!148, !"_ZN97_$LT$alloc..vec..Vec$LT$A$GT$$u20$as$u20$core..cmp..PartialEq$LT$alloc..vec..Vec$LT$B$GT$$GT$$GT$2eq17h1065b20d4e665728E"}
!149 = !{!150}
!150 = distinct !{!150, !148, !"_ZN97_$LT$alloc..vec..Vec$LT$A$GT$$u20$as$u20$core..cmp..PartialEq$LT$alloc..vec..Vec$LT$B$GT$$GT$$GT$2eq17h1065b20d4e665728E: %other"}
!151 = !{!143, !145, !147}
!152 = !{!153, !155, !157, !150}
!153 = distinct !{!153, !154, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E: %self"}
!154 = distinct !{!154, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E"}
!155 = distinct !{!155, !156, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E: %self"}
!156 = distinct !{!156, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E"}
!157 = distinct !{!157, !158, !"_ZN77_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17hf953ec44a9e835fdE: %self"}
!158 = distinct !{!158, !"_ZN77_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17hf953ec44a9e835fdE"}
!159 = !{!147}
!160 = !{!155, !157, !150}
!161 = !{!147, !150}
!162 = !{!163, !165, !167, !169}
!163 = distinct !{!163, !164, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E: %self"}
!164 = distinct !{!164, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E"}
!165 = distinct !{!165, !166, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E: %self"}
!166 = distinct !{!166, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E"}
!167 = distinct !{!167, !168, !"_ZN77_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17h4031bf48ebce9572E: %self"}
!168 = distinct !{!168, !"_ZN77_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17h4031bf48ebce9572E"}
!169 = distinct !{!169, !170, !"_ZN97_$LT$alloc..vec..Vec$LT$A$GT$$u20$as$u20$core..cmp..PartialEq$LT$alloc..vec..Vec$LT$B$GT$$GT$$GT$2eq17h32fb0ce2884d7816E: %self"}
!170 = distinct !{!170, !"_ZN97_$LT$alloc..vec..Vec$LT$A$GT$$u20$as$u20$core..cmp..PartialEq$LT$alloc..vec..Vec$LT$B$GT$$GT$$GT$2eq17h32fb0ce2884d7816E"}
!171 = !{!172}
!172 = distinct !{!172, !170, !"_ZN97_$LT$alloc..vec..Vec$LT$A$GT$$u20$as$u20$core..cmp..PartialEq$LT$alloc..vec..Vec$LT$B$GT$$GT$$GT$2eq17h32fb0ce2884d7816E: %other"}
!173 = !{!165, !167, !169}
!174 = !{!175, !177, !179, !172}
!175 = distinct !{!175, !176, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E: %self"}
!176 = distinct !{!176, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E"}
!177 = distinct !{!177, !178, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E: %self"}
!178 = distinct !{!178, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E"}
!179 = distinct !{!179, !180, !"_ZN77_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17h4031bf48ebce9572E: %self"}
!180 = distinct !{!180, !"_ZN77_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..index..Index$LT$I$GT$$GT$5index17h4031bf48ebce9572E"}
!181 = !{!169}
!182 = !{!177, !179, !172}
!183 = !{!169, !172}
!184 = !{!185, !187}
!185 = distinct !{!185, !186, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E: %self"}
!186 = distinct !{!186, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E"}
!187 = distinct !{!187, !188, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E: %self"}
!188 = distinct !{!188, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E"}
!189 = !{!190, !192}
!190 = distinct !{!190, !191, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E: %self"}
!191 = distinct !{!191, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E"}
!192 = distinct !{!192, !193, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E: %self"}
!193 = distinct !{!193, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E"}
!194 = !{!195, !197}
!195 = distinct !{!195, !196, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E: %self"}
!196 = distinct !{!196, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17hd068f8460bf3b120E"}
!197 = distinct !{!197, !198, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E: %self"}
!198 = distinct !{!198, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17he5ea00f639b318f7E"}
!199 = !{!200, !202}
!200 = distinct !{!200, !201, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E: %self"}
!201 = distinct !{!201, !"_ZN5alloc3vec12Vec$LT$T$GT$6as_ptr17h051a1a098c483c96E"}
!202 = distinct !{!202, !203, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E: %self"}
!203 = distinct !{!203, !"_ZN68_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h83a57d6def8a4b76E"}
!204 = !{i32 0, i32 3}
!205 = !{!206}
!206 = distinct !{!206, !207, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: argument 0"}
!207 = distinct !{!207, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E"}
!208 = !{!209, !210}
!209 = distinct !{!209, !207, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %pieces.0"}
!210 = distinct !{!210, !207, !"_ZN4core3fmt9Arguments6new_v117hef4f791f58ac5a37E: %args.0"}
