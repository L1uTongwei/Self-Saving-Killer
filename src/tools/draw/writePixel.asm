; 写入 VRAM 中的像素
; 参数：X 坐标（eax） Y 坐标（ebx） 颜色（cl）
call covertXY
mov [VRAM:eax], cl