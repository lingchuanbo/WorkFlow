###API 列表
* * *
###Class __vim
__vim 是vimd中的顶级对象。vimd 具有以下属性

属性|说明
----|----
pluginList|存放插件（plugin）对象，如 vim.pluginList["totalcmd"]返回 "totalcmd" 的插件对象， 具体的plugin 对象请看 class __plugin部分。
winList|存放窗口（win）对象，如 vim.winList["TC"]返回"TC"的窗口对象，具体的 win 对象请看 class __win 部分。
winInfo|存放当前窗口(win)对象相关的说明信息， *SetWin()* 函数会将数据保存这个属性中。通常不需要用到这个对象，只有 *CheckWin()* 需要用到这个属性
ActionList|存放动作（Action)对象，如 vim.ActionList["<Down>"]会返回"<down>"的动作对象，具对的Action对象请看 class __Action 部分。
ActionFromPlugin|声明某个动作（Action）是由哪个插件定义的。如 vim.ActionList["<Down>"] 返回 "Genernal"。
ExcludeWinList|存放所有排除的窗口（win）对象。其它与WinList类似。
winGlobal|全局窗口（win）对象，此对象管理全局下的模式与热键。优先级低于其它窗口对象。
LastFoundWin|保存vimd最后获取到的窗口对象名
ErrorCode|预留用于错误提示代码值，暂没有设置功能

####LoadPlugin(PluginName)
__功能__：加载插件，vimd保存相应的Plugin对象，然后转到(GoSub)PluginName对应的Label。

__参数__：PluginName -> 插件名称。

__返回值__：无返回内容，如果出错，会有Msgbox提示

####SetPlugin(PluginName,Author="",Ver="",Comment="")
__功能__：设置插件信息，声明作者、版本号、插件说明等。

__参数__：
* PluginName: 插件名称。
* Author: 插件作者名，默认为空。
* Ver: 版本号，默认为空。
* Comment: 插件说明，默认为空。

__返回值__：无返回内容。

####GetPlugin(PluginName)
__功能__：获取插件PluginName对应的插件对象。

__参数__：PluginName -> 插件名称

__返回值__：返回插件（plugin）对象。

####Comment(action,desc=“”,complex=True)
__功能__：新建并声明动作（Action）对象，兼容vimcore.ahk，与SetAction功能一致。

__参数__：
  * action：动作名称。
  * desc：动作的描述，默认为空。
  * complex：是否允许此动作多次运行，默认允许。
  
__返回值__：返回动作(action)对象。

####SetAction(Name,Comment=“”)
__功能__：新建并声明动作（Action）对象。

__参数__：
  * Name：动作名称。
  * Comment：动作的描述，默认为空。
  
__返回值__：返回动作(action)对象。

####GetAction(Name)
__功能__：获取名为Name的动作（Action）对象。

__参数__：Name -> 动作名称。

__返回值__：返回动作(action)对象。

####SetWin(winName,class,filepath=“”,title=“”)
__功能__：新建并声明窗口（win）对象。

