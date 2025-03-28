//=============================================================================
// EndGameTrigger.
//=============================================================================
class EndGameTrigger expands KlingonTrigger;

function Touch(actor Other)
{
}

function Trigger(actor Other,pawn InstigatedBy)
{
	Level.Game.EndGame();
}

defaultproperties
{
}
