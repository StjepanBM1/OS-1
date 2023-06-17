
    _m_curs:
        mov     ah, 0x01
        mov     cx, 0x10
        int         0x10

        mov     cl, 12
        mov     bl, 40

        _l_curs:
            mov ah, 0x02
            mov dh, cl
            mov dl, bl
            int     0x10

            mov ah, 0x00
            int     0x16

            cmp ah, 0x48
            je      _c_up
            
            cmp ah, 0x50
            je      _c_dw
            
            cmp ah, 0x4B
            je      _c_lt

            cmp ah, 0x4D
            je      _c_rt

            cmp al, 0x20
            je      _c_cc

            jmp     _l_curs

        _c_up:
            cmp     cl, 0
            je      _l_curs

            sub     cl, 1
            jmp     _l_curs

        _c_dw:
            cmp     cl, 27
            je      _l_curs

            add     cl, 1
            jmp     _l_curs

        _c_lt:
            cmp     bl, 00
            je      _l_curs

            sub     bl, 1
            jmp     _l_curs

        _c_rt:
            cmp     bl, 79
            je      _l_curs

            add     bl, 1
            jmp     _l_curs

        _c_cc:
            cmp     cl, 0x00
            je      _top_b
            
            jmp     _l_curs
