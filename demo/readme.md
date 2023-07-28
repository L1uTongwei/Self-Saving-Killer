这是 SSK 引擎的开发文档，讲述 SSK 包的格式及原理。

如果想要开发一个基于 SSK 的游戏，首先需要创建项目文件夹。

编译的 SSK 包的开头是一个文件类型戳记，为`FF 53 53 4B FF`（即`\xffSSK\xff`）

然后是一个结构，用来让 SSK 引擎知道数据的组织形式，如下：

```c
struct{
	uint32_t filesheet_offset; //文件表的偏移量（默认 0x05）
	uint32_t prog_offset; //程序的偏移量
    uint32_t file_offset; //素材文件的偏移量
	uint32_t text_offset; //文本偏移量
};
```

在 structure.json 中写入一个数组，数组的元素是一个字符串，是相对于项目文件夹的路径，这个结构表示文件到索引的映射，方便使用。

然后使用 C 语言通过 `api` 文件夹下的 API 编写基于引擎的游戏程序，编译为代码，保存为项目文件夹下的 `program.bin`。

最后在 text.json 中写入一个数组，数组的元素是一个字符串，表示程序使用的文本。

编译器会自动根据其中的文本生成字模写入 SSK 包并且方便 API 调用。