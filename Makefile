
all: bootld kernel diskim run

bootld:
	make -C boot

kernel:
	make -C kern

diskim:
	cat bin/boot16.bin bin/kern16.bin > bin/os1-200.bin

	dd if=/dev/zero of=disk.img bs=512 count=720
	dd if=bin/os1-200.bin of=disk.img conv=notrunc

run:
	qemu-system-i386 -fda disk.img

clean:
	make -C boot clean
	make -C kern clean
	rm bin/*
	rm disk.img
