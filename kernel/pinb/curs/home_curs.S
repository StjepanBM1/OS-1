
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
                je      .games
                cmp     $0x04,  %dl
                je      .games
                cmp     $0x05,  %dl
                je      .games
                cmp     $0x06,  %dl
                je      .games
                cmp     $0x07,  %dl
                je      .games
                cmp     $0x08,  %dl
                je      .games
                cmp     $0x09,  %dl
                je      .games
                cmp     $0x0A,  %dl
                je      .games
/*
                cmp     $0x0C,  %dl
                je      .office
                cmp     $0x0D,  %dl
                je      .office
                cmp     $0x0E,  %dl
                je      .office
                cmp     $0x0F,  %dl
                je      .office
                cmp     $0x10,  %dl
                je      .office
                cmp     $0x11,  %dl
                je      .office
                cmp     $0x12,  %dl
                je      .office
                cmp     $0x13,  %dl
                je      .office
                cmp     $0x14,  %dl
                je      .office

                jmp     .hc_loop
*/

            /*
                Actions
            */
            .bar:
                cmp     $0x03,  %dl
                je      _pinb

                jmp     .hc_loop

            .shell:
                cmp     $0x03,  %dh
                je      _shell
                cmp     $0x04,  %dh
                je      _shell
                cmp     $0x05,  %dh
                je      _shell
                cmp     $0x06,  %dh
                je      _shell

/*
                cmp     $0x09,  %dh
                je      _pong
                cmp     $0x0A,  %dh
                je      _pong
                cmp     $0x0B,  %dh
                je      _pong
                cmp     $0x0C,  %dh
                je      _pong
                cmp     $0x0D,  %dh
                je      _pong
                cmp     $0x0E,  %dh
                je      _pong
*/
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

            .games:
                cmp     $0x09,  %dh
                je      _pong
                cmp     $0x0A,  %dh
                je      _pong
                cmp     $0x0B,  %dh
                je      _pong
                cmp     $0x0C,  %dh
                je      _pong
                cmp     $0x0D,  %dh
                je      _pong
                cmp     $0x0E,  %dh
                je      _pong

                jmp     .hc_loop
/*
            .office:
                cmp     $0x09,  %dh
                je      _words
                cmp     $0x0A,  %dh
                je      _words
                cmp     $0x0B,  %dh
                je      _words
                cmp     $0x0C,  %dh
                je      _words
                cmp     $0x0D,  %dh
                je      _words
                cmp     $0x0E,  %dh
                je      _words
*/

                jmp     .hc_loop
