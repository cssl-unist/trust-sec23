; ModuleID = 'collectionsbenches-949558e15ed0a833.585916b6sz5bq6h1.rcgu.bc'
source_filename = "585916b6sz5bq6h1"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: uwtable
define i8* @__rust_alloc(i64 %0, i64 %1) #0 {
entry:
  %2 = tail call i8* @__rdl_alloc(i64 %0, i64 %1)
  ret i8* %2
}

declare hidden i8* @__rdl_alloc(i64, i64)

; Function Attrs: uwtable
define void @__rust_dealloc(i8* %0, i64 %1, i64 %2) #0 {
entry:
  tail call void @__rdl_dealloc(i8* %0, i64 %1, i64 %2)
  ret void
}

declare hidden void @__rdl_dealloc(i8*, i64, i64)

; Function Attrs: uwtable
define i8* @__rust_realloc(i8* %0, i64 %1, i64 %2, i64 %3) #0 {
entry:
  %4 = tail call i8* @__rdl_realloc(i8* %0, i64 %1, i64 %2, i64 %3)
  ret i8* %4
}

declare hidden i8* @__rdl_realloc(i8*, i64, i64, i64)

; Function Attrs: uwtable
define i8* @__rust_alloc_zeroed(i64 %0, i64 %1) #0 {
entry:
  %2 = tail call i8* @__rdl_alloc_zeroed(i64 %0, i64 %1)
  ret i8* %2
}

declare hidden i8* @__rdl_alloc_zeroed(i64, i64)

; Function Attrs: noreturn uwtable
define void @__rust_alloc_error_handler(i64 %0, i64 %1) #1 {
entry:
  tail call void @__rg_oom(i64 %0, i64 %1)
  ret void
}

; Function Attrs: noreturn
declare hidden void @__rg_oom(i64, i64) #2

attributes #0 = { uwtable }
attributes #1 = { noreturn uwtable }
attributes #2 = { noreturn }

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{i32 2, !"RtLibUseGOT", i32 1}
