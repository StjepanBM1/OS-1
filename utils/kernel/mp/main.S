
        /*
                    Monitor Program for OS/1
                            (MP-OS/1)
                ================================

            Monitor Program for OS/1 or MP-OS/1 is a
            simple program that allows users to 
            "monitor" the system. Its main function
            is to let the user load and write data
            to the disk(s).

         */


            .code16
            .section    .text.mp
            .global     _input
            #.global     _monitor_program

        #
        #   _monitor_program    -   main program point.
        #                       -   takes user input
        #                           -   if it matches a command, then
        #                               execute it
        #                           -   if there is no match, then return
        #                               an error.
        #
        _input:
            mov     $_mp_prompt,    %si
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
            mov     $_mp_cmd_rebt,  %di
            call    _strcmp
            jc      _reboot

            mov     $_input_buffer, %si
            mov     $_mp_cmd_shutd,  %di
            call    _strcmp
            jc      _shutdown

            #
            #   Memory (mem. stat. , peek & poke)
            #
            mov     $_input_buffer, %si
            mov     $_mp_cmd_mem,   %di
            call    _strcmp
            jc      _mem

            #
            #   Load command(s)
            #
            mov     $_input_buffer, %si
            mov     $_mp_cmd_load_a,%di
            call    _strcmp
            jc      _loada

            mov     $_input_buffer, %si
            mov     $_mp_cmd_load_b,%di
            call    _strcmp
            jc      _loadb

            #
            #   Disk status
            #
            mov     $_input_buffer, %si
            mov     $_mp_cmd_dstat,  %di
            call    _strcmp
            jc      _dstat

            #
            #   Others (ver. and clear)
            #
            mov     $_input_buffer, %si
            mov     $_mp_cmd_clear,%di
            call    _strcmp
            jc      _clear

            mov     $_input_buffer, %si
            mov     $_mp_cmd_ver,%di
            call    _strcmp
            jc      _ver

            #
            #   Help command
            #
            mov     $_input_buffer, %si
            mov     $_mp_cmd_help,  %di
            call    _strcmp
            jc      _help

            #
            #   Pinboard enviroment
            #
            mov     $_input_buffer, %si
            mov     $_mp_cmd_pinb,  %di
            call    _strcmp
            jc      _penv

            #   Command not found? Return an "?"
            mov     $_input_buffer, %si
            call    _printk
            mov     $_mp_str_err,   %si
            call    _printk
            hlt

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

        _mem:
            xor     %ax,    %ax
            clc

            int     $0x12

            movw    %ax,    (regi)
            call    _preg

            mov     $_mp_str_mem,   %si
            call    _printk

            jmp     _input

        _ver:
            mov     $_mp_str_ver,   %si
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

        _loada:
            call     _load_A
            jmp     _input

        _loadb:
            call     _load_B
            jmp     _input

        _help:
            mov     $_mp_str_help,  %si
            call    _printk

            jmp     _input

        _penv:
            jmp     _pinb

            .section    .rodata.mp
        _mp_new_line:   .asciz  "\r\n"
        
        _mp_str_ver:    .asciz  "  Monitor Program for OS/1 (MP-OS/1) Version 1.0.0\r\n"
        _mp_str_mem:    .asciz  "KB of low memory free (in hex.)\r\n"
    
        _mp_prompt:     .asciz  "% "
        _mp_str_err:    .asciz  "?\r\n\n"

        _mp_str_help:   .asciz  "  List of commands:\r\n    - reboot\r\n    - shutdown\r\n    - mem\r\n    - dstat\r\n    - load a\r\n    - load b\r\n    - ver\r\n    - clear\r\n    - help\r\n"

            .section    .data

        #
        #   _input_buffer   -   stores user input (256-byte limit)
        #
        _input_buffer:  .fill   256,1,0

        .include    "mp/cmd.S"
