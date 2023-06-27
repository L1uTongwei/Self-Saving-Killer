; 在指定位置绘制一个可控颜色图块
; 栈参数：地址（dword）长度（word）高度（word）起始位置 X（word）起始位置 Y（word）颜色（word）
pop eax ; 地址
pop bx ; 长度
pop cx ; 高度
.startx dw 0
pop word [.startx]
.starty dw 0 
pop word [.starty]
.endX dw 0
push word [.startx]
pop word [.endX]
add word [.endX], bx
mov si, [.starty] ; Y 坐标初始值
pop bx ; 颜色
.loop2.loop1:
    mov di, [.startx] ; X 坐标初始值
    .loop2:
        mov edx, esi
        imul edx, 1024
        add edx, edi

        test byte [eax], 0b00000001
        jmp .fill1
        .callback1:

        test byte [eax], 0b00000010
        jmp .fill2
        .callback2:

        test byte [eax], 0b0000100
        jmp .fill3
        .callback3:

        test byte [eax], 0b00001000
        jmp .fill4
        .callback4:

        test byte [eax], 0b00010000
        jmp .fill5
        .callback5:

        test byte [eax], 0b00100000
        jmp .fill6
        .callback6:

        test byte [eax], 0b01000000
        jmp .fill7
        .callback7:

        test byte [eax], 0b10000000
        jmp .fill8
        .callback8:
        
        add di, 8
        cmp di, word [endX]
        jle .loop2
    inc si
loop .loop2.loop1
jmp .end

.fill1:
mov byte [VRAM:edx], bx
jmp .callback1

.fill2:
mov byte [VRAM:edx + 1], bx
jmp .callback2

.fill3:
mov byte [VRAM:edx + 2], bx
jmp .callback3

.fill4:
mov byte [VRAM:edx + 3], bx
jmp .callback4

.fill5:
mov byte [VRAM:edx + 4], bx
jmp .callback5

.fill6:
mov byte [VRAM:edx + 5], bx
jmp .callback6

.fill7:
mov byte [VRAM:edx + 6], bx
jmp .callback7

.fill8:
mov byte [VRAM:edx + 7], bx
jmp .callback8

.end: