	.file	"modbus.c"
	.text
	.globl	device_id
	.section	.rodata
	.type	device_id, @object
	.size	device_id, 1
device_id:
	.byte	1
	.globl	holding_register
	.type	holding_register, @object
	.size	holding_register, 1
holding_register:
	.byte	3
	.globl	coil_register
	.type	coil_register, @object
	.size	coil_register, 1
coil_register:
	.byte	1
	.globl	starting_address
	.align 2
	.type	starting_address, @object
	.size	starting_address, 2
starting_address:
	.zero	2
	.globl	last_address
	.align 2
	.type	last_address, @object
	.size	last_address, 2
last_address:
	.value	-7
	.globl	starting_quantity
	.align 2
	.type	starting_quantity, @object
	.size	starting_quantity, 2
starting_quantity:
	.zero	2
	.globl	last_quantity
	.align 2
	.type	last_quantity, @object
	.size	last_quantity, 2
last_quantity:
	.value	2000
	.text
	.globl	mb_req_pdu_server
	.type	mb_req_pdu_server, @function
mb_req_pdu_server:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %edx
	movl	%esi, %eax
	movb	%dl, -4(%rbp)
	movb	%al, -8(%rbp)
	cmpb	$5, -4(%rbp)
	jne	.L2
	cmpb	$5, -8(%rbp)
	jne	.L2
	movl	$5, %eax
	jmp	.L3
.L2:
	movl	$0, %eax
.L3:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	mb_req_pdu_server, .-mb_req_pdu_server
	.globl	read_from_memory
	.type	read_from_memory, @function
read_from_memory:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movb	$1, -1(%rbp)
	cmpb	$1, -1(%rbp)
	jne	.L5
	movl	$5, %eax
	jmp	.L6
.L5:
	movl	$0, %eax
.L6:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	read_from_memory, .-read_from_memory
	.globl	check_is_readable
	.type	check_is_readable, @function
check_is_readable:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %eax
	call	read_from_memory
	cmpb	$5, %al
	jne	.L8
	movl	$5, %eax
	jmp	.L9
.L8:
	movl	$4, %eax
.L9:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	check_is_readable, .-check_is_readable
	.globl	check_valid_function_code
	.type	check_valid_function_code, @function
check_valid_function_code:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	movl	$3, %eax
	cmpb	%al, -4(%rbp)
	je	.L11
	movl	$1, %eax
	cmpb	%al, -4(%rbp)
	jne	.L12
.L11:
	movl	$5, %eax
	jmp	.L13
.L12:
	movl	$1, %eax
.L13:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	check_valid_function_code, .-check_valid_function_code
	.globl	check_valid_quantity
	.type	check_valid_quantity, @function
check_valid_quantity:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movw	%ax, -4(%rbp)
	movl	$0, %eax
	cmpw	%ax, -4(%rbp)
	jb	.L15
	movl	$2000, %eax
	cmpw	%ax, -4(%rbp)
	ja	.L15
	movl	$5, %eax
	jmp	.L16
.L15:
	movl	$3, %eax
.L16:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	check_valid_quantity, .-check_valid_quantity
	.globl	check_address
	.type	check_address, @function
check_address:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	$0, %eax
	movzwl	%ax, %eax
	cmpl	%eax, -4(%rbp)
	jb	.L18
	movl	$-7, %eax
	movzwl	%ax, %eax
	cmpl	%eax, -4(%rbp)
	ja	.L18
	movl	$5, %eax
	jmp	.L19
.L18:
	movl	$0, %eax
.L19:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	check_address, .-check_address
	.globl	check_valid_address_and_quantity
	.type	check_valid_address_and_quantity, @function
check_valid_address_and_quantity:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movl	%edi, %edx
	movl	%esi, %eax
	movw	%dx, -20(%rbp)
	movw	%ax, -24(%rbp)
	movzwl	-20(%rbp), %edx
	movzwl	-24(%rbp), %eax
	addl	%edx, %eax
	movw	%ax, -2(%rbp)
	movzwl	-20(%rbp), %eax
	movl	%eax, %edi
	call	check_address
	cmpb	$5, %al
	jne	.L21
	movzwl	-2(%rbp), %eax
	movl	%eax, %edi
	call	check_address
	cmpb	$5, %al
	jne	.L21
	movl	$5, %eax
	jmp	.L22
.L21:
	movl	$2, %eax
.L22:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	check_valid_address_and_quantity, .-check_valid_address_and_quantity
	.globl	CRC_Check
	.type	CRC_Check, @function
CRC_Check:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jne	.L24
	movl	$5, %eax
	jmp	.L25
.L24:
	movl	$0, %eax
.L25:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	CRC_Check, .-CRC_Check
	.globl	address_id_check
	.type	address_id_check, @function
address_id_check:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	movl	$1, %eax
	cmpb	%al, -4(%rbp)
	jne	.L27
	movl	$5, %eax
	jmp	.L28
.L27:
	movl	$0, %eax
