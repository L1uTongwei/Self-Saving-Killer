#include "header.h"
#include "memory_pool.h"
#include "drives.h"
typedef struct{
    unsigned long tabsize;
    unsigned long strsize;
    unsigned long addr;
    unsigned long reserved;
}aout_symbol_table_t;
typedef struct{
    unsigned long num;
    unsigned long size;
    unsigned long addr;
    unsigned long shndx;
}elf_section_header_table_t;
typedef struct{
    unsigned long size; //结构大小
    unsigned long base_addr; //基地址
    unsigned long length; //地址长度
    unsigned long type; 
    /*
        值 1 表示可用 RAM
        值 3 表示保存ACPI信息的可用存储器
        值 4 表示需要在休眠时保留的保留存储器
        值 5 表示被有缺陷的RAM模块占用的存储器
    */
}mmap;
typedef struct{
    unsigned short red;
    unsigned short yellow;
    unsigned short blue;
}color;
typedef struct{
    unsigned long flags;
    unsigned long mem_lower; //低位内存（640KB）
    unsigned long mem_upper; //高位内存（从 1MB 位置开始，最大 1MB）
    unsigned long boot_device; //启动设备编号（从 CD 启动无法使用此字段）
    unsigned long cmdline; //启动命令行地址
    unsigned long mods_count; 
    unsigned long mods_addr;
    union{
        aout_symbol_table_t aout_sym;
        elf_section_header_table_t elf_sec;
    }u;
    unsigned long mmap_length; //mmap长度
    unsigned long mmap_addr; //mmap结构地址
    unsigned long drives_length; //drives长度
    unsigned long drives_addr; //drives地址
    unsigned long config_table;
    unsigned long bootloader_name; //bootloader的名字
    unsigned long apm_table;
    unsigned long vbe_control_info;
    unsigned long vbe_mode_info;
    unsigned long vbe_mode;
    unsigned long vbe_interface_seg;
    unsigned long vbe_interface_off;
    unsigned long vbe_interface_len;
    unsigned long long framebuffer_addr; //帧缓冲区地址
    unsigned long framebuffer_pitch;
    unsigned long framebuffer_width; //宽度（1024）
    unsigned long framebuffer_height; //高度（768）
    unsigned short framebuffer_bpp;
    unsigned short framebuffer_type;
    struct{
        unsigned long A;
        unsigned short B;
    }color_info;
}multiboot_info_t;
void __main(unsigned long magic, unsigned long addr){
    multiboot_info_t *mbi;
    mbi = (multiboot_info_t*)addr;
    //初始化内存池
    for(void* ptr = (void*)mbi->mmap_addr; ptr <= (void*)mbi->mmap_addr + mbi->mmap_length; ptr += ((mmap*)ptr)->size){
        if(((mmap*)ptr)->type == 1){
            add_pool((void*)((mmap*)ptr)->base_addr, ((mmap*)ptr)->length);
        }
    }
    //初始化设备
    for(void* ptr = (void*)mbi->drives_addr; ptr <= (void*)mbi->drives_addr + mbi->drives_length; ptr += ((drive*)ptr)->size){
        initDrives(ptr);
    }
    //调用主函数
    main();
}