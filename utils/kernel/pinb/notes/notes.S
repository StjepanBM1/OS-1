
            .code16
            .section    .text.pinb.app
            .global     _notes

        _notes:
            mov 	$0x02,	%ah
			mov 	$0x00,	%dx
			int 	$0x10

			mov 	$0x09,	%ah
			mov 	$0x20,	%al
			mov 	$0x00,	%bh
			mov 	$0x1E,	%bl
			mov 	$2240,	%cx
			int 	$0x10

			mov 	$0x09,	%ah
			mov 	$0x20,	%al
			mov 	$0x00,	%bh
			mov 	$0xF1,	%bl
			mov 	$80,	%cx
			int 	$0x10

			mov 	$titlew,%si
			call 	_printk

			mov 	$0x02,	%ah
			inc 	%dh
			mov 	$0x00,	%dl
			int 	$0x10

			.textin:
				.textinl:
					mov 	$0x00,	%ah
					int 	$0x16

					cmp 	$0x0D,	%al
					je 		.return

					cmpb 	%al,	exitk
					je 		_pinb

					mov 	$0x0e,	%ah
					int 	$0x10

					jmp		.textinl
				
				.return:
					mov 	$0x0e,	%ah
					mov 	$0x0d,	%al
					int 	$0x10

					mov 	$0x0a,	%al
					int 	$0x10

					mov 	$0x09,	%ah
					mov 	$0x20,	%al
					mov 	$0x00,	%bh
					mov 	$0x1E,	%bl
					mov 	$80,	%cx
					int 	$0x10

					jmp 	.textin

            .section    .rodata.pinb
        titlew:     .asciz  "  Write 2.5.0  \xB3 ESC to exit \xB3 Yes this was copied from OS/1 3.0.0 \xB3"
        exitk:      .byte   27
