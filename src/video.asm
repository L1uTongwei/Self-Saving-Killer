; video.asm
; 定义视频相关函数
%include 'define.asm'

mov eax, VIDEO_SELECTOR
mov gs, eax

global _writePixel
_writePixel: ; void writePixel(int x, int y, short color)
    mov ax, [ESP + 4] ; x
    mov bx, [ESP + 8] ; y
    mov cx, [ESP + 12] ; color
    imul eax, 0x0400
    add eax, ebx
    mov [gs:edx], cx
ret

global _readPixel
_readPixel: ; short readPixel(int x, int y)
    mov ax, [ESP + 4] ; x
    mov bx, [ESP + 8] ; y
    imul eax, 0x0400
    add eax, ebx
    mov eax, [gs:edx]
ret