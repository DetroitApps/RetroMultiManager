;=============================================
; Profiles
;=============================================

Gui, Tab, 2

Gui, Font,              Bold s10
Gui, Add, Text,         , % Translate("Profiles")
Gui, Font,              Normal s8

Gui, Add, Text,         y+10 h20 0x200, % Translate("Profile")
Gui, Add, DropDownList, x+10 vSelectProfile w50, 1||2|3|4|5|6|7|8|9
Gui, Add, Button,       x+10 gGui_LoadProfile, % Translate("Load")
Gui, Add, Button,       x+10 gGui_ClearAccountData, % Translate("ClearAll")

;Input fields
Gui, Font,              Bold s9
Gui, Add, Text,         x92 y+10 h20 0x200 w100, % Translate("Username")
Gui, Add, Text,         x+10 h20 0x200 w100, % Translate("Password")
Gui, Add, Text,         x+25 h20 0x200 w50, % Translate("Server")
Gui, Add, Text,         x+5 h20 0x200 w50, % Translate("Player")
Gui, Add, Text,         x+10 h20 0x200 w80, % Translate("Nickname")
Gui, Add, Text,         x+10 h20 0x200 w80, % Translate("Class")
Gui, Add, Text,         x+10 h20 0x200 w50, % Translate("Initiative")
Gui, Font,              Normal s8

Loop 12 {
    ;ID
    Gui, Font,          Bold
    Gui, Add, Text,     x40 y+5 h20 w20 0x200, [%A_Index%]
    Gui, Font,          Normal

    ;Active
    Gui, Add, CheckBox, x+5 vCheckActive%A_Index% h20 0x200 Checked 1
    ;Username
    Gui, Add, Edit,     hp r1 x+0 w100 vInputUsername%A_Index% gGui_ToggleModifications
    
    ;Password
    Gui, Add, Edit,     Password hp r1 x+10 w100 vInputPassword%A_Index% gGui_ToggleModifications
    Gui, Add, Button,   gGui_RevealPassword%A_Index% x+1 w5, 👁

    ;Slots
    Gui, Add, DropDownList, x+5 w50 vSelectServerSlot%A_Index% gGui_ToggleModifications, 1||2|3|4|5
    Gui, Add, DropDownList, x+5 w50 vSelectPlayerSlot%A_Index% gGui_ToggleModifications, 1||2|3|4|5

    ;Nickname
    Gui, Add, Edit,     hp r1 x+10 w80 vInputNickname%A_Index% gGui_ToggleModifications

    ;Class
    Gui, Add, DropDownList, x+10 w80 vSelectClass%A_Index% gGui_ToggleModifications, Cra|Ecaflip|Eniripsa|Enutrof|Feca|Iop|Osamodas|Pandawa|Sacrieur|Sadida|Sram|Xelor

    ;Initiative
    Gui, Add, Edit,     hp r1 x+10 w50 vInputInitiative%A_Index% gGui_ToggleModifications
    
    ;Order
    Gui, Add, Button,   gGui_MoveAccountUp%A_Index% x+5, ↑
    Gui, Add, Button,   gGui_MoveAccountDown%A_Index% x+1, ↓
}

Gui, Font,              Bold s10
Gui, Add, Button,       y+10 x40 w100 gGui_SaveProfile, % Translate("Save")
Gui, Font,              Normal s8
Gui, Add, CheckBox,     x+10 vCheckDefaultProfile h25 0x200, % Translate("DefaultProfile")