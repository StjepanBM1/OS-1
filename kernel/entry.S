
        .code16
        .global     _kernel_start
        .section    .text.main

    _file:  .ascii  "KERNEL-6-0-0.SYS"     #   12 char file name and a 3 char file exst.

    _kernel_start:
        #
        #   Stack setup
        #
        xor     %ax,    %ax
        mov     %ax,    %ds
        mov     %ax,    %ss
        mov     $0x7e00,%sp
        cld

        #
        #   Load GDT
        #
        cli
        push    %ds

        lgdt    _gdt_info

        mov     %cr0,   %eax
        or      $1,     %al
        mov     %eax,   %cr0

        ljmp    $0x08,  $_prot_mode

        #
        #   Swith to huge unreal mode
        #
    _prot_mode:
        mov     $0x10,  %bx
        mov     %bx,    %ds

        and     $0xFE,  %al
        mov     %eax,   %cr0

        ljmp    $0x00,  $_unreal_mode

    _unreal_mode:

        pop     %ds
        sti

        #
        #   Load custom interrupts to IVT
        #
        call    _set_ivt

        #
        #   Start the shell (located in KERNEL 6.0.0.SYS)
        #

/*
    
    THIS CODE ACTUALLY WORKS!!!!

    IT READS THE 16*****th SECTOR

    FOR SOME REASON QEMU USES 16
    SECTORS PER TRACK INSTEAD OF
    DEFAULT 18.

    IT TOOK ME AN HOUR OF TESTING
    TO FIND THAT OUT

    1.4.2024:
        NVM it now randomly 
        switched to using 18
        sectors per track???

        NVM#2 the reason it
        switched to using 18
        sectors per track is
        because we now run
        QEMU with this cmd:
            qemu-system-i386 -drive format=raw,file="$(FD_IMG)",index=0,if=floppy

        xor     %ax,    %ax
        mov     %ax,    %es

        mov     $0x02,  %ah
        mov     $0x40,  %al             #   Load 32 sectors (16KiB) of data
        mov     $0x500, %bx             #   to address 0x0500
        mov     $0x02,  %ch             #   track 2
        mov     $0x01,  %cl             #   1st sector of track 2
        mov     $0x00,  %dh
        movb    (_cur_drive),%dl
        int     $0x13

        jc      _disk_error

        jmp     0x500
*/

        jmp     _mp

        cli
        hlt

    _disk_error:
        mov     $_err,  %si
        call    _printk

        cli
        hlt

        .section    .rodata
    _err:       .asciz  "DISK ERROR!\r\n"
