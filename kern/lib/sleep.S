    ;   slow -> stops for a few seconds
    slow:
        mov     cx, 0Fh
        mov     dx, 4240h
        mov     ah, 86h
        int         0x15

        ret