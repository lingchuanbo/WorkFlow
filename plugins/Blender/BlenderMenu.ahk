; ##########程序便捷.专业软件##########补充测试,具体看各自的插件
	; Blender
		#If WinActive("ahk_exe blender.exe")
		{
			; BlenderCursorRepeat := 10
			; ; Clear screen in console
			; ^k::Send {Blind}{LCtrl Down}{LControl Up}

			; ; Delete one char to the right of cursor
			; ^d::Send {Delete},

			; ; Clear line in console
			; ^c::Send +{Enter}

			; ; Delete word
			; ^w::Send {LCtrl Down}{Backspace}{LCtrl Up}

			; ^a::
			; 	; Move cursor to beginning
			; 	Loop %BlenderCursorRepeat% {
			; 		Send {LCtrl Down}{Left}{LCtrl Up}
			; 	}
			; Return
			; ^e::
			; 	; Move cursor to end
			; 	Loop %BlenderCursorRepeat% {
			; 		Send {LCtrl Down}{Right}{LCtrl Up}
			; 	}
			; Return

			$Space::
				start := A_TickCount            ; measure current time.
				KeyWait, Space                  ; wait for Space to be released.
				duration := A_TickCount - start ; calculate if Space was held for less than ### ms.
				if (duration < 180){            ; if so
					SendEvent, {Space}            ; send Space else send nothing.
				}
				return
			$LButton::
				if GetKeyState("Space", "p"){ ; If Spacebar is being held down while Mouse button is pressed.
					Send {MButton Down}
					KeyWait, LButton
					Send {MButton Up}
				return
				} else {
					Click, down ; Click is necessary over Send as the button sometimes stops responding for unknown reasons.
					KeyWait, LButton
					Click, up
					return
				}
				return
			$RButton::
				if GetKeyState("Space", "p"){
					SendEvent, ^{MButton Down}
					KeyWait, RButton
					SendEvent, ^{MButton Up}
					Return
				} else {
					Click, down, Right
					KeyWait, RButton
					Click, up, Right
					return
				}
				return
			$MButton::
				if GetKeyState("Space", "p"){
					SendEvent +{Mbutton down} ; Use SendEvent "+" so not to trigger the shift+space command in Blender.
					Return
				} else {
					Click, down, Right
					KeyWait, MButton
					Click, up, Right
					Return
				}
				Return 
			MButton up::
				SendEvent {Mbutton up}
			Return 
		}
		#If