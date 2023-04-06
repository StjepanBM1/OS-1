
	.section	.text
	.global		waitk_reb
	.code16

		waitk_reb:
			mov 	$0x00,	%ah
			int 	$0x16

			int 	$0x19

			ret
