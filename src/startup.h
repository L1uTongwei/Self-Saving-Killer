#include "header.h"
#include "memory_pool.h"
#include "ASCII_font.h"
#include "simple_print.h"
#include "keyboard.h"
#include "drive.h"
extern void entry();
typedef struct{
    uint32_t size; //结构大小
    uint64_t base_addr; //基地址
    uint64_t length; //地址长度
    uint32_t type; 
    /*
        值 1 表示可用 RAM
        值 3 表示保存ACPI信息的可用存储器
        值 4 表示需要在休眠时保留的保留存储器
        值 5 表示被有缺陷的RAM模块占用的存储器
    */
}mmap;
typedef struct{
    /*0*/ uint32_t flags;
    /*4*/ uint32_t mem_lower; //低位内存
    /*8*/ uint32_t mem_upper; //高位内存
    /*12*/ uint32_t boot_device; //启动设备编号
    /*16*/ uint32_t cmdline; //启动命令行地址
    /*20*/ uint32_t mods_count; //Diasbled
    /*24*/ uint32_t mods_addr; //Disabled
    /*28-40*/ struct{
        uint32_t num;
        uint32_t size;
        uint32_t addr;
        uint32_t shndx;
    }syms;
    /*44*/ uint32_t mmap_length; //mmap长度
    /*48*/ uint32_t mmap_addr; //mmap结构地址
    /*52*/ uint32_t drives_length; //Disabled
    /*56*/ uint32_t drives_addr; //Disabled
    /*60*/ uint32_t config_table; //Disabled
    /*64*/ uint32_t bootloader_name; //bootloader的名字
    /*68*/ uint32_t apm_table; //Disabled
    /*72*/ uint32_t vbe_control_info;
    /*76*/ uint32_t vbe_mode_info;
    /*80*/ uint16_t vbe_mode;
    /*82*/ uint16_t vbe_interface_seg;
    /*84*/ uint16_t vbe_interface_off;
    /*86*/ uint16_t vbe_interface_len;
    /*88*/ uint64_t framebuffer_addr; //帧缓冲区地址
    /*96*/ uint32_t framebuffer_pitch;
    /*100*/ uint32_t framebuffer_width; //宽度（1024）
    /*104*/ uint32_t framebuffer_height; //高度（768）
    /*108*/ uint8_t framebuffer_bpp;
    /*109*/ uint8_t framebuffer_type;
    /*110-115*/ struct color{
        uint8_t framebuffer_red_field_position;
        uint8_t framebuffer_red_mask_size;
        uint8_t framebuffer_green_field_position;
        uint8_t framebuffer_green_mask_size;
        uint8_t framebuffer_blue_field_position;
        uint8_t framebuffer_blue_mask_size;
    } color_info;
}multiboot_info_t;
void __main(unsigned long magic, unsigned long addr){
    multiboot_info_t *mbi;
    mbi = (multiboot_info_t*)addr;
    //Init fonts
    init_ASCII_font();
    //Display Boot Informations
    clear_screen((void*)mbi->framebuffer_addr, blue);
    println((void*)mbi->framebuffer_addr, "Multiboot Informations: ", red, blue);
    print((void*)mbi->framebuffer_addr, "Bootloader: ", white, blue);
    println((void*)mbi->framebuffer_addr, (char*)mbi->bootloader_name, white, blue);
    print((void*)mbi->framebuffer_addr, "Command Line: ", white, blue);
    println((void*)mbi->framebuffer_addr, (char*)mbi->cmdline, white, blue);
    print((void*)mbi->framebuffer_addr, "Lower Memory: ", white, blue);
    put_number((void*)mbi->framebuffer_addr, mbi->mem_lower, 10, white, blue);
    println((void*)mbi->framebuffer_addr, " Bytes", white, blue);
    print((void*)mbi->framebuffer_addr, "Upper Memory: ", white, blue);
    put_number((void*)mbi->framebuffer_addr, mbi->mem_upper, 10, white, blue);
    println((void*)mbi->framebuffer_addr, " Bytes", white, blue);
    println((void*)mbi->framebuffer_addr, "Memory Map: ", red, blue);
    for(mmap* ptr = (void*)mbi->mmap_addr; ptr <= (mmap*)(mbi->mmap_addr) + (mbi->mmap_length / sizeof(mmap)); ptr++){
        if(ptr->type == 1){
            print((void*)mbi->framebuffer_addr, "Base Address: 0x", white, blue);
            if(ptr->base_addr == 0) print((void*)mbi->framebuffer_addr, "000000", white, blue);
            put_number((void*)mbi->framebuffer_addr, ptr->base_addr, 16, white, blue);
            print((void*)mbi->framebuffer_addr, "    Length: ", white, blue);
            put_number((void*)mbi->framebuffer_addr, ptr->length, 10, white, blue);
            println((void*)mbi->framebuffer_addr, " Bytes", white, blue);
        }
    }
    init_pool(); //初始化内存池
    println((void*)mbi->framebuffer_addr, "Memory Using: ", red, blue);
    print((void*)mbi->framebuffer_addr, "Base Address: 0x", white, blue);
    put_number((void*)mbi->framebuffer_addr, (unsigned long)&memory_pool, 16, white, blue);
    print((void*)mbi->framebuffer_addr, "    Length: ", white, blue);
    put_number((void*)mbi->framebuffer_addr, SPACE, 10, white, blue);
    println((void*)mbi->framebuffer_addr, " MB", white, blue);
    println((void*)mbi->framebuffer_addr, "Welcome to Self-Saving Killer!", green, blue);
    println((void*)mbi->framebuffer_addr, "Author: OIer-Meet Dev Team", blue, blue);
    println((void*)mbi->framebuffer_addr, "Have a good time!", red, blue);
    println((void*)mbi->framebuffer_addr, "Test message: The quick brown fox jumps over the lazy dog.", green, blue);
    println((void*)mbi->framebuffer_addr, "Press any key to continue...", red, blue);
    getchar();
    entry((void*)mbi->framebuffer_addr); //调用主函数
}