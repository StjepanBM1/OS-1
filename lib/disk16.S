
    PRG_SPACE   equ     0x7e00

    disk_read:
        mov     ah,     0x02
        mov     bx,     PRG_SPACE
        mov     al,     16
        mov     dl,     [BOOTD]
        mov     ch,     0x00
        mov     dh,     0x00
        mov     cl,     0x02

        int             0x13

        jc      disk_fail

        ret

    BOOTD:  db  0

    disk_fail:
        pusha
        mov     ah, 0x00
        mov     al, 0x03
        int         0x10
        popa

        xor     al, al
        
        mov     ah, 09h
        mov     cx, 2000d
        mov     al, 32d
        mov     bl, 0x4F
        int         0x10

        mov     si,     derr1
        call            puts

        jmp     $
