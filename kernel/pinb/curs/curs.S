	.section	.text
	.global		curs
	.global		cloop
	.code16

		curs:
            mov     $0x01,  %ah
            mov     $0x10,  %cx
            int     $0x10

			mov 	$12,	%cl
			mov 	$40,	%bl

			cloop:
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

				jmp		cloop

			.up:
				cmp 	$0x00,	%cl
				je 		cloop

				sub 	$1,		%cl
				jmp 	cloop

			.dw:
				cmp 	$27,	%cl
				je 		cloop

				add 	$1,		%cl
				jmp 	cloop

			.lt:
				cmp 	$0x00,	%bl
				je 		cloop

				sub 	$1,		%bl
				jmp 	cloop
			
			.rt:
				cmp 	$79,	%bl
				je 		cloop

				add 	$1,		%bl
				jmp 	cloop

			.cc:
				cmp 	$0x00,	%cl
				je 		topbm

				jmp		cloop

			cli
			hlt
