; bootloader.asm
; 加载主程序
[bits 16]
org 0x7e00 ; Bootloader 加载地址 0x7e00 - 0x7f00
GDT_START_ADDRESS equ 0x8800 ; GDT 表地址
pgdt dw 0 
    dd GDT_START_ADDRESS

call clear
mov ecx, title_end - title ; 循环次数
mov esi, title ; 文字地址
call output_string
call output_return
mov ecx, load_protect_end - load_protect ; 循环次数
mov esi, load_protect ; 文字地址
call output_string

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

; 平坦模式数据段选择子
DATA_SELECTOR equ 0x8
; 平坦模式栈段选择子
STACK_SELECTOR equ 0x10
; 平坦模式视频段选择子
VIDEO_SELECTOR equ 0x18
VIDEO_NUM equ 0x18
; 平坦模式代码段选择子
CODE_SELECTOR equ 0x20

in al, 0x92 ; 南桥芯片内的端口 
or al, 0000_0010B
out 0x92, al ; 打开A20

cli
mov eax, cr0
or eax, 1
mov cr0, eax
jmp dword CODE_SELECTOR:protect_mode

output_string:
    mov ah, 0x0e ; 显示字符模式
    mov al, [esi]
    int 0x10 ; 显示字符
    inc esi
    loop output_string
ret

output_return:
    mov ah, 0x0e
    mov al, 10
    int 0x10
    mov ah, 0x0e
    mov al, 13
    int 0x10
ret

clear:
    mov ah, 0x0f
    int 0x10
    mov ah, 0x00
    int 0x10
    mov ah, 0x0b
    mov bh, 0x00
    mov bl, 0x11
    int 0x10
ret

; 数据
title db '[Bootloader] Self-Saving Killer Loading...'
title_end:

load_protect db 'Loading Protect Mode... '
load_protect_end:

success db 'Success!'
success_end:

[bits 32]
protect_mode:
    mov eax, DATA_SELECTOR
    mov ds, eax
    mov es, eax
    mov eax, STACK_SELECTOR
    mov ss, eax
    mov eax, VIDEO_SELECTOR
    mov gs, eax
    mov ecx, success_end - success
    mov ebx, 80 * 2 + 48
    mov esi, success
    mov ah, 0x3
    output_protect_mode_tag:
        mov al, [esi]
        mov word[gs:ebx], ax
        add ebx, 2
        inc esi
        loop output_protect_mode_tag
jmp $

times 512 - ($ - $$) db 0 ; 对齐 512 字节（1 扇区）