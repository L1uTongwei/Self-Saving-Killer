这是 SSK 引擎的开发文档，讲述 SSK 包的格式及原理。

如果想要开发一个基于 SSK 的游戏，首先需要创建项目文件夹。

编译的 SSK 包的开头是一个文件类型戳记，为`FF 53 53 4B FF`（即`\xffSSK\xff`）

然后是一个结构，用来让 SSK 引擎知道数据的组织形式，如下：

```c
struct{
    uint32_t info_offset; //包信息表的偏移量（默认为 0x05）
    uint32_t character_offset; //角色表的偏移量
};
```

在 information.json 中写入一个对象，其包含属性如下：

- `name` 字符串，表示该项目的名称。
- `author` 字符串，表示项目作者。
- `version` 字符串，用于指明版本。
- `description` 字符串，写上项目的描述。
- `license` 字符串，该项目使用的许可证（如果不使用许可证可以写`none`之类）

这些属性被写入生成的 SSK 包的第一个表，并且显示为 SSK 引擎默认字体。

在 character.json 中写入一个数组，其类型是一个对象。对象包含的属性如下：

- `character` 字符串，角色名称。
- `default` 数组，保存二元组，第一个元素是变量，第二个是默认值（没写就是零）
  关于变量参见下文。
- `limit` 数组，保存二元组，第一个元素是变量，第二个是上限（没写不限制）
- `skill` 数组，技能名称。

这个数组的类型又是对象，表示一个技能。对象包含的属性如下：

- `name` 字符串，技能名称。
- `trigger` 对象，触发器。
  其是一个对象，至少包含 `type` 属性。
  如果 `type="active"`，那么表示这是一个主动技能。
  如果 `type="passive"`，那么还有一个 `when` 字段，表示这是一个被动技能。
  `when="onhurt"`表示受到伤害触发，`when="<name>.xxx"`表示在某角色触发某技能后触发。
  受伤的事件保留编号为零。
- `cd-local` 数字，表示使用技能后多少回合无法再次使用。
- `cd-global` 数字，表示使用技能后多少回合无法使用任何技能。
- `deplete` 数组，表示使用技能损耗的数值，保存二元组，第一个元素是变量，第二个是减少的数值。
  0 号变量保留为 `hp`，1 号变量保留为 `hurt`。
- `requirement` 数组，表示依赖的变量应当满足的条件，保存二元组，第一个元素是变量，第二个是条件。
  条件例如：`>2` `<=3` `=16` 等等
- `target` 字符串，表示该技能针对的目标。
  `target="enemy"` 表示该技能针对敌人 `target="self"` 表示该技能对自己使用
  `target="friend"` 表示该技能对友军使用，`target=all` 表示该技能对全体使用
  `target=all-enemies` 表示该技能对全体敌人使用，`target=all-friends` 表示该技能对全体友军使用
- `effect` 对象，表示该技能造成的影响。
  影响这块主要是针对目标 HP 和目标 CD。
  对目标 HP 的减少值是由一次函数 $f(x)=ax+b+c$ 决定的，其中 $x$ 为玩家的 `hate`，$c$是武器带来的增益。
  `base` 数字，表示函数的截距。
  `magnification` 数字，表示函数的系数。
  `cd` 数字，表示对目标全局 CD 的增加量。 
- `obtain` 字符串，表示加载的场景名称，
  当该名称的场景被加载，技能就会启用。
  显然 "none" 表示默认启用。

编译器会将 `name` 属性自动处理为一个数字索引。

所以会生成这样的结构：

```c
uint32_t character_length;
struct{
	uint32_t name;
    uint32_t default_length;
    struct{
        uint32_t variable;
        uint32_t value;
    }*default;
    uint32_t limit_length;
    struct{
        uint32_t variable;
        uint32_t value;
    }*limit;
	uint8_t skill_length;
	struct{
		uint32_t name;
		uint32_t trigger;
		/*
			最高位为主动/被动，为1则为主动，否则被动
			前15位为技能编号，后16位为角色编号
		*/
		uint8_t cd_local;
		uint8_t cd_global;
		uint32_t deplete_length;
		struct{
			uint32_t variable;
			uint32_t reduce;
		}*deplete;
		uint32_t requirement_length;
		struct{
			uint32_t variable;
			uint32_t require;
		}*requirement;
		uint8_t target;
		/*
			0: self
			1: enemy
			2: friend
			3: all-enemies
			4: all-friends
			5: all
		*/
		struct{
			uint32_t base;
			uint32_t magnification;
			uint8_t cd;
		}effect;
		uint8_t obtain_length;
		char* obtain;
	}*skill;
}*character;
```

为了让 SSK 引擎能够正确、正常地读取贴图、音乐及各种各样的文件，我们设计了结构表。

这个表是 `structure.json` 里的对象，主要是文件与名称的映射。

- `music` 属性是一个二元组数组，用于音乐文件的映射（`wav` 格式）。
- `image` 属性是一个二元组数组，用于图像文件的映射（24位 `bmp` 格式）。

结构表是提供给编译器使用的，并不会被写入到文件。