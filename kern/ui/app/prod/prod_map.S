
    chos_prod:

        _prod_window:
            mov     ah, 2
            mov     dh, 12
            mov     dl, 3
            int         10h

            .prod_loop:

                mov ah, 2
                inc dh
                mov dl, 3
                int     10h

                mov ah, 09h
                mov al, 20h
                mov cx, 43d
                mov bl, 0xF0
                int     0x10
                
                cmp dh, 18+1
                je  .prod_after

                jmp .prod_loop

            .prod_after:

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
            mov     si, prod_title
            call        ui_puts

            mov     ah, 2
            mov     dh, 14
            mov     dl, 4
            int         10h
            mov     si, prod_item1
            call        ui_puts

            mov     ah, 2
            mov     dh, 15
            mov     dl, 4
            int         10h
            mov     si, prod_item2
            call        ui_puts

            mov     ah, 2
            mov     dh, 16
            mov     dl, 4
            int         10h
            mov     si, prod_item3
            call        ui_puts

            mov     ah, 2
            mov     dh, 18
            mov     dl, 3
            int         10h
            mov     si, prod_prompt
            call        ui_puts

            _prod_get_in:
                mov     ah, 0x00
                int         0x16

                cmp     al, '1'
                je      _app_console

                cmp     al, '2'
                je      _app_write

                cmp     al, '3'
                je      _return_to_main

                jmp     _prod_get_in

            _app_console:
                jmp     app_console

            _return_to_main:
                mov     ah, 2
                mov     dh, 11
                mov     dl, 0
                int         10h

                .loop_return:
                    mov ah, 2
                    inc dh
                    mov dl, 0
                    int     10h

                    mov	ah,	09h
                    mov	cx,	2000d
                    mov	al,	177d    ;   177d
                    mov	bl,	0xF8
                    int		0x10

                    cmp dh, 18+1
                    je  _ui_main_window

                    jmp .loop_return

    prod_title:     db  " [ OS/1 | Build ",BUILD," ] [ ",BOOTD,":Productivity ] ", 0
    prod_prompt:    db  " [ ",BOOTD,":Productivity ]",175, " ", 0

    ;   Items
    prod_item1:     db  " [1] Console", 0
    prod_item2:     db  " [2] Temp-Write", 0
    prod_item3:     db  " [3] Return", 0
