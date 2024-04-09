
        .code16
        .global     _set_ivt
        .global     _add_interrupt

        .section    .text

    _set_ivt:
        
        #   int. 0x30
        movb     $0x30,  %al
        movw     $_int_0x30, %si
        call    _add_interrupt

        #   int. 0x31
        movb     $0x31,  %al
        movw     $_int_0x31, %si
        call    _add_interrupt

        #   int. 0x32
        movb     $0x32,  %al
        movw     $_int_0x32, %si
        call    _add_interrupt

        #   int. 0x40
        movb     $0x40,  %al
        movw     $_int_0x40, %si
        call    _add_interrupt

        #   int. 0x41
        movb     $0x41,  %al
        movw     $_int_0x41, %si
        call    _add_interrupt

        ret

    #
    #   Add interrupt to the IVT
    #
    #   %al - int numb.
    #   %si - int. handler
    #
    _add_interrupt:
        push    %ax

        xor     %ax,    %ax
        mov     %ax,    %es

        pop     %ax

        mov     $0x04,  %bl
        mul     %bl
        mov     %ax,    %bx

        movw    %si,    %es:(%bx)
        add     $2,     %bx

        movw    %cs,    %es:(%bx)

        ret

    #******************
    #
    #   INTERRUPTS
    #
    #*************************

    #
    #   interrupt 0x30:
    #
    #       - no parameters
    #
    #       - terminate program
    #         and return control
    #         to the OS
    #
    _int_0x30:
        jmp     0x500
        iret

    #
    #   interrupt 0x31:
    #
    #       %si - file name
    #       %dl - disk drive
    #
    #       - create a file on a disk
    #
    _int_0x31:
        call    _mk_file
        iret

    #
    #   interrupt 0x32:
    #
    #       %si - file name
    #       %dl - disk drive
    #
    #       - find a file from the
    #         disk drive
    _int_0x32:
        call    _find_file
        iret

    #
    #   interrupt 0x33:
    #
    #       %si - file name
    #       %dl - disk drive
    #
    #       - delete a file
    #         from the disk
    _int_0x33:
        call    _rm_file
        iret

    #
    #   interrupt   0x40:
    #
    #       %si - string input
    #
    #       - print str. in %si
    #
   _int_0x40:
        call    _printk
        iret

    #
    #   interrupt 0x41:
    #
    #       - no parameters
    #
    #       - clear the screen
    #         and set it to 80x28
    #         resolution
    #
    _int_0x41:
        #   clear scr.
        mov     $0x03,      %ax
        int     $0x10

        #   Set pallete register
        mov     $0x1003,    %ax
        mov     $0x00,      %bl
        int     $0x10

        #   Set up the font
        mov     $0x11,      %ah
        mov     $0x11,      %al
        int     $0x10
        iret
