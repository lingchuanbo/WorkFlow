include_class_datetime()

TTCommander_Include()
{
	return 1
}

class TTCommander
{
	;~ ----------------------------------------------------
	;~ [Section Start] 类属性
	;~ --------------------------
	;~ Tc窗体的识别标示符
	static identifiableTitle := "ahk_class TTOTAL_CMD"
	;~ 默认的文本编辑器完整路径配置,支持 COMMANDER_PATH 变量
	, editorDefault := "`%COMMANDER_PATH`%\Tools\EmEditorPortable\EmEditor.exe"

	;~ ----------------------------------------------------
	;~ [Section Start] 动态属性
	;~ --------------------------
	;~ Tc的启动程序路径
	_tcPathExe := ""
	;~ Tc程序目录的路径信息对象
	, _tcPathInfo := {}
	;~ Tc的主配置文件路径
	, _tcPathWinCmdIni := ""
	;~ Tc的 UserCmd.ini 文件路径
	, _tcPathUserCmdIni := ""
	;~ Tc的Ftp配置文件
	, _tcPathFtpIni := ""
	;~ 语言文件路径
	, _tcPathMainMenu := ""
	;~ 语言文件绑定的用户命令文件路径
	, _tcPathMainMenuIni := ""
	;~ 主配置文件中定义的语言文件名称
	, _Setting_mainMenu := ""

