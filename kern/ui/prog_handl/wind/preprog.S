
    .section    .text
    .global     pre_prog
    .code16

        pre_prog:
            mov     $2,     %ah
            mov     $4,     %dh
            mov     $17,     %dl
            int     $0x10

            mov     $0x09,  %ah
            mov     $46,    %cx
            mov     $32,    %al
            mov     $0x1F,  %bl
            int     $0x10

            mov     $pre_prog_title,    %si
            call    ui_puts16

            .loop_prep:
                mov     $2,     %ah
                inc     %dh
                mov     $17,     %dl
                int     $0x10

                mov     $0x09,  %ah
                mov     $46,    %cx
                mov     $32,    %al
                mov     $0xF0,  %bl
                int     $0x10

                cmp     $10,    %dh
                je      .loop_done

                jmp     .loop_prep

            .loop_done:           
                mov     $2,     %ah
                mov     $6,     %dh
                mov     $17,    %dl
                int     $0x10
                mov     $pre_prog_msg0, %si
                call    ui_puts16

                mov     $2,     %ah
                mov     $8,     %dh
                mov     $17,    %dl
                int     $0x10
                mov     $pre_prog_msg1, %si
                call    ui_puts16

                mov     $2,     %ah
                mov     $10,    %dh
                mov     $18,    %dl
                int     $0x10

                mov     $0x09,  %ah
                mov     $44,    %cx
                mov     $205,   %al
                mov     $0xF0,  %bl
                int     $0x10

                jmp     .keyb_loop

            .keyb_loop:
                mov     $0x00,  %ah
                int     $0x16

                cmpb    $49,    %al
                je      mainprg

                jmp     .keyb_loop

            cli
            hlt

    .section    .rodata
        pre_prog_title:     .asciz  " [=]           Account Manager            [=] \r\n"
        pre_prog_msg0:      .asciz  "           Please select an account :"
        pre_prog_msg1:      .asciz  "                   1: Admin"
