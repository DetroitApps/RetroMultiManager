/*
    Scenario: Reorganize windows according to initiative 
*/

Main:
    tempAccounts := ArrayAccounts.Clone()
    orderedAccounts := []
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
        orderedAccounts[A_Index].Window.setTitle(orderedAccounts[A_Index], A_Index)
    }
    ArrayAccounts := orderedAccounts
return