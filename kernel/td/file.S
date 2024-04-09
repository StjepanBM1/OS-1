
        .code16
        .global     _td_create_new
        .global     _td_open_file
        .section    .text

    _td_create_new:
        movb    (_cur_drive),%dl
        call    _mk_file

        movb     %ch,    (_td_file_track)

        jmp     _td_screen_setup

    _td_open_file:
        movb    (_cur_drive),%dl
        call    _find_file
        jnc     _td_file_not_found

        xor     %ax,    %ax
        mov     %ax,    %ds

        movb     %ch,    (_td_file_track)

        mov     $0x02,  %ah
        mov     $0x12,  %al
        mov     $0xA000,%bx
        mov     $0x01,  %cl
        mov     $0x00,  %dh
        movb    (_cur_drive),%dl
        int     $0x13

        mov     $0x02,  %ah
        mov     $0x12,  %al
        mov     $0xC400,%bx
        inc     %ch
        mov     $0x01,  %cl
        mov     $0x00,  %dh
        movb    (_cur_drive),%dl
        int     $0x13

        jmp     _td_screen_setup

        _td_file_not_found:
            mov     $_td_no_file,   %si
            call    _printk

            int     $0x30

        cli
        hlt

        .section    .rodata
    _td_no_file:    .asciz  "\r\n\tInputed file not found.\r\n"
