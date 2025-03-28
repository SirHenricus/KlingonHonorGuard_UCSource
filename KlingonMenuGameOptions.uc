//=============================================================================
// KlingonMenuGameOptions.
//=============================================================================
class KlingonMenuGameOptions expands KlingonMenu
	config
	localized;

var() localized string[64] AdvancedString;
var() localized string[128] AdvancedHelp;
var   config bool bCanModifyGore;
var() class<GameInfo> GameClass;
var	  GameInfo	GameType;
var   bool      bSetup;

function Destroyed()
{
	Super.Destroyed();
	if ( GameType != Level.Game )
		GameType.Destroy();
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	if ( Level.Game.Class == GameClass )
		GameType = Level.Game;
	else
		GameType = Spawn(GameClass);
}

function MenuProcessInput( byte KeyNum, byte ActionNum )
{
	Super.MenuProcessInput(KeyNum, ActionNum);

	if ( KeyNum == EInputKey.IK_Up )
	{
		if ( bCanModifyGore == true )
		{
			if ( Selection <= 1 )
				Selection = MenuLength;
		}
		else
		{
			if ( Selection <= 2 )
				Selection = MenuLength;
		}
	}
	else if ( KeyNum == EInputKey.IK_Down )
	{
		if ( bCanModifyGore == true )
		{
			if ( Selection == 1 )
				Selection = 2;
		}
		else
		{
			if ( ( Selection == 1 ) || ( Selection == 2) )
				Selection = 3;
		}
	}
}


function bool ProcessLeft()
{
//	if ( Selection == 1 )
//		GameType.SetGameSpeed(FMax(0.5, Level.TimeDilation - 0.1));
//	else if ( (Selection == 2) && bCanModifyGore )
	if ( (Selection == 2) && bCanModifyGore )
	{
		GameType.bLowGore = !GameType.bLowGore;
		Level.Game.bLowGore = GameType.bLowGore;
	}
	else 
		return false;

	return true;
}

function bool ProcessRight()
{
//	if ( Selection == 1 )
//		GameType.SetGameSpeed(FMin(2.0, Level.TimeDilation + 0.1));
//	else if ( (Selection == 2) && bCanModifyGore )
	if ( (Selection == 2) && bCanModifyGore )
	{
		GameType.bLowGore = !GameType.bLowGore;
		Level.Game.bLowGore = GameType.bLowGore;
	}
	else 
		return false;

	return true;
}



function SaveConfigs()
{
	if ( GameType != None )
		GameType.SaveConfig();
	PlayerOwner.SaveConfig();
	PlayerOwner.myHUD.SaveConfig();	
}


function DrawValues(canvas Canvas)
{
	local int s;

//	s = 10 * (GameType.GameSpeed + 0.02);
//	MenuValues[1] = (""$(10 * s)$"%");
	if ( bCanModifyGore )
	{
//		MenuValues[2] = string(GameType.bLowGore);
		MenuValues[2] = string(Level.Game.bLowGore);
	}
	else
	{
		MenuValues[2] = "";
	    HelpMessage[2]="";
	}
		
	
	KDrawChangeList(Canvas, 370, 0);  
}


function DrawOptions(canvas Canvas)
{
//	MenuList[1] = Default.MenuList[1];
	if ( bCanModifyGore )
		MenuList[2] = Default.MenuList[2];
	else
	{
		MenuList[2] = "";
	    HelpMessage[2]="";
	}

	KDrawList(Canvas, 150, 0);
}

function DrawMenu(canvas Canvas)
{
	DrawBackGround(Canvas, false);

	if ( !bSetup )
		SetUpDisplay();

	DrawOptions(Canvas);
	
	DrawValues(Canvas);

	// Draw help panel
	KDrawHelpPanel(Canvas);
}


function SetUpDisplay()
{	
	bSetup = true;
	Selection = 2;
}

defaultproperties
{
     AdvancedString="Advanced Options"
     AdvancedHelp="Edit advanced game configuration options."
     bCanModifyGore=True
     GameClass=Class'Klingons.KlingonGameInfo'
     MenuLength=2
     HelpMessage(1)=""
     HelpMessage(2)="REDUCES THE GORE IN THE GAME"
     MenuList(1)=""
     MenuList(2)="REDUCED GORE"
     MenuTitle="GAME OPTIONS"
}
