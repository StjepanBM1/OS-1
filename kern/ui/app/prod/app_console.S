
    app_console:

        call    clear
        call    c_backg

        clc
        xor     ax, ax

        mov     [MEM], ax

        cli
        sti

        mov     ah, 2
        mov     dh, 1
        mov     dl, 3
        int         10h
        mov     ah, 09h
        mov     al, 20h
        mov     cx, 74d
        mov     bl, 0xF0
        int         0x10

        mov     ah, 2
        mov     dh, 1
        mov     dl, 4
        int     0x10
        mov     ah, 09h
        mov     al, 20h
        mov     cx, 72d
        mov     bl, 0x1F
        int         0x10

        mov     ah, 2
        mov     dh, 1
        mov     dl, 73d
        int         10h

        mov     ah, 2
        mov     dh, 1
        mov     dl, 5
        int         10h

        mov     si, c_title
        call        ui_puts

        .c_loop_bg:
            mov ah, 2
            inc dh
            mov dl, 3
            int     10h

            mov ah, 09h
            mov al, 20h
            mov cx, 74d
            mov bl, 0xF0
            int     0x10

            cmp dh, 22+1
            je  .c_after

            jmp .c_loop_bg

        .c_after:
            mov ah, 2
            mov dh, 2
            mov dl, 5
            int     10h

            mov si, c_wlc_str
            call    ui_puts

            mov ah, 2
            inc dh
            mov dl, 3
            int     10h

        .c_input:
            mov ax, 0
            mov ds, ax
            mov es, ax
            mov ss, ax
            mov sp, 0x7e00

            clc

            mov si, c_prompt
            call    ui_puts

            mov di, c_buffer
            call    get_str

            mov si, c_buffer
            cmp byte [si], 0
            je  .c_input

            mov si, c_buffer
            mov di, cmd_ver
            call    strcmp
            jc  .os_ver

            mov si, c_buffer
            mov di, cmd_mem
            call    strcmp
            jc  .os_mem

            mov si, c_buffer
            mov di, cmd_cls
            call    strcmp
            jc  .os_cls

            mov si, c_buffer
            mov di, cmd_exit
            call    strcmp
            jc  .os_exit

            jmp .os_err

            .os_exit:
                jmp _ui_main

            .os_cls:
                jmp app_console

            .os_mem:
                mov si, str_mem
                call    ui_puts

                mov ah, 2
                inc dh
                mov dl, 3
                int     10h
                jmp .c_input

            .os_ver:

                mov si, str_ver
                call    ui_puts

                mov ah, 2
                inc dh
                mov dl, 3
                int     10h
                jmp .c_input

            .os_err:
                mov si, str_err
                call    ui_puts
                
                mov ah, 2
                inc dh
                mov dl, 3
                int     10h
                jmp .c_input

        jmp     $

    %include "ui/app/prod/console.lib"
