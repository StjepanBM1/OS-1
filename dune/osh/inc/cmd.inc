
    ;   Power
    cmd_reboot:     db  "reboot",0
    cmd_shutdw:     db  "shutdown",0

    ;   Screen
    cmd_clear:      db  "clear", 0

    ;   Utils
    cmd_text:       db  "ed",0

    ;   Others
    cmd_test:       db  "test",0
    cmd_mem:        db  "mem",0
    cmd_ver:        db  "ver",0
    cmd_expl:       db  "explain",0
    buffer:         times   256 db  0

    ;;  Strings
    prompt:         db  "# ", 0
    str_err:        db  "  Command not found",13,10,0
    str_test:       db  "  test",13,10,0
    str_ver:        db  "  Operating System/1 v4.0.0 | DUNE kernel v1.00",13,10,0
    str_rebt:       db  "  Press any key to reboot.",13,10,0
    str_mem:        db  "  KB free: 0x", 0
    str_expl:       db  " This version was a bit rushed, as such it is missing a lot of features.",13,10,0
