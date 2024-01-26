
            .code16
            .section    .text.pinb
            .global     _home_curs

        _home_curs:
            mov     $0x01,  %ah
            mov     $0x10,  %cx
            int     $0x10

            mov     $0x03,  %bl
            mov     $0x02,  %cl

            .hc_loop:
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

                jmp     .hc_loop

            .up:
                cmp     $0x00,  %cl
                je      .hc_loop

                sub     $0x01,  %cl
                jmp     .hc_loop

            .down:
                cmp     $0x1B,  %cl
                je      .hc_loop

                add     $0x01,  %cl
                jmp     .hc_loop

            .left:
                cmp     $0x00,  %bl
                je      .hc_loop

                sub     $0x01,  %bl
                jmp     .hc_loop

            .right:
                cmp     $79,    %bl
                je      .hc_loop

                add     $0x01,  %bl
                jmp     .hc_loop

            .click:
                cmp     $0x00,  %dh
                je      .tbar

                cmp     $0x02,  %dh
                je      .bar

                cmp     $0x03,  %dl
                je      .shell
                cmp     $0x04,  %dl
                je      .shell
                cmp     $0x05,  %dl
                je      .shell
                cmp     $0x06,  %dl
                je      .shell
                cmp     $0x07,  %dl
                je      .shell
                cmp     $0x08,  %dl
                je      .shell
                cmp     $0x09,  %dl
                je      .shell

                cmp     $0x0C,  %dl
                je      .paint
                cmp     $0x0D,  %dl
                je      .paint
                cmp     $0x0E,  %dl
                je      .paint
                cmp     $0x0F,  %dl
                je      .paint
                cmp     $0x10,  %dl
                je      .paint

                cmp     $0x13,  %dl
                je      .notes
                cmp     $0x14,  %dl
                je      .notes
                cmp     $0x15,  %dl
                je      .notes
                cmp     $0x16,  %dl
                je      .notes
                cmp     $0x17,  %dl
                je      .notes
/*
                cmp     $0x1A,  %dl
                je      .settings
                cmp     $0x1B,  %dl
                je      .settings
                cmp     $0x1C,  %dl
                je      .settings
                cmp     $0x1D,  %dl
                je      .settings
                cmp     $0x1E,  %dl
                je      .settings
                cmp     $0x1F,  %dl
                je      .settings
                cmp     $0x20,  %dl
                je      .settings
                cmp     $0x21,  %dl
                je      .settings
*/
                cmp     $0x24,  %dl
                je      .extras
                cmp     $0x25,  %dl
                je      .extras
                cmp     $0x26,  %dl
                je      .extras
                cmp     $0x27,  %dl
                je      .extras
                cmp     $0x28,  %dl
                je      .extras
                cmp     $0x29,  %dl
                je      .extras
                cmp     $0x2A,  %dl
                je      .extras
                cmp     $0x2B,  %dl
                je      .extras

                cmp     $0x03,  %dl
                je      .loada
                cmp     $0x04,  %dl
                je      .loada
                cmp     $0x05,  %dl
                je      .loada
                cmp     $0x06,  %dl
                je      .loada
                cmp     $0x07,  %dl
                je      .loada
                cmp     $0x08,  %dl
                je      .loada
                cmp     $0x09,  %dl
                je      .loada
                cmp     $0x0A,  %dl
                je      .loada

                cmp     $0x0C,  %dl
                je      .loadb
                cmp     $0x0D,  %dl
                je      .loadb
                cmp     $0x0E,  %dl
                je      .loadb
                cmp     $0x0F,  %dl
                je      .loadb
                cmp     $0x10,  %dl
                je      .loadb
                cmp     $0x11,  %dl
                je      .loadb
                cmp     $0x12,  %dl
                je      .loadb
                cmp     $0x13,  %dl
                je      .loadb
                cmp     $0x14,  %dl
                je      .loadb
                cmp     $0x15,  %dl
                je      .loadb

                jmp     .hc_loop

            /*
                Actions
            */
            .tbar:
                cmp     $0x0B,  %dl
                je      _about
                cmp     $0x0C,  %dl
                je      _about
                cmp     $0x0D,  %dl
                je      _about
                cmp     $0x0E,  %dl
                je      _about
                cmp     $0x0F,  %dl
                je      _about
                cmp     $0x10,  %dl
                je      _about
                cmp     $0x11,  %dl
                je      _about
                cmp     $0x12,  %dl
                je      _about
                cmp     $0x13,  %dl
                je      _about

            .bar:
                cmp     $0x03,  %dl
                je      _h_clear

                jmp     .hc_loop

            .shell:
                cmp     $0x03,  %dh
                je      _pre_jump
                cmp     $0x04,  %dh
                je      _pre_jump
                cmp     $0x05,  %dh
                je      _pre_jump
                cmp     $0x06,  %dh
                je      _pre_jump

                cmp     $0x09,  %dh
                je      .loada
                cmp     $0x0A,  %dh
                je      .loada
                cmp     $0x0B,  %dh
                je      .loada
                cmp     $0x0C,  %dh
                je      .loada
                cmp     $0x0D,  %dh
                je      .loada
                cmp     $0x0E,  %dh
                je      .loada

                jmp     .hc_loop

            .paint:
                cmp     $0x03,  %dh
                je      _paint
                cmp     $0x04,  %dh
                je      _paint
                cmp     $0x05,  %dh
                je      _paint
                cmp     $0x06,  %dh
                je      _paint
                cmp     $0x07,  %dh
                je      _paint
