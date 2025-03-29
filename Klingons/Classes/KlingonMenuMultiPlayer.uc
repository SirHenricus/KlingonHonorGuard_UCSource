//=============================================================================
// KlingonMenuMultiPlayer.
//=============================================================================
class KlingonMenuMultiPlayer expands KlingonMenu
	localized;

function bool ProcessSelection()
{
	local Menu ChildMenu;

	ChildMenu = None;

	if ( Selection == 1 )
		ChildMenu = spawn(class'KlingonMenuJoin', owner);
	else if ( Selection == 2 )
		ChildMenu = spawn(class'KlingonMenuServer', owner);
	else
		ChildMenu = spawn(class'KlingonMenuPlayer', owner);

	if ( ChildMenu != None )
	{
		HUD(Owner).MainMenu = ChildMenu;
		ChildMenu.ParentMenu = self;
		ChildMenu.PlayerOwner = PlayerOwner;
	}
	return true;
}

function DrawMenu(canvas Canvas)
{
	local int StartX, StartY, Spacing;

	DrawBackGround(Canvas, False);
	
	KDrawList( Canvas, 320, 0);
	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     MenuLength=3
     HelpMessage(1)="JOIN A NETWORK GAME."
     HelpMessage(2)="SET UP AND START A NETWORK GAME."
     HelpMessage(3)="CONFIGURE APPEARANCE, NAME, AND TEAM NAME."
     MenuList(1)="JOIN GAME"
     MenuList(2)="CREATE GAME"
     MenuList(3)="PLAYER SETUP"
     MenuTitle="MULTIPLAYER"
}
