#Persistent
#SingleInstance force
SetTitleMatchMode, 2

; Toggle variable to track whether the script is active or not
Toggle := False

; Cursor speed settings
NormalSpeed := 75  ; Adjust as needed
SlowSpeed := 15  ; Adjust as needed

; Zoom speed settings
ZoomSpeed := 1  ; Adjust as needed

; Set mouse movement delay to zero
SetDefaultMouseSpeed, 0

; Hotkey to toggle the script on/off with Win + CapsLock
#CapsLock::Toggle := !Toggle

; Always on top
WinSet, AlwaysOnTop, on, ahk_class AutoHotkey

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
    w::SendInput {WheelUp}
    s::SendInput {WheelDown}

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
    SetMouseDelay, -1  ; Makes mouse movements more immediate
    while GetKeyState("XButton1", "P")
    {
        SendInput {WheelDown}
        Sleep 40  ; Reduced sleep time for smoother and swifter scrolling
    }
    return

    ; Continuous scroll up when XButton2 is held
    XButton2::
    SetMouseDelay, -1  ; Makes mouse movements more immediate
    while GetKeyState("XButton2", "P")
    {
        SendInput {WheelUp}
        Sleep 40  ; Reduced sleep time for smoother and swifter scrolling
    }
    return

#If
