
override FD_IMG := img/disk.img
override CD_IMG := img/disk.iso

override OS_BIN := bin/os.sys

override BOOT_FILE := bin/boot.sys
override KERN_FILE := bin/kernel.sys

.PHONY: all boot kernel
all: boot kernel disk run

boot:
	make -f boot/boot.mk
	
kernel:
	make -f kernel/kernel.mk

disk:
	dd if=/dev/zero of=$(FD_IMG) bs=512 count=1440
	dd if=$(BOOT_FILE) of=$(FD_IMG) bs=512 count=1 conv=notrunc
	dd if=$(KERN_FILE) of=$(FD_IMG) bs=512 seek=1 conv=notrunc


run:
	qemu-system-i386 -drive format=raw,file="$(FD_IMG)",index=0,if=floppy

.PHONY: clean
clean:
	make -f boot/boot.mk clean
	make -f kernel/kernel.mk clean

	rm $(FD_IMG)
