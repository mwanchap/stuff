;old 5-button mouse macros, less useful now, commented out
;XButton2 & LButton::SendInput ^c
;XButton2 & RButton::SendInput ^v
;XButton2 & MButton::SendInput ^V
;XButton2 & XButton1::Send !{Tab}
;XButton2 & WheelUp::Send #{F11}
;XButton2 & WheelDown::Send #{F11}
;XButton1 & WheelDown::Send {Alt Down}{Tab}{Alt Up}
;XButton1 & XButton2::SendInput ^a doesn't work?
;XButton1 & WheelUp::Send !{ESC}
;XButton1 & WheelDown::Send !+{ESC} 
;~MButton & WheelUp::AltTab
;~MButton & WheelDown::ShiftAltTab
;~MButton & LButton::SendInput ^c
;~MButton & RButton::SendInput ^v

;swap caps and escape
$CapsLock::SendInput {Escape}
$Escape::SetCapsLockState Off

;launching various programs

#s::
{
    Run "C:\Program Files\grepWin\grepWin.exe"
    Sleep 200
    WinActivate
    return
}

;alt-tab replacement
;`::
;{
;    If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 250)
;    {
;        Send {Alt down}{Tab}
;        return
;    }
;    Else
;    {
;        SendInput !{Tab}
;        return
;    }
;}

desktop := 1

ScrollLock::
{
    desktops := 2
    if(desktop < desktops)
    {
        Send ^#{Right}
        desktop++
        return
    }
    else
    {
        while(desktop > 1)
        {
            Send ^#{Left}
            Sleep 100
            desktop--
        }

        return
    }
}

;prevents some programs like vim and notepad catching the numpad minus key for consoles
;NumpadSub::Send #{NumpadSub}
;NumpadAdd::Send ^#k
;^AppsKey::Send #{NumpadSub}
;!AppsKey::Send ^#k
;AppsKey::Send {AppsKey}
Launch_App2::Send !#k

; replacement for alt-tab shortcut - opens "switch to" module
; the $ symbol means that it can't be triggered from the ` hotkey below
$`::
{
    Send !#k
    Sleep 10
    Send Switch To`t
    return
}

; sometimes we still need to use the grave character, like in Powershell. Doesn't trigger the above
; due to the $ character
^+`::
{
    Send {``}
}

!#n::WindowSwitch("gvim.exe")
!#m::WindowSwitch("devenv.exe")
!#h::WindowSwitch("chrome.exe")
!#o::WindowSwitch("Code.exe")
!#i::WindowSwitch("firefox.exe")
!#j::WindowSwitch("WindowsTerminal.exe")
!#y::
{
    ;opens skype search
    Send ^!+3
    Send {Escape}
    return
}

#z::
{
    ; toggle skype mute
    Send #{F4}
    return
}


WindowSwitch(appName)
{
    if WinExist("ahk_exe " . appName)
    {
        WinActivate, ahk_exe %appName%
    }
    return
}

^Ins::
{
    Send ^c
}

:*:ssf::
(
SELECT	*
FROM	`
)

^!t::
FormatTime, TimeString,, yyyy-MM-dd HH:mm
Send %TimeString%
return


XButton1::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,3, Int,2)
KeyWait, XButton1
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,2)
return

XButton2::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,15, Int,2)
return

/*
~Break::
Send #{F4}
KeyWait, Break
Send #{F4}
return
*/

;media keys from http://www.instructables.com/id/Keyboard-Media-Controls-for-Windows-with-AutoHotKe/step2/Writing-the-script/
/*
^!Ins::
	Send {Media_Play_Pause}
return

^!End::
	Send {Media_Stop}
return

^!PgUp::
	Send {Media_Prev}
return

^!PgDn::
	Send {Media_Next}
return
*/

;^PrintScreen::
;	Run "C:\Windows\System32\SnippingTool.exe"
;	Sleep 500
;	WinActivate
;	Send ^n
;return

;Vim-style outlook shortcuts
/*
#IfWinActive Inbox - Matt.Wanchap@cpal.com.au - Outlook

j::
{
    SendInput ^6
    SendInput ^1
    SendInput {Down}
    return
}
k::
{
    SendInput ^6
    SendInput ^1
    SendInput {Up}
    return
}
d::SendInput {Delete}

;reply
r::
{
    SendInput ^r
    Sleep 1000
    SendInput #j
}

;move
m::SendInput ^+v

;forward
f::SendInput ^f

;search
/::
{
    SendInput ^e
    Sleep 500
    SendInput #j
}

#IfWinActive
*/
