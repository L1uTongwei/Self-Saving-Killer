; main.asm
; 主程序
%include 'tools/tools.asm'
CODE_BEGIN equ 0x00010000
CODE_OFFSET equ 0x200
ASCII_BEGIN equ CODE_BEGIN + CODE_OFFSET
ASCII_OFFSET equ 0x1000
MENU_BEGIN equ ASCII_BEGIN + ASCII_OFFSET
MENU_OFFSET equ 0xC0400
main:
    jmp $
    ; 加载 assets/menu.bmp （背景页位图）
    push word 0 ; 起始位置 Y
    push word 0 ; 起始位置 X
    push word 768 ; 列数
    push word 1024 ; 行数
    push dword MENU_BEGIN ; 地址
    ;call drawBitmap
jmp $

;%include 'tools/draw/drawBitmap.asm'