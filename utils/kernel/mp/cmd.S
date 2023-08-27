
    #   Power
    _mp_cmd_rebt:       .asciz  "reboot"        #   Warm reboot (int 0x19)
    _mp_cmd_shutd:      .asciz  "shutdown"      #   Power off the sys. (QEMU, Virtualbox)

    #   Memory
    _mp_cmd_mem:        .asciz  "mem"           #   Get the amount of free (low) memory in hex

    #   Disk(s)
    _mp_cmd_dstat:      .asciz  "dstat"         #   Status from the disk drive / check for disk drive errors

    _mp_cmd_load_a:     .asciz  "load a"        #   Load data from disk in drive A (from 0x7e00+) and jump to 0x7e00
    _mp_cmd_load_b:     .asciz  "load b"        #   Load data from disk in drive B (from 0x7e00+) and jump to 0x7e00

    #   Others
    _mp_cmd_ver:        .asciz  "ver"           #   Display version string
    _mp_cmd_clear:      .asciz  "clear"         #   Clear the screen
    _mp_cmd_help:       .asciz  "help"          #   Help command

    #   Pinboard
    _mp_cmd_pinb:       .asciz  "pinb"          #   Start the pinboard enviroment
