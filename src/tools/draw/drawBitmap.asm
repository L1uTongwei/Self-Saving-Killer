; 写入位图文件
; 参数：地址（edi） 文件行数（esi） 文件列数（ecx）显存起始位置 X（eax） 显存起始位置 Y（ebx）
drawBitmap:
    startx dw 0
    mov [startx], eax ; 读取起始位置 X
    starty dw 0
    mov [starty], ebx ; 读取起始位置 Y
    filex dw 0
    mov [starty], esi ; 读取起始位置 Y
    filey dw 0
    mov [starty], ecx ; 读取起始位置 Y
    ; 读取调色板
    mov esi, 0
    mov ax, 0
    mov cl, 4
    _loop2:
        ; 写入颜色（B G R A）
        mov ax, si
        mov dx, 0x3c8
        out dx, al

        mov bx, [RAM:edi + 2]
        mov dx, 0x3c9
        mov al, bh ; R (bl)
        div cl
        out dx, al

        mov bx, [RAM:edi]
        mov al, bh ; G
        div cl
        out dx, al

        mov al, bl ; B
        div cl
        out dx, al

        inc esi
        add edi, 4
        cmp esi, 255 ; 读取 256 种颜色
    jle _loop2
    ; 写入屏幕
    mov esi, [filex] ; 读取文件行数
    mov ebx, 0x00
    mov ecx, [filey] ; 读取文件列数
    add cx, -1
    _loop3:
        ; 外层循环 eax（显存）
        ; 同时初始化 ebx = 0 （列扫描线）
        mov eax, ecx
        add eax, [starty]
        imul eax, 1024
        add eax, [startx]
        mov ebx, 0x00
        __loop3:
            ; 内层循环 ebx: 0 ~ 文件行数
            ; 同时增加显存
            mov dl, byte [RAM:edi]
            mov [VRAM:eax], byte dl
            inc eax
            inc ebx
            inc edi
            cmp ebx, esi
        jl __loop3
    loop _loop3
ret