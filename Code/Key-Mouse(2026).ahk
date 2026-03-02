#Requires AutoHotkey v2.0
#SingleInstance Force

; Global variables
global MasterActive := false
global CurrentProfile := 1
global KeyStates := Map()

; Cursor speeds (pixels per 16ms)
global NormalSpeed := 30
global SlowSpeed := 8

; Start background loop (16ms delay)
SetTimer(MouseLoop, 16)

; Toggle master script state
#CapsLock::global MasterActive := !MasterActive

; Hotkey condition (Master active + CapsLock toggled)
#HotIf MasterActive and GetKeyState("CapsLock", "T")

; Profile switching
1::global CurrentProfile := 1
2::global CurrentProfile := 2

; Shared scrolling logic
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

; Profile 1 active
#HotIf MasterActive and GetKeyState("CapsLock", "T") and CurrentProfile == 1

; Block physical movement keys
*w::return
*a::return
*s::return
*d::return

; Profile 1 click mappings
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

; Profile 2 active
#HotIf MasterActive and GetKeyState("CapsLock", "T") and CurrentProfile == 2

; Block physical movement keys
*p::return
*l::return
*;::return
*'::return

; Profile 2 scrolling logic
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

; Profile 2 click mappings
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

; Clear hotkey conditions
#HotIf

; Custom click press function
ClickDown(key, btn) {
    KeyStates[key] := btn
    Send("{Blind}{" btn " Down}")
}

; Custom click release function
ClickUp(key) {
    if KeyStates.Has(key) {
        btn := KeyStates[key]
        Send("{Blind}{" btn " Up}")
        KeyStates.Delete(key)
    }
}

; Continuous mouse movement logic
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