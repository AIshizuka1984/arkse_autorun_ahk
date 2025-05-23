DetectHiddenWindows, On
SetTitleMatchMode, 2
Process, Priority, , High
#SingleInstance, Force
SendMode Input

WalkToggle := 0
RunToggle := 0

LShift & F1::
WinGetTitle, title, A
MsgBox, Class: %class%`nEXE: %exe%`nTitle: %title%
Return

LShift::
    if GetKeyState("w", "P"){
        Return
    }
    if(ArkActive()){
        WalkToggle := !WalkToggle
        AutoRunOff()

        If(WalkToggle){
            SetTimer, AutoWalk, 50
            ShowToolTip("AutoWalkOn")
        }

        Else{
            AutoWalkOff()
            ShowToolTip("AutoWalkOff")
        }
    }
    Else{
        AutoWalkOff()
        AutoRunOff()
        Send, {LShift}
    }
Return


LShift & W::
    If(ArkActive()){
        RunToggle := !RunToggle
        AutoWalkOff()

        If(RunToggle){
            SetTimer, AutoRun, 50
            ShowToolTip("AutoRunOn")
        }
        Else{
            AutoRunOff()
            ShowToolTip("AutoRunOff")
        }
    }
    Else{
        AutoWalkOff()
        AutoRunOff()
        Send, +w
    }
Return

$w::
    AutoWalkOff()
    AutoRunOff()
    Send {Blind}{w}

AutoWalk:
    If (ArkActive()){
        Send, {W Down}{LShift Up}
    }
Return

AutoRun:
    If (ArkActive()){
        Send, {W Down}{LShift Down}
    }
Return

RemoveToolTip:
    ToolTip
return

ArkActive(){
    WinGetTitle, title, A
    If (title = "ARK: Survival Evolved"){
        Return True
    }
    Else{
        Return False
    }
}

AutoWalkOff(){
    global WalkToggle
    WalkToggle := 0

    SetTimer, AutoWalk, Off
    Send, {W Up}{LShift Up}
}

AutoRunOff(){
    global RunToggle
    RunToggle := 0

    SetTimer, AutoRun, Off
    Send, {W Up}{LShift Up}
}

ShowToolTip(message){
    ToolTip, %message%, 0, 0
    SetTimer, RemoveToolTip, -2000
}
