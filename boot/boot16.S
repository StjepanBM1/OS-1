
    [ORG    0x7c00]
    [CPU       386]
    [BITS       16]

    JMP     _start

        _start:
            mov     [BOOTD],  dl

            mov     bp, 0x7c00
            mov     sp, bp

            call    clear
            call    screen

            call    disk_read

            jmp     PRG_SPACE

        ;   Includes
        %include "../lib/txt16.S"
        %include "../lib/disk16.S"

    TIMES 510-($-$$) DB 0
    DW 0xaa55
