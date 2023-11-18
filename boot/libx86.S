
            .code16
            .global     _print
            .section    .text
        _print:
            lodsb

            or      %al,    %al
            jz      .p_done

            mov     $0x0e,  %ah
            int     $0x10

            jmp     _print

            .p_done:
                ret
