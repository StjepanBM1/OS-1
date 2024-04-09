    Operating System/1
==========================

    -= About =-
            Operating System/1 or OS/1 for short is a
        simple 16-bit OS written in x86 assembly that runs
        in huge unreal mode.

            Version 6.0.0 removed some stuff, but most
        importantly it added a functioning file system called
        Low Performance File System (LPFS). It can handle files
        up to 18KiB in size (36 512B sectors).

            Pinboard has been removed from the base
        system and will be available with other software on a
        special disk called "OS/1 Utilities disk".

        (to see the logo of OS/1 check OS-1-LOGO.png)

    -= CHANGES (as of v6.0.0) =-
        -   BBFS:
            >   removed

        -   LDFS:
            >   removed

        -   LPFS:
            >   new FS for OS/1
            >   read, write or remove files up to 18KiB
                in size
            >   format command

        -   IVT:
            >   custom interrupts to make developing
                software for OS/1 easier

        -   MP:
            >   more disk commands
            >   added cmd. line arguments
            >   a text editor called "td" added

        -   Pinboard:
            > removed from the base OS

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

        When you wish to compile run this command:
            make -i clean && make

    -= Running on real hardware =-
        To be honest, I have no idea if this will run
        on real hardware. If you have the time, do test 
        OS/1 6.0.0 on real hardware and tell me how it went.

    -= Additional =-
            If any bugs or issues have been found do
        submit an issue on the Github page.
