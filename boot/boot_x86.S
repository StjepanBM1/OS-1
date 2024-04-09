
            .code16
            .global     _entry
            .section    .text

        _entry:
            jmp     _start
            nop

        #
        #   Low Performance File System (LPFS) header
        #

        _disk_volume_label:     .asciz  "OPERATING SYSTEM/1 SYSTEM  DISK"       #   31chars (+1 for '\0')
        _disk_sector_size:      .word   512                                     #   Define a size of a sector in bytes
        _maximal_dir_size:      .word   1024                                    #   Maximum directory size of 1024KiB (~1MB)
        _minimum_dir_size:      .word   1                                       #   Minimum directory size of 1KiB
        _minimal_file_size:     .word   1                                       #   Minimum file size of 1KiB (1024 bytes - 2 sectors)
        _maximum_file_size:     .word   18                                      #   Maximum file size of 18KiB (16384 bytes - 2 tracks [18 sectors per track])
        _disk_id_number:        .byte   79, 83, 47, 49, 20, 86, 54, 46, 48, 46, 48, 20 #   12 byte disk id nubmer

        #
        #   Main function of the bootloader
        #
        _start:
            #   save the boot device
            movb    %dl,    _boot_dev

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

            #   Stack
            cli
            mov     $0x9000,%ax
            mov     %ax,    %ss
            mov     $0xF800,%sp
            sti

            #   boot message
            mov     $_msg_0,    %si
            call    _print

        #
        #   Check for kernel file
        #
        #   like dos' io.sys the
        #   kernel also needs to
        #   be on a specific disk
        #   position
        #
        _check_file:
            mov     $_msg_1,%si
            call    _print

            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x02,  %ah
            mov     $0x01,  %al             #   Load 32 sectors (16KiB) of data
            mov     $0x0500, %bx             #   to address 0x0500
            mov     $0x00,  %ch
            mov     $0x02,  %cl             #   starting from the 2nd sector
            mov     $0x00,  %dh
            movb    (_boot_dev),%dl         #   on the boot device
            int     $0x13

            xor     %ax,    %ax
            xor     %cx,    %cx

            mov     $0x0500, %si
            mov     $_file_name,%di
            mov     $16,    %cx

            _check_loop:
                movsb
                loop    _check_loop

            mov     $0x00,  %al
            stosb

            mov     $_file_name,%si
            mov     $_file,     %di
            call    _strcmp

            jc      _load_file

            mov     $_err2, %si
            call    _print

            jmp     _end

        #
        #   Load the kernel file to (phys. mem.) 0x0500
        #
        _load_file:
            mov     $_msg_2,%si
            call    _print

            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x02,  %ah
            mov     $0x20,  %al             #   Load 32 sectors (16KiB) of data
            mov     $0x0500, %bx            #   to address 0x0500
            mov     $0x00,  %ch
            mov     $0x02,  %cl             #   starting from the 2nd sector
            mov     $0x00,  %dh
            movb    (_boot_dev),%dl         #   on the boot device
            int     $0x13

            jc      _disk_error

            mov     $_start_k,  %si
            call    _print

            jmp     0x0500

        #
        #   Clear ints. and halt
        #
        _end:
            cli
            hlt

        #
        #   If a int 0x13 carry flag is set jump heres
        #
        _disk_error:
            mov     $_err,  %si
            call    _print

            xor     %ax,    %ax
            int     $0x16

            int     $0x19

        #
        #   Cannot find kernel file
        #
        _no_kernel:
            mov     $_err2, %si
            call    _print

            xor     %ax,    %ax
            int     $0x16

            int     $0x19

        #
        #   Prints out string stored in %si
        #
        _print:
            lodsb

            or      %al,    %al
            jz      .p_done

            mov     $0x0e,  %ah
            int     $0x10

            jmp     _print

            .p_done:
                ret

        #
        #   Compare a string in %si with a string in %di
        #
        _strcmp:
            _str_loop:
                mov     (%si),  %al
                mov     (%di),  %bl
                cmp     %bl,    %al
                jne     _not_equal

                cmp     $0x00,  %al
                je      _equal

                inc     %di
                inc     %si
                
                jmp     _str_loop
            
            _not_equal:
                clc
                ret

            _equal:
                stc
                ret

        #
        #   Variables
        #
            .section    .rodata

        _msg_0: .asciz  "\xDB\xDB\xDB OS/1\n\r"
        _msg_1: .asciz  "Searching for the kernel file...\n\r"
        _msg_2: .asciz  "Loading the kernel file...\n\r"

        _err:   .asciz  "Disk read error\n\rAny key to reboot"
        _err2:  .asciz  "Cannot find the kernel file on the required locaton\r\nAny key to reboot"

        _start_k:   .asciz  "Starting OS/1...\r\n"

        _file:  .asciz  "KERNEL-6-0-0.SYS"      #   The file we are looking for

            .section    .data16
        _boot_dev:  .byte   0
        _file_name: .fill   16,1,0              #   12 char file name + 1 char for . + 3 chars for file exst.
