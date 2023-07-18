#pragma once
#include "header.h"

struct{
    uint16_t bytes_per_sector; //只支持 512 字节哦~
    uint8_t sector_per_cluster; //每簇的扇区数
    uint16_t reversed_sectors; //保留扇区数
    uint8_t FATs; //FAT 副本数
    uint16_t root_entries; //根目录项数
    uint16_t small_sector; //小扇区数，如果超出范围为零并使用大扇区数
    uint8_t media_descriptor; //媒体描述符
    uint16_t sector_per_FAT; //每个 FAT 的扇区数
    uint16_t sector_per_track; //每个磁道的扇区数
    uint16_t heads; //磁头数
    uint32_t hidden_sector; //隐藏扇区数
    uint32_t big_sector;  //大扇区数
}*BPB;
//分区基本信息，保存在分区 DMR（第 800 号分区）

uint8_t* init_BPB(){
    byte* DMR_buffer = malloc(512);
    readSectors((uint16_t*)DMR_buffer, 0, 1);
    //if(*(DMR_buffer + 0x01FD) != 0x55 || *(DMR_buffer + 0x01FE) != 0xAA){
    //    return nullptr;
    //}
    BPB = DMR_buffer + 0x0B;
    return DMR_buffer;
}