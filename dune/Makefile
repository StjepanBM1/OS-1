
NASM := nasm -f bin

override DUNE := dune.bin

.PHONY: all
all: $(DUNE)

$(DUNE):
	$(NASM) dune16.nasm -o ../bin/$(DUNE)
