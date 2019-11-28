/*
    Gui Style
*/

;Colors
cWhite = FFFFFF
cBlack = 121212

;Scaling
guiWidth := 800
guiHeight := 600
guiMargin := 10
groupboxWidth := guiWidth / 1.05
guiLabelOptions = h20 0x200 w80

;Gui Settings
Gui, -dpiscale
Gui, Color, %cWhite%

myIcon = %A_WorkingDir%\Resources\icon.ico
IfExist, %myIcon%
    Menu, Tray, Icon,       %myIcon%, 1, 1

Gui, Destroy
Gui -AlwaysOnTop

Gui, Font,, MS Sans Serif
Gui, Font,, Arial
Gui, Font,, Open Sans