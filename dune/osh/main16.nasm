
        %include    "osh/inc/cmd.inc"

    _main_osh:

        mov     si,     prompt
        call    puts16
        
        mov     di,     buffer
        call    get_str

        mov     si,     buffer
        cmp     byte [si], 0
        je      _main_osh

        mov     si,     buffer
        mov     di,     cmd_ver
        call    strcmp
        jc      .ver

        mov     si,     buffer
        mov     di,     cmd_test
        call    strcmp
        jc      .test

        mov     si,     buffer
        mov     di,     cmd_mem
        call    strcmp
        jc      .mem

        mov     si,     buffer
        mov     di,     cmd_reboot
        call    strcmp
        jc      .reboot

        mov     si,     buffer
        mov     di,     cmd_expl
        call    strcmp
        jc      .expl

        mov     si,     buffer
        mov     di,     cmd_clear
        call    strcmp
        jc      .clear

        mov     si,     buffer
        mov     di,     cmd_text
        call    strcmp
        jc      .ed

        mov     si,     str_err
        call    puts16
        hlt

        jmp     _main_osh

    .ed:
        mov     ax,     0x0003
        int             0x10
        call    _main_ed

    .clear:
        mov     ax,     0x0003
        int             0x10

        jmp     _main_osh

    .shutdown:
        xor     ax,     ax
        xor     bx,     bx

        mov     ax,     0x1000
        mov     ax,     ss
        mov     sp,     0xf000
        mov     ax,     0x5307
        mov     bx,     0x0001
        mov     cx,     0x0003
        int     0x15

    .expl:
        mov     si,     str_expl
        call    puts16

        jmp     _main_osh

    .reboot:
        mov     si,     str_rebt
        call    puts16

        mov     ax,     0x00
        int             0x16
        int     0x19

    .mem:
        mov     si,     str_mem
        call    puts16

        xor     ax,     ax
        clc
        int     0x12

        mov     word[regs_in], ax
        call    regs16

        call    get_str.return

        jmp     _main_osh

    .ver:
        mov     si,     str_ver
        call    puts16

        jmp     _main_osh

    .test:
        mov     si,     str_test
        call    puts16

        jmp     _main_osh

    get_str:
        xor     cl,     cl

        .loop:
            mov     ah, 0x00
            int         0x16

            cmp     al, 0x08
            je      .backpsace

            cmp     al, 0x0d
            je      .return

            cmp     cl, 0xFF
            je      .loop

            mov     ah, 0x0e
            int         0x10

            stosb
            inc     cl
            jmp     .loop

        .backpsace:
            cmp     cl, 0x00
            je      .loop

            dec     di
            mov     byte [di],  0
            dec     cl

            mov     ah, 0x0e
            mov     al, 0x08
            int         0x10

            mov     al, ' '
            int         0x10

            mov     al, 0x08
            int         0x10

            jmp     .loop

        .return:
            mov     al, 0x00
            stosb

            mov     ah, 0x0e
            mov     al, 0x0d
            int         0x10

            mov     al, 0x0a
            int         0x10

            ret
