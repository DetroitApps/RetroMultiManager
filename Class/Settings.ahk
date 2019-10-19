/*
    Class Settings
*/

Class Settings {
    __New(IniPath){
        If (IniPath = "settings_default.ini")
        {
            FileCopy, %IniPath%, settings.ini
            IniPath = settings.ini
        }
        IniRead, _DofusPath, %IniPath%, Settings, DofusPath
        IniRead, _Speed, %IniPath%, Settings, Speed
        IniRead, _GuiStatus, %IniPath%, Settings, GuiStatus
        IniRead, _CheckForUpdates, %IniPath%, Settings, CheckForUpdates
        IniRead, _FirstStart, %IniPath%, Settings, FirstStart
        IniRead, _Debug, %IniPath%, Settings, Debug
        IniRead, _DefaultProfile, %IniPath%, Profile, Default, %A_Space%

        this.DofusPath := _DofusPath
        this.Speed := _Speed
        this.GuiStatus := _GuiStatus = "True" ? True : False
        this.CheckForUpdates := _CheckForUpdates = "True" ? True : False
        this.FirstStart := _FirstStart = "True" ? True : False
        this.Debug := _Debug = "True" ? True : False
        this.DefaultProfile := _DefaultProfile
    }

    SetFirstStart(var, value, iniPath) {
        this.FirstStart := value
        IniWrite, %value%, %iniPath%, Settings, FirstStart
    }

    InitShortcuts(IniPath){
        arrayShortcuts := []

        Loop 12 {
            targetKey := "F" . A_Index
            IniRead, shortcut, %IniPath%, Hotkeys, %targetKey%
            arrayShortcuts[A_Index] := shortcut
        }
        this.Hotkeys := Object(   "F1", arrayShortcuts[1]
                                    ,"F2", arrayShortcuts[2]
                                    ,"F3", arrayShortcuts[3]
                                    ,"F4", arrayShortcuts[4]
                                    ,"F5", arrayShortcuts[5]
                                    ,"F6", arrayShortcuts[6]
                                    ,"F7", arrayShortcuts[7]
                                    ,"F8", arrayShortcuts[8]
                                    ,"F9", arrayShortcuts[9]
                                    ,"F10", arrayShortcuts[10]
                                    ,"F11", arrayShortcuts[11]
                                    ,"F12", arrayShortcuts[12])
        
    }
}