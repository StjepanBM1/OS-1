
        .code16
        .global     _mp
        .global     _clear_buffer
        .section    .text

    _mp:
        mov     $_buffer,   %di
        xor     %cx,    %cx

    _mp_main:
        mov     $_prompt,   %si
        call    _printk

        xor     %cx,    %cx
        mov     $_buffer,   %di
        call    _input

        mov     $_buffer,   %si
        cmpb    $0x0000,    (%si)
        je      _mp_main

        mov     $_buffer,   %si
        call    _cmd_parser

        mov     $_buffer,   %di
        xor     %cx,    %cx
        call    _clear_buffer

        jmp     _mp_main

    #
    #   Get user input
    #

    _input:
        mov     $0x00,  %ah
        int     $0x16

        cmp     $0x08,  %al
        je      _backspace

        cmp     $0x0D,  %al
        je      _return

        cmp     $0x60,  %cl
        je      _input

        mov     $0x0e,  %ah
        int     $0x10

        stosb
        inc     %cl
        jmp     _input

        _backspace:
            cmp     $0x00,  %cl
            je      _input

            dec     %di
            movb    $0x00,  (%di)
            dec     %cl

            mov     $0x0e,  %ah
            mov     $0x08,  %al
            int     $0x10

            mov     $0x20,  %al
            int     $0x10

            mov     $0x08,  %al
            int     $0x10

            jmp     _input

        _return:
            mov     $0x00,  %al
            stosb

            mov     $0x0e,  %ah
            mov     $0x0d,  %al
            int     $0x10

            mov     $0x0a,  %al
            int     $0x10

            ret

    #
    #   Clear the _buffer
    #
    _clear_buffer:
        mov     $0, %al     # Fill buffer with null characters
        mov     $96, %cx    # Buffer size
        rep stosb          # Clear buffer
        ret

    _end:
        cli
        hlt

        .section    .rodata
    _prompt:    .asciz  "% "            #   command line prompt

    .include    "kernel/mp/cmds.S"

        .section    .data
        .global     _buffer
    _buffer:    .fill   97,1,0         #   maximum of 96 chars (+1 for \0)
