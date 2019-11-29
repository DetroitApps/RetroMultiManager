/*
    Scenario: Reorganize windows according to initiative 
*/

OrderWindowListWithInitiative() {
    tempWindowList := API.GetLinkedWindowList()
    orderedWindowList := {}

    While (tempWindowList.Length() != 0) 
    {
        maxInitiativeIndex := -1
        Loop, % tempWindowList.Length() 
        {
            If (tempWindowList[A_Index].account.initiative > tempWindowList[maxInitiativeIndex].account.initiative) 
                maxInitiativeIndex := A_Index
        }
        API.LogWrite("Maximum initiative is " tempWindowList[maxInitiativeIndex].title " with " tempWindowList[maxInitiativeIndex].account.initiative " initiative.")
        orderedWindowList.Push(tempWindowList[maxInitiativeIndex])
        tempWindowList.RemoveAt(maxInitiativeIndex)
    }

    unlinkedList := API.GetUnlinkedWindowList()
    Loop, % unlinkedList.MaxIndex()
        orderedWindowList.Push(unlinkedList[A_Index])
    return orderedWindowList
}

Main:
    API.DeleteClosedWindows()
    orderedWindowList := OrderWindowListWithInitiative()
    API.SetWindowList(orderedWindowList)
    API.OrganizeTaskbar()
    API.RefreshWindowsListView()
return