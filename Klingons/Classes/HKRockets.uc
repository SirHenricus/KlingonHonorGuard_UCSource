//=============================================================================
// HKRockets.
//=============================================================================
class HKRockets expands KlingonAmmo;

#call q:\Klingons\Art\Pickups\Ammo\HKRocket\Final\HKRocket.mac

defaultproperties
{
     ExplosionDamage=50.000000
     ExplosionRadius=200.000000
     ExplosionMomentum=25000.000000
     ExplosionType=exploded
     ExplosionEffect=Class'Klingons.AirExplosion'
     ObjectHealth=75.000000
     ObjectDamagedEffect=Class'Klingons.BlackSmoke'
     AmmoAmount=2
     MaxAmmo=50
     ParentAmmo=Class'Klingons.HERockets'
     UsedInWeaponSlot(0)=7
     PickupMessage="You picked up some Hunter Killer Rockets"
     PickupViewScale=0.600000
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     Icon=Texture'KlingonHUD.InvIcons.A_Trilth'
     DrawScale=0.600000
     bProjTarget=False
     Mass=20.000000
}
