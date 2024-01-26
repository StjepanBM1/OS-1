
            .code16
            .section    .text.pinb.app
            .global     _dstat

        _dstat:

            .dtitle:
                mov     $0x02,  %ah
                mov     $17,    %dh
                mov     $0x01,  %dl
                int     $0x10

                mov     $0x09,  %ah
                mov     $0x20,  %al
                mov     $0x00,  %bh
                mov     $0xF1,  %bl
                mov     $66,    %cx
                int     $0x10

                mov     $_d_title,  %si
                call    _printk

            .backg:
                mov     $0x02,  %ah
                mov     $17,    %dh
                mov     $0x01,  %dl
                int     $0x10
                
                .left:
                    cmp     $24,    %dh
                    je      .i1

                    mov     $0x02,  %ah
                    inc     %dh
                    mov     $0x01,  %dl
                    int     $0x10

                    mov     $0x09,  %ah
                    mov     $0xBA,  %al
                    mov     $0x00,  %bh
                    mov     $0xF1,  %bl
                    mov     $1,    %cx
                    int     $0x10

                    jmp     .left

                .i1:
                    mov     $0x02,  %ah
                    mov     $17,    %dh
                    mov     $0x01,  %dl
                    int     $0x10

                .right:
                    cmp     $24,    %dh
                    je      .bot

                    mov     $0x02,  %ah
                    inc     %dh
                    mov     $66,    %dl
                    int     $0x10

                    mov     $0x09,  %ah
                    mov     $0xBA,  %al
                    mov     $0x00,  %bh
                    mov     $0xF1,  %bl
                    mov     $1,    %cx
                    int     $0x10

                    jmp     .right

                .bot:
                    mov     $0x02,      %ah
                    mov     $01,        %dl
                    int     $0x10

                    mov     $0x09,      %ah
                    mov     $0xCD,      %al
                    mov     $0x00,      %bh
                    mov     $0xF1,      %bl
                    mov     $66,        %cx
                    int     $0x10

                    mov     $0x0e,      %ah
                    mov     $0xC8,      %al
                    int     $0x10

                    mov     $0x02,      %ah
                    mov     $66,        %dl
                    int     $0x10
                    mov     $0x0e,      %ah
                    mov     $0xBC,      %al
                    int     $0x10
            .halt:

                mov     $0x02,      %ah
                mov     $19,        %dh
                mov     $02,        %dl
                int     $0x10

                xor     %dx,    %dx
                xor     %ax,    %ax
                call    _disk_status

                call    bbfs_get_params

                mov     $0x02,  %ah
                mov     $17,    %dh
                mov     $0x01,  %dl
                int     $0x10

            .done:
                jmp     _disk_curs

            .section    .rodata.pinb
        _d_title:       .asciz  " \xB3\xFE\xB3 Disk status "

        _d_label:       .asciz  "Disk label: "
        _d_fs_id:       .asciz  "File system id: "
