
;*****************************************************************************;
;							   /dune/dune16.nasm							  ;
;	-----------------------------------------------------------------------   ;
;			    Main (16-bit) source file for the DUNE kernel.			      ;
;*****************************************************************************;


		org		0x7e00
		bits	16
		jmp		_start

		;	File	includes
		%include	"i286/stdio.inc"
		%include	"osh/main16.nasm"
		%include	"ed/ed.nasm"

	_start:

		mov		ax,		0x0003
		int				0x10

		mov		si,		msg_2
		call			puts16

		jmp		_main_osh

		;	Strings
		msg_2:	db	"DUNE kernel v1.00 (for i286) | Running in DOS mode",13,10,0
