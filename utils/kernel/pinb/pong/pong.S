
            .code16
            .section    .text.pinb.app
            .global     _pong

        _pong:
            call        _clear

            mov     $_expl, %si
            call    _printk

            mov     $0x00,  %ax
            int     $0x16

            jmp     _pinb

            cli
            hlt

            .section    .rodata.pinb
        _expl:      .asciz  "Pong has been removed from OS/1 5.0.0 for being to buggy.\r\nIt will be back in the next Service Pack\r\nAny key to return to Pinboard"
