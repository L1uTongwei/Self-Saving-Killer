#pragma once
#include "header.h"
typedef struct{
    unsigned long size; //结构大小
    unsigned short drive_number; //设备编号
    unsigned short drive_mode; //设备模式（0：C/H/S 1：LBA）
    unsigned int drive_cylinders;
    unsigned short drive_heads; //设备磁头数
    unsigned short drive_sectors; //设备扇区数
    unsigned int *drive_ports; //设备端口（数组）
}drive;
typedef struct dnode{
    struct dnode* next;
    unsigned short drive_number; //设备编号
    unsigned short drive_mode; //设备模式（0：C/H/S 1：LBA）
    unsigned short drive_heads; //设备磁头数
    unsigned short drive_sectors; //设备扇区数
    unsigned short ports_length; //数组长度
    unsigned int *drive_ports; //设备端口（数组）
}drive_node;
drive_node drive_head = {(drive_node*)nullptr};
void initDrives(void* address){
    drive* source = (drive*)address;
    drive_node* target = &drive_head;
    while(target->next != (drive_node*)nullptr){
        target = target->next;
    }
    target->drive_number = source->drive_number;
    target->drive_mode = source->drive_mode;
    target->drive_heads = source->drive_heads;
    target->drive_sectors = source->drive_sectors;
    target->ports_length = (source->size - sizeof(short) * 5 - sizeof(int)) / sizeof(int);
    target->drive_ports = source->drive_ports;
    target->next = (drive_node*)nullptr;
}