ScriptName Mnt_Core Extends Quest
{Handles Modification and Retrieval of Mentality stats_titles}

;=================================================================
;=======                Stat Explanation                   =======
;=================================================================
;===== StorageUtil Keys ending in "Key" return the raw score =====
;===== StorageUtil Keys ending in "title" return the rank    =====
;=====                                                       =====
;===== Scores range from -100 to +100                        =====
;===== Ranks range from -4 to 4                              =====
;===== Both include 0 as a midpoint                          =====
;=====                                                       =====
;===== Negative fetish values mean the character does not    =====
;===== enjoy that particular kink                            =====
;===== Positive values mean they do                          =====
;=====                                                       =====
;===== More extreme values mean stronger feelings either way =====
;=====  (for fetishes or other stats)                        =====
;=====                                                       =====
;=================================================================
;=======                Stat Explanation                   =======
;=================================================================
;=====  Each stat behaves a little differently               =====
;=====                                                       =====
;=====  Quick overview:                                      =====
;=====                                                       =====
;=====  Sub_Dom                                              =====
;=====   -                                                   =====
;=====   -                                                   =====
;=====                                                       =====
;=====                                                       =====
;=====                                                       =====
;=====                                                       =====
;=====                                                       =====
SexLabFramework Property SexLab Auto
slaFrameworkScr Property SexLabAroused Auto
Mnt_MCM Property Config Auto

Actor Property PlayerRef Auto

Import StorageUtil;
Import Math;

ReferenceAlias Property PlayerAlias Auto;
Actor Property Player Auto;
;Properties for fet and stage?

String[] Property Presets Auto;
Int[] Property PreWillPower Auto;
Int[] Property PreConfidence Auto;
Int[] Property PreObedience Auto;
Int[] Property PreSub Auto;

String[] Property WillTitles Auto;
String[] Property ConfTitles Auto;
String[] Property ObedTitles Auto;
String[] Property SubTitles Auto;

Race Property KhajiitRace Auto;
Race Property ArgonianRace Auto;

;Storage Util Key names stored for easy access
;Recommend using these properties to retrieve the stats.
;beginfold
;NP++ Comment folding, beginfold->midfold->endfold
;midfold -StatKeys
String Property WillKey
	String Function Get()
		Return "Mentalities.Willpower.Score"
	EndFunction
EndProperty
String Property WillTitle
	String Function Get()
		Return "Mentalities.Willpower.Title"
	EndFunction
EndProperty
String Property ConfidenceKey
	String Function Get()
		Return "Mentalities.Confidence.Score"
	EndFunction
EndProperty
String Property ConfidenceTitle
	String Function Get()
		Return "Mentalities.Confidence.Title"
	EndFunction
EndProperty
String Property ObedienceKey
	String Function Get()
		Return "Mentalities.Obedience.Score"
	EndFunction
EndProperty
String Property ObedienceTitle
	String Function Get()
		Return "Mentalities.Obedience.Title"
	EndFunction
EndProperty
String Property SubDomKey
	String Function Get()
		Return "Mentalities.SubDom.Score"
	EndFunction
EndProperty
String Property SubDomTitle
	String Function Get()
		Return "Mentalities.SubDom.Title"
	EndFunction
EndProperty
;midfold -FetishKeys
String Property VagKey
	String Function Get()
		Return "Mentalities.Fetish.Vaginal"
	EndFunction
EndProperty
String Property VagTitle
	String Function Get()
		Return "Mentalities.Fetish.VaginalTitle"
	EndFunction
EndProperty
String Property AnalKey
	String Function Get()
		Return "Mentalities.Fetish.Anal"
	EndFunction
EndProperty
String Property AnalTitle
	String Function Get()
		Return "Mentalities.Fetish.AnalTitle"
	EndFunction
EndProperty
String Property OralKey
	String Function Get()
		Return "Mentalities.Fetish.Oral"
	EndFunction
EndProperty
String Property OralTitle
	String Function Get()
		Return "Mentalities.Fetish.OralTitle"
	EndFunction
EndProperty
String Property FurryKey
	String Function Get()
		Return "Mentalities.Fetish.Furry"
	EndFunction
EndProperty
String Property FurryTitle
	String Function Get()
		Return "Mentalities.Fetish.FurryTitle"
	EndFunction
EndProperty
String Property VictimKey
	String Function Get()
		Return "Mentalities.Fetish.Victimized"
	EndFunction
