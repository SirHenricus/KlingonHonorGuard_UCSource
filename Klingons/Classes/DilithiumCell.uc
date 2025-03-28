//=============================================================================
// DilithiumCell.
//=============================================================================
class DilithiumCell expands KlingonAmmo;

#call q:\Klingons\Art\Pickups\Ammo\DCell\Final\DCell.mac

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
     MaxAmmo=500
     UsedInWeaponSlot(0)=3
     UsedInWeaponSlot(1)=4
     UsedInWeaponSlot(2)=8
     PickupMessage="You picked up a Dilithium Cell"
     PickupViewMesh=Mesh'Klingons.AmmoDilithiumCell'
     PickupViewScale=0.230000
     PickupSound=Sound'KlingonSFX01.Pickups.Health3'
     Icon=Texture'KlingonHUD.InvIcons.a_dilith'
     Mesh=Mesh'Klingons.AmmoDilithiumCell'
     DrawScale=0.230000
     bMeshCurvy=True
     CollisionHeight=5.000000
     Mass=20.000000
}
