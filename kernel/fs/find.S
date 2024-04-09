
        .code16
        .global     _find_file
        .global     _find_empty
        .section    .text

    #
    #   %si - file name
    #   %dl - disk drive
    #
    #   returns:
    #   %ch - starting file track
    #
    _find_file:

        #
        #   save the input to $_filename
        #
        _save_filename:
            xor     %ax,    %ax
            mov     $_filename,%di
            mov     $16,    %cx

            _save_fn_l:
                movsb
                loop    _save_fn_l
            
            mov     $0x00,  %al
            stosb

        #
        #   search the file
        #
        #   we don't check for
        #   the first 17KiB
        #   since that space is
        #   reserved for the kernel
        #   file
        #
            xor     %cx,    %cx
            mov     $0x02,  %ch
        _search_loop:
            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x02,  %ah
            mov     $0x01,  %al             #   Load 32 sectors (16KiB) of data
            mov     $0x5000, %bx            #   to address 0x0500
            mov     $0x01,  %cl             #   starting from the 2nd sector
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            push    %cx

            mov     $0x5000,%si
            mov     $_tmp_file,%di
            mov     $16,    %cx

            _copy_l:
                movsb
                loop    _copy_l

            mov     $0x00,  %al
            stosb

            pop     %cx

            mov     $_filename,%si
            mov     $_tmp_file,%di
            call    _strcmp
            jc      _found

            add     $0x02,  %ch

            cmp     $0x50,  %ch
            jg      _not_found

            jmp     _search_loop


        _found:
            stc
            ret

        _not_found:
            clc
            ret
    
    #
    #   Find empty space
    #
    #   if found set carry flag
    #
    _find_empty:
        xor     %cx,    %cx
        mov     $0x02,  %ch

        _fe_loop:
            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x02,  %ah
            mov     $0x01,  %al             #   Load 32 sectors (16KiB) of data
            mov     $0x5000, %bx            #   to address 0x0500
            mov     $0x01,  %cl             #   starting from the 2nd sector
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            cmpb    $0x00,  0x5000
            je      _fe_found

            add     $0x02,  %ch

            cmp     $0x50,  %ch
            jg      _fe_not_found

            jmp     _fe_loop

        _fe_found:
            stc
            ret

        _fe_not_found:
            clc
            ret

        .section    .rodata
    _filename:  .fill   17,1,0
    _tmp_file:  .fill   17,1,0
