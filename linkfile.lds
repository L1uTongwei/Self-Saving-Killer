ENTRY(start)
INPUT(object/main.o)
OUTPUT(object/boot/kernel)
STARTUP(object/bootloader.o)
SECTIONS
{
    . = 0x100000;
    .text : {*(.text)}
    .data : {*(.data)}
    .bss : {*(.bss)}
    .memory_pool : {*(.memory_pool)}
}