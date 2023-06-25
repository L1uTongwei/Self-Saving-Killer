; tools.asm
; 工具类包含文件
jmp tools_asm_end

DRAM equ ds ; 数据地址寄存器
SRAM equ ss ; 栈地址寄存器
VRAM equ es ; 显存

%include 'tools/draw.asm'
%include 'tools/disk.asm'

tools_asm_end: