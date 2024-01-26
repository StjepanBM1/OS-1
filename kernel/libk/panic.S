
            .section    .text.libk
            .global     _panic
            .code16

        _panic:
            call    _clear

            mov     $0x09,  %ah
            mov     $0x20,  %al
            mov     $0x00,  %bh
            mov     $0x4f,  %bl
            mov     $2240,  %cx
            int     $0x10

            mov     $_pm_0, %si
            call    _printk

            mov     $_pm_1, %si
            call    _printk

            mov     $_pm_2, %si
            call    _printk

            #
            #   Print registers
            #

            mov     $_pm_ax,%si
            call    _printk
            movw    %ax,    (regi)
            call    _preg

            mov     $_pm_bx,%si
            call    _printk
            movw    %bx,    (regi)
            call    _preg

            mov     $_pm_cx,%si
            call    _printk
            movw    %cx,    (regi)
            call    _preg

            mov     $_pm_dx,%si
            call    _printk
            movw    %dx,    (regi)
            call    _preg

            mov     $_nwln, %si
            call    _printk

            #
            #
            #

            mov     $_pm_sp,%si
            call    _printk
            movw    %sp,    (regi)
            call    _preg

            mov     $_pm_bp,%si
            call    _printk
            movw    %bp,    (regi)
            call    _preg

            mov     $_pm_si,%si
            call    _printk
            movw    %si,    (regi)
            call    _preg

            mov     $_pm_di,%si
            call    _printk
            movw    %di,    (regi)
            call    _preg

            mov     $_nwln, %si
            call    _printk

            #
            #
            #

            mov     $_pm_cs,%si
            call    _printk
            movw    %cs,    (regi)
            call    _preg

            mov     $_pm_ds,%si
            call    _printk
            movw    %ds,    (regi)
            call    _preg

            mov     $_pm_es,%si
            call    _printk
            movw    %es,    (regi)
            call    _preg

            mov     $_pm_fs,%si
            call    _printk
            movw    %fs,    (regi)
            call    _preg

            mov     $_nwln, %si
            call    _printk

            #
            #
            #

            mov     $_pm_gs,%si
            call    _printk
            movw    %gs,    (regi)
            call    _preg

            mov     $_pm_ss,%si
            call    _printk
            movw    %ss,    (regi)
            call    _preg

            #
            #   OS  Info
            #
            mov     $_pm_3, %si
            call    _printk

            mov     $_pm_i1, %si
            call    _printk

            mov     $_pm_i2, %si
            call    _printk

            mov     $0x00,  %ax
            int     $0x16
            int     $0x19

            cli
            hlt

            .section    .rodata
        _nwln:  .asciz  "\r\n"
        _pm_0:  .asciz  "**** OS KERNEL HALTED ****\r\n\r\n"
        _pm_1:  .asciz  " OS kernel has experienced a fatal error and has halted program execution.\r\n"
        _pm_2:  .asciz  " Restart your computer. Registers dumped:\r\n\r\n"
        
        _pm_ax:  .asciz  " AX : "
        _pm_bx:  .asciz  " BX : "
        _pm_cx:  .asciz  " CX : "
        _pm_dx:  .asciz  " DX : "

        _pm_sp:  .asciz  " SP : "
        _pm_bp:  .asciz  " BP : "
        _pm_si:  .asciz  " SI : "
        _pm_di:  .asciz  " DI : "

        _pm_cs:  .asciz  " CS : "
        _pm_ds:  .asciz  " DS : "
        _pm_es:  .asciz  " ES : "
        _pm_fs:  .asciz  " FS : "
        _pm_gs:  .asciz  " GS : "
        _pm_ss:  .asciz  " SS : "

        _pm_3:  .asciz  "\r\n\r\n OS Information:\r\n"
        _pm_i1: .asciz  "  Kernel: v5.5.0 \"Los Angeles\"\r\n"
        _pm_i2: .asciz  "  OS: OS/1 Average Release 5.5.0"
