
        .code16
        .global     _format_disk
        .section    .text

    #
    #   %si - disk label
    #   %dl - disk drive
    #
    _format_disk:
        #
        #   Save the label
        #
        mov     $_label,%di
        mov     $30,    %cx
        rep     movsb

        xor     %cx,    %cx
        mov     $0x02,  %ch
        _format_loop:
            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x03,  %ah
            mov     $0x01,  %al
            mov     $0x5000, %bx
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            add     $0x02,  %ch

            cmp     $0x50,  %ch
            jg      _format_label

            jmp     _format_loop

        _format_label:
            mov     $_label,%si
            mov     $0xC003,%di
            mov     $31,    %cx
            rep     movsb

            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x03,  %ah
            mov     $0x01,  %al
            mov     $0x5000, %bx
            mov     $0x00,  %ch
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

        _format_done:
            ret

        .section    .rodata
    _label: .fill   30,1,20
            .byte   0
