#pragma once
#include "../header.h"

byte keymap[0x60];
//0x00 - 0x80 Make Key
//0x80 - 0xFF Break Key

typedef struct{
    unsigned char ch;
    byte is_makeKey;
}key;

#define CAPSLOCK 0x3A
#define NUMLOCK 0x45
#define SCROLLLOCK 0x46
#define SYSREQ 0x54
#define ESC 0x01
#define ALT 0x38
#define CTRL 0x1D
#define LEFT_SHIFT 0x2A
#define RIGHT_SHIFT 0x36

#define F1 0x3B
#define F2 0x3C
#define F3 0x3D
#define F4 0x3E
#define F5 0x3F
#define F6 0x40
#define F7 0x41
#define F8 0x42
#define F9 0x43
#define F10 0x44
#define F11 0x57
#define F12 0x58

void initKeyMap(){
    keymap[0x0E] = '\b';
    keymap[0x1C] = '\n';
    keymap[0x39] = ' ';
    keymap[0x0F] = '\t';
    keymap[0x1E] = 'A';
    keymap[0x30] = 'B';
    keymap[0x2E] = 'C';
    keymap[0x20] = 'D';
    keymap[0x12] = 'E';
    keymap[0x2E] = 'F';
    keymap[0x22] = 'G';
    keymap[0x23] = 'H';
    keymap[0x17] = 'I';
    keymap[0x24] = 'J';
    keymap[0x25] = 'K';
    keymap[0x26] = 'L';
    keymap[0x32] = 'M';
    keymap[0x31] = 'N';
    keymap[0x18] = 'O';
    keymap[0x19] = 'P';
    keymap[0x10] = 'Q';
    keymap[0x13] = 'R';
    keymap[0x1F] = 'S';
    keymap[0x14] = 'T';
    keymap[0x16] = 'U';
    keymap[0x2F] = 'V';
    keymap[0x11] = 'W';
    keymap[0x2D] = 'X';
    keymap[0x15] = 'Y';
    keymap[0x2C] = 'Z';
}
key scan_keyboard(){
    portOut(0x20, 0x21);
    byte data = portIn(0x60), is_Makekey = 1;
    if(data >= 0x80){
        is_Makekey = 0;
        data -= 0x80;
    }
    if(keymap[data] == 0) return (key){data, is_Makekey};
    return (key){keymap[data], is_Makekey};
}
unsigned char getchar(){
    key data;
    while((data = scan_keyboard()).is_makeKey == 0);
    return data.ch;
}