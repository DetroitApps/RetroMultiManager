;=============================================
; Settings
;=============================================

Gui, Tab, 3

Gui, Font,              Bold s10
Gui, Add, Text,         , % Translate("Software")
Gui, Font,              Normal s8

;Dofus path
Gui, Add, Text,         x40 y+10 %guiLabelOptions% , Dofus.exe
Gui, Add, Edit,         hp r1 x+10 w500 ReadOnly vInputDofusPath
Gui, Add, Button,       x+10 w80 gGui_Browse, % Translate("Browse")

;Dofus window's name
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, % Translate("WindowName")
Gui, Add, Edit,         hp r1 x+10 w200 gGui_DofusWindowName vInputDofusWindowName

;Updates
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, % Translate("Updates")
Gui, Add, Button,       x+10 gGui_CheckForUpdates, % Translate("CheckForUpdates")
Gui, Add, CheckBox,     x+10 vCheckCheckUpdateOnStart gGui_ToggleCheckUpdateOnStart h20 0x200, % Translate("CheckOnStart")

;Organizer
Gui, Add, Text,         x40 y+10 %guiLabelOptions%, Organizer
Gui, Add, CheckBox,     x+10 gCheckAlwaysOrganize_Listener vCheckAlwaysOrganize h20 0x200, % Translate("StartWithOrganizer")


;=============================================
; In Game
;=============================================


Gui, Font,              Bold s10
Gui, Add, Text,         x40 y+15, % Translate("InGame")
Gui, Font,              Normal s8

;ConnectionSpeed
Gui, Add, Text,         x40 y+10 %guiLabelOptions% w141, % Translate("SpeedConnection")
Gui, Add, DropDownList, x+10 AltSubmit vSelectSpeedConnection gGui_ChangeSpeedConnection, % Translate("SpeedFastest") "|" Translate("SpeedFaster") "|" Translate("SpeedNormal") "||" Translate("SpeedSlower") "|" Translate("SpeedSlowest")
Gui, Add, CheckBox,     x+10 gGui_WaitForAnkamaShield vCheckWaitForAnkamaShield h20 0x200, % Translate("WaitForAnkamaShield")

;MoveSpeedDelay
Gui, Add, Text,         x40 y+10 %guiLabelOptions% w141, % Translate("DelayMoveSpeed")
Gui, Add, Text,         x+10 %guiLabelOptions% w30, % Translate("Between")
Gui, Add, Edit,         x+2 Number vSelectDelayMoveSpeedBegin gGui_ChangeDelayMoveSpeedBegin %guiLabelOptions% w40
Gui, Add, Text,         x+1 %guiLabelOptions% w35, % "ms " Translate("and")
Gui, Add, Edit,         x+2 Number vSelectDelayMoveSpeedEnd gGui_ChangeDelayMoveSpeedEnd %guiLabelOptions% w40
Gui, Add, Text,         x+1 %guiLabelOptions% w15, ms


;=============================================
; Hotkeys
;=============================================

Gui, Font,              Bold s10
Gui, Add, Text,         x40 y+15, % Translate("Hotkeys")
Gui, Font,              Normal s8

Gui, Add, Checkbox,     x40y y+10 gCheckFunctionHotkeys_Listener vCheckFunctionHotkeys, % Translate("FunctionHotkeysText")

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, % Translate("CycleWindows")
Gui, Add, Hotkey,       x+10 gHotkeyCycleWindows_Listener vHotkeyCycleWindows, SC056

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, % Translate("CycleWindowsBackwards")
Gui, Add, Hotkey,       x+10 gHotkeyCycleWindowsBackwards_Listener vHotkeyCycleWindowsBackwards, +SC056

Gui, Add, Text,         x40 y+10 %guiLabelOptions% w200, % Translate("MoveAllPlayers")
Gui, Add, Hotkey,       x+10 gHotkeyMoveAllPlayers_Listener vHotkeyMoveAllPlayers, ^SC056