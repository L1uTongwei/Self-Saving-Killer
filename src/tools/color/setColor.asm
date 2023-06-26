; 定义一个颜色
; 参数：R&G（bh, bl）B&编号（ch, cl）
mov al, cl
mov dx, 0x3c8
out dx, al
mov al, bh
mov dx, 0x3c9
out dx, al
mov al, bl
out dx, al
mov al, ch
out dx, al