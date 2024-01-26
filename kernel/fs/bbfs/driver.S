
            .code16
            .section    .text.filesys

            .global     _bbfs_read_sector
            .global     bbfs_get_params
            .global     _bbfs_print_info

            .global     _bbfs_write_to_ram_block
            .global     _bbfs_read_ram_block

            .global     _bbfs_ram_exec

        #
        #   BBFS read sector
        #
        _bbfs_read_sector:

            push    %ax
            push    %bx
            push    %cx
            push    %dx
            push    %es

            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $0x02,  %ah
            mov     $0x01,  %al
            mov     $0xAA00,%bx
            mov     $0x00,  %ch
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            mov     $0x00,  %dl

            int     $0x13

            jc      _fail_read

            mov     $_disk_ok,  %si
            call    _printk

            pop     %es
            pop     %dx
            pop     %cx
            pop     %bx
            pop     %ax

            ret

        #
        #   BBFS get disk parameters
        #
        bbfs_get_params:
            push    %ax
            push    %bx
            push    %cx
            push    %dx
            push    %es

            _get_label:
                xor     %ax,    %ax
                mov     $0xAA03,%si             #   Src
                mov     $_disk_label,   %di     #   Dest
                mov     $10, %cx                #   Num of chars to cpy.

                _copy_label_l:
                    movsb                       #   Copy the src to dest
                    loop    _copy_label_l       #   Loop until \0

                mov     $_msg_label,    %si
                call    _printk
                mov     $_disk_label,   %si
                call    _printk

            _bl_size:
                xor     %ax,    %ax
                mov     $0xAA0E,%si
                mov     $_bootable,%di
                mov     $1, %cx

                _copy_bl_l:
                    movsb
                    loop    _copy_bl_l

                mov     $_msg_boot,%si
                call    _printk
                mov     $_bootable, %si
                call    _printk

            _fs_id:
                xor     %ax,    %ax
                mov     $0xAA10,%si
                mov     $_file_sys,%di
                mov     $8, %cx

                _copy_fs_id_l:
                    movsb
                    loop    _copy_fs_id_l

                mov     $_msg_fs_id,%si
                call    _printk
                mov     $_file_sys,   %si
                call    _printk

            pop     %es
            pop     %dx
            pop     %cx
            pop     %bx
            pop     %ax

            ret

        #
        #   Output disk info
        #
        _bbfs_print_info:
            mov     $_disk_ok,  %si
            call    _printk

            mov     $_msg_label,    %si
            call    _printk
            mov     $_disk_label,   %si
            call    _printk

            mov     $_msg_boot,%si
            call    _printk
            mov     $_bootable, %si
            call    _printk
            
            mov     $_msg_fs_id,%si
            call    _printk
            mov     $_file_sys,   %si
            call    _printk

            mov     $0x0e,  %ah
            mov     $'\r',  %al
            int     $0x10

            mov     $'\n',  %al
            int     $0x10

            ret

        #
        #   Write data to RAM block.
        #   
        #   %ax - what block (1-5)
        #   %si - data to copy
        #   %cx - num. of bytes to copy
        #
        _bbfs_write_to_ram_block:
            cmp     $512,   %cx
            jg      .f_to_big_data

            cmp     $0x01,  %ax
            je      .block_1

            cmp     $0x02,  %ax
            je      .block_2

            cmp     $0x03,  %ax
            je      .block_3

            cmp     $0x04,  %ax
            je      .block_4

            cmp     $0x05,  %ax
            je      .block_5

            jmp     .f_no_ram_blck

            .block_1:
                xor     %ax,        %ax
                mov     $0xAC00,    %di

                _b1_loop:
                    movsb
                    loop    _b1_loop

                mov     $0x00,      %al
                stosb

                mov     $_b1_w_done,%si
                call    _printk

                jmp     .done

            .block_2:
                xor     %ax,        %ax
                mov     $0xAE00,    %di

                _b2_loop:
                    movsb
                    loop    _b2_loop

                mov     $0x00,      %al
                stosb

                mov     $_b2_w_done,%si
                call    _printk

                jmp     .done

            .block_3:
                xor     %ax,        %ax
                mov     $0xB000,    %di

                _b3_loop:
                    movsb
                    loop    _b3_loop

                mov     $0x00,      %al
                stosb

                mov     $_b3_w_done,   %si
                call    _printk

                jmp     .done

            .block_4:
                xor     %ax,        %ax
                mov     $0xB200,    %di

                _b4_loop:
                    movsb
                    loop    _b4_loop

                mov     $0x00,      %al
                stosb

                mov     $_b4_w_done,%si
                call    _printk

                jmp     .done

            .block_5:
                xor     %ax,        %ax
                mov     $0xB400,    %di

                _b5_loop:
                    movsb
                    loop    _b5_loop

                mov     $0x00,      %al
                stosb

                mov     $_b5_w_done,%si
                call    _printk

                jmp     .done

            .f_no_ram_blck:
                mov     $_ram_err1, %si
                call    _printk

                jmp     .done

            .f_to_big_data:
                mov     $_ram_err2, %si
                call    _printk

                jmp     .done

            .done:
                ret

        #
        #   Read data from RAM block and
        #   copy it to 0xAA00
        #   
        #   %ax - what block (1-5)
        #   %cx - num. of bytes to read
        #
        _bbfs_read_ram_block:
            cmp     $512,   %cx
            jg      .r_too_data

            cmp     $0x01,  %ax
            je      .ram_block_1

            cmp     $0x02,  %ax
            je      .ram_block_2

            cmp     $0x03,  %ax
            je      .ram_block_3

            cmp     $0x04,  %ax
            je      .ram_block_4

            cmp     $0x05,  %ax
            je      .ram_block_5

            jmp     .r_no_block

            .ram_block_1:
                xor     %ax,        %ax
                mov     $0xAA00,    %di
                mov     $0xAC00,    %si
                
                .rb_1_loop:
                    movsb
                    loop    .rb_1_loop

                mov     $0x00,      %al
                stosb

                mov     $_b1_r_done,%si
                call    _printk

                jmp     .r_done

            .ram_block_2:
                xor     %ax,        %ax
                mov     $0xAA00,    %di
                mov     $0xAE00,    %si
                
                .rb_2_loop:
                    movsb
                    loop    .rb_2_loop

                mov     $0x00,      %al
                stosb

                mov     $_b2_r_done,%si
                call    _printk

                jmp     .r_done

            .ram_block_3:
                xor     %ax,        %ax
                mov     $0xAA00,    %di
                mov     $0xB000,    %si
                
                .rb_3_loop:
                    movsb
                    loop    .rb_3_loop

                mov     $0x00,      %al
                stosb

                mov     $_b3_r_done,%si
                call    _printk

                jmp     .r_done

            .ram_block_4:
                xor     %ax,        %ax
                mov     $0xAA00,    %di
                mov     $0xB200,    %si
                
                .rb_4_loop:
                    movsb
                    loop    .rb_4_loop

                mov     $0x00,      %al
                stosb

                mov     $_b4_r_done,%si
                call    _printk

                jmp     .r_done
            
            .ram_block_5:
                xor     %ax,        %ax
                mov     $0xAA00,    %di
                mov     $0xB400,    %si
                
                .rb_5_loop:
                    movsb
                    loop    .rb_5_loop

                mov     $0x00,      %al
                stosb

                mov     $_b5_r_done,%si
                call    _printk

                jmp     .r_done

            .r_no_block:
                mov     $_ram_err1, %si
                call    _printk

                jmp     .done

            .r_too_data:
                mov     $_ram_err2, %si
                call    _printk

                jmp     .r_done

            .r_done:
            ret

        #
        #   Jump to 0xAA00
        #
        _bbfs_ram_exec:
            mov     $_ram_run,  %si
            call    _printk

            jmp     0xAA00

        #
        #   BBFS failure function
        #
        _fail_read:
            mov     $_disk_error,   %si
            call    _printk

            xor     %ax,    %ax
            int     $0x16

            jmp     $0xFFFFF,$0

            cli
            hlt

            .section    .rodata.filesys
        _b1_w_done:     .asciz  "\tFinished writing data to RAM block #1 @ 0xAC00\r\n"
        _b2_w_done:     .asciz  "\tFinished writing data to RAM block #2 @ 0xAE00\r\n"
        _b3_w_done:     .asciz  "\tFinished writing data to RAM block #3 @ 0xB000\r\n"
        _b4_w_done:     .asciz  "\tFinished writing data to RAM block #4 @ 0xB200\r\n"
        _b5_w_done:     .asciz  "\tFinished writing data to RAM block #5 @ 0xB400\r\n"

        _b1_r_done:     .asciz  "\tFinished reading RAM block #1 (copied @ 0xAA00)\r\n"
        _b2_r_done:     .asciz  "\tFinished reading RAM block #2 (copied @ 0xAA00)\r\n"
        _b3_r_done:     .asciz  "\tFinished reading RAM block #3 (copied @ 0xAA00)\r\n"
        _b4_r_done:     .asciz  "\tFinished reading RAM block #4 (copied @ 0xAA00)\r\n"
        _b5_r_done:     .asciz  "\tFinished reading RAM block #5 (copied @ 0xAA00)\r\n"

        _ram_run:       .asciz  "\tJumping to 0xAA00\r\n"

        _ram_err1:      .asciz  "\tWrong RAM block specified.\r\n"
        _ram_err2:      .asciz  "\tData size limit exceeded. Maximum of 512 bytes.\r\n"

        _ram_error:     .asciz  "\tFailed to write data to the RAM block.\r\n"


        _disk_error:    .ascii  "BBFS: Disk error.\r\n"
                        .asciz  "Boot ended in a failure. Any key to retry."

        _disk_ok:       .asciz  "BBFS parameter: \r\n"

        _msg_label:     .asciz  "\t\tDISK LABEL:  "
        _msg_boot:      .asciz  "\r\n\t\tBOOTABLE:    "
        _msg_wrprt:     .asciz  "\r\n\t\tWRITE PR.:   "
        _msg_fs_id:     .asciz  "\r\n\t\tFILE SYS:    "

        _msg_cp_w_done:   .asciz  "Disk copying done.\r\n"

            .section    .data.filesys
            .global     _block_size
            .global     _disk_label
            .global     _file_sys
        _ram_out:       .fill   512, 1, 0
        _disk_label:    .asciz  "          "
        _bootable:      .asciz  " "
        _file_sys:      .asciz  "        "
