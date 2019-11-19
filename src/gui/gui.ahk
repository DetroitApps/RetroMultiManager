/*
    Gui main file
*/

#Include src\lib\SB.ahk
#Include src\functions\gui-functions.ahk
#Include src\gui\gui-style.ahk

;----------------------------------------
;GUI
;----------------------------------------

;MENU BAR
;File
Menu, FileMenu, Add,        % Translate("CloseGui") "`t" Translate("Escape"), Gui_CloseGui
Menu, FileMenu, Add,        % Translate("ReloadScript") "`tCtrl+R", Gui_ReloadScript
Menu, FileMenu, Add,        % Translate("Quit") "`tShift+F12", TestMsg
Menu, MyMenuBar, Add,       % Translate("File"), :FileMenu

;Scenarios
Menu, ScenariosMenu, Add,   % Translate("MergeAndReload"), MergeScenarios
Menu, ScenariosMenu, Add
Menu, MyMenuBar, Add,       % Translate("Scenarios"), :ScenariosMenu

/*;Tools
Menu, ToolsMenu, Add,       
Menu, ToolsMenu, Add,       
Menu, MyMenuBar, Add,       % Translate("Tools"), :ToolsMenu
*/

;Language
Menu, LanguageMenu, Add,    en-US, Gui_SetLanguageEN
Menu, LanguageMenu, Add,    fr-FR, Gui_SetLanguageFR
Menu, MyMenuBar, Add,       Language, :LanguageMenu

;Settings
Menu, SettingsMenu, Add,    Debug, Gui_SetDebugMode
If Settings.Debug
    Menu, SettingsMenu, Check,  Debug
Menu, MyMenuBar, Add,       % Translate("Settings"), :SettingsMenu

;About
Menu, AboutMenu, Add,       % Translate("VisitGithub"), VisitGithub
Menu, MyMenuBar, Add,       ?, :AboutMenu
Gui, Menu,                  MyMenuBar

;HEADER
Gui, Font,              cBlack s16
Sleep, 500
Gui, Add, Text,         w%guiWidth% y10 center, % Settings.TitleApp . A_Space . "v" Settings.version
Gui, Font,              s8
Gui, Add, Text,         w%guiWidth% y+1 center, % Translate("For") " Dofus Retro 1.3.0"

;SCRIPT SETTINGS
Gui, Font,              Bold
Gui, Add, GroupBox,     xm ym+10 y+10 Section w%groupboxWidth% h120, % Translate("Settings")
Gui, Font,              Normal
;Dofus path
Gui, Add, Text,         xs+10 ys+30 %guiLabelOptions%, Dofus.exe
Gui, Add, Edit,         hp r1 x+10 w550 vInputDofusPath
Gui, Add, Button,       x+10 w80 gGui_Browse, % Translate("Browse")

;Speed
Gui, Add, Text,         xs+10 ys+60 %guiLabelOptions%, % Translate("Speed")
Gui, Add, DropDownList, x+10 AltSubmit vSelectSpeed gGui_ChangeSpeed, % Translate("SpeedFastest") "|" Translate("SpeedFaster") "|" Translate("SpeedNormal") "||" Translate("SpeedSlower") "|" Translate("SpeedSlowest")
Gui, Add, CheckBox,     x+10 gGui_WaitForAnkamaShield vCheckWaitForAnkamaShield h20 0x200, % Translate("WaitForAnkamaShield")


;Updates
Gui, Add, Text,         ys+90 xs+10 %guiLabelOptions%, % Translate("Program")
Gui, Add, Button,       x+10 gGui_CheckForUpdates, % Translate("CheckForUpdates")
Gui, Add, CheckBox,     x+10 vCheckCheckUpdateOnStart gGui_ToggleCheckUpdateOnStart h20 0x200, % Translate("CheckOnStart")

;ACCOUNTS
Gui, Font,              Bold
Gui, Add, GroupBox,     xm ym+10 y+20 Section w%groupboxWidth% h320, % Translate("Accounts")
Gui, Font,              Normal


