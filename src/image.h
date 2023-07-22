#pragma once
#include "header.h"

//图像显示
//目前只支持 BMP 格式，24位颜色深度，不可压缩

typedef struct{
   unsigned short bfType;	    // 文件的类型，该值必须是0x4D42，也就是字符'BM'。
   unsigned long  bfSize;	    // 位图文件的大小，用字节为单位
   unsigned short bfReserved1; // 保留，必须设置为0
   unsigned short bfReserved2; // 保留，必须设置为0
   unsigned long  bfOffBits;   // 位图数据距离文件开头偏移量，用字节为单位
}bitmap_header_t;

typedef struct{
   unsigned long  biSize;		     // bitmap_info 结构所需要的字数
   unsigned long  biWidth;		     // 图像宽度，单位为像素
   long biHeight;                 // 图像高度，单位为像素，负数，则说明图像是正向的
   unsigned short biPlanes;	     // 为目标设备说明位面数，其值将总是被设为1
   unsigned short biBitCount;	     // 一个像素占用的bit位，值位1、4、8、16、24、32
   unsigned long  biCompression;   // 压缩类型
   unsigned long  biSizeImage;	  // 位图数据的大小，以字节为单位
   unsigned long  biXPelsPerMeter; // 水平分辨率，单位 像素/米
   unsigned long  biYPelsPerMeter; // 垂直分辨率，单位 像素/米
   unsigned long  biClrUsed; 
   unsigned long  biClrImportant; 
}bitmap_info_t;

bitmap_header_t *bitmap_header;
bitmap_info_t *bitmap_info;

//显示一个位图，(x, y) 即该位图左上角的坐标
byte display_bitmap(color framebuffer[768][1024], byte* buffer, uint16_t x, uint16_t y){
   bitmap_header = buffer;
   bitmap_info = buffer + sizeof(bitmap_header_t);
   if(bitmap_header->bfType != 0x4D42 || bitmap_info->biCompression) return 1;
   if(x + bitmap_info->biWidth >= 1024 || y + abs(bitmap_info->biHeight) >= 768) return 2;
   buffer += bitmap_header->bfOffBits;
   if(bitmap_info->biHeight < 0){
      for(uint16_t j = y; j < y - bitmap_info->biHeight; j++){
         for(uint16_t i = x; i < x + bitmap_info->biWidth; i++){
            framebuffer[j][i].blue = *buffer;
            framebuffer[j][i].green = *(buffer + 1);
            framebuffer[j][i].red = *(buffer + 2);
            framebuffer[j][i].reversed = 0;
            buffer += 3;
         }
         buffer += ((bitmap_info->biWidth) * 3) % 4;
      }
   }else{
      for(uint16_t j = y + bitmap_info->biHeight - 1; j >= y; j--){
         for(uint16_t i = x; i < x + bitmap_info->biWidth; i++){
            framebuffer[j][i].blue = *buffer;
            framebuffer[j][i].green = *(buffer + 1);
            framebuffer[j][i].red = *(buffer + 2);
            framebuffer[j][i].reversed = 0;
            buffer += 3;
         }
         buffer += ((bitmap_info->biWidth) * 3) % 4;
      }
   }
   return 0;
}