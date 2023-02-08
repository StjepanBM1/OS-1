
    [ORG    0x7c00]
    [CPU       386]
    [BITS       16]

    JMP     _start

        _start:
            mov     [BOOTD],  dl

            mov     bp, 0x7c00
            mov     sp, bp

            pusha
            mov     ah, 0x00
            mov     al, 0x02
            int         0x10
            popa

            xor     al, al
            
            mov     ah, 09h
            mov     cx, 2000d
            mov     al, 32d
            mov     bl, 0x1F
            int         0x10

            call    disk_read

            jmp     PRG_SPACE


        ;   Includes
        %include "../lib/txt16.S"
        %include "../lib/disk16.S"

    TIMES 510-($-$$) DB 0
    DW 0xaa55
