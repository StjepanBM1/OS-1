
    _ui_main_window:

        clc

        int     0x12

        mov     [MEM], ax

        cli
        sti

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
        mov     bl, 0xE0
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
            mov dh, 2
            mov dl, 4
            int     10h

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

            mov ah, 2
            mov dh, 8
            mov dl, 4
            int     10h
            mov     si, item6
            call    ui_puts

            mov ah, 2
            mov dh, 9
            mov dl, 4
            int     10h
            mov     si, item7
            call    ui_puts

            mov ah, 2
            mov dh, 10
            mov dl, 4
            int     10h
            mov     si, item8
            call    ui_puts

            xor cx, cx

            mov ah, 2
            mov dh, 12
            mov dl, 4
            int     10h

            ;.ui_apps_loop:
                ;mov si, separator
                ;call    ui_puts

                ;inc     cx

                ;cmp cx, 72
                ;je  ui_prompt

                ;jmp .ui_apps_loop

            mov     ah, 2
            mov     dh, 13
            mov     dl, 4
            int     10h
            mov     ah, 09h
            mov     al, 20h
            mov     cx, 72d
            mov     bl, 0xE0
            int         0x10

            mov     ah, 2
            mov     dh, 12
            mov     dl, 0
            int     10h

            mov     ah, 09h
            mov     al, 177d
            mov     cx, 80d
            mov     bl, 0xF7
            int         0x10

            mov     ah, 2
            mov     dh, 13
            mov     dl, 4
            int         10h
            mov     si, ui_title2
            call        ui_puts

        ui_prompt:

            jmp     app_console

            ret

    ui_title:   db  "   [ OS/1 | Build ",BUILD," ] [ Drive : ",BOOTD," ] ", 0
    ui_title2:  db  "   [ OS/1 Console | Versions : ",PRG_VER," ] [ Memory : ",MEM," KB ]", 0
    prompt:     db  " [",BOOTD,"]",175," ", 0
    MEM:        db  0
