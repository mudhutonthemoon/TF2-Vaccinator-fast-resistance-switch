#Requires AutoHotkey v2.0

#HotIf WinActive("Team Fortress 2")

; Config
global ReloadKey := "`b" ; Bound to +reload
global TimeBetweenCommands := 15

; Toggle
#SuspendExempt
RAlt:: {
    if (A_IsSuspended) {
        Reset(true)
    } else {
        loop 2 {
            SoundBeep(523, 100)
        }
        CurrentResistance := ResistanceTypeBullet
    }
    Suspend()
}
#SuspendExempt false

; Bullet
e:: {
    global
    if (CurrentResistance != ResistanceTypeBullet) {

        switch (CurrentResistance) {
            case ResistanceTypeExplosive:
                CyclePrevious()
            case ResistanceTypeFire:
                CycleNext()
        }

        CurrentResistance := ResistanceTypeBullet
    }
}

; Explosive
r:: {
    global
    if (CurrentResistance != ResistanceTypeExplosive) {

        switch (CurrentResistance) {
            case ResistanceTypeBullet:
                CycleNext()
            case ResistanceTypeFire:
                CyclePrevious()
        }

        CurrentResistance := ResistanceTypeExplosive
    }
}

; Fire
f:: {
    global
    if (CurrentResistance != ResistanceTypeFire) {

        switch (CurrentResistance) {
            case ResistanceTypeBullet:
                CyclePrevious()
            case ResistanceTypeExplosive:
                CycleNext()
        }

        CurrentResistance := ResistanceTypeFire
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

CycleNext() {
    Send(ReloadKey)
    Sleep(TimeBetweenCommands)
}
CyclePrevious() {
    loop 2 {
        Send(ReloadKey)
        Sleep(TimeBetweenCommands)
    }
}

Reset(startup := false) {
    if (startup) {
        SoundBeep(554, 100)
        SoundBeep(739, 100)
        SoundBeep(988, 600)

        CurrentResistance := ResistanceTypeBullet
    } else {
        Send(ReloadKey)
        CurrentResistance := ResistanceTypeBullet
        loop 2 {
            SoundBeep(988, 100)
        }
    }

}


Suspend()
