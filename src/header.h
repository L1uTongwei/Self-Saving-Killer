#pragma once

#define nullptr (void*) 0
typedef unsigned char           byte;
typedef unsigned char           uint8_t;
typedef unsigned short          uint16_t;
typedef unsigned int            uint32_t;
typedef unsigned long long      uint64_t;
#define white (uint32_t)0x00ffffff
#define black (uint32_t)0

inline short portIn(short addr){
    short ret;
    __asm__ volatile(
        "in dx, al"
        : "=al"(ret)
        : "dx"(addr)
    );
}

inline void portOut(short addr, short value){
    short ret;
    __asm__ volatile(
        "out dx, al"
        : "=g"(ret)
        : "dx"(addr), "al"(value)
    );
}