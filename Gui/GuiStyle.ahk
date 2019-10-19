/*
    Gui Style
*/

;Colors
cWhite = FFFFFF
cBlack = 121212

;Scaling
guiWidth := 850
guiHeight := 800
guiMargin := 10
groupboxWidth := guiWidth / 1.1
guiLabelOptions = h20 0x200 w80

;Gui Settings
Gui, -dpiscale
Gui, Color, %cWhite%
Gui -AlwaysOnTop +Resize

Gui, Font,, MS Sans Serif
Gui, Font,, Arial
Gui, Font,, Open Sans ; Preferred font.

myIcon = %A_WorkingDir%\Resources\icon.png
IfExist, %myIcon%
    Menu, Tray, Icon, %myIcon%, 1, 1
Menu, Tray, Add  ; Creates a separator line.
Menu, Tray, Add, Item1, TestMsg  ; Creates a new menu item.
Gui, Destroy
Gui -AlwaysOnTop -Resize
Menu, MySubmenu, Add, TestMsg

;Menu Bar
;File
Menu, FileMenu, Add,    &Close Gui, TestMsg
Menu, FileMenu, Add,    &Reload Script`tCtrl+R, ReloadScript
Menu, FileMenu, Add,    &Quit`tF12, TestMsg
Menu, MyMenuBar, Add,   &File, :FileMenu

;Tools
Menu, ToolsMenu, Add,   &Merge scenarios, MergeScenarios
Menu, MyMenuBar, Add,   &Tools, :ToolsMenu
Gui, Menu,              MyMenuBar

;Help
Menu, HelpMenu, Add,    &Visit Github, VisitGithub
Menu, MyMenuBar, Add,   &About, :HelpMenu
Gui, Menu,              MyMenuBar