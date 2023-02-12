
    chos_creat:

        _creat_window:
            mov     ah, 2
            mov     dh, 12
            mov     dl, 3
            int         10h

            .creat_loop:

                mov ah, 2
                inc dh
                mov dl, 3
                int     10h

                mov ah, 09h
                mov al, 20h
                mov cx, 43d
                mov bl, 0xF0
                int     0x10
                
                cmp dh, 19+1
                je  .creat_after

                jmp .creat_loop

            .creat_after:

            mov     ah, 2
            mov     dh, 12
            mov     dl, 3
            int         10h

            mov     ah, 09h
            mov     al, 20h
            mov     cx, 43d
            mov     bl, 0x1F
            int         0x10

            mov     ah, 2
            mov     dh, 12
            mov     dl, 3
            int         10h

            mov     si, creat_title
            call        ui_puts

            mov     ah, 2
            mov     dh, 14
            mov     dl, 4
            int         10h
            mov     si, creat_item1
            call        ui_puts

            mov     ah, 2
            mov     dh, 15
            mov     dl, 4
            int         10h
            mov     si, creat_item2
            call        ui_puts

            mov     ah, 2
            mov     dh, 16
            mov     dl, 4
            int         10h
            mov     si, creat_item3
            call        ui_puts

            mov     ah, 2
            mov     dh, 17
            mov     dl, 4
            int         10h
            mov     si, creat_item4
            call        ui_puts

            mov     ah, 2
            mov     dh, 19
            mov     dl, 3
            int         10h
            mov     si, creat_prompt
            call        ui_puts

            _creat_get_in:
                mov     ah, 0x00
                int         0x16

                cmp     al, '4'
                je      _return_to_main2

                jmp     _creat_get_in

            _return_to_main2:
                mov     ah, 2
                mov     dh, 11
                mov     dl, 0
                int         10h

                .loop_return2:
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
                    je  _ui_main_window

                    jmp .loop_return2

    creat_title:     db  " [ OS/1 | Build ",BUILD," ] [ ",BOOTD,":Creativity ] ", 0
    creat_prompt:    db  " [ ",BOOTD,":Creativity ]",175, " ", 0

    ;   Items
    creat_item1:     db  " [1] Paint", 0
    creat_item2:     db  " [2] Temp-Write", 0
    creat_item3:     db  " [3] 2 (the game)", 0
    creat_item4:     db  " [4] Return", 0
