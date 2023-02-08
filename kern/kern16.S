
    [ORG    0x7e00]
    [CPU       386]
    [BITS       16]

        %define BUILD '0x002'

        JMP _kstart

        _kstart:
            xor     ax, ax
            mov     ds, ax
            mov     ss, ax
            mov     sp, 0x7e00

            cld

            mov     ax, 0xb800
            mov     es, ax

            mov     si, msg0
            call        puts

            call        slow

            mov     si, msg1
            call        puts

            call        slow

            mov     si, msg2
            call        puts

            call        slow

            mov     si, msg3
            call        puts

            mov     ax, 0xb800
            mov     gs, ax
            mov     bx, 0x0000
            mov     ax, [gs:bx]

            jmp     $

        %include "../lib/txt16.S"
        %include "../lib/disk16.S"
    
    TIMES   8192-($-$$) db 0
    DW      0xaa55

