	.text
	.section	.rodata
.LC0:
	.string	"Error opening file"
.LC1:
	.string	"Error getting file size"
	.align 8
.LC2:
	.string	"New file size cannot be negative\n"
.LC3:
	.string	"Error setting file size"
	.text
	.globl	adjust_file_size
	.type	adjust_file_size, @function
adjust_file_size:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	-40(%rbp), %rax
	movl	$2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jns	.L2
	movl	$.LC0, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L2:
	movl	-4(%rbp), %eax
	movl	$2, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	lseek
	movq	%rax, -16(%rbp)
	cmpq	$-1, -16(%rbp)
	jne	.L3
	movl	$.LC1, %edi
	call	perror
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$1, %edi
	call	exit
.L3:
	movq	-16(%rbp), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jns	.L4
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$33, %edx
	movl	$1, %esi
	movl	$.LC2, %edi
	call	fwrite
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$1, %edi
	call	exit
.L4:
	movq	-24(%rbp), %rdx
	movl	-4(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	ftruncate
	testl	%eax, %eax
	jns	.L5
	movl	$.LC3, %edi
	call	perror
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$1, %edi
	call	exit
.L5:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	close
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	adjust_file_size, .-adjust_file_size
	.section	.rodata
.LC4:
	.string	"Enter file name: "
.LC5:
	.string	"Error reading input"
.LC6:
	.string	"\n"
	.align 8
.LC7:
	.string	"Enter the amount to change the size (use + to increase or - to decrease): "
.LC8:
	.string	"%ld"
.LC9:
	.string	"Error reading amount\n"
	.align 8
.LC10:
	.string	"File size successfully updated."
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$272, %rsp
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movq	stdin(%rip), %rdx
	leaq	-256(%rbp), %rax
	movl	$256, %esi
	movq	%rax, %rdi
	call	fgets
	testq	%rax, %rax
	jne	.L7
	movl	$.LC5, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L7:
	leaq	-256(%rbp), %rax
	movl	$.LC6, %esi
	movq	%rax, %rdi
	call	strcspn
	movb	$0, -256(%rbp,%rax)
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
	leaq	-264(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC8, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	cmpl	$1, %eax
	je	.L8
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$21, %edx
	movl	$1, %esi
	movl	$.LC9, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L8:
	movq	-264(%rbp), %rdx
	leaq	-256(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	adjust_file_size
	movl	$.LC10, %edi
	call	puts
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.section	.note.GNU-stack,"",@progbits
