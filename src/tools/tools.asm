; tools.asm
; 工具类包含文件

; 数据地址寄存器
%define RAM ds
; 显存
%define VRAM gs 

%include 'tools/color/debugColor.asm'
%include 'tools/color/setColor.asm'
%include 'tools/disk/readData.asm'
%include 'tools/disk/readDisk.asm'
%include 'tools/draw/covertXY.asm'
%include 'tools/draw/drawBitmap.asm'
%include 'tools/draw/drawCharacter.asm'
%include 'tools/draw/readPixel.asm'
%include 'tools/draw/writePixel.asm'