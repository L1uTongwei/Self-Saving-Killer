; 读取 VRAM 中的像素
; 参数：X 坐标（eax）Y 坐标（ebx）
; 返回于 al
call covertXY
mov al, [VRAM:eax]