; tools.asm
; 工具类包含文件
jmp tools_asm_end

%define DRAM ds ; 数据地址寄存器
%define SRAM ss ; 栈地址寄存器
%define VRAM es ; 显存

%include 'tools/draw.asm'
%include 'tools/disk.asm'
%include 'tools/color.asm'

tools_asm_end: