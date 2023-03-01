
    .section    .text
    .global     paint16
    .code16

        paint16:
            call    ui_clear
            call    paint_screen

            cli
            hlt

        paint_screen:
            mov     $0x09,  %ah
            mov     $80,    %cx
            mov     $32,    %al
            mov     $0x1F,  %bl
            int     $0x10

            mov     $title, %si
            call    ui_puts16

            mov     $0x02,  %ah
            mov     $0,     %dh
            mov     $0,     %dl
            int     $0x10
            .board_loop:
                cmp     $27,    %dh
                je      .after

                mov     $0x02,  %ah
                inc             %dh
                mov     $0,     %dl
                int     $0x10

                mov     $0x09,  %ah
                mov     $80,    %cx
                mov     $32,    %al
                mov     $0xF0,  %bl
                int     $0x10

                jmp     .board_loop


            .after:
                mov     $0x01,  %ah
                mov     $0x07,  %cx
                int     $0x10

                mov     $0,     %bl
                mov     $1,     %cl

                .loop_af:
                    mov     $0x02,  %ah
                    mov     %cl,    %dh
                    mov     %bl,    %dl
                    int     $0x10

                    mov     $0x00,  %ah
                    int     $0x16

                    cmp     $0x48,  %ah
                    je      up

                    cmp     $0x50,  %ah
                    je      dw

                    cmp     $0x4B,  %ah
                    je      lt

                    cmp     $0x4D,  %ah
                    je      rt

                    cmpb    %al,    key_place
                    je      place

                    cmpb    %al,    key_erase
                    je      erase

                    cmpb    %al,    key_text
                    je      textp

                    cmpb    %al,    key_exit
                    je      exit

                    jmp     .loop_af

                ret

            up:
                cmp     $1, %cl
                je      .loop_af

                sub     $1, %cl
                jmp     .loop_af

            dw:
                cmp     $27,%cl
                je      .loop_af

                add     $1, %cl
                jmp     .loop_af

            lt:
                cmp     $0, %bl
                je      .loop_af

                sub     $1, %bl
                jmp     .loop_af

            rt:
                cmp     $79,%bl
                je      .loop_af

                add     $1, %bl
                jmp     .loop_af

            place:
                mov     $0x0e,  %ah
                mov     $219,   %al
                int     $0x10

                jmp     .loop_af

            erase:
                mov     $0x0e,  %ah
                mov     $32,    %al
                int     $0x10

                jmp     .loop_af

            textp:
                mov     $0x00,  %ah
                int     $0x16

                cmp     %al,    key_text
                je      .loop_af

                mov     $0x0e,  %ah
                int     $0x10

                jmp     textp

            exit:
                jmp     mainprg

    .section    .rodata
        title:      .asciz  " [OS/1 Paint 2.0.0] [ ESC = exit ] [ ` = place text ] [ p = place | e = erase ]"

        #   Keybinding
        key_text:   .byte   '`'
        key_place:  .byte   'p'
        key_erase:  .byte   'e'
        key_exit:   .byte   27
