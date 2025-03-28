//=============================================================================
// DilithiumCellCase.
//=============================================================================
class DilithiumCellCase expands KlingonAmmo;

#call q:\Klingons\Art\Pickups\Ammo\DCell\Final\DCellCase.mac

defaultproperties
{
     ExplosionDamage=50.000000
     ExplosionRadius=300.000000
     ExplosionMomentum=25000.000000
     ExplosionType=exploded
     ExplosionEffect=Class'Klingons.AirExplosion'
     ObjectHealth=75.000000
     ObjectDamagedEffect=Class'Klingons.BlackSmoke'
     ExpProjectile=Class'Klingons.DilithiumCell'
     ExpProjCount=5
     AmmoAmount=30
     MaxAmmo=500
     ParentAmmo=Class'Klingons.DilithiumCell'
     UsedInWeaponSlot(0)=3
     UsedInWeaponSlot(1)=4
     UsedInWeaponSlot(2)=8
     PickupMessage="You picked up a Case of Dilithium Cells"
     PickupViewMesh=Mesh'Klingons.AmmoDilithiumCellCase'
     PickupViewScale=0.500000
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     Mesh=Mesh'Klingons.AmmoDilithiumCellCase'
     DrawScale=0.500000
     CollisionHeight=10.000000
     Mass=33.000000
}
