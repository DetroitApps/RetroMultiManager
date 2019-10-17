;param
#NoEnv
; #Warn
SendMode Input
SetWorkingDir %A_ScriptDir% 
#SingleInstance, Force

#Include ..\library\StatusBar.ahk
;end param

;----------------------------------------
;----------------GUI---------------------
;----------------------------------------

;Colors
cWhite = FFFFFF
cBlack = 121212

;Scaling
guiWidth := 800
guiHeight := 600
guiMargin := 10
groupboxWidth := guiWidth / 1.1
guiLabelOptions = h20 0x200 w80

;Style
Gui, -dpiscale
Gui, Color, %cWhite%
Gui -AlwaysOnTop +ToolWindow

Gui, Font,, MS Sans Serif
Gui, Font,, Arial
Gui, Font,, Open Sans ; Preferred font.

;Header
Gui, Font, cBlack s16
Gui, Add, Text, w%guiWidth% y10 center, Retro Multi Manager
Gui, Font, s8
Gui, Add, Text, w%guiWidth% y+1 center, For Dofus Retro 1.3.0

;SCRIPT SETTINGS
Gui, Font, Bold
Gui, Add, GroupBox, xm ym+10 y+10 Section w%groupboxWidth% h100, Settings
Gui, Font, Normal
;Dofus path
Gui, Add, Text, xs+10 ys+30 %guiLabelOptions%, Dofus.exe
Gui, Add, Edit, hp r1 x+10 w450 vInputDofusPath, C:\path ;hardcode
Gui, Add, Button, x+10 w80, Browse
;Delimiter
Gui, Add, Text, xs+10 ys+60 %guiLabelOptions%, Delimiter
Gui, Add, Edit, hp r1 x+10 w15, % Chr(59) ;hardcode

;ACCOUNTS
Gui, Font, Bold
Gui, Add, GroupBox, xm ym+10 y+20 Section w%groupboxWidth% h300, Accounts
Gui, Font, Normal

;Input fields
start_y := 30
iter := 1
Loop 8 {
    ;ID
    Gui, Font, Bold
    Gui, Add, Text, ys+%start_y% xs+10 h20 0x200, [%iter%]
    Gui, Font, Normal
    ;Username
    Gui, Add, Text, x+10 %guiLabelOptions%, Username
    Gui, Add, Edit, hp r1 x+10 w100, value ;hardcode
    ;Password
    Gui, Add, Text, x+10 %guiLabelOptions%, Password
    Gui, Add, Edit, Password hp r1 x+10 w100, value ;hardcode
    ;Nickname
    Gui, Add, Text, x+10 %guiLabelOptions%, Nickname
    Gui, Add, Edit, hp r1 x+10 w100, value ;hardcode
    start_y += 30
    iter++
}

;ACTIONS
Gui, Font, Bold
Gui, Add, GroupBox, xm ym+10 y+40 Section w%groupboxWidth%, Actions
Gui, Font, Normal

Gui, Add, Button, ys+30 xs+10 w100 h50 gOpenWindows, Open Dofus windows
Gui, Add, Button, x+10 w100 h50 gLoginAccounts, Login accounts
Gui, Add, Button, x+10 w100 h50 gConnectServers, Connect on servers

;STATUS BAR
Gui, Add, StatusBar

Gui, Show, w%guiWidth% h%guiHeight%, Retro Multi Manager 1.0 GUI

SB_SetParts(20,200,100) ; Make 3 different parts
SB_SetText("demotext",2) ; Set a text segment 2
SB_SetIcon(A_AhkPath,1,1) ; Set an Icon to 1st segment
; hwnd := SB_SetProgress(100,3, "cFFFFFF")


Return ; END OF MAIN

;Labels
GuiClose:
    ExitApp, 0
    return

OpenWindows:
    SB_SetText("Opening Dofus instances...",2)
    hwnd := SB_SetProgress(10,3)
    Sleep, 3000
    hwnd := SB_SetProgress(100,3)
    SB_SetText("Done.",2)
    return

LoginAccounts:
    MsgBox, Todo
    return

ConnectServers:
    MsgBox, Todo
    return


;----------------------------------------
;----------------SHORTCUTS---------------
;----------------------------------------

F12::
    ExitApp, 0
    return