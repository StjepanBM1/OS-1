
AS=i386-elf-as
LD=i386-elf-ld
LF=-Tlink16.ld *.o -o ../obj/boot16.bin

all:
	$(AS) boot16.S -o boot16.o
	$(AS) libb16.S -o libb16.o

	$(LD) $(LF)

clean:
	rm	*.o
