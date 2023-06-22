
;*****************************************************************************;
;							   /dune/dune16.nasm							  ;
;	-----------------------------------------------------------------------   ;
;			    Main (16-bit) source file for the DUNE kernel.			      ;
;*****************************************************************************;


		org		0x7e00
		bits	16
		jmp		_start

	_start:

		mov		ax,		0x03
		int				0x10

		mov		ax,		0x1003
		mov		bx,		0x0000
		int				0x10

		mov		ah,		0x11
		mov		al,		0x11
		int				0x10

		mov		si,		msg_2
		call	puts16

		jmp		_main_osh

	msg_2:	db	0xDB,0xDB,0xDB," OS/1 v4.1.1",13,10,0

	;	File	includes
	%include	"i286/stdio.inc"
	%include	"osh/main16.nasm"
	%include	"ed/ed.nasm"
	%include	"pinb/pinb.nasm"

	%include	"fs/format.nasm"
