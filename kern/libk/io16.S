
    .section    .text
    .global     slow
    .global     strcmp
    .code16

        #   Slows down the system
        slow:
            mov     $0x0F,  %cx
            mov     $0x4240,%dx
            mov     $0x86,  %ah
            int     $0x15

            ret

        #   String compare
        strcmp:
            .strcmp_loop:
                
                mov     (%si),  %al
                mov     (%di),  %bl
                cmp     %al,    %bl
                jne     .strcmp_notq

                cmp     0x00,   %al
                je      .strcmp_done

                inc     %di
                inc     %si
                jmp     .strcmp_loop

            .strcmp_notq:
                clc
                ret

            .strcmp_done:
                stc
                ret
