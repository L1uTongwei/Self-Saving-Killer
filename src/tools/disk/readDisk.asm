; 从硬盘读取一个逻辑扇区
; 参数列表
; eax 起始扇区
; DRAM:ebx = 读取出的数据放入地址
; 返回 ebx = ebx + 512            

mov dx, 0x1f3 ; 0x1f3
out dx, al    ; LBA地址7~0

mov dx, 0x1f4 ; 0x1f4
mov al, ah
out dx, al    ; LBA地址15~8

mov dx, 0x1f5 ; 0x1f5
shr eax, 16
out dx, al    ; LBA地址23~16

mov dx, 0x1f6 ; 0x1f6
and ah, 0x0f
or ah, 0xe0
mov al, ah  
out dx, al    ; LBA地址27~24

mov dx, 0x1f2
mov al, 0x01
out dx, al    ; 读取1个扇区

mov dx, 0x1f7 ; 0x1f7
mov al, 0x20  ; 读命令
out dx, al

; 等待处理其他操作
.waits:
    nop
    in  al, dx        
    and al, 0x88
    cmp al, 0x08
jnz .waits                           

; 读取512字节到地址ds:bx
mov cx, 256    ; 每次读取一个字，2个字节，因此读取256次即可           
mov dx, 0x1f0

.readw:
    in ax, dx
    mov [ds:ebx], ax
    add ebx, 2
loop .readw