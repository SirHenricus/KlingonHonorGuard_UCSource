//=============================================================================
// GrenadeLauncher.
//=============================================================================
class GrenadeLauncher expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\GLaunch\InHand\Final\GLaunch.mac
#call q:\Klingons\Art\Weapons\GLaunch\Pickup\Final\GLaunchpu.mac

#exec MESH ORIGIN MESH=WeapGLauncherPickup X=300 Y=65 Z=50

#call q:\Klingons\Art\Weapons\GLaunch\3rd\Final\GLaunch3rd.mac

#exec MESH ORIGIN MESH=WeapGLaunch3rd X=-30 Y=0 Z=0

#exec MESH SEQUENCE MESH=WeapGLauncher SEQ=Select STARTFRAME=1 NUMFRAMES=15
#exec MESH SEQUENCE MESH=WeapGLauncher SEQ=Down STARTFRAME=17 NUMFRAMES=16

#exec MESH NOTIFY MESH=WeapGLauncher SEQ=Shoot TIME=0.01 FUNCTION=FireProjectile

defaultproperties
{
     AmmoConsumption=1
     AltAmmoConsumption=1
     NumProjectiles=1
     AltNumProjectiles=1
     DamageAmount=100.000000
     FireRate=1.000000
     AltFireRate=1.000000
     ShotRecoil=200.000000
     AltShotRecoil=200.000000
     HurtType=exploded
     AltHurtType=Blinded
     ProjClass=Class'Klingons.GrenadeProjectile'
     AltProjClass=Class'Klingons.FlashGrenade'
     MuzzleFlash=Class'Klingons.RocketTrail'
     AltMuzzleFlash=Class'Klingons.RocketTrail'
     WeaponType=5
     FireNoise=0.500000
     AltFireNoise=0.500000
     AmmoName=Class'Klingons.HERockets'
     ReloadCount=6
     PickupAmmoCount=5
     bWarnTarget=True
     bAltWarnTarget=True
     bSplashDamage=True
     FireOffset=(X=38.000000,Y=-5.000000,Z=14.000000)
     AIRating=0.600000
     FireSound=Sound'KlingonSFX01.Weapons.GrenadFr'
     AltFireSound=Sound'KlingonSFX01.Weapons.GrenadFr'
     CockingSound=Sound'KlingonSFX01.Weapons.GrenadeLd2'
     SelectSound=Sound'KlingonSFX01.Weapons.GrenadeLd2'
     MessageNoAmmo="No ammunition for Grenade Launcher"
     AutoSwitchPriority=60
     InventoryGroup=6
     PickupMessage="You picked up a Grenade Launcher"
     PlayerViewOffset=(X=-5.000000,Z=-22.000000)
     PlayerViewMesh=Mesh'Klingons.WeapGLauncher'
     PickupViewMesh=Mesh'Klingons.WeapGLauncherPickup'
     PickupViewScale=1.800000
     ThirdPersonMesh=Mesh'Klingons.WeapGLaunch3RD'
     Mesh=Mesh'Klingons.WeapGLauncherPickup'
     DrawScale=1.800000
     CollisionRadius=35.000000
     CollisionHeight=12.000000
     bProjTarget=True
     Mass=40.000000
}