	;~ 实例初始化,支持自定义 Wincmd.ini 和 wcx_ftp.ini
	__New()
	{
		if !(this._tcPathExe := this._GetTcPath())
		{
			Trace("请将脚本置于 %COMMANDER_PATH% " """" "\Tools\{A_ScriptDir}" """", 1)
		}

		try
		{
			this._tcPathInfo := fsys_GetPathObj(this._tcPathExe)
			this._FillTcSettings()
		}
		catch , _err
		{
			_err := new OC_Error("失败"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
		return this
	}

	;~ 根据用户传递的 Tc启动程序,Wincmd.ini配置文件,ftp.ini配置文件路径
	;~ 填充本类实例的对应属性
	;~ 如果没有传递配置文件路径,则根据Tc启动程序自动配置默认路径
	_FillTcSettings()
	{
		;~ 必须通过New创建实例,指定tc路径属性
		if isNull(this._tcPathInfo)
		{
			Trace("文件: " StrReplace(A_LineFile, A_ScriptDir) " [" A_LineNumber "]`n" "函数: " A_ThisFunc "`n"
				. "TC路径信息对象 _tcPathInfo 为空"
				, 1, "")
		}

		try
		{
			this._GetWinIniFilePath()
			this._GetUserIniFilePath()
			this._GetFtpIniFilePath()
			this._GetMainMenuSetting()
		}
		catch , _err
		{
			_err := new OC_Error("失败"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	_GetMainMenuSetting()
	{
			try
			{
				this._Setting_mainMenu := this._ReadWinSetting("Configuration", "Mainmenu")
				this._tcPathMainMenu := fsys_JoinPath(this._tcPathInfo.fileDirPath, "LANGUAGE", this._Setting_mainMenu)
				this._tcPathMainMenuIni := RegExReplace(this._tcPathMainMenu, "i)\.mnu$", ".ini")
			}
			catch , _err
			{
				_err := new OC_Error("失败"
					, _err
					, A_ThisFunc ? A_ThisFunc : A_ThisLabel
					, A_LineFile, A_LineNumber)
				_err.Arise()
				return
			}

			if isNull(this._Setting_mainMenu)
			|| ! (fsys_isByteFile(this._tcPathMainMenu))
			|| ! (fsys_isByteFile(this._tcPathMainMenuIni))
			{
				_err := new OC_Error("失败"
					, "无法读取主菜单配置内容"
					, A_ThisFunc ? A_ThisFunc : A_ThisLabel
					, A_LineFile, A_LineNumber)
				_err.Arise()
				return
			}
	}

	_GetUserIniFilePath()
	{
		if ! (fsys_isByteFile(this._tcPathUserCmdIni := fsys_JoinPath(this._tcPathInfo.fileDirPath, "usercmd.ini")))
		{
			_err := new OC_Error("失败 用户配置文件 usercmd.ini 不存在"
				, this._tcPathUserCmdIni
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	_GetWinIniFilePath()
	{
		if ! (fsys_isByteFile(this._tcPathWinCmdIni := fsys_JoinPath(this._tcPathInfo.fileDirPath, "wincmd.ini")))
		{
			_err := new OC_Error("失败 全局配置文件 wincmd.ini 不存在"
				, this._tcPathWinCmdIni
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	_GetFtpIniFilePath()
	{
		if ! (fsys_isByteFile(this._tcPathUserCmdIni := fsys_JoinPath(this._tcPathInfo.fileDirPath, "wcx_ftp.ini")))
		{
			_err := new OC_Error("失败 全局配置文件 wcx_ftp.ini 不存在"
				, this._tcPathUserCmdIni
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	;~ 读取 Tc WinCmd.ini 的设置
	_ReadWinSetting(aSection, aKey := "")
	{
		if ! fsys_isByteFile(this._tcPathWinCmdIni)
		{
			Trace("文件: " StrReplace(A_LineFile, A_ScriptDir) " [" A_LineNumber "]`n" "函数: " A_ThisFunc "`n"
				. "_tcPathWinCmdIni 不存在: " this._tcPathWinCmdIni
				, 1, "")
		}

		tmpVal := fc_IniRead(this._tcPathWinCmdIni, aSection, aKey)

		if !(tmpVal)
		|| (tmpVal = "ERROR")
		{
			_err := new OC_Error("失败"
				, "无法读取该配置: " aSection "." aKey
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
		return tmpVal
	}

	;~ 写入 Tc WinCmd.ini 配置
	_WriteWinSetting(aVal, aSection, aKey)
	{
		if isNull(this._tcPathInfo)
		{
			_err := new OC_Error("不可直接调用实例方法"
				, A_ThisFunc
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		return fc_IniWrite(aVal, this._tcPathWinCmdIni, aSection, aKey)
	}

	;~ 通过发送TC内置msg来操作TC
	_SendTcMsg(aMsgNumb)
	{
		;~ SendMessage 将等待目标返回响应
		;~ 出错时, ErrorLevel 返回单词 FAIL
		;~ 成功时, ErrorLevel 为包含0在内的整数
		SendMessage 1075, %aMsgNumb%,,, ahk_class TTOTAL_CMD
		if (ErrorLevel != "FAIL")
		{
			return 1
		}
	}

	;~ 获取 winIni 中左右路径列表
	;~ 返回的结构为:
	;~ {lefttabs : [ "c:\windows", "d:\dev" ], righttabs : [ "c:\windows", "d:\dev" ]}
	GetCurTabPathList()
	{
		_tabPathList := {}

		try
		{
			_tabPathList.lefttabs := this._tabPathToList(this._ReadWinSetting("lefttabs"))
			_tabPathList.righttabs := this._tabPathToList(this._ReadWinSetting("righttabs"))
		}
		catch , _err
		{
			_err := new OC_Error("ERROR"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
		return _tabPathList
	}

	_tabPathToList(aTabText)
	{
		if isNull(aTabText)
		{
			_err := new OC_Error("ERROR"
				, "tab信息为空"
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		_pathList := []
		;~ matchObj.Value(3) 就是路径, 1 为序号
		, _rx := "^(\d*)(\_path\=)(.*)$"

		loop, Parse, % aTabText, `n, `r
		{
			if (_matchObj := RegEx_MatchObjectOfStrLine(A_LoopField, _rx))
				_pathList.Push( _matchObj.Value(3) )
		}
		return _pathList
	}

	;~ 保存当前的 DirMenu 内容为 %COMMANDER_PATH%\DirMenu\日期时间.json
	;~ 可通过 RestoreDirMenuFromFile() 恢复
	BackupDirMenuToFile(aFileName := "")
	{
		if ! (aFileName)
		{
			aFileName := class_datetime.unixToHuman(class_datetime.humanToUnix(A_Now))
		}

		try
		{
			_dmObj := this.GetDirMenuItemList()
			_filePath := fsys_JoinPath(this._tcPathInfo.fileDirPath, "DirMenu", aFileName ".json")
			Json_ObjToFile(_dmObj, _filePath)
		}
		catch , _err
		{
			_err := new OC_Error("ERROR"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	;~ 获取 ^d 菜单的所有项目
	GetDirMenuItemList()
	{
		try
		{
			_sectionStr := this._ReadWinSetting("DirMenu")
			return this._parseDirMenuStr(_sectionStr)
		}
		catch , _err
		{
			_err := new OC_Error("ERROR"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	;~ 解析 DirMenu key文本,按目录层次结构返回对象
	;~ key 为 menuN (N为菜单序号) 时, 如果第一个字符是 "-" 减号, 则表示该菜单为目录其后的菜单为其子菜单,
	;~ 但是子菜单的项目序号仍然递增. 否则,该菜单为命令.
	;~ 如果 key 为 "--" 两个减号, 表示当前层目录结束.
	_parseDirMenuStr(ByRef aStr)
	{
		_itemList := []

		try
		{
			loop
			{
				if isNull(_item := this._dirMenu_getItemIndexOf(A_Index, aStr))
				{
					break
				}

				_itemList.Push(_item)
			}
		}
		catch , _err
		{
			_err := new OC_Error("ERROR"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		return _itemList
	}

	;~ 假设文本行存在错乱,由于文本不会特别大,所以这样的重复也许无所谓
	_dirMenu_getItemIndexOf(aIndex, ByRef aStr)
	{
		_foundItem := {}
		_regEx := "^(menu|cmd|path)(\d*)(\=)(.*)$"

		loop, Parse, % aStr, `n, `r
		{
			_line := A_LoopField
			_lineInfo := RegEx_MatchObjectOfStrLine(_line, _regEx)

			_curType := _lineInfo.Value(1)
			_curIndex := _lineInfo.Value(2)
			_curVal := _lineInfo.Value(4)

			if (_curIndex = aIndex)
			{
				if (_curType = "menu")
				{
					_foundItem.index := _curIndex
					_foundItem.title := _curVal
				}
				else if (_curType = "cmd")
				{
					_foundItem.cmd := _curVal
				}
				else if (_curType = "path")
				{
					_foundItem.path := _curVal
				}
			}
		}
		return _foundItem
	}

	;~ 获取当前TC实例中选择的文件/目录列表(0个或多个)
	;~ 返回:
	;~ 一个数组,每一项包含一个选择的文件/目录的完整路径
	GetSelectFileArr()
	{
		if isNull(this._tcPathInfo)
		{
			_err := new OC_Error("不可直接调用实例方法"
				, A_ThisFunc
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		;~ 备份剪贴板
		_clipBak := ClipboardAll
		,Clipboard := ""
		,_reArr := ""

		;~ 复制当前选择的文件/文件夹的完整路径到剪贴板 2018
		this._SendTcMsg(2018)

		_re := Clipboard
		, Clipboard := _clipBak
		, _clipBak := ""
		_reArr := StrSplit(_re, "`r`n")
		return _reArr
	}

	;~ 获取当前TC实例的Tab路径(source/target)
	;~ 复制来源Tab路径 2029
	;~ 复制目标Tab路径 2030
	;~ aIsSource 是否为来源路径
	;~ true  (source): (默认) 来源Tab路径
	;~ false (target): 目标Tab路径
	;~ 返回:
	;~ 文本 或 失败时返回空值
	GetTabPath(aIsSource := true)
	{
		if isNull(this._tcPathInfo)
		{
			_err := new OC_Error("失败"
				, "实例方法"
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		;~ 默认获取来源路径
		_curMsg := 2029
		,_clipBak := ClipboardAll
		,Clipboard := ""
		,_re := ""

		;~ 获取目标路径
		if (!aIsSource)
		{
			_curMsg := 2030
		}

		this._SendTcMsg(_curMsg)

		_re	:= Clipboard
		Clipboard := _clipBak
		_clipBak := ""
		return _re
	}

	;~ 获取当前F4默认编辑器的设置
	GetPath_CurEditor()
	{
		return this._ReadWinSetting("Configuration", "Editor")
	}

	;~ 修复/修改 Tc的F4默认编辑器
	FixEditor()
	{
		_editorPath := this.editorDefault

		if (InStr(_editorPath, "COMMANDER_PATH"))
		{
			_editorPath := StrReplace(_editorPath, "`%COMMANDER_PATH`%`\")
			_editorPath := fsys_JoinPath(this._tcPathInfo.fileDirPath, _editorPath)
		}

		if ! (fsys_isByteFile(_editorPath))
		{
			_err := new OC_Error("失败"
				, "默认编辑器属性错误,: "
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		try
		{
			this._WriteWinSetting(this.editorDefault, "Configuration", "Editor")
		}
		catch , _err
		{
			_err := new OC_Error("失败"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	;~ 清除路径历史记录
	ClearHistory()
	{
		this._WriteWinSetting("", "LeftHistory", "")
		this._WriteWinSetting("", "RightHistory", "")
	}

	;~ 获取所有自定义命令的数组
	GetEmCmdLists()
	{
		if isNull(this._tcPathInfo)
		{
			_err := new OC_Error("不可直接调用实例方法"
				, A_ThisFunc
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		;~ em_ 自定义命令可能存在于两个文件中
		cmdIniArr := [this._tcPathUserCmdIni, this._tcPathMainMenuIni]
		, cmdArr := []

		for ii, iniFile in cmdIniArr
		{
			if !(fsys_isByteFile(iniFile))
			{
				_err := new OC_Error("找不到配置文件"
					, iniFile
					, A_ThisFunc ? A_ThisFunc : A_ThisLabel
					, A_LineFile, A_LineNumber)
				_err.Arise()
				return
			}

			tmpIniObj := iniFile_toObj(iniFile)

			for sec, key in tmpIniObj
			{
				cmdArr.insert(sec)
			}
		}
		return cmdArr
	}

	;~ 获取tc的完整路径
	_GetTcPath()
	{
		_tcWinTitle := TTCommander.identifiableTitle
		if ! (_tcProcessPath := fc_WinGet("ProcessPath", _tcWinTitle))
		{
			Trace("文件: " StrReplace(A_LineFile, A_ScriptDir) " [" A_LineNumber "]`n" "函数: " A_ThisFunc "`n"
				. "TotalCmd 未运行"
				, 1, "")
		}

		return _tcProcessPath
	}
}