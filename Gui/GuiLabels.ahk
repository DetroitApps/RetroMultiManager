/*
    Gui labels
*/

GuiClearAccountsData:
    GuiControl,,CheckPasswordEncryption, 0
    GuiControl,,CheckDefaultProfile, 0
    Loop 8 {
        GuiControl,,CheckActive%A_Index%, 1
        GuiControl,,InputUsername%A_Index%
        GuiControl,,InputPassword%A_Index%
        GuiControl,,InputNickname%A_Index%
        GuiControl, Choose, SelectClass%A_Index%, 0
    }
    return

Browse:
    Gui, Submit, NoHide
    FileSelectFile, newDofusPath, 3, , Open a file, Dofus.exe (Dofus.exe)
    oSettings.DofusPath := newDofusPath
    GuiControl,,InputDofusPath, % oSettings.DofusPath
    IniWrite, % oSettings.DofusPath, %IniPath%, Settings, DofusPath
    SB_UpdateText("Dofus path successfully modified.")
    return

ChangeSpeed:
    Gui, Submit, NoHide
    oSettings.Speed := SpeedSelection
    IniWrite, % oSettings.Speed, %IniPath%, Settings, Speed ;move to class
    SB_UpdateText("Script speed successfully modified (" . SpeedSelection . ").")
    return

GuiCheckForUpdates:
    CheckForUpdates()
    return

GuiToggleCheckUpdateOnStart:
    Gui, Submit, NoHide
    IniWrite, % CheckCheckUpdateOnStart = 1 ? "True" : "False", %IniPath%, Settings, CheckForUpdates ;move to class
    return

VisitGithub:
    Run, https://github.com/DetroitApps/RetroMultiManager
    return

MergeScenarios:
    path = %A_ScriptDir%\Tools\MergeScenarios.ahk
    Run, %path%
    ;Reload
    return

ReloadScript:
    Reload
    return
    
GuiLoadProfile:
    Gui, Submit, NoHide
    Gosub, LoadProfile
    return

GuiSaveProfile:
    Gui, Submit, NoHide
    Gosub, SaveProfile
    return

GuiOpenDofus:
    Gosub, OpenDofusInstances
    return

GuiLoginAccounts:
    Gosub, LoginAccounts
    return

GuiConnectServers:
    MsgBox, Todo
    return


;ALL INDIVIDUAL LABELS
RevealPassword1:
    RevealPassword("InputPassword1")
    return
RevealPassword2:
    RevealPassword("InputPassword2")
    return
RevealPassword3:
    RevealPassword("InputPassword3")
    return
RevealPassword4:
    RevealPassword("InputPassword4")
    return
RevealPassword5:
    RevealPassword("InputPassword5")
    return
RevealPassword6:
    RevealPassword("InputPassword6")
    return
RevealPassword7:
    RevealPassword("InputPassword7")
    return
RevealPassword8:
    RevealPassword("InputPassword8")
    return

;MoveAccountUp
MoveAccountUp1:
    ;MoveAccountOrder(1, 0)
    return
MoveAccountUp2:
    MoveAccountOrder(2, 0)
    return
MoveAccountUp3:
    MoveAccountOrder(3, 0)
    return
MoveAccountUp4:
    MoveAccountOrder(4, 0)
    return
MoveAccountUp5:
    MoveAccountOrder(5, 0)
    return
MoveAccountUp6:
    MoveAccountOrder(6, 0)
    return
MoveAccountUp7:
    MoveAccountOrder(7, 0)
    return
MoveAccountUp8:
    MoveAccountOrder(8, 0)
    return

;MoveAccountDown
MoveAccountDown1:
    MoveAccountOrder(1, 1)
    return
MoveAccountDown2:
    MoveAccountOrder(2, 1)
    return
MoveAccountDown3:
    MoveAccountOrder(3, 1)
    return
MoveAccountDown4:
    MoveAccountOrder(4, 1)
    return
MoveAccountDown5:
    MoveAccountOrder(5, 1)
    return
MoveAccountDown6:
    MoveAccountOrder(6, 1)
    return
MoveAccountDown7:
    MoveAccountOrder(7, 1)
    return
MoveAccountDown8:
    ;MoveAccountOrder(8, 1)
    return
