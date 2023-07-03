; 显示图块到指定位置
; 栈参数：地址（dword）
drawBitmap:
    pop eax ; 取地址
    ; 读取调色板
    mov esi, 0
    mov ax, 0
    mov cl, 4
    drawBitmap.loop1:
        ; 写入颜色（B G R A）
        mov ax, si
        mov dx, 0x3c8
        out dx, al
        mov bx, [RAM:eax + 2]
        mov dx, 0x3c9
        mov al, bh
        div cl
        out dx, al
        mov bx, [RAM:eax]
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
    mov esi, 768 - 1
    mov ecx, 0
    drawBitmap.loop2:
        mov edi, 0
        drawBitmap.loop3:
            mov edx, esi
            imul edx, 1024
            add edx, edi
            mov bl, [RAM:eax + edx]
            mov [VRAM:ecx], bl
            inc ecx
            inc edi
            cmp edi, 1024 - 1
            jle drawBitmap.loop3
        sub esi, 1
        cmp esi, 0
    jge drawBitmap.loop2
ret