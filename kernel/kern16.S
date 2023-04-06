
	.section	.text.kern
	.global		_kern16
	.code16

		_kern16:
			xor		%ax,	%ax
			mov 	%ax,	%ds
			mov 	%ax,	%ss
			mov 	$_kern16,%sp
			cld

			#call  	regd

			mov 	$msg3,	%si
			call  	write

			call  	delay1
			call  	delay1

			mov 	$msg4,	%si
			call  	write

			call  	delay1

			mov 	$msg5,	%si
			call  	write

			call  	delay1 

			jmp  	pmain

			cli
			hlt

	.section	.rodata
		msg3:	.asciz	"\r\n {2} : Loading the kernel..."
		msg4:	.asciz	"\r\n {3} : Loading the [PinBoard]..."
		msg5:	.asciz	"\r\n {4} : Starting the [PinBoard].."
