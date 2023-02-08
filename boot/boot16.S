
    [ORG    0x7c00]
    [CPU       386]
    [BITS       16]

    %define BUILD '0x001'

    JMP     _start

        _start:
            call    clear
            call    screen

            xor     ax, ax
            mov     ds, ax
            mov     ss, ax
            mov     sp, 0x9c00

            cld

            mov     ax, 0xb800
            mov     es, ax

            mov     si, msg0
            call        puts

            mov     ax, 0xb800
            mov     gs, ax
            mov     bx, 0x0000
            mov     ax, [gs:bx]

            mov     word [regs],    ax
            call        regs

            jmp     $

        ;   Includes
        %include "lib/io16.S"

    TIMES 510-($-$$) DB 0
    DW 0xaa55
