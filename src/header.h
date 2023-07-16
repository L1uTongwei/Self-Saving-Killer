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
#define red (color){0, 0, 0xff, 0}
#define green (color){0, 0xff, 0, 0}
#define blue (color){0xff, 0, 0, 0}

#define SPACE 64 // 64 MB Space

uint8_t portIn(short addr){
    uint8_t ret;
    asm volatile(
        "in al, dx \n\t"
        : "=a"(ret)
        : "d"(addr)
    );
    return ret;
}

uint16_t portIn16(short addr){
    uint16_t ret;
    asm volatile(
        "in ax, dx \n\t"
        : "=a"(ret)
        : "d"(addr)
    );
    return ret;
}

void portOut(short addr, short value){
    asm volatile(
        "out dx, al \n\t"
        :
        : "d"(addr), "a"(value)
    );
}