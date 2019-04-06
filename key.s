.section .data
values:
	.ascii "This is a Plaintext message.\n"
key:
	.ascii "ABXmv#7"
.section .text
.global main
main:
	movl $4, %eax
	movl $1, %ebx
	movl $values, %ecx
	movl $29, %edx
	int $0x80
	
	leal values, %esi
	leal key, %edi
	movl $27, %ecx
	movl $7, %edx
loop:
	movb (%esi), %al
	xorb (%edi), %al
	movb %al, (%esi)
	dec %ecx
	jz end
	inc %esi
	dec %edx
	jz reset
	inc %edi
	jmp loop
reset:
	movl $7, %edx
	leal key, %edi
	jmp loop
end:	
	movl $4, %eax
	movl $1, %ebx
	movl $values, %ecx
	movl $29, %edx
	int $0x80
