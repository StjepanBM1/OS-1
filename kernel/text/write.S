
	.section	.text
	.global		write
	.global		wregs
	.global		reg16
	.global		regd
	.global		strcmp
	.code16

		write:
			lodsb
			or 		%al,	%al
			jz 		.done

			mov 	$0x0e,	%ah
			mov 	$0x00,	%bh
			int 	$0x10

			jmp 	write

			.done:
				ret
		wregs:
			mov 	$outsr,	%di
			mov 	(reg16),%ax
			mov 	$hexs,	%si
			mov 	$4,		%cx
			.hexl:
				rol 	$4,	%ax
				mov 	%ax,%bx
				and 	$0x0f,%bx
				mov 	(%bx,%si),%bl
				mov 	%bl,(%di)
				
				inc  	%di
				dec 	%cx
				jnz		.hexl

				mov 	$outsr, %si
				call 	write
				ret

		regd:
			mov 	$regd_s,	%si
			call 	write

			movw	%ax,	(reg16)
			call 	wregs
			movw	%bx,	(reg16)
			call 	wregs
			movw	%cx,	(reg16)
			call 	wregs
			movw	%dx,	(reg16)
			call 	wregs
			movw	%si,	(reg16)
			call 	wregs
			movw	%di,	(reg16)
			call 	wregs
			movw	%bp,	(reg16)
			call 	wregs
			movw	%sp,	(reg16)
			call 	wregs
			movw	%cs,	(reg16)
			call 	wregs
			movw	%ds,	(reg16)
			call 	wregs
			movw	%es,	(reg16)
			call 	wregs
			movw	%ss,	(reg16)
			call 	wregs

			ret

		strcmp:
			.str_loop:
				mov	(%si),	%al
				mov (%di),	%bl
				cmp %bl,	%al
				jne 	.notequ

				cmp $0x00,	%al
				je 	.equs

				inc 		%di
				inc 		%si
				jmp .str_loop

			.notequ:
				clc
				ret
			.equs:
				stc
				ret

			ret

	.section	.data
		hexs:	.asciz "0123456789ABCDEF"
		outsr:	.asciz "0000\r\n"
		reg16:	.word 0
		regd_s:	.asciz "\r\n!== Register Dump ==!\r\n"
