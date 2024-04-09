OUTPUT_FORMAT(binary);
ENTRY(_kernel_start);

SECTIONS
{
    .   =   0x0500;
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
        *(.data);
    }

    /DISCARD/   :   {
        *(.note*)
    }

}