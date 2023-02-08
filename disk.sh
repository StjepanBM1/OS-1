
echo "===> Creating the system binary..."
cat bin/boot16.bin bin/kern16.bin > bin/OS-1.bin

echo "===> Creating the disk.img..."
dd if=/dev/zero of=disk.img bs=512 count=1440
dd if=bin/OS-1.bin of=disk.img conv=notrunc
