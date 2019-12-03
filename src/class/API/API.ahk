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

    SetWindowList(newList){
        this.WindowList := newList
        this.RefreshWindowsIndex()
    }

    CheckCurrentWindow(){
        If WinActive("ahk_id " this.GetWindow(this.CurrentWindow).hwnd)
            return
        Loop, % this.GetNbWindows() {
            If WinActive("ahk_id " this.GetWindow(A_Index).hwnd)
            {
                this.CurrentWindow := A_Index
                return
            }
        }
        this.CurrentWindow := 1
    }

    LinkWindow(id) {
        window := this.GetWindow(id)
        window.isLinked := !window.isLinked
        
        tempList := []
        tempListUnlinked := []
        Loop, % this.GetNbWindows()
        {
            If (this.WindowList[A_Index].isLinked = True)
                tempList.Push(this.WindowList[A_Index])
            Else
                tempListUnlinked.Push(this.WindowList[A_Index])
        }
        Loop, % tempListUnlinked.MaxIndex()
            tempList.Push(tempListUnlinked[A_Index])
        this.SetWindowList(tempList)
        this.RefreshWindows()
    }

    ;Update linked accounts on windows
    UpdateWindowsAccount() {
        Logger.Write("Starting an update of windows linked accounts.")
        Loop, % this.GetNbWindows() {
            window := this.GetWindow(A_Index)
            Loop, % this.GetNbAccounts() {
                If (window.account.username <> ArrayAccounts[A_Index].username)
                    Continue
                Else {
                    Logger.Write("- Found a match with window " window.id " and account " A_Index)
                    window.account := ArrayAccounts[A_Index]
                    Break
                }
            } 
        }
    }

    ClearWindowList(){
        WindowList := []
        LV_Delete()
    }

    ;If a window exists for an account, return the corresponding window index, otherwise -1
    WindowExists(ByRef account)
    {
        Loop, % this.GetNbWindows() 
            If (this.GetWindow(A_Index).account.username = account.username)
                return A_Index
        return -1
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

    GetNbAccounts() {
        return ArrayAccounts.MaxIndex()
    }

    GetNbActiveAccounts() {
        count := 0
        Loop, % this.GetNbAccounts() {
            If ArrayAccounts[A_Index].IsActive
                count++
        }
        return count
    }

    GetWindow(id){
        return this.WindowList[id]
    }

    GetLinkedWindowList(){
        tempList := {}
        Loop, % this.GetNbWindows()
        {
            window := this.GetWindow(A_Index)
            If (window.isLinked = True)
                tempList.Push(this.WindowList[A_Index])
        }
        return tempList
    }

    GetUnlinkedWindowList(){
        tempList := {}
        Loop, % this.GetNbWindows()
        {
            window := this.GetWindow(A_Index)
            If (window.isLinked = False)
                tempList.Push(this.WindowList[A_Index])
        }
        return tempList
    }

    GetNbWindows() {
        return this.WindowList.MaxIndex()
    }

    GetNbLinkedWindows() {
        count := 0
        Loop, % this.GetNbWindows() {
            If (this.WindowList[A_Index].IsLinked = True)
                count++
        }
        return count
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
            If (Settings.Dev)
            {
                Menu, ScenariosMenu, Add,   %scenarioName%, %scenarioName%
                Menu, MyMenuBar, Add,       Scenarios, :ScenariosMenu
                Gui, Menu,                  MyMenuBar
            }
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