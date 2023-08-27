
            .code16
            .section    .text.pinb
            .global     _home

        _home:
            .h_title:
                mov     $0x02,      %ah
                mov     $02,        %dh
                mov     $01,        %dl
                int     $0x10

                mov     $0x09,      %ah
                mov     $0x20,      %al
                mov     $0x00,      %bh
                mov     $0xF1,      %bl
                mov     $50,        %cx
                int     $0x10

                mov     $_h_title,  %si
                call    _printk

            .h_border:

                mov     $0x02,      %ah
                mov     $02,        %dh
                mov     $01,        %dl
                int     $0x10

                .hb_left:
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

                    cmp     $16,        %dh
                    je      .hb_i1

                    jmp     .hb_left

                .hb_i1:
                    mov     $0x02,      %ah
                    mov     $02,        %dh
                    mov     $01,        %dl
                    int     $0x10

                .hb_right:
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

                    cmp     $16,        %dh
                    je      .hb_bottom

                    jmp     .hb_right

                .hb_bottom:
                    mov     $0x02,      %ah
                    mov     $01,        %dl
                    int     $0x10

                    mov     $0x09,      %ah
                    mov     $0xCD,      %al
                    mov     $0x00,      %bh
                    mov     $0xF1,      %bl
                    mov     $50,        %cx
                    int     $0x10

                    mov     $0x0e,      %ah
                    mov     $0xC8,      %al
                    int     $0x10

                    mov     $0x02,      %ah
                    mov     $50,        %dl
                    int     $0x10
                    mov     $0x0e,      %ah
                    mov     $0xBC,      %al
                    int     $0x10

            .h_icons:
                .shell:
                    mov     $0x02,      %ah
                    mov     $03,        %dh
                    mov     $03,        %dl
                    int     $0x10
                    mov     $_h_shell_1,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $04,        %dh
                    mov     $03,        %dl
                    int     $0x10
                    mov     $_h_shell_2,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $05,        %dh
                    mov     $03,        %dl
                    int     $0x10
                    mov     $_h_shell_3,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $06,        %dh
                    mov     $03,        %dl
                    int     $0x10
                    mov     $_h_shell_4,%si
                    call    _printk

                .paint:
                    mov     $0x02,      %ah
                    mov     $03,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_h_paint_1,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $04,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_h_paint_2,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $05,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_h_paint_3,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $06,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_h_paint_4,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $07,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_h_paint_5,%si
                    call    _printk

                .notes:
                    mov     $0x02,      %ah
                    mov     $03,        %dh
                    mov     $0x13,      %dl
                    int     $0x10
                    mov     $_h_notes_1,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $04,        %dh
                    mov     $0x13,      %dl
                    int     $0x10
                    mov     $_h_notes_2,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $05,        %dh
                    mov     $0x13,      %dl
                    int     $0x10
                    mov     $_h_notes_3,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $06,        %dh
                    mov     $0x13,      %dl
                    int     $0x10
                    mov     $_h_notes_4,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $07,        %dh
                    mov     $0x13,      %dl
                    int     $0x10
                    mov     $_h_notes_5,%si
                    call    _printk
                
                .settings:
                    mov     $0x02,      %ah
                    mov     $03,        %dh
                    mov     $0x1A,      %dl
                    int     $0x10
                    mov     $_h_setin_1,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $04,        %dh
                    mov     $0x1A,      %dl
                    int     $0x10
                    mov     $_h_setin_2,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $05,        %dh
                    mov     $0x1A,      %dl
                    int     $0x10
                    mov     $_h_setin_3,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $06,        %dh
                    mov     $0x1A,      %dl
                    int     $0x10
                    mov     $_h_setin_4,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $07,        %dh
                    mov     $0x1A,      %dl
                    int     $0x10
                    mov     $_h_setin_5,%si
                    call    _printk

                .dstat:
                    mov     $0x02,      %ah
                    mov     $03,        %dh
                    mov     $0x24,      %dl
                    int     $0x10
                    mov     $_h_dstat_1,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $04,        %dh
                    mov     $0x24,      %dl
                    int     $0x10
                    mov     $_h_dstat_2,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $05,        %dh
                    mov     $0x24,      %dl
                    int     $0x10
                    mov     $_h_dstat_3,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $06,        %dh
                    mov     $0x24,      %dl
                    int     $0x10
                    mov     $_h_dstat_4,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $07,        %dh
                    mov     $0x24,      %dl
                    int     $0x10
                    mov     $_h_dstat_5,%si
                    call    _printk

                .games:
                    mov     $0x02,      %ah
                    mov     $0x9,        %dh
                    mov     $0x03,      %dl
                    int     $0x10
                    mov     $_pong_1,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xA,        %dh
                    mov     $0x03,      %dl
                    int     $0x10
                    mov     $_pong_2,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xB,        %dh
                    mov     $0x03,      %dl
                    int     $0x10
                    mov     $_pong_3,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xC,        %dh
                    mov     $0x03,      %dl
                    int     $0x10
                    mov     $_pong_4,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xD,        %dh
                    mov     $0x03,      %dl
                    int     $0x10
                    mov     $_pong_5,   %si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xE,        %dh
                    mov     $0x03,      %dl
                    int     $0x10
                    mov     $_pong_6,   %si
                    call    _printk
