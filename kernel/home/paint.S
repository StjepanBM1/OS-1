	.section	.text
	.global		paint
	.code16


		paint:
			mov 	$0x02,	%ah
			mov 	$0x00,	%dx
			int 	$0x10

			mov 	$0x09,	%ah
			mov 	$0x20,	%al
			mov 	$0x00,	%bh
			mov 	$0x1F,	%bl
			mov 	$2240,	%cx
			int 	$0x10

			mov 	$0x09,	%ah
			mov 	$0x20,	%al
			mov 	$0x00,	%bh
			mov 	$0xF1,	%bl
			mov 	$80,	%cx
			int 	$0x10

			mov 	$titlep,%si
			call 	write

			inc 			%dh

			.canvas:
				cmp 	$26,	%dh
				je 		paint_curs

				mov 	$0x02,	%ah
				inc 			%dh
				mov 	$0x01,	%dl
				int 	$0x10

				mov 	$0x09,	%ah
				mov 	$0x20,	%al
				mov 	$0x00,	%bh
				mov 	$0xF0,	%bl
				mov 	$78,	%cx
				int 	$0x10

				jmp 	.canvas

		/*-------------------------*/
		/*	Cursor control */
		paint_curs:
			xor 	%bx,	%bx
			xor 	%cx,	%cx

			mov 	$0x01,	%ah
			mov 	$0x07,	%cx
			int 	$0x10

			mov 	$0x01,	%bl
			mov 	$0x02,	%cl

			.curs_loop:
				mov 	$0x02,	%ah
				mov 	%cl,	%dh
				mov 	%bl,	%dl
				int 	$0x10

				mov 	$0x00,	%ah
				int 	$0x16

				cmp 	$0x48,	%ah
				je 		.up

				cmp 	$0x50,	%ah
				je 		.dw

				cmp 	$0x4B,	%ah
				je 		.lt

				cmp 	$0x4D,	%ah
				je 		.rt

				cmpb 	%al,	place
				je 		.place

				cmpb 	%al,	erase
				je 		.erase

				cmpb	%al, 	text
				je 		.textp

				cmpb 	%al,	exit
				je 		.exit

				cmpb 	%al,	red
				je 		.red

				cmpb	%al,	blue
				je 		.blue

				cmpb	%al,	green
				je 		.green

				cmpb	%al,	brown
				je 		.brown

				cmpb	%al,	magen
				je 		.magen

				cmpb	%al,	cyan
				je 		.cyan

				cmpb	%al,	0x37
				je 		.lblue

				cmpb	%al,	lgren
				je 		.lgren

				cmpb	%al,	yellw
				je 		.yellw

				cmpb	%al,	click
				je 		.click

				jmp 	.curs_loop

				#	Navigation
				.up:
					cmp		$0,	%cl
					je 		.curs_loop

					sub 	$1,	%cl
					jmp 	.curs_loop

				.dw:
					cmp		$26, %cl
					je 		.curs_loop

					add		$1,	%cl
					jmp 	.curs_loop

				.lt:
					cmp		$0,	%bl
					je 		.curs_loop

					sub 	$1,	%bl
					jmp 	.curs_loop

				.rt:
					cmp		$78,%bl
					je 		.curs_loop

					add 	$1,	%bl
					jmp 	.curs_loop

				#	Place
				.place:
					cmp		$0x00,	%bl
					jg		.placey

					jmp		.curs_loop

					.placey:
						cmp		$0x01,	%cl
						jg		.placeyy

						jmp		.curs_loop

						.placeyy:
							mov 	$0x0e,	%ah
							mov 	$219,	%al
							int 	$0x10

							jmp		.curs_loop

					jmp 	.curs_loop

				.erase:
					cmp		$0x00,	%bl
					jg		.erasey

					jmp		.curs_loop

					.erasey:
						cmp		$0x01,	%cl
						jg		.eraseyy

						jmp		.curs_loop

						.eraseyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0x20,	%al
							mov 	$0x00,	%bh
							mov 	$0xF0,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

							jmp		.curs_loop

					jmp 	.curs_loop

				.textp:
					mov     $0x00,  %ah
	                int     $0x16

	                cmp     %al,    text
	                je      .curs_loop

	                mov     $0x0e,  %ah
	                int     $0x10

	                jmp     .textp

				#	Colors
				.red:
					cmp		$0x00,	%bl
					jg		.redy

					jmp		.curs_loop

					.redy:
						cmp		$0x01,	%cl
						jg		.redyy

						jmp		.curs_loop

						.redyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xDB,	%al
							mov 	$0x00,	%bh
							mov 	$0xF4,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				.blue:
					cmp		$0x00,	%bl
					jg		.bluey

					jmp		.curs_loop

					.bluey:
						cmp		$0x01,	%cl
						jg		.blueyy

						jmp		.curs_loop

						.blueyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xDB,	%al
							mov 	$0x00,	%bh
							mov 	$0xF1,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				.green:
					cmp		$0x00,	%bl
					jg		.greeny

					jmp		.curs_loop

					.greeny:
						cmp		$0x01,	%cl
						jg		.greenyy

						jmp		.curs_loop

						.greenyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xDB,	%al
							mov 	$0x00,	%bh
							mov 	$0xF2,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				.brown:
					cmp		$0x00,	%bl
					jg		.browny

					jmp		.curs_loop

					.browny:
						cmp		$0x01,	%cl
						jg		.brownyy

						jmp		.curs_loop

						.brownyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xDB,	%al
							mov 	$0x00,	%bh
							mov 	$0xF6,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				.magen:
					cmp		$0x00,	%bl
					jg		.mageny

					jmp		.curs_loop

					.mageny:
						cmp		$0x01,	%cl
						jg		.magenyy

						jmp		.curs_loop

						.magenyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xDB,	%al
							mov 	$0x00,	%bh
							mov 	$0xF5,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				.cyan:
					cmp		$0x00,	%bl
					jg		.cyany

					jmp		.curs_loop

					.cyany:
						cmp		$0x01,	%cl
						jg		.cyanyy

						jmp		.curs_loop

						.cyanyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xDB,	%al
							mov 	$0x00,	%bh
							mov 	$0xF3,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				.lblue:
					cmp		$0x00,	%bl
					jg		.lbluey

					jmp		.curs_loop

					.lbluey:
						cmp		$0x01,	%cl
						jg		.lbluey

						jmp		.curs_loop

						.lblueyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xBD,	%al
							mov 	$0x00,	%bh
							mov 	$0xF9,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				.lgren:
					cmp		$0x00,	%bl
					jg		.lgreny

					jmp		.curs_loop

					.lgreny:
						cmp		$0x01,	%cl
						jg		.lgrenyy

						jmp		.curs_loop

						.lgrenyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xDB,	%al
							mov 	$0x00,	%bh
							mov 	$0xFA,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				.yellw:
					cmp		$0x00,	%bl
					jg		.yellwy

					jmp		.curs_loop

					.yellwy:
						cmp		$0x01,	%cl
						jg		.yellwyy

						jmp		.curs_loop

						.yellwyy:
							push	%cx
							push	%bx
							push 	%dx

							mov 	$0x09,	%ah
							mov 	$0xDB,	%al
							mov 	$0x00,	%bh
							mov 	$0xFE,	%bl
							mov 	$0x1,	%cx
							int 	$0x10

							pop 	%dx
							pop 	%bx
							pop 	%cx
							jmp 	.curs_loop

					jmp 	.curs_loop

				#	Top bar & exit
				.exit:
					jmp		pmain

				#	Click
				.click:
					cmp		$0x00,	%dh
					je 		.topb

					jmp		.curs_loop
				
				.topb:
					cmp		$0x01,	%dl
					je 		.exit

					jmp		.curs_loop

				jmp 	.curs_loop

	.section	.rodata
		titlep:	.asciz	"\xB3\xFE\xB3  Paint 3.0.0   "

		#	Paint keys
		##	Defaults
		place:	.byte	'p'
		erase:	.byte	'e'
		text:	.byte	'`'
		exit:	.byte	27
		click:	.byte	0x20

		##	Colors
		red:	.byte	'1'
		blue:	.byte	'2'
		green:	.byte	'3'
		brown:	.byte	'4'
		magen:	.byte	'5'
		cyan:	.byte	'6'
		lblue:	.byte	'7'
		lgren:	.byte	'8'
		yellw:	.byte	'9'
