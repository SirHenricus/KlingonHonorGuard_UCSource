//=============================================================================
// DisruptorRifle.
//=============================================================================
class DisruptorRifle expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\DRifle\InHand\Final\DRifle.mac
#call q:\Klingons\Art\Weapons\DRifle\Pickup\Final\DRiflepu.mac

#exec MESH ORIGIN MESH=WeapDRiflePickup X=25 Y=0 Z=75

#call q:\Klingons\Art\Weapons\DRifle\3rd\Final\DRifle3rd.mac

#exec MESH ORIGIN MESH=WeapDRifle3rd X=-30 Y=0 Z=0

#exec MESH SEQUENCE MESH=WeapDRifle SEQ=Select STARTFRAME=1 NUMFRAMES=40
#exec MESH SEQUENCE MESH=WeapDRifle SEQ=Down STARTFRAME=42 NUMFRAMES=20

#exec MESH NOTIFY MESH=WeapDRifle SEQ=Shoot TIME=0.01 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapDRifle SEQ=Shoot TIME=0.5 FUNCTION=ReFireProjectile

defaultproperties
{
     AmmoConsumption=2
     AltAmmoConsumption=6
     NumProjectiles=1
     AltNumProjectiles=3
     DamageAmount=5.000000
     AltDamageAmount=5.000000
     FireRate=1.000000
     AltFireRate=0.500000
     AltDispersion=500.000000
     ShotRecoil=10.000000
     AltShotRecoil=10.000000
     HurtType=Peppered
     AltHurtType=Disintegrated
     ProjClass=Class'Klingons.DisruptorGreen'
     AltProjClass=Class'Klingons.DisruptorRed'
     MuzzleFlash=Class'Klingons.DisruptorTrail1'
     AltMuzzleFlash=Class'Klingons.DisruptorFlash2'
     WeaponType=4
     FireNoise=0.600000
     AltFireNoise=0.700000
     AmmoName=Class'Klingons.DilithiumCell'
     ReloadCount=30
     PickupAmmoCount=30
     bWarnTarget=True
     bAltWarnTarget=True
     FireOffset=(X=33.000000,Y=-7.000000,Z=9.000000)
     shakemag=150.000000
     AIRating=0.400000
     FireSound=Sound'KlingonSFX01.Weapons.Wepon4'
     AltFireSound=Sound'KlingonSFX01.Weapons.Wepon4'
     CockingSound=Sound'KlingonSFX01.Weapons.DsrptRifReload'
     SelectSound=Sound'KlingonSFX01.Weapons.DsrptRifPU'
     MessageNoAmmo="No ammunition for Disruptor Rifle"
     AutoSwitchPriority=30
     InventoryGroup=3
     PickupMessage="You picked up a Disruptor Rifle"
     PlayerViewOffset=(Z=-18.000000)
     PlayerViewMesh=Mesh'Klingons.WeapDRifle'
     PickupViewMesh=Mesh'Klingons.WeapDRiflePickup'
     PickupViewScale=1.800000
     ThirdPersonMesh=Mesh'Klingons.WeapDrifle3RD'
     PickupSound=Sound'KlingonSFX01.Weapons.DsrptRifPU'
     Mesh=Mesh'Klingons.WeapDRiflePickup'
     DrawScale=1.800000
     bMeshCurvy=True
     CollisionRadius=27.000000
     CollisionHeight=12.000000
     bProjTarget=True
     Mass=35.000000
}
