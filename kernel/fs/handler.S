
        .code16
        .global     _handle_file
        .section    .text

    #
    #   _handle_file:
    #
    #   %si - file name (with exst.)
    #
    #   - decides what to do based
    #     on the file exstension
    #
    _handle_file:
        mov     $_file_tmp, %di
        mov     $16,    %cx
        rep     movsb

        mov     $0x00,  %al
        stosb

        mov     $_file_tmp, %si

        _skip_to_exst:
            movb    (%si),  %al
            
            cmp     $0x00,  %al
            je      _handler_end

            cmp     $0x2E,  %al
            je      _get_exst

            inc     %si
            inc     %di

            jmp     _skip_to_exst

        _get_exst:
            inc     %si
            mov     %si,    %bx
            mov     $_file_exst,%di

            _exst_loop:
                movb    (%si),  %al

                cmp     $0x00,  %al
                je      _check_exst

                movb    %al,    (%di)

                inc     %si
                inc     %di

                jmp     _exst_loop

        _check_exst:
            mov     $_file_exst,%si
            mov     $_cmd_exst,%di
            call    _strcmp
            jc      _command_file

            mov     $_file_exst,%si
            mov     $_exe_exst,%di
            call    _strcmp
            jc      _executable

            mov     $_file_exst,%si
            mov     $_sys_exst,%di
            call    _strcmp
            jc      _system_file

            jmp     _handler_end

        _command_file:
            mov     $_com_msg,  %si
            call    _printk

            mov     $_file_tmp, %si
            movb    (_cur_drive),%dl
            call    _find_file

            #   run the command file
            #   (0x2000)
            xor     %ax,    %ax
            mov     %ax,    %ds

            mov     $0x02,  %ah
            mov     $0x12,  %al
            mov     $0x2000,%bx
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            mov     $0x02,  %ah
            mov     $0x12,  %al
            mov     $0x4400,%bx
            inc     %ch
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            jmp     0x2000

            ret

        _executable:
            mov     $_exe_msg,  %si
            call    _printk

            mov     $_file_tmp, %si
            movb    (_cur_drive),%dl
            call    _find_file

            #   execute the file
            #   (0x2000)
            mov     $_file_tmp, %si
            movb    (_cur_drive),%dl
            call    _find_file

            xor     %ax,    %ax
            mov     %ax,    %ds

            mov     $0x02,  %ah
            mov     $0x12,  %al
            mov     $0x2000,%bx
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            mov     $0x02,  %ah
            mov     $0x12,  %al
            mov     $0x4400,%bx
            inc     %ch
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            jmp     0x2000

            ret

        _system_file:
            mov     $_file_tmp, %si
            movb    (_cur_drive),%dl
            call    _find_file

            #   pass the control
            #   to the system file
            #   (0x2000)

            /*
                This could lead
                to many cases of
                malware taking the
                control of the system
             */

            xor     %ax,    %ax
            mov     %ax,    %ds

            mov     $0x02,  %ah
            mov     $0x12,  %al
            mov     $0x2000,%bx
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            mov     $0x02,  %ah
            mov     $0x12,  %al
            mov     $0x4400,%bx
            inc     %ch
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            jmp     0x2000

            ret

        _handler_end:
            mov     $_unknow,   %si
            call    _printk

            ret

        .section    .rodata
    #   msgs
    _com_msg:   .asciz  "COMMAND FILE!!\r\n"
    _exe_msg:   .asciz  "EXECUTEABLE FILE!!\r\n"
    _sys_msg:   .asciz  "SYSTEM FILE!!\r\n"
    
    _unknow:    .asciz  "Unknow file type. Not sure what to do with it.\r\n"

    #   file exstensions
    _cmd_exst:      .asciz  "CMD"
    _exe_exst:      .asciz  "EXE"
    _sys_exst:      .asciz  "SYS"

        .section    .data
    _file_tmp:      .fill   17,1,0
    _file_start:    .byte   0
    _file_exst:     .fill   4,1,0
