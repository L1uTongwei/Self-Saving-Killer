#include "startup.h"
void entry(unsigned char framebuffer[768][1024]){
    clear_screen(framebuffer, blue);
    byte* buf = init_BPB();
    for(int i = 0; i < 512; i++){
        if(buf[i] == 0) print(framebuffer, "00", white, blue);
        else if(buf[i] < 0x10) putchar(framebuffer, '0', white, blue);
        put_number(framebuffer, buf[i], 16, white, blue);
        if(i % 16 == 0) putchar(framebuffer, '\n', white, blue);
        else putchar(framebuffer, ' ', white, blue);
    }
}