; bootloader.asm
; 加载主程序
%include 'define.asm'
[bits 16]
org 0x7e00 ; Bootloader 加载地址 0x7e00 - 0x7f00
pgdt dw 0 
    dd GDT_START_ADDRESS

; 初始化图形模式
mov ax, 0x4f02
mov bx, 0x105
int 0x10
; 隐藏光标
mov ah, 0x01
mov cx, 0x0100
int 0x10

; 空描述符
mov dword [GDT_START_ADDRESS + 0x00], 0x00
mov dword [GDT_START_ADDRESS + 0x04], 0x00  
    
; 创建描述符，这是一个数据段，对应0~4GB的线性地址空间
mov dword [GDT_START_ADDRESS + 0x08], 0x0000ffff    ; 基地址为0，段界限为0xFFFFF
mov dword [GDT_START_ADDRESS + 0x0c], 0x00cf9200    ; 粒度为4KB，存储器段描述符 
    
; 建立保护模式下的堆栈段描述符       
mov dword [GDT_START_ADDRESS + 0x10], 0x00000000    ; 基地址为0x00000000，界限0x0
mov dword [GDT_START_ADDRESS + 0x14], 0x00409600    ; 粒度为1个字节
    
; 建立保护模式下的显存描述符    
mov dword [GDT_START_ADDRESS + 0x18], 0x80007fff    ; 基地址为0x000B8000，界限0x07FFF 
mov dword [GDT_START_ADDRESS + 0x1c], 0x0040920b    ; 粒度为字节
    
; 创建保护模式下平坦模式代码段描述符
mov dword [GDT_START_ADDRESS + 0x20], 0x0000ffff    ; 基地址为0，段界限为0xFFFFF
mov dword [GDT_START_ADDRESS + 0x24], 0x00cf9800    ; 粒度为4kb，代码段描述符

mov word [pgdt], 39 ; 描述符表的界限    
lgdt [pgdt]

in al, 0x92 ; 南桥芯片内的端口 
or al, 0000_0010B
out 0x92, al ; 打开A20

cli
mov eax, cr0
or eax, 1
mov cr0, eax
jmp dword CODE_SELECTOR:protect_mode

[bits 32]
protect_mode:
    mov eax, DATA_SELECTOR
    mov ds, eax
    mov es, eax
    mov eax, STACK_SELECTOR
    mov ss, eax
    mov eax, VIDEO_SELECTOR
    mov gs, eax
jmp $

times 512 - ($ - $$) db 0 ; 对齐 512 字节（1 扇区）