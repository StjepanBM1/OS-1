
    %define PRG_VER '1.0.0'

    _ui_main:
        cli
        xor     ax, ax

        call    _ui_screen

        cli
        hlt

    %include "ui/lib_ui/ui_screen.S"
    %include "ui/lib_ui/ui_puts.S"
    %include "ui/wind/main_wind.S"
    %include "ui/wind/apps.S"
    %include "ui/app/app_console.S"
