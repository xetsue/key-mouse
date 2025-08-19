#Persistent
#SingleInstance force
SetTitleMatchMode, 2

; Load saved settings
IniRead, ScrollSpeed, Settings.ini, Settings, ScrollSpeed, 10
IniRead, MouseScrollSpeed, Settings.ini, Settings, MouseScrollSpeed, 10
IniRead, NormalSpeed, Settings.ini, Settings, NormalSpeed, 75
IniRead, SlowSpeed, Settings.ini, Settings, SlowSpeed, 15

; Toggle variable to track whether the script is active or not
Toggle := False

; Set mouse movement delay to zero
SetDefaultMouseSpeed, 0

; Hotkey to toggle the script on/off with Win + CapsLock
#CapsLock::Toggle := !Toggle

; Always on top
WinSet, AlwaysOnTop, on, ahk_class AutoHotkey

; Function to create the GUI for adjusting scroll speeds and cursor speeds
AdjustSettings() {
    global ScrollSpeed, MouseScrollSpeed, NormalSpeed, SlowSpeed, ScrollSpeedSlider, MouseScrollSpeedSlider, NormalSpeedSlider, SlowSpeedSlider
    Gui, +AlwaysOnTop
    Gui, Font, S10
    Gui, Add, Text,, Adjust Scroll Speed for Keyboard:
    Gui, Add, Slider, vScrollSpeedSlider Range1-100 gUpdateScrollSpeed, %ScrollSpeed%
    Gui, Add, Text,, %ScrollSpeed%
    Gui, Add, Button, gResetScrollSpeed, Reset
    Gui, Add, Text,, Adjust Scroll Speed for Mouse Side Buttons:
    Gui, Add, Slider, vMouseScrollSpeedSlider Range1-100 gUpdateMouseScrollSpeed, %MouseScrollSpeed%
    Gui, Add, Text,, %MouseScrollSpeed%
    Gui, Add, Button, gResetMouseScrollSpeed, Reset
    Gui, Add, Text,, Adjust Cursor Speed (Normal):
    Gui, Add, Slider, vNormalSpeedSlider Range1-100 gUpdateNormalSpeed, %NormalSpeed%
    Gui, Add, Text,, %NormalSpeed%
    Gui, Add, Button, gResetNormalSpeed, Reset
    Gui, Add, Text,, Adjust Cursor Speed (Shift Held):
    Gui, Add, Slider, vSlowSpeedSlider Range1-100 gUpdateSlowSpeed, %SlowSpeed%
    Gui, Add, Text,, %SlowSpeed%
    Gui, Add, Button, gResetSlowSpeed, Reset
    Gui, Add, Button, gSaveSettings, Save
    Gui, Show, Center, Adjust Settings
}

UpdateScrollSpeed() {
    global ScrollSpeed, ScrollSpeedSlider
    GuiControlGet, ScrollSpeedSlider
    ScrollSpeed := ScrollSpeedSlider
    GuiControl, , ScrollSpeedSlider+1, %ScrollSpeed%  ; Update display
}

UpdateMouseScrollSpeed() {
    global MouseScrollSpeed, MouseScrollSpeedSlider
    GuiControlGet, MouseScrollSpeedSlider
    MouseScrollSpeed := MouseScrollSpeedSlider
    GuiControl, , MouseScrollSpeedSlider+1, %MouseScrollSpeed%  ; Update display
}

UpdateNormalSpeed() {
    global NormalSpeed, NormalSpeedSlider
    GuiControlGet, NormalSpeedSlider
    NormalSpeed := NormalSpeedSlider
    GuiControl, , NormalSpeedSlider+1, %NormalSpeed%  ; Update display
}

UpdateSlowSpeed() {
    global SlowSpeed, SlowSpeedSlider
    GuiControlGet, SlowSpeedSlider
    SlowSpeed := SlowSpeedSlider
    GuiControl, , SlowSpeedSlider+1, %SlowSpeed%  ; Update display
}

ResetScrollSpeed() {
    global ScrollSpeed
    ScrollSpeed := 10
    GuiControl, , ScrollSpeedSlider, %ScrollSpeed%
    GuiControl, , ScrollSpeedSlider+1, %ScrollSpeed%
}

