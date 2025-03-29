//=============================================================================
// TargTurd.
//=============================================================================
class TargTurd expands Effects;

#call q:\klingons\art\effects\crap\final\crap.mac
#exec MESH ORIGIN MESH=EffectCrap1 X=0 Y=0 Z=27 YAW=64


var(Sound) Sound Splat;
var()      Mesh  Turd1;
var()      Mesh  Turd2;

function Spawned()
{
	SetPhysics(PHYS_Falling);
	if (FRand() < 0.5)
		Mesh = Turd1;
	else
		Mesh = Turd1;
}

function Landed( vector HitNormal )
{
	SetPhysics(PHYS_None);
	PlaySound(Splat, SLOT_Interact);
}	

defaultproperties
{
     Splat=Sound'KlingonSFX01.creature.TarSting'
     Turd1=Mesh'Klingons.EffectCrap1'
     Turd2=Mesh'Klingons.EffectCrap2'
     LifeSpan=15.000000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.EffectCrap1'
     CollisionRadius=8.000000
     CollisionHeight=4.000000
     bCollideWorld=True
     Mass=5.000000
     Buoyancy=6.000000
}
