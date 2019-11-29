﻿/*
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
Gui, Add, Tab3,         w750, % Translate("Windows") "|" Translate("Profiles") "|" Translate("Groups") "|" Translate("Settings")
Gui, Font,              Normal s8

#Include src\gui\tabs\tab-windows.ahk
#Include src\gui\tabs\tab-profiles.ahk
#Include src\gui\tabs\tab-groups.ahk
#Include src\gui\tabs\tab-settings.ahk

;=============================================
; Action Bar
;=============================================

Gui, Tab

Gui, Font,              Bold s10
Gui, Add, Button,       gGui_1Click2Play w100 h30, % Translate("Play")
Gui, Add, Button,       gGui_OrganizeAccounts x+10 w100 h30, % Translate("Organize")
Gui, Add, Button,       gGui_CloseDofus x+10 w100 h30, % Translate("Close")
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