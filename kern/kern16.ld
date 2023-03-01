
ENTRY(_kern16);
SECTIONS
{
    .   =   0x7e00;
    .text   :   SUBALIGN(0)
    {
        *(.text.kernel)
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

    /DISCARD/   :
    {
        *(.comment);
        *(.note*)
    }

}
