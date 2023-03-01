
    .section    .text
    .global     bputs
    .global     BOOTD
    .global     disk_read
    .global     PRG_SPACE
    .set        PRG_SPACE,  0x7e00
    .code16

        #   Print str. function
        bputs:
            lodsb
            or      %al,    %al
            jz      .done

            mov     $0x0e,  %ah
            mov     $0x00,  %bh
            int     $0x10

            jmp     bputs

            .done:
                ret

        #   Disk read func.
        disk_read:
            mov     $0x02,      %ah
            mov     $PRG_SPACE, %bx
            mov     $65,        %al
            mov     (BOOTD),    %dl
            mov     $0x00,      %ch
            mov     $0x00,      %dh
            mov     $0x02,      %cl
            int     $0x13

            jc      d_fail

            ret

        #   Disk read fail
        d_fail:
            pusha
            mov     $err0,      %si
            call    bputs

            mov     $0x00,      %ah
            int     $0x16

            int     $0x19

            .halt:
                jmp     .halt

    .section    .rodata
        BOOTD:  .byte 0
        err0:   .asciz  "\r\n[!!] Disk read failed | Any key to reboot..."
