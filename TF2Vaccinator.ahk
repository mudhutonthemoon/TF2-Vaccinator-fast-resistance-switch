#Requires AutoHotkey v2.0
#HotIf WinActive("Team Fortress 2")

; Config
global RELOAD_KEY := "`b"
global TIME_BETWEEN_COMMANDS := 40

; Toggle
#SuspendExempt
RAlt:: {
    if (A_IsSuspended) {
        Reset(true)
    } else {
        loop 2 {
            SoundBeep(523, 100)
        }
    }
    Suspend()
}
#SuspendExempt false

; Reset
Up:: {
    Reset()
}


global RESISTANCE_BULLET := 0
global RESISTANCE_EXPLOSIVE := 1
global RESISTANCE_FIRE := 2

global CurrentResistance := RESISTANCE_BULLET

; Bullet
e:: {
    global
    if (CurrentResistance != RESISTANCE_BULLET) {

        switch (CurrentResistance) {
            case RESISTANCE_EXPLOSIVE:
                CyclePrevious()
            case RESISTANCE_FIRE:
                CycleNext()
        }

        CurrentResistance := RESISTANCE_BULLET
    }
}

; Explosive
r:: {
    global
    if (CurrentResistance != RESISTANCE_EXPLOSIVE) {

        switch (CurrentResistance) {
            case RESISTANCE_BULLET:
                CycleNext()
            case RESISTANCE_FIRE:
                CyclePrevious()
        }

        CurrentResistance := RESISTANCE_EXPLOSIVE
    }
}

; Fire
f:: {
    global
    if (CurrentResistance != RESISTANCE_FIRE) {

        switch (CurrentResistance) {
            case RESISTANCE_BULLET:
                CyclePrevious()
            case RESISTANCE_EXPLOSIVE:
                CycleNext()
        }

        CurrentResistance := RESISTANCE_FIRE
    }
}

CycleNext() {
    Sleep(TIME_BETWEEN_COMMANDS)
    Send(RELOAD_KEY)
}
CyclePrevious() {
    Send(RELOAD_KEY)
    Sleep(TIME_BETWEEN_COMMANDS)
    Send(RELOAD_KEY)
}

Reset(startup := false) {
    if (startup) {
        SoundBeep(554, 100)
        SoundBeep(739, 100)
        SoundBeep(988, 600)
    } else {
        SoundBeep(988, 300)
    }
    CurrentResistance := RESISTANCE_BULLET
}

Suspend()
