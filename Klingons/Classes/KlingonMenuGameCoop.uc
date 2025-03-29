//=============================================================================
// KlingonMenuGameCoop.
//=============================================================================
class KlingonMenuGameCoop expands KlingonMenuGame
	localized;

var() string[128] StartMap;

function Destroyed()
{
	Super.Destroyed();
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	Selection = Clamp(Level.Game.Difficulty + 1,1,4);
} 

function bool ProcessSelection()
{
	local Menu ChildMenu;

	Level.Game.Difficulty = Selection - 1;
	Level.Game.SaveConfig();
	ChildMenu = spawn(class'KlingonMenuCoop', owner);
	HUD(Owner).MainMenu = ChildMenu;
	ChildMenu.ParentMenu = self;
	ChildMenu.PlayerOwner = PlayerOwner;
	KlingonMenuSinglePlayer(ChildMenu).StartMap = StartMap;
	KlingonMenuSinglePlayer(ChildMenu).SinglePlayerOnly = false;
	return true;
}

function SaveConfigs();


function DrawMenu(canvas Canvas)
{
	DrawBackGround(Canvas, false);

	KDrawList(Canvas, 320, 0);

	// Draw help panel
	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     MenuLength=4
     HelpMessage(1)="WHAT PROFIT IS THERE IN DYING"
     HelpMessage(2)="P ' TAQ"
     HelpMessage(3)="You Die. Me Kill"
     HelpMessage(4)="TODAY is a good day to die"
     HelpMessage(5)=""
     HelpMessage(6)=""
     MenuList(1)="FERENGI"
     MenuList(2)="HUMAN"
     MenuList(3)="NAUSICAN"
     MenuList(4)="KLINGON"
     MenuList(5)=""
     MenuList(6)=""
}
