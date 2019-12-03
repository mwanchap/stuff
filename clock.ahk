;display the date and time, useful for print screen
#singleinstance force

xpos := A_ScreenWidth - 135
ypos := A_ScreenHeight - 13

Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption
Gui, Color, CCCCCC
Gui, Font, cFF0000 s8 , consolas ;red
Gui, Add, Text, vD y0 BackgroundTrans, %A_YYYY%-%A_MM%-%A_DD% %a_hour%:%a_min%:%a_sec%
Gui, Show, NoActivate x%xpos% y%ypos%,uptime  ; screen position here
WinSet, TransColor, CCCCCC 255,uptime
SetTimer, RefreshD, 1000
return

RefreshD:
GuiControl, , D, %A_YYYY%-%A_MM%-%A_DD% %a_hour%:%a_min%:%a_sec%
return
