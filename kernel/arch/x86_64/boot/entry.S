.section .text
.global _start
.type _start, @function
_start:
    cli
    xor %rbp, %rbp
    lea kernel_stack_end(%rip), %rsp
    call kmain
hlt_loop:
    hlt
    jmp hlt_loop

.section .bss
.align 16
kernel_stack:
    .zero 16384
kernel_stack_end:
