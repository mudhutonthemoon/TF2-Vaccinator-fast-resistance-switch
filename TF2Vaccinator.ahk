#Requires AutoHotkey v2.0

#HotIf WinActive("Team Fortress 2")

; Config
global ReloadKey := "`b" ; Bound to +reload
global TimeBetweenCommands := 64 ; Time between cycling in milliseconds.

; Toggle
#SuspendExempt
RCtrl:: {
    Reset(A_IsSuspended)
    Suspend()
}
#SuspendExempt false

; Set bullet resistance
e:: {
    global
    while (CurrentResistance != ResistanceTypeBullet) {
        Cycle()
    }
}

; Set explosive resistance
r:: {
    global

    while (CurrentResistance != ResistanceTypeExplosive) {
        Cycle()
    }
}

; Set fire resistance
f:: {
    global

    while (CurrentResistance != ResistanceTypeFire) {
        Cycle()
    }
}

; Reset
b:: {
    Reset()
}


global ResistanceTypeBullet := 0
global ResistanceTypeExplosive := 1
global ResistanceTypeFire := 2

global CurrentResistance := ResistanceTypeBullet

Cycle() {
    global

    Send(ReloadKey)
    CurrentResistance := Mod(CurrentResistance + 1, 3)
    Sleep(TimeBetweenCommands)
}

Reset(startup := false) {
    if (startup) {
        SoundBeep(554, 100)
        SoundBeep(739, 100)
        SoundBeep(988, 600)
    } else {
        loop 2 {
            SoundBeep(523, 100)
        }
    }

    CurrentResistance := ResistanceTypeBullet
}


Suspend()
