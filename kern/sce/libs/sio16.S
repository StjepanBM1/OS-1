
    .section    .text
    .global     sys_str_out
    .global     sys_key_wait_reb
    .global     sce_console
    .code16

        #
        #   sys_str_out -> print string function
        #   ------------------------------------
        #   In  :   SI      (.ascii / .asciz)
        #   Out :   None    (on screen text)
        #
        sys_str_out:
            .sys_str_out_loop:
                lodsb
                or      %al,    %al
                jz      .sys_str_out_done

                mov     $0x0e,  %ah
                mov     $0x00,  %bh
                int     $0x10

                jmp     .sys_str_out_loop
            
            .sys_str_out_done:
                ret

        #
        #   sys_key_wait_reb -> reboots the system 
        #                       after a key press
        #   --------------------------------------
        #   In  :   Key press
        #   Out :   None
        #
        sys_key_wait_reb:
            mov     $0x00,  %ah
            int     $0x16
            int     $0x19

        #   *****************************************
        #       Console main func.
        #   *****************************************
        sce_console:
            cmpb    $255,       stack
            je      .stck_full

            mov     $sce_pmpt,  %si
            call    sys_str_out

            mov     $0x00,      %ah
            int     $0x16

            cmpb    %al,        cmd_hlp
            je      .help

            cmpb    %al,        cmd_ret
            je      .return

            cmpb    %al,        cmd_nln
            je      .newline

            cmpb    %al,        cmd_ver
            je      .ver

            cmpb    %al,        cmd_cls
            je      .clear_s

            cmpb    %al,        cmd_add
            je      .add_stck

            cmpb    %al,        cmd_sub
            je      .sub_stck

            cmpb    %al,        cmd_dmp
            je      .dumps

            cmpb    %al,        cmd_new
            je      .news

            mov     $err,       %si
            call    sys_str_out

            stosb
            jmp     sce_console

            #   Commands
            .help:
                mov     $0x0e,      %ah
                int     $0x10

                mov     $str_hlp,  %si
                call    sys_str_out

                jmp sce_console
            
            .return:
                mov     $0x0e,      %ah
                int     $0x10
                int     $0x19

            .newline:
                mov     $0x0e,      %ah
                int     $0x10

                mov     $str_nl,    %si
                call    sys_str_out

                jmp sce_console

            .ver:
                mov     $0x0e,      %ah
                int     $0x10

                mov     $str_ver,   %si
                call    sys_str_out

                jmp sce_console

            .clear_s:
                jmp sce16

            .add_stck:
                mov     $0x0e,      %ah
                int     $0x10

                #mov     $str_add,   %si
                #call    sys_str_out

                addb    $1,         stack

                jmp     sce_console

            .sub_stck:
                mov     $0x0e,      %ah
                int     $0x10

                subb    $1,         stack

                #mov     $str_sub,   %si
                #call    sys_str_out

                jmp     sce_console

            .dumps:
                mov     $0x0e,      %ah
                int     $0x10

                mov     $str_d1,    %si
                call    sys_str_out

                mov     $stack,     %si
                call    sys_str_out

                mov     $str_d2,    %si
                call    sys_str_out

                jmp     sce_console

            .news:
                mov     $0x0e,      %ah
                int     $0x10

                mov     $str_new,   %si
                call    sys_str_out

                andb    $0,         stack

                jmp     sce_console

            .stck_full:

                mov     $str_fll,   %si
                call    sys_str_out

                mov     $0x00,      %ah
                int     $0x16

                jmp     .news

    .section    .data

        stack:      .int    0

    .section    .rodata
        #   Output strings
        str_hlp:    .asciz  "\r\n   Stack Commands :\r\n    ? = help\r\n    < = reboot\r\n    % = dump stack\r\n    ! = new stack\r\n    \\ = version\r\n    # = new line\r\n    + = add\r\n    - = subtract\r\n    $ = clear screen\r\n"
        str_nl:     .asciz  "\r\n"
        str_ver:    .asciz  "\r\n   SCE Operating System [1.0.0]\r\n"
        str_new:    .asciz  "\r\n [ Stack cleared & reinitalized ]\r\n"

        str_d1:     .asciz  "\r\n [ Stack dump (as a char.) : "
        str_d2:     .asciz  " ] \r\n"
        
        str_fll:    .asciz  "\r\n   [!!] STACK FULL [!!]\r\n   Press any key to reset the stack..."

        err:        .asciz  "\r\n   [ Unknow stack command...] \r\n"

        #   Commands (one character)
        cmd_hlp:    .byte   '?'
        cmd_ret:    .byte   '<'
        cmd_dmp:    .byte   '%'
        cmd_new:    .byte   '!'
        cmd_ver:    .byte   '\\'
        cmd_nln:    .byte   '#'
        cmd_add:    .byte   '+'
        cmd_sub:    .byte   '-'
        cmd_cls:    .byte   '$'

        #   Other strings
        sce_pmpt:   .asciz  " : "
