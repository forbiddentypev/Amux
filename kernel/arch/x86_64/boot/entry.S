.section .text
.global _start
.type _start, @function
_start:
    cli
    cld
    xor %rbp, %rbp
    lea kernel_stack_end(%rip), %rsp
    mov $0xB8000, %rax
    movb $'A', (%rax)
    movb $0x0F, 1(%rax)
    call kmain
hlt_loop:
    hlt
    jmp hlt_loop

.section .bss
.align 16
kernel_stack:
    .zero 16384
kernel_stack_end:
