//=============================================================================
// Batleth.
//=============================================================================
class Batleth expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\Batleth\InHand\Final\Batleth.mac
#call q:\Klingons\Art\Weapons\Batleth\Pickup\Final\Batlethpu.mac
#call q:\Klingons\Art\Weapons\Batleth\3rd\Final\Batleth3rd.mac

#exec MESH ORIGIN MESH=WeapBatleth3rd X=50 Y=0 Z=100 PITCH=128

#exec MESH SEQUENCE MESH=WeapBatleth SEQ=Select STARTFRAME=1  NUMFRAMES=15
#exec MESH SEQUENCE MESH=WeapBatleth SEQ=Down   STARTFRAME=17 NUMFRAMES=15

#exec MESH NOTIFY MESH=WeapBatleth SEQ=Slash TIME=0.41 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapBatleth SEQ=Slash TIME=0.45 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapBatleth SEQ=Slash TIME=0.5  FUNCTION=FireProjectile

#exec MESH NOTIFY MESH=WeapBatleth SEQ=Backslash TIME=0.375 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapBatleth SEQ=Backslash TIME=0.41 FUNCTION=FireProjectile

#exec MESH NOTIFY MESH=WeapBatleth SEQ=JabRight TIME=0.42 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapBatleth SEQ=JabRight TIME=0.47 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapBatleth SEQ=JabRight TIME=0.66 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapBatleth SEQ=JabRight TIME=0.71 FUNCTION=FireProjectile

#exec MESH NOTIFY MESH=WeapBatleth SEQ=JabLeft TIME=0.38 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapBatleth SEQ=JabLeft TIME=0.42 FUNCTION=FireProjectile

#exec MESH NOTIFY MESH=WeapBatleth SEQ=Throw TIME=0.8 FUNCTION=FireProjectile

function BringUp()
{
	Super.BringUp();
	if (KlingonPlayer(Owner) != None) {
		KlingonPlayer(Owner).SayHmHmHmHm();
	}
}

function PlayFiring()
{
	local float		R;

	R=FRand();
	if (R < 0.4) {
		if (Misc1Sound != None) {
			PlaySound(Misc1Sound,SLOT_None,Pawn(Owner).SoundDampening);
		}
		PlayAnim('Backslash',FireRate);
	}
	else if (R < 0.6) {
		if (Misc2Sound != None) {
			PlaySound(Misc2Sound,SLOT_None,Pawn(Owner).SoundDampening);
		}
		PlayAnim('JabRight',FireRate);
	}
	else if (R < 0.8) {
		if (Misc2Sound != None) {
			PlaySound(Misc2Sound,SLOT_None,Pawn(Owner).SoundDampening);
		}
		PlayAnim('JabLeft',FireRate);
	}
	else {
		if (FireSound != None) {
			PlaySound(FireSound,SLOT_None,Pawn(Owner).SoundDampening);
		}
		PlayAnim('Slash',FireRate);
	}
}

function PlayAltFiring()
{
//	AmmoType.UseAmmo(AltAmmoConsumption);
	if (AltFireSound != None) {
		PlaySound(AltFireSound,SLOT_None,Pawn(Owner).SoundDampening);
	}
	PlayAnim('Throw',AltFireRate);
}

function PlayIdleAnim()
{
	if (bWeaponUp) {
		Super.PlayIdleAnim();
	}
}

function PlayTauntAnim()
{
	local float		r;

	if (!bWeaponUp) {
		return;
	}
	PlayAnim('Spin',0.5,1.0);
	if (KlingonPlayer(Owner) != None) {
		r=FRand();
		if (r < 0.2) {
			r=FRand();
//			if (r < 0.5) {
//				KlingonPlayer(Owner).SayAttitudeNext();
//			}
			if (r < 0.9) {
				KlingonPlayer(Owner).SayChopYouUp();
			}
		}
	}
}

function Timer()
{
	if (IsInState('Pickup')) {
		Super.Timer();
	}
}

state AltFiring
{
	function Fire(float F) {}
	function AltFire(float F) {}
	
Begin:
	FinishAnim();
	if (AmmoType.AmmoAmount <= 0) {
		Pawn(Owner).Weapon=None;
		Pawn(Owner).SwitchToBestWeapon();
	}
	else {
		Finish();
	}
}

state Idle
{
//	function AnimEnd()
//	{
//		PlayIdleAnim();
//	}
	function Timer()
	{
		if (FRand() < 0.5) {
			GotoState('Taunt');
		}
	}
//	function bool PutDown()
//	{
//		GotoState('DownWeapon');
//		return True;
//	}
Begin:
	bPointing=False;
	if ((AmmoType != None) && (AmmoType.AmmoAmount<=0)) {
		Pawn(Owner).SwitchToBestWeapon();
	}
//	Disable('AnimEnd');
	PlayIdleAnim();
	SetTimer(3.0,True);
}

state Taunt
{
//	function AnimEnd()
//	{
//		PlayIdleAnim();
//	}
//	function bool PutDown()
//	{
//		GotoState('DownWeapon');
//		return True;
//	}
begin:
	PlayTauntAnim();
	FinishAnim();
	Finish();
	GotoState('Idle');
}

defaultproperties
{
     AltAmmoConsumption=1
     AltNumProjectiles=1
     DamageAmount=24.000000
     AltDamageAmount=100.000000
     FireRate=1.000000
     AltFireRate=1.000000
     InstantHitMomentum=25000.000000
     AimAdjust=(Pitch=0,Yaw=0)
     AltAimAdjust=(Pitch=0,Yaw=0)
     HurtType=hacked
     AltHurtType=hacked
     AltProjClass=Class'Klingons.BatlethProjectile'
     InstantHitEffect=Class'Klingons.Spark1'
     WeaponType=1
     FireNoise=0.300000
     AltFireNoise=0.200000
     MaxTargetRange=100.000000
     AmmoName=Class'Klingons.Batleths'
     PickupAmmoCount=1
     bInstantHit=True
     FireOffset=(X=45.000000,Y=0.000000,Z=20.000000)
     AIRating=0.300000
     FireSound=Sound'KlingonSFX01.Weapons.BatSwingBig'
     AltFireSound=Sound'KlingonSFX01.Weapons.BatThrowSt'
     SelectSound=Sound'KlingonSFX01.Pickups.BatPU'
     Misc1Sound=Sound'KlingonSFX01.Weapons.BatSwingBig'
     Misc2Sound=Sound'KlingonSFX01.Weapons.Batswing'
     Misc3Sound=Sound'KlingonSFX01.Weapons.DaktaghWall'
     MessageNoAmmo="No ammunition for Bat'leth"
     AutoSwitchPriority=13
     InventoryGroup=10
     PickupMessage="You picked up a Batleth"
     PlayerViewMesh=Mesh'Klingons.WeapBatleth'
     PickupViewMesh=Mesh'Klingons.WeapBatlethPickup'
     PickupViewScale=1.800000
     ThirdPersonMesh=Mesh'Klingons.WeapBatleth3RD'
     PickupSound=Sound'KlingonSFX01.Pickups.BatPU'
     Mesh=Mesh'Klingons.WeapBatlethPickup'
     DrawScale=1.800000
     CollisionRadius=35.000000
     CollisionHeight=15.000000
     bProjTarget=True
     Mass=35.000000
}
