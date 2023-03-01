    
    .section    .text.kernel
        .code16
        .global _kern16
        .global DEVB

        _kern16:
            mov     (DEVB), %dl

            mov     $msg2,  %si
            call    puts16
            
            call    slow

            jmp     os_choser

        os_choser:
            mov     $0x09,  %ah
            mov     $80,    %cx
            mov     $205,   %al
            mov     $0x0F,  %bl
            int     $0x10

            mov     $msg7,  %si
            call    puts16

            chooser:
                mov     $0x00,  %ah
                int     $0x16

                cmp     $49,    %al
                je      .os1

                cmp     $50,    %al
                je      .sce

                jmp     chooser

            .os1:
                mov     $0x0e,  %ah
                mov     $49,    %al
                int     $0x10

                mov     $msg8,  %si
                call    puts16

                call    slow

                mov     $msg3,  %si
                call    puts16          

                call    slow
                
                mov     $msg4,  %si
                call    puts16

                jmp     _ui16

                cli
                hlt

            .sce:
                mov     $0x0e,  %ah
                mov     $50,    %al
                int     $0x10

                mov     $msg9,  %si
                call    puts16

                call    slow

                mov     $msg5,  %si
                call    puts16

                call    slow

                mov     $msg6,  %si
                call    puts16

                jmp     sce16

                cli
                hlt

        DEVB:   .byte   0
    .section    .rodata
        msg2:   .asciz  "\r\nDisk read!\r\n"
        msg3:   .asciz  "\r\nLoading OS/1 Kernel [0xC8]..."
        msg4:   .asciz  "\r\nOS/1 Kernel loaded!"
        msg5:   .asciz  "\r\nLoading SCE S-Kernel [1.0.0]..."
        msg6:   .asciz  "\r\nSCE S-Kernel loaded!"

        msg7:   .asciz  "\r\nSystem Chooser [1.0.0] :\r\n    1: OS/1    [2.0.0]\r\n    2: SCE     [1.0.0]\r\n    > "
        msg8:   .asciz  "\r\nBooting OS/1 [2.0.0]..."
        msg9:   .asciz  "\r\nBooting SCE [1.0.0]..."
