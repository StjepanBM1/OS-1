
#	Change as you like but keep it x86 compatable.
ARCH=i386-elf

AS=$(ARCH)-as
LD=$(ARCH)-ld

override BIN := ../bin/boot.bin
override ASM := $(shell find ./ -type f -name '*.S')
override OBJ := $(ASM:.S=.o)

.PHONY: all
all: $(BIN)

$(BIN): $(OBJ)
	$(LD) -Tx86.ld $(OBJ) -o $@

%.o: %.S
	$(AS) $< -o $@

.PHONY: clean
clean:
	rm $(OBJ)
