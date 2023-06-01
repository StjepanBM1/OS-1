
NASM := nasm -f bin

override BOOT := bootld.bin

.PHONY: all
all: $(BOOT)

$(BOOT):
	$(NASM) boot16.nasm -o ../bin/$(BOOT)
