        .code16
        .global     _printk
        .global     _preg
        .global     _strcmp
        .section    .text

    _printk:
        lodsb

        or      %al,    %al
        jz      .done_printk

        cmp     $0x09,  %al
        je      .handle_tab

        mov     $0x0e,  %ah
        int     $0x10

        jmp     _printk

        .handle_tab:
            mov $0x0e,  %ah
            mov $' ',   %al
            int $0x10
            int $0x10
            int $0x10
            int $0x10

            jmp _printk

        .done_printk:
            ret

    _preg:
        mov     $out_str,   %si
        mov     (reg_in),   %ax
        mov     $hex_str,   %si
        mov     $0x04,      %cx

        .preg_loop:
            rol $0x04,  %ax
            mov %ax,    %bx
            and $0x0f,  %bx

            movb (%bx,%si), %bl

            movb    %bl,    (%di)

            inc     %di
            dec     %cx

            jnz     .preg_loop

            mov     $out_str,%si
            call    _printk

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

        .section    .data
        .global     reg_in
    out_str:    .asciz  "0000"
    hex_str:    .asciz  "0123456789ABCDEF"

    reg_in:     .word   0
