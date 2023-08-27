
        /*
            GDT by OS-Dev wiki :
                www.osdev.org
         */

            .code16
            .global     _gdt_inf
            .section    .text

        _gdt_inf:
            .word   gdt_end - gdt - 1
            .long   gdt

        gdt:
            .long   0
            .long   0

        flatd:
            .byte   0xFF, 0xFF, 0, 0, 0, 0b10010010, 0b11001111, 0
        
        gdt_end:
