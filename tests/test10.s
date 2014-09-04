	.section	__TEXT,__text,regular,pure_instructions
	.globl	_swapValues
	.align	4, 0x90
_swapValues:                            ## @swapValues
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movslq	-8(%rbp), %rax
	movq	_A@GOTPCREL(%rip), %rcx
	movl	(%rcx,%rax,4), %eax
	movl	%eax, -12(%rbp)
	movslq	-4(%rbp), %rax
	movl	(%rcx,%rax,4), %eax
	movslq	-8(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	-12(%rbp), %eax
	movslq	-4(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_findIndex
	.align	4, 0x90
_findIndex:                             ## @findIndex
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp3:
	.cfi_def_cfa_offset 16
Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp5:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	$-1, -16(%rbp)
	movslq	-4(%rbp), %rcx
	movq	_A@GOTPCREL(%rip), %rax
	movl	(%rax,%rcx,4), %ecx
	movl	%ecx, -20(%rbp)
	movl	-4(%rbp), %ecx
	incl	%ecx
	movl	%ecx, -12(%rbp)
	jmp	LBB1_1
	.align	4, 0x90
LBB1_4:                                 ## %if.end
                                        ##   in Loop: Header=BB1_1 Depth=1
	incl	-12(%rbp)
LBB1_1:                                 ## %while.cond
                                        ## =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %ecx
	cmpl	-8(%rbp), %ecx
	jge	LBB1_5
## BB#2:                                ## %while.body
                                        ##   in Loop: Header=BB1_1 Depth=1
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	cmpl	-20(%rbp), %ecx
	jle	LBB1_4
## BB#3:                                ## %if.then
                                        ##   in Loop: Header=BB1_1 Depth=1
	movl	-12(%rbp), %ecx
	movl	%ecx, -16(%rbp)
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movl	%ecx, -20(%rbp)
	jmp	LBB1_4
LBB1_5:                                 ## %while.end
	movl	-16(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc

	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI2_0:
	.quad	4611686018427387904     ## double 2
LCPI2_1:
	.quad	4614256447914709615     ## double 3.1415000000000002
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:                                ## %entry
	pushq	%rbp
Ltmp6:
	.cfi_def_cfa_offset 16
Ltmp7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp8:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	movl	%edi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -24(%rbp)
	jmp	LBB2_1
	.align	4, 0x90
LBB2_4:                                 ## %if.end
                                        ##   in Loop: Header=BB2_1 Depth=1
	incl	-24(%rbp)
LBB2_1:                                 ## %while.cond
                                        ## =>This Inner Loop Header: Depth=1
	cmpl	$9, -24(%rbp)
	jg	LBB2_5
## BB#2:                                ## %while.body
                                        ##   in Loop: Header=BB2_1 Depth=1
	movl	-24(%rbp), %edi
	movl	$10, %esi
	callq	_findIndex
	movl	%eax, -28(%rbp)
	testl	%eax, %eax
	js	LBB2_4
## BB#3:                                ## %if.then
                                        ##   in Loop: Header=BB2_1 Depth=1
	movl	-24(%rbp), %edi
	movl	-28(%rbp), %esi
	callq	_swapValues
	jmp	LBB2_4
LBB2_5:                                 ## %while.end
	movl	$5, -24(%rbp)
	movl	$5, -28(%rbp)
	vcvtsi2sdl	-24(%rbp), %xmm0, %xmm0
	vdivsd	LCPI2_0(%rip), %xmm0, %xmm0
	vcvttsd2si	%xmm0, %eax
	movl	%eax, -20(%rbp)
	vcvtsi2sdl	-24(%rbp), %xmm0, %xmm0
	vmulsd	LCPI2_1(%rip), %xmm0, %xmm0
	movq	_d@GOTPCREL(%rip), %rax
	vmovsd	%xmm0, (%rax)
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.comm	_A,40,4                 ## @A
	.comm	_d,8,3                  ## @d
	.comm	_a,4,2                  ## @a
	.comm	_b,8,3                  ## @b
	.comm	_c,1,0                  ## @c

.subsections_via_symbols
