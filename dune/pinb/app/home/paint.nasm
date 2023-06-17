
    _paint:

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
        mov     si, title_p
        call    puts16

        inc     dh

        .canvas:
            cmp dh, 26
            je  _p_curs

            mov ah, 0x02
            inc dh
            mov dl, 0x01
            int     0x10

            mov ah, 0x09
            mov al, 0x20
            mov bh, 0x00
            mov bl, 0xf0
            mov cx, 78
            int     0x10

            jmp .canvas

        _p_curs:
            xor bx, bx
            xor cx, cx

            mov ah, 0x01
            mov cx, 0x07
            int     0x10

            mov bl, 0x01
            mov cl, 0x02

            _pc_loop:
                mov ah, 0x02
                mov dh, cl
                mov dl, bl
                int     0x10

                mov ah, 0x00
                int     0x16

                cmp ah, 0x48
                je      _pc_up

                cmp ah, 0x50
                je      _pc_dw

                cmp ah, 0x4B
                je      _pc_lt

                cmp ah, 0x4D
                je      _pc_rt

                cmp al, 0x20
                je      _pc_cc

                cmp al, 'p'
                je  _place

                cmp al, 'e'
                je  _erase

                cmp al, 'i'
                je  _textp

                cmp al, 0x30
                je      _place

                cmp al, 0x39
                je      _erase

                jmp _pc_loop

            _pc_up:
                cmp cl, 0x00
                je  _pc_loop

                sub cl, 1
                jmp _pc_loop

            _pc_dw:
                cmp cl, 27
                je  _pc_loop

                add cl, 1
                jmp _pc_loop

            _pc_lt:
                cmp bl, 0x00
                je  _pc_loop

                sub bl, 1
                jmp _pc_loop

            _pc_rt:
                cmp bl, 79
                je  _pc_loop

                add bl, 1
                jmp _pc_loop

            _pc_cc:
                cmp dh, 0x00
                je  .topb
                
                jmp _pc_loop

                .topb:
                    cmp dl, 0x01
                    je  pinb

                    jmp _pc_loop


            ;   Defs
            _place:
                cmp bl, 0x00
                jg  .placey

                .placey:
                    cmp cl, 0x00
                    jg  .placeyy

                    jmp _pc_loop

                    .placeyy:
                        mov ah, 0x0e
                        mov al, 219
                        int     0x10

                        jmp _pc_loop

                jmp _pc_loop

            _erase:
                cmp bl, 0x00
                jg  .erasey

                .erasey:
                    cmp cl, 0x00
                    jg  .eraseyy

                    jmp _pc_loop

                    .eraseyy:
                        mov ah, 0x0e
                        mov al, 0x20
                        int     0x10

                        jmp _pc_loop

                jmp _pc_loop
            _textp:
                mov ah, 0x00
                int     0x16

                cmp al, 27
                je  _pc_loop

                mov ah, 0x0e
                int     0x10

                jmp _textp


        cli
        hlt

    ;*********************
    title_p:    db  0xb3,"X",0xb3," Paint 3.0.0 - (Monochrome mode)", 0
