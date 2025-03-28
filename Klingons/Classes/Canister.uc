//=============================================================================
// Canister.
//=============================================================================
class Canister expands KlingonAmmo;

#call q:\Klingons\Art\Pickups\Ammo\FCell\Final\FCell.mac

#exec MESH ORIGIN MESH=AmmoFuelCell X=0 Y=0 Z=0

defaultproperties
{
     ExplosionDamage=33.000000
     ExplosionRadius=200.000000
     ExplosionMomentum=25000.000000
     ExplosionType=exploded
     ExplosionEffect=Class'Klingons.AirSmallExp'
     ObjectHealth=50.000000
     ObjectDamagedEffect=Class'Klingons.BlackSmoke'
     AmmoAmount=5
     MaxAmmo=100
     UsedInWeaponSlot(0)=5
     PickupMessage="You picked up a Plasma Fuel Cell"
     PickupViewMesh=Mesh'Klingons.AmmoFuelCell'
     PickupViewScale=0.200000
     PickupSound=Sound'KlingonSFX01.Pickups.Health3'
     Icon=Texture'KlingonHUD.InvIcons.A_Fuel'
     Mesh=Mesh'Klingons.AmmoFuelCell'
     DrawScale=0.200000
     CollisionHeight=6.000000
     Mass=20.000000
}
