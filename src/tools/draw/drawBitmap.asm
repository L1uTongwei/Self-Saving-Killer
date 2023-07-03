; 显示图块到指定位置
; 栈参数：地址（dword）长度（word）高度（word）起始位置 X（word）起始位置 Y（word）
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
    pop bx ; 长度
    pop cx ; 高度
    drawBitmap.startx dw 0
    pop word [drawBitmap.startx]
    sub [drawBitmap.startx], word 1
    drawBitmap.starty dw 0 
    pop word [drawBitmap.starty]
    sub [drawBitmap.startx], word 1
    drawBitmap.endX dw 0
    push word [drawBitmap.startx]
    pop word [drawBitmap.endX]
    add word [drawBitmap.endX], bx
    mov si, cx ; Y 坐标初始值
    add si, [drawBitmap.starty]
    drawBitmap.loop2:
        mov di, [drawBitmap.startx] ; X 坐标初始值
        drawBitmap.loop3:
            mov edx, esi
            imul edx, 1024
            add edx, edi
            mov bl, [RAM:eax]
            mov [VRAM:edx], bl
            add di, 8
            cmp di, word [drawBitmap.endX]
            jle drawBitmap.loop3
        sub si, 1
        cmp si, [drawBitmap.starty]
    jge drawBitmap.loop2