
		org		0x7c00				;	Start @ 0x0000:0x7c00
		cpu		286					;	Target 80286 CPU
		bits	16					;	Generate 16-bit code
		jmp		_start				;	Skip to _start

		;	Include bootloader lib.
		%include	"lib16.nasm"

	_start:							;	Main bootloader func.
			mov		[bootd],dl		;	Boot dev. value

			mov		bp,		0x7c00	
			mov		sp,		bp

			mov		si,		msg_s	;	Print start message
			call	_putsb

			mov		si,		msg_l	;	Print loading message
			call	_putsb

			call	disk_read		;	Read disk function

			jmp		KERNEL			;	Jump to the kernel addr.

		;	Strings
		msg_s:	db	13,10,"Operating System/1 Version 4.1.1",13,10,0
		msg_l:	db	"Starting OS/1...",13,10,0

		times	510-($-$$)	db	0 	;	Bootsect. padding
		dw		0xaa55				;	Boot sig.
