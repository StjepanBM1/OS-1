
            .code16
            .section    .text.pinb
            .global     _desk_curs

        _desk_curs:
            mov     $0x01,  %ah
            mov     $0x10,  %cx
            int     $0x10

            mov     $13,    %cl
            mov     $40,    %bl

            .dc_loop:
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

                jmp     .dc_loop

            .up:
                cmp     $0x00,  %cl
                je      .dc_loop

                sub     $0x01,  %cl
                jmp     .dc_loop

            .down:
                cmp     $0x1B,  %cl
                je      .dc_loop

                add     $0x01,  %cl
                jmp     .dc_loop

            .left:
                cmp     $0x00,  %bl
                je      .dc_loop

                sub     $0x01,  %bl
                jmp     .dc_loop

            .right:
                cmp     $79,    %bl
                je      .dc_loop

                add     $0x01,  %bl
                jmp     .dc_loop

            .click:
                cmp     $0x00,  %dh
                je      .topb

                jmp     .dc_loop

            .topb:
                cmp     $0x02,  %dl
                je      _home
                cmp     $0x03,  %dl
                je      _home
                cmp     $0x04,  %dl
                je      _home
                cmp     $0x05,  %dl
                je      _home
                cmp     $0x06,  %dl
                je      _home
                cmp     $0x07,  %dl
                je      _home
                cmp     $0x08,  %dl
                je      _home
                cmp     $0x09,  %dl
                je      _home

                jmp     .dc_loop
