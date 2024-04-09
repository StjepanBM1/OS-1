
        .code16
        .global     _mk_file
        .section    .text

    #
    #   %si - input file
    #   %dl - disk drive
    #
    _mk_file:

        #
        #   save cmd args
        #
        push    %cx

        mov     $_mk_infile,%di
        mov     $16,    %cx
        rep     movsb

        mov     $0x0d,  %al
        stosb
        pop     %cx

        #   does a file with
        #   the same name
        #   already exists
        mov     $_mk_infile,%si
        movb    (_cur_drive),%dl
        call    _find_file
        jc      _mk_exsists

        #   check if there
        #   are any empty spaces
        call    _find_empty
        jnc     _mk_no_space

        #
        #   write the file to disk
        #

        #   move the file name to
        #   0x5000
        push    %cx
        mov     $_mk_infile,%si
        mov     $0x5000,%di
        mov     $16,    %cx
        rep     movsb
        pop     %cx

        mov     $0x03,  %ah
        mov     $0x01,  %al
        mov     $0x5000, %bx
        mov     $0x01,  %cl
        mov     $0x00,  %dh
        int     $0x13

        ret

    _mk_no_space:
        mov     $_mk_dfull, %si
        call    _printk

        ret

    _mk_file_exsits:
        mov     $_mk_exsists,%si
        call    _printk

        ret

        .section    .rodata
    _mk_dfull:      .asciz  "\tNo available disk space.\r\n"
    _mk_exsists:    .asciz  "\tFile with the same name already exists.\r\n"

    _mk_infile:     .fill   17,1,0
