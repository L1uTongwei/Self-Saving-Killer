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

 uint8_t portIn(uint16_t addr){
    uint8_t ret = 0;
    asm volatile(
        "in %[value], %[port]\n\t"
        : [value]"+&a"(ret)
        : [port]"Nd"(addr)
    );
    return ret;
}
 void portOut(uint16_t addr, short value){
    asm volatile(
        "out %[port], %[value]\n\t"
        :: [port]"Nd"(addr), [value]"a"(value)
    );
}
void memcpy(byte* dest, byte* source, uint32_t size){
    for(int i = 0; i < size; i++){
        dest[i] = source[i];
    }
}
byte memcmp(byte* dest, byte* src, uint32_t size){
    for(int i = 0; i < size; i++){
        if(dest[i] != src[i]) return 1;
    }
    return 0;
}
 void memset(byte* dest, byte value, uint32_t size){
    for(int i = 0; i < size; i++){
        dest[i] = value;
    }
}
byte strcmp(char* dest, char* src){
    while(*dest != '\0' && *src != '\0'){
        if(*dest != *src) return 1;
    }
    if(*src != *dest) return 1;
    return 0;
}
byte strcmp_s(char* dest, char* src, byte len){
    for(int i = 0; i < len; i++){
        if(dest[i] != src[i]) return 1;
    }
    return 0;
}
 uint32_t getESP(){
    uint32_t ret = 0;
    asm volatile(
        "mov %[ret], esp\n\t"
        : [ret]"+&g"(ret)
    );
    return ret;
}