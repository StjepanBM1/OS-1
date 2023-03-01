
    section .text
    bits    16
    global  console
    extern  ui_puts16
    extern  ui_clear
    extern  ui_screen
    extern  pre_prog
    extern  mainprg
    extern  sce16
    extern  DEVB
    extern  paint16
    extern  type16

        console:

            call    console_wind
            call    console_io

            cli
            hlt

        console_wind:

            mov     ah, 2
            mov     dh, 0
            mov     dl, 40
            int         10h

            mov ah, 0x09
            mov cx, 40d
            mov al, 32d
            mov bl, 0x1F
            int     0x10

            mov     ah, 2
            mov     dh, 0
            mov     dl, 40
            int         10h

            .console_sep:
                mov ah, 2
                inc dh
                mov dl, 40
                int     10h

                mov ah, 0x09
                mov cx, 1d
                mov al, 179d
                mov bl, 0xF0
                int     0x10

                cmp dh, 27+1
                je  .console_sep_d

                jmp     .console_sep

            .console_sep_d:
                mov     ah, 2
                mov     dh, 0
                mov     dl, 41
                int         10h

            console_win_l:

                mov ah, 2
                inc dh
                mov dl, 41
                int     10h

                mov ah, 0x09
                mov cx, 39d
                mov al, 32d
                mov bl, 0xF0
                int     0x10

                cmp dh, 27+1
                je  .console_win_d

                jmp     console_win_l

            .console_win_d:
                mov     ah, 2
                mov     dh, 0
                mov     dl, 40
                int         10h

                mov     si, console_title
                call    ui_puts16

            ret
        console_io:
            mov     ah, 2
            add     dh, 1
            mov     dl, 41
            int         10h

            .loop3:
                mov     si, console_prmpt
                call        ui_puts16

                mov     di, buffer
                call    get_str

                mov     si, buffer
                cmp     byte [si],  0
                je      .loop3

                mov     si, buffer
                mov     di, cmd_test
                call    strcmp_con
                jc      .tests

                mov     si, buffer
                mov     di, cmd_ver
                call    strcmp_con
                jc      .ver

                mov     si, buffer
                mov     di, cmd_logout
                call    strcmp_con
                jc      .logout

                mov     si, buffer
                mov     di, cmd_reboot
                call    strcmp_con
                jc      .reboot

                mov     si, buffer
                mov     di, cmd_exit
                call    strcmp_con
                jc      .exit

                mov     si, buffer
                mov     di, cmd_shutd
                call    strcmp_con
                jc      .shutdown

                mov     si, buffer
                mov     di, cmd_gsce
                call    strcmp_con
                jc      .gsce

                mov     si, buffer
                mov     di, cmd_clear
                call    strcmp_con
                jc      .clear
                
                mov     si, buffer
                mov     di, cmd_help
                call    strcmp_con
                jc      .help

                mov     si, buffer
                mov     di, cmd_typew
                call    strcmp_con
                jc      .type

                mov     si, buffer
                mov     di, cmd_paint
                call    strcmp_con
                jc      .paint

                mov     si, err_str
                call    ui_puts16
                mov     ah, 2
                add     dh, 1
                mov     dl, 41
                int     10h
                
                jmp     .loop3

            .type:
                jmp     type16
            .paint:
                jmp     paint16
    
            .help:
                mov     si, str_help_0
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_1
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_2
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_3
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_4
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_5
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_6
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_7
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_8
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_9
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_A
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10
                mov     si, str_help_B
                call    ui_puts16

                cmp dh, 26+1
                je  console

                mov     ah, 0x02
                inc     dh
                mov     dl, 41
                int         0x10

                cmp dh, 26+1
                je  console

                jmp     .loop3

            .clear:
                jmp     console
            .gsce:
                mov     si, str_gosce
                call    ui_puts16

                .inpt_l:
                    mov     ah, 0x00
                    int     0x16

                    cmp     al, 121d
                    je      .yes

                    cmp     al, 110d
                    je      .no

                    jmp     .inpt_l

                .yes:
                    mov ah, 0x0e
                    int     0x10

                    jmp     sce16

                .no:
                    mov ah, 0x0e
                    int     0x10
                
                    mov ah, 2
                    add dh, 1
                    mov dl, 41
                    int     10h
                    
                    jmp     .loop3

            .shutdown:
                xor     bx, bx
                mov     ax, 0x1000
                mov     ax, ss
                mov     sp, 0xf000
                mov     ax, 0x5307
                mov     bx, 0x0001
                mov     cx, 0x0003
                int         0x15

            .exit:
                jmp     mainprg
            
            .reboot:
                int     0x19

            .logout:
                call    ui_screen

                jmp     pre_prog

            .ver:
                mov si, str_ver
                call    ui_puts16

                mov ah, 2
                add dh, 1
                mov dl, 41
                int     10h

                jmp     .loop3

            .tests:
                mov si, str_test
                call    ui_puts16

                mov ah, 2
                add dh, 1
                mov dl, 41
                int     10h

                jmp     .loop3

        get_str:
            xor     cl, cl
            .get_str_l:
                mov ah, 0x00
                int     0x16

                cmp al, 0x08
                je  .backspace

                cmp al, 0x0D
                je  .newline

                cmp cl, 0x3F
                je  .get_str_l

                mov ah, 0x0e
                int     0x10

                stosb
                inc cl
                jmp .get_str_l

            .backspace:
                cmp cl, 0x00
                je  .get_str_l

                dec di
                mov byte [di], 0
                dec cl

                mov ah, 0x0e
                mov al, 0x08
                int     0x10

                mov al, ' '
                int     0x10

                mov al, 0x08
                int     0x10

                jmp     .get_str_l

            .newline:
                cmp dh, 26+1
                je  console
                
                mov al, 0
                stosb

                mov ah, 2
                add dh, 1
                mov dl, 41
                int     10h


                ret

        strcmp_con:
            .strcmp_loop:
                mov     al, [si]
                mov     bl, [di]
                cmp     al, bl
                jne     .strcmp_notq

                cmp     al, 0
                je      .strcmp_done

                inc     di
                inc     si
                jmp     .strcmp_loop

            .strcmp_notq:
                clc
                ret

            .strcmp_done:
                stc
                ret


        buffer:         times   64 db  0
        sects:          db  0
    section     .rodata
        console_title:  db  " [ OS/1 Console 2.0.0 ][ 'help' = help ] ", 0
        console_prmpt:  db  "# ", 0
        str_test:       db  " test", 0
        str_gosce:      db  " Are you sure? (y/n) ", 0
        str_ver:        db  " OS/1 2.0.0 | Console 2.0.0 ", 0
        err_str:        db  " ! Bad / unknow command, check 'help'", 0

        ;   Help command
        str_help_0:     db  " Commands :", 0
        str_help_1:     db  "  test  = test command", 0
        str_help_2:     db  "  help  = lists of commands", 0
        str_help_3:     db  "  clear = clears the terminal display", 0
        str_help_4:     db  "  ver   = displays the version number", 0
        str_help_5:     db  "  exit  = exit the console", 0
        str_help_6:     db  "  shutdown = power off", 0
        str_help_7:     db  "  reboot = reboot the PC", 0
        str_help_8:     db  "  logout = logout of the account", 0
        str_help_9:     db  "  go sce = enter SCE system", 0
        str_help_A:     db  "  paint = load Paint program", 0
        str_help_B:     db  "  write = load Write program", 0

        ;   Commands
        cmd_test:       db  "test", 0       ;   done
        cmd_help:       db  "help", 0       ;   done
        cmd_clear:      db  "clear",0       ;   done
        cmd_ver:        db  "ver",  0       ;   done
        cmd_exit:       db  "exit", 0       ;   done
        cmd_shutd:      db  "shutdown", 0   ;   done
        cmd_reboot:     db  "reboot",   0   ;   done
        cmd_logout:     db  "logout",   0   ;   done
        cmd_gsce:       db  "go sce", 0     ;   done
        cmd_paint:      db  "paint", 0      ;   done
        cmd_typew:      db  "write", 0      ;   done
