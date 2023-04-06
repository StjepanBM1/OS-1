
all: boot kern bin disk run

boot:
	make -C bootld

kern:
	make -C kernel
bin:
	cat obj/boot16.bin obj/kern16.bin > obj/os1-300.bin

disk:
	dd if=/dev/zero of=img/disk.img bs=512 count=1440
	dd if=obj/os1-300.bin of=img/disk.img conv=notrunc

run:
	qemu-system-i386 -fda img/disk.img

clean:
	make -C bootld clean
	make -C kernel clean
	rm obj/*
	rm img/*