EndProperty
String Property VictimTitle
	String Function Get()
		Return "Mentalities.Fetish.VictimizedTitle"
	EndFunction
EndProperty
;midfold -

;endfold

Event OnInit() ;Empty for now, populate arrays __FIXME

	;Outsource to extra Mnt_Setup Script

	;beginfold -Title Filling - Stats
		;Will power
		WillTitles = New String[9]
		WillTitles[0] = "Rank -4";
		WillTitles[1] = "Rank -3";
		WillTitles[2] = "Rank -2";
		WillTitles[3] = "Rank -1";
		WillTitles[4] = "Rank 0";
		WillTitles[5] = "Rank 1";
		WillTitles[6] = "rank 2";
		WillTitles[7] = "Rank 3";
		WillTitles[8] = "Rank 4";
		
		;Confidence
		ConfTitles = New String[9]
		ConfTitles[0] = "Rank -4";
		ConfTitles[1] = "Rank -3";
		ConfTitles[2] = "Rank -2";
		ConfTitles[3] = "Rank -1";
		ConfTitles[4] = "Rank 0";
		ConfTitles[5] = "Rank 1";
		ConfTitles[6] = "rank 2";
		ConfTitles[7] = "Rank 3";
		ConfTitles[8] = "Rank 4";
		
		;Obedience
		ObedTitles = New String[9]
		ObedTitles[0] = "Obedient 4";
		ObedTitles[1] = "Obedient 3";
		ObedTitles[2] = "Obedient 2";
		ObedTitles[3] = "Obedient 1";
		ObedTitles[4] = "Neutral";
		ObedTitles[5] = "Resistant 1";
		ObedTitles[6] = "Resistant 2";
		ObedTitles[7] = "Resistant 3";
		ObedTitles[8] = "Resistant 4";
		
		;Sub/Dom
		SubTitles = New String[9]
		SubTitles[0] = "sub 4";
		SubTitles[1] = "sub 3";
		SubTitles[2] = "sub 2";
		SubTitles[3] = "sub 1";
		SubTitles[4] = "neither";
		SubTitles[5] = "dom 1";
		SubTitles[6] = "dom 2";
		SubTitles[7] = "dom 3";
		SubTitles[8] = "dom 4";
		
	;midfold -Title filling - Fetishes
		;__FIXME
	;midfold -Preset Fillinf
	Presets = New String[7] ;Populate preset Titles
	;Fill Pre* Arrays with corresponding Stats, do that in order so this is easy to follow

	;endfold
EndEvent

Function StartUp(Actor Target = none, Bool FreshStart = False); Initializes Values on an actor, Eventually needed for running other actors.
	If Target == none
		Target = PlayerAlias.GetReference() as Actor
		;No Target passed, assume player
	Else
		
	EndIf

	If (FreshStart == True) || (GetIntValue(Target, "Mentalities.Running", -1) == -1)
		;Mod hasn't started on this actor or is being reset.
		int Gender = SexLab.GetGender(Target); 0 male, 1 female, >=2 creature, haven't figured out which numbers correspond to m/f creatures
		SetIntValue(Target, "Mentalities.Gender", Gender)
		;Initialize values to default state
		;;STATS
	Else
		;Mod has started
		
		;Make sure all the values are where they should be
	
	EndIf
	
	
EndFunction

Int Function GetStat(Int Idx, Bool Rank = False) ;DONE
	;0  WP
	;1  Conf
	;2  Obed
	;3  Sub
	;4+ None
	
	If Idx == 0
		;WP
		Return GetIntValue(PlayerAlias.GetReference(), WillKey);
	ElseIf Idx == 1
		;Conf
		Return GetIntValue(PlayerAlias.GetReference(), ConfidenceKey);
	ElseIf Idx == 2
		;Obed
		Return GetIntValue(PlayerAlias.GetReference(), ObedienceKey);
	ElseIf Idx == 3
		;Sub
		Return GetIntValue(PlayerAlias.GetReference(), SubDomKey);
	Else
		;Error code not yet implemented
	EndIf
EndFunction

String Function GetTitle(Int Idx) ;ReCalc Titles
	;0  WP
	;1  Conf
	;2  Obed
	;3  Sub
	;4+ None
	
	If Idx == 0
		;WP
		Return GetStringValue(PlayerAlias.GetReference(), WillTitle, "ERROR");
	ElseIf Idx == 1
		;Conf
		Return GetStringValue(PlayerAlias.GetReference(), ConfidenceTitle, "ERROR");
	ElseIf Idx == 2
		;Obed
		Return GetStringValue(PlayerAlias.GetReference(), ObedienceTitle, "ERROR");
	ElseIf Idx == 3
		;Sub
		Return GetStringValue(PlayerAlias.GetReference(), SubDomTitle, "ERROR");
	Else
		Return "ERROR";
	EndIf
	
