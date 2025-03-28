//=============================================================================
// AssaultDisruptor.
//=============================================================================
class AssaultDisruptor expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\Assault\InHand\Final\Assault.mac
#call q:\Klingons\Art\Weapons\Assault\Pickup\Final\Assaultpu.mac

#exec MESH ORIGIN MESH=WeapADisruptPickup X=0 Y=0 Z=75

#call q:\Klingons\Art\Weapons\Assault\3rd\Final\Assault3rd.mac

#exec MESH ORIGIN MESH=WeapADisrupt3rd X=-20 Y=10 Z=0

#exec MESH SEQUENCE MESH=WeapADisrupt SEQ=Select STARTFRAME=1 NUMFRAMES=15
#exec MESH SEQUENCE MESH=WeapADisrupt SEQ=Down STARTFRAME=17 NUMFRAMES=15

#exec MESH NOTIFY MESH=WeapADisrupt SEQ=Shoot TIME=0.05 FUNCTION=FireProjectile

function Projectile ProjectileFire(class<projectile>ProjClass,float ProjSpeed,bool bWarn)
{
	local vector		Start;
	local projectile	P;

	P=Super.ProjectileFire(ProjClass,ProjSpeed,bWarn);
	if (IsInState('NormalFire') && ProjNum == 1) {
		Start=P.Location+vect(0,0,10);
		P.SetLocation(Start);
	}
	return(P);
}

defaultproperties
{
     AmmoConsumption=5
     AltAmmoConsumption=10
     NumProjectiles=2
     AltNumProjectiles=10
     DamageAmount=20.000000
     AltDamageAmount=10.000000
     FireRate=0.500000
     AltFireRate=0.500000
     AltDispersion=1500.000000
     ShotRecoil=150.000000
     AltShotRecoil=50.000000
     HurtType=Blasted
     AltHurtType=burned
     ProjClass=Class'Klingons.AssaultProjectile'
     AltProjClass=Class'Klingons.DisruptorProjectile'
     MuzzleFlash=Class'Klingons.DisruptorFlash3'
     AltMuzzleFlash=Class'Klingons.DisruptorFlash3'
     FireNoise=0.900000
     AltFireNoise=1.000000
     AmmoName=Class'Klingons.DilithiumCell'
     ReloadCount=40
     PickupAmmoCount=40
     bWarnTarget=True
     bAltWarnTarget=True
     FireOffset=(X=33.000000,Y=-10.000000,Z=14.000000)
     AIRating=0.500000
     FireSound=Sound'KlingonSFX01.Weapons.Wepon1'
     AltFireSound=Sound'KlingonSFX01.Weapons.Wepon2'
     CockingSound=Sound'KlingonSFX01.Weapons.AssultLd2'
     SelectSound=Sound'KlingonSFX01.Weapons.PickUpWeapons'
     MessageNoAmmo="No ammunition for Assault Disruptor"
     AutoSwitchPriority=40
     InventoryGroup=4
     PickupMessage="You picked up an Assault Disruptor"
     PlayerViewOffset=(Z=-22.000000)
     PlayerViewMesh=Mesh'Klingons.WeapADisrupt'
     PickupViewMesh=Mesh'Klingons.WeapADisruptPickup'
     PickupViewScale=1.800000
     ThirdPersonMesh=Mesh'Klingons.WeapADisrupt3RD'
     Mesh=Mesh'Klingons.WeapADisruptPickup'
     DrawScale=1.800000
     CollisionRadius=35.000000
     CollisionHeight=15.000000
     bProjTarget=True
     Mass=40.000000
}
