;=============================================
; Settings
;=============================================

Gui, Tab, 3

Gui, Font,              Bold s10
Gui, Add, Text,         , Programme
Gui, Font,              Normal s8

;Dofus path
Gui, Add, Text,         x40 y+10 %guiLabelOptions% , Dofus.exe
Gui, Add, Edit,         hp r1 x+10 w500 ReadOnly vInputDofusPath
Gui, Add, Button,       x+10 w80 gGui_Browse, % Translate("Browse")

;Dofus window's name
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, % Translate("WindowName")
Gui, Add, Edit,         hp r1 x+10 w200 gGui_DofusWindowName vInputDofusWindowName

;Speed
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, % Translate("Speed")
Gui, Add, DropDownList, x+10 AltSubmit vSelectSpeed gGui_ChangeSpeed, % Translate("SpeedFastest") "|" Translate("SpeedFaster") "|" Translate("SpeedNormal") "||" Translate("SpeedSlower") "|" Translate("SpeedSlowest")
Gui, Add, CheckBox,     x+10 gGui_WaitForAnkamaShield vCheckWaitForAnkamaShield h20 0x200, % Translate("WaitForAnkamaShield")

;Updates
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, % Translate("Updates")
Gui, Add, Button,       x+10 gGui_CheckForUpdates, % Translate("CheckForUpdates")
Gui, Add, CheckBox,     x+10 vCheckCheckUpdateOnStart gGui_ToggleCheckUpdateOnStart h20 0x200, % Translate("CheckOnStart")

;
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, Organizer
Gui, Add, CheckBox,     x+10 gCheckAlwaysOrganize_Listener vCheckAlwaysOrganize h20 0x200, % Translate("StartWithOrganizer")


;=============================================
; Hotkeys
;=============================================

Gui, Font,              Bold s10
Gui, Add, Text,         x40 y+10, % Translate("Hotkeys")
Gui, Font,              Normal s8

Gui, Add, Checkbox,     x40y y+10 gCheckFunctionHotkeys_Listener vCheckFunctionHotkeys, % Translate("FunctionHotkeysText")

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, % Translate("CycleWindows")
Gui, Add, Hotkey,       x+10 gHotkeyCycleWindows_Listener vHotkeyCycleWindows, SC056

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, % Translate("CycleWindowsBackwards")
Gui, Add, Hotkey,       x+10 gHotkeyCycleWindowsBackwards_Listener vHotkeyCycleWindowsBackwards, +SC056

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, % Translate("MoveAllPlayers")
Gui, Add, Hotkey,       x+10 gHotkeyMoveAllPlayers_Listener vHotkeyMoveAllPlayers, ^SC056