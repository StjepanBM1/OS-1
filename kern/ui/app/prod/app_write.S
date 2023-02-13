
    _app_write:

        call    clear
        call    w_backg

        clc
        xor     ax, ax

        mov     ah, 2
        mov     dh, 0
        mov     dl, 0
        int         0x10
        mov     ah, 09h
        mov     al, 20h
        mov     cx, 80d
        mov     bl, 0x1F
        int         0x10

        mov     ah, 2
        mov     dh, 0
        mov     dl, 0
        int         10h

        mov     si, w_title
        call        ui_puts

        mov     ah, 2
        mov     dh, 1
        mov     dl, 0
        int         10h

        cli
        clc

        txt_intp:
            xor     ax, ax
            cli

            .txt_loop:
                mov ah, 0
                int     0x16

                cmp al, 27d
                je  .txt_exit

                cmp al, 13d
                je  .txt_done

                mov ah, 0x0e
                int     0x10

                jmp     .txt_loop

            .txt_back:
            .txt_done:
                mov al, 0
                stosb

                xor     ax, ax
                cli

                mov     ah, 2
                inc     dh
                mov     dl, 0
                int         10h

                jmp     txt_intp

            .txt_exit:
                jmp     _ui_main

    %include "ui/app/prod/write.lib"
