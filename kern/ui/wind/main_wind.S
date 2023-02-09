
    _ui_main_window:

        mov     ah, 2
        mov     dh, 1
        mov     dl, 3
        int     10h
        mov     ah, 09h
        mov     al, 20h
        mov     cx, 74d
        mov     bl, 0xF0
        int         0x10

        mov     ah, 2
        mov     dh, 1
        mov     dl, 4
        int     10h
        mov     ah, 09h
        mov     al, 20h
        mov     cx, 72d
        mov     bl, 0x9F
        int         0x10

        mov     ah, 2
        mov     dh, 1
        mov     dl, 73d
        int         10h

        mov     ah, 2
        mov     dh, 1
        mov     dl, 4
        int         10h

        mov     si, ui_title
        call        ui_puts

        .ui_loop:

            mov ah, 2
            inc dh
            mov dl, 3
            int     10h
            mov     ah, 09h
            mov     al, 20h
            mov     cx, 74d
            mov     bl, 0xF0
            int         0x10

            cmp     dh, 22 + 1
            je      ui_items

            jmp     .ui_loop

        ui_items:
            mov ah, 2
            mov dh, 3
            mov dl, 4
            int     10h
            mov     si, item1
            call    ui_puts
            
            mov ah, 2
            mov dh, 4
            mov dl, 4
            int     10h
            mov     si, item2
            call    ui_puts

            mov ah, 2
            mov dh, 5
            mov dl, 4
            int     10h
            mov     si, item3
            call    ui_puts
            
            mov ah, 2
            mov dh, 6
            mov dl, 4
            int     10h            
            mov     si, item4
            call    ui_puts
            
            mov ah, 2
            mov dh, 7
            mov dl, 4
            int     10h
            mov     si, item5
            call    ui_puts

            jmp     ui_prompt

        ui_prompt:
            jmp     app_chos

            ret

    ui_title:   db  "   [ OS/1 | Build ",BUILD," ] [ Drive : (",BOOTD,") ] [ Program Handler : ",PRG_VER," ] ", 0
    prompt:     db  " [",BOOTD,"]",175," ", 0
