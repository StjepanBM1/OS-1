
	.section	.text
	.global		delay1
	.global		delay5
	.global		delay10
	.code16

		#	One second delay
		delay1:
			mov 	$0x86,		%ah
			mov 	$0x0f,		%cx
			mov 	$0x4240,	%dx
			int 	$0x15
			ret

		#	5 second delay
		delay5:
			mov 	$0x86,		%ah
			mov 	$0x49,		%cx
			mov 	$0x4840,	%dx
			int 	$0x15
			ret

		#	10 second delay
		delay10:
			mov 	$0x86,		%ah
			mov 	$0x98,		%cx
			mov 	$0x9680,	%dx
			int 	$0x15
			ret
