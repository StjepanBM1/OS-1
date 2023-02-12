
    app_chos:
        _main:
            mov ah, 2
            mov dh, 9
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

                cmp     al, '3'
                je      chos_prod

                cmp     al, '4'
                je      chos_creat

                cmp     al, '5'
                je      .app_credits

                jmp     .done_key

            .done_key:
                mov ah, 2
                mov dh, 9
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

            .app_credits:
                mov ah, 2
                mov dh, 16
                mov dl, 3
                int     10h

                .loop_cred:
                    mov ah, 2
                    inc dh
                    mov dl, 3
                    int     10h

                    mov ah, 09h
                    mov al, 20h
                    mov cx, 41d
                    mov bl, 0xF0
                    int     0x10

                    cmp dh, 22+1
                    je  .after_cred

                    jmp .loop_cred

                .after_cred:

                mov ah, 2
                mov dh, 16
                mov dl, 3
                int     10h

                mov ah, 09h
                mov al, 20h
                mov cx, 41d
                mov bl, 0x1F
                int     0x10

                mov ah, 2
                mov dh, 16
                mov dl, 3
                int     10h
                mov si, cred_title
                call    ui_puts

                mov ah, 2
                mov dh, 18
                mov dl, 3
                int     10h
                mov si, cred_str1
                call    ui_puts

                mov ah, 2
                mov dh, 19
                mov dl, 3
                int     10h
                mov si, cred_str2
                call    ui_puts

                mov ah, 2
                mov dh, 20
                mov dl, 3
                int     10h
                mov si, cred_str3
                call    ui_puts

                mov ah, 2
                mov dh, 22
                mov dl, 3
                int     10h
                mov si, cred_end
                call    ui_puts

                mov ah, 0x00
                int     0x16

                jmp     .done_cred

                .done_cred:
                    mov ah, 2
                    mov dh, 15
                    mov dl, 0
                    int     10h

                    .done_cred_loop:
                        mov ah, 2
                        inc dh
                        mov dl, 0
                        int     10h

                        mov ah, 09h
                        mov al, 177d
                        mov cx, 80d
                        mov bl, 0xF8
                        int     0x10

                        cmp dh, 22+1
                        je  .done_key

                        jmp .done_cred_loop

            .app_shutdown:

                mov     ah, 2
                mov     dh, 16
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
                mov     dh, 16
                mov     dl, 3
                int         10h
                mov     si, warn_title
                call        ui_puts

                mov     ah, 2
                mov     dh, 18
                mov     dl, 4
                int         10h
                mov     si, warn_str
                call        ui_puts

                mov     ah, 2
                mov     dh, 20
                mov     dl, 3
                int         10h
                mov     si, warn_yn
                call        ui_puts

                mov     ah, 0x00
                int         0x16

                cmp     al, 'y'
                je      .shutd

                cmp     al, 'n'
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
                        mov	bl,	0xF8
                        int		0x10

                        cmp dh, 19+1
                        je  ui_prompt

                        jmp .loop3

            .app_help:
                jmp     .done_key

            .done:
                jmp     .done_key

    ;   Screen items
    item1:      db  " (1) Reboot", 0
    item2:      db  " (2) Shutdown", 0

    item3:      db  " (3) Productivity",0   ;   calc, calendar & console
    item4:      db  " (4) Creativity", 0    ;   paint, temp-write, 9 (the game)  

    item5:      db  " [5] Credits", 0

    separator:  db  205, 0

    warn_title: db  " [ ! ]           [ Warning ]          [ ! ]", 0
    warn_str:   db  " This will exit OS/1 and shutdown the PC! ", 0
    warn_yn:    db  "                  [ Y / N ]", 0

    cred_title: db  " [ ",240," ]         [ Credits ]         [ ",240," ] ", 0
    cred_str1:  db  "   Main programmer :   Stjepan B. M.", 0
    cred_str2:  db  "   Console basis   :   OS-Dev wiki", 0
    cred_str3:  db  "   UI programmer   :   Stjepan B. M.", 0
    cred_end:   db  "     [ Press any key to exit... ] ", 0 
