#pragma once
#include "ASCII_font.h"
int pos_x = 0, pos_y = 0; //text position
void clear_screen(uint32_t* buffer, uint32_t bc){
    int i, j;
    for(i = 0; i < 768; i++){
        for(j = 0; j < 1024; j++){
            buffer[j* 1024 + i] = bc;
        }
    }
}
void putchar(uint32_t* buffer, unsigned char ch, uint32_t fc, uint32_t bc){
    int i, j;
    if(ch == '\n' || ch == '\r'){
        pos_y++;
        if(pos_y > 768 / 6) clear_screen(buffer, bc), pos_x = pos_y = 0;
    }
    byte* font = get_ASCII_font(ch);
    for(i = pos_y * 6; i < (pos_y + 1) * 6; i++){
        for(j = pos_x * 6; j < (pos_x + 1) * 6; j++){
            buffer[i * 1024 + j] = ((font[i - pos_y * 6] << (j - pos_x * 6) & 1) ? fc : bc);
        }
    }
    pos_x++;
    if(pos_x > 1024 / 6) pos_x = 0, pos_y++;
    if(pos_y > 768 / 6) clear_screen(buffer, bc), pos_x = pos_y = 0;
}
void print(uint32_t* buffer, unsigned char* string, uint32_t fc, uint32_t bc){
    while(*string != '0'){
        putchar(buffer, *string, fc, bc);
        string++;
    }
}
void println(uint32_t* buffer, unsigned char* string, uint32_t fc, uint32_t bc){
    print(buffer, string, fc, bc);
    putchar(buffer, '\n', fc, bc);
}
void put_number(uint32_t* buffer, unsigned long number, unsigned long ratio, uint32_t fc, uint32_t bc){
    while(number){
        unsigned char display = number % ratio;
        if(display > 9) display += 'A';
        else display += '0';
        putchar(buffer, display, fc, bc);
        number /= ratio;
    }
}