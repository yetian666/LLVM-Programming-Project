; ModuleID = 'test6.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9.0"

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %b = alloca i32, align 4
  %x = alloca i32, align 4
  %t = alloca i32, align 4
  %p = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 1, i32* %p, align 4
  store i32 10, i32* %a, align 4
  br label %L0

L0:                                               ; preds = %entry
  store i32 0, i32* %i, align 4
  store i32 0, i32* %b, align 4
  %0 = load i32* %p, align 4
  store i32 %0, i32* %x, align 4
  br label %LX

LX:                                               ; preds = %L0
  %1 = load i32* %i, align 4
  %2 = load i32* %p, align 4
  %cmp = icmp slt i32 %1, %2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %LX
  br label %L1

if.end:                                           ; preds = %LX
  br label %L4

L4:                                               ; preds = %if.end
  %3 = load i32* %b, align 4
  %add = add nsw i32 %3, 1
  store i32 %add, i32* %b, align 4
  store i32 0, i32* %x, align 4
  ret i32 1

L1:                                               ; preds = %L3, %if.then
  %4 = load i32* %a, align 4
  %add1 = add nsw i32 %4, 1
  store i32 %add1, i32* %t, align 4
  %5 = load i32* %t, align 4
  store i32 %5, i32* %b, align 4
  %6 = load i32* %a, align 4
  %7 = load i32* %b, align 4
  %cmp2 = icmp eq i32 %6, %7
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %L1
  br label %L2

if.end4:                                          ; preds = %L1
  br label %LY

LY:                                               ; preds = %if.end4
  %8 = load i32* %x, align 4
  %add5 = add nsw i32 %8, 1
  store i32 %add5, i32* %a, align 4
  br label %L3

L2:                                               ; preds = %if.then3
  %9 = load i32* %x, align 4
  %sub = sub nsw i32 %9, 1
  store i32 %sub, i32* %a, align 4
  br label %L3

L3:                                               ; preds = %L2, %LY
  %10 = load i32* %i, align 4
  %add6 = add nsw i32 %10, 1
  store i32 %add6, i32* %i, align 4
  br label %L1
}

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.5.0 (trunk 204019)"}
