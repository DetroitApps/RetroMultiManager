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

;=============================================
; Header
;=============================================

Gui, Font,              cBlack s16
Sleep, 500
Gui, Add, Text,         w%guiWidth% y10 center, % Settings.TitleApp . A_Space . "v" Settings.version
Gui, Font,              s8
Gui, Add, Text,         w%guiWidth% y+1 center, % Translate("For") " Dofus Retro 1.30.9"

Gui, Font,              s12
Gui, Add, Tab3,         h450 w750, % Translate("Home") "|" Translate("Profiles") "|" Translate("Groups") "|" Translate("Settings") "|" Translate("Hotkey")
Gui, Font,              Normal s8

;=============================================
; Home
;=============================================

Gui, Font,              Bold
Gui, Add, Text,         x40 y+10, % Translate("OtherHotkeys")
Gui, Font,              Normal s10

Gui, Add, Text,         x40 y+10, % "F1-F8 :`t`t" Translate("GoOnWindows")
Gui, Add, Text,         x40 y+10, % "> :`t`t" Translate("Cycle")
Gui, Add, Text,         x40 y+10, % "Shitft+> :`t" Translate("CycleBackwards")

Gui, Font,              s8

/*
Gui, Add, Text,         ys+80 xs+10 h20 0x200, % Translate("AllScenarios")
Gui, Add, DropDownList, ys+100 xs+10 0x200 vSelectScenario
Gui, Add, Button,       x+10 gGui_RunScenario, % Translate("Run")
Gui, Add, Button,       x+5 gGui_LoadScenarios, % Translate("Reload")
*/

;=============================================
; Profiles
;=============================================

Gui, Tab, 2

Gui, Font,              Bold
;Gui, Add, GroupBox,     xm ym+10 y+20 Section w%groupboxWidth% h320, % Translate("Accounts")
Gui, Font,              Normal


Gui, Add, Text,         h20 0x200, % Translate("Profile")
Gui, Add, DropDownList, x+10 vSelectProfile w50, 1||2|3|4|5|6|7|8|9
Gui, Add, Button,       x+10 gGui_LoadProfile, % Translate("Load")

;Input fields
Gui, Font,              Bold s9
Gui, Add, Text,         x92 y+10 h20 0x200 w100, % Translate("Username")
Gui, Add, Text,         x+10 h20 0x200 w100, % Translate("Password")
Gui, Add, Text,         x+30 h20 0x200 w100, % Translate("Nickname")
Gui, Add, Text,         x+10 h20 0x200 w70, % Translate("Class")
Gui, Add, Text,         x+10 h20 0x200 w50, % Translate("Server")
Gui, Add, Text,         x+5 h20 0x200 w50, % Translate("Player")
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
    ;Nickname
    Gui, Add, Edit,     hp r1 x+10 w100 vInputNickname%A_Index% gGui_ToggleModifications
    ;Class
    Gui, Add, DropDownList, x+10 w80 vSelectClass%A_Index% gGui_ToggleModifications, Cra|Ecaflip|Eniripsa|Enutrof|Feca|Iop|Osamodas|Pandawa|Sacrieur|Sadida|Sram|Xelor
    
    ;Slots
    Gui, Add, DropDownList, x+1 w50 vSelectServerSlot%A_Index% gGui_ToggleModifications, 1||2|3|4|5
    Gui, Add, DropDownList, x+5 w50 vSelectPlayerSlot%A_Index% gGui_ToggleModifications, 1||2|3|4|5

    ;Order
    Gui, Add, Button,   gGui_MoveAccountUp%A_Index% x+5, ↑
    Gui, Add, Button,   gGui_MoveAccountDown%A_Index% x+1, ↓

    ;Actions
    Gui, Add, Button,   x+5, ❤️
    Gui, Add, Button,   x+5, 💔
}

Gui, Font,              Bold s10
Gui, Add, Button,       y+10 x40 w100 gGui_SaveProfile, % Translate("Save")
Gui, Font,              Normal s8
; Gui, Add, CheckBox,     x+10 vCheckEncryption h20 0x200 Checked 1, % Translate("EncryptAccounts")
Gui, Add, CheckBox,     x+10 CheckDefaultProfile h25 0x200, % Translate("DefaultProfile")