/*
                cmp     $0x09,  %dh
                je      _prod
                cmp     $0x0A,  %dh
                je      _prod
                cmp     $0x0B,  %dh
                je      _prod
                cmp     $0x0C,  %dh
                je      _prod
                cmp     $0x0D,  %dh
                je      _prod

                jmp     .hc_loop
*/

            .notes:
                cmp     $0x03,  %dh
                je      _notes
                cmp     $0x04,  %dh
                je      _notes
                cmp     $0x05,  %dh
                je      _notes
                cmp     $0x06,  %dh
                je      _notes
                cmp     $0x07,  %dh
                je      _notes

                jmp     .hc_loop
/*
            .settings:
                cmp     $0x03,  %dh
                je      _settings
                cmp     $0x04,  %dh
                je      _settings
                cmp     $0x05,  %dh
                je      _settings
                cmp     $0x06,  %dh
                je      _settings
                cmp     $0x07,  %dh
                je      _settings

                jmp     .hc_loop
*/

            .extras:
                cmp     $0x03,  %dh
                je      _dstat
                cmp     $0x04,  %dh
                je      _dstat
                cmp     $0x05,  %dh
                je      _dstat
                cmp     $0x06,  %dh
                je      _dstat
                cmp     $0x07,  %dh
                je      _dstat

                jmp     .hc_loop

            .loada:
                cmp     $0x09,  %dh
                je      _load_A
                cmp     $0x0A,  %dh
                je      _load_A
                cmp     $0x0B,  %dh
                je      _load_A
                cmp     $0x0C,  %dh
                je      _load_A
                cmp     $0x0D,  %dh
                je      _load_A

                jmp     .hc_loop

            .loadb:
                cmp     $0x09,  %dh
                je      _load_B
                cmp     $0x0A,  %dh
                je      _load_B
                cmp     $0x0B,  %dh
                je      _load_B
                cmp     $0x0C,  %dh
                je      _load_B
                cmp     $0x0D,  %dh
                je      _load_B


                jmp     .hc_loop

        _h_clear:
            mov     $0x02,      %ah
            mov     $01,        %dh
            mov     $01,        %dl
            int     $0x10

            .h_cloop:
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

                jmp     .h_cloop

        _pre_jump:
            call    _clear
            jmp     _input
