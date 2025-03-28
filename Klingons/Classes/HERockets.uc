//=============================================================================
// HERockets.
//=============================================================================
class HERockets expands KlingonAmmo;

#call q:\Klingons\Art\Pickups\Ammo\HERocket\Final\HERocket.mac

#exec MESH ORIGIN MESH=AmmoHERocket X=-5 Y=750 Z=30 YAW=64

defaultproperties
{
     ExplosionDamage=33.000000
     ExplosionRadius=200.000000
     ExplosionMomentum=25000.000000
     ExplosionType=exploded
     ExplosionEffect=Class'Klingons.AirExplosion'
     ObjectHealth=50.000000
     ObjectDamagedEffect=Class'Klingons.BlackSmoke'
     AmmoAmount=2
     MaxAmmo=50
     UsedInWeaponSlot(0)=6
     UsedInWeaponSlot(1)=7
     PickupMessage="You picked up some Trilithium Rockets"
     PickupViewMesh=Mesh'Klingons.AmmoHERocket'
     PickupViewScale=0.600000
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     Icon=Texture'KlingonHUD.InvIcons.A_Trilth'
     Mesh=Mesh'Klingons.AmmoHERocket'
     DrawScale=0.600000
     Mass=20.000000
}
