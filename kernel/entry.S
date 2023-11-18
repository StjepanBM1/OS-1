
            .code16
            .global     _entry
            .section    .text.kernel
        
            .extern     _printk
        
            .extern     _gdt_info

            .extern     _bbfs_read_sector
            .extern     bbfs_get_params

        _entry:
            xor     %ax,    %ax
            int     $0x13

            #   Stack
            xor     %ax,    %ax
            mov     %ax,    %ds
            mov     %ax,    %ss
            mov     $_entry,%sp
            cld

            mov     $msg0,  %si
            call    _printk

            #
            #   GDT & Unreal mode
            #
            xor     %ax,    %ax
            mov     %ax,    %ds
            mov     %ax,    %ss
            mov     $0x7e00,%sp
            cld

            cli                     #   clear interrupts
            push    %ds             #   save %ds

            lgdt    _gdt_info       #   load gdt

            mov     %cr0,   %eax    #   switch to protected mode
            or      $1,     %al     #   setting the protected
            mov     %eax,   %cr0    #   mode bit
            
            mov     $0x08,  %bx     #   select  descriptor 1
            mov     %bx,    %ds     #   0x08 =  1000B

            and     $0xFe,  %al     #   back to real mode
            mov     %eax,   %cr0    #   toggling the bit again
            
            pop     %ds             #   restore %ds
            sti                     #   enable the ints.

            mov     $msg1,  %si
            call    _printk

            call    _bbfs_bread_sector

            call    bbfs_get_params

            mov     $_mp_str_title, %si
            call    _printk

            jmp     _input

            cli
            hlt

            .section    .rodata.kernel
        msg0:   .asciz  "\r\nControl passed to the kernel.\r\n"
        msg1:   .asciz  "Switched to unreal mode.\r\n"
        _mp_str_title:  .asciz  "\r\n\xDB Monitor Program for OS/1 (MP-OS/1) Version 1.2.0\r\n To start the GUI type pinb\r\n"