ResetMouseScrollSpeed() {
    global MouseScrollSpeed
    MouseScrollSpeed := 10
    GuiControl, , MouseScrollSpeedSlider, %MouseScrollSpeed%
    GuiControl, , MouseScrollSpeedSlider+1, %MouseScrollSpeed%
}

ResetNormalSpeed() {
    global NormalSpeed
    NormalSpeed := 75
    GuiControl, , NormalSpeedSlider, %NormalSpeed%
    GuiControl, , NormalSpeedSlider+1, %NormalSpeed%
}

ResetSlowSpeed() {
    global SlowSpeed
    SlowSpeed := 15
    GuiControl, , SlowSpeedSlider, %SlowSpeed%
    GuiControl, , SlowSpeedSlider+1, %SlowSpeed%
}

SaveSettings() {
    global ScrollSpeed, MouseScrollSpeed, NormalSpeed, SlowSpeed
    IniWrite, %ScrollSpeed%, Settings.ini, Settings, ScrollSpeed
    IniWrite, %MouseScrollSpeed%, Settings.ini, Settings, MouseScrollSpeed
    IniWrite, %NormalSpeed%, Settings.ini, Settings, NormalSpeed
    IniWrite, %SlowSpeed%, Settings.ini, Settings, SlowSpeed
    Gui, Destroy
}

#If (Toggle && GetKeyState("CapsLock", "T"))

    ; Cursor movement with configurable speed
    o::MouseMove, 0, -NormalSpeed, 0, R  ; Move the cursor up
    l::MouseMove, 0, NormalSpeed, 0, R  ; Move the cursor down
    k::MouseMove, -NormalSpeed, 0, 0, R  ; Move the cursor left
    `;::MouseMove, NormalSpeed, 0, 0, R  ; Move the cursor right

    ; Slow down cursor speed when Shift is held
    +o::MouseMove, 0, -SlowSpeed, 0, R
    +l::MouseMove, 0, SlowSpeed, 0, R
    +k::MouseMove, -SlowSpeed, 0, 0, R
    +`;::MouseMove, SlowSpeed, 0, 0, R

    ; Hold down left click when I or Space is pressed
    i::
    Space::
        SendInput {LButton down}
        KeyWait, %A_ThisHotkey%
        SendInput {LButton up}
    return

    ; Hold down right click when Q + Space is pressed
    q & Space::
        SendInput {RButton down}
        KeyWait, Space
        SendInput {RButton up}
    return

    ; Right-click when P is pressed
    p::SendInput {RButton down}{RButton up}

    ; Page Up when ` is held and Left is pressed
    ` & Left::SendInput {PgUp}

    ; Page Down when ` is held and Right is pressed
    ` & Right::SendInput {PgDn}

    ; Scroll wheel simulation for W/S
    w::
        Loop {
            if !GetKeyState("w", "P")
                break
            SendInput {WheelUp}
            Sleep, %ScrollSpeed%
        }
    return
    s::
        Loop {
            if !GetKeyState("s", "P")
                break
            SendInput {WheelDown}
            Sleep, %ScrollSpeed%
        }
    return

    ; Zoom in when Q is held and Up or W is pressed
    q & w::SendInput ^{WheelUp}
    q & o::SendInput ^{WheelUp}

    ; Zoom out when Q is held and Down or S is pressed
    q & s::SendInput ^{WheelDown}
    q & l::SendInput ^{WheelDown}

    ; Use A and D as Mouse Button 4 and Mouse Button 5 respectively
    a::SendInput {XButton1}
    d::SendInput {XButton2}

    ; Continuous scroll down when XButton1 is held
    XButton1::
    Loop {
        if !GetKeyState("XButton1", "P")
            break
        SendInput {WheelDown}
        Sleep, %MouseScrollSpeed%
    }
    return

    ; Continuous scroll up when XButton2 is held
    XButton2::
    Loop {
        if !GetKeyState("XButton2", "P")
            break
        SendInput {WheelUp}
        Sleep, %MouseScrollSpeed%
    }
    return

    ; Adjust settings when ESC is held for 3 seconds
    $Esc::
        KeyWait, Esc, T3
        if !ErrorLevel
        {
            AdjustSettings()
        }
    return

#If
