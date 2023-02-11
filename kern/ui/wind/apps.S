
    app_chos:
        _main:
            mov ah, 2
            mov dh, 12
            mov dl, 3
            int     10h

            mov     si, prompt
            call        ui_puts

            .app_loop:
                mov     ah, 0x00
                int         0x16

                mov     ah, 0x0e
                int         0x10

                cmp     al, '1'
                je      .app_reboot

                cmp     al, '2'
                je      .app_shutdown

                jmp     .done_key

            .done_key:
                mov ah, 2
                mov dh, 12
                mov dl, 3
                int     10h

                mov ah, 09h
                mov al, 20h
                mov cx, 74d
                mov bl, 0xF0
                int     0x10

                jmp     ui_prompt

            .app_reboot:
                jmp     0x7e00

            .app_shutdown:

                mov     ah, 2
                mov     dh, 15
                mov     dl, 3
                int         10h

                mov ah, 09h
                mov al, 20h
                mov cx, 44d
                mov bl, 0x4F
                int     0x10

                .loop2:

                    mov ah, 2
                    inc dh
                    mov dl, 3
                    int     10h

                    mov ah, 09h
                    mov al, 20h
                    mov cx, 44d
                    mov bl, 0xF0
                    int     0x10

                    cmp dh, 19 + 1
                    je  .after2

                    jmp .loop2

                .after2:

                mov     ah, 2
                mov     dh, 15
                mov     dl, 3
                int         10h
                mov     si, warn_title
                call        ui_puts

                mov     ah, 2
                mov     dh, 17
                mov     dl, 4
                int         10h
                mov     si, warn_str
                call        ui_puts

                mov     ah, 2
                mov     dh, 19
                mov     dl, 3
                int         10h
                mov     si, warn_yn
                call        ui_puts

                mov     ah, 0x00
                int         0x16

                cmp     al, 121d
                je      .shutd

                cmp     al, 110d
                je      .after_shutd

                jmp    .after2

                .shutd:
                    xor ax, ax
                    xor bx, bx
                    xor cx, cx

                    mov ax, 0x1000
                    mov ax, ss
                    mov sp, 0xf000
                    mov ax, 0x5307
                    mov bx, 0x0001
                    mov cx, 0x0003
                    int 0x15

                .after_shutd:
                    mov ah, 2
                    mov dh, 14
                    mov dl, 0
                    int     10h

                    .loop3:
                        mov ah, 2
                        inc dh
                        mov dl, 0
                        int     10h

                        mov	ah,	09h
                        mov	cx,	2000d
                        mov	al,	177d    ;   177d
                        mov	bl,	0x17
                        int		0x10

                        cmp dh, 19+1
                        je  ui_prompt

                        jmp .loop3

            .done:
                jmp     ui_prompt

                ret

    ;   Screen items
    item1:      db  " [1] Reboot", 0
    item2:      db  " [2] Shutdown", 0

    item3:      db  " [3] Calculator", 0
    item4:      db  " [4] Console", 0
    item5:      db  " [5] Calendar", 0

    item6:      db  " [6] Paint", 0
    item7:      db  " [7] Temp-Write", 0

    item8:      db  " [8] Help", 0

    separator:  db  205, 0

    warn_title: db  " [ ! ]           [ Warning ]          [ ! ]", 0
    warn_str:   db  " This will exit OS/1 and shutdown the PC! ", 0
    warn_yn:    db  "                 [ Y / N ]", 0
