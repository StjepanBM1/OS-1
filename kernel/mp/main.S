
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
            .extern     _entry
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

            #
            #   kernel panic
            #
            mov     $_input_buffer, %si
            mov     $_mp_cmd_die,  %di
            call    _strcmp
            jc      _die

            #
            #   BBFS
            #
            mov     $_input_buffer, %si
            mov     $_mp_cmd_bbfs,  %di
            call    _strcmp
            jc      _bbfs

            mov     $_input_buffer, %si
            mov     $_mp_cmd_ram1,  %di
            call    _strcmp
            jc      _ram_read_1

            mov     $_input_buffer, %si
            mov     $_mp_cmd_ram2,  %di
            call    _strcmp
            jc      _ram_read_2

            mov     $_input_buffer, %si
            mov     $_mp_cmd_ram3,  %di
            call    _strcmp
            jc      _ram_read_3

            mov     $_input_buffer, %si
            mov     $_mp_cmd_ram4,  %di
            call    _strcmp
            jc      _ram_read_4

            mov     $_input_buffer, %si
            mov     $_mp_cmd_ram5,  %di
            call    _strcmp
            jc      _ram_read_5

            mov     $_input_buffer, %si
            mov     $_mp_cmd_rexe,  %di
            call    _strcmp
            jc      _ram_exec

            #   Command not found? Return an "?"
            mov     $_input_buffer, %si
            call    _printk
            mov     $_mp_str_err,   %si
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
            jmp     $0xFFFFF,   $0

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
            mov     $_mp_str_mem,   %si
            call    _printk

            xor     %ax,    %ax
            clc

            int     $0x12

            movw    %ax,    (regi)
            call    _preg

            call    _returnk

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

        _die:
            jmp     _panic

        _bbfs:
            call    _bbfs_print_info

            jmp     _input

        _help:
            mov     $_mp_str_help,  %si
            call    _printk

            jmp     _input

        _ram_read_1:
            mov     $0x01,  %ax
            mov     $512,   %cx
            call    _bbfs_read_ram_block
            jmp     _input

        _ram_read_2:
            mov     $0x02,  %ax
            mov     $512,   %cx
            call    _bbfs_read_ram_block
            jmp     _input

        _ram_read_3:
            mov     $0x03,  %ax
            mov     $512,   %cx
            call    _bbfs_read_ram_block
            jmp     _input

        _ram_read_4:
            mov     $0x04,  %ax
            mov     $512,   %cx
            call    _bbfs_read_ram_block
            jmp     _input

        _ram_read_5:
            mov     $0x05,  %ax
            mov     $512,   %cx
            call    _bbfs_read_ram_block
            jmp     _input

        _ram_exec:
            jmp     _bbfs_ram_exec

        _penv:
            jmp     _pinb

            .section    .rodata.mp

        _mp_new_line:   .asciz  "\r\n"
        
        _mp_str_ver:    .asciz  "\tMonitor Program for OS/1 (MP-OS/1) Version 1.3.0\r\n"
        _mp_str_mem:    .asciz  "\tKB of low memory (in hex.): "
    
        _mp_prompt:     .asciz  "% "
        _mp_str_err:    .asciz  "?\r\n\n"

        _mp_str_help:   .ascii  "\tList of commands:\r\n"
                        .ascii  "\t\t- reboot\r\n\t\t- shutdown\r\n"
                        .ascii  "\t\t- mem\r\n\t\t- dstat\r\n"
                        .ascii  "\t\t- load a\r\n\t\t- load b\r\n"
                        .ascii  "\t\t- ver\r\n\t\t- clear\r\n"
                        .ascii  "\t\t- die\r\n\t\t- bbfs\r\n"
                        .ascii  "\t\t- pinb\r\n"
                        .ascii  "\t\t- ram read 1/2/3/4/5\r\n"
                        .ascii  "\t\t- ram exec\r\n"
                        .asciz  "\t\t- help\r\n"

            .section    .data
        .include    "./kernel/mp/cmd.S"

        #
        #   _input_buffer   -   stores user input (3254-byte limit)
        #   0xAC00 - 0x7c00 -> 0x3000
        #   First block should be @ 0x3000, alter the size of
        #   input buffer as needed.
        _input_buffer:  .fill   256, 1, 0

