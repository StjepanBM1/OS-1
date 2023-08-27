
            .code16
            .global     _main
            .section    .text.main

        _main:
            xor     %ax,    %ax
            mov     %ax,    %ds
            mov     %ax,    %ss
            mov     $_main, %sp
            cld

            mov     $0x03,  %ax
            int     $0x10

            mov     $0x13,  %ah                     #   Value 0x13 (print str.)
            mov     $0x01,  %al                     #   String type
            mov     $0x00,  %bh                     #   Video page num.
            mov     $0x0c,  %bl                     #   Attribute (Red on Black)
            mov     $0x20,  %cx                     #   String len. = 32 chars.
            mov     $0x00,  %dh                     #   Row 0
            mov     $0x00,  %dl                     #   Column 0
            mov     $_msg0, %bp                     #   String to print
            int     $0x10                           #   Call interrupt

            mov     $0x13,  %ah                     #   Value 0x13 (print str.)
            mov     $0x01,  %al                     #   String type
            mov     $0x00,  %bh                     #   Video page num.
            mov     $0x0f,  %bl                     #   Attribute (White on Black)
            mov     $0x3b,  %cx                     #   String len. = 59 chars.
            mov     $0x01,  %dh                     #   Row 1
            mov     $0x00,  %dl                     #   Column 0
            mov     $_msg1, %bp                     #   String to print
            int     $0x10                           #   Call interrupt

            mov     $0x00,  %ax
            int     $0x16
            int     $0x19

            .section    .rodata
        _msg0:  .asciz  "/!\\ Unbootable disk inserted /!\\"
        _msg1:  .asciz  "Insert the OS/1 WE 5.0.0 System disk and then press any key"
