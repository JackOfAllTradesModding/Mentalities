ScriptName Mnt_MCM Extends SKI_ConfigBase
{The MCM for Mentalities}

Mnt_Core Property Core Auto; Mentalities main script.

GlobalVariable Property Mnt_SuperSecretOption Auto ;bool
Bool Property Tracelog Auto

Event OnConfigInit()
	;Pages
	If Mnt_SuperSecretOption.GetValue() != 1
		Pages = New String[4];
		Pages[0] = "General";General Config:Enable/disable basic things, select preset for player, start mod
		Pages[1] = "Fetishes";Fetishes-Enable disable fetish and detrimental effects.
		Pages[2] = "Consequences";Consequences - enable or disable built in consequences. Find simple way to trick reliant mods
		;Super secret page to modify player stats directly
	Else
		Pages = New String[5];
		Pages[0] = "General";General Config:Enable/disable basic things, select preset for player, start mod
		Pages[1] = "Fetishes";Fetishes-Enable disable fetish and detrimental effects.
		Pages[2] = "Consequences";Consequences - enable or disable built in consequences. Find simple way to trick reliant mods
		PAges[4] = "Super Secret Menu"
	EndIf
	
	
EndEvent

Event OnConfigOpen()
	;Pages, because I think ConfigInit is only sent when the game loads
	;Testing required
	If Mnt_SuperSecretOption.GetValue() != 1
		Pages = New String[4];
		Pages[0] = "General";General Config:Enable/disable basic things, select preset for player, start mod
		Pages[1] = "Fetishes";Fetishes-Enable disable fetish and detrimental effects.
		Pages[2] = "Consequences";Consequences - enable or disable built in consequences. Find simple way to trick reliant mods
		;Super secret page to modify player stats directly
	Else
		Pages = New String[5];
		Pages[0] = "General";General Config:Enable/disable basic things, select preset for player, start mod
		Pages[1] = "Fetishes";Fetishes-Enable disable fetish and detrimental effects.
		Pages[2] = "Consequences";Consequences - enable or disable built in consequences. Find simple way to trick reliant mods
		Pages[4] = "Super Secret Menu";Super secret page to modify player stats directly
	EndIf
EndEvent


Event OnPageReset(String Qpage)

	If (Qpage == "")
		LoadCustomContent("Mentalities/Mentalities_Flash.dds", 143, 0)
		;X = 376 - (width/2) = 376- (446/2) = 376 - 223 = 143
		;Y = 223 - (height/2) = 223 - (446/2) = 223 - 223 = 0
	Else
		UnloadCustomContent();
	EndIf
	
	;Player stats need to be dispalyed somewhere
	
	If (Qpage == "General")
		SetCursorPosition(0);
		SetCursorFillMode(TOP_TO_BOTTOM);
		
	ElseIf (Qpage == "Fetishes")
		SetCursorPosition(0);
		SetCursorFillMode(LEFT_TO_RIGHT);
		;Break into sections
		
		;Header lines, then left to right
		AddHeaderOption("Fetish Options");
		AddHeaderOption("");
		
		;Repeat below
		;Name(Header) -- Status(Display Rank/Name of rank)
		;Enable(Toggle) -- Buffs/Debuffs(Info, displays message box????)
		;Blank row--->
		AddHeaderOption("Vaginal");
		AddHeaderOption("")
		
		
	ElseIf (Qpage == "Consequences");Enables configuration of consequences portion.
		;Left Column For buffs/debuffs
		;Right column for plugin added events/scenes/dialogues
		
		;May need second page
	ElseIF (Qpage == "Help");Help/Debug
		SetCursorPosition(0);
		SetCursorFillMode(TOP_TO_BOTTOM);
		;Enable Logging
		;Reset Stats
		;Stop/restart Tracker
		
		
	ElseIf (Qpage == "Super Secret Menu");Secret page only accessible by setting a global variable. Allows direct modification of stats.
		SetCursorPosition(0);
		SetCursorFillMode(LEFT_TO_RIGHT);
		
		;Stat+Slider -- Title
		
	EndIf
	
EndEvent;