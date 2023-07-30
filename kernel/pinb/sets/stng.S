
            .code16
            .section    .text.pinb.app
            .global     _settings

        _settings:

            .screen:
                call        _clear

                mov     $0x09,  %ah
                mov     $0x20,  %al
                mov     $0x00,  %bh
                mov     $0x1F,  %bl
                mov     $2240,  %cx
                int     $0x10

                .topb:
                    mov     $0x09,  %ah
                    mov     $0x20,  %al
                    mov     $0x00,  %bh
                    mov     $0xF1,  %bl
                    mov     $80,    %cx
                    int     $0x10

                    mov     $_s_title,  %si
                    call    _printk

                    mov     $0x02,  %ah
                    mov     $0x02,  %dh
                    mov     $0x01,  %dl
                    int     $0x10

                .fill:
                    cmp     $27,    %dh
                    je      .prev_win

                    mov     $0x09,  %ah
                    mov     $0x20,  %al
                    mov     $0x00,  %bh
                    mov     $0xF0,  %bl
                    mov     $78,    %cx
                    int     $0x10

                    mov     $0x02,  %ah
                    inc     %dh
                    mov     $0x01,  %dl
                    int     $0x10

                    jmp     .fill

                .prev_win:
                    mov     $0x02,  %ah
                    mov     $0x02,  %dh
                    mov     $30,    %dl
                    int     $0x10

                    .pw_loop:
                        cmp     $14,    %dh
                        je      .items

                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $37,    %dl
                        int     $0x10

                        mov     $0x09,  %ah
                        mov     $0x20,  %al
                        mov     $0x00,  %bh
                        mov     $0x1F,  %bl
                        mov     $40,    %cx
                        int     $0x10

                        jmp .pw_loop

                .items:
                    mov     $0x02,  %ah
                    mov     $15,    %dh
                    mov     $52,    %dl
                    int     $0x10

                    mov     $_prev, %si
                    call    _printk

                .halt:

            cli
            hlt

            .section    .rodata.pinb
        _s_title:       .asciz  " \xB3\xFE\xB3 Settings "
        
        _prev:          .asciz  " Preview "

        #
        #   Menu options
        #
