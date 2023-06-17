
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
        mov     di,     cmd_shutdw
        call    strcmp
        je      .shutdown

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

        mov     si,     buffer
        mov     di,     cmd_pinb
        call    strcmp
        jc      .pinb

        mov     si,     buffer
        mov     di,     cmd_fmrt
        call    strcmp
        jc      .format

        mov     si,     buffer
        mov     di,     cmd_help
        call    strcmp
        jc      .help


        mov     si,     str_err
        call    puts16
        hlt

        jmp     _main_osh

    .help:
        mov     si, str_help
        call    puts16

        jmp     _main_osh
    .format:
        mov     ah, 0x09
        mov     al, 0x20
        mov     bh, 0x00
        mov     bl, 0x0c
        mov     cx, 44
        int     0x10

        mov     si,     str_f_v1
        call    puts16

        mov     ax,     0x00
        int             0x16

        cmp     al,     'y'
        je      .do_f

        cmp     al,     'Y'
        je      .no_f

        cmp     al,     'n'
        je      .no_f

        cmp     al,     'N'
        je      .no_f

        mov     si,     newl
        call    puts16

        jmp     .format

        .no_f:
            mov ah, 0x0e
            int     0x10
            mov si, newl
            call    puts16

            jmp _main_osh

        .do_f:
            mov ah, 0x0e
            int     0x10

            mov si, newl
            call puts16

            xor ax, ax
            xor cl, cl

            .f_loop:
                mov ah, 0x03
                mov al, 64
                mov bx, 0x5000
                mov ch, 0x00
                inc cl
                mov dh, 0x00
                mov dl, 0x00
                int     0x13

                cmp cl, 64
                je  .done_f

                jmp .f_loop

            .done_f:
                mov     ah, 0x09
                mov     al, 0x20
                mov     bh, 0x00
                mov     bl, 0x0a
                mov     cx, 44
                int     0x10
                mov si, str_f_2
                call puts16

                jmp _main_osh

    .pinb:
        jmp     pinb

    .ed:
        mov     ax,     0x0003
        int             0x10
        call    _main_ed

    .clear:
        call    clear
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
