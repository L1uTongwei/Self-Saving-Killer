#pragma once
#include "ASCII_font.h"
int pos_x = 0, pos_y = 0; //text position
inline byte getBit(byte number, byte offset){
    return (number >> (6 - offset)) & 1; 
}
void clear_screen(color* buffer, color bc){
    int i, j;
    for(i = 0; i < 768; i++){
        for(j = 0; j < 1024; j++){
            buffer[i * 1024 + j] = bc;
        }
    }
}
void putchar(color* buffer, unsigned char ch, color fc, color bc){
    int i, j;
    if(ch == '\n' || ch == '\r'){
        pos_y++;
        if(pos_y > 768 / 6) clear_screen(buffer, bc), pos_x = pos_y = 0;
    }
    if(ch >= 'a' && ch <= 'z'){
        ch -= 'a';
        ch += 'A';
    }
    byte* font = get_ASCII_font(ch);
    for(i = pos_y * 6; i < (pos_y + 1) * 6; i++){
        for(j = pos_x * 6 + 1; j < (pos_x + 1) * 6 + 1; j++){
            buffer[i * 1024 + j] = getBit(font[i - pos_y * 6], j - pos_x * 6) ? fc : bc;
        }
    }
    pos_x++;
    if(pos_x > 1024 / 6) pos_x = 0, pos_y++;
    if(pos_y > 768 / 6) clear_screen(buffer, bc), pos_x = pos_y = 0;
}
void print(color* buffer, unsigned char* string, color fc, color bc){
    while(*string != '\0'){
        putchar(buffer, *string, fc, bc);
        string++;
    }
}
void println(color* buffer, unsigned char* string, color fc, color bc){
    print(buffer, string, fc, bc);
    putchar(buffer, '\n', fc, bc);
}
void put_number(color* buffer, unsigned long number, unsigned long ratio, color fc, color bc){
    while(number){
        unsigned char display = number % ratio;
        if(display > 9) display += 'A';
        else display += '0';
        putchar(buffer, display, fc, bc);
        number /= ratio;
    }
}