ScriptName Mnt_PlayerAlias Extends ReferenceAlias
{Handles on game load event}

Mnt_Tracker Property Tracker Auto; Main Script

; Event is only sent to the player actor. This would probably be on a magic effect or alias script
Event OnPlayerLoadGame()
	;Debug.Trace("player loaded a save, do some fancy stuff")
	Int i = Tracker.StartTrackers();
	If i == -1
		Debug.Trace("Mentalities: Trackers not started, mod is not yet started by player.")
	ElseIf i == 0
		Debug.Trace("Mentalities: Mod Trackers started as intended.")
	Else
		;Other error codes? Unrecognized error codes
	EndIf
EndEvent
;Set this on playeralias, calls main script.