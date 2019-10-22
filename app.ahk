/*
    Retro Multi Manager
    Smart AutoHotKey program to manage your accounts on Dofus Retro 1.30.0+.
    Author: DetroitApps
*/

#NoEnv
#SingleInstance, Force
#Persistent

StringCaseSense On
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window

#Include class\API\API.ahk
#Include class\accounts.ahk
#Include class\logger.ahk
#Include class\settings.ahk
#Include lib\AES.ahk

;----------------------------------------
; MAIN
;----------------------------------------

; Globals

;quick access for msgbox
Global MBICON := Object("Error", 16, "Question", 32, "Exclamation", 48, "Info", 64)
Global MBBTN := Object("OkCancel", 1, "AbortRetryIgnore", 2, "YesNoCancel", 3, "YesNo", 4, "RetryCancel", 5, "CancelTryAgainContinue", 6)

Global API
Global Logger
Global Settings
Global MasterPassword := ""
Global ArrayAccounts := []

; Settings
If FileExist("settings.ini")
    IniPath = settings.ini
Else
    IniPath = settings_default.ini
Settings := New Settings(IniPath)
IniPath = settings.ini


If Settings.Dev
{
    FileGetTime, lastMergeTime, Scenarios\Out\MergedScenarios.ahk
    diff := A_Now - lastMergeTime
    If (diff > 10)
    {
        Gosub, MergeScenarios
        ExitApp
    }
    FormatTime, formattedTime, lastMergeTime, dd/MM/yyyy hh:mm:sstt
    line := "Last scenarios merge " . diff . " seconds ago. (" . formattedTime . ")"
    TrayTip, Scenarios, %line%, 3, 17
}

If Settings.Debug
    Logger := New Logger()

If (Settings.CheckForUpdates = True)
    CheckForUpdates()

If (Settings.FirstStart = True)
{
    MsgBox, 65, % Translate("FirstStartTitle"), % Translate("FirstStart", [Settings.TitleApp])
    IfMsgBox Ok
        MasterPassword := SetMasterPassword()
        If ((A_ScreenWidth = 2560 && A_ScreenHeight = 1440) || (A_ScreenWidth = 1920 && A_ScreenHeight = 1080))
            If ScreenCompatible()
                Settings.EnableOCR := True
    IfMsgBox Cancel
        ExitApp

    Settings.SetFirstStart("False", IniPath)
}
Else
{
    If !Settings.Dev
        MasterPassword := SetMasterPassword()
    Else
        MasterPassword := "dev"
}

Settings.InitHotkeys(IniPath)

;Gui init
If (Settings.GuiStatus = True) {
    #Include gui\gui.ahk

    GuiControl,,InputDofusPath, % Settings.DofusPath
    GuiControl, Choose, SelectSpeed, % Settings.Speed
    If (Settings.CheckForUpdates = True)
        GuiControl, , CheckCheckUpdateOnStart, 1
    Gui, Submit, NoHide
}

;Load default profile if exist
If (!Settings.FirstStart && Settings.DefaultProfile)
{
    SelectProfile := Settings.DefaultProfile
    Gosub, LoadProfile
}

API := New API()

Return

;----------------------------------------
; END MAIN
;----------------------------------------

;----------------------------------------
; Functions
;----------------------------------------

#Include functions\functions.ahk
#Include functions\ocr.ahk

;----------------------------------------
; Labels
;----------------------------------------

#Include labels\gui-labels.ahk
#Include labels\labels.ahk
#Include scenarios\Out\MergedScenarios.ahk

;----------------------------------------
; Hotkeys
;----------------------------------------

#Include labels\hotkeys.ahk