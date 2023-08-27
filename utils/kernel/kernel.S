
            .code16
            .section    .text.kern
            .global     _kernel

            .extern     _printk
            .extern     _panic

            .extern     _load_A
            .extern     _load_B

            .extern     _format_A
            .extern     _format_B

            .extern     _input

            .extern     _pinb

        _kernel:                                    #   Kernel entry point
            xor     %ax,    %ax                     #   Reset the disk system
            int     $0x13

            call    _clear

            #   Stack   Setup
            xor     %ax,    %ax
            mov     %ax,    %ds
            mov     %ax,    %ss
            mov     $_kernel,%sp
            cld

            #   Print boot msg. #2
            mov     $0x13,  %ah                     #   Value 0x13 (print str.)
            mov     $0x01,  %al                     #   String type
            mov     $0x00,  %bh                     #   Video page num.
            mov     $0x0f,  %bl                     #   Attribute (White on Black)
            mov     $0x0B,  %cx                     #   String len. = 13 chars.
            mov     $0x00,  %dh                     #   Row 2
            mov     $0x00,  %dl                     #   Column 0
            mov     $_msg1, %bp                     #   String to print
            int     $0x10                           #   Call interrupt

            #   Setup   Stack
            xor     %ax,    %ax
            mov     %ax,    %ds
            mov     %ax,    %ss                     #   Stack start = 0
            mov     $0x7e00,%sp                     #   Stack pointer = 0x7e00

            cli                                     #   Clear ints.
            push    %ds                             #   Save %ds

            lgdt    _gdt_inf                        #   Load the GDT

            mov     %cr0,   %eax                    #   Switch to Prot. Mode
            or      $1,     %al                     #   By setting the
            mov     %eax,   %cr0                    #   Prot. Mode bit

            mov     $0x08,  %bx                     #   Select desc. 1
            mov     %bx,    %ds                     #   0x08 = 1000b

            and     $0xFE,  %al                     #   Back to real mode
            mov     %eax,   %cr0                    #   by toggling the bit agian

            pop     %ds                             #   Return the %ds
            sti                                     #   Store ints.

            #   Load MP-OS/1
            #call    _monitor_program

            call    _clear

            mov     $_mp_str_title, %si
            call    _printk

            jmp     _input

            cli
            hlt

            .section    .rodata                     #   Read-only data
        _msg1:  .asciz  "\xDB\xDB\xDB OS/1 WE"      #   Boot message (2/2).
        _mp_str_title:  .asciz  "\xDB Monitor Program for OS/1 (MP-OS/1) Version 1.0.0\r\n To start the GUI type pinb\r\n"