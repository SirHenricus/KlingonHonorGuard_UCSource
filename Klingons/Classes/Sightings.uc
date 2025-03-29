//=============================================================================
// Sightings.
//=============================================================================
class Sightings expands KlingonEffects
	abstract;

simulated function EffectAnim(float delta)
{
	local vector	Pos;

	Super.EffectAnim(delta);
	if (PlayerPawn(Owner) != None) {
		Pos=Vector(PlayerPawn(Owner).ViewRotation);
	}
	else {
		Pos=Vector(Owner.Rotation);
	}
	Pos=Owner.Location+(Pos*100.0)+(vect(0,0,1)*50.0);
	SetLocation(Pos);
}

defaultproperties
{
     ScaleRate=0.020000
     ScaleGlowRate=-0.020000
     bNet=False
     bNetSpecial=False
     DrawScale=0.250000
}
