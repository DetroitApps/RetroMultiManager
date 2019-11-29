/*
    Scenario: Reorganize windows according to initiative 
*/

OrderWindowList() {
    tempWindowList := API.WindowList.Clone()
    orderedWindowList := {}

    While (tempWindowList.Length() != 0) 
    {
        maxInitiativeIndex := -1
        Loop, % tempWindowList.Length() 
        {
            If (tempWindowList[A_Index].account.initiative > tempWindowList[maxInitiativeIndex].account.initiative) 
                maxInitiativeIndex := A_Index
        }
        API.LogWrite("Maximum initiative is " tempWindowList[maxInitiativeIndex].title " with " tempWindowList[maxInitiativeIndex].account.initiative "initiative.")
        orderedWindowList.Push(tempWindowList[maxInitiativeIndex])
        tempWindowList.RemoveAt(maxInitiativeIndex)
    }
    return orderedWindowList
}

OrganizeTaskbar() {
    Loop % API.GetNbWindows()
    {
        window := API.WindowList[A_Index]
        window.SetTitle()
        WinHide, % "ahk_id " window.hwnd
        Sleep 50
    }
    Loop % API.GetNbWindows()
    {
        window := API.WindowList[A_Index]
        WinShow, % "ahk_id " window.hwnd
        Sleep 50
    }
}

Main:
    index := 1
    Loop, % API.GetNbWindows()
    {
        window := API.GetWindow(index)
        If Not WinExist("ahk_id " window.hwnd)
        {
            API.LogWrite("Windows " window.hwnd " has been closed, deleting from list.")
            API.DeleteWindow(index)
            index--
        }
        index++
    }

    orderedWindowList := OrderWindowList()
    API.UpdateWindowList(orderedWindowList)
    OrganizeTaskbar()
    API.RefreshWindowsListView()
return