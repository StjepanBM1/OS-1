
            .code16
            .section    .text.libk

            .global     _printk
            .global     _printk_wh
            .global     _printk_gr
            .global     _printk_rc

            .global     _strcmp


        #
        #   _printk:    standard print string function
        #
        _printk:
            mov     $0x0e,  %ah
            
            ._printk_l:
                lodsb
                
                cmp $0x00,  %al
                je  ._printk_d

                int $0x10

                jmp ._printk_l

            ._printk_d:
                ret

        #
        #   _printk_wh: print a string in a "random" color
        #
        _printk_rc:
            add     $0x01,  %bl
            mov     $0x0e,  %ah
            
            ._prc_l:
                lodsb
                
                cmp $0x00,  %al
                je  ._prc_d

                add $0x01,  %bl
                int $0x10

                jmp ._prc_l

            ._prc_d:
                ret

        #
        #   _printk_bl: print a string in black
        #
        _printk_bl:
            mov     $0x00,  %bl
            mov     $0x0e,  %ah
            
            ._pgr_l:
                lodsb
                
                cmp $0x00,  %al
                je  ._pgr_d

                int $0x10

                jmp ._pgr_l

            ._pgr_d:
                ret
        
        #
        #   _printk_wh: print a string in white
        #
        _printk_wh:
            mov     $0x0F,  %bl
            mov     $0x0e,  %ah
            
            ._pwh_l:
                lodsb
                
                cmp $0x00,  %al
                je  ._pwh_d

                int $0x10

                jmp ._pwh_l

            ._pwh_d:
                ret

        #
        #   _strcmp:    compare two strings in registers
        #               %di and %si
        #
        _strcmp:
            _strcmp_l:
                mov     (%si),  %al
                mov     (%di),  %bl
                cmp     %bl,    %al
                jne     _notequal

                cmp     $0x00,  %al
                je     _strcmp_d

                inc     %di
                inc     %si

                jmp     _strcmp_l

            _notequal:
                clc
                ret

            _strcmp_d:
                stc
                ret
