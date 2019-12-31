include_class_datetime()

TTCommander_Include()
{
	return 1
}

class TTCommander
{
	;~ ----------------------------------------------------
	;~ [Section Start] ������
	;~ --------------------------
	;~ Tc�����ʶ���ʾ��
	static identifiableTitle := "ahk_class TTOTAL_CMD"
	;~ Ĭ�ϵ��ı��༭������·������,֧�� COMMANDER_PATH ����
	, editorDefault := "`%COMMANDER_PATH`%\Tools\EmEditorPortable\EmEditor.exe"

	;~ ----------------------------------------------------
	;~ [Section Start] ��̬����
	;~ --------------------------
	;~ Tc����������·��
	_tcPathExe := ""
	;~ Tc����Ŀ¼��·����Ϣ����
	, _tcPathInfo := {}
	;~ Tc���������ļ�·��
	, _tcPathWinCmdIni := ""
	;~ Tc�� UserCmd.ini �ļ�·��
	, _tcPathUserCmdIni := ""
	;~ Tc��Ftp�����ļ�
	, _tcPathFtpIni := ""
	;~ �����ļ�·��
	, _tcPathMainMenu := ""
	;~ �����ļ��󶨵��û������ļ�·��
	, _tcPathMainMenuIni := ""
	;~ �������ļ��ж���������ļ�����
	, _Setting_mainMenu := ""

