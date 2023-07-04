; 绘制主菜单
MENU_BEGIN equ ASCII_BEGIN + ASCII_OFFSET
MENU_OFFSET equ 0xC0400
drawMenu:
    pop eax
    ; 加载 assets/menu.bmp （背景页位图）
    push dword MENU_BEGIN ; 地址
    call drawBitmap
    jmp dword eax