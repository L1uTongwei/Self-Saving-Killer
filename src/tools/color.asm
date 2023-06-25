; color.asm
; 调色板定义程序

; 定义一个颜色
; 参数：R（ax）G（bx）B（cx）编号（dx）
defColor:
    mov di, ax
    mov al, dl
    mov dx, 0x3c8
    out dx, al
    mov ax, di
    mov dx, 0x3c9
    out dx, al
    mov al, bl
    out dx, al
    mov al, cl
    out dx, al
ret

; 调试使用
debugColor:
    mov al, 0
    mov dx, 0x3c8
    out dx, al
    mov al, 0
    mov dx, 0x3c9
    out dx, al
    mov al, 35
    out dx, al
    mov al, 0
    out dx, al
ret