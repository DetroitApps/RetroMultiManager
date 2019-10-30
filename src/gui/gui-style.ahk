/*
    Gui Style
*/

;Colors
cWhite = FFFFFF
cBlack = 121212

;Scaling
guiWidth := 850
guiHeight := 700
guiMargin := 10
groupboxWidth := guiWidth / 1.05
guiLabelOptions = h20 0x200 w80

;Gui Settings
Gui, -dpiscale
Gui, Color, %cWhite%
Gui -AlwaysOnTop +Resize

myIcon = %A_WorkingDir%\Resources\icon.ico
IfExist, %myIcon%
    Menu, Tray, Icon,       %myIcon%, 1, 1

Gui, Destroy
Gui -AlwaysOnTop Resize

Gui, Font,, MS Sans Serif
Gui, Font,, Arial
Gui, Font,, Open Sans