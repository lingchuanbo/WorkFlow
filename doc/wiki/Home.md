[English Version](https://github.com/goreliu/vimdesktop/wiki/VimDesktop-Introduction-[English-Version])

## 什么是VimDesktop

VimDesktop = Vim Mode At Desktop

Vim的模式与快捷键让人着迷，使用Vim的人会希望将这种模式应用在任意程序中，于是有了Vimperator/Pentadactyl@Firefox，vimium@Chrome。

2012年中国小伙Array(linxinhong.sky At gmail.com)使用ahk开发了viatc(Vim Mode At Total Commander)，这让强大的文件管理利器Total Commander插上了Vim的翅膀：把复杂的操作，用两只手在键盘上敲击出来；最多两次按键，即可完成大部分TC操作。

2013年，viatc扩展为VimDesktop(Vim Mode At Desktop)，使得我们可以在Windows的任意桌面程序上使用Vim的模式进行操作。

## VimDesktop适用对象

* Total Commander：最好你已经安装并使用了Total Commander，认为TC大大提高了你的工作效率，那么你一定要尝试一下VimDesktop，VimDesktop将会再一次提升你的使用境界——VimDesktop目前对Total Commander的支持最为成熟和完善，毕竟VimDesktop是从viatc发展过来的且更为强大；
* 如果你使用Vim作为编辑器，对Vim的操作模式和快捷键有些狂热，希望把它们应用在任何场合，那么VimDesktop也许正是你的期待；
* 如果你已习惯Firefox上的扩展Vimperator/Pentadactyl，并将之作为使用Firefox的重大理由，那么VimDesktop绝对不容错过；
* 如果你使用AutoHotkey编写一些脚本用来辅助工作，那么VimDesktop可以为您提供一种Vim的方式来集中管理这些脚本；
* 如果上述情况你都不了解，那么你必须是一个拥有折腾精神的人，好好学习，天天向上吧。

## VimDesktop能干什么

简单来说，可以将VimDesktop理解为一个可以自定义快捷键的工具；不简单的地方在于，VimDesktop拥有高度可配置性的定义方式：

* 可以定义不带有Win、Ctrl、Alt等辅助功能键的快捷键：这恰恰是VimDesktop能够获得更高效的途径之一；
* 可以定义全局快捷键及其对应的功能：任意场景下按下全局快捷键都会触发你希望执行的操作，VimDesktop可以对系统全局快捷键重新定义，比如我们将Win+E默认打开资源管理器，替换为默认打开Total Commander；
* 可以为指定应用程序定义快捷键
* 可以为指定应用程序的指定界面定义快捷键
* 可以为指定应用程序或指定界面定义多个模式，每种模式下可分别定义不同的快捷键：常用模式如normal、insert，比如在normal模式下按下dd，将删除选定文件，而在插入模式(比如修改文件名时)下按下dd，仅仅是输入了两个字母dd
* 可以通过指定可执行文件、批处理命令的方式来实现快捷键对应的功能
* 可以通过Autohotkey模拟发送按键实现对应功能
* 可以通过Autohotkey编写特定方法实现想要的功能，Autohotkey让你几乎无所不能...

## VimDesktop的安装与配置

* 下载 VimDesktop，[最新版本](https://github.com/goreliu/vimdesktop/releases)

* 运行vimd.exe，此时VimDesktop也许会弹出窗口要求设置Total Commander的安装路径。

此时VimDesktop在系统托盘添加了一个图标，并自动注册了很多热键，可通过右键菜单“查看热键”，来查看：

* 窗口：快捷键起作用的应用窗口，其中全局——相当于系统级的全局快捷键；General——对所有窗口都起作用;TTOTAL_CMD，为Total Commander定义的快捷键

* 模式：类似于Vim的模式，通常包括normal模式(按下win+t（可在配置文件中修改快捷键）可进入），该模式下可使用类似Vim的快捷键进行相关操作，如 `j` 向下滚动；insert模式（在Normal模式下按下 `i` 可进入insert模式），此时通常不包括任何快捷键定义，此时VimDesktop将不起作用。

## 快速上手

### IE浏览器示例

1. 打开IE浏览器
2. 按下快捷键 `win+t` 即进入normal模式
3. 按下 `j`，向下滚动
4. 按下 `k`，向上滚动
5. 按下 `x`，关闭窗口

说明：

* 更多快捷键，VimDesktop托盘图标右键菜单-查看热键，其中窗口-General，模式-normal下的快捷键均可使用
* 如需输入地址、编写内容等，请首先按下 i 进入insert模式，否则将无法正确输入j/k等字符

### Total Commander示例

打开Total Commander，此时默认即为normal模式，此时可使用的常用快捷键如下：

[快捷键列表](https://github.com/goreliu/vimdesktop/wiki/TC%E5%BF%AB%E6%8D%B7%E9%94%AE%E5%88%97%E8%A1%A8)

#### 将TotalCommander作为文件打开对话框
 * `win + o`，全局快捷键，在文件对话框或任意文字编辑界面按下该快捷键将跳转至TC并激活select模式，该模式下可通过按下Ctrl+回车选定文件，如需多选则在TC中选定多个文件后再按Ctrl+回车；
 * 可通过配置文件设置自动激活TC进行文件选择，并排除不需要的自动跳转，注意：仅当对话框的输入框内无文字时才进行自动跳转。

```
[TotalCommander_Config]
;设置为 1 -- 将使用TC作为文件选择对话框，打开文件选择对话框时，会自动跳转到TC
;设置为 0 -- 将禁用TC作为文件选择对话框，此时仍可使用<lwin>o激活TC进行文件选择
AsOpenFileDialog=0

;含有指定字符串的窗体被打开时，禁用自动跳转到TC的功能,以逗号间隔
OpenFileDialogExclude=password,密码,任何字符串,工作表名称,查找,替换
```

更多功能及快捷键：VimDesktop托盘图标，右键菜单，查看热键，窗口-TTOTAL_CMD，模式normal

## 个性化应用

### 通过配置文件自定义快捷键

一千个读者眼里有一千个哈姆雷特，每个人都可以根据自己的喜好来自定义快捷键。

配置文件—— config.ini，可在其内自定义快捷键取代默认的快捷键，可参考我们提供的示例文件 config.ini.help.txt 进行修改。下面提供部分示例：

```
;=====Total Commander快捷键配置=============
[TTOTAL_CMD]
;热键定义语法
;ff 热键 --按下两次f键
;<cm_SearchFor> 对应的动作
;[=normal] 在normal模式下生效
ff=<cm_SearchFor>[=normal]

;全选
a=<cm_SelectAll>[=normal]

;全部取消
<c-d>=<cm_ClearAll>[=normal]

;删除
x=<cm_Delete>[=normal]

;编辑
e=<cm_edit>[=normal]

;弹出右键菜单
o=<cm_ContextMenu>[=normal]

;查看
w=<cm_list>[=normal]

; 运行命令
<s-q>=run|c:\mine\app\run.exe
```

### 编写ahk插件

如果您对ahk比较熟悉，请参考Plugins文件夹中的现有插件来编写插件，丰富VimDesktop的功能。

## 为VimDesktop做贡献

* 提交问题或建议：https://github.com/goreliu/vimdesktop/issues
* 帮助编写文档：https://github.com/goreliu/vimdesktop/wiki
* 编写ahk插件，参考资料： [如何编写一个插件](https://github.com/goreliu/vimdesktop/wiki/%E5%A6%82%E4%BD%95%E5%86%99%E6%8F%92%E4%BB%B6)
* 参与VimDesktop的开发