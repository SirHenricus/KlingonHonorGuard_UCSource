//=============================================================================
// KlingonMenuHelp.
//=============================================================================
class KlingonMenuHelp expands KlingonMenu
	config
	localized;

function bool ProcessSelection()
{
	local Menu ChildMenu;

	if ( Selection == 1 )
		PlayerOwner.ConsoleCommand("START ..\\help\\trouble.htm");
	else
		return false;

	return true;
}

function DrawMenu(canvas Canvas)
{
	DrawBackGround(Canvas, false);
	
	// draw text
	KDrawList( Canvas, 320, 0);

	// Draw help panel
	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     MenuLength=1
     HelpMessage(2)="OPEN THE TROUBLESHOOTING DOCUMENT"
     MenuTitle="HELP"
}
