
    app_chos:
        _main:
            mov ah, 2
            mov dh, 23
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

                jmp     .done

            .app_reboot:
                jmp     0x7e00

            .done:
                jmp     _main

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
