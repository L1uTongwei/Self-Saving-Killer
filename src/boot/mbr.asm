; mbr.asm
; 引导程序 需要加载到 MBR 使用
[bits 16]
org 0x7c00 ; 内存地址 0x7c00 - 0x7e00
mov sp, 0x7c00 ; 初始化栈指针
mov bx, 0x7e00 ; Bootloader 加载地址 0x7e00 - 0x7f00

mov ah, 0x02 ; 读取
mov al, 0x01 ; 扇区数
mov ch, 0x00 ; 柱面
mov cl, 0x02 ; 扇区
mov dh, 0x00 ; 磁头
mov dl, 0x80 ; 驱动器
int 0x13 ; 硬盘中断

jmp 0x7e00 ; 跳转至 bootloader
times 510 - ($ - $$) db 0 ; 对齐 510 字节（1 扇区去掉 2 标志位）
dw 0xaa55 ; MBR 标志位