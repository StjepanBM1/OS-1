
    #   Power
    _sh_cmd_rebt:       .asciz  "reboot"        #   Warm reboot (int 0x19)
    _sh_cmd_shutd:      .asciz  "shutdown"      #   Power off the sys. (QEMU, Virtualbox)

    #   Memory
    _sh_cmd_mem:        .asciz  "mem"           #   Get the amount of free (low) memory in hex

    #   Disk(s)
    _sh_cmd_dstat:      .asciz  "dstat"         #   Status from the disk drive / check for disk drive errors

    #   Others
    _sh_cmd_ver:        .asciz  "ver"           #   Display version string
    _sh_cmd_clear:      .asciz  "clear"         #   Clear the screen
    _sh_cmd_help:       .asciz  "help"          #   Help command
    _sh_cmd_exit:       .asciz  "exit"          #   return to PinB.
