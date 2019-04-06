.section .data
values:
	.ascii "This is a test.\n"
.section .bss
	.lcomm result,17
.section .text
.global main
main:
	movl $4, %eax
	movl $1, %ebx
	movl $values, %ecx
	movl $16, %edx
	int $0x80
	
 	leal values+14, %esi
	leal result, %edi
	movl $15, %ecx
loop:
	std
	lodsb
	cld
	stosb
	dec %ecx
	jnz loop
end:
	leal values+15, %esi
	leal result+15, %edi
	movl $2, %ecx
	rep movsb
	
	movl $4, %eax
	movl $1, %ebx
	movl $result, %ecx
	movl $16, %edx
	int $0x80
