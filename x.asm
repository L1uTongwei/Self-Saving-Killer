%line 3+1 src/boot/bootloader.asm
[bits 16]
[org 0x7e00]
%line 3+1 src/tools/tools.asm
jmp tools_asm_end

%line 8+1 src/tools/tools.asm

%line 8+1 src/tools/draw.asm
covertXY:
 imul eax, 1024
 add eax, ebx
ret



writePixel:
 call covertXY
 mov [es:eax], cl
ret




readPixel:
 call covertXY
 mov al, [es:eax]
ret
%line 11+1 src/tools/disk.asm
readDisk:
 mov dx, 0x1f2
 mov al, 0x01
 out dx, al

 mov dx, 0x1f3
 out dx, al

 inc dx
 mov al, ah
 out dx, al

 inc dx
 mov al, 0x00
 out dx, al

 inc dx
 mov al, 0xe0
 out dx, al

 inc dx
 mov al, 0x20
 out dx, al


 .waits:
 in al, dx
 and al, 0x88
 cmp al, 0x08
 jnz .waits


mov cx, 256
mov dx, 0x1f0

 .readw:
 in ax, dx
 mov [ds:ebx], ax
 add ebx, 2
 loop .readw

ret
%line 6+1 src/tools/color.asm
defColor:
 mov di, ax
 mov al, dl
 mov dx, 0x3c8
 out dx, al
 mov ax, di
 mov dx, 0x3c9
 out dx, al
 mov al, bl
 out dx, al
 mov al, cl
 out dx, al
ret
%line 13+1 src/tools/tools.asm
tools_asm_end:
%line 7+1 src/boot/bootloader.asm
pgdt dw 0
 dd GDT_START_ADDRESS


mov ax, 4F02H
mov bx, 4105H
int 10h

mov ax, 0x9000
mov es, ax
mov di, 0
mov ax, 0x4f01
mov cx, 0x101
int 0x10
mov ebx, [es:40]

GDT_START_ADDRESS equ 0x8800


mov dword [GDT_START_ADDRESS + 0x00], 0x00
mov dword [GDT_START_ADDRESS + 0x04], 0x00


mov dword [GDT_START_ADDRESS + 0x08], 0x0000ffff
mov dword [GDT_START_ADDRESS + 0x0c], 0x00cf9200


mov dword [GDT_START_ADDRESS + 0x10], 0x00000000
mov dword [GDT_START_ADDRESS + 0x14], 0x00409600


mov word [GDT_START_ADDRESS + 0x18], 0xffff
mov word [GDT_START_ADDRESS + 0x1a], bx

shr ebx, 16
mov byte [GDT_START_ADDRESS + 0x1c], bl
mov word [GDT_START_ADDRESS + 0x1d], 0xc092
mov byte [GDT_START_ADDRESS + 0x1f], bh


mov dword [GDT_START_ADDRESS + 0x20], 0x0000ffff
mov dword [GDT_START_ADDRESS + 0x24], 0x00cf9800


DATA_SELECTOR equ 0b1000

STACK_SELECTOR equ 0b10000

VIDEO_SELECTOR equ 0b11000

CODE_SELECTOR equ 0b100000

mov word [pgdt], 39
lgdt [pgdt]

in al, 0x92
or al, 0000_0010B
out 0x92, al

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
 mov esp, 0x7c00
 mov eax, VIDEO_SELECTOR
 mov es, eax
 jmp main
 jmp $

%line 4+1 src/main.asm
main:

 mov ax, 0
 mov bx, 0
 mov cx, 32
 mov dx, 0
 call defColor


 mov ax, 63
 mov bx, 63
 mov cx, 63
 mov dx, 1
 call defColor


 mov eax, 1
 mov ebx, 1
 mov cl, 1
 call writePixel
ret
