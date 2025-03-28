//=============================================================================
// EmptyCanister.
//=============================================================================
class EmptyCanister expands KlingonDecorations;

#call q:\Klingons\Art\Pickups\Ammo\FCell\Final\FCell.mac

#exec MESH ORIGIN MESH=AmmoFuelCell X=0 Y=0 Z=0

function Spawned()
{
	Super.Spawned();
}

simulated function HitWall(vector HitNor,actor HitAct)
{
	Super.HitWall(HitNor,HitAct);
	RandSpin(Self,1.0);
}

simulated function Landed(vector HitNor)
{
	HitWall(HitNor,None);
}

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Weapons.GranadBn'
     VisibleLifeSpan=10.000000
     bDirectional=True
     Physics=PHYS_Falling
     LifeSpan=30.000000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.AmmoFuelCell'
     DrawScale=0.200000
     CollisionRadius=8.000000
     CollisionHeight=8.000000
     bCollideActors=True
     bCollideWorld=True
     bProjTarget=True
     bBounce=True
     bFixedRotationDir=True
     Mass=25.000000
     Buoyancy=55.000000
}
