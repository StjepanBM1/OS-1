OUTPUT_FORMAT(binary);
ENTRY(_kernel);

SECTIONS
{
    .   =   0x7e00;
    .text   :   SUBALIGN(0)
    {
        *(.text.kern);
        *(.text.tests);
        *(.text.filesys);
        *(.text.libk);
        *(.text)
    }

    .rodata :   SUBALIGN(0)
    {
        *(.rodata.mp);
        *(.rodata);
    }

    .data   :   SUBALIGN(0)
    {
        *(.data)
    }

    /DISCARD/ : {
        *(.comment);
        *(.note*);
    }
}
