
    .section    .text
    .global     prog16
    .code16

        prog16:

            call    pre_prog

            cli
            hlt
