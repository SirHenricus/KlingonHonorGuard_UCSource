//=============================================================================
// HKRocketCase.
//=============================================================================
class HKRocketCase expands KlingonAmmo;

#call q:\Klingons\Art\Pickups\Ammo\HKRocket\Final\HKRocketCase.mac

#exec MESH ORIGIN MESH=AmmoHKRocketCase X=0 Y=0 Z=110 YAW=0

defaultproperties
{
     ExplosionDamage=75.000000
     ExplosionRadius=300.000000
     ExplosionMomentum=25000.000000
     ExplosionType=exploded
     ExplosionEffect=Class'Klingons.GroundExplosion'
     ObjectHealth=100.000000
     ObjectDamagedEffect=Class'Klingons.BlackSmoke'
     ExpProjectile=Class'Klingons.HKRockets'
     ExpProjCount=5
     AmmoAmount=6
     MaxAmmo=50
     ParentAmmo=Class'Klingons.HERockets'
     UsedInWeaponSlot(0)=7
     PickupMessage="You picked up a Case of Hunter Killer Rockets "
     PlayerViewScale=0.700000
     PickupViewMesh=Mesh'Klingons.AmmoHKRocketCase'
     PickupViewScale=0.700000
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     Mesh=Mesh'Klingons.AmmoHKRocketCase'
     DrawScale=0.900000
     bProjTarget=False
     Mass=33.000000
}
