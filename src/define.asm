; define.asm
; 宏定义文件

GDT_START_ADDRESS equ 0x8800 ; GDT 表地址
; 平坦模式数据段选择子
DATA_SELECTOR equ 0x8
; 平坦模式栈段选择子
STACK_SELECTOR equ 0x10
; 平坦模式视频段选择子
VIDEO_SELECTOR equ 0x18
VIDEO_NUM equ 0x18
; 平坦模式代码段选择子
CODE_SELECTOR equ 0x20