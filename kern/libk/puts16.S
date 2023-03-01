
    .section    .text
    .global     puts16
    .code16

        #   Print str. func. (kernel)
        puts16:
            lodsb
            or      %al,    %al
            jz      .done

            mov     $0x0e,  %ah
            mov     $0x00,  %bh
            int     $0x10

            jmp     puts16

            .done:
                ret
                