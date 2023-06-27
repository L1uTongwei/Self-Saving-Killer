; 参数：起始扇区（edi） 写入地址（ebx） 扇区数量（esi）
; 读取以扇区 eax 为开始的数据
; 数据写入地址 RAM:ebx
readData:
    _loop:
        mov eax, edi
        call readDisk
        inc edi
        add esi, -1
        cmp esi, 0
    jg _loop
ret