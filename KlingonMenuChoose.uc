//=============================================================================
// KlingonMenuChoose.
//=============================================================================
class KlingonMenuChoose expands KlingonMenu
	localized;

var config string[64] StartMaps[20];
var config string[64] GameNames[20];

function bool ProcessSelection()
{
	local Menu ChildMenu;

	ChildMenu = spawn(class'KlingonMenuNewGame', owner);
	HUD(Owner).MainMenu = ChildMenu;
	ChildMenu.PlayerOwner = PlayerOwner;
	PlayerOwner.UpdateURL("Game=");
	KlingonMenuNewGame(ChildMenu).StartMap = StartMaps[Selection];

	if ( MenuLength == 1 )
	{
		ChildMenu.ParentMenu = ParentMenu;
		Destroy();
	}
	else
		ChildMenu.ParentMenu = self;
}

function DrawMenu(canvas Canvas)
{
	local int i;

	DrawBackGround(Canvas, false);

	if ( MenuLength == 1 )
	{
		Selection = 1;
		ProcessSelection();
		return;
	}

	Canvas.Style = 3;

	// draw text
	for ( i=0; i<20; i++ )
		MenuList[i] = GameNames[i];
		
	KDrawList(Canvas, 320, 0);

	// Draw help panel
	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     StartMaps(1)="..\\maps\\M02.unr"
     GameNames(1)="Klingons"
     MenuLength=1
     HelpMessage(1)="Choose which game to play."
     HelpMessage(2)="Choose which game to play."
     HelpMessage(3)="Choose which game to play."
     HelpMessage(4)="Choose which game to play."
     HelpMessage(5)="Choose which game to play."
     HelpMessage(6)="Choose which game to play."
     HelpMessage(7)="Choose which game to play."
     HelpMessage(8)="Choose which game to play."
     HelpMessage(9)="Choose which game to play."
     HelpMessage(10)="Choose which game to play."
     HelpMessage(11)="Choose which game to play."
     HelpMessage(12)="Choose which game to play."
     HelpMessage(13)="Choose which game to play."
     HelpMessage(14)="Choose which game to play."
     HelpMessage(15)="Choose which game to play."
     HelpMessage(16)="Choose which game to play."
     HelpMessage(17)="Choose which game to play."
     HelpMessage(18)="Choose which game to play."
     HelpMessage(19)="Choose which game to play."
     HelpMessage(20)="Choose which game to play."
     HelpMessage(21)="Choose which game to play."
     HelpMessage(22)="Choose which game to play."
     HelpMessage(23)="Choose which game to play."
     MenuTitle="CHOOSE GAME"
}
