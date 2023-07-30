OUTPUT_FORMAT(binary);
ENTRY(_stage1);

SECTIONS
{
    .   =   0x7c00;
    .text   :   SUBALIGN(0)
    {
        *(.text.s1);
        *(.text)
    }

    .rodata :   SUBALIGN(0)
    {
        *(.rodata)
    }

    .data   :   SUBALIGN(0)
    {
        *(.data)
    }

    .sig    :   AT(0x7DFE)
    {
        SHORT(0xaa55);
    }

    /DISCARD/ : {
        *(.comment);
        *(.note*);
    }
}
