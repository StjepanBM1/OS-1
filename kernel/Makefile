
AS=i386-elf-as
LD=i386-elf-ld
LF=-Tlink16.ld *.o -o ../obj/kern16.bin

all:
	# Main kernel
	$(AS) kern16.S -o kern16.o
	$(AS) text/write.S -o text.o
	$(AS) io/panic.S -o panic.o	

	# IO Lib.
	$(AS) io/delays.S -o delay.o
	$(AS) io/wk_reb.S -o wk_reb.o

	# PinBoard Env.
	$(AS) pinb/main.S -o main.o
	$(AS) pinb/screen/base.S -o base.o
	$(AS) pinb/curs/curs.S -o curs.o
	$(AS) pinb/topb.S -o tobp.o

	# Home applications
	$(AS) home/wind.S -o wind_h.o
	$(AS) home/home_curs.S -o home_curs.o
	$(AS) home/shell.S -o shell.o
	$(AS) home/paint.S -o paint.o
	$(AS) home/write.S -o writet.o

	$(LD) $(LF)

clean:
	rm	*.o
