; tools.asm
; 工具类包含文件

; 数据地址寄存器
%define RAM ds
; 显存
%define VRAM es 

TOTAL_SECTORS equ 1547 ; ROM 扇区数
CODE_BEGIN equ 0x00100000