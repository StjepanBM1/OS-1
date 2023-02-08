
# Directorys
O=bin
B=boot

DF=disk.img
OF=$(O)/*

# Targets
all: bootld diskim run

bootld:
	$(MAKE) -C boot

diskim:
	@./disk.sh

run:
	qemu-system-i386 -fda $(DF)

clean:
	rm $(OF)
	rm $(DF)

