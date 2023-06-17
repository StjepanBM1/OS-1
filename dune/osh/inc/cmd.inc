
    ;   Power
    cmd_reboot:     db  "reboot",0
    cmd_shutdw:     db  "shutdown",0

    ;   Screen
    cmd_clear:      db  "clear", 0

    ;   Utils
    cmd_text:       db  "ed",0
    cmd_pinb:       db  "pinb", 0

    ;   Disk
    cmd_fmrt:       db  "format", 0

    ;   Others
    cmd_test:       db  "test",0
    cmd_mem:        db  "mem",0
    cmd_ver:        db  "ver",0
    cmd_help:       db  "help",0
    cmd_expl:       db  "explain",0
    buffer:         times   256 db  0

    ;;  Strings
    newl:           db  13,10,0
    prompt:         db  "# ", 0
    str_err:        db  "  Command not found",13,10,0
    str_test:       db  "  test",13,10,0
    str_ver:        db  "  Operating System/1 v4.1.0 | DUNE kernel v1.02",13,10,0
    str_rebt:       db  "  Press any key to reboot.",13,10,0
    str_mem:        db  "  KB free: 0x", 0
    str_expl:       db  " This version was a bit rushed, as such it is missing a lot of features.",13,10,0
    str_f_v1:       db  " This will erase all the data on the disk!",13,10," Are you sure (y/n)? ", 0
    str_f_2:        db  " Format complete! Reboot recommended.", 13,10,0
    str_help:       db  " List of commands :",13,10, \
                        "   - reboot ", 13,10, \
                        "   - shutdown ", 13,10, \
                        "   - clear ", 13,10, \
                        "   - ed ", 13,10, \
                        "   - pinb ", 13,10, \
                        "   - format ", 13,10, \
                        "   - test ", 13,10, \
                        "   - mem ", 13,10, \
                        "   - ver ", 13,10, \
                        "   - help ", 13,10, \
                        "   - explain ", 13,10, \
                        0
