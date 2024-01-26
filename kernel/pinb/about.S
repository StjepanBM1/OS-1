
            .code16
            .section    .text.pinb
            .global     _about

        _about:
            mov     $0x02,      %ah
            mov     $02,        %dh
            mov     $01,        %dl
            int     $0x10

            .a_set:
                mov     $0x02,      %ah
                inc     %dh
                mov     $01,        %dl
                int     $0x10

                mov     $0x09,      %ah
                mov     $0x20,      %al
                mov     $0x00,      %bh
                mov     $0x1F,      %bl
                mov     $50,        %cx
                int     $0x10

                cmp     $18,        %dh
                je      .a_title

                jmp     .a_set

            .a_title:
                mov     $0x02,  %ah
                mov     $0x02,  %dh
                mov     $0x01,  %dl
                int     $0x10

                mov     $0x09,  %ah
                mov     $0x20,  %al
                mov     $0x00,  %bh
                mov     $0xF1,  %bl
                mov     $50,    %cx
                int     $0x10

                mov     $_a_title,  %si
                call    _printk

            .a_border:
                mov     $0x02,      %ah
                mov     $02,        %dh
                mov     $01,        %dl
                int     $0x10

                .ab_left:
                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $01,        %dl
                    int     $0x10

                    mov     $0x09,      %ah
                    mov     $0xBA,      %al
                    mov     $0x00,      %bh
                    mov     $0xF1,      %bl
                    mov     $01,        %cx
                    int     $0x10

                    cmp     $8,        %dh
                    je      .ab_i1

                    jmp     .ab_left

                .ab_i1:
                    mov     $0x02,      %ah
                    mov     $02,        %dh
                    mov     $01,        %dl
                    int     $0x10
                
                .ab_right:
                    mov     $0x02,      %ah
                    inc     %dh
                    mov     $50,        %dl
                    int     $0x10

                    mov     $0x09,      %ah
                    mov     $0xBA,      %al
                    mov     $0x00,      %bh
                    mov     $0xF1,      %bl
                    mov     $01,        %cx
                    int     $0x10

                    cmp     $8,        %dh
                    je      .ab_down

                    jmp     .ab_right
                .ab_down:
                    mov $0x02,  %ah
                    mov $0x01,  %dl
                    int $0x10

                    mov $0x09,  %ah
                    mov $0xCD,  %al
                    mov $0x00,  %bh
                    mov $0xF1,  %bl
                    mov $50,    %cx
                    int $0x10

                    mov $0x0e,  %ah
                    mov $0xC8,  %al
                    int $0x10

                    mov $0x02,  %ah
                    mov $50,    %dl
                    int $0x10

                    mov $0x0e,  %ah
                    mov $0xBC,  %al
                    int $0x10

            .a_content:
                mov $0x02,  %ah
                mov $0x04,  %dh
                mov $0x0D,  %dl
                int $0x10

                mov $_header,%si
                call    _printk

                mov $0x02,  %ah
                mov $0x05,  %dh
                mov $0x0B,  %dl
                int $0x10

                mov $0x09,  %ah
                mov $0xC4,  %al
                mov $0x00,  %bh
                mov $0x1F,  %bl
                mov $0x1D,  %cx
                int $0x10
            
                mov $0x02,  %ah
                mov $0x06,  %dh
                mov $0x09,  %dl
                int $0x10

                mov $_copyrg,%si
                call    _printk

            jmp _about_curs

            cli
            hlt

            .section    .rodata.pinb
        _a_title:   .asciz  " \xB3\xFE\xB3 About"
        
        _header:    .asciz  "Operating System/1 v5.5.0"
        _copyrg:    .asciz  "Copyright (C) 2024 \xB3 Build 260124"
