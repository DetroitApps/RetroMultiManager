Class Window {
    __New(parent, index, hwnd){
        this.hwnd := hwnd
        this.id := index
        this.fullTitle := ""
        this.parent := parent
    }

    WaitOpen(){
        Logger.Write("Waiting for window #" this.id " to open (id '" this.hwnd "').")
        WinWait, % "ahk_id " this.hwnd
        If this.hwnd Is Not digit
            Logger.Write("Window hwnd is not a valid number : ' " this.hwnd " '", 2)
    }

    Activate(){
        Logger.Write("Activating window #" this.id " (id '" this.hwnd "').")
        WinActivate, % "ahk_id " this.hwnd
        this.parent.CurrentWindow := this.id
        If this.hwnd Is Not digit
            Logger.Write("Window hwnd is not a valid number : ' " this.hwnd " '", 2)
    }

    WaitActive(){
        Logger.Write("Waiting for window #" this.id " to activate (hwnd '" this.hwnd "').")
        WinWaitActive, % "ahk_id " this.hwnd
        If this.hwnd Is Not digit
            Logger.Write("Window hwnd is not a valid number : ' " this.hwnd " '", 2)
    }

    Maximize(){
        WinMaximize, % "ahk_id " this.hwnd
    }

    SetTitle(Byref Account){
        Logger.Write("Setting title for window # " this.hwnd " (id '" this.hwnd "').")
        If this.hwnd Is Not digit
            Logger.Write("Window hwnd is not a valid number : ' " this.hwnd " '", 2)
        title := "[" . this.id . "]"
        If (Account.CharacterClass && Account.CharacterClass != "")
            title = % title . A_Space . Account.CharacterClass
        If (Account.Nickname && Account.Nickname != "")
            title = % title . A_Space . "(" . Account.Nickname . ")"
        
        WinSetTitle, % "ahk_id " this.hwnd,, %title%
        this.fullTitle := title
    }
}