//=============================================================================
// RocketLauncher.
//=============================================================================
class RocketLauncher expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\RLaunch\InHand\Final\RLaunch.mac
#call q:\Klingons\Art\Weapons\RLaunch\Pickup\Final\RLaunchpu.mac

#exec MESH ORIGIN MESH=WeapRLauncherPickup X=-50 Y=0 Z=25

#call q:\Klingons\Art\Weapons\RLaunch\3rd\Final\RLaunch3rd.mac

#exec MESH ORIGIN MESH=WeapRLaunch3rd X=-30 Y=0 Z=0

#exec MESH SEQUENCE MESH=WeapRLauncher SEQ=Select STARTFRAME=1 NUMFRAMES=15
#exec MESH SEQUENCE MESH=WeapRLauncher SEQ=Down STARTFRAME=17 NUMFRAMES=15

#exec MESH NOTIFY MESH=WeapRLauncher SEQ=Shoot TIME=0.01 FUNCTION=FireProjectile

/*
function Projectile ProjectileFire(class<projectile>ProjClass,float ProjSpeed,bool bWarn)
{
	local projectile	P;
	local rotator		R;

	P=Super.ProjectileFire(ProjClass,ProjSpeed,bWarn);
	R=P.Rotation;
	R.Yaw-=16384.0;
	P.SetRotation(R);
}
*/

defaultproperties
{
     AmmoConsumption=1
     AltAmmoConsumption=3
     NumProjectiles=1
     AltNumProjectiles=1
     DamageAmount=79.000000
     AltDamageAmount=60.000000
     FireRate=1.000000
     AltFireRate=1.000000
     ShotRecoil=400.000000
     AltShotRecoil=200.000000
     HurtType=exploded
     AltHurtType=exploded
     ProjClass=Class'Klingons.RocketProjectile'
     AltProjClass=Class'Klingons.HunterProjectile'
     WeaponType=7
     FireNoise=0.800000
     AltFireNoise=0.700000
     AmmoName=Class'Klingons.HERockets'
     ReloadCount=6
     PickupAmmoCount=5
     bWarnTarget=True
     bAltWarnTarget=True
     bSplashDamage=True
     FireOffset=(X=33.000000,Y=-12.000000,Z=13.000000)
     AIRating=0.850000
     FireSound=Sound'KlingonSFX01.Weapons.RocketSt'
     AltFireSound=Sound'KlingonSFX01.Weapons.GrenadFr'
     CockingSound=Sound'KlingonSFX01.Weapons.RocketLd2'
     SelectSound=Sound'KlingonSFX01.Weapons.RocketLd2'
     MessageNoAmmo="No ammunition for Trilithium Rocket Launcher"
     AutoSwitchPriority=70
     InventoryGroup=7
     PickupMessage="You picked up a Trilithium Rocket Launcher"
     PlayerViewOffset=(Z=-23.000000)
     PlayerViewMesh=Mesh'Klingons.WeapRLauncher'
     PickupViewMesh=Mesh'Klingons.WeapRLauncherPickup'
     PickupViewScale=1.200000
     ThirdPersonMesh=Mesh'Klingons.WeapRLaunch3RD'
     Mesh=Mesh'Klingons.WeapRLauncherPickup'
     DrawScale=1.200000
     CollisionRadius=35.000000
     CollisionHeight=10.000000
     bProjTarget=True
     Mass=45.000000
}
