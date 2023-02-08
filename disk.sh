
dd if=/dev/zero of=disk.img bs=512 count=1440
dd if=bin/boot16.bin of=disk.img conv=notrunc

