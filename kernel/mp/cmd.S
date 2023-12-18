
    #   Power
    _mp_cmd_rebt:       .asciz  "reboot"        #   Warm reboot (int 0x19)
    _mp_cmd_shutd:      .asciz  "shutdown"      #   Power off the sys. (QEMU, Virtualbox)

    #   Memory
    _mp_cmd_mem:        .asciz  "mem"           #   Get the amount of free (low) memory in hex

    #   Disk(s)
    _mp_cmd_dstat:      .asciz  "dstat"         #   Status from the disk drive / check for disk drive errors

    _mp_cmd_load_a:     .asciz  "load a"        #   Load data from disk in drive A (from 0x7e00+) and jump to 0x7e00
    _mp_cmd_load_b:     .asciz  "load b"        #   Load data from disk in drive B (from 0x7e00+) and jump to 0x7e00

    #   BBFS
    _mp_cmd_bbfs:       .asciz  "bbfs"          #   Display disk info

    _mp_cmd_ram1:       .asciz  "ram read 1"    #   read RAM block #1 into memory @ 0xAA00
    _mp_cmd_ram2:       .asciz  "ram read 2"    #   read RAM block #2 into memory @ 0xAA00
    _mp_cmd_ram3:       .asciz  "ram read 3"    #   read RAM block #3 into memory @ 0xAA00
    _mp_cmd_ram4:       .asciz  "ram read 4"    #   read RAM block #4 into memory @ 0xAA00
    _mp_cmd_ram5:       .asciz  "ram read 5"    #   read RAM block #5 into memory @ 0xAA00

    _mp_cmd_rexe:       .asciz  "ram exec"      #   jump to 0xAA00 and run the code there

    #   Others
    _mp_cmd_ver:        .asciz  "ver"           #   Display version string
    _mp_cmd_clear:      .asciz  "clear"         #   Clear the screen
    _mp_cmd_help:       .asciz  "help"          #   Help command

    _mp_cmd_die:        .asciz  "die"           #   Cause a kernel panic

    _mp_cmd_echo:       .asciz  "echo"          #   print out user input

    #   Pinboard
    _mp_cmd_pinb:       .asciz  "pinb"          #   Start the pinboard enviroment
