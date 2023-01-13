.data
    x: .space 4
    y: .space 4
    cat: .space 4
    prod: .space 4
    rez1: .space 4
    rez2: .space 4
    read: .asciz "%ld %ld"
    show: .asciz "%ld %ld\n"
.text
.globl main
main:
    pushl $y
    pushl $x
    pushl $read
    call scanf
    popl %ebx
    popl %ebx
    popl %ebx

etV1:
    mov $0, %edx
    mov x, %eax
    mov $16, %ebx
    idiv %ebx
    mov %eax, cat

    mov y, %eax
    mov $16, %ebx
    mul %ebx
    mov %eax, prod

    mov cat, %eax
    add prod, %eax
    mov %eax, rez1

etV2:
    mov x, %eax
    shr $4, %eax
    mov %eax, cat

    mov y, %eax
    shl $4, %eax
    mov %eax, prod

    mov cat, %eax
    add prod, %eax
    mov %eax, rez2

etShow:
    pushl rez2
    pushl rez1
    pushl $show
    call printf
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

etExit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
