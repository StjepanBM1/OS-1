
    format:
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

        jmp     format

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

            mov     ah, 0x09
            mov     al, 0x20
            mov     bh, 0x00
            mov     bl, 0x0f
            mov     cx, 143
            int     0x10
            mov si, str_f_1
            call puts16

            mov ax, 0x00
            int     0x16

            cmp al, 0x0d
            je  .fd

            jmp .do_f

            .fd:
                mov ah, 0x0e
                int     0x10
                xor cx, cx
                xor dx, dx

                .d1:
                    mov ah, 0x03
                    mov al, 64
                    mov bx, 0x8002
                    mov ch, 0x00
                    inc cl
                    mov dh, 0x00
                    mov dl, 0x00
                    int     0x13

                    cmp cl, 64
                    je  .done_f

                    jmp .d1

            .error:
                mov si, newl
                call puts16
                mov     ah, 0x09
                mov     al, 0x20
                mov     bh, 0x00
                mov     bl, 0x0c
                mov     cx, 80
                int     0x10
                mov si, str_f_e
                call puts16

                mov ax, 0x00
                int     0x16
                int     0x19

            .done_f:

                mov si, newl
                call puts16

                mov     ah, 0x09
                mov     al, 0x20
                mov     bh, 0x00
                mov     bl, 0x0a
                mov     cx, 80
                int     0x10
                mov si, str_f_2
                call puts16
                ret

    ;**********************************
    str_f_v1:       db  " This will erase all the data on the disk!",13,10," Are you sure (y/n)? ", 0
    str_f_1:        db  " Make sure to insert a diskette that has less than 32KB of data written to it.",13,10, \
                    " Insert the diskette you wish to format and press return (",0x11,0xc4,0xd9,") ", 0
    str_f_2:        db  " Format complete! Reinsert the System Diskette.",13,10, " Reboot recommended",13,10,0
    str_f_e:        db  " Disk error! Any key to reboot.", 0
