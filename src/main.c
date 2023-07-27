#include "system/startup.h"
void entry(color framebuffer[768][1024]){
    byte findFlag = 0, gameCnt = 0;
    clear_screen(framebuffer, black);
    println(framebuffer, "SSK RPG Engine Version "VERSION, green, black);
    init_Disk();
    contents_node_t* iterator = &contents_head;
    while(iterator->next != nullptr){
        if(!strcmp_s(iterator->suffix, "ssk", 3) || !strcmp_s(iterator->suffix, "SSK", 3)){
            if(!findFlag){
                println(framebuffer, "Please Select the Game:", white, black);
            }
            for(int i = 0; i < 8; i++){
                if(iterator->filename[i] == ' ') break;
                putchar(framebuffer, iterator->filename[i], white, black);
            }
            println(framebuffer, ".ssk", white, black);
            findFlag = 1, gameCnt++;
        }
        iterator = iterator->next;
    }
    if(!findFlag){
        println(framebuffer, "Game file not found.", red, black);
        while(1);
    }
    println(framebuffer, "Press <Shift> for up, Press <Ctrl> for down.", green, black);
    byte cursor_row = 0;
    unsigned char key = 0;
    highlight(framebuffer, cursor_row + 2, black, blue);
    while(key != '\n'){
        key = getchar();
        if(key == LEFT_SHIFT){
            if(cursor_row > 0){
                highlight(framebuffer, cursor_row + 2, blue, black);
                highlight(framebuffer, cursor_row + 2 - 1, black, blue);
                cursor_row--;
            }
        }else if(key == CTRL){
            if(cursor_row < gameCnt - 1){
                highlight(framebuffer, cursor_row + 2, blue, black);
                highlight(framebuffer, cursor_row + 2 + 1, black, blue);
                cursor_row++;
            }
        }
    }
}
