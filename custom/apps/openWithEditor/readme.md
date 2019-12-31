# 说明

本程序为多编辑器切换工具,通过配置文件自动生成对应的菜单项快速无缝原位编辑.

本程序最适合的使用场景是作为某个编辑器的 ExternalTool,用于在不同编辑器中来回无缝切换编辑同一个文件.

目前已知支持的编辑器或IDE有:

JetBrains系列IDE, SublimeText, EmEditor, VSCode 等等.

## 本程序的参数配置方法

你可以将本程序假设为一个编辑器,接受固定的参数格式:
*** 注意: 别忘了 `=` 符号 ***
```
openWithEditor.exe /f=filePath /l=lineNumber /c=columnNumber
```

如果只需要打开某个文件,而无需指定光标位置的话:

```
openWithEditor.exe filePath
```

### 参数的意思

|参数名|解释|
|-|-|
|/f=|要编辑的文件完整路径|
|/l=|打开文件后光标所在行号|
|/c=|打开文件后光标所在列号|

## 编辑器配置方法

一个标准的菜单项配置是这样的:
```
[sublimetext]
hotkey=s
path=d:\SublimeText3\sublime_text.exe
paramater=$file:$line:$column
```

其中 section 名称(`sublimetext`)即为菜单中显示的程序名称;

启动快捷键为: `s`, 大小写 *** 不 *** 敏感;

编辑器路径为: `d:\SublimeText3\sublime_text.exe`;

参数格式为: `文件路径:光标所在行号:光标所在列号`.

假设要用 SublimeText 打开文件: `c:\dev\index.php`,并将光标定位到第3行,第10个字符的位置,
最终实际运行的命令行命令为:
```
"d:\SublimeText3\sublime_text.exe" c:\dev\index.php:3:10
```

### 每一项的意义如下表:

名称|意义|说明
---|---|---
hotkey | 激活快捷键 | 暂不支持组合键.
path | 编辑器主程序的完整路径. | 无需用双引号包围.
paramater | 编辑器参数的格式 | 只要格式,而不是具体的值.<br>这里的格式与具体编辑器的参数要求一致,不同的编辑器请参考其文档中的命令行参数来配置.目前默认的配置文件中已经包含了常见的几种编辑器的参数格式配置样例.<br>注意:以下几个参数的名称不可更改,它们是用于自动替换实际值的标记!即如:`$line`最终将自动被替换为数字.<br>`$file` : 传入的文件路径,目前仅支持一个文件路径;<br>`$line` : 指定光标跳转到第几行;<br>`$column` : 指定光标跳转到第几列.

## 其他细节

- 编辑器配置文件的名称必须和 `openWithEditor.exe` 的文件名一致,亦即: 假设你将 `openWithEditor.exe` 改名为 `editWith.exe`的话,你就必须将 `openWith.ini` 改名为 `editWith.ini` ;

- 你可以在你的配置文件中配置任意多个编辑器,而无需考虑这个编辑器在当前系统中是否存在.本程序在启动编辑器时会自动判断该编辑器是否存在(路径是否错误),并给出提示.这样的逻辑十分便于您携带本程序到处用 :)

## 在 SublimeText 3 中使用本程序

将以下内容写入: `openWithEditor.sublime-build` 文件,然后将这个文件置于: `\path\to\sublimetext\Data\Packages\User` 目录下.然后在编辑任意 ***已保存的文档 *** 时,按下快捷键 `Ctrl Shift B` 选择 `openWithEditor` 或者 `Ctrl Shift P` 输入 `openWithEditor` 即可.
```
{
  "cmd": ["path/to/openWithEditor.exe", "/f=", "$file"]
}
```
谁知道如何传递 `lineNumber` 和 `columnNumber` 吗? 请在 wiki 中留言,谢谢!

## 已知问题

- SciTE 编辑器对双字节字符支持很不好,无法定位列号;同时,按照官方文档中给出的命令行参数: `SciTE.exe file_path -goto:lineNumber,columnNumber` 的实际效果是:打开文件后将自动选择 columnNumber 位置开始的下一个单词.
