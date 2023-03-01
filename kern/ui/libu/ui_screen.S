
    .section    .text
    .global     ui_screen
    .global     ui_puts16
    .global     ui_clear
    .code16

        ui_puts16:
            lodsb
            or      %al,    %al
            jz      .ui_puts16_d

            mov     $0x0e,  %ah
            mov     $0x00,  %bh
            int     $0x10

            jmp     ui_puts16

            .ui_puts16_d:   ret
        
        ui_clear:
            pusha
            
            mov     $0x00,  %ah
            mov     $0x03,  %al
            int     $0x10

            mov     $0x1003,%ax
            mov     $0x00,  %bx
            int     $0x10

            mov     $0x11,  %ah
            mov     $0x11,  %al
            int     $0x10

            popa
            ret

        ui_screen:
            call    ui_clear

            xor     %al,    %al

            .backg:
                mov     $0x09,  %ah
                mov     $2240,  %cx
                mov     $32,    %al
                mov     $0xCF,  %bl
                int     $0x10

                jmp     .taskb

            .taskb:
        
                mov     $2,     %ah
                mov     $27,    %dh
                mov     $0,     %dl
                int     $0x10

                mov     $builds,%si
                call    ui_puts16
                ret

            ret

    .section    .rodata
        builds:     .asciz  "Build 01.03.7E7.GNU_AS"
