; 将 X, Y 坐标转换为下标
; 参数： X 坐标，Y 坐标
; 返回于栈
covertXY:
    imul ebx, 1024
    add eax, ebx
ret