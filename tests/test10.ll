; ModuleID = 'test10.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9.0"

@A = common global [10 x i32] zeroinitializer, align 16
@d = common global double 0.000000e+00, align 8
@a = common global i32 0, align 4
@b = common global double 0.000000e+00, align 8
@c = common global i8 0, align 1

; Function Attrs: nounwind ssp uwtable
define void @swapValues(i32 %left, i32 %right) #0 {
entry:
  %left.addr = alloca i32, align 4
  %right.addr = alloca i32, align 4
  %tmp = alloca i32, align 4
  store i32 %left, i32* %left.addr, align 4
  store i32 %right, i32* %right.addr, align 4
  %0 = load i32* %right.addr, align 4
  %idxprom = sext i32 %0 to i64
  %arrayidx = getelementptr inbounds [10 x i32]* @A, i32 0, i64 %idxprom
  %1 = load i32* %arrayidx, align 4
  store i32 %1, i32* %tmp, align 4
  %2 = load i32* %left.addr, align 4
  %idxprom1 = sext i32 %2 to i64
  %arrayidx2 = getelementptr inbounds [10 x i32]* @A, i32 0, i64 %idxprom1
  %3 = load i32* %arrayidx2, align 4
  %4 = load i32* %right.addr, align 4
  %idxprom3 = sext i32 %4 to i64
  %arrayidx4 = getelementptr inbounds [10 x i32]* @A, i32 0, i64 %idxprom3
  store i32 %3, i32* %arrayidx4, align 4
  %5 = load i32* %tmp, align 4
  %6 = load i32* %left.addr, align 4
  %idxprom5 = sext i32 %6 to i64
  %arrayidx6 = getelementptr inbounds [10 x i32]* @A, i32 0, i64 %idxprom5
  store i32 %5, i32* %arrayidx6, align 4
  ret void
}

; Function Attrs: nounwind ssp uwtable
define i32 @findIndex(i32 %st, i32 %len) #0 {
entry:
  %st.addr = alloca i32, align 4
  %len.addr = alloca i32, align 4
  %j = alloca i32, align 4
  %res = alloca i32, align 4
  %max = alloca i32, align 4
  store i32 %st, i32* %st.addr, align 4
  store i32 %len, i32* %len.addr, align 4
  store i32 -1, i32* %res, align 4
  %0 = load i32* %st.addr, align 4
  %idxprom = sext i32 %0 to i64
  %arrayidx = getelementptr inbounds [10 x i32]* @A, i32 0, i64 %idxprom
  %1 = load i32* %arrayidx, align 4
  store i32 %1, i32* %max, align 4
  %2 = load i32* %st.addr, align 4
  %add = add nsw i32 %2, 1
  store i32 %add, i32* %j, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %3 = load i32* %j, align 4
  %4 = load i32* %len.addr, align 4
  %cmp = icmp slt i32 %3, %4
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %5 = load i32* %j, align 4
  %idxprom1 = sext i32 %5 to i64
  %arrayidx2 = getelementptr inbounds [10 x i32]* @A, i32 0, i64 %idxprom1
  %6 = load i32* %arrayidx2, align 4
  %7 = load i32* %max, align 4
  %cmp3 = icmp sgt i32 %6, %7
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %8 = load i32* %j, align 4
  store i32 %8, i32* %res, align 4
  %9 = load i32* %j, align 4
  %idxprom4 = sext i32 %9 to i64
  %arrayidx5 = getelementptr inbounds [10 x i32]* @A, i32 0, i64 %idxprom4
  %10 = load i32* %arrayidx5, align 4
  store i32 %10, i32* %max, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %11 = load i32* %j, align 4
  %add6 = add nsw i32 %11, 1
  store i32 %add6, i32* %j, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %12 = load i32* %res, align 4
  ret i32 %12
}

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %i = alloca i32, align 4
  %k = alloca i32, align 4
  %idx = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  store i32 0, i32* %i, align 4
  store i32 0, i32* %k, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %0 = load i32* %k, align 4
  %cmp = icmp slt i32 %0, 10
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %1 = load i32* %k, align 4
  %call = call i32 @findIndex(i32 %1, i32 10)
  store i32 %call, i32* %idx, align 4
  %2 = load i32* %idx, align 4
  %cmp1 = icmp sge i32 %2, 0
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %3 = load i32* %k, align 4
  %4 = load i32* %idx, align 4
  call void @swapValues(i32 %3, i32 %4)
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %5 = load i32* %k, align 4
  %add = add nsw i32 %5, 1
  store i32 %add, i32* %k, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i32 5, i32* %k, align 4
  store i32 5, i32* %idx, align 4
  %6 = load i32* %k, align 4
  %conv = sitofp i32 %6 to double
  %div = fdiv double %conv, 2.000000e+00
  %conv2 = fptosi double %div to i32
  store i32 %conv2, i32* %i, align 4
  %7 = load i32* %k, align 4
  %conv3 = sitofp i32 %7 to double
  %mul = fmul double %conv3, 3.141500e+00
  store double %mul, double* @d, align 8
  ret i32 0
}

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.5.0 (trunk 204019)"}
