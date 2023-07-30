OUTPUT_FORMAT(binary);
ENTRY(_kernel);

SECTIONS
{
    .   =   0x7e00;
    .text   :   SUBALIGN(0)
    {
        *(.text.kern);
        *(.text.libk);
        *(.text.pinb);
        *(.text.pinb.app);
        *(.text)
    }

    .rodata :   SUBALIGN(0)
    {
        *(.rodata.pinb);
        *(.rodata.pinb.app);
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