	;~ ʵ����ʼ��,֧���Զ��� Wincmd.ini �� wcx_ftp.ini
	__New()
	{
		if !(this._tcPathExe := this._GetTcPath())
		{
			Trace("�뽫�ű����� %COMMANDER_PATH% " """" "\Tools\{A_ScriptDir}" """", 1)
		}

		try
		{
			this._tcPathInfo := fsys_GetPathObj(this._tcPathExe)
			this._FillTcSettings()
		}
		catch , _err
		{
			_err := new OC_Error("ʧ��"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
		return this
	}

	;~ �����û����ݵ� Tc��������,Wincmd.ini�����ļ�,ftp.ini�����ļ�·��
	;~ ��䱾��ʵ���Ķ�Ӧ����
	;~ ���û�д��������ļ�·��,�����Tc���������Զ�����Ĭ��·��
	_FillTcSettings()
	{
		;~ ����ͨ��New����ʵ��,ָ��tc·������
		if isNull(this._tcPathInfo)
		{
			Trace("�ļ�: " StrReplace(A_LineFile, A_ScriptDir) " [" A_LineNumber "]`n" "����: " A_ThisFunc "`n"
				. "TC·����Ϣ���� _tcPathInfo Ϊ��"
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
			_err := new OC_Error("ʧ��"
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
				_err := new OC_Error("ʧ��"
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
				_err := new OC_Error("ʧ��"
					, "�޷���ȡ���˵���������"
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
			_err := new OC_Error("ʧ�� �û������ļ� usercmd.ini ������"
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
			_err := new OC_Error("ʧ�� ȫ�������ļ� wincmd.ini ������"
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
			_err := new OC_Error("ʧ�� ȫ�������ļ� wcx_ftp.ini ������"
				, this._tcPathUserCmdIni
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	;~ ��ȡ Tc WinCmd.ini ������
	_ReadWinSetting(aSection, aKey := "")
	{
		if ! fsys_isByteFile(this._tcPathWinCmdIni)
		{
			Trace("�ļ�: " StrReplace(A_LineFile, A_ScriptDir) " [" A_LineNumber "]`n" "����: " A_ThisFunc "`n"
				. "_tcPathWinCmdIni ������: " this._tcPathWinCmdIni
				, 1, "")
		}

		tmpVal := fc_IniRead(this._tcPathWinCmdIni, aSection, aKey)

		if !(tmpVal)
		|| (tmpVal = "ERROR")
		{
			_err := new OC_Error("ʧ��"
				, "�޷���ȡ������: " aSection "." aKey
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
		return tmpVal
	}

	;~ д�� Tc WinCmd.ini ����
	_WriteWinSetting(aVal, aSection, aKey)
	{
		if isNull(this._tcPathInfo)
		{
			_err := new OC_Error("����ֱ�ӵ���ʵ������"
				, A_ThisFunc
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		return fc_IniWrite(aVal, this._tcPathWinCmdIni, aSection, aKey)
	}

	;~ ͨ������TC����msg������TC
	_SendTcMsg(aMsgNumb)
	{
		;~ SendMessage ���ȴ�Ŀ�귵����Ӧ
		;~ ����ʱ, ErrorLevel ���ص��� FAIL
		;~ �ɹ�ʱ, ErrorLevel Ϊ����0���ڵ�����
		SendMessage 1075, %aMsgNumb%,,, ahk_class TTOTAL_CMD
		if (ErrorLevel != "FAIL")
		{
			return 1
		}
	}

	;~ ��ȡ winIni ������·���б�
	;~ ���صĽṹΪ:
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
				, "tab��ϢΪ��"
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		_pathList := []
		;~ matchObj.Value(3) ����·��, 1 Ϊ���
		, _rx := "^(\d*)(\_path\=)(.*)$"

		loop, Parse, % aTabText, `n, `r
		{
			if (_matchObj := RegEx_MatchObjectOfStrLine(A_LoopField, _rx))
				_pathList.Push( _matchObj.Value(3) )
		}
		return _pathList
	}

	;~ ���浱ǰ�� DirMenu ����Ϊ %COMMANDER_PATH%\DirMenu\����ʱ��.json
	;~ ��ͨ�� RestoreDirMenuFromFile() �ָ�
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

	;~ ��ȡ ^d �˵���������Ŀ
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

	;~ ���� DirMenu key�ı�,��Ŀ¼��νṹ���ض���
	;~ key Ϊ menuN (NΪ�˵����) ʱ, �����һ���ַ��� "-" ����, ���ʾ�ò˵�ΪĿ¼���Ĳ˵�Ϊ���Ӳ˵�,
	;~ �����Ӳ˵�����Ŀ�����Ȼ����. ����,�ò˵�Ϊ����.
	;~ ��� key Ϊ "--" ��������, ��ʾ��ǰ��Ŀ¼����.
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

	;~ �����ı��д��ڴ���,�����ı������ر��,�����������ظ�Ҳ������ν
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

	;~ ��ȡ��ǰTCʵ����ѡ����ļ�/Ŀ¼�б�(0������)
	;~ ����:
	;~ һ������,ÿһ�����һ��ѡ����ļ�/Ŀ¼������·��
	GetSelectFileArr()
	{
		if isNull(this._tcPathInfo)
		{
			_err := new OC_Error("����ֱ�ӵ���ʵ������"
				, A_ThisFunc
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		;~ ���ݼ�����
		_clipBak := ClipboardAll
		,Clipboard := ""
		,_reArr := ""

		;~ ���Ƶ�ǰѡ����ļ�/�ļ��е�����·���������� 2018
		this._SendTcMsg(2018)

		_re := Clipboard
		, Clipboard := _clipBak
		, _clipBak := ""
		_reArr := StrSplit(_re, "`r`n")
		return _reArr
	}

	;~ ��ȡ��ǰTCʵ����Tab·��(source/target)
	;~ ������ԴTab·�� 2029
	;~ ����Ŀ��Tab·�� 2030
	;~ aIsSource �Ƿ�Ϊ��Դ·��
	;~ true  (source): (Ĭ��) ��ԴTab·��
	;~ false (target): Ŀ��Tab·��
	;~ ����:
	;~ �ı� �� ʧ��ʱ���ؿ�ֵ
	GetTabPath(aIsSource := true)
	{
		if isNull(this._tcPathInfo)
		{
			_err := new OC_Error("ʧ��"
				, "ʵ������"
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		;~ Ĭ�ϻ�ȡ��Դ·��
		_curMsg := 2029
		,_clipBak := ClipboardAll
		,Clipboard := ""
		,_re := ""

		;~ ��ȡĿ��·��
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

	;~ ��ȡ��ǰF4Ĭ�ϱ༭��������
	GetPath_CurEditor()
	{
		return this._ReadWinSetting("Configuration", "Editor")
	}

	;~ �޸�/�޸� Tc��F4Ĭ�ϱ༭��
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
			_err := new OC_Error("ʧ��"
				, "Ĭ�ϱ༭�����Դ���,: "
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
			_err := new OC_Error("ʧ��"
				, _err
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}
	}

	;~ ���·����ʷ��¼
	ClearHistory()
	{
		this._WriteWinSetting("", "LeftHistory", "")
		this._WriteWinSetting("", "RightHistory", "")
	}

	;~ ��ȡ�����Զ������������
	GetEmCmdLists()
	{
		if isNull(this._tcPathInfo)
		{
			_err := new OC_Error("����ֱ�ӵ���ʵ������"
				, A_ThisFunc
				, A_ThisFunc ? A_ThisFunc : A_ThisLabel
				, A_LineFile, A_LineNumber)
			_err.Arise()
			return
		}

		;~ em_ �Զ���������ܴ����������ļ���
		cmdIniArr := [this._tcPathUserCmdIni, this._tcPathMainMenuIni]
		, cmdArr := []

		for ii, iniFile in cmdIniArr
		{
			if !(fsys_isByteFile(iniFile))
			{
				_err := new OC_Error("�Ҳ��������ļ�"
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

	;~ ��ȡtc������·��
	_GetTcPath()
	{
		_tcWinTitle := TTCommander.identifiableTitle
		if ! (_tcProcessPath := fc_WinGet("ProcessPath", _tcWinTitle))
		{
			Trace("�ļ�: " StrReplace(A_LineFile, A_ScriptDir) " [" A_LineNumber "]`n" "����: " A_ThisFunc "`n"
				. "TotalCmd δ����"
				, 1, "")
		}

		return _tcProcessPath
	}
}