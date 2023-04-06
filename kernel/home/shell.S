
	.section	.text
	.global		shell
	.code16

		shell:
			mov 	$0x03,	%ax
			int 	$0x10

			mov 	$0x1003,%ax
			mov 	$0x00,	%bx
			int 	$0x10

			mov 	$0x11,	%ah
			mov 	$0x11,	%al
			int 	$0x10

            mov     $0x01,  %ah
            mov     $0xFF,  %cx
            int     $0x10

			mov 	$0x09,	%ah
			mov 	$0x20,	%al
			mov 	$0x00,	%bh
			mov 	$0x1F,	%bl
			mov 	$2240,	%cx
			int 	$0x10

			mov 	$titles,%si
			call 	write

			jmp 	input

			cli
			hlt

		input:
			.in_loop:
				mov 	$prompt,%si
				call 	write

				mov 	$buffer,%di
				call 	get_input

				mov 	$buffer,%si
				cmpb 	$0x00,	(%si)
				je 		.in_loop

				mov 	$buffer,%si
				mov 	$test_cmd,%di
				call 	strcmp
				jc 		.testc

				mov 	$buffer,%si
				mov 	$mem_cmd,%di
				call 	strcmp
				jc 		.memc

				mov 	$buffer,%si
				mov 	$cls_cmd,%di
				call 	strcmp
				jc 		.clear

				mov 	$buffer,%si
				mov 	$die_cmd,%di
				call 	strcmp
				jc 		.die

				mov 	$buffer,%si
				mov 	$hlt_cmd,%di
				call 	strcmp
				jc 		.halt

				mov 	$buffer,%si
				mov 	$shtd_cmd,%di
				call 	strcmp
				jc 		.shtd

				mov 	$buffer,%si
				mov 	$rebt_cmd,%di
				call 	strcmp
				jc 		.rebt

				mov 	$buffer,%si
				mov 	$ver_cmd,%di
				call 	strcmp
				jc 		.ver

				mov 	$error,	%si
				call 	write

				jmp 	.in_loop

			.halt:
				cli
				hlt
			.clear:
				mov 	$0x03,	%ax
				int 	$0x10

				mov 	$0x1003,%ax
				mov 	$0x00,	%bx
				int 	$0x10

				mov 	$0x11,	%ah
				mov 	$0x11,	%al
				int 	$0x10

	            mov     $0x01,  %ah
	            mov     $0xFF,  %cx
	            int     $0x10

				mov 	$0x09,	%ah
				mov 	$0x20,	%al
				mov 	$0x00,	%bh
				mov 	$0x1F,	%bl
				mov 	$2240,	%cx
				int 	$0x10
				jmp 	input

			.die:
				call  	panic

			.rebt:
				int 	$0x19

			.ver:
				mov 	$vers,	%si
				call 	write

				jmp 	.in_loop

			.shtd:
			.memc:
				mov 	$memm,	%si
				call 	write

				xorw	%ax,	%ax
				clc
				int 	$0x12

				movw	%ax,	(reg16)
				call	wregs

				jmp 	.in_loop

			.testc:
				mov 	$testm,	%si
				call 	write

				jmp 	.in_loop

		get_input:
			xor		%cl,	%cl

			.getin_l:
				mov 	$0x00,	%ah
				int 	$0x16

				cmp 	$0x08,	%al
				je 		.backsp

				cmp 	$0x0d,	%al
				je 		.newl

				cmp 	$0x3F,	%cl
				je 		.getin_l

				mov 	$0x0e,	%ah
				int 	$0x10

				stosb
				inc 	%cl
				jmp		.getin_l

			.backsp:
				cmp 	$0x00, 	%cl
				je 		.getin_l

				dec 	%di
				movb  	$0x00,	(%di)
				dec 	%cl

				mov 	$0x0e,	%ah
				mov 	$0x08,	%al
				int 	$0x10

				mov 	$0x20,	%al
				int 	$0x10

				mov 	$0x08,	%al
				int 	$0x10

				jmp 	.getin_l

			.newl:
				mov 	$0x00,	%al
				stosb

				mov 	$0x0e,	%ah
				mov 	$0x0d,	%al
				int 	$0x10

				mov 	$0x0a,	%al
				int 	$0x10

				mov 	$0x09,	%ah
				mov 	$0x20,	%al
				mov 	$0x00,	%bh
				mov 	$0x1F,	%bl
				mov 	$80,	%cx
				int 	$0x10

				ret

	.section	.rodata
		titles:	.asciz	"=== Operating Shell (OSH) v3.0.0 ===\r\n"
		prompt:	.asciz	">"

		#	Msgs.
		testm:	.asciz	" test\r\n"
		error:	.asciz	" Command not found\r\n"
		memm:	.asciz	" Free memory (low memory, hex.) : $"
		vers:	.asciz	" Operating System One v3.0.0 \"Oklahoma\" | OSH 3.0.0\r\n"

		#	Commands
		test_cmd:	.asciz	"test"
		mem_cmd:	.asciz	"mem"
		cls_cmd:	.asciz	"clear"
		ver_cmd:	.asciz	"ver"
		die_cmd:	.asciz	"die"
		hlt_cmd:	.asciz	"hlt"
		rebt_cmd:	.asciz	"reboot"
		shtd_cmd:	.asciz	"shutdown"

	.section	.data
		buffer:	.asciz "0000000000000000000000000000000000000000000000000000000000000000"
