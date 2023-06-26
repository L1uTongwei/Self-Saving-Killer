; 写入位图文件
; 栈参数：地址（dword） 文件行数（word） 文件列数（word）显存起始位置（dword）
pop edi ; 取地址
; 读取调色板
mov esi, 0
mov ax, 0
mov cl, 4
_loop2:
    ; 写入颜色（B G R A）
    mov ax, si
    mov dx, 0x3c8
    out dx, al
    
    mov bx, [DRAM:edi + 2]
    mov dx, 0x3c9
    mov al, bh ; R (bl)
    div cl
    out dx, al

    mov bx, [DRAM:edi]
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
pop si ; 读取文件行数
mov ebx, 0x00
pop cx ; 读取文件列数
add cx, -1
start dd 0
pop dword [start] ; 读取起始位置
_loop3:
    ; 外层循环 eax += 行数 * 列数（显存）
    ; 同时初始化 ebx = 0 （列扫描线）
    mov eax, ecx
    imul eax, esi
    add eax, [start]
    mov ebx, 0x00
    __loop3:
        ; 内层循环 ebx: 0 ~ 文件行数
        ; 同时增加显存
        mov dl, byte [DRAM:edi]
        mov [VRAM:eax], byte dl
        inc eax
        inc ebx
        inc edi
        cmp ebx, esi
    jl __loop3
loop _loop3