
            .code16
            .section    .text.filesys

            .global     _bbfs_bread_sector
            .global     bbfs_get_params
            .global     _bbfs_print_info
            .global     _bbfs_write_test

        _bbfs_bread_sector:

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

        bbfs_get_params:
            push    %ax
            push    %bx
            push    %cx
            push    %dx
            push    %es

            _get_label:
                xor     %ax,    %ax
                mov     $0xAA03,%si
                mov     $_disk_label,   %di
                mov     $8, %cx

                _copy_label_l:
                    movsb
                    loop    _copy_label_l

                mov     $_msg_label,    %si
                call    _printk
                mov     $_disk_label,   %si
                call    _printk

            _bl_size:
                xor     %ax,    %ax
                mov     $0xAA0C,%si
                mov     $_block_size,   %di
                mov     $1, %cx

                _copy_bl_l:
                    movsb
                    loop    _copy_bl_l

                mov     $_msg_bl_size,%si
                call    _printk
                mov     $_block_size, %si
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

        _bbfs_print_info:
            mov     $_disk_ok,  %si
            call    _printk

            mov     $_msg_label,    %si
            call    _printk
            mov     $_disk_label,   %si
            call    _printk

            mov     $_msg_bl_size,%si
            call    _printk
            mov     $_block_size, %si
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

        _fail_read:
            mov     $_disk_error,   %si
            call    _printk

            xor     %ax,    %ax
            int     $0x16

            jmp     $0xFFFFF,$0

            cli
            hlt

            .section    .rodata.filesys
        _disk_error:    .ascii  "BBFS: Disk error.\r\n"
                        .asciz  "Boot ended in a failure. Any key to retry."

        _disk_ok:       .asciz  "BBFS parameter: \r\n"

        _msg_label:     .asciz  "   DISK LABEL:  "
        _msg_bl_size:   .asciz  "\r\n   BLOCK SIZE:  "
        _msg_fs_id:     .asciz  "\r\n   FILE SYS:    "

        _msg_cp_done:   .asciz  "Disk copying done.\r\n"

            .section    .data.filesys
            .global     _block_size
            .global     _disk_label
        _disk_label:    .asciz  "        "
        _block_size:    .asciz  " "
        _file_sys:      .asciz  "        "
