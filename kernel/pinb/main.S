
	.section	.text
	.global		pmain
	.code16

		pmain:
			mov 	$0x03,	%ax
			int 	$0x10

			mov 	$0x1003,%ax
			mov 	$0x00,	%bx
			int 	$0x10

			mov 	$0x11,	%ah
			mov 	$0x11,	%al
			int 	$0x10

            mov     $0x01,  %ah
            mov     $0x10,  %cx
            int     $0x10

			call 	bases
			call 	curs

			cli
			hlt
