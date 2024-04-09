
        .code16
        .global     _cmd_parser
        .section    .text

    _cmd_parser:
        mov     $_buffer,   %si
        mov     $_command,  %di

        #   copy the _buffer until
        #   you encounter a " " char.
        _get_cmd:
            movb    (%si),  %al

            cmp     $0x00,  %al
            je      _get_args

            cmp     $0x20,  %al
            je      _get_args

            movb    %al,    (%di)

            inc     %si
            inc     %di

            jmp     _get_cmd

        #   save everything after " "
        #   in _arguments
        _get_args:
            inc     %si
            mov     %si,    %bx
            mov     $_arguments,%di

            _arg_loop:
                movb    (%si),  %al
                
                cmp     $0x00,  %al
                je      _arg_done

                movb    %al,    (%di)

                inc     %si
                inc     %di

                jmp     _arg_loop

            _arg_done:
                movb    $0x00,  (%di)
                movb    $0x00,  1(%di)

        #   compare _buffer to the
        #   list of commands. If
        #   the _buffer is match
        #   with the commands then
        #   execute the command

        #   reboot
        mov     $_command,%si
        mov     $_mp_cmd_reboot,%di
        call    _strcmp
        jc      _reboot

        #   shutdown
        mov     $_command,%si
        mov     $_mp_cmd_shutdown,%di
        call    _strcmp
        jc      _shutdown

        #   echo
        mov     $_command,%si
        mov     $_mp_cmd_echo,%di
        call    _strcmp
        jc      _echo

        #   clear
        mov     $_command,%si
        mov     $_mp_cmd_clear,%di
        call    _strcmp
        jc      _clear

        #   comment
        mov     $_command,%si
        mov     $_mp_cmd_rem,%di
        call    _strcmp
        jc      _comment

        #   ver
        mov     $_command,%si
        mov     $_mp_cmd_ver,%di
        call    _strcmp
        jc      _ver

        #   ls
        mov     $_command,%si
        mov     $_mp_cmd_ls,%di
        call    _strcmp
        jc      _ls_dir

        #   rm
        mov     $_command,%si
        mov     $_mp_cmd_rm,%di
        call    _strcmp
        jc      _rm_pre

        #   mk
        mov     $_command,%si
        mov     $_mp_cmd_mk,%di
        call    _strcmp
        jc      _mk_pre

        #   disk a
        mov     $_command,%si
        mov     $_mp_cmd_disk_a,%di
        call    _strcmp
        jc      _disk_a

        #   disk b
        mov     $_command,%si
        mov     $_mp_cmd_disk_b,%di
        call    _strcmp
        jc      _disk_b

        #   format
        mov     $_command,%si
        mov     $_mp_cmd_format,%di
        call    _strcmp
        jc      _format_pre

        #   td
        mov     $_command,%si
        mov     $_mp_cmd_td,%di
        call    _strcmp
        jc      _td

        #   in the case that the
        #   user input doesn't
        #   match any of the
        #   commands, try to load
        #   the file of the same name
        mov     $_command,  %si
        movb    (_cur_drive),%dl
        call    _find_file
        jc      _go_to_handler
        jnc      _nothing

        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer

        ret

    _nothing:
        #   and if that fails
        #   return an error msg.
        mov     $_no_cmd,   %si
        call    _printk

        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer

        ret

    _go_to_handler:
        mov     $_command, %si
        call    _handle_file

        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer

        ret

    #
    #   Commands  built in
    #

    #   reboot
    _reboot:
        jmp     $0xFFFFF,$0

    #   shutdown
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

    #   echo
    _echo:
        mov     $_arguments,%si
        call    _printk

        mov     $_new_line, %si
        call    _printk

        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer

        ret
    
    #   clear
    _clear:
        #   clear scr.
        mov     $0x03,      %ax
        int     $0x10

        #   Set pallete register
        mov     $0x1003,    %ax
        mov     $0x00,      %bl
        int     $0x10

        #   Set up the font
        mov     $0x11,      %ah
        mov     $0x11,      %al
        int     $0x10

        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer

        jmp     _mp

    #   comment
    _comment:
        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer

        ret

    #   ver
    _ver:
        mov     $_ver_str,  %si
        call    _printk
        
        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer

        ret

    #   landing for _rm
    _rm_pre:
        mov     $_arguments,%si
        call    _rm_file

        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer
        ret

    #   landing for _mk
    _mk_pre:
        mov     $_arguments,%si
        movb    (_cur_drive),%dl
        call    _mk_file

        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer
        ret

    #   switch to a:
    _disk_a:
        movb    $0x00,  _cur_drive
        ret

    #   switch to b:
    _disk_b:
        movb    $0x01,  _cur_drive
        ret

    _format_pre:
        mov     $_arguments,%si
        movb    (_cur_drive),%dl
        call    _format_disk

        mov     $_command,  %di
        xor     %cx,    %cx
        call    _clear_buffer
        ret

        .section    .rodata
        .global     _new_line
    _new_line:  .asciz  "\r\n"

    _ver_str:   .asciz  "\tOperating System/1 v6.0.0\r\n"

    _no_cmd:    .asciz  "Unknow command or file.\r\n\n"

    .include    "kernel/mp/cmds.S"


        .section    .data
        .global     _cur_drive
    _cur_drive: .byte   0           #   current disk drive

    _command:   .fill   33,1,0      #   32 char command name (+1 for \0)
    _arguments: .fill   65,1,0      #   65 char command arguments (+1 for \0)