__参数__：
  * winName：窗口对象名称。
  * class：程序的[ahk_class](http://ahkcn.github.io/docs/misc/WinTitle.htm#ahk_class)值。
  * filepath：程序的文件名（[ahk_exe](http://ahkcn.github.io/docs/misc/WinTitle.htm#ahk_exe)）。如“notepad.exe”
  * title：程序的标题。
  
__返回值__：返回新建的窗口（win）对象。

####GetWin(winName=“”)
__功能__：获取winName对应的窗口(win)对象。

__参数__：winName -> 窗口名称，默认为空值。

__返回值__：返回窗口（win）对象。如winName为空值时，返回全局的窗口（win）对象。

####CheckWin()
__功能__：检查当前窗口是否vimd已定义的窗口（win）对象。如果已经定义，返回窗口名称。

__参数__：空。

__返回值__：如有定义返回窗口名称，否则返回空值。

####Mode(mode,win="")
__功能__：设置win对应的模式(mode)。兼容vimcore.ahk，与SetMode功能一致。

__参数__：
  * mode：模式名称。
  * win：模式所属的窗口对象名。默认空值，设置全局窗口对象。
  
__返回值__：返回模式（mode）对象。

####SetMode(modeName,winName=“”)
__功能__：设置winName窗口对象下的模式(mode)。

__参数__：
  * modeName：模式名称。
  * winName：模式所属的窗口对象名。默认空值，设置全局窗口对象。
  
__返回值__：返回模式（mode）对象。

####SetModeFunction(func,modeName,winName=“”)
__功能__：设置模式切换是执行的函数。

__参数__：
  * func：函数名
  * modeName：切换模式名。
  * winName：窗口对象名。
  
__返回值__：无。


####GetMode(winName)
__功能__：获取winName窗口对象的当前模式。

__参数__：winName -> 模式所属的窗口对象名。默认空值，设置全局窗口对象。

__返回值__：返回模式（mode）对象。

####BeforeActionDo(Function,winName="")
__功能__：设置winName窗口对象的BeforeActionDo功能。BeforeActionDo会在热键按下后，Action执行之前判断。如果Function对应的函数返回True，则直接按热键本身输出，不进行其它判断。配合模式使用可以满足特殊情况下按普通按键输出的需求。

__参数__：
  * Function：自定义的函数名称。
  * winName：窗口对象名。默认为空，操作全局对象。
  
__返回值__：无。

####AfterActionDo(Function,winName="")
__功能__：设置winName窗口对象后AfterActionDo功能。AfterActionDo在Action执行之后开始进行判断。如Function对应的函数返回True，则直接按热键本身输出。适合执行Action后还需要执行其它功能判断的需求。

__参数__：
  * Function：自定义的函数名称。
  * winName：窗口对象名。默认为空，操作全局对象。
  
__返回值__：无。

####SetMaxCount(Int,winName="")
__功能__：设置winName窗口对象中Action可重复执行的最大次数。避免Action执行次数过多造成的错误。

__参数__：
  * Int：最大执行次数。
  * winName：窗口对象名。默认为空，操作全局对象。
  
__返回值__：无。

####GetMaxCount(winName="")
__功能__：获取winName窗口对象中Action可重复执行的最大次数。

__参数__：winName -> 窗口名称。默认为空，操作全局对象。

__返回值__：可最大运行次数。

####SetCount(int,winName="")
__功能__：设置winName窗口对象的次数，如"10j"，设置执行次数为10。

__参数__：
  * int：执行次数。
  * winName：窗口对象名。默认为空，操作全局对象。
  
__返回值__：无。

####GetCount(winName="")
__功能__：获取winName窗口对象的执行次数。（非最大值）

__参数__：winName -> 窗口名称。默认为空，操作全局对象。

__返回值__：返回当前的执行次数。 如"10j"，返回10

####SetTimeOut(Int,winName="")
__功能__：设置超时时间。

__参数__：
  * Int：超时时间，单位毫秒。
  * winName：窗口对象名。默认为空，操作全局对象。
  
__返回值__：无。

####GetTimeOut(winName="")
__功能__：获取超时时间。

__参数__：winName -> 窗口名称。默认为空，操作全局对象。

__返回值__：超时时间值。

####Map(keyName,Action,winName="")
__功能__：映射热键。映射的窗口由winName决定，模式由SetMode()/Mode()决定。

__参数__：
  * KeyName：[热键]()名称。
  * Action：动作名称。
  * winName：窗口对象名。默认为空，操作全局对象。
  
__返回值__：无。

####ExcludeWin(winName="",Bold=True)
__功能__：排除窗口，让vimd在窗口中无效化。

__参数__：
  * winName：窗口对象名。如果为空则操作全局对象。
  * Bold: 如为True排除，否则排除无效。
  
__返回值__：无。

####Toggle(winName="")
__功能__：启用/禁用winName窗口下的vimd效果。此函数与Control不同，此函数切换相反状态。

__参数__：winName -> 窗口名称。默认为空，操作全局对象。

__返回值__：无。

####Control(bold,winName="")
__功能__：启用/禁用winName窗口下的vimd效果。如 vim.Control(false,"TC")

__参数__：
  * Bold：True为启用，False为禁用。
  * winName：窗口名称。默认为空，操作全局对象。
  
__返回值__：无。

####Copy(winName1,winName2,class,filepath="",title="")
__功能__：复制winName的模式、热键定义给winName2，winName2按Class/filepath/title声明。

__参数__：
  * winName1：被复制的winName1窗口对象。
  * winName2：复制到winName2名称。
  * class：程序的ahk_class值。
  * filepath：程序的文件名。如“notepad.exe”
  * title：程序的标题。
  
__返回值__：winName2窗口对象。

####CopyMode(winName,fromMode,toMode)
__功能__：在winName模式中，将fromMode模式所有热键定义复制到toMode模式中。

__参数__：
  * winName：窗口对象名称。
  * fromMode：被复制的模式对象。
  * toMode：复制到ToMode对象。
  
__返回值__：toMode模式对象。

####Delete(winName="")
__功能__：删除winName窗口定义，并删除所有热键功能。

__参数__：winName -> 窗口对象名称。

__返回值__：无。

####GetMore()
__功能__：获取所有满足当前热键缓存（winObj.KeyTemp）的动作（Action）列表。

__返回值__：获取到的Action列表或空值。

####Clear(winName="")
__功能__：清空winName窗口对象中的热键缓存（winObj.KeyTemp）和执行次数（winObj.count）。

__参数__：winName -> 窗口对象名称。

__返回值__：无。

####Key()
__功能__：（内部函数）执行热键判断，包括所属的窗口、所属的模式，执行什么操作等。

__返回值__：无。

####IsTimeOut()
__功能__：（内部函数）判断热键缓存是否超时，如超时，则动作列表，执行当前热键缓存所对应的ActionList

__返回值__：无。

####Debug(Bold)
__功能__：启用/禁用vimd调试界面和相应的功能。

__参数__：Bold -> True或False，默认不启用。

__返回值__：无。

####Convert2VIM(key)
__功能__：把ahk热键名转换为vimd热键定义。

__参数__：Key -> [ahk热键名](http://ahkcn.github.io/docs/KeyList.htm)，如”ctrl & j“、“f1”

__返回值__：vimd热键定义。如 ”<c-j>“、“<f1>”

####Convert2AHK(key,ToSend=False)
__功能__：把vimd热键定义转换为ahk热键名

__参数__：
  Key：vimd热键定义，如 ”<c-j>“、“<f1>”
  ToSend：转换的AHK热键名类型。默认False，返回的[类型](http://ahkcn.github.io/docs/KeyList.htm)是”ctrl & j“、“f1”。如为True，返回的类型是^j、{f1}等适合[Send](http://ahkcn.github.io/docs/commands/Send.htm)的形式。
  
__返回值__：ahk热键名

####CheckCapsLock(key)
__功能__：检测CapsLock键是否按下，并返回对应的大小写值。

__参数__：key -> vimd热键定义，如 CheckCapsLock("<S-A>")

__返回值__：判断大小写后的vimd热键。

* * *
###Class __win
__win 窗口对象。在vimd中，每个程序都对应窗口对象。只有当前程序是在vimd中定义过的窗口对象，vimd才会执行模式及热键判断。

属性|说明
----|----
class|程序的[ahk_class](http://ahkcn.github.io/docs/misc/WinTitle.htm#ahk_class)，如ahk_class TTOTAL_CMD。
filepath|程序的文件名[ahk_exe](http://ahkcn.github.io/docs/misc/WinTitle.htm#ahk_exe)如"Notepad.exe"。
title|程序的窗口标题名。
KeyList|当前窗口对象所有可用的热键列表。如winObj.KeyList["j"] := True，主要用于vim.control()中。
SuperKeyList|当前窗口对象中的超级热键列表。如winObj.SuperKeyList["ctrl & k"] := True，此列表中的热键不受vim.control()/Toggle()的影响。但受vim.Delete()的控制。
modeList|模式列表，存放所有可用的模式，如winObj.modeList["normal"]。
Status|保存窗口热键可用的状态。True时说明热键是可用的。False时说明热键不可用。
mode|当前窗口保存的模式名。
LastKey|当前窗口对象按下的最后一个热键。
KeyTemp|保存当前窗口的热键缓存列表。
MaxCount|当前窗口对象允许的动作最大执行次数。
Count|当前窗口对象执行的次数，如"10j"
TimeOut|当前窗口对象的超时时间
Info|窗口对象是否出现提示热键信息，默认为True
BeforeActionDoFunc|保存窗口对象在执行动作前的函数名
AfterActionDoFunc|保存窗口对象在执行动作后的函数名
ShowInfoFunc|（内部函数）显示提示热键信息的函数。默认为showInfo()
HideInfoFunc|（内部函数）隐藏提示热键信息的函数。默认为hideInfo()

####ChangeMode(modeName)
__功能__：改变当前窗口对象的模式，此函数为内部函数。如需要切换模式，请用回vim.SetMode()

__参数__：ModeName -> 模式名称。

__返回值__：返回切换的模式对象。

####ExistMode()
__功能__：返回当前窗口的模式对象。与ChangeMode不同的是，此函数不切换模式。

__返回值__：返回当前模式对象。

####SetInfo(Bold)
__功能__：设置是否显示提示热键信息，为True时，会根据情况执行win.ShowInfoFunct和win.HideInfoFunc两个函数。

__参数__：Bold -> 正确/错误。

__返回值__：无。

####SetShowInfo(func)
__功能__：（内部函数）设置显示提示热键信息的函数名。

__参数__：func -> 函数名称。

__返回值__：无

####SetHideInfo(func)
__功能__：（内部函数）设置隐藏提示热键信息的函数名。

__参数__：func -> 函数名称。

__返回值__：无

####ShowMore()
__功能__：（内部函数）显示提示热键信息。

__返回值__：无。

####HideMore()
__功能__：（内部函数）隐藏提示热键信息。

__返回值__：无。

* * *
###Class __Mode
每个窗口对象中有多个模式，模式对象主要用于判断热键执行什么动作。

属性|说明
----|----
name|模式名称。
keymapList|映射热键列表。
keymoreList|存放更多组合键的热键列表。
nowaitList|无视等待超时的热键列表。
modeFucntion|切换模式执行的函数名。

####SetKeyMap(key,action)
__功能__：（内部函数）保存到映射热键列表。

####GetKeyMap(key)
__功能__：（内部函数）获取热键对应的动作对象。

####DelKeyMap(key)
__功能__：（内部函数）删除热键映射。

####SetNoWait(key,bold)
__功能__：（内部函数）设置热键无视超时时间。

####GetNoWait(key)
__功能__：（内部函数）获取热键是否为超时时间。

####SetMoreKey(key)
__功能__：（内部函数）设置热键还有更多组合键如，"g\gg\，那么"g"存在更多的组合键。"

####GetMoreKey(key)
__功能__：（内部函数）获取热键是否有更多组合键。

* * *
###Class __Action
动作对象支持ahk的标签（Label）、函数（function）、命令行（cmdLine）、热字串（HotString）。

属性|说明
----|----
Name|动作名称。
Comment|动作的说明。
MaxTimes|动作允许执行的最大次数。
function|执行的函数名。
cmdLine|执行的命令行。
HotString|发送的字符串。
Type|动作类型。0是执行与动作名称一致的Label，1是执行Function函数，2是执行CmdLine命令行，3是发送字符串HotString

####SetFunction(Function)
__功能__：设置动作执行的函数。

__参数__：Function -> 函数名。

__返回值__：无。

####SetCmdLine(CmdLine)
__功能__：设置动作为执行命令行。

__参数__：CmdLine -> 执行命令行。

__返回值__：无。

####SetHotString(HotString)
__功能__：设置动作为发送文本。

__参数__：HotString -> 字符串。

__返回值__：无。

####SetMaxTimes(Times)
__功能__：设置执行动作的最大次数。

__参数__：Times -> 最大次数。

__返回值__：无。

####Do(Times=1)
__功能__：执行动作。

__参数__：Times -> 执行的次数。

__返回值__：无返回值。

* * *
###Class __Plugin
插件对象，用于保存插件的相关信息。

####CheckSub()
__功能__：检测并执行Label，加载插件。

__返回值__：正确加载插件，返回True。

* * *
###Class __vimDebug
用于调试，使用vim.Debug(True)可以启用/Vim.Debug(False)禁用调试窗口。

####Add(v)
__功能__：添加内容到调试窗口中。

####Clear()
__功能__：清除调试窗口显示的内容。


