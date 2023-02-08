
    doch: call putc

    ;   puts -> print str.
    puts:
        lodsb
        cmp     al, 0
        jne     doch

        add     byte [YPOS], 1
        mov     byte [XPOS], 0

        .done:
            ret

    ;   putc -> print char.
    putc:
        mov     ah, 0x1F
        mov     cx, ax

        movzx   ax, byte [YPOS]

        mov     dx, 160
        mul     dx
        
        movzx   bx, byte [XPOS]

        shl     bx, 1


        mov     di, 0
        add     di, ax
        add     di, bx

        .done:
            mov ax, cx
            stosw
            add byte [XPOS], 1
            ret

    ;   regs -> print regs.
    regs:
        mov     di, otus
        mov     ax, [regi]
        mov     si, hexs
        mov     cx, 4

        .hexloop:
            rol ax, 4
            mov bx, ax
            and bx, 0x0f
            mov bl, [si + bx]
            mov [di], bl
            inc di
            dec cx
            jnz .hexloop

            mov     si, otus
            call    puts

        .done:
            ret
        
    ;   clear   ->  clears the screen
    clear:
        pusha

        mov     ah, 0x00
        mov     al, 0x03
        int         0x10
        
        .done:
            popa
            ret

    ;   screen  ->  sets the screen color to 0x1F
    screen:
        xor     al, al
        
        mov     ah, 09h
        mov     cx, 2000d
        mov     al, 32d
        mov     bl, 0x1F
        int         0x10
        
        ret

    ;   Variables
    XPOS:   db  0
    YPOS:   db  0
    hexs:   db  '0123456789ABCDEF'
    otus:   db  '0000', 0
    regi:   dw  0
    msg0:   db  "Starting OS/1 ... Build [", BUILD ,"]" 0
