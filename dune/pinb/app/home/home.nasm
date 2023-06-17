
    _home_win:

        mov     ah,     0x02
        mov     dh,     0x02
        mov     dl,     0x01
        int             0x10

        mov     ah,     0x09
        mov     al,     0x20
        mov     bl,     0xf0
        mov     cx,     44
        int             0x10
        mov     si,     title_h0
        call    puts16

        mov     ah,     0x02
        mov     dh,     2
        mov     dl,     22
        int             0x10
        mov     si,     title_h1
        call    puts16

        mov     ah,     0x02
        mov     dh,     0x09
        mov     dl,     0x01
        int             0x10
        mov     ah,     0x09
        mov     al,     0xcd
        mov     bl,     0xf0
        mov     cx,     44
        int             0x10

        mov     ah,     0x02
        mov     dh,     0x02
        mov     dl,     0x01
        int             0x10
        .border1:
            mov ah,     0x02
            inc dh
            mov dl,     0x01
            int         0x10

            mov ah,     0x09
            mov al,     0xBA
            mov bl,     0xf0
            mov cx,     1
            int         0x10

            cmp dh,     9
            je  .after1

            jmp .border1

        .after1:
            mov     ah,     0x02
            mov     dh,     0x09
            mov     dl,     0x01
            int             0x10
            mov     ah,     0x09
            mov     al,     0xc8
            mov     bl,     0xf0
            mov     cx,     1
            int         0x10

            mov     ah,     0x02
            mov     dh,     0x02
            mov     dl,     0x01
            int             0x10

        .border2:
            mov     ah,     0x02
            inc     dh
            mov     dl,     44
            int             0x10

            mov     ah,     0x09
            mov     al,     0xba
            mov     bl,     0xf0
            mov     cx,     1
            int             0x10

            cmp dh,     9
            je  .after2

            jmp .border2

        .after2:
            mov     ah,     0x02
            mov     dh,     0x09
            mov     dl,     44
            int             0x10
            int             0x10
            mov     ah,     0x09
            mov     al,     0xbc
            mov     bl,     0xf0
            mov     cx,     1
            int             0x10

        .icons:
            .shell:
                mov     ah,     0x02
                mov     dh,     0x03
                mov     dl,     3
                int             0x10
                mov     si,     dos_1
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     3
                int             0x10
                mov     si,     dos_2
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     3
                int             0x10
                mov     si,     dos_3
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     3
                int             0x10
                mov     si,     dos_4
                call    puts16

            .paint:
                mov     ah,     0x02
                mov     dh,     0x03
                mov     dl,     11
                int             0x10
                mov     si,     pnt_1
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     11
                int             0x10
                mov     si,     pnt_2
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     11
                int             0x10
                mov     si,     pnt_3
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     11
                int             0x10
                mov     si,     pnt_4
                call    puts16

            .notes:
                mov     ah,     0x02
                mov     dh,     0x03
                mov     dl,     19
                int             0x10
                mov     si,     doc_1
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     19
                int             0x10
                mov     si,     doc_2
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     19
                int             0x10
                mov     si,     doc_3
                call    puts16
                mov     ah,     0x02
                inc     dh
                mov     dl,     19
                int             0x10
                mov     si,     doc_4
                call    puts16

        jmp     _home_curs

    ;*********************************
    %include "pinb/app/home/curs.nasm"
    %include "pinb/app/home/paint.nasm"
    %include "pinb/app/home/note.nasm"
    ;*********************************
    title_h0:   db  " ",0xb3,"X",0xb3, 0
    title_h1:   db  "Home", 0    

    msg0:       db  "No files found.", 0

    ;   Icons
    dos_1:  db  0xda,0xc4,0xc4,0xc4,0xc4,0xc4,0xbf,0
    dos_2:  db  0xb3,"#    ",0xb3,0
    dos_3:  db  0xc0,0xc4,0xc4,0xc4,0xc4,0xc4,0xd9,0
    dos_4:  db  " Shell", 0

    pnt_1:  db  0xda,0xc4,0xc4,0xc4,0xc4,0xc4,0xbf,0
    pnt_2:  db  0xb3,0xb0,0xb1,0xdb,0xcd,0xcd,0xb3,0
    pnt_3:  db  0xc0,0xc4,0xc4,0xc4,0xc4,0xc4,0xd9,0
    pnt_4:  db  " Paint", 0

    doc_1:  db  0xda,0xc4,0xc4,0xc4,0xc4,0xc4,0xbf,0
    doc_2:  db  0xb3,0xf0,0xf0,0xf0,0xf0,0xf0,0xb3,0
    doc_3:  db  0xc0,0xc4,0xc4,0xc4,0xc4,0xc4,0xd9,0
    doc_4:  db  " Notes", 0
