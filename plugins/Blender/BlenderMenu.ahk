


#IfWinActive, ahk_exe Substance Painter.exe
!q::Send,{Blind}{RButton}{Down}{Down}{Enter} ; 黒マスク追加
!w::Send,{Blind}{RButton}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Enter} ; ペイント追加
!e::Send,{Blind}{RButton}{Up}{Up}{Up}{Up}{Up}{Up}{Enter} ; 涂りつぶし
!r::Send,{Blind}{RButton}{Down}{Down}{Down}{Down}{Enter} ; IDマスク追加
; メッシュを一发で更新する
; マウスとメニュー选択をゴリ押しで行う。既に1度更新している场合にうまくいく
+^!r:: ;ctrl + shift + alt + R
    MouseGetPos, x0, y0
    WinGetPos, X, Y, Width, Height
    MouseMove, Width - Width+90, 40
    MouseClick, left
    MouseMove, x0, y0
  Send,{Blind}{Down}{Down}{Down}{Enter}
  Sleep 1
  Send,{Blind}{Tab}{Tab}{Tab}{Tab}{Enter}
  Send,{Enter}{Blind}{Tab}{Enter}
; 书き出しウィンドウの実行(ボタンにマウスを移动してクリックするゴリ押し)
^+r::
MouseGetPos, x0, y0
WinGetPos, X, Y, Width, Height
MouseMove, Width - 60, 750
MouseClick, left
MouseMove, x0, y0
return