
            .code16
            .global     _stage1
            .section    .text.s1
            .set        STAGE2, 0x7e00
            .global     STAGE2
            .extern     _dev

        _stage1:                                    #   Bootloader entry point

            movb    %dl,  _dev                      #   Boot device value

            xor     %ax,    %ax
            mov     %ax,    %ds
            mov     %ax,    %ss
            mov     $_stage1,%sp
            cld

            /* First part of the boot msg. */
            mov     $0x03,  %ax                     #   Clear the screen
            int     $0x10

            mov     $0x13,  %ah                     #   Value 0x13 (print str.)
            mov     $0x01,  %al                     #   String type
            mov     $0x00,  %bh                     #   Video page num.
            mov     $0x0f,  %bl                     #   Attribute (White on Black)
            mov     $0x04,  %cx                     #   String len. = 4 chars.
            mov     $0x00,  %dh                     #   Row 0
            mov     $0x00,  %dl                     #   Column 0
            mov     $_msg0, %bp                     #   String to print
            int     $0x10                           #   Call interrupt

            call    read_disk

            jmp     0x7e00

            .section    .rodata                     #   Read-only data
        _msg0:  .asciz  "\xDB\xDB\xDB "             #   Boot message (1/2).
