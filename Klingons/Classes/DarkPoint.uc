//=============================================================================
// DarkPoint.
//=============================================================================
class DarkPoint expands Keypoint;

var () byte Darkness;
var () bool bDarknessActive;




singular function Touch(Actor Other)
{
	if (bDarknessActive)
	{
		if (KlingonPlayer(Other) != none)
		{
			KlingonPlayer(Other).Darkness = Darkness;
		}
	}
}


singular function UnTouch(Actor Other)
{
	if (KlingonPlayer(Other) != none)
	{
		KlingonPlayer(Other).Darkness = 0;
	}
}

//function Trigger(actor Other,pawn EventInstigator)
//{
//	bDarknessActive=!bDarknessActive;
//}

defaultproperties
{
     Darkness=153
     bDarknessActive=True
     bCollideWhenPlacing=True
     CollisionRadius=30.000000
     CollisionHeight=50.000000
     bCollideActors=True
}
