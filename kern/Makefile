
AS=i386-elf-as
LD=i386-elf-ld
LF=-Tkern16.ld --oformat=binary
OF=*.o

all:

	#	SCE (Sub) System
	$(AS) sce/sce16.S -o sce16.o
	$(AS) sce/libs/sio16.S -o sio16.o

	#	OS/1 2.0.0 base kernel
	$(AS) kern16.S -o kern16.o
	$(AS) libk/puts16.S -o puts16.o
	$(AS) libk/io16.S -o io16.o

	#	UI & Prog. handler
	$(AS) ui/ui16.S -o ui16.o
	$(AS) ui/libu/ui_screen.S -o ui_screen.o
	$(AS) ui/prog_handl/prog16.S -o prog16.o
	$(AS) ui/prog_handl/wind/preprog.S -o preprog.o
	$(AS) ui/prog_handl/wind/mainprg.S -o mainprg.o

	#	Applications
	nasm -f elf ui/prog_handl/prod/console.S -o console.o
	$(AS) ui/prog_handl/cret/paint.S -o paint.o
	$(AS) ui/prog_handl/cret/type.S -o type.o
#	$(AS) ui/prog_handl/prod/console.S -o console.o

	$(LD) $(LF) $(OF) -o ../bin/kern16.bin

clean:
	rm $(OF)
