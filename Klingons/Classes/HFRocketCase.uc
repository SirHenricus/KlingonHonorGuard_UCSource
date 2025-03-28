//=============================================================================
// HFRocketCase.
//=============================================================================
class HFRocketCase expands KlingonAmmo;

/*
#call q:\Klingons\Art\Pickups\Ammo\HFRocket\Final\HFRocketCase.mac

#exec MESH ORIGIN MESH=AmmoHFRocketCase X=0 Y=0 Z=110 YAW=0
*/

defaultproperties
{
     ExplosionRadius=400.000000
     ExplosionType=Blinded
     ExplosionEffect=Class'Klingons.BlindAll'
     ObjectHealth=75.000000
     ObjectDamagedEffect=Class'Klingons.WhiteSmoke'
     ExpProjectile=Class'Klingons.HFRockets'
     ExpProjCount=5
     AmmoAmount=6
     MaxAmmo=50
     ParentAmmo=Class'Klingons.HERockets'
     UsedInWeaponSlot(0)=6
     PickupMessage="You picked up a Case of Flash Grenades"
     PlayerViewScale=0.700000
     PickupViewScale=0.700000
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     DrawScale=0.900000
     Mass=33.000000
}
