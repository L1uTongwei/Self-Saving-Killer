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

#define nop() asm volatile("mov %ax, %ax")
#define delay(x) asm volatile( \
    "delayLoop%=: \n\t" \
    "\t  nop \n\t" \
    "loop delayLoop%= \n\t" \
    :: "c"(x) \
)

__attribute__((optimize("O2"), stdcall)) uint8_t portIn(uint16_t addr){
    uint8_t ret = 0;
    asm volatile(
        "in %[value], %[port]\n\t"
        : [value]"+&a"(ret)
        : [port]"Nd"(addr)
    );
    return ret;
}
__attribute__((optimize("O2"), stdcall)) void portOut(uint16_t addr, short value){
    asm volatile(
        "out %[port], %[value]\n\t"
        :: [port]"Nd"(addr), [value]"a"(value)
    );
}
__attribute__((optimize("O2"), stdcall)) void memcpy(byte* dest, byte* source, uint32_t size){
    for(int i = 0; i < size; i++){
        dest[i] = source[i];
    }
}
__attribute__((optimize("O2"), stdcall)) uint32_t getESP(){
    uint32_t ret = 0;
    asm volatile(
        "mov %[ret], esp\n\t"
        : [ret]"+&g"(ret)
    );
    return ret;
}