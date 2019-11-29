;=============================================
; Windows tab
;=============================================

Gui, Tab, 1

Gui, Font,              Bold s10
Gui, Add, Text,         , % Translate("Windows")
Gui, Font,              Normal s10

Gui, Add, ListView,     gListViewWindows_Listener r12 w700 AltSubmit -Multi, Id|Account|Title|🔗
LV_ModifyCol(1, "Integer")

Gui, Font,              Bold s14
Gui, Add, Button,       Section y+10 x40 w50 gButtonDisplayWindow_Listener, 👁
Gui, Add, Button,       ys x+5 w50 gButtonLinkWindow_Listener, 🔗
Gui, Add, Button,       ys x+5 w50, ✏️
Gui, Add, Button,       ys x+5 w50 gButtonCloseWindow_Listener, ❌

Gui, Font,              Normal s8