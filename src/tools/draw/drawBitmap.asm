; 显示图块到指定位置
; 栈参数：地址（dword）
drawBitmap:
    pop esi ; 取地址
    ; 读取调色板
    mov ax, 0
    mov cl, 4
    drawBitmap.loop1:
        ; 写入颜色（B G R A）
        mov ax, si
        mov dx, 0x3c8
        out dx, al

        mov bx, [RAM:esi + 2]
        mov dx, 0x3c9
        mov al, bh
        div cl
        out dx, al

        mov bx, [RAM:esi]
        mov al, bh
        div cl
        out dx, al

        mov al, bl
        div cl
        out dx, al

        inc esi
        add eax, 4
        cmp esi, 255 ; 读取 256 种颜色
    jle drawBitmap.loop1
    ; 写入数据
    mov edx, 1024 * (768 - 1)
    drawBitmap.loop2:
        mov edi, 0
        drawBitmap.loop3:
            mov bl, [RAM:esi]
            mov [VRAM:edx], bl
            inc esi
            inc edx
            inc edi
            cmp edi, 1024
            jl drawBitmap.loop3
        sub edx, 1024 * 2
        cmp edx, 0
    jg drawBitmap.loop2
    jmp $
ret