.L28:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	address_id_check, .-address_id_check
	.globl	CRC16_2
	.type	CRC16_2, @function
CRC16_2:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$65535, -12(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L30
.L35:
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	xorl	%eax, -12(%rbp)
	movl	$8, -4(%rbp)
	jmp	.L31
.L34:
	movl	-12(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L32
	shrl	-12(%rbp)
	xorl	$40961, -12(%rbp)
	jmp	.L33
.L32:
	shrl	-12(%rbp)
.L33:
	subl	$1, -4(%rbp)
.L31:
	cmpl	$0, -4(%rbp)
	jne	.L34
	addl	$1, -8(%rbp)
.L30:
	movl	-8(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L35
	movl	-12(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	CRC16_2, .-CRC16_2
	.globl	error_generate
	.type	error_generate, @function
error_generate:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, %edx
	movl	%esi, %eax
	movb	%dl, -20(%rbp)
	movb	%al, -24(%rbp)
	movl	$2, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movzbl	-20(%rbp), %eax
	addl	$-128, %eax
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %edx
	movb	%dl, (%rax)
	movq	-8(%rbp), %rax
	leaq	1(%rax), %rdx
	movzbl	-24(%rbp), %eax
	movb	%al, (%rdx)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	error_generate, .-error_generate
	.section	.rodata
.LC0:
	.string	"Ok!"
	.text
	.globl	check_function
	.type	check_function, @function
check_function:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -88(%rbp)
	movl	%esi, -92(%rbp)
	movq	-88(%rbp), %rax
	movl	$6, %esi
	movq	%rax, %rdi
	call	CRC16_2
	movl	%eax, -52(%rbp)
	movl	-92(%rbp), %edx
	movl	-52(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	CRC_Check
	movb	%al, -65(%rbp)
	movq	-88(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -64(%rbp)
	movzbl	-64(%rbp), %eax
	movl	%eax, %edi
	call	address_id_check
	movb	%al, -63(%rbp)
	movzbl	-63(%rbp), %edx
	movzbl	-65(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	mb_req_pdu_server
	movb	%al, -62(%rbp)
	movq	-88(%rbp), %rax
	movzbl	1(%rax), %eax
	movb	%al, -61(%rbp)
	movq	-88(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, %edx
	movq	-88(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	orl	%edx, %eax
	movw	%ax, -56(%rbp)
	movq	-88(%rbp), %rax
	addq	$4, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, %edx
	movq	-88(%rbp), %rax
	addq	$5, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	orl	%edx, %eax
	movw	%ax, -54(%rbp)
	cmpb	$5, -62(%rbp)
	jne	.L40
	movq	-88(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	check_valid_function_code
	movb	%al, -60(%rbp)
	cmpb	$5, -60(%rbp)
	jne	.L41
	movzwl	-54(%rbp), %eax
	movl	%eax, %edi
	call	check_valid_quantity
	movb	%al, -59(%rbp)
	cmpb	$5, -59(%rbp)
	jne	.L42
	movzwl	-54(%rbp), %edx
	movzwl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	check_valid_address_and_quantity
	movb	%al, -58(%rbp)
	cmpb	$5, -58(%rbp)
	jne	.L43
	movl	$0, %eax
	call	check_is_readable
	movb	%al, -57(%rbp)
	cmpb	$5, -57(%rbp)
	jne	.L44
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$2, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	jmp	.L45
.L44:
	movl	$2, %edi
	call	malloc@PLT
	movq	%rax, -16(%rbp)
	movzbl	-57(%rbp), %edx
	movzbl	-61(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	error_generate
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	jmp	.L45
.L43:
	movl	$2, %edi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	movzbl	-58(%rbp), %edx
	movzbl	-61(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	error_generate
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	jmp	.L45
.L42:
	movl	$2, %edi
	call	malloc@PLT
	movq	%rax, -32(%rbp)
	movzbl	-59(%rbp), %edx
	movzbl	-61(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	error_generate
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	jmp	.L45
.L41:
	movl	$2, %edi
	call	malloc@PLT
	movq	%rax, -40(%rbp)
	movzbl	-60(%rbp), %edx
	movzbl	-61(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	error_generate
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	jmp	.L45
.L40:
	movl	$2, %edi
	call	malloc@PLT
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movb	$116, (%rax)
	movq	-48(%rbp), %rax
.L45:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	check_function, .-check_function
	.section	.rodata
.LC1:
	.string	"%x"
.LC2:
	.string	" ,"
	.text
	.globl	main
	.type	main, @function
main:
.LFB18:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$16777473, -14(%rbp)
	movw	$1280, -10(%rbp)
	movl	$51629, -28(%rbp)
	movl	-28(%rbp), %edx
	leaq	-14(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	check_function
	movq	%rax, -24(%rbp)
	movl	$0, -32(%rbp)
	jmp	.L47
.L48:
	movl	-32(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -32(%rbp)
.L47:
	cmpl	$1, -32(%rbp)
	jle	.L48
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L50
	call	__stack_chk_fail@PLT
.L50:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
