/*
    API for scenarios
*/

Global CurrentScenario := 0

Class API {
    #Include src\class\API\scenario.ahk
    #Include src\class\API\window.ahk

    Debug := False
    CurrentWindow := 1

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
        Loop, GetTotalAccounts() {
            this.getWindow(A_Index) := {}
        }
        
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
    GetTotalAccounts() {
        return ArrayAccounts.MaxIndex()
    }

    SaveWindow(hwnd, id){
        ArrayAccounts[id].Window := New this.Window(this, hwnd, id)
        Logger.Write("Saving window #" id " with hwnd '" this.getWindow(id).hwnd "' for account '" this.GetUsername(id) "'.")
        return ArrayAccounts[id].Window
    }

    GetWindow(id){
        return ArrayAccounts[id].Window
    }

    GetUsername(hwnd) {
        return ArrayAccounts[hwnd].Username
    }

    GetPassword(hwnd) {
        return ArrayAccounts[hwnd].Password
    }
}