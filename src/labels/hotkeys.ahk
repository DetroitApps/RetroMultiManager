/*
    Hotkeys
*/

+F12::
    Gosub, ExitGracefully
return

;Available through INI

F1::
    labelName := Settings.Hotkeys["F1"]
    if (labelName != "")
        Gosub, %labelName%
return

F2::
    labelName := Settings.Hotkeys["F2"]
    if (labelName != "")
        Gosub, %labelName%
return

F3::
    labelName := Settings.Hotkeys["F3"]
    if (labelName != "")
        Gosub, %labelName%
return

F4::
    labelName := Settings.Hotkeys["F4"]
    if (labelName != "")
        Gosub, %labelName%
return

F5::
    labelName := Settings.Hotkeys["F5"]
    if (labelName != "")
        Gosub, %labelName%
return

F6::
    labelName := Settings.Hotkeys["F6"]
    if (labelName != "")
        Gosub, %labelName%
return

F7::
    labelName := Settings.Hotkeys["F7"]
    if (labelName != "")
        Gosub, %labelName%
return

F8::
    labelName := Settings.Hotkeys["F8"]
    if (labelName != "")
        Gosub, %labelName%
return

F9::
    labelName := Settings.Hotkeys["F9"]
    if (labelName != "")
        Gosub, %labelName%
return

F10::
    labelName := Settings.Hotkeys["F10"]
    if (labelName != "")
        Gosub, %labelName%
return

F11::
    labelName := Settings.Hotkeys["F11"]
    if (labelName != "")
        Gosub, %labelName%
return

ActivateWindow1:
    API.GetWindow(1).Activate()
return
ActivateWindow2:
    API.GetWindow(2).Activate()
return
ActivateWindow3:
    API.GetWindow(3).Activate()
return
ActivateWindow4:
    API.GetWindow(4).Activate()
return
ActivateWindow5:
    API.GetWindow(5).Activate()
return
ActivateWindow6:
    API.GetWindow(6).Activate()
return
ActivateWindow7:
    API.GetWindow(7).Activate()
return
ActivateWindow8:
    API.GetWindow(8).Activate()
return
ActivateWindow9:
    API.GetWindow(9).Activate()
return
ActivateWindow10:
    API.GetWindow(10).Activate()
return
ActivateWindow11:
    API.GetWindow(11).Activate()
return
ActivateWindow12:
    API.GetWindow(12).Activate()
return
