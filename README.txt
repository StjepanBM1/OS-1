    Operating System/1
==========================

    -= About =-
            Operating System/1 or OS/1 for short is a
        simple 16-bit OS written in x86 assembly that runs
        in Unreal mode.

            It features a graphical environment called
        Pinboard, a shell called MP-OS/1 (the real name is 
        quite long), and as of version 5.4.0 a functioning
        file system called Bad Block File System (BBFS).

        (to see the logo of OS/1 check OS-1-LOGO.png)

    -= CHANGES (as of v5.5.0) =-
        -   Pinboard:
            > added an About tab to the top bar
            > small changes to Home tab

    -= System Requirements =-

        Recommended:
            - an i386+ CPU
            - 640KB of RAM
            - VGA card & VGA display
            - 2 floppy disk drives
        
        Minimal:
            - an i386
            - 512KB of RAM
            - any video card / display
              (won't display colors correctly
               but who cares?)
            - a floppy disk drive

    -= Compilation =-
        To compile OS/1 you need the following:
            - i386-elf build of GAS (GNU AS)
            - i386-elf build of LD
            - a *nix compliant environment
            - an emulator (QEMU recommended)
            - make

        When you wish to copile run this command:
            make -i clean && make

    -= Running on real hardware =-
            While it is recommended that you run OS/1
        in an emulator, there have been attempts to run it
        on real hardware. So far OS/1 has proven most
        successful running on a COMPAQ DeskPro 386 with VGA
        display and 1MB of RAM. While I have tested that it
        can work with even less RAM, it is quite slow when
        ran with less than 512KB of RAM.

            Also while VGA display isn't necessary I do
        recommended it, since white foreground color will
        start blinking on a non-VGA display.

            If you do successfully run OS/1 on a real
        computer, please do send me a message so I can add
        that machine to the list of PCs that have ran OS/1!

    -= Additional =-
            If any bugs or issues have been found do
        submit an issue on the Github page.
