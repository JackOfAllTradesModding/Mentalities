ScriptName Mnt_Tracker Extends Quest
{Actual tracking of basic events}

;Script Properties
SexLabFramework Property SexLab Auto ;SSL
slaFrameworkScr Property SexLabAroused Auto ;SLA

;Mentalities Properties:
Mnt_Core Property MentalityCore Auto ;CORE
Mnt_MCM Property Config Auto ;MCM
;--Module Scripts:


;Properties
Actor Property PlayerRef Auto


;

; ======================================================= ;
; === Empty State                                     === ;
; ======================================================= ; 
Event OnInit()
	;Display simple config in dialogue box (options to import stats, enable or disable certain features)
	;Does next to nothing else. Most options are chosen through MCM, including starting tracking.
EndEvent

Int Function StartTrackers() ;Empty
	Return -1; Tell Calling script that the mod hasn't been started in the MCM
EndFunction

Event sslStageStart(String eventName, String argString, Float argNum, Form sender) ;Empty
	;Stage Start
EndEvent

Event sslOrgasmEnd(String eventName, String argString, Float argNum, Form sender) ;Empty
	;Orgasm End
EndEvent

Event slaExposureUpdate(Form act, Float val) ;Empty
	;Exposure Change
EndEvent

Event OnUpdate() ;Empty

EndEvent
; ======================================================= ;
; === Running State                                   === ;
; ======================================================= ; 
State Running
	
;Others depending on which soft dependencies are involved.
;Set up optional trackers through dummy scripts, script there but empty unless the module installed.

Int Function StartTrackers() ;Starts listening for events
	
	UnregisterForAllModEvents();Unsure of what happens if you double register, but this can't hurt
	RegisterForModEvent("HookStageStart", "sslStageStart")
	RegisterForModEvent("HookOrgasmEnd", "sslOrgasmEnd")
	RegisterForModEvent("slaUpdateExposure", "slaExposureUpdate")
	
	Return 0; Tell calling script everything started as intended.
EndFunction

Event sslStageStart(String eventName, String argString, Float argNum, Form sender) ;unsure if needed, test for lag
	;Stage Start
	;Look at SSL API for what these args can be used for. At least need tags.
EndEvent

Event sslOrgasmEnd(String eventName, String argString, Float argNum, Form sender) ;set?
	;Orgasm End
	Float[] PnP = New Float[2];
	;0=Pain
	;1=Pleasure
	sslThreadController current = SexLab.HookController(argString);
	If (current.GetPlayer() == PlayerRef)
		PnP = MentalityCore.PainAndPleasure(current);
		
		;Modify Values as required, passing PnP.
		MentalityCore.FetishUpdate(PlayerRef, PnP, current); Updates player fetish values
		MentalityCore.StatUpdate(PlayerRef, PnP, current);   Updates player Stat values/titles
	Else
		;NPC Tracking to be implemented in future releases
	EndIf
	;Event done or player not involved.
	RegisterForSingleUpdate(1.0); register for one update in one second
EndEvent

Event slaExposureUpdate(Form act, Float val) ;Probably gonna get used in denial
	;Exposure Change
	;Act: Actor being updated as form
	;val: new exposure value
EndEvent
	
Event OnUpdate()
	PlayerRef.HasMagicEffectWithKeyword()
EndEvent

EndState 