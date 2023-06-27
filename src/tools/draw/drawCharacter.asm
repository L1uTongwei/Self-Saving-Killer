; 在指定位置绘制一个字符
; 栈参数：字库编码（dword） 字符地址（dword） 字符宽度（word） 指定位置 X（word） 指定位置 Y（word） 颜色（word）
drawCharacter:
    pop eax ; 字符编码
    pop esi ; 字库地址
    add esi, eax ; 计算字体地址
    pop bx ; 字符宽度
    _startx dw 0
    pop word [_startx]
    _starty dw 0
    pop word [_starty]
    _color dw 0
    pop word [_color]  ; 颜色
    mov eax, 0
    _loopRows:
        mov ebx, [_starty]
        imul ebx, 1024
        add ebx, [_startx]
        add ebx, ecx
        mov cl, 0
        mov bx, word [RAM:esi]
        _loopColumn:
            mov di, bx
            shr di, cl
            and di, 0x01
            test di, 0x01
            jz _cloop
            mov ch, byte [_color + 1]
            mov [VRAM:ebx], ch
        _cloop:
            inc ebx
            cmp cl, 16
        jl _loopColumn
        inc esi
    cmp eax, 16
    jl _loopRows
ret