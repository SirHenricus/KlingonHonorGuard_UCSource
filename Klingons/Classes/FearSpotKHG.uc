//=============================================================================
// FearSpotKHG.
//=============================================================================
class FearSpotKHG expands Triggers;

var() bool bInitiallyActive;

function Touch( actor Other )
{
	if ( bInitiallyActive && Other.IsA('KlingonPawn') )
		KlingonPawn(Other).FearThisSpot(self);
}

function Trigger( actor Other, pawn EventInstigator )
{
	bInitiallyActive = !bInitiallyActive;
}

defaultproperties
{
}
