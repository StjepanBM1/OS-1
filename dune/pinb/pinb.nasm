
    pinb:
        _screen:
            mov     ax, 0x03
            int     0x10

            mov     ax, 1003
            mov     bx, 0x00
            int     0x10

            mov     ah, 0x11
            mov     al, 0x11
            int     0x10

            mov     ah, 0x01
            mov     cx, 0x10
            int     0x10

            mov     ah, 0x09
            mov     al, 0x20
            mov     bh, 0x00
            mov     bl, 0x7f
            mov     cx, 2240
            int     0x10

        _topb:
            mov     ah, 0x09
            mov     al, 0x20
            mov     bh, 0x00
            mov     bl, 0xf0
            mov     cx, 80
            int     0x10

            mov     si, _s_topb
            call    puts16

            mov     ah, 0x02
            mov     dh, 27
            mov     dl, 44
            int         0x10
            mov     si, _s_bott
            call    puts16

        _curs:
            call    _m_curs

        cli
        hlt

    %include "pinb/inc/strs.nasm"
    %include "pinb/curs.nasm"
    %include "pinb/topb.nasm"
    %include "pinb/app/home/home.nasm"
