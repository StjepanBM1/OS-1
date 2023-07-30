
            .code16
            .section    .text.pinb.app
            .global     _shell

        _shell:
            mov     $0x03,  %ax
            int     $0x10

            #   Set pallete register
            mov     $0x1003,%ax
            mov     $0x00,  %bl
            int     $0x10

            #   Set up the font
            mov     $0x11,  %ah
            mov     $0x11,  %al
            int     $0x10

            _input:
                mov     $_sh_prompt,    %si
                call    _printk

                mov     $_input_buffer, %di
                call    _get_input

                mov     $_input_buffer, %si
                cmpb    $0x0000,        (%si)
                je      _input

                #
                #   Basics (reboot, shutdown)
                #
                mov     $_input_buffer, %si
                mov     $_sh_cmd_rebt,  %di
                call    _strcmp
                jc      _reboot

                mov     $_input_buffer, %si
                mov     $_sh_cmd_shutd,  %di
                call    _strcmp
                jc      _shutdown


                #
                #   Disk status
                #
                mov     $_input_buffer, %si
                mov     $_sh_cmd_dstat,  %di
                call    _strcmp
                jc      _dstat

                #
                #   Others (ver. and clear)
                #
                mov     $_input_buffer, %si
                mov     $_sh_cmd_clear,%di
                call    _strcmp
                jc      _clear

                mov     $_input_buffer, %si
                mov     $_sh_cmd_ver,%di
                call    _strcmp
                jc      _ver

                #
                #   Help command
                #
                mov     $_input_buffer, %si
                mov     $_sh_cmd_help,  %di
                call    _strcmp
                jc      _help

                #
                #   Exit command
                #
                mov     $_input_buffer, %si
                mov     $_sh_cmd_exit,  %di
                call    _strcmp
                jc      _exit

                #   Command not found? Return the err. msg.
                mov     $_sh_str_er1,   %si
                call    _printk
                mov     $_input_buffer, %si
                call    _printk
                mov     $_sh_str_er2,   %si
                call    _printk

                jmp     _input

        _get_input:
            xor     %cl,    %cl

            _get_input_l:
                mov     $0x00,      %ah
                int     $0x16

                cmp     $0x08,      %al
                je      _backspace

                cmp     $0x0d,      %al
                je      _returnk

                cmp     $0xff,      %cl
                je      _get_input_l

                mov     $0x0e,      %ah
                int     $0x10

                stosb
                inc     %cl
                jmp     _get_input_l

            _backspace:
                cmp     $0x00,      %cl
                je      _get_input_l

                dec     %di
                movb    $0x00,      (%di)
                dec     %cl

                mov     $0x0e,      %ah
                mov     $0x08,      %al
                int     $0x10

                mov     $0x20,      %al
                int     $0x10

                mov     $0x08,      %al
                int     $0x10

                jmp     _get_input_l

            _returnk:
                mov     $0x00,      %al
                stosb

                mov     $0x0e,      %ah
                mov     $0x0d,      %al
                int     $0x10

                mov     $0x0a,      %al
                int     $0x10

                ret
            
            #################################
            #           COMMANDS            #
            #################################
            _reboot:
                int     $0x19

            _shutdown:
                xor     %ax,    %ax
                xor     %bx,    %bx

                mov     $0x1000,%ax
                mov     %ss,    %ax
                mov     $0xf000,%sp
                mov     $0x5307,%ax
                mov     $0x0001,%bx
                mov     $0x0003,%cx
                int     $0x15

            _help:
                mov     $_sh_hlp_msg,   %si
                call    _printk

                jmp     _input

            _ver:
                mov     $_sh_ver_msg,   %si
                call    _printk

                jmp     _input

            _clear:
                mov     $0x03,  %ax
                int     $0x10

                #   Set pallete register
                mov     $0x1003,%ax
                mov     $0x00,  %bl
                int     $0x10

                #   Set up the font
                mov     $0x11,  %ah
                mov     $0x11,  %al
                int     $0x10

                jmp     _input

            _dstat:
                xor     %dx,    %dx
                xor     %ax,    %ax
                call    _disk_status
                jmp     _input

            _exit:
                jmp     _pinb

            .section    .rodata.pinb.app
        _sh_title:      .asciz  "==== OS/1 AR 5.0.0 ====\r\n"
        _sh_prompt:     .asciz  "> "

        _sh_ver_msg:    .asciz  "  Operating System/1 v5.0.0\r\n  DUNE kernel v2.00\r\n  Pinboard Enviroment - Shell v3.0.0\r\n"
        _sh_str_er1:    .asciz  "  Command ["
        _sh_str_er2:    .asciz  "] not found.\r\n"
        _sh_hlp_msg:    .asciz  "  List of commands:\r\n    - help\r\n    - ver\r\n    - reboot\r\n    - shutdown\r\n    - dstat\r\n    - clear\r\n    - exit\r\n"

            .section    .data
        _input_buffer:  .fill   64,1,0

        .include    "pinb/shell/cmd.S"
