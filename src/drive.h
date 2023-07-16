#pragma once
#include "header.h"

byte readSectors(byte* buffer, uint32_t start_sector, uint8_t size){
    byte data = 0;
    portOut(0x1f2, size);
    portOut(0x1f3, start_sector & 0xff);
    portOut(0x1f4, start_sector >> 8 & 0xff);
    portOut(0x1f5, start_sector >> 16 & 0xff);
    portOut(0x1f6, start_sector >> 24 & 0x0f | 0x11100000);
    portOut(0x1f7, 0x20);
    do data = portIn(0x1f7);
    while(!(data & 1) && (!(data >> 3 & 1) || !(data >> 7 & 1)));
    if(data & 1) return portIn(0x1f1);
    for(int i = 0; i <= 255; i++){
        *(buffer++) = portIn16(0x1f0);
    }
    return 0;
}