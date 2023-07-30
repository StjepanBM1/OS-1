
            .code16
            .section    .text.pinb.app
            .global     _paint

        _paint:
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

                    mov     $_paint_title,  %si
                    call    _printk

                    mov     $0x02,  %ah
                    mov     $0x02,  %dh
                    mov     $0x01,  %dl
                    int     $0x10

                .canvas:
                    cmp     $27,    %dh
                    je      .sidebar

                    mov     $0x09,  %ah
                    mov     $0x20,  %al
                    mov     $0x00,  %bh
                    mov     $0xF0,  %bl
                    mov     $72,    %cx
                    int     $0x10
                    
                    mov     $0x02,  %ah
                    inc     %dh
                    mov     $0x01,  %dl
                    int     $0x10

                    jmp     .canvas

                .sidebar:
                    
                    mov     $0x02,  %ah
                    mov     $0x01,  %dh
                    mov     $0x01,  %dl
                    int     $0x10

                    .sb1:
                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $74,    %dl
                        int     $0x10

                        cmp     $27,    %dh
                        je      .sb2

                        mov     $0x09,  %ah
                        mov     $0xBA,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $1,     %cx
                        int     $0x10

                        jmp     .sb1

                    .sb2:
                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $75,    %dl
                        int     $0x10

                        cmp     $27,    %dh
                        je      .sb3

                        mov     $0x09,  %ah
                        mov     $0x20,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $1,     %cx
                        int     $0x10

                        jmp     .sb2

                    .sb3:
                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $76,    %dl
                        int     $0x10

                        cmp     $27,    %dh
                        je      .sb4

                        mov     $0x09,  %ah
                        mov     $0x20,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $1,     %cx
                        int     $0x10

                        jmp     .sb3

                    .sb4:
                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $77,    %dl
                        int     $0x10

                        cmp     $27,    %dh
                        je      .sb5

                        mov     $0x09,  %ah
                        mov     $0x20,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $1,     %cx
                        int     $0x10

                        jmp     .sb4

                    .sb5:
                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $78,    %dl
                        int     $0x10

                        cmp     $27,    %dh
                        je      .sb6

                        mov     $0x09,  %ah
                        mov     $0x20,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $1,     %cx
                        int     $0x10

                        jmp     .sb5

                    .sb6:
                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $79,    %dl
                        int     $0x10

                        cmp     $27,    %dh
                        je      .tb1

                        mov     $0x09,  %ah
                        mov     $0x20,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $1,     %cx
                        int     $0x10

                        jmp     .sb6

                    .tb1:
                        mov     $0x02,  %ah
                        mov     $01,    %dh
                        mov     $00,    %dl
                        int     $0x10

                        mov     $0x09,  %ah
                        mov     $0x20,  %al
                        mov     $0x00,  %bh
                        mov     $0x1F,  %bl
                        mov     $80,    %cx
                        int     $0x10

                        mov     $0x02,  %ah
                        mov     $02,    %dh
                        mov     $75,    %dl
                        int     $0x10

                        mov     $0x09,  %ah
                        mov     $0xCD,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $5,    %cx
                        int     $0x10

                        mov     $0x02,  %ah
                        mov     $02,    %dh
                        mov     $74,    %dl
                        int     $0x10

                        mov     $0x0e,  %ah
                        mov     $0xC9,  %al
                        int     $0x10

                    .bb1:
                        mov     $0x02,  %ah
                        mov     $26,    %dh
                        mov     $75,    %dl
                        int     $0x10

                        mov     $0x09,  %ah
                        mov     $0xCD,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $5,    %cx
                        int     $0x10

                        mov     $0x02,  %ah
                        mov     $26,    %dh
                        mov     $74,    %dl
                        int     $0x10

                        mov     $0x0e,  %ah
                        mov     $0xC8,  %al
                        int     $0x10

                    .ico:
                        .black:
                            mov     $0x02,  %ah
                            mov     $0x03,  %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x0F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .blue:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x1F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .green:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x2F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .cyan:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x3F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .red:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x4F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .magenta:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x5F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .brown:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x6F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .l_gray:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x7F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .d_gray:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x8F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .l_blue:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0x9F,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .l_green:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0xAF,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .l_cyan:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0xBF,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .l_red:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0xCF,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .l_mag:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0xDF,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .yellow:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0xEF,  %bl
                            mov     $5,     %cx
                            int     $0x10
                        .white:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0x20,  %al
                            mov     $0x00,  %bh
                            mov     $0xF0,  %bl
                            mov     $5,     %cx
                            int     $0x10

                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $74,    %dl
                        int     $0x10

                        mov     $0x09,  %ah
                        mov     $0xCD,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $6,     %cx
                        int     $0x10

                        mov     $0x0e,  %ah
                        mov     $0xCC,  %al
                        int     $0x10

                        .shade0:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0xDB,  %al
                            mov     $0x00,  %bh
                            mov     $0xF0,  %bl
                            mov     $5,     %cx
                            int     $0x10

                        .shade1:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0xB2,  %al
                            mov     $0x00,  %bh
                            mov     $0xF0,  %bl
                            mov     $5,     %cx
                            int     $0x10

                        .shade2:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0xB1,  %al
                            mov     $0x00,  %bh
                            mov     $0xF0,  %bl
                            mov     $5,     %cx
                            int     $0x10

                        .shade3:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $75,    %dl
                            int     $0x10

                            mov     $0x09,  %ah
                            mov     $0xB0,  %al
                            mov     $0x00,  %bh
                            mov     $0xF0,  %bl
                            mov     $5,     %cx
                            int     $0x10

                        mov     $0x02,  %ah
                        inc     %dh
                        mov     $74,    %dl
                        int     $0x10

                        mov     $0x09,  %ah
                        mov     $0xCD,  %al
                        mov     $0x00,  %bh
                        mov     $0xF0,  %bl
                        mov     $6,     %cx
                        int     $0x10

                        mov     $0x0e,  %ah
                        mov     $0xCC,  %al
                        int     $0x10

                        .new:
                            mov     $0x02,  %ah
                            inc     %dh
                            mov     $76,    %dl
                            int     $0x10

                            mov     $0x0e,  %ah
                            mov     $0x4E,  %al
                            int     $0x10

                            mov     $0x65,  %al
                            int     $0x10

                            mov     $0x77,  %al
                            int     $0x10

                .halt:

            jmp     _paint_curs            

            cli
            hlt

            .section    .rodata.pinb.app
        _paint_title:   .asciz  " \xB3\xFE\xB3 Paint v5.0.0"
