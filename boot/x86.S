
            .code16
            .section    .text
            .global     _entry

            .extern     _printk
        
        /*
         *  Entry point (for the linker)
         */
        _entry:
            jmp     _start                  #   Jump over the BBFS
            nop

        /*
         *  Bad Block File System
         *      Parameters
         *
         *  as defined in BBFS specification
         */
        _disk_label:    .asciz  "OS/1 v5.40"#   Disk label, 10 bytes
        _bootable:      .byte   1           #   Bootable: 1-yes, 0-no
        _file_sys:      .asciz  "BBFS V02"  #   File system str. 8 chars.

        /*
         *  Main bootloader function
         */
        _start:
            movb    %dl,    _bd             #   Save boot device num.

            mov     $0x03,  %ax
            int     $0x10

            #   Set pallete register
            mov     $0x1003,%ax
            mov     $0x00,  %bl
            int     $0x10

            #   Set up the font
            mov     $0x11,  %ah
            mov     $0x11,  %al
            int     $0x10

            #
            #   Stack setup
            #
            cli
            mov     $0x9000,%ax
            mov     %ax,    %ss
            mov     $0xF800,%sp
            sti
            
            #   Print boot msg.
            mov     $_sm,   %si
            call    _print

        /*
         *  Read kernel func.
         *
         *  reads 64 sectors.
         */
        _disk_read:

            xor     %ax,    %ax
            mov     %ax,    %es
            
            mov     $0x02,  %ah
            mov     $0x40,  %al
            mov     $0x7e00,%bx
            mov     $0x00,  %ch
            mov     $0x02,  %cl
            mov     $0x00,  %dh
            movb    (_bd),  %dl

            int     $0x13

            jc      _disk_error

            mov     $_ok,   %si
            call    _print

            jmp     0x7e00

        _disk_error:
            mov     $_er,   %si
            call    _print

        _end:
            cli
            hlt

            .section    .rodata
        _sm:    .asciz  "Booting..."
        _ok:    .asciz  "\r\nLoaded."
        _pc:    .asciz  "\r\nPassing control to the kernel...\r\n"
        _er:    .asciz  "\r\nDisk read error!"

            .section    .data
        _bd:    .byte   0
