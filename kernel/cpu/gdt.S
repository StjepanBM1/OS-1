
        .code16
        .global     _gdt_info
        .section    .text.kernel

        _gdt_info:
            .word   gdt_end - gdt - 1
            .long   gdt

        gdt:
            .long   0
            .long   0

        flatd:
            .byte   0xFF, 0xFF, 0, 0, 0, 0b10010010, 0b11001111, 0
        
        gdt_end:
