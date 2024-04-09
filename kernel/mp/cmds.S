    
    #
    #   list of all comands located in MP
    #

    _mp_cmd_reboot:     .asciz  "reboot"        #   reboot the pc
    _mp_cmd_shutdown:   .asciz  "shutdown"      #   shutdown the pc

    #
    #   MP stuff
    #
    _mp_cmd_rem:        .asciz  "#"             #   a comment
    _mp_cmd_echo:       .asciz  "echo"          #   echo user input
    _mp_cmd_clear:      .asciz  "clear"         #   clear the screen
    _mp_cmd_ver:        .asciz  "ver"           #   display version info
    _mp_cmd_help:       .asciz  "help"          #   help message

    #
    #   File system & disk commands
    #
    _mp_cmd_ls:         .asciz  "ls"            #   list all files on the disk
    _mp_cmd_rm:         .asciz  "rm"            #   remove a file from the disk
    _mp_cmd_mk:         .asciz  "mk"            #   create a file

    _mp_cmd_format:     .asciz  "format"        #   format a disk
    _mp_cmd_system:     .asciz  "sys"           #   make a disk bootable (copy the bootld. & the kernel file)

    _mp_cmd_disk_a:     .asciz  "a:"            #   switch to disk in the drive A (0x00)
    _mp_cmd_disk_b:     .asciz  "b:"            #   switch to disk in the drive B (0x01)
/*
    Hard drive support? 
    In OS/1?

    _mp_cmd_disk_c:     .asciz  "c:"            #   switch to the 1st HDD (0x80)
    _mp_cmd_disk_d:     .asciz  "d:"            #   switch to the 2nd HDD (0x81)
*/

    #
    #   Plain ArChiver Kit (PACK) commands
    #
    _mp_cmd_pack:       .asciz  "pack"          #   create a .pak file archive
    _mp_cmd_unpack:     .asciz  "unpack"        #   extract a .pak file

    #   The eDitor
    _mp_cmd_td:         .asciz  "td"            #   run the text editor (td)
