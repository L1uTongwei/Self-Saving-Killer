; main.asm
; 主程序

main:
    ; 加载 assets/menu.bmp
    ; 0x100000 - 0x1C0600
    mov ax, 2
    mov ebx, 0x100000
    call readBitmap
    mov ebx, 0x100000
    call drawBitmap
ret