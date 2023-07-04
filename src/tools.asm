; tools.asm
; 工具类包含文件

; 数据地址寄存器
%define RAM ds
; 显存
%define VRAM es 

TOTAL_SECTORS equ 1547 ; ROM 扇区数
CODE_BEGIN equ 0x00100000
; 平坦模式数据段选择子
DATA_SELECTOR equ 0b1000
; 平坦模式栈段选择子
STACK_SELECTOR equ 0b10000
; 平坦模式视频段选择子
VIDEO_SELECTOR equ 0b11000
; 平坦模式代码段选择子
CODE_SELECTOR equ 0b100000