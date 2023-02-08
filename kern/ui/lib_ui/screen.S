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
