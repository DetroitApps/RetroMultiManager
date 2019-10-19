LoginAccounts:
    Loop, % API.GetTotalWindows() {
        window := API.GetWindow(A_Index)
        window.Activate()
        MsgBox, % "Activating Window " . window.fullTitle
        Sleep 3000
    }
return

/*
LoginAccounts:
    WinGet, windows, List, Dofus
    Loop, %windows% {
        window := windows%A_Index%
        WinActivate, ahk_id %window%
        WinWaitActive, ahk_id %window%
        Sleep 50
        id := nbInstances - %A_Index% + 1
        WinSetTitle, %id%
        Click, 30,100
        Send, {Tab}
        Sleep 50
        SendRaw, % username[id]
        Sleep 50
        Send, {Tab}
        Sleep 50
        SendRaw, % password[id]
        Sleep 50
        ;Send {Enter}
        Sleep 300
        WinMaximize, ahk_id %window%
    }
return
*/