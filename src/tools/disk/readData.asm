; 栈参数：起始扇区 写入地址 扇区数量
; 读取以扇区 ax 为开始的数据
; 数据写入地址 DRAM:ebx
pop edi ; 保存起始扇区
pop ebx ; 保存写入地址
pop esi ; 保存扇区数量
_loop:
    mov eax, edi
    %include 'tools/disk/readDisk.asm'
    inc edi
    add esi, -1
    cmp esi, 0
jg _loop