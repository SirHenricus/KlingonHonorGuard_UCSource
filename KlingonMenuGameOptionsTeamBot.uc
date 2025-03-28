//=============================================================================
// KlingonMenuGameOptionsTeamBot.
//=============================================================================
class KlingonMenuGameOptionsTeamBot expands KlingonMenuGameOptionsDMBot
	localized;

function bool ProcessLeft()
{
	if ( Selection == 8 )
		TeamGame(GameType).FriendlyFireScale = FMax(0, TeamGame(GameType).FriendlyFireScale - 0.1);
	else 
		return Super.ProcessLeft();

	return true;
}

function bool ProcessRight()
{
	if ( Selection == 8 )
		TeamGame(GameType).FriendlyFireScale = FMin(1, TeamGame(GameType).FriendlyFireScale + 0.1);
	else 
		return Super.ProcessRight();

	return true;
}

function DrawOptions(canvas Canvas)
{
	MenuList[8] = Default.MenuList[7];

	Super.DrawOptions(Canvas);
}

function DrawValues(canvas Canvas)
{
	MenuValues[8] = string(TeamGame(GameType).FriendlyFireScale);

	Super.DrawValues(Canvas);
}

defaultproperties
{
     GameClass=Class'Klingons.TeamGame'
     MenuLength=8
     HelpMessage(8)="% OF DAMAGE TAKEN WHEN HIT BY FRIENDLY FIRE."
     MenuList(8)="FRIENDLY FIRE SCALE"
}
