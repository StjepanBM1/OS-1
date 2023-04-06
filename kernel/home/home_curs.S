
	.section	.text
	.global		home_curs
	.global		hcloop
	.code16

		home_curs:
			mov 	$2,	%cl
			mov 	$2,	%bl

			hcloop:
				mov 	$0x02,	%ah
				mov 	%cl,	%dh
				mov 	%bl,	%dl
				int 	$0x10

				mov 	$0x00,	%ah
				int 	$0x16

				cmp 	$0x48,	%ah
				je		.up

				cmp 	$0x50,	%ah
				je		.dw

				cmp 	$0x4B,	%ah
				je		.lt

				cmp 	$0x4D,	%ah
				je		.rt

				cmp 	$0x20,	%al
				je		.cc

				jmp		hcloop

			.up:
				cmp 	$0x00,	%cl
				je 		hcloop

				sub 	$1,		%cl
				jmp 	hcloop

			.dw:
				cmp 	$27,	%cl
				je 		hcloop

				add 	$1,		%cl
				jmp 	hcloop

			.lt:
				cmp 	$0x00,	%bl
				je 		hcloop

				sub 	$1,		%bl
				jmp 	hcloop
			
			.rt:
				cmp 	$79,	%bl
				je 		hcloop

				add 	$1,		%bl
				jmp 	hcloop

			.cc:
				cmp 	$0x02,	%dl
				je 	.home_b
	
				cmp 	$4,		%dl
				je 		.shell
				cmp 	$5,		%dl
				je 		.shell
				cmp 	$6,		%dl
				je 		.shell
				cmp 	$7,		%dl
				je 		.shell
				cmp		$8,		%dl
				je 		.shell
				cmp		$9,		%dl
				je 		.shell
				cmp		$10,	%dl
				je 		.shell

				cmp		$24,	%dl
				je 		.paint
				cmp		$25,	%dl
				je 		.paint
				cmp		$26,	%dl
				je 		.paint
				cmp		$27,	%dl
				je 		.paint
				cmp		$28,	%dl
				je 		.paint
				cmp		$29,	%dl
				je 		.paint
				cmp		$30,	%dl
				je 		.paint

				cmp		$34,	%dl
				je 		.write
				cmp		$35,	%dl
				je 		.write
				cmp		$36,	%dl
				je 		.write
				cmp		$37,	%dl
				je 		.write
				cmp		$38,	%dl
				je 		.paint
				cmp		$39,	%dl
				je 		.write
				cmp		$40,	%dl
				je 		.write

				jmp		hcloop
	
			.home_b:
				cmp 	$0x02,	%dh
				je 		.close

				jmp		hcloop

			.paint:
				cmp		$0x02,	%dh
				je 		paint
				cmp		$0x03,	%dh
				je 		paint
				cmp		$0x04,	%dh
				je 		paint
				cmp		$0x05,	%dh
				je 		paint
				cmp		$0x06,	%dh
				je 		paint

				jmp 	hcloop

			.shell:
				cmp		$0x02,	%dh
				je 		shell
				cmp		$0x03,	%dh
				je 		shell
				cmp		$0x04,	%dh
				je 		shell
				cmp		$0x05,	%dh
				je 		shell
				cmp		$0x06,	%dh
				je 		shell

				jmp		hcloop

			.write:
				cmp		$0x02,	%dh
				je 		writet
				cmp		$0x03,	%dh
				je 		writet
				cmp		$0x04,	%dh
				je 		writet
				cmp		$0x05,	%dh
				je 		writet
				cmp		$0x06,	%dh
				je 		writet

				jmp 	hcloop

			.close:
				mov 	$0x02,	%ah
				mov 	$0x1,	%dh
				mov 	$0x2,	%dl
				int 	$0x10

				mov 	$0x09,	%ah
				mov 	$0x20,	%al
				mov 	$0x00,	%bh
				mov 	$0x1F,	%bl
				mov 	$800,	%cx
				int 	$0x10

				mov 	$0x02,	%ah
				mov 	$0x2,	%dh
				mov 	$0x2,	%dl
				int 	$0x10

				mov 	$0x1,	%bl
				mov 	$0x1,	%cl

				jmp		cloop
