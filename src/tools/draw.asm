; draw.asm
; 绘制函数
; 应只在 tools.asm 包含

; 将 X, Y 坐标转换为下标
; 参数： X 坐标（eax），Y 坐标（ebx）
; 返回于 eax
covertXY:
    imul eax, 1024
    add eax, ebx
ret

; 写入 VRAM 中的像素
; 参数：X 坐标（eax） Y 坐标（ebx） 颜色（cl）
writePixel:
    call covertXY
    mov [VRAM:eax], cl
ret

; 读取 VRAM 中的像素
; 参数：X 坐标（eax）Y 坐标（ebx）
; 返回于 al
readPixel:
    call covertXY
    mov al, [VRAM:eax]
ret