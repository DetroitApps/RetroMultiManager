/*
    Class Settings
*/

Class Settings {
    ;Default values
    DofusPath := ""
    Speed := 0
    Language := ""
    DefaultProfile := 1
    GuiStatus := False
    CheckForUpdates := False
    WaitForAnkamaShield := False
    FirstStart := False
    Debug := False
    Dev := False
    Hotkeys := []

    __New(IniPath){
        this.TitleApp := "Retro Multi Manager"
        FileRead, version, version.txt
        this.Version := version
        this.IniPath := IniPath
        
        ; Grab config from INI
        If (IniPath = "settings_default.ini")
        {
            FileCopy, %IniPath%, settings.ini
            IniPath = settings.ini
        }

        ; Game
        IniRead, DofusPath, %IniPath%, Game, Path
        IniRead, Speed, %IniPath%, Game, Speed

        this.DofusPath := DofusPath
        this.Speed := Speed

        ; Program
        IniRead, Language, %IniPath%, Program, Language, %A_Space%
        IniRead, DefaultProfile, %IniPath%, Program, DefaultProfile, %A_Space%
        IniRead, GuiStatus, %IniPath%, Program, Gui
        IniRead, CheckForUpdates, %IniPath%, Program, CheckForUpdates
        IniRead, WaitForAnkamaShield, %IniPath%, Program, WaitForAnkamaShield
        IniRead, FirstStart, %IniPath%, Program, FirstStart

        If !Language
            this.Language := (A_Language = "040C") ? "fr-FR" : "en-US"
        Else
            this.Language := Language
        this.GuiStatus := GuiStatus = "True" ? True : False
        this.CheckForUpdates := CheckForUpdates = "True" ? True : False
        this.WaitForAnkamaShield := WaitForAnkamaShield = "True" ? True : False
        this.FirstStart := FirstStart = "True" ? True : False
        this.DefaultProfile := DefaultProfile

        ;Organizer
        IniRead, AlwaysOrganize, %IniPath%, Organizer, AlwaysOrganize

        this.AlwaysOrganize := AlwaysOrganize = "True" ? True : False

        ; Mode
        IniRead, Debug, %IniPath%, Mode, Debug
        IniRead, Dev, %IniPath%, Mode, Dev

        this.Debug := Debug = "True" ? True : False
        this.Dev := Dev = "True" ? True : False

        ;Shortcuts
        IniRead, FunctionHotkeys, %IniPath%, Hotkeys, FunctionHotkeys
        IniRead, CycleWindows, %IniPath%, Hotkeys, CycleWindows
        IniRead, CycleWindowsBackwards, %IniPath%, Hotkeys, CycleWindowsBackwards
        IniRead, MoveAllPlayers, %IniPath%, Hotkeys, MoveAllPlayers

        this.FunctionHotkeys := FunctionHotkeys = "True" ? True : False
        this.Hotkeys["CycleWindows"] := CycleWindows
        this.Hotkeys["CycleWindowsBackwards"] := CycleWindowsBackwards
        this.Hotkeys["MoveAllPlayers"] := MoveAllPlayers

        this.InitHotkeys()

        ;Try to get Dofus with default path
        If (this.DofusPath = "")
        {
            defaultPath := StrReplace(A_AppData, "Roaming") . "Local\Ankama\zaap\retro\Resources\app.asar.unpacked\retroclient\Dofus.exe"
            If FileExist(defaultPath)
            {
                this.DofusPath := defaultPath
                GuiControl,,InputDofusPath, defaultPath
                IniWrite, %defaultPath%, %IniPath%, Game, Path
            }
        }
    }

    SetFirstStart(value, iniPath) {
        this.FirstStart := value
        IniWrite, %value%, %iniPath%, Program, FirstStart
    }

    SetLanguage(lang)
    {
        this.Language := lang
        IniWrite, %lang%, % this.IniPath, Program, Language
        Reload
    }

    DisableHotkey(hotkeyName)
    {
        Hotkey, % this.Hotkeys[hotkeyName],, UseErrorLevel
        If ErrorLevel in 5,6
            return
        Else
            Hotkey, % this.Hotkeys[hotkeyName], Off
    }

    UpdateHotkey(hotkeyName, key)
    {
        this.DisableHotkey(hotkeyName)
        this.Hotkeys[hotkeyName] := key
        Hotkey, % this.Hotkeys[hotkeyName], %hotkeyName%
    }

    InitHotkeys(){
        Hotkey, % this.Hotkeys["CycleWindows"], CycleWindows
        Hotkey, % this.Hotkeys["CycleWindowsBackwards"], CycleWindowsBackwards
        Hotkey, % this.Hotkeys["MoveAllPlayers"], MoveAllPlayers
    }
}