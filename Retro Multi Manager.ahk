/*
    Retro Multi Manager
    Smart AutoHotKey program to manage your accounts on Dofus Retro 1.30.0+.
    Author: DetroitApps
*/

#NoEnv
#SingleInstance, Force
#Persistent
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window

#Include Class\API\API.ahk
#Include Class\Accounts.ahk
#Include Class\Settings.ahk
#Include Debug\Logger.ahk 
#Include Debug\Tests.ahk
#Include Library\AES.ahk
#Include OCR\OCR.ahk

;----------------------------------------
;Main
;----------------------------------------

Global MasterPassword := ""
Global ArrayAccounts := []

;Settings
If FileExist("settings.ini")
    IniPath = settings.ini
Else
    IniPath = settings_default.ini
Global oSettings := New Settings(IniPath)
IniPath = settings.ini

If oSettings.Dev
{
    FileGetTime, LastMergeTime, Scenarios\Out\MergedScenarios.ahk
    FormatTime, Now,, Time
    EnvSub, LastMergeTime, A_Now
    If (LastMergeTime < -10)
        Gosub, MergeScenarios
}

If oSettings.Debug
    Global Logger := New Logger()

If (oSettings.CheckForUpdates = True)
    CheckForUpdates()

If ((A_ScreenWidth = 2560 && A_ScreenHeight = 1440) || (A_ScreenWidth = 1920 && A_ScreenHeight = 1080))
    oSettings.EnableOCR := True

If (oSettings.FirstStart = True)
{
    MsgBox, 65, First Start, %  "This is the first time you start Retro Multi Manager.`n" 
                                . "You need to setup a master password to safely store all your passwords.`n"
                                . "For more information, see the GitHub."
    IfMsgBox Ok
        MasterPassword := SetMasterPassword()
    IfMsgBox Cancel
        ExitApp

    oSettings.SetFirstStart(FirstStart, "False", IniPath)
}
Else
{
    If !oSettings.Debug
        MasterPassword := SetMasterPassword()
    Else
        MasterPassword := "debug"
}

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
If (!oSettings.FirstStart && oSettings.DefaultProfile)
{
    ProfileSelection := oSettings.DefaultProfile
    Gosub, LoadProfile
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
            progress := (step = totalSteps) ? 100 : step * Round(100 / totalSteps)
            SB_UpdateBar(progress)
        }
    }
}

GUI_UpdateText(content){
    global
    If (oSettings.GuiStatus = True) {
        SB_UpdateText(content)
    }
}

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
    {
        MsgBox, % 68, Update found, An update exists!`nCurrentVersion: %localVersion%`nNew version: %githubVersion%`nWould you like to visit GitHub release page ?
        IfMsgBox, Yes
            Run, https://github.com/DetroitApps/RetroMultiManager/releases
    }
    FileDelete, githubVersion.txt
}

ExitGracefully(){
    Logger.Write("Program exited gracefully with " . Logger.TotalWarning . " warning and " . Logger.TotalErrors . " errors.")
    Logger.CloseLogFiles()
    ExitApp
}

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
    ExitGracefully()
    return