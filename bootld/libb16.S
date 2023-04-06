
	.section	.text
	.global		puts16
	.global		delay
	.global		disk_read
	.global		KERN
	.set 		KERN,		0x7e00
	.code16

		puts16:
			lodsb
			
			or 			%al,	%al
			jz			.done

			mov 	$0x0e,		%ah
			mov 	$0x00,		%bh
			int 	$0x10

			jmp		puts16

			.done:
				ret

		delay:
			mov 	$0x0f,		%cx
			mov 	$0x4240,	%dx
			mov 	$0x86,		%ah
			int 	$0x15
			ret

		disk_read:
			mov 	$0x02,		%ah
			mov 	$0x7e00,	%bx
			mov 	$65,		%al
			mov 	(BOOT),		%dl
			mov 	$0x00,		%ch
			mov 	$0x00,		%dh
			mov 	$0x02,		%cl
			int 	$0x13

			jc 		disk_fail

			ret

		disk_fail:
			mov 	$err0,		%si
			call 	puts16

			mov 	$0x00,		%ah 
			int 	$0x16

			int 	$0x19

			.halt:
				jmp	.halt

#	.section	.data
		BOOT:	.byte	0
	.section	.rodata
		err0:	.asciz	"\r\n Error {1} : Failed to read the system disk | Any key to restart..."
