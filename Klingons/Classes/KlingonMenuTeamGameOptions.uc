//=============================================================================
// KlingonMenuTeamGameOptions.
//=============================================================================
class KlingonMenuTeamGameOptions expands KlingonMenuDMGameOptions
	localized;

function bool ProcessLeft()
{
	if ( Selection == 11 )
		TeamGame(GameType).FriendlyFireScale = FMax(0, TeamGame(GameType).FriendlyFireScale - 0.1);
	else 
		return Super.ProcessLeft();

	return true;
}

function bool ProcessRight()
{
	if ( Selection == 11 )
		TeamGame(GameType).FriendlyFireScale = FMin(1, TeamGame(GameType).FriendlyFireScale + 0.1);
	else 
		return Super.ProcessRight();

	return true;
}

function DrawOptions(canvas Canvas)
{
	MenuList[11] = Default.MenuList[10];

	Super.DrawOptions(Canvas);
}

function DrawValues(canvas Canvas)
{
	MenuValues[11] = string(TeamGame(GameType).FriendlyFireScale);

	Super.DrawValues(Canvas);
}

defaultproperties
{
     GameClass=Class'Klingons.TeamGame'
     MenuLength=11
     HelpMessage(11)="% OF DAMAGE TAKEN WHEN HIT BY FRIENDLY FIRE."
     MenuList(11)="FRIENDLY FIRE SCALE"
}
