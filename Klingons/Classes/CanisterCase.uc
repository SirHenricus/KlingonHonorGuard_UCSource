//=============================================================================
// CanisterCase.
//=============================================================================
class CanisterCase expands KlingonAmmo;

#call q:\Klingons\Art\Pickups\Ammo\FCell\Final\FCellCase.mac

defaultproperties
{
     ExplosionDamage=50.000000
     ExplosionRadius=300.000000
     ExplosionMomentum=25000.000000
     ExplosionType=exploded
     ExplosionEffect=Class'Klingons.AirExplosion'
     ObjectHealth=75.000000
     ObjectDamagedEffect=Class'Klingons.BlackSmoke'
     ExpProjectile=Class'Klingons.Canister'
     ExpProjCount=6
     AmmoAmount=15
     ParentAmmo=Class'Klingons.Canister'
     UsedInWeaponSlot(0)=5
     PickupMessage="You picked up a Case of Plasma Fuel Cells"
     PickupViewMesh=Mesh'Klingons.AmmoFuelCellCase'
     PickupViewScale=0.500000
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     Mesh=Mesh'Klingons.AmmoFuelCellCase'
     DrawScale=0.500000
     CollisionHeight=20.000000
     Mass=40.000000
}
