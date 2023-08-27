
            .code16
            .section    .text.pinb.app
            .global     _words

        _words:
            call        _clear

            cli
            hlt
