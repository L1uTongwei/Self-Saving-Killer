; main.asm
; 主程序
[bits 32]
%include 'tools.asm'
org CODE_BEGIN

CODE_OFFSET equ 0x200
ASCII_BEGIN equ CODE_BEGIN + CODE_OFFSET
ASCII_OFFSET equ 0x1000

main:
    call drawMenu ; 绘制主菜单
jmp $

; 工具函数 drawBitmap
%include 'drawBitmap.asm'
; 主菜单相关函数
%include 'menu.asm'