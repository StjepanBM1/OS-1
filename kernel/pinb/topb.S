
	.section	.text
	.global		topbm
	.global		menul
	.global		files
	.global		special
	.code16
		topbm:
			cmp 	$0x04,	%bl
			je 		menul
			cmp 	$0x05,	%bl
			je 		menul
			cmp 	$0x06,	%bl
			je 		menul
			cmp 	$0x07,	%bl
			je 		menul

			jmp 	cloop
		
		menul:
			jmp		home_wind
