//=============================================================================
// AirSmallExp.
//=============================================================================
class AirSmallExp expands AirExplosion;

auto state SpecialEffect
{
	simulated function BeginState()
	{
		Super.BeginState();
		if (ChildActor != None) {
			ChildActor.DrawScale=K.DrawScale;
		}
	}
}

defaultproperties
{
}
