/*
    Scenario: Reorganize windows according to initiative 
*/

Main:
    tempAccounts := ArrayAccounts.Clone()
    orderedAccounts := []
    accountsToRemove := []
    
    ;Look for closed windows
    Loop % tempAccounts.Length() {
        API.LogWrite("tempAccounts[" A_Index "].Window.hwnd : " tempAccounts[A_Index].Window.hwnd)
        If Not WinExist("ahk_id " . tempAccounts[A_Index].Window.hwnd) {
            accountsToRemove.Push(A_Index)
        }
    }

    ;Supress closed account
    Loop % accountsToRemove.Length() {
        index := accountsToRemove[A_Index]
        API.LogWrite("Le fenetre du compte '" tempAccounts[index].Nickname "' a disparu, suppression dans la gestion de fenètre")
        tempAccounts.RemoveAt(index)
    }

    ;Selection sort by initiative
    While (tempAccounts.Length() != 0) {
        maxInitiativeIndex := -1
        Loop % tempAccounts.Length() {
            If (tempAccounts[A_Index].Initiative > tempAccounts[maxInitiativeIndex].Initiative) {
                maxInitiativeIndex := A_Index
            }
        }
        API.LogWrite("L'initiative la plus haute est celle du compte #" maxInitiativeIndex " :" tempAccounts[maxInitiativeIndex].Nickname)
        orderedAccounts.Push(tempAccounts[maxInitiativeIndex])
        tempAccounts.RemoveAt(maxInitiativeIndex)
    }
    
    ; Set new windows Title + debug
    API.LogWrite("L'initiative dans l'ordre :")
    Loop % orderedAccounts.Length() {
        API.LogWrite(A_Index ": " orderedAccounts[A_Index].Nickname)
        orderedAccounts[A_Index].Window.id := A_Index
        orderedAccounts[A_Index].Window.setTitle(orderedAccounts[A_Index], A_Index)
    }
    ArrayAccounts := orderedAccounts
return