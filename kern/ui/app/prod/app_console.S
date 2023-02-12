
    app_console:
        cli
        sti

        mov     ah, 2
        mov     dl, 3
        mov     dh, 13
        int         10h

        mov     ax, 0
        mov     ds, ax
        mov     es, ax
        mov     ss, ax
        mov     sp, 0x7e00

        .app_console_loop:

            mov     ah, 2
            mov     dl, 4
            inc     dh
            int         10h

            mov     si, c_prompt
            call        cons_puts

            mov     di, c_buffer
            call        get_str

            mov     si, c_buffer
            cmp     byte [si], 0
            je      .app_console_loop

            mov     si, c_buffer
            mov     di, cmd_ver
            call    strcmp
            jc      .ver

            mov     ah, 2
            mov     dl, 4
            inc     dh
            int         10h
            mov     si, str_err
            call    cons_puts

            jmp     .app_console_loop

        .ver:
            mov     ah, 2
            mov     dl, 4
            inc     dh
            int         10h

            mov     si, str_ver
            call    cons_puts

            jmp     .app_console_loop

    %include "ui/app/prod/console.lib"
