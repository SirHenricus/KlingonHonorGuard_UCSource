//=============================================================================
// Daktagh.
//=============================================================================
class Daktagh expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\Daktagh\InHand\Final\Daktagh.mac
#call q:\Klingons\Art\Projectiles\Daktagh\Final\Daktpro.mac
#call q:\Klingons\Art\Weapons\Daktagh\3rd\Final\Daktagh3rd.mac

#exec MESH ORIGIN MESH=WeapDaktagh3rd X=-30 Y=0 Z=0 YAW=0

#exec MESH SEQUENCE MESH=WeapDaktagh SEQ=Select STARTFRAME=1 NUMFRAMES=36
#exec MESH SEQUENCE MESH=WeapDaktagh SEQ=Down STARTFRAME=37 NUMFRAMES=11

#exec MESH NOTIFY MESH=WeapDaktagh SEQ=Stab TIME=0.32 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapDaktagh SEQ=Stab TIME=0.5 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapDaktagh SEQ=ForwardSlice TIME=0.26 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapDaktagh SEQ=ForwardSlice TIME=0.70 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapDaktagh SEQ=ReverseSlice TIME=0.48 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapDaktagh SEQ=ReverseSlice TIME=0.56 FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapDaktagh SEQ=Throw TIME=0.90 FUNCTION=FireProjectile

function BringUp()
{
	Super.BringUp();
	if (KlingonPlayer(Owner) != None && FRand() < 0.3) {
		KlingonPlayer(Owner).SayHmHmHmHm();
	}
}

function PlayFiring()
{
	if (FRand() < 0.33) {
		if (FireSound != None) {
			PlaySound(Misc1Sound,SLOT_None,Pawn(Owner).SoundDampening);
		}
		PlayAnim('Stab',FireRate);
	}
	else if (FRand() < 0.66) {
		if (FireSound != None) {
			PlaySound(FireSound,SLOT_None,Pawn(Owner).SoundDampening);
		}
		PlayAnim('ForwardSlice',FireRate);
	}
	else {
		if (FireSound != None) {
			PlaySound(FireSound,SLOT_None,Pawn(Owner).SoundDampening);
		}
		PlayAnim('ReverseSlice',FireRate*0.6);
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

/*
function PlayTauntAnim()
{
	local float		r;

	if (!bWeaponUp) {
		return;
	}
	PlayAnim('CMon',1.0,0.05);
	if (KlingonPlayer(Owner) != None) {
		r=FRand();
		if (r < 0.2) {
			r=FRand();
			if (r < 0.3) {
				KlingonPlayer(Owner).SayDaktaghWithYourName();
			}
//			else if (r < 0.6) {
//				KlingonPlayer(Owner).SayAttitudeNext();
//			}
			else if (r < 0.9) {
				KlingonPlayer(Owner).SayChopYouUp();
			}
		}
	}
}
*/

function PlayIdleAnim()
{
	if (bWeaponUp) {
		Super.PlayIdleAnim();
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
	if (AmmoType.AmmoAmount <= 0 || AmmoType.AmmoAmount < AltAmmoConsumption) {
		Pawn(Owner).Weapon=None;
		Pawn(Owner).SwitchToBestWeapon();
	}
	else {
		Finish();
	}
}

state Idle
{
/*
	function Timer()
	{
		if (FRand() < 0.3) {
			GotoState('CMon');
		}
	}
*/
Begin:
	bPointing=False;
	if ((AmmoType != None) && (AmmoType.AmmoAmount<=0)) {
		Pawn(Owner).SwitchToBestWeapon();
	}
	else {
		Disable('AnimEnd');
		PlayIdleAnim();
/*
		SetTimer(2.0,True);
*/
	}
}

/*
state CMon
{
begin:
	PlayTauntAnim();
	FinishAnim();
	Finish();
	GotoState('Idle');
}
*/

defaultproperties
{
     AltAmmoConsumption=1
     AltNumProjectiles=1
     DamageAmount=12.000000
     AltDamageAmount=60.000000
     FireRate=1.500000
     AltFireRate=1.500000
     InstantHitMomentum=25000.000000
     HurtType=sliced
     AltHurtType=sliced
     AltProjClass=Class'Klingons.DaktaghProjectile'
     InstantHitEffect=Class'Klingons.Spark1'
     WeaponType=2
     FireNoise=0.300000
     AltFireNoise=0.200000
     MaxTargetRange=100.000000
     AmmoName=Class'Klingons.Daktaghs'
     PickupAmmoCount=1
     bInstantHit=True
     FireOffset=(X=45.000000,Y=-10.000000,Z=10.000000)
     FireSound=Sound'KlingonSFX01.Weapons.Batswing'
     SelectSound=Sound'KlingonSFX01.Weapons.knifeout2'
     Misc1Sound=Sound'KlingonSFX01.Weapons.BatSwingBig'
     Misc3Sound=Sound'KlingonSFX01.Weapons.DaktaghWall'
     MessageNoAmmo="No ammunition for D'k tahg"
     AutoSwitchPriority=10
     PickupMessage="You picked up a D'k tagh"
     PlayerViewMesh=Mesh'Klingons.WeapDaktagh'
     PickupViewMesh=Mesh'Klingons.ProjDaktagh'
     PickupViewScale=1.800000
     ThirdPersonMesh=Mesh'Klingons.WeapDaktagh3RD'
     PickupSound=Sound'KlingonSFX01.Weapons.Knifeout'
     Mesh=Mesh'Klingons.ProjDaktagh'
     DrawScale=1.800000
     CollisionRadius=20.000000
     CollisionHeight=10.000000
     bProjTarget=True
     Mass=30.000000
}
