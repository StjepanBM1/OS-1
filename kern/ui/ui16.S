
    .section    .text
    .global     _ui16
    .code16

        _ui16:

            call    ui_screen

            jmp     prog16

            cli
            hlt
