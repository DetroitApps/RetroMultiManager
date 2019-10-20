/*
    Class Settings
*/

Class Settings {
    DofusPath := ""
    Speed := 0
    GuiStatus := False
    CheckForUpdates := False
    FirstStart := False
    Debug := False
    Dev := False
    DefaultProfile := 1
    EnableOCR := False

    __New(IniPath){
        If (IniPath = "settings_default.ini")
        {
            FileCopy, %IniPath%, settings.ini
            IniPath = settings.ini
        }
        
        this.TitleApp := "Retro Multi Manager"
        FileRead, version, version.txt
        this.Version := version

        ;INI
        IniRead, DofusPath, %IniPath%, Settings, DofusPath
        IniRead, Speed, %IniPath%, Settings, Speed
        IniRead, GuiStatus, %IniPath%, Settings, GuiStatus
        IniRead, CheckForUpdates, %IniPath%, Settings, CheckForUpdates
        IniRead, FirstStart, %IniPath%, Settings, FirstStart
        IniRead, EnableOCR, %IniPath%, Settings, EnableOCR
        IniRead, Debug, %IniPath%, Settings, Debug
        IniRead, Dev, %IniPath%, Settings, Dev
        IniRead, DefaultProfile, %IniPath%, Profile, Default, %A_Space%

        this.DofusPath := DofusPath
        this.Speed := Speed
        this.GuiStatus := GuiStatus = "True" ? True : False
        this.CheckForUpdates := CheckForUpdates = "True" ? True : False
        this.FirstStart := FirstStart = "True" ? True : False
        this.EnableOCR := EnableOCR = "True" ? True : False
        this.Debug := Debug = "True" ? True : False
        this.Dev := Dev = "True" ? True : False
        this.DefaultProfile := DefaultProfile

        ;Try to get Dofus with default path
        If (this.DofusPath = "")
        {
            defaultPath := StrReplace(A_AppData, "Roaming") . "Local\Ankama\zaap\retro\resources\app.asar.unpacked\retroclient\Dofus.exe"
            If FileExist(defaultPath)
            {
                this.DofusPath := defaultPath
                GuiControl,,InputDofusPath, defaultPath
                IniWrite, %defaultPath%, %IniPath%, Settings, DofusPath
            }
        }
    }

    SetFirstStart(var, value, iniPath) {
        this.FirstStart := value
        IniWrite, %value%, %iniPath%, Settings, FirstStart
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