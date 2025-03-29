//=============================================================================
// KlingonMenuQuit.
//=============================================================================
class KlingonMenuQuit expands KlingonMenu
	localized;

var   bool bResponse;
var() localized string[32] YesSelString;
var() localized string[32] NoSelString;


function bool ProcessYes()
{
	bResponse = true;
	return true;
}

function bool ProcessNo()
{
	bResponse = false;
	return true;
}

function bool ProcessLeft()
{
	bResponse = !bResponse;
	return true;
}

function bool ProcessRight()
{
	bResponse = !bResponse;
	return true;
}

function bool ProcessSelection()
{
	local Menu ChildMenu;

	ChildMenu = None;

	if ( bResponse )
	{
		PlayerOwner.SaveConfig();
		if ( Level.Game != None )
			Level.Game.SaveConfig();

		ChildMenu = spawn(class'KlingonMenuCredit', owner);
	}
	else ExitMenu();
	
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
	DrawBackGround(Canvas, (Canvas.ClipY < 320));
	
	Selection = 4;
	
	// draw text
	if ( bResponse )
		MenuValues[4] = YesSelString;
	else
		MenuValues[4] = NoSelString;
	
	KDrawList( Canvas, 0, 0);
	KDrawChangeList(Canvas, 0, 0);
}

defaultproperties
{
     YesSelString="[YES]  No"
     NoSelString=" Yes  [NO]"
     MenuLength=4
     HelpMessage(1)=""
     HelpMessage(4)="QUIT KLINGON HONOR GUARD"
     MenuList(1)=""
     MenuList(4)="Are You Sure?"
     MenuTitle="QUIT?"
}
