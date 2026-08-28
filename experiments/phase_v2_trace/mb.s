	.file	"microbench_iq3xxs.c"
	.text
	.p2align 4
	.type	run_arith_impl, @function
run_arith_impl:
.LFB7335:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$64, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	salq	$32, %rdx
	movl	%eax, %eax
	orq	%rax, %rdx
	movq	%rdx, %r8
	movl	8(%rdi), %edx
	testl	%edx, %edx
	jle	.L5
	movl	%edx, %r10d
	movl	$56, %edx
	movq	(%rdi), %rax
	vpcmpeqd	%ymm2, %ymm2, %ymm2
	vmovd	%edx, %xmm6
	imulq	$88, %r10, %r10
	movl	$4, %edx
	vmovd	%edx, %xmm4
	movl	$2, %edx
	vpxor	%xmm5, %xmm5, %xmm5
	vmovd	%edx, %xmm3
	vpsrld	$29, %ymm2, %ymm2
	vpbroadcastd	%xmm6, %ymm6
	addq	%rax, %r10
	vpbroadcastd	%xmm4, %ymm4
	vpbroadcastd	%xmm3, %ymm3
	leaq	signs64(%rip), %rdi
	.p2align 4
	.p2align 3
.L3:
	movl	64(%rax), %r9d
	movl	68(%rax), %esi
	addq	$88, %rax
	movl	-16(%rax), %ecx
	movl	-12(%rax), %edx
	movl	%r9d, %r11d
	shrl	$12, %r9d
	vmovdqu	-88(%rax), %ymm10
	vmovdqu	-56(%rax), %ymm8
	movl	%r9d, 4(%rsp)
	movl	%esi, %r9d
	shrl	$12, %esi
	andl	$4095, %r11d
	movl	%esi, 12(%rsp)
	movl	%ecx, %esi
	shrl	$12, %ecx
	andl	$4095, %r9d
	movl	%ecx, 20(%rsp)
	movl	%edx, %ecx
	andl	$4095, %esi
	shrl	$12, %edx
	andl	$4095, %ecx
	movl	%r11d, (%rsp)
	movl	%r9d, 8(%rsp)
	movl	%esi, 16(%rsp)
	movl	-8(%rax), %esi
	movl	%ecx, 24(%rsp)
	movl	-4(%rax), %ecx
	movl	%edx, 28(%rsp)
	vmovdqa	(%rsp), %ymm0
	movl	%esi, %r9d
	movl	%esi, %r11d
	shrl	$7, %r9d
	movl	%esi, %ebx
	shrl	$14, %r11d
	vpsrld	$9, %ymm0, %ymm9
	vpsrld	$6, %ymm0, %ymm7
	shrl	$21, %esi
	andl	$127, %ebx
	vpand	%ymm2, %ymm9, %ymm9
	vpand	%ymm2, %ymm7, %ymm7
	vpand	%ymm2, %ymm0, %ymm11
	andl	$127, %r9d
	vpslld	$3, %ymm9, %ymm1
	vpcmpeqd	%ymm2, %ymm9, %ymm9
	vpand	%ymm6, %ymm0, %ymm0
	andl	$127, %esi
	vpaddd	%ymm4, %ymm1, %ymm1
	andl	$127, %r11d
	vmovq	(%rdi,%rbx,8), %xmm14
	vpinsrq	$1, (%rdi,%r9,8), %xmm14, %xmm14
	vmovq	(%rdi,%r11,8), %xmm15
	movl	%ecx, %r9d
	vpinsrq	$1, (%rdi,%rsi,8), %xmm15, %xmm15
	movl	%ecx, %esi
	shrl	$7, %esi
	vpand	%ymm3, %ymm9, %ymm9
	movl	%ecx, %r11d
	shrl	$14, %r9d
	vpsubd	%ymm9, %ymm1, %ymm1
	vpslld	$3, %ymm7, %ymm9
	shrl	$21, %ecx
	andl	$127, %r11d
	vpcmpeqd	%ymm2, %ymm7, %ymm7
	vpaddd	%ymm4, %ymm9, %ymm9
	andl	$127, %esi
	andl	$127, %r9d
	vpslld	$24, %ymm1, %ymm1
	vinserti128	$0x1, %xmm15, %ymm14, %ymm14
	andl	$127, %ecx
	vmovq	(%rdi,%r9,8), %xmm15
	vpsignb	%ymm14, %ymm10, %ymm10
	vpinsrq	$1, (%rdi,%rcx,8), %xmm15, %xmm15
	vmovq	(%rdi,%r11,8), %xmm14
	vpand	%ymm3, %ymm7, %ymm7
	vpinsrq	$1, (%rdi,%rsi,8), %xmm14, %xmm14
	vpsubd	%ymm7, %ymm9, %ymm7
	vpaddd	%ymm4, %ymm0, %ymm9
	vpcmpeqd	%ymm6, %ymm0, %ymm0
	vpslld	$16, %ymm7, %ymm7
	vinserti128	$0x1, %xmm15, %ymm14, %ymm14
	vpor	%ymm7, %ymm1, %ymm1
	vpslld	$3, %ymm11, %ymm7
	vpsignb	%ymm14, %ymm8, %ymm8
	vpcmpeqd	%ymm2, %ymm11, %ymm11
	vpand	%ymm3, %ymm0, %ymm0
	vpaddd	%ymm4, %ymm7, %ymm7
	vpsubd	%ymm0, %ymm9, %ymm0
	vpslld	$8, %ymm0, %ymm0
	vpand	%ymm3, %ymm11, %ymm11
	vpsubd	%ymm11, %ymm7, %ymm7
	vpor	%ymm0, %ymm7, %ymm0
	vpor	%ymm0, %ymm1, %ymm1
	vpsrldq	$8, %xmm1, %xmm9
	vpextrd	$3, %xmm1, %edx
	vmovdqa	%xmm1, %xmm7
	vpsrldq	$4, %xmm1, %xmm13
	vextracti128	$0x1, %ymm1, %xmm1
	vpunpckldq	%xmm13, %xmm7, %xmm7
	vmovdqa	%xmm1, %xmm0
	vpextrd	$1, %xmm1, %r12d
	vpsrldq	$8, %xmm1, %xmm11
	vpsrldq	$12, %xmm1, %xmm1
	vpunpckldq	%xmm1, %xmm11, %xmm11
	vpinsrd	$1, %edx, %xmm9, %xmm1
	addl	$1, %edx
	vpinsrd	$1, %r12d, %xmm0, %xmm0
	vpinsrd	$1, %edx, %xmm9, %xmm9
	vpunpcklqdq	%xmm1, %xmm7, %xmm1
	vpunpcklqdq	%xmm11, %xmm0, %xmm0
	vpunpcklqdq	%xmm9, %xmm7, %xmm7
	vinserti128	$0x1, %xmm0, %ymm1, %ymm1
	vinserti128	$0x1, %xmm7, %ymm0, %ymm0
	vpmaddubsw	%ymm10, %ymm1, %ymm1
	vpmaddubsw	%ymm8, %ymm0, %ymm0
	vpmaddwd	%ymm1, %ymm1, %ymm1
	vpmaddwd	%ymm0, %ymm0, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vextracti128	$0x1, %ymm0, %xmm1
	vpaddd	%xmm0, %xmm1, %xmm0
	vpsrldq	$8, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vpsrldq	$4, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vpaddd	%xmm0, %xmm5, %xmm5
	cmpq	%r10, %rax
	jne	.L3
	vzeroupper
.L2:
	vmovd	%xmm5, result_sink(%rip)
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	movl	%eax, %eax
	salq	$32, %rdx
	orq	%rax, %rdx
	movq	%rdx, %rax
	subq	%r8, %rax
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L9
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L5:
	.cfi_restore_state
	vpxor	%xmm5, %xmm5, %xmm5
	jmp	.L2
