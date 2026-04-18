#Requires AutoHotkey v2.0
#SingleInstance Force

global MasterActive := false
global CurrentProfile := 1
global KeyStates := Map()
global NormalSpeed := 30
global SlowSpeed := 8
global BlockAltTab := false

global Prof1Key := "1"
global Prof2Key := "2"

SettingsGui := Gui("+AlwaysOnTop", "Experimental Settings")
Tabs := SettingsGui.Add("Tab3", "w280 h150", ["General", "Speeds", "Hotkeys"])

Tabs.UseTab(1)
AltTabCheckbox := SettingsGui.Add("Checkbox", "vBlockAltTab x20 y40", "Block Alt+Tab")
AltTabCheckbox.OnEvent("Click", UpdateSettings)

Tabs.UseTab(2)
SettingsGui.Add("Text", "x20 y40 w80", "Normal Speed:")
NormSpeedEdit := SettingsGui.Add("Edit", "x100 y38 w50 Number", NormalSpeed)
SettingsGui.Add("Text", "x20 y70 w80", "Slow Speed:")
SlowSpeedEdit := SettingsGui.Add("Edit", "x100 y68 w50 Number", SlowSpeed)
ApplySpeedBtn := SettingsGui.Add("Button", "x160 y38 w80 h50", "Apply")
ApplySpeedBtn.OnEvent("Click", ApplySpeeds)

Tabs.UseTab(3)
SettingsGui.Add("Text", "x20 y40 w80", "Profile 1:")
HKProf1 := SettingsGui.Add("Hotkey", "x100 y38 w100", Prof1Key)
SettingsGui.Add("Text", "x20 y70 w80", "Profile 2:")
HKProf2 := SettingsGui.Add("Hotkey", "x100 y68 w100", Prof2Key)
ApplyHKBtn := SettingsGui.Add("Button", "x210 y38 w50 h50", "Set")
ApplyHKBtn.OnEvent("Click", ApplyHotkeys)

Tabs.UseTab()

UpdateSettings(*) {
    global BlockAltTab := AltTabCheckbox.Value
}

ApplySpeeds(*) {
    global NormalSpeed := Integer(NormSpeedEdit.Value)
    global SlowSpeed := Integer(SlowSpeedEdit.Value)
}

ApplyHotkeys(*) {
    global Prof1Key, Prof2Key

    HotIf (*) => MasterActive and GetKeyState("CapsLock", "T")
    
    try Hotkey(Prof1Key, SetProfile1, "Off")
    try Hotkey(Prof2Key, SetProfile2, "Off")

    if (HKProf1.Value != "")
        Prof1Key := HKProf1.Value
    if (HKProf2.Value != "")
        Prof2Key := HKProf2.Value

    try Hotkey(Prof1Key, SetProfile1, "On")
    try Hotkey(Prof2Key, SetProfile2, "On")
    
    HotIf
}

SetProfile1(*) {
    global CurrentProfile := 1
}

SetProfile2(*) {
    global CurrentProfile := 2
}

HotIf (*) => MasterActive and GetKeyState("CapsLock", "T")
Hotkey(Prof1Key, SetProfile1, "On")
Hotkey(Prof2Key, SetProfile2, "On")
HotIf

#F12::SettingsGui.Show("w300 h170")

#HotIf BlockAltTab
!Tab::return
+!Tab::return
#HotIf

SetTimer(MouseLoop, 16)

#CapsLock::global MasterActive := !MasterActive

#HotIf MasterActive and GetKeyState("CapsLock", "T")

*Up::
*Down:: {
    key := SubStr(A_ThisHotkey, 2)
    while GetKeyState(key, "P") {
        if (key = "Up")
            Send("{WheelUp}")
        else
            Send("{WheelDown}")
        Sleep(40)
    }
}

#HotIf MasterActive and GetKeyState("CapsLock", "T") and CurrentProfile == 1

*w::return
*a::return
*s::return
*d::return

*e:: {
    if GetKeyState("Shift", "P")
        ClickDown("e", "RButton")
    else
        ClickDown("e", "LButton")
}
*e up::ClickUp("e")

*Space:: {
    if GetKeyState("Shift", "P")
        ClickDown("Space", "RButton")
    else
        ClickDown("Space", "LButton")
    }
*Space up::ClickUp("Space")

*q::ClickDown("q", "RButton")
*q up::ClickUp("q")

#HotIf MasterActive and GetKeyState("CapsLock", "T") and CurrentProfile == 2

*p::return
*l::return
*;::return
*'::return

*w::
*s:: {
    key := SubStr(A_ThisHotkey, 2)
    while GetKeyState(key, "P") {
        if (key = "w")
            Send("{WheelUp}")
        else
            Send("{WheelDown}")
        Sleep(40)
    }
}

*Space:: {
    if GetKeyState("Shift", "P")
        ClickDown("Space", "RButton")
    else
        ClickDown("Space", "LButton")
}
*Space up::ClickUp("Space")

*o:: {
    if GetKeyState("Shift", "P")
        ClickDown("o", "RButton")
    else
        ClickDown("o", "LButton")
}
*o up::ClickUp("o")

*[::ClickDown("[", "RButton")
*[ up::ClickUp("[")

*a::ClickDown("a", "XButton1")
*a up::ClickUp("a")

*d::ClickDown("d", "XButton2")
*d up::ClickUp("d")

#HotIf

ClickDown(key, btn) {
    KeyStates[key] := btn
    Send("{Blind}{" btn " Down}")
}

ClickUp(key) {
    if KeyStates.Has(key) {
        btn := KeyStates[key]
        Send("{Blind}{" btn " Up}")
        KeyStates.Delete(key)
    }
}

MouseLoop() {
    if !(MasterActive && GetKeyState("CapsLock", "T"))
        return

    x := 0
    y := 0
    dist := GetKeyState("Shift", "P") ? SlowSpeed : NormalSpeed
    moved := false

    if (CurrentProfile == 1) {
        if GetKeyState("w", "P") {
            y -= dist
            moved := true
        }
        if GetKeyState("a", "P") {
            x -= dist
            moved := true
        }
        if GetKeyState("s", "P") {
            y += dist
            moved := true
        }
        if GetKeyState("d", "P") {
            x += dist
            moved := true
        }
    } else if (CurrentProfile == 2) {
        if GetKeyState("p", "P") {
            y -= dist
            moved := true
        }
        if GetKeyState("l", "P") {
            x -= dist
            moved := true
        }
        if GetKeyState(";", "P") {
            y += dist
            moved := true
        }
        if GetKeyState("'", "P") {
            x += dist
            moved := true
        }
    }

    if (moved)
        MouseMove(x, y, 0, "R")
}