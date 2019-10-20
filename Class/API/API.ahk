/*
    API for scenarios
*/

Global CurrentScenario := 0

Class API {
    #Include Class\API\Scenario.ahk
    #Include Class\API\Window.ahk

    Debug := False
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
            ;Menu bar
            Menu, ScenariosMenu, Add,   &%scenarioName%, %scenarioName%
            Menu, MyMenuBar, Add,       &Scenarios, :ScenariosMenu
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
        this.WindowList := []
    }

    CloseWindow(id)
    {
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

    LogWrite(ByRef content)
    {
        Logger.Write("[Scenario " . CurrentScenario.Title . "] " . content)
    }

    LogWriteError(ByRef content, type := 0)
    {
        Logger.WriteError("[Scenario " . CurrentScenario.Title . "] ", type)
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
}