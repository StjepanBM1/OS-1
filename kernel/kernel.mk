
ARCH=i386-elf

AS=$(ARCH)-as
LD=$(ARCH)-ld

NASM=nasm -fbin

override BIN := ./bin/kernel.sys
override ASM := $(shell find ./kernel -type f -name '*.S')
override OBJ := $(ASM:.S=.o)

.PHONY: all
all: $(BIN)

$(BIN): $(OBJ)
	$(LD) -Tkernel/kernel.ld $(OBJ) -o $@

%.o: %.S
	$(AS) $< -o $@

.PHONY: clean
clean:
	rm $(OBJ)
	rm $(BIN)

