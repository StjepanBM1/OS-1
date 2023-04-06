
	.section	.text
	.global		bases
	.code16

		bases:
			mov 	$0x09,	%ah
			mov 	$0x20,	%al
			mov 	$0x00,	%bh
			mov 	$0x1F,	%bl
			mov 	$2240,	%cx
			int 	$0x10

			mov 	$0x09,	%ah
			mov 	$0x20,	%al
			mov 	$0xF1,	%bl
			mov 	$80,	%cx
			int 	$0x10

			mov 	$titleb,%si
			call  	write

			mov 	$0x02,	%ah
			mov 	$27,	%dh
			mov 	$53,	%dl
			int 	$0x10

			mov 	$build,	%si
			call 	write

			ret

	.section	.rodata
		titleb:	.asciz	"    Home   "
		build:	.asciz	"OS1-$12C-PinBoard-1-GNU_AS"
