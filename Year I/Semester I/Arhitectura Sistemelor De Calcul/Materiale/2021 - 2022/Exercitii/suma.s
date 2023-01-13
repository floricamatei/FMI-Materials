// Suma a doua numere citite de la tastatura
.data
	x: .space 4
	y: .space 4
	formatRead: .asciz "%d %d"
	formatPrint: .asciz "Suma celor doua numere este: %d\n"
.text

.global main

main:
	// scanf("%d %d", &x, &y)
	
	push $y
	push $x
	push $formatRead
	call scanf
	pop %ebx
	pop %ebx
	pop %ebx
	
	mov x, %eax
	add y, %eax
	
	
	push %eax
	push $formatPrint
	call printf
	pop %ebx
	pop %ebx
	
	push $0
	call fflush
	pop %ebx
	
	mov $1, %eax
	mov $0, %ebx
	int $0x80
