
        .code16
        .global     _rm_file
        .section    .text

    #
    #   %si - filename to remove
    #
    #   NOTE:
    #       only input one file
    #       when running the cmd
    #
    _rm_file:
        movb    (_cur_drive),%dl
        call    _find_file
        jnc     _rm_not_found

        mov     $0x03,  %ah
        mov     $0x12,  %al
        mov     $0x4000, %bx
        mov     $0x01,  %cl
        mov     $0x00,  %dh
        movb    (_cur_drive),%dl
        int     $0x13
        jc      _rm_error

        mov     $0x03,  %ah
        mov     $0x12,  %al
        mov     $0x4000, %bx
        inc     %ch
        mov     $0x01,  %cl
        mov     $0x00,  %dh
        movb    (_cur_drive),%dl
        int     $0x13
        jc      _rm_error

        _rm_done:
            ret

    _rm_not_found:
        mov     $_rm_file_nf,%si
        call    _printk

        ret

    _rm_error:
        mov     $0x0e,  %ah
        mov     $'!',   %al
        int     $0x10
        
        ret

        .section    .rodata
    _rm_no_file:    .asciz  "\tNo file input.\r\n\trm [file]\r\n"
    _rm_file_nf:    .asciz  "\tInput file not found.\r\n"
    
    _rm_infile: .fill   17,1,0
    _rm_tmfile: .fill   17,1,0