.L9:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE7335:
	.size	run_arith_impl, .-run_arith_impl
	.p2align 4
	.type	wrap_arith, @function
wrap_arith:
.LFB7340:
	.cfi_startproc
	jmp	run_arith_impl
	.cfi_endproc
.LFE7340:
	.size	wrap_arith, .-wrap_arith
	.p2align 4
	.type	run_table_impl, @function
run_table_impl:
.LFB7334:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rcx
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	salq	$32, %rdx
	movl	%eax, %eax
	movq	%rdx, %rdi
	movl	8(%rcx), %edx
	orq	%rax, %rdi
	testl	%edx, %edx
	jle	.L14
	movl	%edx, %r9d
	movq	(%rcx), %rax
	movq	%rbx, -32(%rbp)
	vpxor	%xmm2, %xmm2, %xmm2
	imulq	$88, %r9, %r9
	movq	%r12, -24(%rbp)
	leaq	signs64(%rip), %r8
	movq	%r13, -16(%rbp)
	leaq	table256(%rip), %rdx
	movq	%r14, -8(%rbp)
	.cfi_offset 3, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	addq	%rax, %r9
	.p2align 4
	.p2align 3
.L13:
	movl	80(%rax), %esi
	movl	84(%rax), %ecx
	addq	$88, %rax
	vmovdqu	-88(%rax), %ymm3
	movzbl	-18(%rax), %r14d
	movl	%esi, %r10d
	movl	%esi, %r11d
	movl	%esi, %ebx
	shrl	$21, %esi
	shrl	$7, %r10d
	shrl	$14, %r11d
	andl	$127, %ebx
	andl	$127, %esi
	andl	$127, %r10d
	andl	$127, %r11d
	vmovq	(%r8,%rbx,8), %xmm0
	movzbl	-17(%rax), %r13d
	vmovq	(%r8,%r11,8), %xmm1
	vpinsrq	$1, (%r8,%r10,8), %xmm0, %xmm0
	movl	%ecx, %r10d
	movl	%ecx, %r11d
	vpinsrq	$1, (%r8,%rsi,8), %xmm1, %xmm1
	movl	%ecx, %esi
	shrl	$14, %r10d
	andl	$127, %r11d
	shrl	$7, %esi
	shrl	$21, %ecx
	andl	$127, %r10d
	movzbl	-19(%rax), %ebx
	andl	$127, %esi
	andl	$127, %ecx
	vmovdqu	-56(%rax), %ymm4
	movzbl	-20(%rax), %r12d
	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
	vmovq	(%r8,%r10,8), %xmm1
	vpinsrq	$1, (%r8,%rcx,8), %xmm1, %xmm1
	vpsignb	%ymm0, %ymm3, %ymm3
	vmovq	(%r8,%r11,8), %xmm0
	movzbl	-23(%rax), %ecx
	vpinsrq	$1, (%r8,%rsi,8), %xmm0, %xmm0
	movzbl	-22(%rax), %r11d
	movzbl	-24(%rax), %esi
	movzbl	-21(%rax), %r10d
	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
	vmovd	(%rdx,%r14,4), %xmm1
	vpinsrd	$1, (%rdx,%r13,4), %xmm1, %xmm1
	vpsignb	%ymm0, %ymm4, %ymm4
	vmovd	(%rdx,%r12,4), %xmm0
	vpinsrd	$1, (%rdx,%rbx,4), %xmm0, %xmm0
	vmovd	(%rdx,%r11,4), %xmm5
	vpinsrd	$1, (%rdx,%r10,4), %xmm5, %xmm5
	vpunpcklqdq	%xmm1, %xmm0, %xmm0
	vmovd	(%rdx,%rsi,4), %xmm1
	vpinsrd	$1, (%rdx,%rcx,4), %xmm1, %xmm1
	movzbl	-16(%rax), %esi
	movzbl	-15(%rax), %ecx
	movzbl	-14(%rax), %r11d
	movzbl	-13(%rax), %r10d
	vpunpcklqdq	%xmm5, %xmm1, %xmm1
	movzbl	-12(%rax), %r12d
	movzbl	-11(%rax), %ebx
	vinserti128	$0x1, %xmm0, %ymm1, %ymm1
	movzbl	-10(%rax), %r14d
	movzbl	-9(%rax), %r13d
	vpmaddubsw	%ymm3, %ymm1, %ymm1
	vmovd	(%rdx,%r12,4), %xmm3
	vmovd	(%rdx,%r11,4), %xmm5
	vpmaddwd	%ymm1, %ymm1, %ymm1
	vmovd	(%rdx,%r14,4), %xmm0
	vpinsrd	$1, (%rdx,%rbx,4), %xmm3, %xmm3
	vpinsrd	$1, (%rdx,%r13,4), %xmm0, %xmm0
	vpinsrd	$1, (%rdx,%r10,4), %xmm5, %xmm5
	vpunpcklqdq	%xmm0, %xmm3, %xmm3
	vmovd	(%rdx,%rsi,4), %xmm0
	vpinsrd	$1, (%rdx,%rcx,4), %xmm0, %xmm0
	vpunpcklqdq	%xmm5, %xmm0, %xmm0
	vinserti128	$0x1, %xmm3, %ymm0, %ymm0
	vpmaddubsw	%ymm4, %ymm0, %ymm0
	vpmaddwd	%ymm0, %ymm0, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpshufd	$85, %xmm0, %xmm4
	vpshufd	$255, %xmm0, %xmm3
	vpaddd	%xmm4, %xmm0, %xmm1
	vpshufd	$170, %xmm0, %xmm4
	vextracti128	$0x1, %ymm0, %xmm0
	vpaddd	%xmm4, %xmm1, %xmm1
	vpaddd	%xmm3, %xmm1, %xmm1
	vpshufd	$85, %xmm0, %xmm3
	vpaddd	%xmm0, %xmm1, %xmm1
	vpaddd	%xmm3, %xmm1, %xmm1
	vpshufd	$170, %xmm0, %xmm3
	vpshufd	$255, %xmm0, %xmm0
	vpaddd	%xmm3, %xmm1, %xmm1
	vpaddd	%xmm0, %xmm1, %xmm0
	vpaddd	%xmm0, %xmm2, %xmm2
	cmpq	%rax, %r9
	jne	.L13
	vzeroupper
	movq	-32(%rbp), %rbx
	.cfi_restore 3
	movq	-24(%rbp), %r12
	.cfi_restore 12
	movq	-16(%rbp), %r13
	.cfi_restore 13
	movq	-8(%rbp), %r14
	.cfi_restore 14
.L12:
	vmovd	%xmm2, result_sink(%rip)
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	movl	%eax, %eax
	salq	$32, %rdx
	orq	%rax, %rdx
	movq	%rdx, %rax
	subq	%rdi, %rax
	ret
.L14:
	.cfi_restore_state
	vpxor	%xmm2, %xmm2, %xmm2
	jmp	.L12
	.cfi_endproc
.LFE7334:
	.size	run_table_impl, .-run_table_impl
	.p2align 4
	.type	wrap_table, @function
wrap_table:
.LFB7339:
	.cfi_startproc
	jmp	run_table_impl
	.cfi_endproc
.LFE7339:
	.size	wrap_table, .-wrap_table
	.p2align 4
	.type	bench.constprop.3, @function
bench.constprop.3:
.LFB7349:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$256, %rsp
	.cfi_def_cfa_offset 288
	movq	%fs:40, %r12
	movq	%r12, 248(%rsp)
	movq	%rdi, %r12
	leaq	248(%rsp), %rbx
	movq	%rsp, %rbp
	.p2align 4
	.p2align 3
