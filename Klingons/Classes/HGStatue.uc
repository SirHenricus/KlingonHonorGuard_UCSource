//=============================================================================
// HGStatue.
//=============================================================================
class HGStatue expands Destructable;

#call q:\klingons\art\pawns\statues\final\hgstatue.mac

#exec MESH ORIGIN MESH=PawnHGStatue X=0 Y=0 Z=-30 YAW=64

var (Sounds)	sound HitSound;

function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLoc,Vector Momentum,name DamageType)
{
	if (FRand() < 0.5)
		PlaySound(sound'SpinBounce');
	else
		PlaySound(sound'DaktaghWall');

	Super.TakeDamage(Damage,InstigatedBy,HitLoc,Momentum,DamageType);

}

defaultproperties
{
     HitSound=Sound'KlingonSFX01.Weapons.SpinBounce'
     ObjectHealth=0.000000
     ImpactSound=Sound'KlingonSFX01.Weapons.SpinBounce'
     bPushable=False
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnHGStatue'
     DrawScale=1.900000
     CollisionRadius=26.000000
     CollisionHeight=55.000000
     Mass=0.000000
}
