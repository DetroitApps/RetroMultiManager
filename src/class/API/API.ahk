/*
    API for scenarios
*/

Global CurrentScenario := 0

Class API {
    #Include src\class\API\scenario.ahk
    #Include src\class\API\window.ahk

    Debug := False
    WindowList := []
    CurrentWindow := 1 ;Focused windows
    SelectedWindow := 0 ;Selected window in list view

    __New(){
        this.LoadScenarios()
    }

    ;========================
    ; Window methods
    ;========================

    NewWindow(hwnd, account) {
        index := (this.WindowList.MaxIndex() > 0) ? this.WindowList.MaxIndex() + 1 : 1
        window := New this.Window(this, hwnd, account, index)
        this.WindowList[index] := window
        Logger.Write("Creating window #" index " with hwnd '" hwnd "'.")
        return window
    }

    CloseWindow(id)
    {
        windowHwnd := this.GetWindow(id).hwnd
        WinClose, ahk_id %windowHwnd%
        this.DeleteWindow(id)
    }

    DeleteWindow(id) {
        this.WindowList.RemoveAt(id)
        this.RefreshWindowsIndex()
        this.CurrentWindow := 1
    }

    DeleteClosedWindows() {
        index := 1
        Loop, % this.GetNbWindows()
        {
            window := this.GetWindow(index)
            If Not WinExist("ahk_id " window.hwnd)
            {
                this.LogWrite("Windows " window.hwnd " has been closed, deleting from list.")
                this.DeleteWindow(index)
                index--
            }
            index++
        }
    }

    OrganizeTaskbar() {
        Loop, % this.GetNbWindows()
        {
            window := this.WindowList[A_Index]
            window.SetTitle()
            WinHide, % "ahk_id " window.hwnd
            Sleep 50
        }
        Loop, % API.GetNbWindows()
        {
            window := this.WindowList[A_Index]
            WinShow, % "ahk_id " window.hwnd
            Sleep 50
        }
    }

    RefreshWindows() {
        this.DeleteClosedWindows()
        this.OrganizeTaskbar()
        this.RefreshWindowsListView()
    }

    RefreshWindowsIndex(){
        Loop, % this.GetNbWindows() {
            this.WindowList[A_Index].id := A_Index
        }
    }

    UpdateWindowList(newList){
        this.WindowList := newList
        this.RefreshWindowsIndex()
    }

    ClearWindowList(){
        WindowList := []
    }

    ;========================
    ; Windows ListView
    ;========================

    RefreshWindowsListView(){
        LV_Delete()
        Loop, % this.GetNbWindows() {
            window := this.WindowList[A_Index]
            LV_Add("", window.id, window.account.username, window.title, (window.isLinked = True) ? Translate("Yes") : Translate("No"))
        }
        LV_ModifyCol()
    }

    AddWindowToListView(id){
        window := this.WindowList[id]
        LV_Add("", id, window.account.username, window.title, (window.isLinked = True) ? Translate("Yes") : Translate("No"))
        LV_ModifyCol()
    }
    
    RemoveWindowFromListView(id){

    }

    ;========================
    ; Simple getters
    ;========================

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

    GetWindow(id){
        return this.WindowList[id]
    }

    ;========================
    ; Misc
    ;========================

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

    LogWrite(ByRef content, ByRef type := 0)
    {
        Logger.Write(content, type, CurrentScenario.Title)
    }
}