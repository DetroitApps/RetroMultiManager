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
    FirstStart := False
    Debug := False
    Dev := False

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
        IniRead, FirstStart, %IniPath%, Program, FirstStart

        If !Language
            this.Language := (A_Language = "040C") ? "fr-FR" : "en-US"
        Else
            this.Language := Language
        this.GuiStatus := GuiStatus = "True" ? True : False
        this.CheckForUpdates := CheckForUpdates = "True" ? True : False
        this.FirstStart := FirstStart = "True" ? True : False
        this.DefaultProfile := DefaultProfile
        ; Mode
        IniRead, Debug, %IniPath%, Mode, Debug
        IniRead, Dev, %IniPath%, Mode, Dev

        this.Debug := Debug = "True" ? True : False
        this.Dev := Dev = "True" ? True : False

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

    InitHotkeys(IniPath){
        arrayHotkeys := []

        Loop 12 {
            targetKey := "F" . A_Index
            IniRead, shortcut, %IniPath%, Hotkeys, %targetKey%
            arrayHotkeys[A_Index] := shortcut
        }
        this.Hotkeys := Object(   "F1", arrayHotkeys[1]
                                    ,"F2", arrayHotkeys[2]
                                    ,"F3", arrayHotkeys[3]
                                    ,"F4", arrayHotkeys[4]
                                    ,"F5", arrayHotkeys[5]
                                    ,"F6", arrayHotkeys[6]
                                    ,"F7", arrayHotkeys[7]
                                    ,"F8", arrayHotkeys[8]
                                    ,"F9", arrayHotkeys[9]
                                    ,"F10", arrayHotkeys[10]
                                    ,"F11", arrayHotkeys[11]
                                    ,"F12", arrayHotkeys[12])
        
    }
}