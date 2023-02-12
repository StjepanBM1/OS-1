
    %define BUILD '0.0.7'

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

    ;   Variables
    XPOS:   db  0
    YPOS:   db  0
    hexs:   db  '0123456789ABCDEF'
    otus:   db  '0000', 0
    regi:   dw  0
    msg0:   db  "[1/5] ===> Starting OS/1 ... Build [", BUILD ,"]", 0
    msg1:   db  "[2/5] ===> Reading from the disk...", 0
    msg2:   db  "[3/5] ===> Disk read, loading the kernel...", 0
    msg3:   db  "[4/5] ===> Kernel loaded!", 0
    msg4:   db  "[5/5] ===> Starting the user interface...", 0

    derr1:  db  "===> ERROR : DISK READ FAILED | Reboot...", 0
