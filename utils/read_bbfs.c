
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>

#define DEV 0

typedef struct bbfs_t
{
    char disk_label[8];
    uint8_t block_size;
    char reserve[2];
    uint8_t bootable;
    char file_sys_id[8];

} BBFS_Parmam;

void read_boot_sector(char *file_path)
{
    char buffer[512];
    int boot_sector;
    BBFS_Parmam disk;

    boot_sector = open(file_path, O_RDONLY);
    read(boot_sector, buffer, 510);
    close(boot_sector);

    for (int x = 3; x <= 11; x++)
        disk.disk_label[x-3] = buffer[x];

    disk.block_size = buffer[12];
    disk.bootable = buffer[15];

    for (int x = 16; x <= 25-1; x++)
        disk.file_sys_id[x-16] = buffer[x];

    printf("DISK LABEL: %s\n", disk.disk_label);
    printf("BLOCK SIZE: %d\n", disk.block_size);
    printf("BOOTABLE:   %d\n", disk.bootable);
    printf("FILE SYS:   %s\n", disk.file_sys_id);

}

int main(int argc, char *argv[])
{

    #if DEV == 1
    for (int i = 0; i < argc-1; i++)
        printf("argc(%d) = argv(%s)\n", i, argv[i]);
    #endif

    if (argc < 2) {
        
    } else {
        
    }

    read_boot_sector(argv[1]);

    return 0;

}
