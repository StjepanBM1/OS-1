AS=i386-elf-as
LD=i386-elf-ld
LF=-Tboot16.ld --oformat=binary
OF=*.o

all:
	$(AS) boot16.S -o boot16.o
	$(AS) blib16.S -o blib16.o
	$(LD) $(LF) $(OF) -o ../bin/boot16.bin

clean:
	rm $(OF)
