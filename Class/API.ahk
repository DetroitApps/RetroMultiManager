;API for scenarios

Class API {
    Debug := False
    WindowList := []

    __New(){   
    }

    SetDebug(ByRef mode) {
        this.Debug := (mode = True) ? True : False
    }

    ;Simple getters
    GetNbAccounts() {
        return ArrayAccounts.MaxIndex()
    }

    Class Window {
        __New(_pid){
            static idIndex := 1
            this.pid := _pid
            this.id := idIndex++
            this.fullTitle := ""
        }

        WaitOpen(){
            waitForId := this.pid
            WinWait, ahk_pid %waitForId%
        }

        SetTitle(Byref Account){
            this.fullTitle := value
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
}