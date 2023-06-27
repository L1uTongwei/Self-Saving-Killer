; main.asm
; 主程序
; Bootloader 起始扇区
%define Bootloader_Sector 1
; Bootloader 长度
%define Bootloader_Length 2
main:
    ; 加载 assets/menu.bmp （背景页位图）
    ; 0x100000 - 0x1C0400
    push dword 1538 ; 扇区数量 1538
    push dword 0x100000 ; 写入地址
    push dword 2 ; 起始扇区
    %include 'tools/disk/readData.asm'
    push word 0 ; 起始位置 Y
    push word 0 ; 起始位置 X
    push word 768 ; 列数
    push word 1024 ; 行数
    push dword 0x100000 ; 地址
    %include 'tools/draw/drawBitmap.asm'
jmp $