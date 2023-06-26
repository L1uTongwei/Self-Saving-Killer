; 读取以扇区 ax 为开始的位图文件
; 将要读取 1538 个扇区 (0xC0400 字节)
; 数据写入地址 DRAM:ebx
mov edi, eax ; 保存起始扇区
mov esi, 0
_loop:
    mov eax, edi
    %include 'tools/disk/readDisk.asm'
    inc edi
    inc esi
    cmp esi, 1538
jl _loop