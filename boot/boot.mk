
ARCH=i386-elf

AS=$(ARCH)-as
LD=$(ARCH)-ld

override BIN := ./bin/boot.sys
override ASM := $(shell find ./boot -type f -name '*.S')
override OBJ := $(ASM:.S=.o)

.PHONY: all
all: $(BIN)

$(BIN): $(OBJ)
	$(LD) -Tboot/x86.ld $(OBJ) -o $@

%.o: %.S
	$(AS) $< -o $@

.PHONY: clean
clean:
	rm $(OBJ)
	rm $(BIN)