.L19:
	movq	%r12, %rdi
	addq	$8, %rbp
	call	run_arith_impl
	movq	%rax, -8(%rbp)
	cmpq	%rbx, %rbp
	jne	.L19
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	.p2align 4
	.p2align 3
.L22:
	movq	%rsi, %rax
	.p2align 5
	.p2align 4
	.p2align 3
.L21:
	movq	(%rax), %rcx
	movq	(%rsi), %rdx
	cmpq	%rdx, %rcx
	jnb	.L20
	movq	%rcx, (%rsi)
	movq	%rdx, (%rax)
.L20:
	addq	$8, %rax
	cmpq	%rax, %rbx
	jne	.L21
	addq	$1, %rdi
	addq	$8, %rsi
	cmpq	$31, %rdi
	jne	.L22
	movq	120(%rsp), %rax
	movq	248(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L28
	addq	$256, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L28:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE7349:
	.size	bench.constprop.3, .-bench.constprop.3
	.p2align 4
	.type	bench.constprop.4, @function
bench.constprop.4:
.LFB7350:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$256, %rsp
	.cfi_def_cfa_offset 288
	movq	%fs:40, %r12
	movq	%r12, 248(%rsp)
	movq	%rdi, %r12
	leaq	248(%rsp), %rbx
	movq	%rsp, %rbp
	.p2align 4
	.p2align 3
.L30:
	movq	%r12, %rdi
	addq	$8, %rbp
	call	run_table_impl
	movq	%rax, -8(%rbp)
	cmpq	%rbx, %rbp
	jne	.L30
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	.p2align 4
	.p2align 3
.L33:
	movq	%rsi, %rax
	.p2align 5
	.p2align 4
	.p2align 3
.L32:
	movq	(%rax), %rcx
	movq	(%rsi), %rdx
	cmpq	%rdx, %rcx
	jnb	.L31
	movq	%rcx, (%rsi)
	movq	%rdx, (%rax)
.L31:
	addq	$8, %rax
	cmpq	%rax, %rbx
	jne	.L32
	addq	$1, %rdi
	addq	$8, %rsi
	cmpq	$31, %rdi
	jne	.L33
	movq	120(%rsp), %rax
	movq	248(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L39
	addq	$256, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L39:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE7350:
	.size	bench.constprop.4, .-bench.constprop.4
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC9:
	.string	"table buffer 44 KB (L1/L2 boundary):"
	.align 8
.LC11:
	.string	"  table path : %7.1f cyc / 64 elems\n"
	.align 8
.LC12:
	.string	"  arith path : %7.1f cyc / 64 elems\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC13:
	.string	"table buffer 358 KB (L2):"
.LC15:
	.string	"micro-ops:"
	.section	.rodata.str1.8
	.align 8
.LC17:
	.string	"  16 gathers  : %7.1f cyc / 16 loads (%.2f cyc/load)\n"
	.align 8
.LC19:
	.string	"  16 ALU ops  : %7.1f cyc / 16 ops  (%.2f cyc/op)\n"
	.align 8
.LC21:
	.string	"  L1 load 32B : %7.2f cyc / load\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB7345:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	leaq	table256(%rip), %r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	leaq	1024(%r15), %r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	leaq	bytevals.0(%rip), %rbx
	subq	$224, %rsp
	movq	%fs:40, %rdi
	movq	%rdi, -56(%rbp)
	movl	$12345, %edi
	call	srand@PLT
	.p2align 4
	.p2align 3
.L41:
	xorl	%r13d, %r13d
	xorl	%r14d, %r14d
.L42:
	call	rand@PLT
	movl	%r13d, %ecx
	addl	$8, %r13d
	cltd
	shrl	$29, %edx
	addl	%edx, %eax
	andl	$7, %eax
	subl	%edx, %eax
	cltq
	movl	(%rbx,%rax,4), %eax
	sall	%cl, %eax
	orl	%eax, %r14d
	cmpl	$32, %r13d
	jne	.L42
	movl	%r14d, (%r15)
	addq	$4, %r15
	cmpq	%r12, %r15
	jne	.L41
	movl	$8, %ecx
	vpcmpeqd	%ymm4, %ymm4, %ymm4
	leaq	signs64(%rip), %rax
	vmovdqa	.LC4(%rip), %ymm2
	vmovd	%ecx, %xmm5
	vpsrld	$31, %ymm4, %ymm3
	leaq	1024(%rax), %rdx
	vpsrld	$24, %ymm4, %ymm4
	vpbroadcastd	%xmm5, %ymm5
.L44:
	vpand	%ymm3, %ymm2, %ymm0
	vpsrad	$1, %ymm2, %ymm6
	addq	$64, %rax
	vpslld	$8, %ymm0, %ymm12
	vpsrad	$2, %ymm2, %ymm13
	vpsrad	$4, %ymm2, %ymm15
	vpsrad	$5, %ymm2, %ymm14
	vpsubd	%ymm0, %ymm12, %ymm12
	vpand	%ymm3, %ymm6, %ymm0
	vpxor	%ymm13, %ymm6, %ymm6
	vpslld	$8, %ymm0, %ymm1
	vpxor	%ymm2, %ymm6, %ymm6
	vpsubd	%ymm0, %ymm1, %ymm1
	vpand	%ymm3, %ymm13, %ymm0
	vpmovzxdq	%xmm12, %ymm13
	vpslld	$8, %ymm1, %ymm9
	vpslld	$8, %ymm0, %ymm8
	vpsrad	$3, %ymm2, %ymm1
	vpsubd	%ymm0, %ymm8, %ymm8
	vpand	%ymm3, %ymm1, %ymm0
	vpslld	$16, %ymm8, %ymm8
	vpxor	%ymm15, %ymm1, %ymm1
	vpslld	$8, %ymm0, %ymm11
	vpsubd	%ymm0, %ymm11, %ymm11
	vpand	%ymm3, %ymm15, %ymm0
	vpslld	$8, %ymm0, %ymm7
	vpslld	$24, %ymm11, %ymm11
	vpsubd	%ymm0, %ymm7, %ymm7
	vpand	%ymm3, %ymm14, %ymm0
	vpslld	$8, %ymm0, %ymm10
	vpsubd	%ymm0, %ymm10, %ymm10
	vpsrad	$6, %ymm2, %ymm0
	vpaddd	%ymm5, %ymm2, %ymm2
	vpxor	%ymm0, %ymm14, %ymm14
	vpermq	$216, %ymm0, %ymm0
	vpxor	%ymm14, %ymm1, %ymm1
	vpmovzxdq	%xmm8, %ymm14
	vextracti128	$0x1, %ymm8, %xmm8
	vpxor	%ymm6, %ymm1, %ymm1
	vpmovzxdq	%xmm8, %ymm8
	vpand	%ymm3, %ymm1, %ymm1
	vpslld	$8, %ymm1, %ymm6
	vpsubd	%ymm1, %ymm6, %ymm6
	vpshufd	$80, %ymm0, %ymm1
	vpshufd	$250, %ymm0, %ymm0
	vpmuldq	%ymm4, %ymm1, %ymm1
	vpmuldq	%ymm4, %ymm0, %ymm0
	vpsllq	$48, %ymm1, %ymm1
	vpsllq	$48, %ymm0, %ymm0
	vpor	%ymm13, %ymm1, %ymm1
	vpmovzxdq	%xmm11, %ymm13
	vpor	%ymm13, %ymm1, %ymm1
	vpmovzxdq	%xmm10, %ymm13
	vpsllq	$40, %ymm13, %ymm13
	vpor	%ymm13, %ymm1, %ymm1
	vpmovzxdq	%xmm9, %ymm13
	vpor	%ymm14, %ymm13, %ymm13
	vpmovzxdq	%xmm7, %ymm14
	vextracti128	$0x1, %ymm7, %xmm7
	vpsllq	$32, %ymm14, %ymm14
	vpmovzxdq	%xmm7, %ymm7
	vpor	%ymm14, %ymm13, %ymm13
	vpsllq	$32, %ymm7, %ymm7
	vpmovzxdq	%xmm6, %ymm14
	vpsllq	$56, %ymm14, %ymm14
	vextracti128	$0x1, %ymm6, %xmm6
	vpor	%ymm14, %ymm13, %ymm13
	vpmovzxdq	%xmm6, %ymm6
	vpor	%ymm13, %ymm1, %ymm1
	vpsllq	$56, %ymm6, %ymm6
	vmovdqa	%ymm1, -64(%rax)
	vextracti128	$0x1, %ymm12, %xmm1
	vpmovzxdq	%xmm1, %ymm1
	vpor	%ymm1, %ymm0, %ymm0
	vextracti128	$0x1, %ymm11, %xmm1
	vpmovzxdq	%xmm1, %ymm1
	vpor	%ymm1, %ymm0, %ymm0
	vextracti128	$0x1, %ymm10, %xmm1
	vpmovzxdq	%xmm1, %ymm1
	vpsllq	$40, %ymm1, %ymm1
	vpor	%ymm1, %ymm0, %ymm0
	vextracti128	$0x1, %ymm9, %xmm1
	vpmovzxdq	%xmm1, %ymm1
	vpor	%ymm8, %ymm1, %ymm1
	vpor	%ymm7, %ymm1, %ymm1
	vpor	%ymm6, %ymm1, %ymm1
	vpor	%ymm1, %ymm0, %ymm0
	vmovdqa	%ymm0, -32(%rax)
	cmpq	%rdx, %rax
	jne	.L44
	movl	$45056, %esi
	movl	$64, %edi
	vzeroupper
	call	aligned_alloc@PLT
	movl	$360448, %esi
	movl	$64, %edi
	movq	%rax, %r14
	call	aligned_alloc@PLT
	movl	$45056, %esi
	movl	$64, %edi
	leaq	80(%r14), %r12
	movq	%rax, -184(%rbp)
	call	aligned_alloc@PLT
	movl	$360448, %esi
	movl	$64, %edi
	movq	%rax, %rbx
	movq	%rax, -200(%rbp)
	call	aligned_alloc@PLT
	movq	%r14, -144(%rbp)
	leaq	64(%rbx), %r15
	leaq	80(%rbx), %r13
	movq	%rax, -192(%rbp)
	leaq	45120(%rbx), %rax
	movq	%rax, -168(%rbp)
	movl	$0, -176(%rbp)
	movq	%r14, -208(%rbp)
	movq	%rbx, -152(%rbp)
	leaq	64(%r14), %rbx
	.p2align 4
	.p2align 3
.L51:
	movq	-144(%rbp), %r14
	.p2align 4
	.p2align 3
.L45:
	call	rand@PLT
	addq	$1, %r14
	movb	%al, -1(%r14)
	cmpq	%rbx, %r14
	jne	.L45
	movq	%rbx, %r14
	.p2align 4
	.p2align 3
.L46:
	call	rand@PLT
	addq	$1, %r14
	cltd
	shrl	$24, %edx
	addl	%edx, %eax
	movzbl	%al, %eax
	subl	%edx, %eax
	movb	%al, -1(%r14)
	cmpq	%r12, %r14
	jne	.L46
	movq	%rbx, -160(%rbp)
	leaq	24(%rbx), %r14
	movq	%r12, %rbx
	.p2align 4
	.p2align 3
.L47:
	call	rand@PLT
	addq	$1, %rbx
	movb	%al, -1(%rbx)
	cmpq	%r14, %rbx
	jne	.L47
	movq	-144(%rbp), %rdi
	movq	-152(%rbp), %rax
	movq	-160(%rbp), %rbx
	vmovdqu	(%rdi), %ymm0
	movq	%rax, %r14
	vmovdqu	%ymm0, (%rax)
	vmovdqu	32(%rdi), %ymm0
	vmovdqu	%ymm0, 32(%rax)
	vmovdqu	56(%rdi), %ymm0
	vmovdqu	%ymm0, 56(%rax)
	vzeroupper
	.p2align 4
	.p2align 3
.L48:
	call	rand@PLT
	addq	$1, %r14
	movb	%al, -1(%r14)
	cmpq	%r15, %r14
	jne	.L48
	movq	%r15, %r14
	.p2align 4
	.p2align 3
.L49:
	call	rand@PLT
	addq	$1, %r14
	cltd
	shrl	$24, %edx
	addl	%edx, %eax
	movzbl	%al, %eax
	subl	%edx, %eax
	movb	%al, -1(%r14)
	cmpq	%r13, %r14
	jne	.L49
	movq	%rbx, -160(%rbp)
	leaq	24(%r15), %r14
	movq	%r13, %rbx
	.p2align 4
	.p2align 3
.L50:
	call	rand@PLT
	addq	$1, %rbx
	movb	%al, -1(%rbx)
	cmpq	%r14, %rbx
	jne	.L50
	movzbl	24(%r15), %eax
	movzbl	16(%r15), %ecx
	vmovd	-176(%rbp), %xmm12
	movq	-160(%rbp), %rbx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	8(%r15), %ecx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	(%r15), %ecx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	17(%r15), %ecx
	vmovd	%eax, %xmm2
	movzbl	25(%r15), %eax
	vpcmpgtb	%xmm2, %xmm12, %xmm5
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	9(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm5, %xmm5
	orl	%ecx, %eax
	movzbl	1(%r15), %ecx
	vpsrlw	$5, %xmm5, %xmm5
	vpshufb	.LC8(%rip), %xmm5, %xmm5
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	18(%r15), %ecx
	vmovd	%eax, %xmm7
	movzbl	26(%r15), %eax
	vpcmpgtb	%xmm7, %xmm12, %xmm9
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	10(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm9, %xmm9
	orl	%ecx, %eax
	movzbl	2(%r15), %ecx
	vpsrlw	$5, %xmm9, %xmm9
	vpshufb	.LC8(%rip), %xmm9, %xmm9
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	19(%r15), %ecx
	vmovd	%eax, %xmm8
	movzbl	27(%r15), %eax
	vpcmpgtb	%xmm8, %xmm12, %xmm10
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	11(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm10, %xmm10
	orl	%ecx, %eax
	movzbl	3(%r15), %ecx
	vpsrlw	$5, %xmm10, %xmm10
	vpshufb	.LC8(%rip), %xmm10, %xmm10
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	20(%r15), %ecx
	vmovd	%eax, %xmm3
	movzbl	28(%r15), %eax
	vpcmpgtb	%xmm3, %xmm12, %xmm6
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	12(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm6, %xmm6
	orl	%ecx, %eax
	movzbl	4(%r15), %ecx
	vpsrlw	$5, %xmm6, %xmm6
	vpshufb	.LC8(%rip), %xmm6, %xmm6
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	21(%r15), %ecx
	vmovd	%eax, %xmm4
	movzbl	29(%r15), %eax
	vpcmpgtb	%xmm4, %xmm12, %xmm11
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	13(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm11, %xmm11
	addq	$88, %r15
	addq	$88, %r13
	orl	%ecx, %eax
	movzbl	-83(%r15), %ecx
	vpsrlw	$5, %xmm11, %xmm11
	addq	$88, %r12
	vpshufb	.LC8(%rip), %xmm11, %xmm11
	sall	$8, %eax
	addq	$88, %rbx
	orl	%ecx, %eax
	vpaddb	%xmm11, %xmm4, %xmm4
	vmovd	%eax, %xmm0
	vpcmpgtb	%xmm0, %xmm12, %xmm15
	vpmovzxbw	%xmm15, %xmm15
	vpsrlw	$5, %xmm15, %xmm15
	vpshufb	.LC8(%rip), %xmm15, %xmm15
	movzbl	-58(%r15), %eax
	movzbl	-66(%r15), %ecx
	vpaddb	%xmm15, %xmm0, %xmm0
	addq	$88, -152(%rbp)
	sall	$8, %eax
	addq	$88, -144(%rbp)
	orl	%ecx, %eax
	movzbl	-74(%r15), %ecx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	-82(%r15), %ecx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	-65(%r15), %ecx
	vmovd	%eax, %xmm1
	movzbl	-57(%r15), %eax
	vpcmpgtb	%xmm1, %xmm12, %xmm13
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	-73(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm13, %xmm13
	orl	%ecx, %eax
	movzbl	-81(%r15), %ecx
	vpsrlw	$5, %xmm13, %xmm13
	vpshufb	.LC8(%rip), %xmm13, %xmm13
	sall	$8, %eax
	orl	%ecx, %eax
	vpaddb	%xmm13, %xmm1, %xmm1
	vmovd	%eax, %xmm14
	vpcmpgtb	%xmm14, %xmm12, %xmm12
	vmovd	.LC22(%rip), %xmm14
	vpand	%xmm14, %xmm1, %xmm14
	vmovd	.LC22(%rip), %xmm1
	vpmovzxbw	%xmm12, %xmm12
	vpsubb	%xmm13, %xmm14, %xmm14
	vpsrlw	$5, %xmm12, %xmm12
	vpand	%xmm1, %xmm0, %xmm13
	vmovd	%eax, %xmm1
	vpshufb	.LC8(%rip), %xmm12, %xmm12
	vpsubb	%xmm15, %xmm13, %xmm13
	vmovd	.LC22(%rip), %xmm15
	vpaddb	%xmm12, %xmm1, %xmm1
	vpmovsxbd	%xmm14, %xmm14
	vpand	%xmm15, %xmm4, %xmm4
	vpslld	$6, %xmm14, %xmm14
	vpsubb	%xmm11, %xmm4, %xmm4
	vpmovsxbd	%xmm13, %xmm13
	vpand	%xmm15, %xmm1, %xmm1
	vpslld	$3, %xmm13, %xmm13
	vpsubb	%xmm12, %xmm1, %xmm1
	vpor	%xmm13, %xmm14, %xmm0
	vpmovsxbd	%xmm4, %xmm4
	vpmovsxbd	%xmm1, %xmm1
	vpslld	$9, %xmm1, %xmm1
	vpor	%xmm4, %xmm1, %xmm1
	vpor	%xmm1, %xmm0, %xmm0
	vpaddb	%xmm9, %xmm7, %xmm1
	vpslld	$12, %xmm0, %xmm4
	vpaddb	%xmm10, %xmm8, %xmm0
	vpand	%xmm15, %xmm1, %xmm1
	vpand	%xmm15, %xmm0, %xmm0
	vpsubb	%xmm9, %xmm1, %xmm1
	vpsubb	%xmm10, %xmm0, %xmm0
	vpmovsxbd	%xmm1, %xmm1
	vpmovsxbd	%xmm0, %xmm0
	vpslld	$3, %xmm1, %xmm1
	vpslld	$6, %xmm0, %xmm0
	vpor	%xmm1, %xmm0, %xmm0
	vpaddb	%xmm5, %xmm2, %xmm1
	vpor	%xmm0, %xmm4, %xmm4
	vpaddb	%xmm6, %xmm3, %xmm0
	vpand	%xmm15, %xmm1, %xmm1
	vpand	%xmm15, %xmm0, %xmm0
	vpsubb	%xmm5, %xmm1, %xmm1
	vpsubb	%xmm6, %xmm0, %xmm0
	vpmovsxbd	%xmm1, %xmm1
	vpmovsxbd	%xmm0, %xmm0
	vpslld	$9, %xmm0, %xmm0
	vpor	%xmm1, %xmm0, %xmm0
	vpor	%xmm0, %xmm4, %xmm0
	vmovdqu	%xmm0, -88(%r15)
	cmpq	-168(%rbp), %r15
	jne	.L51
	movq	-192(%rbp), %rax
	movq	-184(%rbp), %rdi
	movl	$0, -176(%rbp)
	movq	%rax, -152(%rbp)
	leaq	64(%rax), %r15
	leaq	80(%rax), %r13
	addq	$360512, %rax
	movq	%rdi, -144(%rbp)
	leaq	80(%rdi), %r12
	leaq	64(%rdi), %rbx
	movq	%rax, -168(%rbp)
	.p2align 4
	.p2align 3
.L58:
	movq	-144(%rbp), %r14
	.p2align 4
	.p2align 3
.L52:
	call	rand@PLT
	addq	$1, %r14
	movb	%al, -1(%r14)
	cmpq	%rbx, %r14
	jne	.L52
	movq	%rbx, %r14
	.p2align 4
	.p2align 3
.L53:
	call	rand@PLT
	addq	$1, %r14
	cltd
	shrl	$24, %edx
	addl	%edx, %eax
	movzbl	%al, %eax
	subl	%edx, %eax
	movb	%al, -1(%r14)
	cmpq	%r12, %r14
	jne	.L53
	movq	%rbx, -160(%rbp)
	leaq	24(%rbx), %r14
	movq	%r12, %rbx
	.p2align 4
	.p2align 3
.L54:
	call	rand@PLT
	addq	$1, %rbx
	movb	%al, -1(%rbx)
	cmpq	%r14, %rbx
	jne	.L54
	movq	-144(%rbp), %rsi
	movq	-152(%rbp), %rax
	movq	-160(%rbp), %rbx
	vmovdqu	(%rsi), %ymm0
	movq	%rax, %r14
	vmovdqu	%ymm0, (%rax)
	vmovdqu	32(%rsi), %ymm0
	vmovdqu	%ymm0, 32(%rax)
	vmovdqu	56(%rsi), %ymm0
	vmovdqu	%ymm0, 56(%rax)
	vzeroupper
	.p2align 4
	.p2align 3
.L55:
	call	rand@PLT
	addq	$1, %r14
	movb	%al, -1(%r14)
	cmpq	%r15, %r14
	jne	.L55
	movq	%r15, %r14
	.p2align 4
	.p2align 3
.L56:
	call	rand@PLT
	addq	$1, %r14
	cltd
	shrl	$24, %edx
	addl	%edx, %eax
	movzbl	%al, %eax
	subl	%edx, %eax
	movb	%al, -1(%r14)
	cmpq	%r13, %r14
	jne	.L56
	movq	%rbx, -160(%rbp)
	leaq	24(%r15), %r14
	movq	%r13, %rbx
	.p2align 4
	.p2align 3
.L57:
	call	rand@PLT
	addq	$1, %rbx
	movb	%al, -1(%rbx)
	cmpq	%r14, %rbx
	jne	.L57
	movzbl	24(%r15), %eax
	movzbl	16(%r15), %ecx
	vmovd	-176(%rbp), %xmm14
	movq	-160(%rbp), %rbx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	8(%r15), %ecx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	(%r15), %ecx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	17(%r15), %ecx
	vmovd	%eax, %xmm2
	movzbl	25(%r15), %eax
	vpcmpgtb	%xmm2, %xmm14, %xmm5
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	9(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm5, %xmm5
	orl	%ecx, %eax
	movzbl	1(%r15), %ecx
	vpsrlw	$5, %xmm5, %xmm5
	vpshufb	.LC8(%rip), %xmm5, %xmm5
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	18(%r15), %ecx
	vmovd	%eax, %xmm8
	movzbl	26(%r15), %eax
	vpcmpgtb	%xmm8, %xmm14, %xmm10
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	10(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm10, %xmm10
	orl	%ecx, %eax
	movzbl	2(%r15), %ecx
	vpsrlw	$5, %xmm10, %xmm10
	vpshufb	.LC8(%rip), %xmm10, %xmm10
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	19(%r15), %ecx
	vmovd	%eax, %xmm7
	movzbl	27(%r15), %eax
	vpcmpgtb	%xmm7, %xmm14, %xmm9
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	11(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm9, %xmm9
	orl	%ecx, %eax
	movzbl	3(%r15), %ecx
	vpsrlw	$5, %xmm9, %xmm9
	vpshufb	.LC8(%rip), %xmm9, %xmm9
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	20(%r15), %ecx
	vmovd	%eax, %xmm3
	movzbl	28(%r15), %eax
	vpcmpgtb	%xmm3, %xmm14, %xmm6
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	12(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm6, %xmm6
	orl	%ecx, %eax
	movzbl	4(%r15), %ecx
	vpsrlw	$5, %xmm6, %xmm6
	vpshufb	.LC8(%rip), %xmm6, %xmm6
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	21(%r15), %ecx
	vmovd	%eax, %xmm4
	movzbl	29(%r15), %eax
	vpcmpgtb	%xmm4, %xmm14, %xmm11
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	13(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm11, %xmm11
	addq	$88, %r15
	addq	$88, %r13
	orl	%ecx, %eax
	movzbl	-83(%r15), %ecx
	vpsrlw	$5, %xmm11, %xmm11
	addq	$88, %r12
	vpshufb	.LC8(%rip), %xmm11, %xmm11
	sall	$8, %eax
	addq	$88, %rbx
	orl	%ecx, %eax
	vpaddb	%xmm11, %xmm4, %xmm4
	vmovd	%eax, %xmm0
	vpcmpgtb	%xmm0, %xmm14, %xmm15
	vpmovzxbw	%xmm15, %xmm15
	vpsrlw	$5, %xmm15, %xmm15
	vpshufb	.LC8(%rip), %xmm15, %xmm15
	movzbl	-58(%r15), %eax
	movzbl	-66(%r15), %ecx
	vpaddb	%xmm15, %xmm0, %xmm0
	addq	$88, -152(%rbp)
	sall	$8, %eax
	addq	$88, -144(%rbp)
	orl	%ecx, %eax
	movzbl	-74(%r15), %ecx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	-82(%r15), %ecx
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	-65(%r15), %ecx
	vmovd	%eax, %xmm1
	movzbl	-57(%r15), %eax
	vpcmpgtb	%xmm1, %xmm14, %xmm13
	sall	$8, %eax
	orl	%ecx, %eax
	movzbl	-73(%r15), %ecx
	sall	$8, %eax
	vpmovzxbw	%xmm13, %xmm13
	orl	%ecx, %eax
	movzbl	-81(%r15), %ecx
	vpsrlw	$5, %xmm13, %xmm13
	vpshufb	.LC8(%rip), %xmm13, %xmm13
	sall	$8, %eax
	orl	%ecx, %eax
	vpaddb	%xmm13, %xmm1, %xmm1
	vmovd	%eax, %xmm12
	vpcmpgtb	%xmm12, %xmm14, %xmm12
	vmovd	.LC22(%rip), %xmm14
	vpand	%xmm14, %xmm1, %xmm14
	vmovd	.LC22(%rip), %xmm1
	vpmovzxbw	%xmm12, %xmm12
	vpsubb	%xmm13, %xmm14, %xmm14
	vpsrlw	$5, %xmm12, %xmm12
	vpand	%xmm1, %xmm0, %xmm13
	vmovd	%eax, %xmm1
	vpshufb	.LC8(%rip), %xmm12, %xmm12
	vpsubb	%xmm15, %xmm13, %xmm13
	vmovd	.LC22(%rip), %xmm15
	vpaddb	%xmm12, %xmm1, %xmm1
	vpmovsxbd	%xmm14, %xmm14
	vpand	%xmm15, %xmm4, %xmm4
	vpslld	$6, %xmm14, %xmm14
	vpsubb	%xmm11, %xmm4, %xmm4
	vpmovsxbd	%xmm13, %xmm13
	vpand	%xmm15, %xmm1, %xmm1
	vpslld	$3, %xmm13, %xmm13
	vpsubb	%xmm12, %xmm1, %xmm1
	vpor	%xmm13, %xmm14, %xmm0
	vpmovsxbd	%xmm4, %xmm4
	vpmovsxbd	%xmm1, %xmm1
	vpslld	$9, %xmm1, %xmm1
	vpor	%xmm4, %xmm1, %xmm1
	vpor	%xmm1, %xmm0, %xmm0
	vpaddb	%xmm9, %xmm7, %xmm1
	vpslld	$12, %xmm0, %xmm4
	vpaddb	%xmm10, %xmm8, %xmm0
	vpand	%xmm15, %xmm1, %xmm1
	vpand	%xmm15, %xmm0, %xmm0
	vpsubb	%xmm9, %xmm1, %xmm1
	vpsubb	%xmm10, %xmm0, %xmm0
	vpmovsxbd	%xmm1, %xmm1
	vpmovsxbd	%xmm0, %xmm0
	vpslld	$6, %xmm1, %xmm1
	vpslld	$3, %xmm0, %xmm0
	vpor	%xmm1, %xmm0, %xmm0
	vpaddb	%xmm5, %xmm2, %xmm1
	vpor	%xmm0, %xmm4, %xmm4
	vpaddb	%xmm6, %xmm3, %xmm0
	vpand	%xmm15, %xmm1, %xmm1
	vpand	%xmm15, %xmm0, %xmm0
	vpsubb	%xmm5, %xmm1, %xmm1
	vpsubb	%xmm6, %xmm0, %xmm0
	vpmovsxbd	%xmm1, %xmm1
	vpmovsxbd	%xmm0, %xmm0
	vpslld	$9, %xmm0, %xmm0
	vpor	%xmm1, %xmm0, %xmm0
	vpor	%xmm0, %xmm4, %xmm0
	vmovdqu	%xmm0, -88(%r15)
	cmpq	-168(%rbp), %r15
	jne	.L58
	leaq	gidx(%rip), %r12
	movq	-208(%rbp), %r14
	leaq	64(%r12), %rbx
.L59:
	call	rand@PLT
	addq	$4, %r12
	cltd
	shrl	$24, %edx
	addl	%edx, %eax
	movzbl	%al, %eax
	subl	%edx, %eax
	movl	%eax, -4(%r12)
	cmpq	%rbx, %r12
	jne	.L59
	movl	$1024, %esi
	movl	$64, %edi
	call	aligned_alloc@PLT
	movq	%rax, %r13
	movq	%rax, %r12
	leaq	1024(%rax), %rbx
	.p2align 4
	.p2align 3
.L60:
	call	rand@PLT
	addq	$4, %r12
	movl	%eax, -4(%r12)
	cmpq	%r12, %rbx
	jne	.L60
	movq	-200(%rbp), %rax
	vxorps	%xmm2, %xmm2, %xmm2
	movq	%r14, -128(%rbp)
	leaq	.LC9(%rip), %rdi
	vmovaps	%xmm2, -144(%rbp)
	movq	%rax, -112(%rbp)
	movq	-184(%rbp), %rax
	movq	%r13, gtable(%rip)
	movq	%rax, -96(%rbp)
	movq	-192(%rbp), %rax
	movq	$512, -120(%rbp)
	movq	$512, -104(%rbp)
	movq	$4096, -88(%rbp)
	movq	%rax, -80(%rbp)
	movq	$4096, -72(%rbp)
	call	puts@PLT
	leaq	-128(%rbp), %rdi
	call	bench.constprop.4
	vmovaps	-144(%rbp), %xmm2
	testq	%rax, %rax
	js	.L61
	vcvtsi2sdq	%rax, %xmm2, %xmm0
.L62:
	vmulsd	.LC10(%rip), %xmm0, %xmm0
	leaq	.LC11(%rip), %rdi
	movl	$1, %eax
	vmovaps	%xmm2, -144(%rbp)
	call	printf@PLT
	leaq	-112(%rbp), %rdi
	call	bench.constprop.3
	vmovaps	-144(%rbp), %xmm2
	testq	%rax, %rax
	js	.L63
	vcvtsi2sdq	%rax, %xmm2, %xmm0
.L64:
	vmulsd	.LC10(%rip), %xmm0, %xmm0
	leaq	.LC12(%rip), %rdi
	movl	$1, %eax
	vmovaps	%xmm2, -144(%rbp)
	call	printf@PLT
	leaq	.LC13(%rip), %rdi
	call	puts@PLT
	leaq	-96(%rbp), %rdi
	call	bench.constprop.4
	vmovaps	-144(%rbp), %xmm2
	testq	%rax, %rax
	js	.L65
	vcvtsi2sdq	%rax, %xmm2, %xmm0
.L66:
	vmulsd	.LC14(%rip), %xmm0, %xmm0
	leaq	.LC11(%rip), %rdi
	movl	$1, %eax
	vmovaps	%xmm2, -144(%rbp)
	call	printf@PLT
	leaq	-80(%rbp), %rdi
	call	bench.constprop.3
	vmovaps	-144(%rbp), %xmm2
	testq	%rax, %rax
	js	.L67
	vcvtsi2sdq	%rax, %xmm2, %xmm0
.L68:
	vmulsd	.LC14(%rip), %xmm0, %xmm0
	leaq	.LC12(%rip), %rdi
	movl	$1, %eax
	vmovaps	%xmm2, -240(%rbp)
	call	printf@PLT
	leaq	.LC15(%rip), %rdi
	call	puts@PLT
	movq	%rsp, -208(%rbp)
	subq	$256, %rsp
	movl	gidx(%rip), %edx
	leaq	7(%rsp), %rax
	vmovaps	-240(%rbp), %xmm2
	movq	%rax, %r13
	andq	$-8, %rax
	movq	%rax, %rcx
	movq	gtable(%rip), %rax
	shrq	$3, %r13
	movq	%rcx, -200(%rbp)
	leaq	248(%rcx), %r15
	leaq	(%rax,%rdx,4), %r12
	movl	4+gidx(%rip), %edx
	movq	%r13, -224(%rbp)
	movq	%rcx, -248(%rbp)
	leaq	(%rax,%rdx,4), %rbx
	movl	8+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %r11
	movl	12+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %r10
	movl	16+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %r9
	movl	20+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %r8
	movl	24+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rdi
	movl	28+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rsi
	movl	32+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rdx
	movq	%rdx, -216(%rbp)
	movl	36+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rdx
	movq	%rdx, -144(%rbp)
	movl	40+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rdx
	movq	%rdx, -152(%rbp)
	movl	44+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rdx
	movq	%rdx, -160(%rbp)
	movl	48+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rdx
	movq	%rdx, -168(%rbp)
	movl	52+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rdx
	movq	%rdx, -176(%rbp)
	movl	56+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rdx
	movq	%rdx, -184(%rbp)
	movl	60+gidx(%rip), %edx
	leaq	(%rax,%rdx,4), %rax
	movq	%rax, -192(%rbp)
.L69:
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	movq	-144(%rbp), %rcx
	movl	%edx, %r13d
	movl	%eax, -240(%rbp)
	movq	-216(%rbp), %rdx
	movl	(%r12), %eax
	xorl	(%rbx), %eax
	xorl	(%r11), %eax
	xorl	(%r10), %eax
	xorl	(%r9), %eax
	xorl	(%r8), %eax
	xorl	(%rdi), %eax
	xorl	(%rsi), %eax
	xorl	(%rdx), %eax
	xorl	(%rcx), %eax
	movq	-152(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-160(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-168(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-176(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-184(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-192(%rbp), %rcx
	xorl	(%rcx), %eax
	xorl	(%r12), %eax
	xorl	(%rbx), %eax
	xorl	(%r11), %eax
	xorl	(%r10), %eax
	xorl	(%r9), %eax
	xorl	(%r8), %eax
	xorl	(%rdi), %eax
	xorl	(%rsi), %eax
	movq	-144(%rbp), %rcx
	xorl	(%rdx), %eax
	xorl	(%rcx), %eax
	movq	-152(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-160(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-168(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-176(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-184(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-192(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-144(%rbp), %rcx
	xorl	(%r12), %eax
	xorl	(%rbx), %eax
	xorl	(%r11), %eax
	xorl	(%r10), %eax
	xorl	(%r9), %eax
	xorl	(%r8), %eax
	xorl	(%rdi), %eax
	xorl	(%rsi), %eax
	xorl	(%rdx), %eax
	xorl	(%rcx), %eax
	movq	-152(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-160(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-168(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-176(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-184(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-192(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-144(%rbp), %rcx
	xorl	(%r12), %eax
	xorl	(%rbx), %eax
	xorl	(%r11), %eax
	xorl	(%r10), %eax
	xorl	(%r9), %eax
	xorl	(%r8), %eax
	xorl	(%rdi), %eax
	xorl	(%rsi), %eax
	xorl	(%rdx), %eax
	xorl	(%rcx), %eax
	movq	-152(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-160(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-168(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-176(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-184(%rbp), %rcx
	xorl	(%rcx), %eax
	movq	-192(%rbp), %rcx
	xorl	(%rcx), %eax
	movl	%eax, result_sink(%rip)
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	salq	$32, %rdx
	movl	%eax, %eax
	salq	$32, %r13
	movq	-200(%rbp), %rcx
	orq	%rdx, %rax
	movl	-240(%rbp), %edx
	addq	$8, %rcx
	orq	%r13, %rdx
	subq	%rdx, %rax
	movq	%rax, -8(%rcx)
	movq	%rcx, -200(%rbp)
	cmpq	%r15, %rcx
	jne	.L69
	movq	-248(%rbp), %rcx
	movq	-224(%rbp), %r13
	movl	$1, %edi
	addq	$8, %rcx
.L72:
	movq	%rcx, %rax
	.p2align 5
	.p2align 4
	.p2align 3
.L71:
	movq	(%rax), %rsi
	movq	(%rcx), %rdx
	cmpq	%rdx, %rsi
	jnb	.L70
	movq	%rsi, (%rcx)
	movq	%rdx, (%rax)
.L70:
	addq	$8, %rax
	cmpq	%rax, %r15
	jne	.L71
	addq	$1, %rdi
	addq	$8, %rcx
	cmpq	$31, %rdi
	jne	.L72
	movq	120(,%r13,8), %rax
	movq	-208(%rbp), %rsp
	testq	%rax, %rax
	js	.L73
	vcvtsi2sdq	%rax, %xmm2, %xmm1
.L74:
	vmulsd	.LC16(%rip), %xmm1, %xmm1
	shrq	$2, %rax
	leaq	.LC17(%rip), %rdi
	vmovaps	%xmm2, -144(%rbp)
	vcvtsi2sdq	%rax, %xmm2, %xmm0
	movl	$2, %eax
	call	printf@PLT
	movq	%rsp, %rcx
	subq	$256, %rsp
	vmovaps	-144(%rbp), %xmm2
	leaq	7(%rsp), %rsi
	movq	%rsi, %r8
	andq	$-8, %rsi
	shrq	$3, %r8
	leaq	248(%rsi), %rdi
	movq	%rsi, %r10
.L75:
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	vmovdqa	(%r14), %ymm1
	vpaddd	32(%r14), %ymm1, %ymm1
	salq	$32, %rdx
	movl	%eax, %eax
	orq	%rax, %rdx
	vpslld	$3, %ymm1, %ymm0
	movq	%rdx, %r9
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$3, %ymm0, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpslld	$3, %ymm1, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$3, %ymm0, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpslld	$3, %ymm1, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$3, %ymm0, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpslld	$3, %ymm1, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$3, %ymm0, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpslld	$3, %ymm1, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$3, %ymm0, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpslld	$3, %ymm1, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$3, %ymm0, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpslld	$3, %ymm1, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$3, %ymm0, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vextracti128	$0x1, %ymm1, %xmm0
	vpaddd	%xmm1, %xmm0, %xmm0
	vpsrldq	$8, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vpsrldq	$4, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vmovd	%xmm0, result_sink(%rip)
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	movl	%eax, %eax
	salq	$32, %rdx
	addq	$8, %r10
	orq	%rax, %rdx
	movq	%rdx, %rax
	subq	%r9, %rax
	movq	%rax, -8(%r10)
	cmpq	%rdi, %r10
	jne	.L75
	addq	$8, %rsi
	movl	$1, %r9d
.L78:
	movq	%rsi, %rax
	.p2align 5
	.p2align 4
	.p2align 3
.L77:
	movq	(%rax), %r10
	movq	(%rsi), %rdx
	cmpq	%rdx, %r10
	jnb	.L76
	movq	%r10, (%rsi)
	movq	%rdx, (%rax)
.L76:
	addq	$8, %rax
	cmpq	%rax, %rdi
	jne	.L77
	addq	$1, %r9
	addq	$8, %rsi
	cmpq	$31, %r9
	jne	.L78
	movq	120(,%r8,8), %rax
	movq	%rcx, %rsp
	testq	%rax, %rax
	js	.L79
	vcvtsi2sdq	%rax, %xmm2, %xmm0
.L80:
	vmulsd	.LC18(%rip), %xmm0, %xmm1
	vmovaps	%xmm2, -144(%rbp)
	movl	$2, %eax
	leaq	.LC19(%rip), %rdi
	vzeroupper
	call	printf@PLT
	movslq	-120(%rbp), %rcx
	movq	%rsp, %r8
	movq	-128(%rbp), %r12
	subq	$256, %rsp
	vmovaps	-144(%rbp), %xmm2
	movq	%rcx, %rbx
	imulq	$88, %rcx, %rcx
	leaq	7(%rsp), %rsi
	movq	%rsi, %r9
	andq	$-8, %rsi
	shrq	$3, %r9
	leaq	248(%rsi), %rdi
	movq	%rsi, %r11
	addq	%r12, %rcx
.L83:
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	salq	$32, %rdx
	movl	%eax, %eax
	orq	%rax, %rdx
	movq	%rdx, %r10
	testl	%ebx, %ebx
	jle	.L90
	movq	%r12, %rax
	vpxor	%xmm3, %xmm3, %xmm3
	.p2align 6
	.p2align 4
	.p2align 3
.L82:
	vmovdqu	32(%rax), %ymm1
	vpaddd	(%rax), %ymm1, %ymm1
	addq	$88, %rax
	vextracti128	$0x1, %ymm1, %xmm0
	vpaddd	%xmm1, %xmm0, %xmm0
	vpsrldq	$8, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vpsrldq	$4, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vpaddd	%xmm0, %xmm3, %xmm3
	cmpq	%rax, %rcx
	jne	.L82
.L81:
	vmovd	%xmm3, result_sink(%rip)
#APP
# 15 "microbench_iq3xxs.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	movl	%eax, %eax
	salq	$32, %rdx
	addq	$8, %r11
	orq	%rax, %rdx
	movq	%rdx, %rax
	subq	%r10, %rax
	movq	%rax, -8(%r11)
	cmpq	%rdi, %r11
	jne	.L83
	addq	$8, %rsi
	movl	$1, %r10d
.L86:
	movq	%rsi, %rax
	.p2align 5
	.p2align 4
	.p2align 3
.L85:
	movq	(%rax), %rcx
	movq	(%rsi), %rdx
	cmpq	%rdx, %rcx
	jnb	.L84
	movq	%rcx, (%rsi)
	movq	%rdx, (%rax)
.L84:
	addq	$8, %rax
	cmpq	%rdi, %rax
	jne	.L85
	addq	$1, %r10
	addq	$8, %rsi
	cmpq	$31, %r10
	jne	.L86
	movq	120(,%r9,8), %rax
	movq	%r8, %rsp
	testq	%rax, %rax
	js	.L87
	vcvtsi2sdq	%rax, %xmm2, %xmm0
.L88:
	vmulsd	.LC10(%rip), %xmm0, %xmm0
	leaq	.LC21(%rip), %rdi
	movl	$1, %eax
	vmulsd	.LC20(%rip), %xmm0, %xmm0
	vzeroupper
	call	printf@PLT
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L120
	leaq	-48(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L90:
	.cfi_restore_state
	vpxor	%xmm3, %xmm3, %xmm3
	jmp	.L81
.L61:
	movq	%rax, %rdx
	andl	$1, %eax
	shrq	%rdx
	orq	%rax, %rdx
	vcvtsi2sdq	%rdx, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	jmp	.L62
.L87:
	movq	%rax, %rdx
	andl	$1, %eax
	shrq	%rdx
	orq	%rax, %rdx
	vcvtsi2sdq	%rdx, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	jmp	.L88
.L79:
	movq	%rax, %rdx
	andl	$1, %eax
	shrq	%rdx
	orq	%rax, %rdx
	vcvtsi2sdq	%rdx, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	jmp	.L80
.L73:
	movq	%rax, %rdx
	movq	%rax, %rcx
	shrq	%rdx
	andl	$1, %ecx
	orq	%rcx, %rdx
	vcvtsi2sdq	%rdx, %xmm2, %xmm1
	vaddsd	%xmm1, %xmm1, %xmm1
	jmp	.L74
.L67:
	movq	%rax, %rdx
	andl	$1, %eax
	shrq	%rdx
	orq	%rax, %rdx
	vcvtsi2sdq	%rdx, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	jmp	.L68
.L65:
	movq	%rax, %rdx
	andl	$1, %eax
	shrq	%rdx
	orq	%rax, %rdx
	vcvtsi2sdq	%rdx, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	jmp	.L66
.L63:
	movq	%rax, %rdx
	andl	$1, %eax
	shrq	%rdx
	orq	%rax, %rdx
	vcvtsi2sdq	%rdx, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	jmp	.L64
.L120:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE7345:
	.size	main, .-main
	.section	.rodata
	.align 32
	.type	bytevals.0, @object
	.size	bytevals.0, 32
bytevals.0:
	.long	4
	.long	12
	.long	20
	.long	28
	.long	36
	.long	44
	.long	52
	.long	62
	.local	gidx
	.comm	gidx,64,32
	.local	gtable
	.comm	gtable,8,8
	.globl	result_sink
	.bss
	.align 4
	.type	result_sink, @object
	.size	result_sink, 4
result_sink:
	.zero	4
	.local	signs64
	.comm	signs64,1024,32
	.local	table256
	.comm	table256,1024,32
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC4:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC8:
	.byte	0
	.byte	2
	.byte	4
	.byte	6
	.byte	8
	.byte	10
	.byte	12
	.byte	14
	.byte	0
	.byte	2
	.byte	4
	.byte	6
	.byte	8
	.byte	10
	.byte	12
	.byte	14
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC10:
	.long	0
	.long	1063256064
	.align 8
.LC14:
	.long	0
	.long	1060110336
	.align 8
.LC16:
	.long	0
	.long	1066401792
	.align 8
.LC18:
	.long	0
	.long	1068498944
	.align 8
.LC20:
	.long	0
	.long	1071644672
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC22:
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.ident	"GCC: (GNU) 16.2.1 20260810"
	.section	.note.GNU-stack,"",@progbits