;=============================================
; Groups
;=============================================

Gui, Tab, 3

Gui, Add, Text,         , To Do

;=============================================
; Settings
;=============================================

Gui, Tab, 4

Gui, Font,              Bold s10
Gui, Add, Text,         , Programme
;Gui, Add, GroupBox,     xm ym+10 y+10 Section w%groupboxWidth% h120, % Translate("Settings")
Gui, Font,              Normal s8
;Dofus path
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, Dofus.exe
Gui, Add, Edit,         hp r1 x+10 w500 vInputDofusPath
Gui, Add, Button,       x+10 w80 gGui_Browse, % Translate("Browse")

;Speed
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, % Translate("Speed")
Gui, Add, DropDownList, x+10 AltSubmit vSelectSpeed gGui_ChangeSpeed, % Translate("SpeedFastest") "|" Translate("SpeedFaster") "|" Translate("SpeedNormal") "||" Translate("SpeedSlower") "|" Translate("SpeedSlowest")
Gui, Add, CheckBox,     x+10 gGui_WaitForAnkamaShield vCheckWaitForAnkamaShield h20 0x200, % Translate("WaitForAnkamaShield")

;Updates
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, % Translate("Updates")
Gui, Add, Button,       x+10 gGui_CheckForUpdates, % Translate("CheckForUpdates")
Gui, Add, CheckBox,     x+10 vCheckCheckUpdateOnStart gGui_ToggleCheckUpdateOnStart h20 0x200, % Translate("CheckOnStart")

;=============================================
; Hotkeys
;=============================================

Gui, Tab, 5

Gui, Font,              Bold s10
Gui, Add, Text,         x40 y+10 , Raccourcis
Gui, Font,              Normal s8

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Naviguer entre les fenêtres
Gui, Add, Hotkey,       x+10 vHotkeyCycleWindows, SC056

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Naviguer entre les fenêtres (à l'envers)
Gui, Add, Hotkey,       x+10 vHotkeyCycleWindowsBackwards, +SC056

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Déplacer les personnages
Gui, Add, Hotkey,       x+10 vHotkeyMoveAllPlayers, ^SC056

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Activer la fenêtre #1
Gui, Add, Hotkey,       x+10 vHotkeySetWindow1, F1

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Activer la fenêtre #2
Gui, Add, Hotkey,       x+10 vHotkeySetWindow2, F2

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Activer la fenêtre #3
Gui, Add, Hotkey,       x+10 vHotkeySetWindow3, F3

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Activer la fenêtre #4
Gui, Add, Hotkey,       x+10 vHotkeySetWindow4, F4

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Activer la fenêtre #5
Gui, Add, Hotkey,       x+10 vHotkeySetWindow5, F5

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Activer la fenêtre #6
Gui, Add, Hotkey,       x+10 vHotkeySetWindow6, F6

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Activer la fenêtre #7
Gui, Add, Hotkey,       x+10 vHotkeySetWindow7, F7

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, Activer la fenêtre #8
Gui, Add, Hotkey,       x+10 vHotkeySetWindow8, F8


;=============================================
; Action Bar
;=============================================

Gui, Tab

Gui, Font,              Bold s10
Gui, Add, Button,       y+70 gGui_1Click2Play w100 h30, % Translate("Play")
Gui, Add, Button,       x+10 w100 h30, % Translate("Organize")
Gui, Add, Button,       x+10 w100 h30, % Translate("Close")
Gui, Font,              Normal s8

/*
Gui, Add, Button,       x+10 gGui_OpenDofus, % "[" GetHotkeyForScenario("OpenDofusInstances") "] " Translate("StartDofus")
Gui, Add, Button,       x+10 gGui_LoginAccounts, % "[" GetHotkeyForScenario("LoginAccounts") "] " Translate("LoginAccounts")
Gui, Add, Button,       x+10 gGui_ConnectPlayersOnServer, % "[" GetHotkeyForScenario("ConnectPlayersOnServer") "] " Translate("ConnectPlayersOnServer")
Gui, Add, Button,       x+10 gGui_CloseDofus, % "[" GetHotkeyForScenario("CloseDofusInstances") "] " Translate("CloseDofusInstances")
*/
;=============================================
; Status Bar
;=============================================

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