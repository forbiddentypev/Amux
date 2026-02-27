.section .multiboot_header
.align 8
.global multiboot_header
multiboot_header:
    .long 0xE85250D6
    .long 0x00000000
    .long multiboot_header_end - multiboot_header
    .long -(0xE85250D6 + 0x00000000 + (multiboot_header_end - multiboot_header))
    .long 0x00000000
    .long 8
multiboot_header_end:
