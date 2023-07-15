#pragma once

#define nullptr (void*) 0
typedef unsigned char           byte;
typedef unsigned char           uint8_t;
typedef unsigned short          uint16_t;
typedef unsigned int            uint32_t;
typedef unsigned long long      uint64_t;

typedef struct{
    uint8_t blue;
    uint8_t green;
    uint8_t red;
    uint8_t reversed;
}color;

#define white (color){0xff, 0xff, 0xff, 0}
#define black (color){0, 0, 0, 0}

/*
short portIn(short addr){
    short ret;
    __asm__ volatile(
        "in dx, al"
        : "=al"(ret)
        : "dx"(addr)
    );
}

void portOut(short addr, short value){
    short ret;
    __asm__ volatile(
        "out dx, al"
        : "=g"(ret)
        : "dx"(addr), "al"(value)
    );
}
*/