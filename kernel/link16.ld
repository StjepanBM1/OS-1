
OUTPUT_FORMAT(binary);
ENTRY(_kern16);

SECTIONS
{
	.	=	0x7e00;
	.text	:	SUBALIGN(0) { 
		*(.text.kern); 
		*(.text)
	}

	.rodata	:	SUBALIGN(0) { *(.rodata) }
	.data	:	SUBALIGN(0) { *(.data) } 
	.sig 	:	AT(0x9c40)  { SHORT(0x4241); }

	/DISCARD/ : {
		*(.comment);
		*(.note*)
	}

}
