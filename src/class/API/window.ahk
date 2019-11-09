Class Window {
    __New(parent, index, pid){
        this.pid := pid
        this.id := index
        this.fullTitle := ""
        this.parent := parent
    }

    WaitOpen(){
        Logger.Write("Waiting for window #" this.id " to open (pid '" this.pid "').")
        WinWait, % "ahk_pid " this.pid
        If this.pid Is Not digit
            Logger.Write("Window PID is not a valid number : ' " this.pid " '", 2)
    }

    Activate(){
        Logger.Write("Activating window #" this.id " (pid '" this.pid "').")
        WinActivate, % "ahk_pid " this.pid
        this.parent.CurrentWindow := this.id
        If this.pid Is Not digit
            Logger.Write("Window PID is not a valid number : ' " this.pid " '", 2)
    }

    WaitActive(){
        Logger.Write("Waiting for window #" this.id " to activate (pid '" this.pid "').")
        WinWaitActive, % "ahk_pid " this.pid
        If this.pid Is Not digit
            Logger.Write("Window PID is not a valid number : ' " this.pid " '", 2)
    }

    Maximize(){
        WinMaximize, % "ahk_pid " this.pid
    }

    SetTitle(Byref Account){
        Logger.Write("Setting title for window # " this.id " (pid '" this.pid "').")
        If this.pid Is Not digit
            Logger.Write("Window PID is not a valid number : ' " this.pid " '", 2)
        title := "[" . this.id . "]"
        If (Account.CharacterClass && Account.CharacterClass != "")
            title = % title . A_Space . Account.CharacterClass
        If (Account.Nickname && Account.Nickname != "")
            title = % title . A_Space . "(" . Account.Nickname . ")"
        
        WinSetTitle, % "ahk_pid " this.pid,, %title%
        this.fullTitle := title
    }
}