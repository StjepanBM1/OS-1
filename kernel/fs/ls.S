
        .code16
        .global     _ls_dir
        .section    .text

    _ls_dir:
        xor     %cx,    %cx
        mov     $0x02,  %ch

        _ls_loop:
            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x02,  %ah
            mov     $0x01,  %al
            mov     $0x5000, %bx
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            push    %cx

            mov     $0x5000,%si
            mov     $_ls_file,%di
            mov     $16,    %cx
            rep     movsb

            mov     $0x0d,  %al
            stosb
            mov     $0x0a,  %al
            stosb
            mov     $0x00,  %al
            stosb

            pop     %cx

            mov     $_ls_file, %si
            call    _printk

            add     $0x02,  %ch

            cmp     $0x50,  %ch
            jg      _ls_dstat

            jmp     _ls_loop

        _ls_dstat:
            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x02,  %ah
            mov     $0x01,  %al
            mov     $0x5000, %bx
            mov     $0x00,  %ch
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            mov     $0x5003,%si
            mov     $_ls_dlabl,%di
            mov     $31,    %cx
            rep     movsb

            mov     $_ls_label,%si
            call    _printk
            mov     $_ls_dlabl,%si
            call    _printk
            mov     $_new_line,%si
            call    _printk

        _ls_done:
            ret

        .section    .rodata
    _ls_file:   .fill   21,1,0
    _ls_dlabl:  .fill   32,1,0

    _ls_label:  .asciz  "\r\nDISK DRIVE LABEL: "
