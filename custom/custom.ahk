;自动快捷输入高频常用词
;=========================================================
:*:ffmpeg::
clipboard = ffmpeg -i input.mkv output.mp4
send,^v
return

:*:iffmp::
clipboard = ffmpeg -i input.flv output.mp4
send,^v
return

:*:iiffmp::
clipboard = ffmpeg -i input.mp4 -c:v libx264 -crf 24 -preset slower output.mp4
send,^v
return

:*:sffmp::
clipboard = ffmpeg -i input.mp4 -c:v libx264 -crf 24 -s 1280:720 -preset slower output.mp4
send,^v
return

:*:affmp::
clipboard = ffmpeg -i input.mp4 -vn -acodec copy output.aac
send,^v
return

:*:iaffmp::
clipboard = ffmpeg -i input.m4a -vn -acodec copy output.aac
send,^v
return

; :*:ggg::
; ;clipboard = Dan Ebberts ;可任意更改剪切板内容
; clipboard = 1236547890 ;NVIDIA密码
; send,^v
; return

:*:ddv:: ;c语言编程通用代码段
clipboard=#include <stdio.h>`n`nint main()`n{`n	return 0;`n}
send,^v
send,{up}{enter}{up}
send,`t
send,{F4} ;切换到英文
return

; :*:ddd:: ;小海不离键盘秘技之剪切当前行
; send,{home}{shiftdown}{end}{shiftup}
; send,^x
; clipboard = %clipboard%   ; 把任何复制的文件, HTML 或其他格式的文本转换为纯文本
; return

; :*:eee::^v ;小海不离键盘秘技

; :*:deee::
; clipboard = `;
; send,^v
; return

:*:iid::  ; 此热字串通过后面命令将热字串替换成当前日期和时间.
FormatTime, CurrentDateTime,, MM月dd ; 形式：小海01月17短片
;FormatTime, CurrentDateTime,, MM月dd-HH点-mm-ss ; 形式：小海08月16-11点-43-51短片
SendInput "小海%CurrentDateTime%短片"
return
;=========================================================
:*:ahk:: ;自动输入AutoHotkey
clipboard = AutoHotkey
send,^v
return

:*:nia:: 
clipboard = Niagara
send,^v
return

:*:unreal:: 
clipboard = Unreal Engine
send,^v
return

:*:uni:: 
clipboard = Unity
send,^v
return

; :*:loo::
; clipboard = LookAE
; send,^v
; return

:*:bili::
clipboard = bilibili
send,^v
return

:*:ggg::
clipboard = google.com
send,^v
return

:*:davi::
clipboard = DaVinci
send,^v
return

:*:disk::
clipboard = DiskGenius
send,^v
return

:*:yout::
clipboard = YouTube
send,^v
return

:*:prev::
clipboard = Previews
send,^v
return

:*:nvd::
clipboard = NVDIA
send,^v
return

:*:prem::
clipboard = Premiere
send,^v
return

:*:midia::
clipboard = Media Encoder
send,^v
return

:*:ctr::
clipboard = Ctrl+
send,^v
sleep,50
send,{f4} ;切换到英文
return

:*:shif::
clipboard = Shift+
send,^v
return

:*:exp::
clipboard = exposure
send,^v
sleep,50
send,{f4} ;切换到英文
return

:*:lut::
clipboard = correction luts
send,^v
sleep,50
send,{f4} ;切换到英文
return

:*:cont::
clipboard = contrast
send,^v
sleep,50
send,{f4} ;切换到英文
return

:*:win::
clipboard = Windows
send,^v
return

:*:skin::
clipboard = color of skin
send,^v
sleep,50
send,{f4} ;切换到英文
return

:*:vig::
clipboard = vignette
send,^v
sleep,50
send,{f4} ;切换到英文
return

:*:cre::
clipboard = creativity
send,^v
sleep,50
send,{f4} ;切换到英文
return

:*:mavic::
clipboard = 大疆 Mavic Mini
send,^v
sleep,50
send,{f3} ;切换到中文
return

:*:bandi::
clipboard = Bandicam
send,^v
sleep,50
return

:*:gmail::
clipboard = lingchuanbo@gmail.com
send,^v
sleep,50
return

:*:wk::
clipboard = WorkFlow
send,^v
sleep,50
return

; :*:gf::
; 	SetCapsLockState,off
; 	switchimeIM(0)
; 	switchimeIM()
; return

; :*:gg::
; 	SetCapsLockState,off
; 	switchimeIM(0)
; return

; switchimeIM(ime := "A")
; {
;     if (ime = 1){
;         DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"00000804", UInt, 1))
;     }else if (ime = 0)
;     {
;         DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
;     }else if (ime = "A")
;     {
;         ;ime_status:=DllCall("GetKeyboardLayout","int",0,UInt)
;         Send, #{Space}
;     }
; }