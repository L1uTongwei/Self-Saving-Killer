; 读取以扇区 ax 为开始的位图文件
; 将要读取 1538 个扇区 (0xC0400 字节)
; 数据写入地址 DRAM:ebx
mov di, ax ; 保存起始扇区
mov esi, 0
_loop:
    mov ax, di
    %include 'tools/disk/readDisk.asm'
    inc di
    inc esi
    cmp esi, 1538
jl _loop