
            .code16
            .global     read_disk
            .section    .text
            .extern     STAGE2
            .global     _dev

        read_disk:
            clc
            incb     (trys)

            mov     $0x02,  %ah                     #   Read disk arg. (ah = 0x02)
            mov     $0x40,  %al                     #   Number of sectors to read (64)
            mov     $0x7e00,%bx                     #   Buffer address (2nd sector)
            mov     $0x00,  %ch                     #   Track / Cylinder number
            mov     $0x02,  %cl                     #   Sector number
            mov     $0x00,  %dh                     #   Head number
            movb    (_dev), %dl                     #   Disk drive  (0 - drive A; 1 - drive B)
            
            int     $0x13                           #   Disk interrupt (0x13)

            jc      disk_error                      #   If clear flag is set jump to disk_error

            ret                                     #   Return

        disk_error:
            clc
            cmpb     $3,     (trys)                 #   If num of tries is less than 3
            jl      read_disk                       #   jump to read_disk

            mov     $0x03,  %ax                     #   Clear the screen
            int     $0x10

            mov     $0x13,  %ah                     #   Value 0x13 (print str.)
            mov     $0x01,  %al                     #   String type
            mov     $0x00,  %bh                     #   Video page num.
            mov     $0x0c,  %bl                     #   Attribute (L. Red on Black)
            mov     $38,    %cx                     #   String len. = 38 chars.
            mov     $0x00,  %dh                     #   Row 1
            mov     $0x00,  %dl                     #   Column 0
            mov     $_err0, %bp                     #   String to print
            int     $0x10                           #   Call interrupt

            cli
            hlt

            .section    .rodata
        _err0:  .asciz  "/!\\ Disk read error, system halted /!\\"

            .section    .data
        #   Disk read
        trys:   .byte   0
        _dev:   .byte   0
