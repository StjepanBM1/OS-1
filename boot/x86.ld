OUTPUT_FORMAT(binary);
ENTRY(_entry);

SECTIONS
{
    . = 0x7c00;

    .text   :   SUBALIGN(0)
    {
        *(.text.main);
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

    .sig    :   AT(0x7dfe)
    {
        SHORT(0xaa55);
    }

    /DISCARD/   :   {
        *(.comment);
        *(.note*)
    }

}