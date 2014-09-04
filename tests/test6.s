	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:                                ## %LX
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	movl	$0, -4(%rbp)
	movl	$1, -24(%rbp)
	movl	$10, -28(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	LBB0_1
## BB#5:                                ## %L4
	incl	-12(%rbp)
	movl	$0, -16(%rbp)
	movl	$1, %eax
	popq	%rbp
	retq
	.align	4, 0x90
LBB0_3:                                 ## %L1
                                        ##   in Loop: Header=BB0_1 Depth=1
	movl	%eax, -28(%rbp)
	incl	-8(%rbp)
LBB0_1:                                 ## %L1
                                        ## =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	incl	%eax
	movl	%eax, -20(%rbp)
	movl	%eax, -12(%rbp)
	cmpl	%eax, -28(%rbp)
	jne	LBB0_2
## BB#4:                                ## %L2
                                        ##   in Loop: Header=BB0_1 Depth=1
	movl	-16(%rbp), %eax
	decl	%eax
	jmp	LBB0_3
	.align	4, 0x90
LBB0_2:                                 ## %LY
                                        ##   in Loop: Header=BB0_1 Depth=1
	movl	-16(%rbp), %eax
	incl	%eax
	jmp	LBB0_3
	.cfi_endproc


.subsections_via_symbols
