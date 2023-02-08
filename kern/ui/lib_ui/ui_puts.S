
    ui_puts:
        lodsb
        or      al, al
        jz      .done

        mov     ah, 0x0e
        int         0x10

        jmp     ui_puts

        .done:
            ret
