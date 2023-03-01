
    .section    .text.boot
        .extern     BOOTD
        .code16
        .global     _start

        _start:

            mov     %dl,    (BOOTD)

            xor     %ax,    %ax
            mov     %ax,    %ds
            mov     %ax,    %ss
            mov     $_start,%sp
            cld

            #   Set the video mode
            mov     $0x03,  %ax
            int     $0x10

            #   Stop blinking attr.
            mov     $0x1003,%ax
            mov     $0x00,  %bx
            int     $0x10

            #   8x14 characther set
            mov     $0x11,  %ah
            mov     $0x01,  %al
            int     $0x10

            #   Print the start msg.
            mov     $msg0,  %si
            call    bputs

            mov     $0x0F,  %cx
            mov     $0x4240,%dx
            mov     $0x86,  %ah
            int     $0x15

            mov     $msg1,  %si
            call    bputs

            mov     $0x0F,  %cx
            mov     $0x4240,%dx
            mov     $0x86,  %ah
            int     $0x15

            #   Read the rest of the sects.
            call    disk_read

            jmp     PRG_SPACE

            1:  cli
                jmp     1b

    .section    .rodata
        msg0:   .asciz  "                   [ Operating System One | Release 2.0.0 ]\r\n                            Kernel Version [0xC8]\r\n"
        msg1:   .asciz  "\r\nLoading the System Boot image..."

/*
    .space  510-(. - _start)
    .word   0xaa55
*/