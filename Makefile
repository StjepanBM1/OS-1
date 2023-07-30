
override FLP = os1.img
override ISO = os1.iso
override BINS := $(shell find ./ -type f -name '*.bin')

.PHONY:all
all: loader kern binary disk run

#
#	Builds the bootloader
loader:
	make -C boot

#
#	Builds the main kernel
kern:
	make -C kernel

#
#	Create a system binary by combining boot.bin & kernel.bin
binary:
	cat bin/boot.bin bin/kernel.bin > bin/os1.bin
#
#	Creates a low density 360 KiB
disk: loader kern binary
	dd if=/dev/zero of=img/$(FLP) bs=512 count=720
	dd if=bin/os1.bin of=img/$(FLP) conv=notrunc

#
#	Create high density 1.44M floppy image (needed for CD-ISO)
144img:
	dd if=/dev/zero of=img/$(FLP) bs=512 count=2880
	dd if=bin/os1.bin of=img/$(FLP) conv=notrunc

#
#	Creates an ISO image
cdiso: 144img
	mkisofs -quiet -V 'os1-500' -input-charset iso8859-1 -o img/$(ISO) -b $(FLP) img/

#
#	Runs the os1.img in QEMU
run: disk
	qemu-system-i386 -fda img/$(FLP)

#
#	Run the CD-ISO image (os1.iso) - QEMU
runcd: cdiso
	qemu-system-i386 -cdrom img/$(ISO)

.PHONY: clean
clean:
	make -C boot clean
	make -C kernel clean
	rm $(BINS) img/$(FLP) img/$(ISO)
