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
#Include Library\AES.ahk


;----------------------------------------
; MAIN
;----------------------------------------

; Globals
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
    FileGetTime, LastMergeTime, Scenarios\Out\MergedScenarios.ahk
    FormatTime, Now,, Time
    EnvSub, LastMergeTime, A_Now
    If (LastMergeTime < -10)
        Gosub, MergeScenarios
}

If Settings.Debug
    Logger := New Logger()

If (Settings.CheckForUpdates = True)
    CheckForUpdates()

If (Settings.FirstStart = True)
{
    MsgBox, 65, First Start, %  "This is the first time you start " . Settings.TitleApp . "`n" 
                                . "You need to setup a master password to safely store all your passwords.`n"
                                . "For more information, see the GitHub."
    IfMsgBox Ok
        MasterPassword := SetMasterPassword()
        If ((A_ScreenWidth = 2560 && A_ScreenHeight = 1440) || (A_ScreenWidth = 1920 && A_ScreenHeight = 1080))
            If ScreenCompatible()
                Settings.EnableOCR := True
    IfMsgBox Cancel
        ExitApp

    Settings.SetFirstStart(FirstStart, "False", IniPath)
}
Else
{
    If !Settings.Debug
        MasterPassword := SetMasterPassword()
    Else
        MasterPassword := "debug"
}

Settings.InitHotkeys(IniPath)

;Gui init
If (Settings.GuiStatus = True) {
    #Include Gui\Gui.ahk
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

#Include Functions\Functions.ahk
#Include Functions\OCR.ahk

;----------------------------------------
; Labels
;----------------------------------------

#Include Gui\GuiLabels.ahk
#Include Labels\Labels.ahk
#Include Scenarios\Out\MergedScenarios.ahk

;----------------------------------------
; Hotkeys
;----------------------------------------

#Include Labels\Hotkeys.ahk