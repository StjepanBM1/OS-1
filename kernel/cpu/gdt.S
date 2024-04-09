
        .code16
        .global     _gdt_info
        .section    .text

    _gdt_info:
        .word   _gdt_end - _gdt - 1
        .long   _gdt

    _gdt:
        .long   0
        .long   0
    
    _flat_code:
        .byte   0xff, 0xff, 0, 0, 0, 0b10011010, 0b10001111, 0
    
    _flat_data:
        .byte   0xff, 0xff, 0, 0, 0, 0b10010010, 0b11001111, 0

    _gdt_end:
