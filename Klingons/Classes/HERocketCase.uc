//=============================================================================
// HERocketCase.
//=============================================================================
class HERocketCase expands KlingonAmmo;

#call q:\Klingons\Art\Pickups\Ammo\HERocket\Final\HERocketCase.mac

#exec MESH ORIGIN MESH=AmmoHERocketCase X=0 Y=0 Z=110 YAW=0

defaultproperties
{
     ExplosionDamage=75.000000
     ExplosionRadius=300.000000
     ExplosionMomentum=25000.000000
     ExplosionType=exploded
     ExplosionEffect=Class'Klingons.AirExplosion'
     ObjectHealth=100.000000
     ObjectDamagedEffect=Class'Klingons.BlackSmoke'
     ExpProjectile=Class'Klingons.HERockets'
     ExpProjCount=5
     AmmoAmount=10
     ParentAmmo=Class'Klingons.HERockets'
     UsedInWeaponSlot(0)=6
     UsedInWeaponSlot(1)=7
     PickupMessage="You picked up a Case of Trilithium Rockets"
     PlayerViewScale=0.700000
     PickupViewMesh=Mesh'Klingons.AmmoHERocketCase'
     PickupViewScale=0.700000
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     Mesh=Mesh'Klingons.AmmoHERocketCase'
     DrawScale=0.900000
     Mass=33.000000
}
