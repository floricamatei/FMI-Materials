// apel functie printf
.data
	formatPrint: .asciz "%d : %d"
.text

.global main

main:
	push $1
	push $0
	push $formatPrint
	call printf
	pop %ebx
	pop %ebx
	pop %ebx
	
	push $0
	call fflush
	pop %ebx
	
	mov $1, %eax
	mov $0, %ebx
	int $0x80
