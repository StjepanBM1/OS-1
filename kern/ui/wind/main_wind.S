
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
            je      ui_prompt

            jmp     .ui_loop

        ui_prompt:
            mov     ah, 2
            mov     dh, 4
            mov     dl, 22

            mov     si, prompt
            call    ui_puts
            ret
            
    ui_title:   db  "  [ Program Handler ]  [ Boot Disk on the Drive ",175," ",BOOTD," ]  [ Build ",BUILD," ]", 0
    prompt:     db  " [",BOOTD,"]",175," ", 0
