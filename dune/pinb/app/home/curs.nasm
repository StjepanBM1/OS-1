
    _home_curs:
        mov     cl,     2
        mov     bl,     3

        _hc_loop:
            mov ah,     0x02
            mov dh,     cl
            mov dl,     bl
            int         0x10

            mov ah,     0x00
            int         0x16

            cmp ah,     0x48
            je          _up

            cmp ah,     0x50
            je          _dw

            cmp ah,     0x4b
            je          _lt

            cmp ah,     0x4d
            je          _rt

            cmp al,     0x20
            je          _cc

            jmp _hc_loop

            _up:
                cmp cl, 0x00
                je  _hc_loop

                sub cl, 1
                jmp _hc_loop

            _dw:
                cmp cl, 27
                je  _hc_loop

                add cl, 1
                jmp _hc_loop

            _lt:
                cmp bl, 0x00
                je  _hc_loop

                sub bl, 1
                jmp _hc_loop

            _rt:
                cmp bl, 79
                je  _hc_loop

                add bl, 1
                jmp _hc_loop

            _cc:
                cmp dh, 2
                je  .retu

                cmp dl,  3
                je  .shell
                cmp dl,  4
                je  .shell
                cmp dl,  5
                je  .shell
                cmp dl,  6
                je  .shell
                cmp dl,  7
                je  .shell
                cmp dl,  8
                je  .shell
                cmp dl,  9
                je  .shell

                cmp dl, 11
                je  .paint
                cmp dl, 12
                je  .paint
                cmp dl, 13
                je  .paint
                cmp dl, 14
                je  .paint
                cmp dl, 15
                je  .paint
                cmp dl, 16
                je  .paint
                cmp dl, 17
                je  .paint

                cmp dl, 19
                je  .note
                cmp dl, 20
                je  .note
                cmp dl, 21
                je  .note
                cmp dl, 22
                je  .note
                cmp dl, 23
                je  .note
                cmp dl, 24
                je  .note
                cmp dl, 25
                je  .note

                jmp _hc_loop

                .shell:
                    cmp dh, 3
                    je  _start
                    cmp dh, 4
                    je  _start
                    cmp dh, 5
                    je  _start
                    cmp dh, 6
                    je  _start

                    jmp _hc_loop

                .paint:
                    cmp dh, 3
                    je  _paint
                    cmp dh, 4
                    je  _paint
                    cmp dh, 5
                    je  _paint
                    cmp dh, 6
                    je  _paint

                    jmp _hc_loop

                .note:
                    cmp dh, 3
                    je  _notes
                    cmp dh, 4
                    je  _notes
                    cmp dh, 5
                    je  _notes
                    cmp dh, 6
                    je  _notes

                    jmp _hc_loop

                .retu:
                    cmp dl, 3
                    je  pinb

                    jmp _hc_loop
