; bootloader.asm
; 加载主程序
[bits 16]
org 0x7e00 ; Bootloader 加载地址 0x7e00 - 0x7f00

pgdt dw 0 
    dd GDT_START_ADDRESS

; 初始化图形模式
mov ax, 4F02H
mov bx, 4105H 
int 10h
; 线性地址
mov ax, 0x9000
mov es, ax
mov di, 0
mov ax, 0x4f01
mov cx, 0x101
int 10h
mov ebx, [es:40]

GDT_START_ADDRESS equ 0x8800 ; GDT 表地址

; 空描述符
mov dword [GDT_START_ADDRESS + 0x00], 0x00
mov dword [GDT_START_ADDRESS + 0x04], 0x00  
    
; 创建描述符，这是一个数据段，对应0~4GB的线性地址空间
mov dword [GDT_START_ADDRESS + 0x08], 0x0000ffff    ; 基地址为0，段界限为0xFFFFF
mov dword [GDT_START_ADDRESS + 0x0c], 0x00cf9200    ; 粒度为4KB，存储器段描述符 
    
; 建立保护模式下的堆栈段描述符       
mov dword [GDT_START_ADDRESS + 0x10], 0x00000000    ; 基地址为0x00000000，界限0xFFFFF
mov dword [GDT_START_ADDRESS + 0x14], 0x00409600    ; 粒度为1个字节
    
; 建立保护模式下的显存描述符
mov word [GDT_START_ADDRESS + 0x18], 0xffff         ; 显卡线性地址的低16位
mov word [GDT_START_ADDRESS + 0x1a], bx             ; 由于像素较多，段界限设置成0xfffff

shr ebx, 16                                         ; 取出ebx的高16位,显卡线性地址的高16位 
mov byte [GDT_START_ADDRESS + 0x1c], bl               
mov word [GDT_START_ADDRESS + 0x1d], 0xc092         ; f 位段界限最高位
mov byte [GDT_START_ADDRESS + 0x1f], bh          
    
; 创建保护模式下平坦模式代码段描述符
mov dword [GDT_START_ADDRESS + 0x20], 0x0000ffff    ; 基地址为0，段界限为0xFFFFF
mov dword [GDT_START_ADDRESS + 0x24], 0x00cf9800    ; 粒度为4kb，代码段描述符

; 平坦模式数据段选择子
DATA_SELECTOR equ 0b1000
; 平坦模式栈段选择子
STACK_SELECTOR equ 0b10000
; 平坦模式视频段选择子
VIDEO_SELECTOR equ 0b11000
; 平坦模式代码段选择子
CODE_SELECTOR equ 0b100000

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
    mov eax, STACK_SELECTOR
    mov ss, eax
    mov eax, VIDEO_SELECTOR
    mov es, eax
    %include 'main.asm'