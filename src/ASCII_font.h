#pragma once
#include "header.h"
byte ASCII_font[256][6];
void init_ASCII_font(){
    // A
    ASCII_font['A'][0] = 0b00001100;
    ASCII_font['A'][1] = 0b00010010;
    ASCII_font['A'][2] = 0b00100001;
    ASCII_font['A'][3] = 0b00111111;
    ASCII_font['A'][4] = 0b00100001;
    ASCII_font['A'][5] = 0b00100001;
    // B
    
}
byte* get_ASCII_font(unsigned char ch){
    return ASCII_font[ch];
}