
    [ORG    0x7e00]
    [CPU       386]
    [BITS       16]

        %define BUILD '0.1.2'

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

            call        slow

            mov     si, msg4
            call        puts

            call        slow

            cli

            jmp     _ui_main

        %include "../lib/txt16.S"
        %include "../lib/disk16.S"
        %include "ui/ui16.S"
        %include "ui/lib_ui/screen.S"
        %include "lib/sleep.S"
