
all: bootld kernel disk run

bootld:
	make -C boot

kernel:
	make -C dune

disk:
	cat bin/bootld.bin bin/dune.bin > bin/os1.bin
	dd if=/dev/zero of=disk.img bs=512 count=360
	dd if=bin/os1.bin of=disk.img conv=notrunc

run:
	qemu-system-i386 -fda disk.img

clean:
	rm disk.img bin/*.bin
