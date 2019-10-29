Class Window {
    __New(parent, index, pid){
        if (_pid = 0) ; ??
        {
            idIndex = 1
            return
        }
        this.pid := pid
        this.id := index
        this.fullTitle := ""
        this.parent := parent
    }

    WaitOpen(){
        WinWait, % "ahk_pid " this.pid
    }

    Activate(){
        WinActivate, % "ahk_pid " this.pid
        this.parent.CurrentWindow := this.id
    }

    WaitActive(){
        WinWaitActive, % "ahk_pid " this.pid
    }

    Maximize(){
        WinMaximize, % "ahk_pid " this.pid
    }

    SetTitle(Byref Account){
        title := "[" . this.id . "]"
        If (Account.CharacterClass && Account.CharacterClass != "")
            title = % title . A_Space . Account.CharacterClass
        If (Account.Nickname && Account.Nickname != "")
            title = % title . A_Space . "(" . Account.Nickname . ")"
        
        winId := this.pid
        WinSetTitle, ahk_pid %winId%,, %title%
        this.fullTitle := title
    }
}