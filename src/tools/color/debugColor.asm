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
    jmp $
ret