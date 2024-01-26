        .code16
        .global     _print
        .global     _strcmp
        .section    .text

    _print:
        lodsb

        or      %al,    %al
        jz      .p_done

        mov     $0x0e,  %ah
        int     $0x10

        jmp     _print

        .p_done:
            ret

    _strcmp:
        _str_loop:
            mov     (%si),  %al
            mov     (%di),  %bl
            cmp     %bl,    %al
            jne     _not_equal

            cmp     $0x00,  %al
            je      _equal

            inc     %di
            inc     %si
            
            jmp     _str_loop
        
        _not_equal:
            clc
            ret

        _equal:
            stc
            ret