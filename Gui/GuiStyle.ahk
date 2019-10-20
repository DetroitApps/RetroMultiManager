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

Gui, Font,, MS Sans Serif
Gui, Font,, Arial
Gui, Font,, Open Sans ; Preferred font.

myIcon = %A_WorkingDir%\Resources\icon.png
IfExist, %myIcon%
    Menu, Tray, Icon,       %myIcon%, 1, 1

Gui, Destroy
Gui -AlwaysOnTop Resize
Menu, MySubmenu, Add,       TestMsg

;Menu Bar
;File
Menu, FileMenu, Add,        &Close Gui, TestMsg
Menu, FileMenu, Add,        &Reload Script`tCtrl+R, Gui_ReloadScript
Menu, FileMenu, Add,        &Quit`tF12, TestMsg
Menu, MyMenuBar, Add,       &File, :FileMenu

;Scenarios
Menu, ScenariosMenu, Add,   &Merge and reload, MergeScenarios
Menu, ScenariosMenu, Add
Menu, ScenariosMenu, Add,   &OpenDofusInstances,OpenDofusInstances
Menu, MyMenuBar, Add,       &Scenarios, :ScenariosMenu

;Tools
Menu, ToolsMenu, Add,       &Toggle OCR, ToggleOCR
Menu, ToolsMenu, Add,       &Download OCR Preset, DownloadOCRPreset
Menu, MyMenuBar, Add,       &Tools, :ToolsMenu

;Help
Menu, HelpMenu, Add,        &Visit Github, VisitGithub
Menu, MyMenuBar, Add,       &About, :HelpMenu
Gui, Menu,                  MyMenuBar