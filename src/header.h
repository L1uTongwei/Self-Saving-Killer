#pragma once
#define nullptr (void*) 0
#define byte unsigned char

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