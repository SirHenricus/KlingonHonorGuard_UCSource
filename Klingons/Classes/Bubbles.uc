//=============================================================================
// Bubbles.
//=============================================================================
class Bubbles expands KlingonEffects
	abstract;

simulated function Spawned()
{
	Buoyancy+=FRand();
	Velocity.X=50.0*(FRand()-0.5);
	Velocity.Y=50.0*(FRand()-0.5);
}

simulated function ZoneChange(ZoneInfo NewZone)
{
	if (NewZone.bWaterZone == False) {
		Destroy();
	}
}

simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLoc,Vector Momentum,name DamageType)
{
	Destroy();
}

defaultproperties
{
     Physics=PHYS_Falling
     bNet=False
     bNetSpecial=False
     Texture=Texture'KlingonFX01.Bubbles.bubl001'
     DrawScale=0.250000
     Mass=10.000000
     Buoyancy=11.000000
}
