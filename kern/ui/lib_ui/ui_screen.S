
    _ui_clear:
        pusha

        mov     ax, 03h
        int         0x10

        ;   Stop blinking
        mov ax, 1003h
        mov bx, 0
        int 10h

        popa
        ret

    _ui_backgr:
        
        xor     al, al

        ;mov	ah,	09h
		;mov	cx,	2000d
		;mov	al,	32d
		;mov	bl,	0xCF
		;int		0x10
        
        mov	ah,	09h
		mov	cx,	2000d
		mov	al,	177d    ;   177d
		mov	bl,	0x17
		int		0x10

        ret

    _ui_screen:
        call    _ui_clear
        call    _ui_backgr
        call    _ui_main_window

        ret
