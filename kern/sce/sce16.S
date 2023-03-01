
    /*
            Main kernel file for SCE operating system.
    */

    .section    .text
    .global     sce16
    .code16

        sce16:
            #   Video mode
            mov     $0x03,      %ax
            int     $0x10

            #   Disable blinking
            mov     $0x1003,    %ax
            mov     $0x00,      %bx
            int     $0x10

            mov     $sce_msg0,  %si
            call    sys_str_out

            call    sce_console

            cli
            hlt

    .section    .rodata
        sce_msg0:   .asciz  "   SCE Operating System [1.0.0] | ? = help\r\n"
        sce_pmpt:   .asciz  " : "
