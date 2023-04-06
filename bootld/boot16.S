
	.section	.text.boot
	.global		_boot16
	.code16

		_boot16:
			xor		%ax,	%ax
			mov 	%ax,	%ds
			mov 	%ax,	%ss
			mov 	$_boot16,%sp
			cld

			mov 	$0x03,	%ax
			int 	$0x10

			mov 	$0x1003,%ax
			mov 	$0x00,	%bx
			int 	$0x10

			mov 	$0x11,	%ah
			mov 	$0x11,	%al
			int 	$0x10

			mov 	$msg0,	%si
			call 	puts16

			call 	delay

			mov 	$msg1,	%si
			call 	puts16

			call 	delay

			mov 	$msg2,	%si
			call 	puts16

			call 	delay
			call 	delay

			call 	disk_read

			jmp 	KERN

			1:	cli
				jmp		1b

	.section	.rodata
		msg0:	.asciz	" === Operating System One ... Version 3.0.0 === \r\n"
		msg1:	.asciz	"\r\n {0} : Starting the system disk..."
		msg2:	.asciz	"\r\n {1} : Reading the disk..."
