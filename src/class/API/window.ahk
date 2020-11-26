Class Window {
    __New(parent, hwnd, account, id){
        this.hwnd := hwnd
        this.id := id
        this.title := ""
        this.account := account
        this.parent := parent
        this.isLinked := True
        this.isConnected := False
    }

    Activate(){
        Logger.Write("Activating window #" this.id " (hwnd '" this.hwnd "').")
        If WinExist("ahk_id " . this.hwnd)
            WinActivate
        Else
            Logger.Write("HWND not found : '" this.hwnd "'", 2)
        If (this.hwnd = "")
            Logger.Write("Window HWND is not a valid ID : '" this.hwnd "'", 2)
        this.parent.CurrentWindow := this.id
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

    Minimize(){
        WinMinimize, % "ahk_id " this.hwnd
    }

    SetTitle(){
        If (this.hwnd = "")
            Logger.Write("Window HWND is not a valid ID : '" this.hwnd "'", 2)
        title := ""
        If (this.isLinked = True)
        title := title "[" this.id . "]" A_Space
        If (this.account.CharacterClass && this.account.CharacterClass != "")
            title = % title . this.account.CharacterClass
        If (this.account.Nickname && this.account.Nickname != "")
            title = % title . A_Space . "(" . this.account.Nickname . ")"
        Logger.Write("Setting title '" title "'for window # " this.id " (hwnd '" this.hwnd "').")
        WinSetTitle, % "ahk_id " this.hwnd,, %title%
        this.title := title
    }
}