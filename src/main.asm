; main.asm
; 主程序

main:
    ; 定义背景为蓝色
    mov ax, 0
    mov bx, 0
    mov cx, 32
    mov dx, 0
    call defColor

    ; 定义白色
    mov ax, 63
    mov bx, 63
    mov cx, 63
    mov dx, 1
    call defColor

    ; 测试写入像素
    mov eax, 1
    mov ebx, 1
    mov cl, 1
    call writePixel
ret