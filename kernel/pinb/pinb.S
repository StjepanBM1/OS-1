            .code16
            .section    .text.pinb
            .global     _pinb

            .extern     _shell

        _pinb:
            .start:
                call    _clear
                mov     $_pm_0,     %si
                call    _printk

            .screen:
                call    _clear

                mov     $0x09,      %ah
                mov     $0x20,      %al
                mov     $0x00,      %bh
                mov     $0x1F,      %bl
                mov     $2240,      %cx
                int     $0x10
            
            .t_bar:
                mov     $0x02,      %ah
                mov     $00,        %dh
                mov     $00,        %dl
                int     $0x10

                mov     $0x09,      %ah
                mov     $0x20,      %al
                mov     $0x00,      %bh
                mov     $0xF1,      %bl
                mov     $80,        %cx
                int     $0x10

                mov     $_bar,      %si
                call    _printk

            .bt_str:
                mov     $0x02,      %ah
                mov     $27,        %dh
                mov     $44,        %dl
                int     $0x10
                mov     $_pm_0,     %si
                call    _printk

            .end:
                jmp     _desk_curs

                cli
                hlt

            .section    .rodata.pinb
        _pm_0:      .asciz  " Pinboard Enviroment for OS/1 5.0.0"
        _bar:       .asciz  "  \xB3 Home \xB3"
