Class Window {
    __New(parent, hwnd){
        this.hwnd := hwnd
        this.fullTitle := ""
        this.parent := parent
    }

    /*
    WaitOpen(){
        Logger.Write("Waiting for window #" this.id " to open (hwnd '" this.hwnd "').")
        WinWait, % "ahk_id " this.hwnd
        If (this.hwnd = "")
            Logger.Write("Window HWND is not a valid ID : '" this.hwnd "'", 2)
    }
    */

    Activate(){
        Logger.Write("Activating window #" this.id " (hwnd '" this.hwnd "', fullTitle '" this.fullTitle "').")
        If WinExist("ahk_id " . this.hwnd)
            WinActivate
        Else
            Logger.Write("HWND not found : '" this.hwnd "'", 2)
        If (this.hwnd = "")
            Logger.Write("Window HWND is not a valid ID : '" this.hwnd "'", 2)
    }
    WaitActive(){
        Logger.Write("Waiting for window #" this.id " to activate (hwnd '" this.hwnd "').")
        WinWaitActive, % "ahk_id " this.hwnd
        If (this.hwnd = "")
            Logger.Write("Window HWND is not a valid ID : '" this.hwnd "'", 2)
    }

    Maximize(){
        WinMaximize, % "ahk_id " this.hwnd
    }

    SetTitle(Byref Account){
        Logger.Write("Setting title for window # " this.id " (hwnd '" this.hwnd "').")
        If (this.hwnd = "")
            Logger.Write("Window HWND is not a valid ID : '" this.hwnd "'", 2)
        title := "[" . this.id . "]"
        If (Account.CharacterClass && Account.CharacterClass != "")
            title = % title . A_Space . Account.CharacterClass
        If (Account.Nickname && Account.Nickname != "")
            title = % title . A_Space . "(" . Account.Nickname . ")"
        
        WinSetTitle, % "ahk_id " this.hwnd,, %title%
        this.fullTitle := title
    }
}