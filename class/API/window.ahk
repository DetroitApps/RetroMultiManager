Class Window {
    __New(_pid){
        static idIndex := 1
        if (_pid = 0)
        {
            idIndex = 1
            return
        }
        this.pid := _pid
        this.id := idIndex++
        this.fullTitle := ""
    }

    WaitOpen(){
        waitForId := this.pid
        WinWait, ahk_pid %waitForId%
    }

    Activate(){
        windowId := this.pid
        WinActivate, ahk_pid %windowId%
        WinWaitActive, ahk_pid %windowId%
    }

    Maximize(){
        windowId := this.pid
        WinMaximize, ahk_pid %windowId%
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