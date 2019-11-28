/*
    Gui functions
*/

SB_UpdateText(content){
    global
    SB_SetText(content, textPartId)
}

SB_UpdateBar(value){
    global
    SB_SetProgress(value, barPartId)
}

GetHotkeyForScenario(labelName){
    global

    For Key, Value in Settings.Hotkeys {
        If (Value = labelName)
            return Key
    }
}

RevealPassword(inputId){
    static PasswordRevealToggler := []
    
    id := SubStr(inputId, 0), id += 0
    If (PasswordRevealToggler[id] = 1)
    {
        GuiControl, +Password, %inputId%
        PasswordRevealToggler[id] := 0
    }
    Else
    {
        GuiControl, -Password, %inputId%
        PasswordRevealToggler[id] := 1
    }
    Gui, Submit, NoHide
}

WriteAccountLine(account, id){
    GuiControl,,CheckActive%id%, % account.IsActive
    GuiControl,,InputUsername%id%, % account.Username
    GuiControl,,InputPassword%id%, % account.Password
    GuiControl,,InputNickname%id%, % account.Nickname
    GuiControl,,InputInitiative%id%, % account.Initiative
    GuiControl, Choose,SelectServerSlot%id%, % account.ServerSlot
    GuiControl, Choose,SelectPlayerSlot%id%, % account.PlayerSlot
    If(account.CharacterClass = "")
        GuiControl, Choose, SelectClass%id%, 0
    Else
        GuiControl, ChooseString, SelectClass%id%, % account.CharacterClass
}

MoveAccountOrder(originId, direction){
    Gui, Submit, NoHide
    accountOrigin := New Account(InputUsername%originId%
                                ,InputPassword%originId%
                                ,InputNickname%originId%
                                ,InputInitiative%originId%
                                ,SelectClass%originId%
                                ,CheckActive%originId%
                                ,SelectServerSlot%originId%
                                ,SelectPlayerSlot%originId%)
    destId := originId
    destId += direction = 1 ? 1 : -1
    accountDest := New Account(InputUsername%destId%
                                ,InputPassword%destId%
                                ,InputNickname%destId%
                                ,InputInitiative%destId%
                                ,SelectClass%destId%
                                ,CheckActive%destId%
                                ,SelectServerSlot%destId%
                                ,SelectPlayerSlot%destId%)
    WriteAccountLine(accountOrigin, direction = 1 ? originId + 1 : originId - 1)
    WriteAccountLine(accountDest, originId)
}