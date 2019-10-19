/*
    Retro Multi Manager
    A tool to help multi account on Dofus Retro
    Author: DetroitApps
*/

#NoEnv
; #Warn
#SingleInstance, Force
#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%

#Include Library\AES.ahk
#Include Class\Accounts.ahk
#Include Class\API.ahk
#Include Class\Settings.ahk

;----------------------------------------
;Main
;----------------------------------------

IniPath = settings.ini
Global MasterPassword := ""
Global ArrayAccounts := []

;Global PasswordRevealToggler := []

;Settings
oSettings := New Settings(IniPath)
If (oSettings.FirstStart= True)
{
    MsgBox, 65, First Start, %  "This is the first time you start RMM.`n" 
                                . "You need to setup a master password to safely store all your passwords.`n"
                                . "See the Github for more information."
    IfMsgBox Ok
    {
        MasterPassword := SetMasterPassword()
        oSettings.SetFirstStart(FirstStart, "False", IniPath)
    }
    IfMsgBox Cancel
        ExitApp
}
Else
{
    If !oSettings.Debug
        MasterPassword := SetMasterPassword()
    Else
        MasterPassword := "debug"
}

If (oSettings.CheckForUpdates = True)
    CheckForUpdates()

oSettings.InitShortcuts(IniPath)

;Gui init
If (oSettings.GuiStatus = True) {
    #Include Gui\Gui.ahk
    GuiControl,,InputDofusPath, % oSettings.DofusPath
    GuiControl, Choose, SpeedSelection, % oSettings.Speed
    If (oSettings.CheckForUpdates = True)
        GuiControl, , CheckCheckUpdateOnStart, 1
    Gui, Submit, NoHide
}

;Load default profile if exist
If (oSettings.DefaultProfile)
{
    ProfileSelection := oSettings.DefaultProfile
    Gosub, LoadProfile
    ;MsgBox, % "[" . ArrayAccounts[1].Id . "] Name=" . ArrayAccounts[1].Username
}

Global API := New API()
Return ;End Main


;----------------------------------------
;Functions
;----------------------------------------

GUI_UpdateBar(step, totalSteps := 0){
    global
    If (oSettings.GuiStatus = True) {
        If (totalSteps = 0)
            SB_UpdateBar(step)
        Else
        {  
            step := step * Round(100 / totalSteps)
            SB_UpdateBar(step)
        }
    }
}

GUI_UpdateText(content){
    global
    If (oSettings.GuiStatus = True) {
        SB_UpdateText(content)
    }
}

/*ListFiles(Directory)
{
	files =
	Loop %Directory%\*.*
		files = % files . A_LoopFileName . ";"
	return StrSplit(files, ";")
}
*/

SetMasterPassword() {
    InputBox, password, Master Password,Type your master password:, hide,,130
    If (ErrorLevel)
        ExitApp
    Else If (password = "")
    {
        MsgBox, 49, Error, % "Master password can't be empty. `nPress Ok to retry."
        IfMsgBox Ok
            SetMasterPassword()
        IfMsgBox Cancel
            ExitApp
    }
    Else
        return password
}

SleepHandler(addedSleep){
    global

    local step := 500 ;each speed mode will add or decrease initial value based on step
    local defaultSleep := 50
    speed := addedSleep + defaultSleep + ((oSettings.Speed - 1) * step)
    Sleep speed
}

CheckForUpdates(){
    UrlDownloadToFile, https://raw.githubusercontent.com/DetroitApps/RetroMultiManager/master/version.txt, githubVersion.txt ; kind of hardcoded
    FileRead, githubVersion, githubVersion.txt
    FileRead, localVersion, version.txt
    githubVersion := Trim(githubVersion, OmitChars := " `n")
    localVersion := Trim(localVersion, OmitChars := " `n")
    If (githubVersion != localVersion)
        MsgBox, % "Update exists " . githubVersion . "/" . localVersion ; To do
    FileDelete, githubVersion.txt
}

/*FillAccountsArray(){
    arrayAccount := []
    arrayAccount[1] := New Account("bla", "bli", "blop", "enutrof")
    arrayAccount[2] := New Account("blu", "bly", "blnp", "sadida")
}
*/

;----------------------------------------
;Labels
;----------------------------------------

#Include Gui\GuiLabels.ahk
#Include Labels.ahk
#Include Scenarios\Out\MergedScenarios.ahk

;----------------------------------------
;Shortcuts
;----------------------------------------

F1::
    labelName := oSettings.Hotkeys["F1"]
    if (labelName != "")
        Gosub, %labelName%
    return

F2::
    labelName := oSettings.Hotkeys["F2"]
    if (labelName != "")
        Gosub, %labelName%
    return

F3::
    labelName := oSettings.Hotkeys["F3"]
    if (labelName != "")
        Gosub, %labelName%
    return

F4::
    labelName := oSettings.Hotkeys["F4"]
    if (labelName != "")
        Gosub, %labelName%
    return

F5::
    labelName := oSettings.Hotkeys["F5"]
    if (labelName != "")
        Gosub, %labelName%
    return

F6::
    labelName := oSettings.Hotkeys["F6"]
    if (labelName != "")
        Gosub, %labelName%
    return

F7::
    labelName := oSettings.Hotkeys["F7"]
    if (labelName != "")
        Gosub, %labelName%
    return

F8::
    labelName := oSettings.Hotkeys["F8"]
    if (labelName != "")
        Gosub, %labelName%
    return

F9::
    labelName := oSettings.Hotkeys["F9"]
    if (labelName != "")
        Gosub, %labelName%
    return

F10::
    labelName := oSettings.Hotkeys["F10"]
    if (labelName != "")
        Gosub, %labelName%
    return

F12::
    ExitApp, 0
    return