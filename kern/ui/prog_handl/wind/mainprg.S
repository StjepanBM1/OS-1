
    .section    .text
    .global     mainprg
    .code16

        mainprg:

            call    ui_screen

            jmp     mainprg_wind
        
        mainprg_wind:

            mov     $2,     %ah
            mov     $17,    %dh
            mov     $0,     %dl
            int     $0x10

            mov     $0x09,  %ah
            mov     $40,    %cx
            mov     $32,    %al
            mov     $0x1F,  %bl
            int     $0x10

            mov     $mainprg_title, %si
            call    ui_puts16

            .wind_loop:

                mov     $2, %ah
                inc         %dh
                mov     $0, %dl
                int     $0x10

                mov     $0x09,  %ah
                mov     $40,    %cx
                mov     $32,    %al
                mov     $0xF0,  %bl
                int     $0x10

                cmp     $25,    %dh
                je      .after_win

                jmp     .wind_loop

            .after_win:

                mov     $2, %ah
                mov     $18,%dh
                mov     $0, %dl
                int     $0x10

                mov     $mainprg_items, %si
                call    ui_puts16

                
                mov     $2, %ah
                mov     $25 ,%dh
                mov     $1, %dl
                int     $0x10
                mov     $0x09,  %ah
                mov     $38,    %cx
                mov     $205,   %al
                mov     $0xF0,  %bl
                int     $0x10

                mov     $2, %ah
                mov     $24,%dh
                mov     $0, %dl
                int     $0x10
                mov     $mainprg_prmpt, %si
                call    ui_puts16

            .keyb_codes:
                mov     $0x00,  %ah
                int     $0x16

                cmpb    %al,    cmd_one
                je      .shutdown

                cmpb    %al,    cmd_two
                je      .reboot

                cmpb    %al,    cmd_thr
                je      .logout

                cmpb    %al,    cmd_for
                je      .about

                cmpb    %al,    cmd_fve
                je      .credits

                cmpb    %al,    cmd_six
                je      .console

                cmpb    %al,    cmd_svn
                je      .paint

                cmpb    %al,    cmd_egh
                je      .typew

                jmp     .keyb_codes

                .shutdown:
                    xor     %ax,    %ax
                    xor     %bx,    %bx
                    xor     %bx,    %bx

                    mov     $0x1000,%ax
                    mov     %ss,    %ax
                    mov     $0xf000,%sp
                    mov     $0x5307,%ax
                    mov     $0x0001,%bx
                    mov     $0x0003,%cx
                    int     $0x15

                .reboot:
                    int $0x19

                .logout:
                    call    ui_screen
                    jmp     pre_prog

                .about:
                    mov     $0x02,  %ah
                    mov     $2,    %dh
                    mov     $2,     %dl
                    int     $0x10

                    mov     $0x09,  %ah
                    mov     $32,    %al
                    mov     $0x1F,  %bl
                    mov     $38,    %cx
                    int     $0x10

                    mov     $about_title,   %si
                    call    ui_puts16

                    .about_win:
                        cmp     $8,%dh
                        je      .about_aft

                        mov     $0x02,  %ah
                        inc     %dh
                        int     $0x10

                        mov     $0x09,  %ah
                        mov     $32,    %al
                        mov     $0xF0,  %bl
                        mov     $38,    %cx
                        int     $0x10

                        jmp .about_win

                    .about_aft:
                    mov     $0x02,  %ah
                    mov     $4,    %dh
                    mov     $2,     %dl
                    int     $0x10
                    mov     $about_item1,   %si
                    call    ui_puts16

                    mov     $0x02,  %ah
                    mov     $5,    %dh
                    mov     $2,     %dl
                    int     $0x10
                    mov     $about_item2,   %si
                    call    ui_puts16

                    mov     $0x02,  %ah
                    mov     $6,    %dh
                    mov     $2,     %dl
                    int     $0x10
                    mov     $about_item3,   %si
                    call    ui_puts16

                    mov     $0x02,  %ah
                    mov     $8,    %dh
                    mov     $2,     %dl
                    int     $0x10
                    mov     $about_prompt,   %si
                    call    ui_puts16

                    .about_keyb:
                        mov $0x00,  %ah
                        int $0x16

                        jmp .about_cwin

                    .about_cwin:
                        mov     $0x02,  %ah
                        mov     $1,     %dh
                        mov     $2,     %dl
                        int     $0x10

                        .loop1:
                            cmp $8,    %dh
                            je  .after_win
                    
                            mov $0x02,  %ah
                            inc %dh
                            mov $0,     %dl
                            int $0x10

                            mov $0x09,  %ah
                            mov $40,    %cx
                            mov $32,    %al
                            mov $0xCF,  %bl
                            int $0x10

                            jmp .loop1

                .credits:
                    mov     $0x02,  %ah
                    mov     $2,    %dh
                    mov     $2,     %dl
                    int     $0x10

                    mov     $0x09,  %ah
                    mov     $32,    %al
                    mov     $0x1F,  %bl
                    mov     $38,    %cx
                    int     $0x10

                    mov     $credits_title,   %si
                    call    ui_puts16

                    .cred_win:
                        cmp     $7,%dh
                        je      .cred_aftr

                        mov     $0x02,  %ah
                        inc     %dh
                        int     $0x10

                        mov     $0x09,  %ah
                        mov     $32,    %al
                        mov     $0xF0,  %bl
                        mov     $38,    %cx
                        int     $0x10

                        jmp .cred_win

                    .cred_aftr:

                        mov     $0x02,  %ah
                        mov     $4,    %dh
                        mov     $2,     %dl
                        int     $0x10
                        mov     $credits_item1, %si
                        call    ui_puts16

                        mov     $0x02,  %ah
                        mov     $5,    %dh
                        mov     $2,     %dl
                        int     $0x10
                        mov     $credits_item2, %si
                        call    ui_puts16

                        mov     $0x02,  %ah
                        mov     $7,    %dh
                        mov     $2,     %dl
                        int     $0x10
                        mov     $credits_prompt, %si
                        call    ui_puts16

                        mov     $0x00,  %ah
                        int     $0x16

                        mov     $0x02,  %ah
                        mov     $1,    %dh
                        mov     $2,     %dl
                        int     $0x10

                        .loop3:
                            cmp $7,    %dh
                            je  .after_win
                    
                            mov $0x02,  %ah
                            inc %dh
                            mov $0,     %dl
                            int $0x10

                            mov $0x09,  %ah
                            mov $40,    %cx
                            mov $32,    %al
                            mov $0xCF,  %bl
                            int $0x10

                            jmp .loop3

                .console:
                    jmp     console

                .paint:
                    jmp     paint16

                .typew:
                    jmp     type16

            cli
            hlt

    /*

        #   1-5 > FINISH BY 22.02
        #   6-8 > FINISH BY 01.03

        1.  Shutdown    5.  Credits
        2.  Reboot      6.  Console
        3.  Logout      7.  Paint
        4.  About       8.  Write
    */

    .section    .rodata
        #   Commonds
        cmd_one:        .byte   '1'
        cmd_two:        .byte   '2'
        cmd_thr:        .byte   '3'
        cmd_for:        .byte   '4'
        cmd_fve:        .byte   '5'
        cmd_six:        .byte   '6'
        cmd_svn:        .byte   '7'
        cmd_egh:        .byte   '8'

        #   Strings
        mainprg_title:  .asciz  " [ Program Handler 2.0.0 ][ Drive : ? ] "
        mainprg_items:  .asciz  "\r\n  (1) Shutdown  (5) Credits\r\n  (2) Reboot    (6) Console\r\n  (3) Logout    (7) Paint\r\n  (4) About     (8) Write\r\n"
        mainprg_prmpt:  .asciz  " [?]: "
        
        #   About
        about_title:    .asciz  "              About OS/1            "
        about_item1:    .asciz  "   Operating System One 2.0.0    "
        about_item2:    .asciz  "   Build 01.03.7E7.GNU_AS "
        about_item3:    .asciz  "   Kernel version [0xC8]"
        about_prompt:   .asciz  "      [ Press any key to exit ]"

        #   Credits
        credits_title:  .asciz  "               Credits            "
        credits_item1:  .asciz  "   Main developer : Stjepan B. M."
        credits_item2:  .asciz  "   Console basis  : OS-Dev wiki."
        credits_prompt: .asciz  "      [ Press any key to exit ]"
