// citire matrice
// 1600 = 20 * 20 * 4
.data
	matrix: .space 1600
	columnIndex: .space 4
	lineIndex: .space 4
	n: .space 4
	nrMuchii: .space 4
	index: .space 4
	left: .space 4
	right: .space 4
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d "
	newLine: .asciz "\n"
.text

.global main

main:
	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $nrMuchii
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
// for (int index = 0; index < nrMuchii; index++)
// {
//		scanf("%d", &left);
//		scanf("%d", &right);
//		matrix[left][right] = 1;
// }
	movl $0, index
et_for:
	movl index, %ecx
	cmp %ecx, nrMuchii
	je et_afis_matr
	
	pushl $left
	pushl $formatScanf
	call scanf 
	popl %ebx
	popl %ebx
	
	pushl $right
	pushl $formatScanf
	call scanf 
	popl %ebx
	popl %ebx
	
	// trebuie sa completez 
	// matrix[left][right] = 1
	// left * n + right 
	
	movl left, %eax
	movl $0, %edx
	mull n
	// %eax := left * n
	addl right, %eax
	// %eax = left * n + right
	
	lea matrix, %edi
	movl $1, (%edi, %eax, 4)
	
	incl index
	jmp et_for
	
et_afis_matr:
	movl $0, lineIndex
	for_lines:
		movl lineIndex, %ecx
		cmp %ecx, n
		je et_exit
		
		movl $0, columnIndex
		for_columns:
			movl columnIndex, %ecx
			cmp %ecx, n
			je cont
			
			// afisez matrix[lineIndex][columnIndex]
			// lineIndex * n + columnIndex
			movl lineIndex, %eax
			movl $0, %edx
			mull n
			addl columnIndex, %eax
			// %eax = lineIndex * n + columnIndex
			
			lea matrix, %edi
			movl (%edi, %eax, 4), %ebx
			
			pushl %ebx
			pushl $formatPrintf
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl columnIndex
			jmp for_columns
		
	cont:
		movl $4, %eax
		movl $1, %ebx
		movl $newLine, %ecx
		movl $2, %edx
		int $0x80
		
		incl lineIndex
		jmp for_lines
		
		
et_exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
