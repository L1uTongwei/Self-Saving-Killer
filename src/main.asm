; main.asm
; 主程序
; Bootloader 起始扇区
%define Bootloader_Sector 1
; Bootloader 长度
%define Bootloader_Length 2
main:
    ; 加载 assets/menu.bmp （背景页位图）
    ; 0x100000 - 0x1C0400
    mov edi, Bootloader_Sector + Bootloader_Length  ; 起始扇区
    mov ebx, 0x100000 ; 写入地址
    mov esi, 1538 ; 扇区数量 1538
    call readData
    mov edi, 0x100000 ; 地址
    mov esi, 1024 ; 行数
    mov ecx, 768 ; 列数
    mov eax, 0x00 ; 起始位置 X
    mov ebx, 0x00 ; 起始位置 Y
    call drawBitmap
    ; 加载 assets/ascii.font （字体文件）
    ; 0x0F0000 - 0x0F1000
    mov edi, Bootloader_Sector + Bootloader_Length + 1538  ; 起始扇区
    mov ebx, 0x0F0000 ; 写入地址
    mov esi, 8 ; 扇区数量 1538
    call readData
jmp $
%include 'tools/tools.asm'