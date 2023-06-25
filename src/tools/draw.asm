; draw.asm
; 绘制函数
; 应只在 tools.asm 包含

; 将 X, Y 坐标转换为下标
; 参数： X 坐标（eax），Y 坐标（ebx）
; 返回于 eax
covertXY:
    imul ebx, 1024
    add eax, ebx
ret

; 写入 VRAM 中的像素
; 参数：X 坐标（eax） Y 坐标（ebx） 颜色（cl）
writePixel:
    call covertXY
    mov [VRAM:eax], cl
ret

; 读取 VRAM 中的像素
; 参数：X 坐标（eax）Y 坐标（ebx）
; 返回于 al
readPixel:
    call covertXY
    mov al, [VRAM:eax]
ret

; 读取以扇区 ax 为开始的位图文件
; 将要读取 1539 个扇区 (0xC0600 字节)
; 数据写入地址 DRAM:ebx
readBitmap:
    mov di, ax ; 保存起始扇区
    mov si, 0
    _loop:
        mov ax, di
        call readDisk
        inc di
        inc si
        cmp si, 1539
    jl _loop
ret

; 写入以地址 DRAM:ebx 为开始的位图文件
drawBitmap:
    mov edi, ebx
    add edi, 55 ; 从第 55 字节开始读取调色板
    mov cx, 0
    _loop2:
        ; 写入颜色（B G R A）
        mov ebx, [DRAM:edi]
        mov al, cl
        mov dx, 0x3c8
        out dx, al
        mov al, bh ; R
        mov dx, 0x3c9
        out dx, al
        shr ebx, 8
        mov al, bl ; G
        out dx, al
        mov al, bh ; B
        out dx, al
        add edi, 4
        inc cx
        cmp cx, 256 ; 读取 256 种颜色
    jl _loop2
    mov ebx, 0x00 ; X
    mov ecx, 768 - 1  ; Y
    _loop3:
        mov ebx, 0x00
        __loop3:
            mov dl, byte [DRAM:edi]
            mov eax, ecx
            imul eax, 1024
            add eax, ebx
            mov [VRAM:eax], byte dl
            inc ebx
            inc edi
            cmp ebx, 1024
        jl __loop3
    loop _loop3
ret