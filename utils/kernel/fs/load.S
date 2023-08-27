
            .code16
            .global     _load_A
            .global     _load_B
            .section    .text.filesys

        #
        #   _load_B:    Load the data from the disk drive A.
        #               And jump to the 0x7e00 address of the disk.
        _load_A:
            clc
            incb    (tries)

            mov     $0x02,  %ah
            mov     $0x40,  %al
            mov     $0x7e00,%bx
            mov     $0x00,  %ch
            mov     $0x02,  %cl
            mov     $0x00,  %dh
            mov     $0x00,  %dl
            int     $0x13

            jc      _err_A

            ljmp    $0x0000,$0x7e00

        #
        #   _load_B:    Load the data from the disk drive B.
        #               And jump to the 0x7e00 address of the disk.
        _load_B:
            clc
            incb    (tries)

            mov     $0x02,  %ah
            mov     $0x40,  %al
            mov     $0x7e00,%bx
            mov     $0x00,  %ch
            mov     $0x02,  %cl
            mov     $0x00,  %dh
            mov     $0x01,  %dl
            int     $0x13

            jc      _err_B

            ljmp    $0x0000,$0x7e00

        #
        #   _err_A: Disk load error for _load_A function
        _err_A:
            clc
            cmpb    $3, (tries)
            jl      _load_A

            mov     $0x03,  %ax
            int     $0x10

            xor     %ax,    %ax
            int     $0x13

            mov     $0x13,  %ah
            mov     $0x01,  %al
            mov     $0x00,  %bh
            mov     $0x0c,  %bl
            mov     $0x2e,  %cx
            mov     $0x00,  %dh
            mov     $0x00,  %dl
            mov     $_ler_A,%bp
            int     $0x10

            call    _disk_status

            mov     $0x13,  %ah
            mov     $0x01,  %al
            mov     $0x00,  %bh
            mov     $0x0f,  %bl
            mov     $0x24,  %cx
            mov     $0x01,  %dh
            mov     $0x00,  %dl
            mov     $_retmg,%bp
            int     $0x10

            mov     $0x00,  %ax
            int     $0x16

            call    _clear

            ret

        #
        #   _err_B: Disk load error for _load_B function
        _err_B:
            clc
            cmpb    $3, (tries)
            jl      _load_B

            mov     $0x03,  %ax
            int     $0x10

            xor     %ax,    %ax
            int     $0x13

            mov     $0x13,  %ah
            mov     $0x01,  %al
            mov     $0x00,  %bh
            mov     $0x0c,  %bl
            mov     $0x2e,  %cx
            mov     $0x00,  %dh
            mov     $0x00,  %dl
            mov     $_ler_B,%bp
            int     $0x10

            call    _disk_status

            mov     $0x13,  %ah
            mov     $0x01,  %al
            mov     $0x00,  %bh
            mov     $0x0f,  %bl
            mov     $0x24,  %cx
            mov     $0x01,  %dh
            mov     $0x00,  %dl
            mov     $_retmg,%bp
            int     $0x10

            mov     $0x00,  %ax
            int     $0x16

            call    _clear

            ret

            .section    .rodata
        _ler_A: .asciz  "/!\\ Failed to load the data from drive A /!\\\r\n"
        _ler_B: .asciz  "/!\\ Failed to load the data from drive B /!\\\r\n"
        _retmg: .asciz  "\r\nPress any key to return to MP-OS/1"

            .section    .data
        tries:  .byte   0
