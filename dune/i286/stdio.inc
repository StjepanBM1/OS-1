
    puts16:
        lodsb
        or      al,     al
        jz      .pdone

        mov     ah,     0x0e
        mov     bh,     0x00
        mov     bl,     0xf
        int             0x10

        jmp     puts16

        .pdone:
            ret

    keyb16:
        mov     ax,     0x00
        int             0x16

        mov     ah,     0x0e
        int             0x10

        ret

    clear:
        mov		ax,		0x03
		int				0x10

		mov		ax,		0x1003
		mov		bx,		0x0000
		int				0x10

		mov		ah,		0x11
		mov		al,		0x11
		int				0x10

        ret

    regs16:
        mov     di,     out_str
        mov     ax,     [regs_in]
        mov     si,     hex_str
        mov     cx,     4

        .rloop:
            ;rol ax,     4
            mov bx,     ax
            and bx,     0x0f

            mov bl,     [si + bx]
            mov [di],   bl

            inc di
            dec cx
            jnz         .rloop

            mov si,     out_str
            call        puts16

        ret

    hex_str:    db  '0123456789ABCDEF'
    out_str:    db  '0000', 0
    regs_in:    dw  0

    strcmp:
        .cmpl:
            mov     al,     [si]
            mov     bl,     [di]
            cmp     al,     bl
            jne     .neq

            cmp     al,     0x00
            je      .yeq

            inc     di
            inc     si
            jmp     .cmpl

        .neq:
            clc
            ret

        .yeq:
            stc
            ret
