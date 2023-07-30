
            .code16
            .section    .text.libk

            .global     _clear
            .global     _set_GM

        #
        #   _clear:     clear the screen, and set the resolution to 80x28
        #
        _clear:
            mov     $0x03,  %ax
            int     $0x10

            #   Set pallete register
            mov     $0x1003,%ax
            mov     $0x00,  %bl
            int     $0x10

            #   Set up the font
            mov     $0x11,  %ah
            mov     $0x11,  %al
            int     $0x10

            ret

        #
        #   _set_GM:   clear the screen and set to the graphics mode
        #
        _set_GM:
            mov     $0x00,  %ah
            mov     $0x06,  %al
            int     $0x10

            ret
