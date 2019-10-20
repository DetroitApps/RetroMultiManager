/*
    API for scenarios
*/

Class API {
    Debug := False
    WindowList := []

    __New(){   
    }

    SetDebug(ByRef mode) {
        this.Debug := (mode = True) ? True : False
    }

    ClearWindowList(){
        this.WindowList := []
    }

    CloseWindow(id){
        windowId := this.WindowList[id].pid
        WinClose, ahk_pid %windowId%
    }

    ResetWindowsIndex(){
        New this.Window(0) ;highjack to reset index
    }

    SearchImageInWindow(imageName, ByRef outputX, ByRef outputY)
    {
        folder := "Resources\" . A_ScreenHeight . "p\"
        OCR_GetPositionFromImage(folder . imageName, outputX, outputY)
    }

    ;Simple getters
    GetTotalAccounts() {
        return ArrayAccounts.MaxIndex()
    }

    GetWindow(id){
        return this.WindowList[id]
    }

    GetTotalWindows() {
        return this.WindowList.MaxIndex()
    }

    GetUsername(id) {
        return ArrayAccounts[id].Username
    }

    GetPassword(id) {
        return ArrayAccounts[id].Password
    }

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
}