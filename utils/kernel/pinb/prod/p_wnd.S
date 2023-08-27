            .code16
            .section    .text.pinb
            .global     _prod

        _prod:
            .o_title:
                mov     $0x02,      %ah
                mov     $02,        %dh
                mov     $52,        %dl
                int     $0x10

                mov     $0x09,      %ah
                mov     $0x20,      %al
                mov     $0x00,      %bh
                mov     $0xF1,      %bl
                mov     $21,        %cx
                int     $0x10

                mov     $_o_title,  %si
                call    _printk

            .border:

                mov     $0x02,      %ah
                mov     $02,        %dh
                mov     $52,        %dl
                int     $0x10

                .left:
                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $52,        %dl
                    int     $0x10

                    mov     $0x09,      %ah
                    mov     $0xBA,      %al
                    mov     $0x00,      %bh
                    mov     $0xF1,      %bl
                    mov     $01,        %cx
                    int     $0x10

                    cmp     $10,        %dh
                    je      .int1

                    jmp     .left

                .int1:
                    mov     $0x02,      %ah
                    mov     $02,        %dh
                    mov     $01,        %dl
                    int     $0x10

                .right:
                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $72,        %dl
                    int     $0x10

                    mov     $0x09,      %ah
                    mov     $0xBA,      %al
                    mov     $0x00,      %bh
                    mov     $0xF1,      %bl
                    mov     $01,        %cx
                    int     $0x10

                    cmp     $10,        %dh
                    je      .bottom

                    jmp     .right

                .bottom:
                    mov     $0x02,      %ah
                    mov     $52,        %dl
                    int     $0x10

                    mov     $0x09,      %ah
                    mov     $0xCD,      %al
                    mov     $0x00,      %bh
                    mov     $0xF1,      %bl
                    mov     $20,        %cx
                    int     $0x10

                    mov     $0x0e,      %ah
                    mov     $0xC8,      %al
                    int     $0x10

                    mov     $0x02,      %ah
                    mov     $72,        %dl
                    int     $0x10
                    mov     $0x0e,      %ah
                    mov     $0xBC,      %al
                    int     $0x10

            .icons:
                mov     $0x02,      %ah
                mov     $02,        %dh
                mov     $52,        %dl
                int     $0x10

                .words:
                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $55,        %dl
                    int     $0x10
                    mov     $_words_1,   %si
                    call    _printk

                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $55,        %dl
                    int     $0x10
                    mov     $_words_2,   %si
                    call    _printk

                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $55,        %dl
                    int     $0x10
                    mov     $_words_3,   %si
                    call    _printk

                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $55,        %dl
                    int     $0x10
                    mov     $_words_4,   %si
                    call    _printk

                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $55,        %dl
                    int     $0x10
                    mov     $_words_5,   %si
                    call    _printk

                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $55,        %dl
                    int     $0x10
                    mov     $_words_6,   %si
                    call    _printk
            cli
            hlt

            .section    .rodata.pinb
        _o_title:       .asciz  " \xB3\xFE\xB3 Home\\Office"

        #
        #   Icon(s)
        #

        _words_1:       .asciz  "\xD6\xC4\xC4\xC4\xC4\xC4\xBF"
        _words_2:       .asciz  "\xBA\x20\xC4\xC4\xC4\x20\xB3"
        _words_3:       .asciz  "\xBA\xCD\xCD\xCD\xCD\xCD\xB3"
        _words_4:       .asciz  "\xBA\xCD\xCD\xCD\xCD\xCD\xB3"
        _words_5:       .asciz  "\xD3\xC4\xC4\xC4\xC4\xC4\xD9"
        _words_6:       .asciz  " Words "
