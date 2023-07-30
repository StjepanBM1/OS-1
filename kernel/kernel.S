
            .code16
            .section    .text.kern
            .global     _kernel

            .extern     _printk

        .fill   218, 1, 0
        jmp     _kernel

        _kernel:
            xor     %ax,    %ax
            xor     %dx,    %dx
            mov     %ax,    %es
            mov     %ss,    %ax
            mov     $_kernel,%sp

            call        _clear

            mov     $_msg2,     %si
            call    _printk

            jmp     _pinb

            cli
            hlt

            .section    .rodata
        _msg2:      .asciz  "\xDB\xDB\xDB OS/1 5.0.0\r\n"
