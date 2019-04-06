.section .data
values:
	.fill 1000,4,0
example:
	.ascii "%d \n"
.section .text
.global main
main:
	movl $1, values
	leal values+3996, %ebx
	leal values, %esi
	movl $999, %ecx
find_next:
        cmp $0, (%esi)
        jz return
	dec %ecx
	jz finish
        leal 4(%esi), %esi
        jmp find_next
return:
        movl $1000, %eax
        subl %ecx, %eax
	movl %eax, (%esi)
	movl %esi, %edi
add:
	leal (%edi,%eax,4), %edi
	cmp %ebx, %edi
	ja update_eax
	movl $1, (%edi)
	jmp add
update_eax:
	dec %ecx
	jz finish
	leal 4(%esi), %esi
	jmp find_next
finish:
	movl $1, %esi
	leal values, %edi
compare:
	cmp $1, (%edi)
	jne output
	inc %esi
	cmp $1000, %esi
	ja end
	leal 4(%edi), %edi
	jmp compare
output:
	movl (%edi), %ebx
	pushl %ebx
	pushl $example
	call printf
	addl $8, %esp
	inc %esi
	cmp $1000, %esi
	ja end
	leal 4(%edi), %edi
	jmp compare
end:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
