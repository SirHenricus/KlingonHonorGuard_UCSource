//=============================================================================
// ParticleCannon.
//=============================================================================
class ParticleCannon expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\PCannon\InHand\Final\PCannon.mac
#call q:\Klingons\Art\Weapons\PCannon\Pickup\Final\PCannonpu.mac

#exec MESH ORIGIN MESH=WeapPCannonPickup X=-45 Y=-45 Z=0

#call q:\Klingons\Art\Weapons\PCannon\3rd\Final\PCannon3rd.mac

#exec MESH ORIGIN MESH=WeapPCannon3rd X=-30 Y=0 Z=0

#exec MESH SEQUENCE MESH=WeapPCannon SEQ=Select STARTFRAME=1 NUMFRAMES=20
#exec MESH SEQUENCE MESH=WeapPCannon SEQ=Down STARTFRAME=22 NUMFRAMES=20

#exec MESH NOTIFY MESH=WeapPCannon SEQ=Shoot TIME=0.66 FUNCTION=FireProjectile

function PlayFiring()
{
	Owner.PlaySound(FireSound,SLOT_None,Pawn(Owner).SoundDampening*4.0,,DefaultSoundRadius);
	Super.PlayFiring();
}

function PlayAltFiring()
{
	Owner.PlaySound(AltFireSound,SLOT_None,Pawn(Owner).SoundDampening*4.0,,DefaultSoundRadius);
	Super.PlayAltFiring();
}

function Projectile ProjectileFire(class<projectile>ProjClass,float ProjSpeed,bool bWarn)
{
	local vector		Start,X,Y,Z;

	Owner.MakeNoise(Pawn(Owner).SoundDampening);
	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	Start=Owner.Location+CalcDrawOffset()+FireOffset.X*X+FireOffset.Y*Y+FireOffset.Z*Z;
	AdjustedAim=WeaponAdjustAim(Start,ProjSpeed,bWarn);
	if (IsInState('AltFiring')) {
		if (AltMuzzleFlash != None) {
			MuzzleFlashActor=Spawn(AltMuzzleFlash,,,Start);
		}
		AdjustedAim.Yaw+=(AltDispersion*(FRand()-0.5));
		AdjustedAim.Pitch+=(AltDispersion*(FRand()-0.5));
	}
	else {
		if (MuzzleFlash != None) {
			MuzzleFlashActor=Spawn(MuzzleFlash,,,Start);
		}
		AdjustedAim.Yaw+=(Dispersion*(FRand()-0.5));
		AdjustedAim.Pitch+=(Dispersion*(FRand()-0.5));
	}
	LastProjClass=ProjClass;
	LastProjAim=AdjustedAim;
	WeaponRecoil();
	return(Spawn(ProjClass,,,Start,AdjustedAim));
}

defaultproperties
{
     AmmoConsumption=125
     AltAmmoConsumption=125
     NumProjectiles=1
     AltNumProjectiles=1
     DamageAmount=500.000000
     AltDamageAmount=1000.000000
     FireRate=1.000000
     AltFireRate=1.000000
     ShotRecoil=800.000000
     AltShotRecoil=200.000000
     HurtType=burned
     AltHurtType=Imploded
     ProjClass=Class'Klingons.ParticleProjectile'
     AltProjClass=Class'Klingons.ParticleAttractor'
     MuzzleFlash=Class'Klingons.ParticleTrail'
     WeaponType=6
     FireNoise=1.000000
     AltFireNoise=1.000000
     AmmoName=Class'Klingons.DilithiumCell'
     ReloadCount=125
     PickupAmmoCount=100
     bWarnTarget=True
     bAltWarnTarget=True
     bSplashDamage=True
     FireOffset=(X=33.000000,Y=-6.000000,Z=10.000000)
     AIRating=0.550000
     FireSound=Sound'KlingonSFX01.Weapons.BFGWindUp2'
     AltFireSound=Sound'KlingonSFX01.Weapons.BFGWindUp2'
     CockingSound=Sound'KlingonSFX01.Weapons.BFGReload'
     SelectSound=Sound'KlingonSFX01.Pickups.BFGPU'
     MessageNoAmmo="No ammunition for Particle Dispersal Cannon"
     AutoSwitchPriority=90
     InventoryGroup=9
     PickupMessage="No ammunition for Particle Dispersal Cannon"
     PlayerViewMesh=Mesh'Klingons.WeapPCannon'
     PickupViewMesh=Mesh'Klingons.WeapPCannonPickup'
     PickupViewScale=2.300000
     ThirdPersonMesh=Mesh'Klingons.WeapPcannon3RD'
     Mesh=Mesh'Klingons.WeapPCannonPickup'
     DrawScale=1.800000
     CollisionRadius=24.000000
     CollisionHeight=10.000000
     bProjTarget=True
     Mass=40.000000
}
