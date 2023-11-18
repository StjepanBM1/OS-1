
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

#
#	Double Density 3.5" 720KiB disks
#
disk:
	dd if=/dev/zero of=$(FD_IMG) bs=512 count=1440
	dd if=$(BOOT_FILE) of=$(FD_IMG) bs=512 count=1 conv=notrunc
	dd if=$(KERN_FILE) of=$(FD_IMG) bs=512 seek=1 conv=notrunc

#
#	CD ISO - uses high density 1.44MB disk image
#
cdrom: base
	dd if=/dev/zero of=$(FD_IMG) bs=512 count=2880
	dd if=$(BOOT_FILE) of=$(FD_IMG) bs=512 count=1 conv=notrunc
	dd if=$(KERN_FILE) of=$(FD_IMG) bs=512 seek=1 conv=notrunc

	mkisofs -quiet -V 'honolulu' \
	 -input-charset iso8859-1 \
	  -o img/disk.iso \
	  -b disk.img \
	  img

run:
	qemu-system-i386 -fda $(FD_IMG)

run-cd: cdrom
	qemu-system-i386 -cdrom $(CD_IMG)

utils:
	make -f utils/utils.mk

.PHONY: clean
clean:
	make -f boot/boot.mk clean
	make -f kernel/kernel.mk clean
	make -f utils/utils.mk clean

	rm $(FD_IMG)
	rm $(CD_IMG)
