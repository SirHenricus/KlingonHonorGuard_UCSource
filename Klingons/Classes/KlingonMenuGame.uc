//=============================================================================
// KlingonMenuGame.
//=============================================================================
class KlingonMenuGame expands KlingonMenu
	localized;

var string[255] curmap;
var() localized string[64] Info1;
var() localized string[64] Info2;
var bool IsMPOk;
var bool bSetup;


function SetUpMenu()
{
	bSetup = true;
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

//	if ( class'GameInfo'.Default.bShareware )
//		MaxGames = 2;

	IsMPOk = true;
}


function bool ProcessSelection()
{
	local Menu ChildMenu;
	local string[32] prstrq;
	
	if ( IsMPOk == false )
	{
		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
			
		if ( prstrq == "mpgameplay" )
		{
			IsMPOk = true;
		}
		else 
		{
			IsMPOk = false;
			return true;
		}
	}

	if ( Selection == 1 )
	{
		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
		
		if ( prstrq == "mpgameplay" )
		{
			IsMPOk = true;
		}
		else 
		{
			IsMPOk = false;
			return true;
		}
		ChildMenu = spawn(class'KlingonMenuChoose', owner);		
	}
	else if ( (Selection == 2) && (Level.NetMode == NM_Standalone)
				&& !Level.Game.IsA('DeathMatchGame') )
	{				
		if ( Level.Title == "KLINGON" )
			return true;
			
		ChildMenu = spawn(class'KlingonMenuSave', owner);
	}
	else if ( ( Selection == 3 ) && (Level.NetMode == NM_Standalone)
				&& !Level.Game.IsA('DeathMatchGame') )
	{
		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
		
		if ( prstrq == "mpgameplay" )
		{
			IsMPOk = true;
		}
		else 
		{
			IsMPOk = false;
			return true;
		}

		ChildMenu = spawn(class'KlingonMenuLoad', owner);
	}
	else if ( ( Selection == 4 ) && (Level.NetMode == NM_Standalone)
				&& !Level.Game.IsA('DeathMatchGame') )
	{
		if ( Level.Title == "KLINGON" )
			return true;

		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
		
		if ( prstrq == "mpgameplay" )
		{
			IsMPOk = true;
		}
		else 
		{
			IsMPOk = false;
			return true;
		}
		ChildMenu = spawn(class'KlingonMenuAVI', owner);
	}
	else if ( Selection == 5 )
	{
		if ( (Level.Game != None) && (Level.Game.GameMenuType != None) )
			ChildMenu = spawn(Level.Game.GameMenuType, owner);
	}
	else if ( Selection == 6 )
	{
		ChildMenu = spawn(class'KlingonMenuServer', owner);
		KlingonMenuServer(ChildMenu).bStandAlone = true;
	}
	else 
		return false;

	if ( ChildMenu != None )
	{
		HUD(Owner).MainMenu = ChildMenu;
		ChildMenu.ParentMenu = self;
		ChildMenu.PlayerOwner = PlayerOwner;
	}
	return true;
}

function SaveConfigs()
{
	Level.Game.SaveConfig();
}

function DrawMenu(canvas Canvas)
{
	DrawBackGround(Canvas, false);

	if ( IsMPOk == false )
	{
		KDrawMsg ( Canvas );
		return;
	}

	KDrawList(Canvas, 320, 0);
	KDrawHelpPanel(Canvas);
}


function KDrawMsg(canvas Canvas )
{
	local int StartX;
	local int StartY;
	local int DrawY;
	local int ClipX;
	local int ClipY;
	local int OldClipX;
	local int OldClipY;

	OldClipX = Canvas.ClipX;
	OldClipY = Canvas.ClipY;

	StartX = 120 * XRatio;
	StartY = 150 * YRatio;
	ClipY = 128 * YRatio;
	
	Canvas.bCenter = false;
	
	if ( Canvas.ClipX > 800 )
		ClipX = (Canvas.ClipX - (370 * XRatio)) * XRatio;
	else if ( Canvas.ClipX == 800 )
		ClipX = 532;
	else
		ClipX = (Canvas.ClipX - (200 * XRatio)) * XRatio;
		
	Canvas.SetOrigin( StartX, StartY );
	Canvas.SetClip(ClipX, ClipY);
	Canvas.SetPos(0,0);
	Canvas.Style = 1;
	SetFontBrightness(Canvas, true);	

	if ( OldClipY >= 400 )
		Canvas.Font = Font'hMRedFont';
	else
		Canvas.Font = Font'hSRedFont';

	if ( IsMpOk == false)
		Canvas.DrawText(Info1, False);
	
	SetFontBrightness(Canvas, false);
	
	Canvas.ClipX = OldClipX;
	Canvas.ClipY = OldClipY;
}

defaultproperties
{
     Info1="Insert the Gameplay CD-ROM and press ENTER"
     Info2="Insert the Install CD-ROM and press ENTER"
     MenuLength=6
     HelpMessage(1)="SELECT A DIFFICULTY LEVEL, AND START A NEW GAME."
     HelpMessage(2)="HIT ENTER TO SAVE THE CURRENT GAME."
     HelpMessage(3)="HIT ENTER TO LOAD A SAVED GAME."
     HelpMessage(4)="SHOW MISSION BRIEFING AGAIN"
     HelpMessage(5)="SPECIFIC GAME OPTIONS"
     HelpMessage(6)="DEATHMATCH AGAINST BOTS."
     MenuList(1)="NEW GAME"
     MenuList(2)="SAVE GAME"
     MenuList(3)="LOAD GAME"
     MenuList(4)="REPLAY MISSION BRIEFING"
     MenuList(5)="GAME OPTIONS"
     MenuList(6)="BOTMATCH"
     MenuTitle="GAME MENU"
}
