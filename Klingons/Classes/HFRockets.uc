//=============================================================================
// HFRockets.
//=============================================================================
class HFRockets expands KlingonAmmo;

/*
#call q:\Klingons\Art\Pickups\Ammo\HFRocket\Final\HFRocket.mac
*/

defaultproperties
{
     ExplosionRadius=300.000000
     ExplosionType=Blinded
     ExplosionEffect=Class'Klingons.BlindAll'
     ObjectHealth=25.000000
     ObjectDamagedEffect=Class'Klingons.WhiteSmoke'
     AmmoAmount=2
     MaxAmmo=50
     ParentAmmo=Class'Klingons.HERockets'
     UsedInWeaponSlot(0)=6
     PickupMessage="You picked up some Flash Grenades"
     PickupViewScale=0.600000
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     Icon=Texture'KlingonHUD.InvIcons.A_gren'
     DrawScale=0.600000
     Mass=20.000000
}
