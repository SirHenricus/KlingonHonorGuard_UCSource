//=============================================================================
// KlingonMenuMain.
//=============================================================================
class KlingonMenuMain expands KlingonMenu
	localized;

var bool bBegun;

function bool ProcessSelection()
{
	local Menu ChildMenu;

	ChildMenu = None;
	if ( ! bBegun )
	{
		PlayEnterSound();
		bBegun = true;
	}

	if ( Selection == 1 )
		ChildMenu = spawn(class'KlingonMenuGame', owner);
	else if ( Selection == 2 )
		ChildMenu = spawn(class'KlingonMenuMultiPlayer', owner);
	else if ( Selection == 3 )
		ChildMenu = spawn(class'KlingonMenuOptions', owner);
	else if ( Selection == 4 )
		ChildMenu = spawn(class'KlingonMenuVideo', owner);
	else if ( Selection == 5 )	
		ChildMenu = spawn(class'KlingonMenuQuit', owner);

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
	DrawBackGround(Canvas, false);
	KDrawList( Canvas, 320, 0);
	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     MenuSlider(4)=None
     MenuSlider(5)=None
     MenuSlider(6)=None
     MenuSlider(7)=None
     MenuLength=5
     HelpMessage(1)="HIT ENTER TO  MODIFY GAME OPTIONS, NEW GAME, LOAD GAME, SAVING GAME AND STARTING A BOTMATCH."
     HelpMessage(2)="HIT ENTER TO PROCEED TO MULTIPLAYER MENU"
     HelpMessage(3)="HIT ENTER TO CUSTOMIZE CONTROLS."
     HelpMessage(4)="CHANGE SOUND AND DISPLAY OPTIONS"
     HelpMessage(5)="HIT ENTER TO QUIT GAME."
     MenuList(1)="GAME"
     MenuList(2)="MULTIPLAYER"
     MenuList(3)="OPTIONS"
     MenuList(4)="AUDIO/VIDEO"
     MenuList(5)="QUIT"
     MenuTitle="MAIN MENU"
}
