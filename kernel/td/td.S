
/*
 *          td.S --- The eDitor
 *  ---------------------------------
 *
 *  The eDitor or td for short is a very
 *  simple text editor for OS/1 v6.0.0.
 *
 *  It doesn't do much, you can just
 *  edit existing or create and edit new
 *  files.
 *
 *  As of now it is very bare bones but
 *  I do plan to flesh it out a bit more
 *  so rather than it being a gray on 
 *  black screen that also happens to be
 *  able to save files to the disk I
 *  plan to make it more like edit on
 *  MS-DOS.
 *
 *  Do note that td is a bit (read: very
 *  much) buggy, and if you are not care-
 *  full it could corrupt the disk.
 *
 *  ---------------------------------
 *  
 *  Controls:
 *      CTRL + S => save file
 *      CTRL + Q => quit
 *
 *      LEFT CUR. KEY => move to left
 *      RIGHT CUR. KEY => move to right
 *      UP CUR. KEY => move up
 *      DOWN CUR. KEY => move down
 *
 *      PAGE DOWN => show next page
 *
 *  ---------------------------------
 */

        .code16
        .global     _td
        .global     _td_screen_setup
        .global     _td_main
        .section    .text

    #
    #   Entry point
    #
    _td:

    #
    #   Input prompts
    #
    _td_input_prompt:
        mov     $_prompt_0,     %si
        call    _printk

        #   create a new file or
        #   open an existing one
        1:
        mov     $_prompt_1,     %si
        call    _printk

        #   user input [n/o]
        _td_new_or_open:
            xor     %ax,    %ax
            int     $0x16

            cmp     $0x6E,  %al
            je      new

            cmp     $0x6F,  %al
            je      open

            jmp     _td_new_or_open

        #   user chose new
        new:
            mov     $0x0e,  %ah
            int     $0x10

            mov     $0x01,  _td_is_new

            jmp     _td_file_name

        #   user chose to open
        open:
            mov     $0x0e,  %ah
            int     $0x10

            mov     $0x01,  _td_is_open

            jmp     _td_file_name

        _td_file_name:
        #   File name
        xor     %ax,        %ax
        xor     %bx,        %bx
        xor     %cx,        %cx
        mov     $0x03,  %ah
        int     $0x10

        push    %dx

        mov     $_prompt_2,     %si
        call    _printk

        pop     %dx

        xor     %ax,        %ax
        xor     %bx,        %bx
        xor     %cx,        %cx
        mov     $0x02,  %ah
        inc     %dh
        mov     $0x20,  %dl
        int     $0x10

        xor     %cx,    %cx
        mov     $_td_file_, %di

        #   user input [file name]
        _td_fn_loop:
            xor     %ax,    %ax
            int     $0x16

            cmp     $0x0d,  %al
            je      _td_prompt_end

            mov     $0x0e,  %ah
            int     $0x10

            stosb
            inc     %cl
            jmp     _td_fn_loop

        _td_prompt_end:
            mov     $_td_file_, %si

            cmp     $0x01,  _td_is_new
            je      _td_create_new

            cmp     $0x01,  _td_is_open
            je      _td_open_file

            #
            #   incase somehow it doesn't
            #   jump to those functons,
            #   halt the pc
            #
            cli
            hlt

    #
    #   Screen setup
    #
    _td_screen_setup:
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

        #   if there is any buffer
        #   print it out (0xA000)        
        mov     $0xA010,    %bx
        mov     $2080,      %cx

        _td_bout_loop:
            mov     (%bx),  %al
            mov     $0x0e,  %ah
            int     $0x10

            push    %ax
            push    %bx
            push    %cx

            xor     %ax,    %ax
            xor     %bx,    %bx
            xor     %cx,    %cx

            mov     $0x03,  %ah
            int     $0x10

            cmp     $0x1B,  %dh
            je      _td_bout_end

            pop     %cx
            pop     %bx
            pop     %ax

            inc     %bx
            loop    _td_bout_loop

        _td_bout_end:

        #   return cursor to 0,0
        xor     %ax,        %ax
        xor     %bx,        %bx
        xor     %cx,        %cx

        mov     $0x02,      %ah
        mov     $0x00,      %dh
        mov     $0x00,      %dl
        int     $0x10

        xor     %cx,        %cx
        mov     $0xA010,    %di

    _td_text_input:
        movb     (%di),     %cl

        xor     %ax,        %ax
        int     $0x16

        #   text stuff
        cmp     $0x08,      %al
        je      _td_backspace

        cmp     $0x0D,      %al
        je      _td_enter_key

        cmp     $0x09,      %al
        je      _td_tab

        #   cursor movement
        cmpb    $0x48,      %ah
        je      _td_up

        cmpb    $0x50,      %ah
        je      _td_down

        cmpb    $0x4B,      %ah
        je      _td_left

        cmpb    $0x4D,      %ah
        je      _td_right

        #   control keys
        cmpb    (_ctrl_s),  %al
        je      _td_ctrl_s

        cmpb    (_ctrl_q),  %al
        je      _td_ctrl_q

        #   page up
        cmpb    $0x49,      %ah
        je      _td_page_up

        #   page down
        cmpb    $0x51,      %ah
        je      _td_page_dn

        mov     $0x0e,      %ah
        int     $0x10

        mov     %al,    (%di)
        inc     %di
        inc     %cl
        jmp     _td_text_input

        _td_backspace:
            dec     %di
            movb    $0x0000,    (%di)
            dec     %cl

            mov     $0x0e,      %ah
            mov     $0x08,      %al
            int     $0x10

            mov     $0x20,      %al
            int     $0x10

            mov     $0x08,      %al
            int     $0x10

            jmp     _td_text_input

        _td_enter_key:
            mov     $0x0d,      %al
            mov     %al,        (%di)
            inc     %di
            inc     %cl

            mov     $0x0a,      %al
            mov     %al,        (%di)
            inc     %di
            inc     %cl

            mov     $0x0e,      %ah
            mov     $0x0d,      %al
            int     $0x10

            mov     $0x0a,      %al
            int     $0x10

            jmp     _td_text_input

        _td_tab:
            mov     $0x20,      %al
            mov     %al,        (%di)
            mov     $0x20,      %al
            mov     %al,        (%di)
            mov     $0x20,      %al
            mov     %al,        (%di)
            mov     $0x20,      %al
            mov     %al,        (%di)

            add     $0x04,      %di
            add     $0x04,      %cl

            mov     $0x0e,      %ah
            mov     $0x20,      %al
            int     $0x10
            int     $0x10
            int     $0x10
            int     $0x10

            jmp     _td_text_input

        _td_up:
            mov     %di,    %ax
            sub     $80,   %ax

            mov     %ax,    %di

            xor     %ax,    %ax

            mov     $0x03,  %ah
            int     $0x10

            mov     $0x02,  %ah
            dec     %dh
            int     $0x10

            jmp     _td_text_input

        _td_down:
            mov     %di,    %ax
            add     $80,   %ax

            mov     %ax,    %di

            xor     %ax,    %ax

            mov     $0x03,  %ah
            int     $0x10

            mov     $0x02,  %ah
            inc     %dh
            int     $0x10

            jmp     _td_text_input

        _td_left:
            dec     %di

            mov     $0x03,  %ah
            int     $0x10

            mov     $0x02,  %ah
            dec     %dl
            int     $0x10

            jmp     _td_text_input

        _td_right:
            inc     %di

            mov     $0x03,  %ah
            int     $0x10

            mov     $0x02,  %ah
            inc     %dl
            int     $0x10

            jmp     _td_text_input

        _td_ctrl_s:
            xor     %ax,    %ax
            mov     %ax,    %es

            mov     $_td_file_,%si
            mov     $0xA000,%di
            mov     $16,    %cx
            rep     movsb

            mov     $_td_file_,%si
            movb    (_cur_drive),%dl
            call    _find_file

            mov     %ch,    _td_file_track

            xor     %ax,    %ax
            mov     %ax,    %es
            xor     %cx,    %cx

            push    %dx

            mov     $0x03,  %ah
            mov     $0x12,  %al
            mov     $0xA000,%bx
            movb    (_td_file_track),%ch
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            mov     $0x03,  %ah
            mov     $0x12,  %al
            mov     $0xC400,%bx
            inc     %ch
            mov     $0x01,  %cl
            mov     $0x00,  %dh
            movb    (_cur_drive),%dl
            int     $0x13

            pop     %dx

            jmp     _td_text_input

        _td_ctrl_q:
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

            int     $0x30

        _td_page_up:
            #   if we are on the first
            #   page, do nothing
            cmp     $0xA010,    %di
            je      _td_text_input

            xor     %cx,        %cx
            #   update the %di and stuff
            sub     $2080,      %di

            #   update the load addrs.
            #   and print out a page
            #   from the address
            sub     $2080,      _td_load_addrs
            mov     $_td_load_addrs,%bx
            mov     $2080,      %cx

            _td_pgup_l:
                mov     (%bx),  %al
                mov     $0x0e,  %ah
                int     $0x10

                push    %ax
                push    %bx
                push    %cx

                xor     %ax,    %ax
                xor     %bx,    %bx
                xor     %cx,    %cx

                mov     $0x03,  %ah
                int     $0x10

                cmp     $0x1B,  %dh
                je      _td_text_input

                pop     %cx
                pop     %bx
                pop     %ax

                inc     %bx
                loop    _td_pgup_l

            mov     $0x02,      %ah
            xor     %dx,        %dx
            int     $0x10

            jmp     _td_text_input

        _td_page_dn:
            #   if we are on the last
            #   page, do nothing
            cmp     $0xE810,    %di
            je      _td_text_input

            xor     %cx,        %cx
            #   update the %di and stuff
            add     $2080,      %di

            #   update the load addrs.
            #   and print out a page
            #   from the address
            add     $2080,      _td_load_addrs
            mov     $_td_load_addrs,%bx
            mov     $2080,      %cx

            _td_pgdn_l:
                mov     (%bx),  %al
                mov     $0x0e,  %ah
                int     $0x10

                push    %ax
                push    %bx
                push    %cx

                xor     %ax,    %ax
                xor     %bx,    %bx
                xor     %cx,    %cx

                mov     $0x03,  %ah
                int     $0x10

                cmp     $0x1B,  %dh
                je      _td_text_input

                pop     %cx
                pop     %bx
                pop     %ax

                inc     %bx
                loop    _td_pgdn_l

            xor     %dx,        %dx
            mov     $0x02,      %ah
            mov     $0x00,      %dh
            mov     $0x00,      %dl
            int     $0x10

            jmp     _td_text_input

        jmp     _td_text_input

    #
    #   Exit
    #
    _td_exit:
        int     $0x30

        .section    .rodata
        .global     _td_file_track
        .global     _td_load_addrs

    _td_file_track:     .byte   0
    _td_file_sector:    .byte   0
    
    _td_load_addrs:     .word   0xA000

    #
    #   COMMAND LINE PROMPTS
    #
    _prompt_0:  .asciz  "\t=-=-=-=-= The eDitor v1.0.0 =-=-=-=-="
    _prompt_1:  .asciz  "\r\n > Create a [n]ew file or [o]pen an existing one? [n/o] "
    _prompt_2:  .asciz  "\r\n > File name (with exstension) [                ]"

    #   file input
    _td_file_:  .fill   17,1,0

    #
    #   KEYS
    #
    _ctrl_s:    .byte   0x13    #   CTRL + S = save
    _ctrl_q:    .byte   0x11    #   CTRL + Q = quit

    #
    #   Variables
    #
        .section    .data
    _td_is_new:     .byte   0
    _td_is_open:    .byte   0
