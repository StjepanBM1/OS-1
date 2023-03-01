
    .section    .text
    .global     type16
    .code16

        type16:
            call    ui_clear
            call    type16_screen
            
            mov     $0x02,  %ah
            mov     $2,     %dh
            mov     $0,     %dl
            int     $0x10

            call    type16_io

            cli
            hlt

        type16_io:
            ret

        type16_screen:
            .layout:
                mov     $0x02,  %ah
                mov     $0,     %dh
                mov     $0,     %dl
                int     $0x10

                mov     $0x09,  %ah
                mov     $80,    %cx
                mov     $32,    %al
                mov     $0x1F,  %bl
                int     $0x10
                mov     $title, %si
                call    ui_puts16

                jmp     .type16_wind
        
            .type16_wind:
                cmp     $27,    %dh
                je      .after

                mov     $0x02,  %ah
                inc     %dh
                mov     $0,     %dl
                int     $0x10

                mov     $0x09,  %ah
                mov     $80,    %cx
                mov     $32,    %al
                mov     $0xF0,  %bl
                int     $0x10

                jmp     .type16_wind
    
            .after:
                mov     $0x02,  %ah
                mov     $0,     %dh
                mov     $1,     %dl
                int     $0x10
                .after2:
                    cmp     $28,    %dh
                    je      .after

                    mov     $0x02,  %ah
                    inc     %dh
                    mov     $1,     %dl
                    int     $0x10
                    .loop:
                        mov     $0x00,  %ah
                        int     $0x16

                        cmp     $9,     %al
                        je      .tabp

                        cmp     $0x0D,  %al
                        je      .after2

                        cmp     $27,    %al
                        je      mainprg

                        mov     $0x0e,  %ah
                        int     $0x10

                        jmp     .loop

                    .tabp:
                        mov     $tabk,  %si
                        call    ui_puts16

                        jmp     .loop 
            
    .section    .rodata
        title:      .asciz  " [ OS/1 Write 2.0.0 ] [ ESC to exit ] [ 27-line limit, not saveable ] "
        line:       .byte   179
        exit:       .byte   27
        tabk:       .asciz  "   "
