
	_putsb:					;	Print out a string
		lodsb
		or	al,	al
		jz	.done

		mov	ah,	0x0e
		int		0x10

		jmp	_putsb

		.done:
			ret
		
	disk_read:				;	Read 0xff sectors from the disk
		mov	ah,	2
		mov	al,	32
		mov	bx,	KERNEL
		mov	ch,	0x00
		mov	cl,	0x02
		mov	dh,	0x00
		mov	dl,	[bootd]

		int		0x13

		jc		.fail		;	Jump to the fail if error c. present

		ret

		.fail:
			mov	si,	msg_de	;	Print out the error msg.
			call	_putsb

			mov	ax,	0x00
			int		0x16	;	Wait for input
			int		0x19	;	Reboot

		;	Varaibles
		bootd:	db	0
		KERNEL	equ	0x7e00
		msg_de:	db	"Disk read error occurred",13,10,"Press any key to reboot",0
