            .code16
            .section    .text.pinb.app
            .global     _paint_curs

        _paint_curs:

            #   CL  =   DH
            #   BL  =   DL

            mov     $0x01,      %ah
            mov     $0x07,      %cx
            int     $0x10

            mov     $0x02,      %dh
            mov     $0x01,      %dl

            pc_loop:
                mov     $0x02,  %ah
                int     $0x10

                mov     $0x00,  %ah
                int     $0x16

                #
                #   Directional keys
                #   Up, down, left, right
                #

                cmp     $0x48,  %ah
                je      .up

                cmp     $0x50,  %ah
                je      .do_wn

                cmp     $0x4B,  %ah
                je      .left

                cmp     $0x4D,  %ah
                je      .right

                #
                #   Base keys
                #   Space, P, E, N, Esc
                #

                cmp     $0x20,  %al
                je      .select

                cmp     $0x70,  %al
                je      .place

                cmp     $0x65,  %al
                je      .erase
                
                cmp     $0x6e,  %al
                je      .new

                cmp     $0x1B,  %al
                je      _pinb

                jmp     pc_loop
            
            #
            #   Directions
            #
            .up:
                cmp     $0x00,  %dh
                je      pc_loop

                sub     $1,     %dh
                jmp     pc_loop

            .do_wn:
                cmp     $27,    %dh
                je      pc_loop

                add     $1,     %dh
                jmp     pc_loop

            .left:
                cmp     $0,     %dl
                je      pc_loop

                sub     $1,     %dl
                jmp     pc_loop

            .right:
                cmp     $79,    %dl
                je      pc_loop

                add     $1,     %dl
                jmp     pc_loop

            #
            #   Draw commands
            #
            .place:
                cmp     $0x02,  %dh
                jl      pc_loop

                cmp     $26,    %dh
                jg      pc_loop

                cmp     $0x01,  %dl
                jl      pc_loop

                cmp     $72,    %dl
                jg      pc_loop

                mov     $0x09,  %ah
                mov     TRANS,  %al
                mov     $0x00,  %bh
                mov     COLOR,  %bl
                mov     $0x01,  %cx
                int     $0x10

                jmp     pc_loop

            .erase:
                cmp     $0x02,  %dh
                jl      pc_loop

                cmp     $26,    %dh
                jg      pc_loop

                cmp     $0x01,  %dl
                jl      pc_loop

                cmp     $72,    %dl
                jg      pc_loop

                mov     $0x09,  %ah
                mov     $0x20,  %al
                mov     $0x00,  %bh
                mov     $0xF0,  %bl
                mov     $0x01,  %cx
                int     $0x10

                jmp     pc_loop

            .new:
                mov     $0x02,  %ah
                mov     $0x02,  %dh
                mov     $0x01,  %dl
                int     $0x10

                .nloop:
                    cmp     $27,    %dh
                    je      _paint_curs

                    mov     $0x09,  %ah
                    mov     $0x20,  %al
                    mov     $0x00,  %bh
                    mov     $0xF0,  %bl
                    mov     $72,    %cx
                    int     $0x10
                    
                    mov     $0x02,  %ah
                    inc     %dh
                    mov     $0x01,  %dl
                    int     $0x10

                    jmp     .nloop

            #
            #   Selection
            #
            .select:
                cmp     $0x00,  %dh
                je      .exit

                cmp     $0x03,  %dh
                je      .black

                cmp     $0x04,  %dh
                je      .blue

                cmp     $0x05,  %dh
                je      .green

                cmp     $0x06,  %dh
                je      .cyan

                cmp     $0x07,  %dh
                je      .red

                cmp     $0x08,  %dh
                je      .magenta

                cmp     $0x09,  %dh
                je      .brown

                cmp     $0x0A,  %dh
                je      .l_gray

                cmp     $0x0B,  %dh
                je      .d_gray

                cmp     $0x0C,  %dh
                je      .l_blue

                cmp     $0x0D,  %dh
                je      .l_green

                cmp     $0x0E,  %dh
                je      .l_cyan

                cmp     $0x0F,  %dh
                je      .l_red

                cmp     $0x10,  %dh
                je      .l_mag

                cmp     $0x11,  %dh
                je      .yellow

                cmp     $0x12,  %dh
                je      .white

                cmp     $0x14,  %dh
                je      .shade0

                cmp     $0x15,  %dh
                je      .shade1

                cmp     $0x16,  %dh
                je      .shade2

                cmp     $0x17,  %dh
                je      .shade3

                cmp     $0x19,  %dh
                je      .news

                jmp     pc_loop

                .exit:
                    cmp $0x02,  %dl
                    je  _pinb

                    jmp pc_loop

                #
                #   Colors
                #
                .black:
                    cmp     $75,    %dl
                    je      .do_black
                    cmp     $76,    %dl
                    je      .do_black
                    cmp     $77,    %dl
                    je      .do_black
                    cmp     $78,    %dl
                    je      .do_black
                    cmp     $79,    %dl
                    je      .do_black

                    jmp     pc_loop

                    .do_black:
                    movb    $0x0F,  COLOR
                    jmp     pc_loop

                .blue:
                    cmp     $75,    %dl
                    je      .do_blue
                    cmp     $76,    %dl
                    je      .do_blue
                    cmp     $77,    %dl
                    je      .do_blue
                    cmp     $78,    %dl
                    je      .do_blue
                    cmp     $79,    %dl
                    je      .do_blue

                    jmp     pc_loop

                    .do_blue:
                    movb    $0x1F,  COLOR
                    jmp     pc_loop

                .green:
                    cmp     $75,    %dl
                    je      .do_green
                    cmp     $76,    %dl
                    je      .do_green
                    cmp     $77,    %dl
                    je      .do_green
                    cmp     $78,    %dl
                    je      .do_green
                    cmp     $79,    %dl
                    je      .do_green

                    jmp     pc_loop

                    .do_green:
                    movb    $0x2F,  COLOR
                    jmp     pc_loop

                .cyan:
                    cmp     $75,    %dl
                    je      .do_cyan
                    cmp     $76,    %dl
                    je      .do_cyan
                    cmp     $77,    %dl
                    je      .do_cyan
                    cmp     $78,    %dl
                    je      .do_cyan
                    cmp     $79,    %dl
                    je      .do_cyan

                    jmp     pc_loop

                    .do_cyan:
                    movb    $0x3F,  COLOR
                    jmp     pc_loop

                .red:
                    cmp     $75,    %dl
                    je      .do_red
                    cmp     $76,    %dl
                    je      .do_red
                    cmp     $77,    %dl
                    je      .do_red
                    cmp     $78,    %dl
                    je      .do_red
                    cmp     $79,    %dl
                    je      .do_red

                    jmp     pc_loop

                    .do_red:
                    movb    $0x4F,  COLOR
                    jmp     pc_loop

                .magenta:
                    cmp     $75,    %dl
                    je      .do_magenta
                    cmp     $76,    %dl
                    je      .do_magenta
                    cmp     $77,    %dl
                    je      .do_magenta
                    cmp     $78,    %dl
                    je      .do_magenta
                    cmp     $79,    %dl
                    je      .do_magenta

                    jmp     pc_loop

                    .do_magenta:
                    movb    $0x5F,  COLOR
                    jmp     pc_loop

                .brown:
                    cmp     $75,    %dl
                    je      .do_brown
                    cmp     $76,    %dl
                    je      .do_brown
                    cmp     $77,    %dl
                    je      .do_brown
                    cmp     $78,    %dl
                    je      .do_brown
                    cmp     $79,    %dl
                    je      .do_brown

                    jmp     pc_loop

                    .do_brown:
                    movb    $0x6F,  COLOR
                    jmp     pc_loop

                .l_gray:
                    cmp     $75,    %dl
                    je      .do_l_gray
                    cmp     $76,    %dl
                    je      .do_l_gray
                    cmp     $77,    %dl
                    je      .do_l_gray
                    cmp     $78,    %dl
                    je      .do_l_gray
                    cmp     $79,    %dl
                    je      .do_l_gray

                    jmp     pc_loop

                    .do_l_gray:
                    movb    $0x7F,  COLOR
                    jmp     pc_loop

                .d_gray:
                    cmp     $75,    %dl
                    je      .do_d_gray
                    cmp     $76,    %dl
                    je      .do_d_gray
                    cmp     $77,    %dl
                    je      .do_d_gray
                    cmp     $78,    %dl
                    je      .do_d_gray
                    cmp     $79,    %dl
                    je      .do_d_gray

                    jmp     pc_loop

                    .do_d_gray:
                    movb    $0x8F,  COLOR
                    jmp     pc_loop

                .l_blue:
                    cmp     $75,    %dl
                    je      .do_l_blue
                    cmp     $76,    %dl
                    je      .do_l_blue
                    cmp     $77,    %dl
                    je      .do_l_blue
                    cmp     $78,    %dl
                    je      .do_l_blue
                    cmp     $79,    %dl
                    je      .do_l_blue

                    jmp     pc_loop

                    .do_l_blue:
                    movb    $0x9F,  COLOR
                    jmp     pc_loop

                .l_green:
                    cmp     $75,    %dl
                    je      .do_l_green
                    cmp     $76,    %dl
                    je      .do_l_green
                    cmp     $77,    %dl
                    je      .do_l_green
                    cmp     $78,    %dl
                    je      .do_l_green
                    cmp     $79,    %dl
                    je      .do_l_green

                    jmp     pc_loop

                    .do_l_green:
                    movb    $0xAF,  COLOR
                    jmp     pc_loop

                .l_cyan:
                    cmp     $75,    %dl
                    je      .do_l_cyan
                    cmp     $76,    %dl
                    je      .do_l_cyan
                    cmp     $77,    %dl
                    je      .do_l_cyan
                    cmp     $78,    %dl
                    je      .do_l_cyan
                    cmp     $79,    %dl
                    je      .do_l_cyan

                    jmp     pc_loop

                    .do_l_cyan:
                    movb    $0xBF,  COLOR
                    jmp     pc_loop

                .l_red:
                    cmp     $75,    %dl
                    je      .do_l_red
                    cmp     $76,    %dl
                    je      .do_l_red
                    cmp     $77,    %dl
                    je      .do_l_red
                    cmp     $78,    %dl
                    je      .do_l_red
                    cmp     $79,    %dl
                    je      .do_l_red

                    jmp     pc_loop

                    .do_l_red:
                    movb    $0xCF,  COLOR
                    jmp     pc_loop

                .l_mag:
                    cmp     $75,    %dl
                    je      .do_l_mag
                    cmp     $76,    %dl
                    je      .do_l_mag
                    cmp     $77,    %dl
                    je      .do_l_mag
                    cmp     $78,    %dl
                    je      .do_l_mag
                    cmp     $79,    %dl
                    je      .do_l_mag

                    jmp     pc_loop

                    .do_l_mag:
                    movb    $0xDF,  COLOR
                    jmp     pc_loop

                .yellow:
                    cmp     $75,    %dl
                    je      .do_yellow
                    cmp     $76,    %dl
                    je      .do_yellow
                    cmp     $77,    %dl
                    je      .do_yellow
                    cmp     $78,    %dl
                    je      .do_yellow
                    cmp     $79,    %dl
                    je      .do_yellow

                    jmp     pc_loop

                    .do_yellow:
                    movb    $0xEF,  COLOR
                    jmp     pc_loop

                .white:
                    cmp     $75,    %dl
                    je      .do_white
                    cmp     $76,    %dl
                    je      .do_white
                    cmp     $77,    %dl
                    je      .do_white
                    cmp     $78,    %dl
                    je      .do_white
                    cmp     $79,    %dl
                    je      .do_white

                    jmp     pc_loop

                    .do_white:
                    movb    $0xF0,  COLOR
                    jmp     pc_loop

                #
                #   Shading / "transparency"
                #
                .shade0:
                    cmp     $75,    %dl
                    je      .do_s0
                    cmp     $76,    %dl
                    je      .do_s0
                    cmp     $77,    %dl
                    je      .do_s0
                    cmp     $78,    %dl
                    je      .do_s0
                    cmp     $79,    %dl
                    je      .do_s0

                    jmp     pc_loop

                    .do_s0:
                    movb    $0x20,  TRANS
                    jmp     pc_loop

                .shade1:
                    cmp     $75,    %dl
                    je      .do_s1
                    cmp     $76,    %dl
                    je      .do_s1
                    cmp     $77,    %dl
                    je      .do_s1
                    cmp     $78,    %dl
                    je      .do_s1
                    cmp     $79,    %dl
                    je      .do_s1

                    jmp     pc_loop

                    .do_s1:
                    movb    $0xB2,  TRANS
                    jmp     pc_loop


                .shade2:
                    cmp     $75,    %dl
                    je      .do_s2
                    cmp     $76,    %dl
                    je      .do_s2
                    cmp     $77,    %dl
                    je      .do_s2
                    cmp     $78,    %dl
                    je      .do_s2
                    cmp     $79,    %dl
                    je      .do_s2

                    jmp     pc_loop

                    .do_s2:
                    movb    $0xB1,  TRANS
                    jmp     pc_loop

                .shade3:
                    cmp     $75,    %dl
                    je      .do_s3
                    cmp     $76,    %dl
                    je      .do_s3
                    cmp     $77,    %dl
                    je      .do_s3
                    cmp     $78,    %dl
                    je      .do_s3
                    cmp     $79,    %dl
                    je      .do_s3

                    jmp     pc_loop

                    .do_s3:
                    movb    $0xB0,  TRANS
                    jmp     pc_loop

                #   New canvas
                .news:
                    cmp     $75,    %dl
                    je      .new
                    cmp     $76,    %dl
                    je      .new
                    cmp     $77,    %dl
                    je      .new
                    cmp     $78,    %dl
                    je      .new
                    cmp     $79,    %dl
                    je      .new

                    jmp     pc_loop

            cli
            hlt

            .section    .data
        COLOR:  .byte   0x00        #   Color
        TRANS:  .byte   0x00        #   Transparency
