
    _notes:
        mov     ax, 0x03
        int     0x10

        mov     ax, 1003
        mov     bx, 0x00
        int     0x10

        mov     ah, 0x11
        mov     al, 0x11
        int     0x10

        mov     ah, 0x09
        mov     al, 0x20
        mov     bh, 0x00
        mov     bl, 0x1f
        mov     cx, 2240
        int     0x10

        mov     ah, 0x09
        mov     al, 0x20
        mov     bh, 0x00
        mov     bl, 0xf0
        mov     cx, 80
        int     0x10
        mov     si, title_n
        call    puts16

        mov     dh, 1

        .paper:
            cmp dh, 27
            je  _n_curs

            mov ah, 0x02
            inc dh
            mov dl, 0x00
            int     0x10

            mov ah, 0x09
            mov al, 0x20
            mov bh, 0x00
            mov bl, 0xf0
            mov cx, 80
            int     0x10

            jmp .paper
        
    _n_curs:
        xor cx, cx
        xor bx, bx

        mov ah, 0x01
        mov cx, 0x07
        int     0x10

        mov bl, 0x01
        mov cl, 0x02

        _nc_loop:
            mov ah, 0x02
            mov dh, cl
            mov dl, bl
            int     0x10

            mov ah, 0x00
            int     0x16

            cmp ah, 0x48
            je  _nc_up

            cmp ah, 0x50
            je  _nc_dw

            cmp ah, 0x4B
            je  _nc_lt

            cmp ah, 0x4D
            je  _nc_rt

            cmp al, 0x20
            je  _pc_cc

            cmp al, 'i'
            je  _insert

            jmp _nc_loop

        _nc_up:
            cmp cl, 0x00
            je  _nc_loop

            sub cl, 1
            jmp _nc_loop

        _nc_dw:
            cmp cl, 27
            je  _nc_loop

            add cl, 1
            jmp _nc_loop
            
        _nc_lt:
            cmp bl, 0x00
            je  _nc_loop

            sub bl, 1
            jmp _nc_loop
            
        _nc_rt:
            cmp bl, 79
            je  _nc_loop

            add bl, 1
            jmp _nc_loop
            
        _nc_cc:
            cmp dh, 0x00
            je  .topb
            jmp _nc_loop

            .topb:
                cmp dl, 0x01
                je  pinb

                jmp _nc_loop

        _insert:
            cmp dh, 0x01
            jg  .inserty

            jmp _nc_loop

            .inserty:
                cmp dl, 0x00
                jg  .insertyy

                jmp _nc_loop

                .insertyy:

                    mov ax, 0x00
                    int     0x16

                    cmp al, 0x1b
                    je  _nc_loop

                    cmp al, 0x08
                    je  .backsp

                    cmp al, 0x0d
                    je  .return

                    mov ah, 0x0e
                    int     0x10

                    jmp _insert

                        .backsp:
                            cmp bl, 0x00
                            jg  .inserty

                            mov ah, 0x0e
                            mov al, 0x08
                            int     0x10

                            mov al, ' '
                            int     0x10

                            mov al, 0x08
                            int     0x10

                            jmp     .inserty

                        .return:
                            cmp dh, 26+1
                            je  _notes

                            mov ah, 0x02
                            inc dh
                            mov dl, 0x01
                            int     0x10

                            jmp .inserty
        
        cli
        hlt

    ;*********************
    title_n:    db  0xb3,"X",0xb3," Notes 2.0.0 ",0xb3," Cannot save (no file sys.) ",0xb3, 0
