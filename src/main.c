#include "startup.h"
void entry(unsigned char framebuffer[768][1024]){
    clear_screen(framebuffer, blue);
    byte* disk_buffer = malloc(512);
    readSectors(disk_buffer, 40, 1);
    for(int i = 0; i < 512; i++){
        putchar(framebuffer, disk_buffer[i], white, blue);
    }
    free(disk_buffer, 512);
}