/*
    Gui main file
*/

#Include Library\SB.ahk
#include Gui\GuiStyle.ahk
#Include Gui\GuiFunctions.ahk

;----------------------------------------
;GUI
;----------------------------------------

;Header
Gui, Font,              cBlack s16
Gui, Add, Text,         w%guiWidth% y10 center, Retro Multi Manager
Gui, Font,              s8
Gui, Add, Text,         w%guiWidth% y+1 center, For Dofus Retro 1.3.0

;SCRIPT SETTINGS
Gui, Font,              Bold
Gui, Add, GroupBox,     xm ym+10 y+10 Section w%groupboxWidth% h120, Settings
Gui, Font,              Normal
;Dofus path
Gui, Add, Text,         xs+10 ys+30 %guiLabelOptions%, Dofus.exe
Gui, Add, Edit,         hp r1 x+10 w450 vInputDofusPath, C:\path ;hardcode
Gui, Add, Button,       x+10 w80 gBrowse, Browse

;Speed
Gui, Add, Text,         xs+10 ys+60 %guiLabelOptions%, Speed
Gui, Add, DropDownList, x+10 AltSubmit vSpeedSelection gChangeSpeed, Fastest|Faster|Normal||Slower|Slowest

;Updates
Gui, Add, Text,         ys+90 xs+10 %guiLabelOptions%, Program
Gui, Add, Button,       x+10 gGuiCheckForUpdates, Check for updates
Gui, Add, CheckBox,     x+10 vCheckCheckUpdateOnStart gGuiToggleCheckUpdateOnStart h20 0x200, Check on start

;ACCOUNTS
Gui, Font,              Bold
Gui, Add, GroupBox,     xm ym+10 y+20 Section w%groupboxWidth% h320, Accounts
Gui, Font,              Normal

Gui, Add, Text,         xs+10 ys+30 h20 0x200, Profile
Gui, Add, DropDownList, x+10 vProfileSelection w50, 1||2|3|4|5
Gui, Add, Button,       x+10 gGuiLoadProfile, Load
Gui, Add, Button,       x+10 gGuiSaveProfile, Save
Gui, Add, CheckBox,     x+10 vCheckPasswordEncryption h20 0x200 Checked 1, Encrypt password
Gui, Add, CheckBox,     x+10 vCheckDefaultProfile h20 0x200, Default profile
Gui, Add, Button,       x+10 gGuiClearAccountsData, Clear all

;Input fields
start_y := 70
Loop 8 {
    ;ID
    Gui, Font,          Bold
    Gui, Add, Text,     ys+%start_y% xs+10 h20 0x200, [%A_Index%]
    Gui, Font,          Normal

    ;Active
    Gui, Add, CheckBox, x+5 vCheckActive%A_Index% h20 0x200 Checked 1
    ;Username
    Gui, Add, Text,     x+10 h20 0x200 w60, Username
    Gui, Add, Edit,     hp r1 x+10 w100 vInputUsername%A_Index%
    ;Password
    Gui, Add, Text,     x+10 h20 0x200 w60, Password
    Gui, Add, Edit,     Password hp r1 x+10 w100 vInputPassword%A_Index%
    Gui, Add, Button,   gRevealPassword%A_Index% x+1, 👁
    ;Nickname
    Gui, Add, Text,     x+10 h20 0x200 w60, Nickname
    Gui, Add, Edit,     hp r1 x+10 w100 vInputNickname%A_Index%
    ;Class
    Gui, Add, DropDownList, x+10 vSelectClass%A_Index% w80, Cra|Ecaflip|Eniripsa|Enutrof|Feca|Iop|Osamodas|Pandawa|Sacrieur|Sadida|Sram|Xelor
    
    Gui, Add, Button,   gMoveAccountUp%A_Index% x+1, ↑
    Gui, Add, Button,   gMoveAccountDown%A_Index% x+1, ↓
    
    start_y += 30
}
start_y += 10
;Might not be implemented


;GuiControl, -Password, InputPassword1

;Scenarios
Gui, Font,              Bold
Gui, Add, GroupBox,     xm ym+10 y+20 Section w%groupboxWidth% h100, Scenarios
Gui, Font,              Normal s10



h := GetShortcutKey("OpenDofusInstances")
Gui, Add, Button,       ys+30 xs+10 gGuiOpenDofus, [%h%] Start Dofus
h := GetShortcutKey("LoginAccounts")
Gui, Add, Button,       x+10 gGuiLoginAccounts, [%h%] Login accounts
h := GetShortcutKey("ConnectOnServer")
Gui, Add, Button,       x+10 gGuiConnectServers, [%h%] Connect on servers

Gui, Add, Text,         x+10 h20 0x200 w60, Custom scenarios

Gui, Font,              s8

;STATUS BAR
Gui, Add, StatusBar

Gui, Show,              w%guiWidth% h%guiHeight%, Retro Multi Manager 1.0 GUI

SB_SetParts(300,300,100)
barPartId := 1
textPartId := 2

hwnd := SB_SetProgress(0, barPartId)

;Status bar quick functions

SB_UpdateText("Retro Multi Manager is alive!")


;LABELS INCLUDED FROM MAIN FILE