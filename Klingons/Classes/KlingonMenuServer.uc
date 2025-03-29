//=============================================================================
// KlingonMenuServer.
//=============================================================================
class KlingonMenuServer expands KlingonMenu
	config
	localized;

var config string[64] Map;
var config string[32] GameType;
var config string[32] Games[16];
var config int MaxGames;
var int CurrentGame;
var class<GameInfo> GameClass;
var bool bStandalone;
var() localized string[32] BotTitle;
var() localized string[64] Info1;
var() localized string[64] Info2;
var bool 	IsMPOk;

function PostBeginPlay()
{
	Super.PostBeginPlay();

//	if ( class'GameInfo'.Default.bShareware )
//		MaxGames = 2;

	CurrentGame = 0;
	SetGameClass();
	IsMPOk = true;
}

function SetGameClass()
{
	GameType = Games[CurrentGame];
	GameClass = class<gameinfo>(DynamicLoadObject(GameType, class'Class'));
	Map = GetMapName(GameClass.Default.MapPrefix, Map,0);
}

function bool ProcessLeft()
{
	if ( Selection == 1 )
	{
		CurrentGame--;
		if ( CurrentGame < 0 )
			CurrentGame = MaxGames;
		SetGameClass();
		if ( GameClass == None )
		{
			MaxGames--;
			if ( MaxGames > 0 )
				ProcessLeft();
		}
	}
	else if ( Selection == 2 )
		Map = GetMapName(GameClass.Default.MapPrefix, Map, -1);
	else 
		return false;

	return true;
}

function bool ProcessRight()
{
	if ( Selection == 1 )
	{
		CurrentGame++;
		if ( CurrentGame > MaxGames )
			CurrentGame = 0;
		SetGameClass();
		if ( GameClass == None )
		{
			MaxGames--;
			if ( MaxGames > 0 )
				ProcessRight();
		}
	}
	else if ( Selection == 2 )
		Map = GetMapName(GameClass.Default.MapPrefix, Map, 1);
	else
		return false;

	return true;
}

function bool ProcessSelection()
{
	local Menu ChildMenu;
	local string[240] URL;
	local string[32] prstrq;
	
	if ( IsMPOk == false )
	{
		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
			
		if ( prstrq == "mpgameplay" )
		{
			IsMPOk = true;
			Level.Game.Difficulty = 3;
			Level.Game.SaveConfig();
		}
		else 
		{
			IsMPOk = false;
			return true;
		}
	}
		
	if( Selection == 3 )
	{
		if ( true == bStandAlone )
		{
			if ( class'KlingonMenuTeamGameOptions' == GameClass.Default.GameMenuType ) 
				ChildMenu = spawn( class'KlingonMenuGameOptionsTeamBot', owner );
			else if ( Class'KlingonMenuDMGameOptions' == GameClass.Default.GameMenuType )
				ChildMenu = spawn( class'KlingonMenuGameOptionsDMBot', owner );
			else // Class'Klingons.KlingonMenuGameOptions'
				ChildMenu = spawn( GameClass.Default.GameMenuType, owner );
		}
		else
			ChildMenu = spawn( GameClass.Default.GameMenuType, owner );
		HUD(Owner).MainMenu = ChildMenu;
		ChildMenu.ParentMenu = self;
		ChildMenu.PlayerOwner = PlayerOwner;
		return true;
	}
	else if ( Selection == 4 )
	{
		GameClass = class<gameinfo>(DynamicLoadObject(GameType, class'Class'));
		URL = Map $ "?Game=" $ GameType;
		if( !bStandAlone ) //&& Level.Netmode!=NM_ListenServer )
			URL = URL $ "?Listen";
					
		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
			
		if ( prstrq == "mpgameplay" )
		{
			IsMPOk = true;
			Level.Game.Difficulty = 3;
			Level.Game.SaveConfig();
		}
		else 
		{
			IsMPOk = false;
			return true;
		}

		if ( GameType == "Klingons.COOPGAME" )
		{
			Level.Game.Difficulty = 3;
			Level.Game.SaveConfig();
		}

		ChildMenu = spawn(class'KlingonMenuMesh', owner);
		if ( ChildMenu != None )
		{
			KlingonMenuMesh(ChildMenu).StartMap = URL;
			HUD(Owner).MainMenu = ChildMenu;
			ChildMenu.ParentMenu = self;
			ChildMenu.PlayerOwner = PlayerOwner;
		}
		log( "URL: '" $ URL $ "'" );
		return true;
	}
	else if ( Selection == 5 )
	{
		GameClass = class<gameinfo>(DynamicLoadObject(GameType, class'Class'));
		URL = Map $ "?Game=" $ GameType;
		SaveConfigs();
		PlayerOwner.ConsoleCommand("RELAUNCH "$URL$" -server");
		return true;
	}
	else return false;
}

function SaveConfigs()
{
	SaveConfig();
	PlayerOwner.SaveConfig();
}

function DrawMenu(canvas Canvas)
{
	local int i, StartX, StartY, Spacing;
	local string[32] MapName;

	// Draw Title
	if ( bStandAlone )
	{
		MenuLength = 4;
		MenuTitle = BotTitle;
	}

	DrawBackGround(Canvas, false);
		
	if ( IsMPOk == false )
	{
		KDrawMsg ( Canvas );
		return;
	}
				
	// draw text
	for( i=1; i<MenuLength+1; i++ )
		MenuList[i] = Default.MenuList[i];

	KDrawList( Canvas, 140, 0);

	// draw values
	if ( GameType == "Klingons.DEATHMATCHGAME" )
		MenuValues[1] = "DEATHRITE";
	else
		MenuValues[1] = GameType;
	
	i = InStr(MenuValues[1], ".");
	if( i != -1 )
		MenuValues[1] =  Right(MenuValues[1], Len(MenuValues[1]) - i - 1);
	MapName = Left(Map, Len(Map) - 4 );	
	MenuValues[2] = MapName;
	MenuValues[3] = "";
	MenuValues[4] = "";
	MenuValues[5] = "";
	KDrawChangeList(Canvas, 0, 0);
	
	// Draw help panel
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
     Map="DR01.unr"
     GameType="Klingons.DEATHMATCHGAME"
     Games(0)="Klingons.DEATHMATCHGAME"
     Games(1)="Klingons.TEAMGAME"
     Games(2)="Klingons.COOPGAME"
     MaxGames=2
     BotTitle="BOTMATCH"
     Info1="Insert the Gameplay CD-ROM and press ENTER"
     Info2="Insert the Install CD-ROM and press ENTER"
     MenuLength=5
     HelpMessage(1)="CHOOSE GAME TYPE"
     HelpMessage(2)="CHOOSE MAP"
     HelpMessage(3)="MODIFY GAME OPTIONS"
     HelpMessage(4)="START GAME"
     HelpMessage(5)="START A DEDICATED SERVER ON THIS MACHINE"
     MenuList(1)="SELECT GAME"
     MenuList(2)="SELECT MAP"
     MenuList(3)="CONFIGURE GAME"
     MenuList(4)="START GAME"
     MenuList(5)="LAUNCH DEDICATED SERVER"
     MenuTitle="MULTIPLAYER"
}
