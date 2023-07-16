#include "startup.h"
void entry(unsigned char framebuffer[768][1024]){
    clear_screen(framebuffer, black);
}