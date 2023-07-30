
        /*
            Status messages taken from:
                https://stanislavs.org/helppc/int_s_03-1.html
         */

            .code16
            .section    .text.libk
            .global     _disk_status

        #
        #   Check for disk drive errors
        #
        _disk_status:
            mov     $0x01,  %ah
            int     $0x13

            movb    %al,    (_ec)

            mov     $_s_XX, %si
            call    _printk

            xor     %ax,    %ax

            movb    (_ec),  %al

            #
            #   There is probably a macro that could some all of my issues here
            #   but I'm to lazy to play around with GAS macros. So here it is:
            #   the CMP monster.
            #
            #   TODO:   Use macros!
            #

            cmp     $0x00,  %al
            je      _00

            cmp     $0x01,  %al
            je      _01

            cmp     $0x02,  %al
            je      _02

            cmp     $0x03,  %al
            je      _03

            cmp     $0x04,  %al
            je      _04

            cmp     $0x05,  %al
            je      _05

            cmp     $0x06,  %al
            je      _06

            cmp     $0x07,  %al
            je      _07

            cmp     $0x08,  %al
            je      _08

            cmp     $0x09,  %al
            je      _09

            cmp     $0x0A,  %al
            je      _0A

            cmp     $0x0B,  %al
            je      _0B

            cmp     $0x0C,  %al
            je      _0C

            cmp     $0x0D,  %al
            je      _0D

            cmp     $0x0E,  %al
            je      _0E

            cmp     $0x0F,  %al
            je      _0F

            cmp     $0x10,  %al
            je      _10

            cmp     $0x11,  %al
            je      _11

            cmp     $0x20,  %al
            je      _20

            cmp     $0x40,  %al
            je      _40

            cmp     $0x80,  %al
            je      _80

            cmp     $0xAA,  %al
            je      _AA

            cmp     $0xBB,  %al
            je      _BB

            cmp     $0xCC,  %al
            je      _CC

            cmp     $0xE0,  %al
            je      _E0

            cmp     $0xFF,  %al
            je      _FF

            ret

        _00:
            mov     $_s_00,   %si
            call    _printk
            ret

        _01:
            mov     $_s_01,   %si
            call    _printk
            ret

        _02:
            mov     $_s_02,   %si
            call    _printk
            ret
            
        _03:
            mov     $_s_03,   %si
            call    _printk
            ret

        _04:
            mov     $_s_04,   %si
            call    _printk
            ret

        _05:
            mov     $_s_05,   %si
            call    _printk
            ret

        _06:
            mov     $_s_06,   %si
            call    _printk
            ret

        _07:
            mov     $_s_07,   %si
            call    _printk
            ret

        _08:
            mov     $_s_08,   %si
            call    _printk
            ret

        _09:
            mov     $_s_09,   %si
            call    _printk
            ret

        _0A:
            mov     $_s_0A,   %si
            call    _printk
            ret

        _0B:
            mov     $_s_0B,   %si
            call    _printk
            ret
            
        _0C:
            mov     $_s_0C,   %si
            call    _printk
            ret

        _0D:
            mov     $_s_0D,   %si
            call    _printk
            ret

        _0E:
            mov     $_s_0E,   %si
            call    _printk
            ret

        _0F:
            mov     $_s_0F,   %si
            call    _printk
            ret

        _10:
            mov     $_s_10,   %si
            call    _printk
            ret

        _11:
            mov     $_s_11,   %si
            call    _printk
            ret

        _20:
            mov     $_s_20,   %si
            call    _printk
            ret

        _40:
            mov     $_s_40,   %si
            call    _printk
            ret

        _80:
            mov     $_s_80,   %si
            call    _printk
            ret
        
        _AA:
            mov     $_s_AA,   %si
            call    _printk
            ret
        
        _BB:
            mov     $_s_BB,   %si
            call    _printk
            ret
        
        _CC:
            mov     $_s_CC,   %si
            call    _printk
            ret
        
        _E0:
            mov     $_s_E0,   %si
            call    _printk
            ret
        
        _FF:
            mov     $_s_FF,   %si
            call    _printk
            ret

        _ec:    .byte   0

            .section    .rodata
        _s_XX:    .asciz  " Disk status:"

        #
        #   A lot of strings!
        #

        _s_00:    .asciz  "  No disk drive error\r\n"
        _s_01:    .asciz  "  Bad command passed to the disk driver\r\n"
        _s_02:    .asciz  "  Address mark not found / Bad sector\r\n"
        _s_03:    .asciz  "  Diskette write protect error\r\n"
        _s_04:    .asciz  "  Sector not found\r\n"
        _s_05:    .asciz  "  Fixed disk reset failed\r\n"
        _s_06:    .asciz  "  Diskette changed or removed\r\n"
        _s_07:    .asciz  "  Bad fixed disk parameter table\r\n"
        _s_08:    .asciz  "  DMA overrun\r\n"
        _s_09:    .asciz  "  DMA access across 64K boundry\r\n"
        _s_0A:    .asciz  "  Bad fixed disk sector flag\r\n"
        _s_0B:    .asciz  "  Bad fixed disk cylinder\r\n"
        _s_0C:    .asciz  "  Unsupported track/invalid media\r\n"
        _s_0D:    .asciz  "  Invalid number of sectors on a fixed disk format\r\n"
        _s_0E:    .asciz  "  Fixed disk controlled data address mark detected\r\n"
        _s_0F:    .asciz  "  Fixed disk DMA arbitration level out of range\r\n"
        _s_10:    .asciz  "  ECC/CRC error on disk read\r\n"
        _s_11:    .asciz  "  Recoverable fixed disk data error, data fixed by ECC\r\n"
        _s_20:    .asciz  "  Controller error (NEC for diskettes)\r\n"
        _s_40:    .asciz  "  Seek failure\r\n"
        _s_80:    .asciz  "  Time out, drive not ready\r\n"
        _s_AA:    .asciz  "  Fixed disk, drive not ready\r\n"
        _s_BB:    .asciz  "  Fixed disk undefined error\r\n"
        _s_CC:    .asciz  "  Fixed disk write fault on selected drive\r\n"
        _s_E0:    .asciz  "  Fixed disk status error / Error reg = 0\r\n"
        _s_FF:    .asciz  "  Sense operation failed\r\n"