global username := []
global password := []
global nickname := []

IniRead, DofusPath, config.ini, Script, DofusLocation
IniRead, Delim, config.ini, Script, Delimiter

if (DofusPath = "")
{
    MsgBox, 16, Edit needed, You need to edit the DofusPath variable (line 2) in the .ahk file.
    ExitApp, 1
}

if !FileExist(DofusPath){
    MsgBox, 16, File not found, % "Dofus.exe is not found with path: '" . DofusPath . "'."
    ExitApp, 2
}

i := 1
Loop, 8
{
    IniRead, Account, config.ini, Accounts, User%i%
    if (Account != "")
    {
        accountArray := StrSplit(Account, Delim)
        username[i] := accountArray[1]
        password[i] := accountArray[2]
        nickname[i] := accountArray[3]
        i++
    }
    else if (Account = "ERROR")
    {
        MsgBox, 16, Error reading ini,% "Error when trying to read user number" . i "."
        ExitApp, 3
    }
    else
        break
}

global nbInstances := password.MaxIndex()
 
Loop %nbInstances% {
    Run, %DofusPath%
    Sleep 50
}

CycleWindow(currentWindowTitle, isForward) {
    nbwindow := SubStr(currentWindowTitle, 1, 1), nbwindow += 0
    if (isForward = True) 
    {
        nbwindow++
        if (nbwindow > nbInstances)
            nbwindow := 1
        WinActivate, %nbwindow%
    }
    else
    {
        nbwindow--
        if (nbwindow <= 0)
            nbwindow := nbInstances
        WinActivate, %nbwindow%
    }
}

GetTitle(id)
{
    if (nickname[id])
        title := id . " " . nickname[id]
    else
        title := id
    return title
}

;Connect accounts
F10::
    WinGet, windows , List, Dofus
    i := 1
    Loop, %windows% {
        window := windows%A_Index%
        WinActivate, ahk_id %window%
        WinWaitActive, ahk_id %window%
        Sleep 50
        id := nbInstances - i + 1
        title := GetTitle(id)
        WinSetTitle, %title%
        Click, 30,100
        Sleep 50
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
        i += 1
    }
return

;Connect characters
F11::
    i := 1
    Loop, %nbInstances%
    {
        WinActivate, %i%
        WinWaitActive, %i%
        Loop, 2 {
            MouseMove, 650, 800
            Click, 2
            Sleep 2000
        }
        Sleep 500
        i++
    }
return

loop
{
    SC029::
        WinGetActiveTitle, Title
        CycleWindow(Title, True)
        return
    +SC029::
        WinGetActiveTitle, Title
        CycleWindow(Title, False)
        return
    F9::
        WinGetActiveTitle, Title
        InputBox, UserInput, Update title,,,200,100
        WinSetTitle, %Title%,,%UserInput%
        return
    F12::
        ExitApp, 0
    +F12::
        WinGet, windows , List, Dofus
        Loop, %windows% {
            window := windows%A_Index%
            WinClose, ahk_id %window%
            Sleep 100
        }
        i := 1
        Loop %nbInstances% {
            WinClose, %i%
            i += 1
            Sleep 100
        }
    return
}
return