/*
                .office:
                    mov     $0x02,      %ah
                    mov     $0x9,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_words_1,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xA,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_words_2,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xB,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_words_3,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xC,        %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_words_4,%si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xD,       %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_words_5,  %si
                    call    _printk

                    mov     $0x02,      %ah
                    mov     $0xE,       %dh
                    mov     $0x0C,      %dl
                    int     $0x10
                    mov     $_words_6,  %si
                    call    _printk
*/

            jmp     _home_curs

            .h_halt:
                cli
                hlt

            .section    .rodata.pinb
        
        #
        #   Strings
        #
        _h_title:       .asciz  " \xB3\xFE\xB3 Home "

        #
        #   Icons
        #

        #   Shell   (7x3)
        _h_shell_1:     .asciz  "\xDA\xC4\xC4\xC4\xC4\xC4\xBF"
        _h_shell_2:     .asciz  "\xB3\x3E\x20\x20\x20\x20\xB3"
        _h_shell_3:     .asciz  "\xC0\xC4\xC4\xC4\xC4\xC4\xD9"
        _h_shell_4:     .asciz  " Shell"

        #   Paint   (5x4)
        _h_paint_1:     .asciz  "\xDA\xC4\xC4\xC4\xBF"
        _h_paint_2:     .asciz  "\xB3\xB2\xB1\xB0\xB3"
        _h_paint_3:     .asciz  "\xB3\xB3\x20\x20\xB3"
        _h_paint_4:     .asciz  "\xC0\xC4\xC4\xC4\xD9"
        _h_paint_5:     .asciz  "Paint"

        #   Notes   (5x4)
        _h_notes_1:     .asciz  "\xDA\xC4\xC4\xC4\xBF"
        _h_notes_2:     .asciz  "\xB3\xC4\xC4\xC4\xB3"
        _h_notes_3:     .asciz  "\xB3\xC4\xC4\xC4\xB3"
        _h_notes_4:     .asciz  "\xC0\xC4\xC4\xC4\xD9"
        _h_notes_5:     .asciz  "Notes"

        #   Blank    (8x4)
        _h_setin_1:     .asciz  "\xDA\xC4\xC4\xC4\xC4\xC4\xC4\xBF"
        _h_setin_2:     .asciz  "\xB3\x20\x20\x20\x20\x20\x20\xB3"
        _h_setin_3:     .asciz  "\xB3\x20\x20\x20\x20\x20\x20\xB3"
        _h_setin_4:     .asciz  "\xC0\xC4\xC4\xC4\xC4\xC4\xC4\xD9"
        _h_setin_5:     .asciz  " Blank"

        #   Disk status (8x4)
        _h_dstat_1:     .asciz  ""
        _h_dstat_2:     .asciz  "\xDA\xC4\xC4\xC4\xC4\xC4\x3F\xBF"
        _h_dstat_3:     .asciz  "\xB3\x20\xC4\xCD\xCD\xC4\x20\xB3"
        _h_dstat_4:     .asciz  "\xC0\xC4\xC4\xC4\xC4\xC4\xC4\xD9"
        _h_dstat_5:     .asciz  "Dsk Stat"

        #   Pong (game)
        _pong_1:        .asciz  "\xDA\xC4\xC4\xC4\xC4\xBF"
        _pong_2:        .asciz  "\xB3\xDD\x20\x20\x20\xB3"
        _pong_3:        .asciz  "\xB3\x20\xFE\x20\x20\xB3"
        _pong_4:        .asciz  "\xB3\x20\x20\x20\xDE\xB3"
        _pong_5:        .asciz  "\xC0\xC4\xC4\xC4\xC4\xD9"
        _pong_6:        .asciz  " Pong "

        #   Words (word processor)
        _words_1:       .asciz  "\xD6\xC4\xC4\xC4\xC4\xC4\xBF"
        _words_2:       .asciz  "\xBA\x20\xC4\xC4\xC4\x20\xB3"
        _words_3:       .asciz  "\xBA\xCD\xCD\xCD\xCD\xCD\xB3"
        _words_4:       .asciz  "\xBA\xCD\xCD\xCD\xCD\xCD\xB3"
        _words_5:       .asciz  "\xD3\xC4\xC4\xC4\xC4\xC4\xD9"
        _words_6:       .asciz  " Words "
