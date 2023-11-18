
OUTPUT_FORMAT(binary);
ENTRY(_entry);

SECTIONS
{
    .   =   0x7e00;
    .text   :   SUBALIGN(0)
    {
        *(.text.kernel);
        *(.text.filesys);
        *(.text.libk);
        *(.text)
    }

    .rodata :   SUBALIGN(0)
    {
        *(.rodata.kernel);
        *(.rodata.filesys);
        *(.rodata.mp);
        *(.rodata)
    }

    .data   :   SUBALIGN(0)
    {
        *(.data.filesys);
        *(.data);
        *(.data.filesys.blocks);
        *(.data.pinb);
    }

    /DISCARD/   :   {
        *(.comment);
        *(.note*)
    }

}
