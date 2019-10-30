/*
    Gui labels
*/

GuiClose:
    ExitApp
    return

Gui_ClearAccountData:
    GuiControl,,CheckEncryption, 0
    GuiControl,,CheckDefaultProfile, 0
    Loop 8 {
        GuiControl,,CheckActive%A_Index%, 1
        GuiControl,,InputUsername%A_Index%
        GuiControl,,InputPassword%A_Index%
        GuiControl,,InputNickname%A_Index%
        GuiControl, Choose, SelectClass%A_Index%, 0
    }
    return

Gui_Browse:
    Gui, Submit, NoHide
    FileSelectFile, newDofusPath, 3, , Open a file, Dofus.exe (Dofus.exe)
    Settings.DofusPath := newDofusPath
    GuiControl,,InputDofusPath, % Settings.DofusPath
    IniWrite, % Settings.DofusPath, %IniPath%, Game, Path
    SB_UpdateText("Dofus path successfully modified.")
    return

Gui_ChangeSpeed:
    Gui, Submit, NoHide
    Settings.Speed := SelectSpeed
    IniWrite, % Settings.Speed, %IniPath%, Game, Speed ;move to class
    SB_UpdateText("Script speed successfully modified (" . SelectSpeed . ").")
    return

Gui_CheckForUpdates:
    CheckForUpdates()
    return

Gui_CloseGui:
    Gui, Destroy
    return

Gui_ToggleCheckUpdateOnStart:
    Gui, Submit, NoHide
    IniWrite, % CheckCheckUpdateOnStart = 1 ? "True" : "False", %IniPath%, Program, CheckForUpdates ;move to class
    return

Gui_RunScenario:
    Gui, Submit, NoHide
    Gosub, %SelectScenario%
    return

Gui_LoadScenarios:
    API.LoadScenarios()
    return

Gui_ReloadScript:
    Reload
    return
    
Gui_LoadProfile:
    Gui, Submit, NoHide
    Gosub, LoadProfile
    return

Gui_SaveProfile:
    Gui, Submit, NoHide
    Gosub, SaveProfile
    return

Gui_OpenDofus:
    Gosub, OpenDofusInstances
    return

Gui_LoginAccounts:
    Gosub, LoginAccounts
    return

Gui_ConnectServers:
    Gosub, ConnectServersPlayers
    return

;ALL INDIVIDUAL LABELS
Gui_RevealPassword1:
    RevealPassword("InputPassword1")
    return
Gui_RevealPassword2:
    RevealPassword("InputPassword2")
    return
Gui_RevealPassword3:
    RevealPassword("InputPassword3")
    return
Gui_RevealPassword4:
    RevealPassword("InputPassword4")
    return
Gui_RevealPassword5:
    RevealPassword("InputPassword5")
    return
Gui_RevealPassword6:
    RevealPassword("InputPassword6")
    return
Gui_RevealPassword7:
    RevealPassword("InputPassword7")
    return
Gui_RevealPassword8:
    RevealPassword("InputPassword8")
    return

;MoveAccountUp
Gui_MoveAccountUp1:
    ;MoveAccountOrder(1, 0)
    return
Gui_MoveAccountUp2:
    MoveAccountOrder(2, 0)
    return
Gui_MoveAccountUp3:
    MoveAccountOrder(3, 0)
    return
Gui_MoveAccountUp4:
    MoveAccountOrder(4, 0)
    return
Gui_MoveAccountUp5:
    MoveAccountOrder(5, 0)
    return
Gui_MoveAccountUp6:
    MoveAccountOrder(6, 0)
    return
Gui_MoveAccountUp7:
    MoveAccountOrder(7, 0)
    return
Gui_MoveAccountUp8:
    MoveAccountOrder(8, 0)
    return

;MoveAccountDown
Gui_MoveAccountDown1:
    MoveAccountOrder(1, 1)
    return
Gui_MoveAccountDown2:
    MoveAccountOrder(2, 1)
    return
Gui_MoveAccountDown3:
    MoveAccountOrder(3, 1)
    return
Gui_MoveAccountDown4:
    MoveAccountOrder(4, 1)
    return
Gui_MoveAccountDown5:
    MoveAccountOrder(5, 1)
    return
Gui_MoveAccountDown6:
    MoveAccountOrder(6, 1)
    return
Gui_MoveAccountDown7:
    MoveAccountOrder(7, 1)
    return
Gui_MoveAccountDown8:
    ;MoveAccountOrder(8, 1)
    return
