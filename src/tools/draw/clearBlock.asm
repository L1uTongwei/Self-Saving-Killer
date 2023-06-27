; 清空指定位置的图块
; 栈参数：长度（word）高度（word）起始位置 X（word）起始位置 Y（word）颜色（word）
; 写入数据
pop bx ; 长度
pop cx ; 高度
.startx dw 0
pop word [.startx]
sub [.startx], word 1
.starty dw 0 
pop word [.starty]
sub [.startx], word 1
.endX dw 0
push word [.startx]
pop word [.endX]
add word [.endX], bx
mov si, cx ; Y 坐标初始值
add si, [.starty]
pop bx ; 颜色
.loop2.loop1:
    mov di, [.startx] ; X 坐标初始值
    .loop2:
        mov edx, esi
        imul edx, 1024
        add edx, edi
        mov [VRAM:edx], bl
        inc di
        cmp di, word [.endX]
        jle .loop2
    sub si, 1
    cmp si, [.starty]
jge .loop2.loop1