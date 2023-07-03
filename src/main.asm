; main.asm
; 主程序
[bits 32]
%include 'tools/tools.asm'
org CODE_BEGIN

CODE_OFFSET equ 0x200
ASCII_BEGIN equ CODE_BEGIN + CODE_OFFSET
ASCII_OFFSET equ 0x1000
MENU_BEGIN equ ASCII_BEGIN + ASCII_OFFSET
MENU_OFFSET equ 0xC0400

main:
    ; 加载 assets/menu.bmp （背景页位图）
    push dword MENU_BEGIN ; 地址
    call drawBitmap
jmp $

%include 'tools/draw/drawBitmap.asm'