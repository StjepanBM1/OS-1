
	.section	.text
	.global		home_wind
	.code16

		home_wind:
			mov 	$0x02,	%ah
			mov 	$0x2,	%dh
			mov 	$0x1,	%dl
			int 	$0x10

			mov 	$0x09,	%ah
			mov 	$0x20,	%al
			mov 	$0xF1,	%bl
			mov 	$43,	%cx
			int 	$0x10
			mov 	$titlew,%si
			call 	write

			.border1:
				mov 	$0x02,	%ah
				inc 			%dh
				mov 	$0x01,	%dl
				int 	$0x10

				mov 	$0x09,	%ah
				mov 	$0xBA,	%al
				mov 	$0x1F,	%bl
				mov 	$1,		%cx
				int 	$0x10

				cmp  	$7,	%dh
				je 		.after

				jmp		.border1
			
			.after:
				mov 	$0x02,	%ah
				mov 	$0x2,	%dh
				mov 	$0x1,	%dl
				int 	$0x10

				jmp		.border2

			.border2:
				mov 	$0x02,	%ah
				inc 			%dh
				mov 	$43,	%dl
				int 	$0x10

				mov 	$0x09,	%ah
				mov 	$0xBA,	%al
				mov 	$0x1F,	%bl
				mov 	$1,		%cx
				int 	$0x10

				cmp  	$7,	%dh
				je 		.shell

				jmp		.border2

			.shell:
				mov 	$0x02,	%ah
				mov 	$0x3,	%dh
				mov 	$0x3,	%dl
				int 	$0x10
				mov 	$shell1,%si
				call  	write
				
				mov 	$0x02,	%ah
				mov 	$0x4,	%dh
				mov 	$0x3,	%dl
				int 	$0x10
				mov 	$shell2,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x5,	%dh
				mov 	$0x3,	%dl
				int 	$0x10
				mov 	$shell3,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x6,	%dh
				mov 	$0x3,	%dl
				int 	$0x10
				mov 	$shell4,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x8,	%dh
				mov 	$0x1,	%dl
				int 	$0x10
				mov 	$wind_b,%si
				call 	write

			.games:
				mov 	$0x02,	%ah
				mov 	$0x3,	%dh
				mov 	$0xD,	%dl
				int 	$0x10
				mov 	$colle1,%si
				call  	write
				
				mov 	$0x02,	%ah
				mov 	$0x4,	%dh
				mov 	$0xD,	%dl
				int 	$0x10
				mov 	$colle2,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x5,	%dh
				mov 	$0xD,	%dl
				int 	$0x10
				mov 	$colle3,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x6,	%dh
				mov 	$0xD,	%dl
				int 	$0x10
				mov 	$colle4,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x8,	%dh
				mov 	$0x1,	%dl
				int 	$0x10
				mov 	$wind_b,%si
				call 	write

			.paint:
				mov 	$0x02,	%ah
				mov 	$0x3,	%dh
				mov 	$0x17,	%dl
				int 	$0x10
				mov 	$paint1,%si
				call  	write
				
				mov 	$0x02,	%ah
				mov 	$0x4,	%dh
				mov 	$0x17,	%dl
				int 	$0x10
				mov 	$paint2,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x5,	%dh
				mov 	$0x17,	%dl
				int 	$0x10
				mov 	$paint3,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x6,	%dh
				mov 	$0x17,	%dl
				int 	$0x10
				mov 	$paint4,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x8,	%dh
				mov 	$0x1,	%dl
				int 	$0x10
				mov 	$wind_b,%si
				call 	write

			.write:
				mov 	$0x02,	%ah
				mov 	$0x3,	%dh
				mov 	$0x21,	%dl
				int 	$0x10
				mov 	$write1,%si
				call  	write
				
				mov 	$0x02,	%ah
				mov 	$0x4,	%dh
				mov 	$0x21,	%dl
				int 	$0x10
				mov 	$write2,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x5,	%dh
				mov 	$0x21,	%dl
				int 	$0x10
				mov 	$write3,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x6,	%dh
				mov 	$0x21,	%dl
				int 	$0x10
				mov 	$write4,%si
				call  	write

				mov 	$0x02,	%ah
				mov 	$0x8,	%dh
				mov 	$0x1,	%dl
				int 	$0x10
				mov 	$wind_b,%si
				call 	write

			jmp		home_curs

	.section	.rodata
		#	Window
		titlew:	.asciz	"\xB3\xFE\xB3  Home "
		wind_b:	.asciz	"\xC8\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xBC"

		#	Collections (Directory) icon
		colle1:	.asciz	" \xDA\xC4\xC4\xC4\xC4\xC4\xBF"
		colle2:	.asciz	" \xB3     \xB3"
		colle3:	.asciz	" \xC0\xC4\xC4\xC4\xC4\xC4\xD9"
		colle4:	.asciz	"  Blank"

		#	Shell icon
		shell1:	.asciz	" \xDA\xC4\xC4\xC4\xC4\xC4\xBF"
		shell2:	.asciz	" \xB3>    \xB3"
		shell3:	.asciz	" \xC0\xC4\xC4\xC4\xC4\xC4\xD9"
		shell4:	.asciz	"  Shell"

		#	Paint icon
		paint1:	.asciz	" \xDA\xC4\xC4\xC4\xC4\xC4\xBF"
		paint2:	.asciz	" \xB3\xB0\xB1\xDB\xCD\xCD\xB3"
		paint3:	.asciz	" \xC0\xC4\xC4\xC4\xC4\xC4\xD9"
		paint4:	.asciz	"  Paint"
		
		#	Write icon
		write1:	.asciz	" \xDA\xC4\xC4\xC4\xC4\xC4\xBF"
		write2:	.asciz	" \xB3\Hello\xB3"
		write3:	.asciz	" \xC0\xC4\xC4\xC4\xC4\xC4\xD9"
		write4:	.asciz	"  Write"
