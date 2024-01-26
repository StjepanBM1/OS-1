
            .code16
            .section    .text.pinb
            .global     _about_curs

        _about_curs:
            mov     $0x01,  %ah
            mov     $0x10,  %cx
            int     $0x10

            mov     $0x03,  %bl
            mov     $0x02,  %cl

            .ac_loop:
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

                jmp     .ac_loop

            .up:
                cmp     $0x00,  %cl
                je      .ac_loop

                sub     $0x01,  %cl
                jmp     .ac_loop

            .down:
                cmp     $0x1B,  %cl
                je      .ac_loop

                add     $0x01,  %cl
                jmp     .ac_loop

            .left:
                cmp     $0x00,  %bl
                je      .ac_loop

                sub     $0x01,  %bl
                jmp     .ac_loop

            .right:
                cmp     $79,    %bl
                je      .ac_loop

                add     $0x01,  %bl
                jmp     .ac_loop

            .click:
                cmp     $0x02,  %dh
                je      .bar

                cmp     $0x00,  %dh
                je      .tbar

                jmp     .ac_loop

            /*
                Actions
            */
            .tbar:
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

                jmp     .ac_loop

            .bar:
                cmp     $0x03,  %dl
                je      _a_clear

                jmp     .ac_loop

        _a_clear:
            mov     $0x02,      %ah
            mov     $01,        %dh
            mov     $01,        %dl
            int     $0x10

            .a_cloop:
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
                je      _desk_curs

                jmp     .a_cloop
