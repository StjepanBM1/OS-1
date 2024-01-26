            
            .code16
            .global     _printk
            .global     _preg
            .global     _clear
            .global     _strcmp
            .section    .text.libk

        #
        #   _clear:     clears the screen
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
        #   _printk:    prints strings in SI register
        #
        _printk:
            lodsb

            or      %al,    %al
            jz      .pk_done

            cmp     $0x09,  %al
            je      .handle_tab

            mov     $0x0e,  %ah
            int     $0x10

            jmp     _printk

            .handle_tab:
                mov $0x0e,  %ah
                mov $' ',   %al
                int $0x10
                int $0x10
                int $0x10
                int $0x10

                jmp _printk

            .pk_done:
                ret
        #
        #   _preg:  prints value of a register
        #
        _preg:
            mov     $ostr,  %di
            mov     (regi), %ax
            mov     $hstr,  %si
            mov     $0x04,  %cx

            .preg_loop:
                rol $0x04,  %ax                #   Might cause problems later on, if enabled pc returns an error
                mov %ax,    %bx
                and $0x0f,  %bx

                movb (%bx, %si), %bl

                movb %bl,    (%di)

                inc %di
                dec %cx

                jnz .preg_loop

                mov $ostr,  %si
                call    _printk

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

            .section    .data
            .global     regi
        ostr:   .asciz  "0000 "
        hstr:   .asciz  "0123456789ABCDEF"
        
        regi:   .word   0