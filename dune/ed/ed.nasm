
    _main_ed:
        mov     si,     start_msg
        call    puts16

        .ed_l:
            mov     ax,     0x00
            int             0x16

            cmp     al,     0x1b
            je      .done

            cmp     al, 0x08
            je      .backpsace

            cmp     al, 0x0d
            je      .return

            mov     ah,     0x0e
            int             0x10
            jmp     .ed_l

        .backpsace:
            dec     di
            mov     byte [di],  0
            dec     cl

            mov     ah, 0x0e
            mov     al, 0x08
            int         0x10

            mov     al, ' '
            int         0x10

            mov     al, 0x08
            int         0x10

            jmp     .ed_l

        .return:
            mov     al, 0x00
            stosb

            mov     ah, 0x0e
            mov     al, 0x0d
            int         0x10

            mov     al, 0x0a
            int         0x10

            jmp     .ed_l
        .done:
            ret

        cli
        hlt

    ;   Strings
    start_msg:  db  "  EDitor v001 | ESC to exit",13,10, 0