Gui, Add, Text,         xs+10 ys+30 h20 0x200, % Translate("Profile")
Gui, Add, DropDownList, x+10 vSelectProfile w50, 1||2|3|4|5
Gui, Add, Button,       x+10 gGui_LoadProfile, % Translate("Load")
Gui, Add, Button,       x+10 gGui_SaveProfile, % Translate("Save")
Gui, Add, CheckBox,     x+10 vCheckEncryption h20 0x200 Checked 1, % Translate("EncryptAccounts")
Gui, Add, CheckBox,     x+10 vCheckDefaultProfile h20 0x200, % Translate("DefaultProfile")
Gui, Add, Button,       x+10 gGui_ClearAccountData, % Translate("ClearAll")

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
    Gui, Add, Text,     x+5 h20 0x200 w50, % Translate("Username")
    Gui, Add, Edit,     hp r1 x+10 w100 vInputUsername%A_Index%
    ;Password
    Gui, Add, Text,     x+10 h20 0x200 w70, % Translate("Password")
    Gui, Add, Edit,     Password hp r1 x+10 w100 vInputPassword%A_Index%
    Gui, Add, Button,   gGui_RevealPassword%A_Index% x+1, 👁
    ;Nickname
    Gui, Add, Text,     x+10 h20 0x200 w50, % Translate("Nickname")
    Gui, Add, Edit,     hp r1 x+10 w100 vInputNickname%A_Index%
    ;Nickname
    Gui, Add, Text,     x+10 h20 0x200 w40, % Translate("Initiative")
    Gui, Add, Edit,     hp r1 x+10 w50 vInputInitiative%A_Index%
    ;Class
    Gui, Add, DropDownList, x+10 vSelectClass%A_Index% w80, Cra|Ecaflip|Eniripsa|Enutrof|Feca|Iop|Osamodas|Pandawa|Sacrieur|Sadida|Sram|Xelor
    
    Gui, Add, DropDownList, x+1 vSelectServerSlot%A_Index% w30, 1||2|3|4|5
    Gui, Add, DropDownList, x+5 vSelectPlayerSlot%A_Index% w30, 1||2|3|4|5

    Gui, Add, Button,   gGui_MoveAccountUp%A_Index% x+5, ↑
    Gui, Add, Button,   gGui_MoveAccountDown%A_Index% x+1, ↓
    
    start_y += 30
}
start_y += 10

;Scenarios
Gui, Font,              Bold
Gui, Add, GroupBox,     xm ym+10 y+20 Section w%groupboxWidth% h120, % Translate("Scenarios")
Gui, Font,              Normal s10

Gui, Add, Button,       ys+30 xs+10 gGui_1Click2Play, % "1 Click 2 Play"
Gui, Add, Button,       x+10 gGui_OpenDofus, % "[" GetHotkeyForScenario("OpenDofusInstances") "] " Translate("StartDofus")
Gui, Add, Button,       x+10 gGui_LoginAccounts, % "[" GetHotkeyForScenario("LoginAccounts") "] " Translate("LoginAccounts")
Gui, Add, Button,       x+10 gGui_ConnectPlayersOnServer, % "[" GetHotkeyForScenario("ConnectPlayersOnServer") "] " Translate("ConnectPlayersOnServer")
Gui, Add, Button,       x+10 gGui_CloseDofus, % "[" GetHotkeyForScenario("CloseDofusInstances") "] " Translate("CloseDofusInstances")

Gui, Font,              Bold
Gui, Add, Text,         ys+60 xs+10, % Translate("OtherHotkeys")
Gui, Font,              Normal s10

Gui, Add, Text,         ys+80 xs+10, % "² :`t" Translate("Cycle")
Gui, Add, Text,         ys+100 xs+10, % "Shitft+² :`t" Translate("CycleBackwards")

Gui, Font,              s8

/*
Gui, Add, Text,         ys+80 xs+10 h20 0x200, % Translate("AllScenarios")
Gui, Add, DropDownList, ys+100 xs+10 0x200 vSelectScenario
Gui, Add, Button,       x+10 gGui_RunScenario, % Translate("Run")
Gui, Add, Button,       x+5 gGui_LoadScenarios, % Translate("Reload")
*/
;STATUS BAR
Gui, Add, StatusBar

TitleBar := Settings.TitleApp . A_Space . Settings.version
Gui, Show,              w%guiWidth% h%guiHeight%, %TitleBar%
TitleBar := ""

SB_SetParts(300,300,100)
barPartId := 1
textPartId := 2

hwnd := SB_SetProgress(0, barPartId)

;Status bar quick functions

SB_UpdateText(Translate("AliveMsg", Settings.TitleApp))

;LABELS INCLUDED FROM MAIN FILE