EndFunction

Int Function GetFetishVal(Int Idx, Bool Rank = False)
;0 victimized
;1 vag
;2 or
;3 an
;4 bottom/top (negative=bottom, pos=top)
;5 group
;6 best
;7 fur
;8 scales
;9
;10
;11
;12
;13
;14
;15
;16
EndFunction

String Function GetFetishTitle(Int Idx)

EndFunction

Float[] Function PainAndPleasure(sslThreadModel Thread) ;DONE FOR BETA ; implement race, fix penetrate

	;Player for now, will modify to support NPCs soon
	Int Gender = GetIntValue(PlayerAlias.GetReference(), "Mentalities.Gender", 0)

	If(Config.Tracelog)
		Debug.Trace("__FIXME")
	EndIf
	
	Float[] PnP = new float[2];
	;Retrns PnP[0]=Pain__PnP[1]=Pleasure
	Float BasePain = 0;
	Float BasePleasure = 0;
	Bool Consensual = True;
	Bool PlayerBottom = True;
	Bool Group = False;
	Bool Penetration = True;
	Bool Vaginal = False;
	Bool Oral = False;
	Bool Anal = False;
	Bool Creature = Thread.HasCreature;
	Bool Khajiit = False;
	Bool Argonian = False;
	
	;Number of actors, early abort for masturbation
	If (Thread.ActorCount > 2)
		Group = True
	ElseIf (Thread.ActorCount == 2)
		Group = False
	Else
		;Handle Masturbation
		Return PainAndPleasure_Solo(Thread);
	EndIf
	
	;Is it aggressive?
	If (Thread.IsAggressive)
		Consensual = False;
	Else
		Consensual = True;
	EndIf
	
	;Player pitching or catching?
	If Thread.IsVictim(PlayerRef) || Thread.GetPlayerPosition() != 0
		PlayerBottom = True
	Else 
		PlayerBottom = False
	EndIf
	
	;Commence tag retrieval
	;Note: Tag searching may be updated in future releases to include any 
	String[] Tags = Thread.GetTags();
	
	If Tags.Find("Vaginal") != -1 || Tags.Find("vaginal") != -1
		;Vaginal
		Vaginal = True;
		;Incrememnt pain and pleasure values by the appropriate amounts
		If PlayerBottom == True 
			If Gender == 1
				BasePain += 20
				BasePleasure += 40
			Else
				BasePain += 10
				BasePleasure += 30				
			EndIf
		Else
			If Gender == 1
				BasePain += 15
				BasePleasure += 40				
			Else
				BasePain += 10
				BasePleasure += 30				
			EndIf		
		EndIf
	EndIf
	
	If Tags.Find("Anal") != -1 || Tags.Find("anal") != -1
		;Anal
		Anal = True
		;Incrememnt pain and pleasure values by the appropriate amounts
		If PlayerBottom == True 
			If Gender == 1
				BasePain += 40
				BasePleasure += 30
			Else
				BasePain += 20
				BasePleasure += 40				
			EndIf
		Else
			If Gender == 1
				BasePain += 30
				BasePleasure += 40				
			Else
				BasePain += 10
				BasePleasure += 40				
			EndIf		
		EndIf
	EndIf
	
	If Tags.Find("Oral") != -1 || Tags.Find("oral") != -1
		;Oral
		Oral = True
		;Incrememnt pain and pleasure values by the appropriate amounts
		;;FIXME: Currently assumes BJ, will implement check for cunni soon
		If PlayerBottom == True 
			If Gender == 1
				BasePain += 5
				BasePleasure += 10
			Else
				BasePain += 5
				BasePleasure += 15				
			EndIf
		Else
			If Gender == 1
				BasePain += 5
				BasePleasure += 15				
			Else
				BasePain += 0
				BasePleasure += 20				
			EndIf		
		EndIf
		;;FIXME: Deepthroat mod
	EndIf
	
	If Tags.Find("Creature") != -1 || Tags.Find("creature") != -1 ;__FIXME: Doublecheck the damn tag
		;Creature
		;;FIXME: More thorough, right now just a base mod
		Creature = True;
		If Consensual == True
			BasePain += 20
			BasePleasure += 15
		Else
			BasePain += 30
			BasePleasure += 15
		EndIf
	EndIf
	
	;Furry check   (Khajiit and Lykaios)
	int i = 1;
	While i <= Thread.ActorCount
		If i != Thread.GetPlayerPosition()
			If Thread.Positions[i].GetRace() == KhajiitRace
				Khajiit = True;
			EndIf
		EndIf
	EndWhile
	;Scalie check  (Argonian)
	i = 1;
	While i <= Thread.ActorCount
		If i != Thread.GetPlayerPosition()
			If Thread.Positions[i].GetRace() == ArgonianRace
				Argonian = True;
			EndIf
		EndIf
	EndWhile
	;__FIXME Check that these work
	
	;Check for penetration: Planned feature. Needs more research into tags.
		;Crude: check if animation is designed for MF or 
		
	Bool[] Paramaters = New Bool[10];
	Paramaters[0] = Consensual;
	Paramaters[1] = PlayerBottom;
	Paramaters[2] = Group;
	Paramaters[3] = Penetration;
	Paramaters[4] = Vaginal;
	Paramaters[5] = Oral;
	Paramaters[6] = Anal;
	Paramaters[7] = Creature;
	Paramaters[8] = Khajiit; (furry)
	Paramaters[9] = Argonian; Scalie
	
	Float FetMult = FetMult(Paramaters);
	If (FetMult <= 0.0)
		FetMult = 0.05;Prevents negative or zero values
	EndIf
	PnP[0] = PnP[0] / FetMult; values greater than 1 decrease pain, lower increase
	PnP[1] = PnP[1] * FetMult; vice versa
