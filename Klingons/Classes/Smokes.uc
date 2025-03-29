//=============================================================================
// Smokes.
//=============================================================================
class Smokes expands KlingonEffects
	abstract;

var() bool		bRising;
var() float		RisingRate;

var Smokes		S;

function DetermineOwner()
{
	Super.DetermineOwner();
	if (Smokes(Owner) == None) {
		S=Self;
	}
	else {
		S=Smokes(Owner);
	}
}

state SpecialEffect
{
	function BeginState()
	{
		Super.BeginState();
		if (bRising) {
			SetPhysics(PHYS_Projectile);
			Velocity=(vect(0,0,1)*S.RisingRate)*(0.25+FRand());
		}
	}
}

defaultproperties
{
     RisingRate=50.000000
     ScaleRate=0.025000
     EffectTimer=0.100000
}
