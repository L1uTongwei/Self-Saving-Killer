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
//分区基本信息，保存在分区 DMR（第 2048 号扇区）

typedef uint16_t FAT_t;
/*
FAT 表是一个长度为 BPB->big_sector / BPB->sector_per_cluster（簇数） 的表
FAT 表取值：
0x0000          未使用的簇
0x0002 - 0xFFEF 已分配的簇
0xFFF0 - 0xFFF6 系统保留
0xFFF8 - 0xFFFF 文件结束
*/
FAT_t *FAT;

typedef struct contents_node_t{
    unsigned char filename[8];
    unsigned char suffix[3];
    uint8_t attribute;
    byte reversed[10];
    uint16_t edit_time;
    uint16_t edit_date;
    uint16_t cluster;
    uint32_t length;
    struct contents_node_t* next;
} contents_node_t;
contents_node_t contents_head;

typedef struct{
    unsigned char filename[8];
    unsigned char suffix[3];
    uint8_t attribute;
    byte reversed[10];
    uint16_t edit_time;
    uint16_t edit_date;
    uint16_t cluster;
    uint32_t length;
} contents_t;

void readSector(uint16_t* buffer, uint32_t sector){
    asm volatile(
        "mov dx, 0x1f3 \n\t"
        "out dx, al \n\t" //0x1f3
        "mov dx, 0x1f4 \n\t"
        "shr eax, 8 \n\t"
        "out dx, al \n\t" //0x1f4
        "mov dx, 0x1f5 \n\t"
        "shr eax, 8 \n\t"
        "out dx, al \n\t" //0x1f5
        "mov dx, 0x1f6 \n\t"
        "shr eax, 8 \n\t"
        "and eax, 0x0F \n\t"
        "or  eax, 0xE0 \n\t"
        "out dx, al \n\t" //0x1f6
        "mov al, 1 \n\t"
        "mov dx, 0x1f2 \n\t"
        "out dx, al \n\t" //0x1f2
        "mov dx, 0x1f7 \n\t"
        "mov al, 0x20 \n\t"
        "out dx, al \n\t" //0x1f7
        :: "a"(sector)
        : "edx"
    );
    asm volatile(
        "mov dx, 0x1f7 \n\t"
        "waitLoop: \n\t"
        "    nop \n\t"
        "    in al, dx \n\t"
        "    and al, 0x88 \n\t"
        "    cmp al, 0x08 \n\t"
        "    jnz waitLoop \n\t"
        "mov dx, 0x1f0 \n\t"
        "mov cx, 256 \n\t"
        "readLoop: \n\t"
        "    in ax, dx \n\t"
        "    mov [%[addr]], ax \n\t"
        "    add %[addr], 2 \n\t"
        "    loop readLoop \n\t"
        :: [addr]"p"(buffer)
        : "edx", "eax", "ecx"
    );
}

void readSectors(byte* buffer, uint32_t start_sector, uint32_t size){
    for(uint32_t i = 0; i < size; i++, buffer += 512){
        readSector(buffer, start_sector + i);
    }
}

byte init_Disk(){
    /*
        FAT1 偏移：0x800 （0x804 号扇区）
        FAT2 偏移：0x20800 （0x904 号扇区）
        根目录：0x40800（0xA04 号扇区）
    */
    byte *DMR_buffer = malloc(0x200), *FAT_buffer = malloc(0x20000), *contents_buffer = malloc(0x200);
    readSectors(DMR_buffer, 0x800, 1);
    readSectors(FAT_buffer, 0x804, 0x100);
    if(DMR_buffer[0x1FE] != 0x55 || DMR_buffer[0x1FF] != 0xAA){
        return 1;
    }
    BPB = DMR_buffer + 0x0B;
    FAT = FAT_buffer;
    contents_head.next = nullptr;
    contents_node_t* iterator = &contents_head;
    contents_t* pointer = contents_buffer;
    uint32_t sector = 0xA04;
    contents_t *empty_struct = malloc(sizeof(contents_t));
    memset(empty_struct, 0, sizeof(contents_t));
    do{
        readSector(contents_buffer, sector);
        pointer = contents_buffer;
        while((byte*)pointer <= contents_buffer + 0x200 && memcmp(pointer, empty_struct, sizeof(contents_t))){
            while(iterator->next != nullptr) iterator = iterator->next;
            memcpy(iterator, pointer, 32);
            iterator->next = malloc(sizeof(contents_node_t));
            (iterator->next)->next = nullptr;
            pointer += 2;
        }
        sector++;
    }while((byte*)pointer > contents_buffer + 0x200);
    return 0;
}

contents_node_t* find_file(char* filename, char* suffix){ //目前只支持读取根目录下的文件
    contents_node_t* iterator = &contents_head;
    while(iterator->next != nullptr){
        if(!strcmp_s(iterator->filename, filename, 8) && !strcmp_s(iterator->suffix, filename, 3)){
            return iterator;
        }
        iterator = iterator->next;
    }
    return nullptr;
}