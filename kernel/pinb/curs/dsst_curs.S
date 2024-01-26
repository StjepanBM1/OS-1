
            .code16
            .section    .text.pinb
            .global     _disk_curs

        _disk_curs:
            mov     $0x01,  %ah
            mov     $0x10,  %cx
            int     $0x10

            mov     $17,    %cl
            mov     $3,     %bl

            .dsk_loop:
                mov     $0x02,  %ah
                mov     %cl,    %dh
                mov     %bl,    %dl
                int     $0x10

                mov     $0x00,  %ah
                int     $0x16

                cmp     $0x48,  %ah
                je      .up

                cmp     $0x50,  %ah
                je      .down

                cmp     $0x4B,  %ah
                je      .left

                cmp     $0x4D,  %ah
                je      .right

                cmp     $0x20,  %al
                je      .click

                jmp     .dsk_loop

            .up:
                cmp     $0x00,  %cl
                je      .dsk_loop

                sub     $0x01,  %cl
                jmp     .dsk_loop

            .down:
                cmp     $0x1B,  %cl
                je      .dsk_loop

                add     $0x01,  %cl
                jmp     .dsk_loop

            .left:
                cmp     $0x00,  %bl
                je      .dsk_loop

                sub     $0x01,  %bl
                jmp     .dsk_loop

            .right:
                cmp     $79,    %bl
                je      .dsk_loop

                add     $0x01,  %bl
                jmp     .dsk_loop

            .click:
                cmp     $17,    %dh
                je      .bar

                jmp     .dsk_loop

            .bar:
                cmp     $0x03,  %dl
                je      .return

                jmp     .dsk_loop

                .return:
                    mov     $0x02,  %ah
                    mov     $16,    %dh
                    mov     $1,     %dl
                    int     $0x10

                    .rloop:
                        cmp $24,    %dh
                        je  .endd

                        mov $0x02,  %ah
                        inc %dh
                        mov $0x01,  %dl
                        int $0x10

                        mov $0x09,  %ah
                        mov $0x20,  %al
                        mov $0x00,  %bh
                        mov $0x1F,  %bl
                        mov $70,    %cx
                        int $0x10

                        jmp .rloop

                    .endd:
                        jmp _home
