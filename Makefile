
# Directorys
O=bin
B=boot

DF=disk.img
OF=$(O)/*

# Targets
all: bootld kernel diskim run

bootld:
	$(MAKE) -C boot

kernel:	
	$(MAKE) -C kern

diskim:
	@./disk.sh

run:
	qemu-system-i386 -fda $(DF)

clean:
	rm $(OF)
	rm $(DF)

