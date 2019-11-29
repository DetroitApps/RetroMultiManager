/*
    API for scenarios
*/

Global CurrentScenario := 0

Class API {
    #Include src\class\API\scenario.ahk
    #Include src\class\API\window.ahk

    Debug := False
    CurrentWindow := 1
    WindowList := []

    __New(){
        this.LoadScenarios()
    }

    LoadScenarios(){
        directory := A_ScriptDir . "\Scenarios\"
        GuiControl, , SelectScenario, |
        Loop, %directory%*.ahk
        {
            scenarioName := StrSplit(A_LoopFileName, ".")[1]
            Logger.Write("I'm alive!",,scenarioName)
            ;Menu bar
            Menu, ScenariosMenu, Add,   %scenarioName%, %scenarioName%
            Menu, MyMenuBar, Add,       Scenarios, :ScenariosMenu
            Gui, Menu,                  MyMenuBar
            ;Scenario select
            GuiControl, , SelectScenario, %scenarioName%
        }
    }

    GuiUpdateProgressText(content){
        If (Settings.GuiStatus = True) {
            SB_UpdateText(content)
        }
    }

    GuiUpdateProgressBar(step, totalSteps := 0)
    {
        If (Settings.GuiStatus = True) {
            If (totalSteps = 0)
                SB_UpdateBar(step)
            Else
            {
                progress := (step = totalSteps) ? 100 : step * Round(100 / totalSteps)
                SB_UpdateBar(progress)
            }
        }
    }

    SetDebug(ByRef mode)
    {
        this.Debug := (mode = True) ? True : False
    }

    ClearWindowList(){
        WindowList := []
        /*
        Loop, GetNbAccounts() {
            this.getWindow(A_Index) := {}
        }
        */
    }

    CloseWindow(id)
    {
        windowHwnd := this.getWindow(id).hwnd
        WinClose, ahk_id %windowHwnd%
    }

    LogWrite(ByRef content, ByRef type := 0)
    {
        Logger.Write(content, type, CurrentScenario.Title)
    }

    ;Simple getters
    GetNbActiveAccounts() {
        count := 0
        Loop, % this.GetNbAccounts() {
            If ArrayAccounts[A_Index].IsActive
                count++
        }
        return count
    }

    GetNbAccounts() {
        return ArrayAccounts.MaxIndex()
    }

    GetNbWindows() {
        return this.WindowList.MaxIndex()
    }

    NewWindow(hwnd, account) {
        index := (this.WindowList.MaxIndex() > 0) ? this.WindowList.MaxIndex() + 1 : 1
        window := New this.Window(this, hwnd, account, index)
        this.WindowList[index] := window
        Logger.Write("Creating window #" index " with hwnd '" hwnd "'.")
        return window
    }

    /*SaveWindow(hwnd, id){
        ArrayAccounts[id].Window := New this.Window(this, hwnd, id)
        Logger.Write("Saving window #" id " with hwnd '" this.getWindow(id).hwnd "' for account '" this.GetUsername(id) "'.")
        this.CurrentWindow := id
        return ArrayAccounts[id].Window
    }
    */

    AddWindowToListView(id){
        window := this.WindowList[id]
        LV_Add("", window.account.username, window.title, id, window.hwnd)
        LV_ModifyCol()
    }

    GetWindow(id){
        return this.WindowList[id]
    }

/*
    GetUsername(hwnd) {
        return ArrayAccounts[hwnd].Username
    }

    GetPassword(hwnd) {
        return ArrayAccounts[hwnd].Password
    }
*/
}