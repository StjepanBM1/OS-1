
/**
 * Not my proudest C++ code, but hey
 * I did not want to play with argv,
 * maybe someday.
 * 
 * NOTE: if you don't input 8 chars
 *       into file sys. id, the app
 *       will crash.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>

#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    char buffer[512];
    int disk_desc;

    string file;
    string disk_label;
    int block_size;
    int bootable;
    string file_sys_id;

    _file:
        cout << "File path: ";
        getline(cin, file);

    _disk_label:
        cout << "Disk label: ";
        getline(cin, disk_label);

        if (disk_label.size() > 8) {
            fputs("[!!] Disk label cannot be more than 8 chars. in length [!!]\n", stderr);
            goto _disk_label;
        }
        else
            goto _block_size;

    _block_size:
        cout << "Block size (1-6): ";
        cin >> block_size;

        if (block_size < 1 || block_size > 6) {
            fputs("[!!] Size of blocks must be between 1-6 [!!]\n", stderr);
            goto _block_size;
        }
        else
            goto _bootable;

    _bootable:
        cout << "Is the disk bootable (1-yes | 0-no)? ";
        cin >> bootable;
 
        if (bootable != 0 && bootable != 1) {
            fputs("[!!] Enter either 1 or 0 [!!]\n", stderr);
            goto _bootable;
        }
        else
            goto _file_sys_id;

    _file_sys_id:
        cout << "File System id: ";
        cin.ignore();
        getline(cin, file_sys_id);

        if (file_sys_id.size() > 8) {
            fputs("[!!] File Sys. id string cannot be more than 8 chars. [!!]\n", stderr);
            goto _file_sys_id;
        }
        else
            goto _format;

    _format:

        ofstream disk_file(file.c_str(), ios::out);

        if (disk_file.is_open())
        {
            memset(buffer, 0x00, sizeof(buffer));

            for (int x = 3; x <= 11; x++)
                buffer[x] = disk_label[x-3];
            
            buffer[12] = block_size;

            if (bootable == 1) {
                buffer[15] = bootable;
                buffer[510] = 0x55;
                buffer[511] = 0xaa; 
            } else {
                buffer[15] = bootable;
            }

            for (int x = 16; x<= 25-1; x++)
                buffer[x] = file_sys_id[x-16];

            for (int i = 0; i < 512; i++)
                disk_file << buffer[i];

            disk_file.close();
        }

        else {
            fputs("[!!] Unable to open the file, try again [!!]\n", stderr);
            goto _file;
        }

    return 0;
}
