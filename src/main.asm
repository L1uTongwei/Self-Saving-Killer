; main.asm
; 主程序
%include 'tools/tools.asm'
main:
    ; 加载 assets/menu.bmp
    ; 0x100000 - 0x1C0400
    push dword 1538 ; 扇区数量 1538
    push dword 0x100000 ; 写入地址
    push dword 2 ; 起始扇区
    %include 'tools/disk/readData.asm'
    push dword 0x00 ; 起始位置
    push word 768 ; 列数
    push word 1024 ; 行数
    push dword 0x100000 ; 地址
    %include 'tools/draw/drawBitmap.asm'
jmp $