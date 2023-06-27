; 写入位图文件
; 栈参数：地址（dword） 文件行数（word） 文件列数（word）
pop edi ; 取地址
; 读取调色板
mov esi, 0
mov ax, 0
mov cl, 4
.loop1:
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
jle .loop1
; 写入屏幕
pop si ; 读取文件行数
mov ebx, 0x00
pop cx ; 读取文件列数
add cx, -1
.loop3.loop2:
    mov eax, ecx
    imul eax, esi
    mov ebx, 0x00
    .loop3:
        mov dl, byte [DRAM:edi]
        mov [VRAM:eax], byte dl
        inc eax
        inc ebx
        inc edi
        cmp ebx, esi
    jl .loop3
sub cx, 1
cmp cx, 0
jge .loop3.loop2