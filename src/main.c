#include "header.h"
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
    unsigned long flags;
    unsigned long mem_lower;
    unsigned long mem_upper;
    unsigned long boot_device;
    unsigned long cmdline;
    unsigned long mods_count;
    unsigned long mods_addr;
    union
    {
        aout_symbol_table_t aout_sym;
        elf_section_header_table_t elf_sec;
    }u;
    unsigned long mmap_length;
    unsigned long mmap_addr;
}multiboot_info_t;
void __main(unsigned long magic, unsigned long addr){
    multiboot_info_t *mbi;
    mbi = (multiboot_info_t*)addr;
    
}