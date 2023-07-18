#pragma once
#include "header.h"

byte readSectors(uint16_t* buffer, uint32_t start_sector, uint8_t size){
    byte data = 0;
    portOut(0x1f3, start_sector & 0xff);
    portOut(0x1f4, start_sector >> 8 & 0xff);
    portOut(0x1f5, start_sector >> 16 & 0xff);
    portOut(0x1f6, start_sector >> 24 & 0x0f | 0xe0);
    portOut(0x1f2, size);
    portOut(0x1f7, 0x20);
    while((data = portIn(0x1f7)) & 0x88 != 0x08);
    for(int i = 0; i < 256 * size; i++){
        *buffer = portIn16(0x1f0);
        buffer++;
    }
    return 0;
}