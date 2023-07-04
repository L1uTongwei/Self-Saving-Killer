; 写入位图文件
; 栈参数：地址（dword）
drawBitmap:
    mov edi, [ESP + 4] ; 取地址
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
    mov ecx, 768 - 1
    _loop3:
        ; 外层循环 eax += 行数 * 列数（显存）
        ; 同时初始化 ebx = 0 （列扫描线）
        mov eax, ecx
        imul eax, 1024
        mov ebx, 0
        __loop3:
            ; 内层循环 ebx: 0 ~ 文件行数
            ; 同时增加显存
            mov dl, byte [RAM:edi]
            mov [VRAM:eax], byte dl
            inc eax
            inc ebx
            inc edi
            cmp ebx, 1024
        jl __loop3
    loop _loop3
    pop eax
    pop edi
jmp dword eax