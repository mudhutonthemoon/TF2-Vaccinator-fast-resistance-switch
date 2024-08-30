#Requires AutoHotkey v2.0

#HotIf WinActive("Team Fortress 2")

; Config
global ReloadKey := "`b" ; Bound to +reload
global TimeBetweenCommands := 66 ; Time between cycling in milliseconds.

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

  while (CurrentResistance != ResistanceTypeBullet && VaccActive) {
    Cycle()
  }
}

; Set explosive resistance
r:: {
  global

  while (CurrentResistance != ResistanceTypeExplosive && VaccActive) {
    Cycle()
  }
}

; Set fire resistance
f:: {
  global

  while (CurrentResistance != ResistanceTypeFire && VaccActive) {
    Cycle()
  }
}

; Reset
b:: {
  Reset()
}

; Handle weapon switching
1:: {
  global

  VaccActive := false
  SendInput(1)
}
2:: {
  global

  VaccActive := true
  SendInput(2)
}
3:: {
  global

  VaccActive := false
  SendInput(3)
}


global ResistanceTypeBullet := 0
global ResistanceTypeExplosive := 1
global ResistanceTypeFire := 2

global CurrentResistance := ResistanceTypeBullet
global VaccActive := true

Cycle() {
  global

  Send(ReloadKey)
  CurrentResistance := Mod(CurrentResistance + 1, 3)
  VaccActive := true
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
  VaccActive := true
}


Suspend()