EndFunction

Float[] Function PainAndPleasure_Solo(sslThreadModel Thread) ;CURRENTLY just placeholders, try again later
	Float[] PlaceholderVals = new Float[2];
	PlaceholderVals[0] = 1.2;
	PlaceholderVals[1] = 0.4;
	
	;Will be based entirely off of player skill in whichever act
	
EndFunction

Float[] Function PainAndPleasure_Args(Bool[] Args)
;Array must be in specific format, essentially which tags are present. Only use this if your mod is causing something that wouldn't be regularly tracked.
EndFunction

Float Function FetMult(Bool[] Paramaters) ;DONE for now, may modify calculation, add more fet, new interactions
	;Check player fetish values
	;If it is true in the parameters, pull the value down.
	;mult starts at 1.0
	;values plus or minus rank times .05
	
	Float FetMult = 1.0;
	
	If (Paramaters[0]);NoCon
		FetMult = FetMult + (0.05*GetFetishVal(0, True));
	EndIf
	If Paramaters[1];bottom
		FetMult = FetMult - (0.05*GetFetishVal(4, True));Is on bottom but does not want to be, modifier inverted
	Else
		FetMult = FetMult + (0.05*GetFetishVal(4, True));
	EndIf
	If Paramaters[2];Group
		;;Fixme: group applies raw mod to base too
		FetMult = FetMult + (0.05*GetFetishVal(5, True));
	EndIf
	;If Parameters [3]
		;penetration 
	;EndIf ;Currently not involved until check can be refined
	If Paramaters[4];v 
		FetMult = FetMult + (0.05*GetFetishVal(1, True));
	EndIf
	If Paramaters[5];o 
		FetMult = FetMult + (0.05*GetFetishVal(2, True));
	EndIf 
	If Paramaters[6];a 
		FetMult = FetMult + (0.05*GetFetishVal(3, True));
	EndIf
	If Paramaters[7];best 
		FetMult = FetMult + (0.05*GetFetishVal(6, True));
	EndIf
	
	;fur;sca
	
EndFunction


;__FIXME: little book has rules for this
Function FetishUpdate(Actor Target, Float[] PnP, Bool[] Parameters, sslThreadModel Thread)
	If (PnP.length != 2)
		;FIXME: Log error
		return;
	ElseIf (PnP[0] == -1) || (PnP[1] == -1)
		;Update titles only
		;In case a cylinder somewhere isn't firing
	Endif
	;Use PnP & Paramaters to change necessary fet scores. Use thread only to extract information abuot races_creatures
	
	;Apply new effects if necessary
	;Update title and value in storageutil
EndFunction

Function StatUpdate(Actor Target, Float[] PnP, Bool[] Parameters, sslThreadModel Thread)

EndFunction 