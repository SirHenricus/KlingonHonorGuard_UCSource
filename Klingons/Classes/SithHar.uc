//=============================================================================
// NewWeapon.
//=============================================================================
class SithHar expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\FThrow\InHand\Final\FThrow.mac
#call q:\Klingons\Art\Weapons\FThrow\Pickup\Final\FThrowpu.mac

#exec MESH ORIGIN MESH=WeapFThrowerPickup X=175 Y=85 Z=65

#call q:\Klingons\Art\Weapons\FThrow\3rd\Final\FThrow3rd.mac

#exec MESH ORIGIN MESH=WeapFThrower3rd X=-30 Y=0 Z=0

#exec MESH SEQUENCE MESH=WeapFThrower SEQ=Select STARTFRAME=1 NUMFRAMES=20
#exec MESH SEQUENCE MESH=WeapFThrower SEQ=Down   STARTFRAME=21 NUMFRAMES=20

#exec MESH NOTIFY MESH=WeapFThrower SEQ=Shoot  TIME=0.1  FUNCTION=FireProjectile
#exec MESH NOTIFY MESH=WeapFThrower SEQ=Reload TIME=0.45 FUNCTION=DiscardAmmo

var() class<Effects>	TrailEffect;
var() class<Actor>		AmmoDiscardClass;
var() vector			AmmoDiscardOffset;

function ProcessTraceHit(actor HitAct,vector HitLoc,vector HitNor,vector X,vector Y,vector Z)
{
	local int		i;
	local float		D;
	local vector	dist,
					spacing,
					StartLoc;
	local vector	MomVec;
	local actor		A;

	if (IsInState('NormalFire')) {
		D=DamageAmount;
		if (KlingonPlayer(Owner) != None && KlingonPlayer(Owner).WeaponDamageScale != 0.0) {
			D*=KlingonPlayer(Owner).WeaponDamageScale;
		}
		else if (Bots(Owner) != None && Bots(Owner).WeaponDamageScale != 0.0) {
			D*=Bots(Owner).WeaponDamageScale;
		}
		MomVec=D*vector(AdjustedAim)*(InstantHitMomentum*0.02);
		HitAct.TakeDamage(D,Instigator,HitLoc,MomVec,HurtType);
		if (InstantHitEffect != None) {
			Spawn(InstantHitEffect,,,HitLoc);
		}
		if (HitAct.IsA('LevelInfo')) {
			if (ScorchEffect != None) {
				A=Spawn(ScorchEffect,,,HitLoc,rotator(HitNor));
				A.DrawScale=FMax(ScorchScale*FRand(),ScorchScale*0.5);
			}
		}
	}
	else if (IsInState('AltFiring')) {
		D=AltDamageAmount;
		if (KlingonPlayer(Owner) != None && KlingonPlayer(Owner).WeaponDamageScale != 0.0) {
			D*=KlingonPlayer(Owner).WeaponDamageScale;
		}
		else if (Bots(Owner) != None && Bots(Owner).WeaponDamageScale != 0.0) {
			D*=Bots(Owner).WeaponDamageScale;
		}
		MomVec=D*vector(AdjustedAim)*(AltInstantHitMomentum*0.02);
		HitAct.TakeDamage(D,Instigator,HitLoc,MomVec,AltHurtType);
		if (HitAct.IsA('LevelInfo')) {
			if (AltInstantHitEffect != None) {
				Spawn(AltInstantHitEffect,,,HitLoc);
			}
			if (AltScorchEffect != None) {
				A=Spawn(AltScorchEffect,,,HitLoc,rotator(HitNor));
				A.DrawScale=FMax(AltScorchScale*FRand(),AltScorchScale*0.5);
			}
		}
		StartLoc=StartTrace;
		dist=HitLoc-StartLoc;
		spacing=dist/15.0;
		for (i=0 ; i < 15 ; i++) {
			A=Spawn(TrailEffect,Owner,,StartLoc);
			A.DrawScale=a.Default.DrawScale/3.0;
			StartLoc+=spacing;
		}
	}
}

function DiscardAmmo()
{
	local actor		A;
	local vector	Start,
					X,Y,Z;

	if (AmmoDiscardClass != None) {
		GetAxes(Pawn(Owner).ViewRotation,X,Y,Z);
		Start=Owner.Location+CalcDrawOffset()+AmmoDiscardOffset.X*X+AmmoDiscardOffset.Y*Y+AmmoDiscardOffset.Z*Z;
		A=Spawn(AmmoDiscardClass,,,Start);
		A.Velocity=vector(Pawn(Owner).ViewRotation)*200.0;
		RandSpin(A,1.0);
	}
}

function Fire(float v)
{
	bAltLastFired=False;	// bypass mode reload for this weapon
	Super.Fire(v);
}

function AltFire(float v)
{
	bAltLastFired=True;		// bypass mode reload for this weapon
	Super.AltFire(v);
}

defaultproperties
{
     TrailEffect=Class'Klingons.WhiteSmoke'
     AmmoDiscardClass=Class'Klingons.EmptyCanister'
     AmmoDiscardOffset=(X=45.000000,Z=20.000000)
     AmmoConsumption=1
     AltAmmoConsumption=25
     DamageAmount=20.000000
     AltDamageAmount=125.000000
     FireRate=1.000000
     AltFireRate=0.250000
     InstantHitMomentum=40000.000000
     AltInstantHitMomentum=20000.000000
     ShotRecoil=100.000000
     AltShotRecoil=300.000000
     HurtType=Perforated
     AltHurtType=Perforated
     InstantHitEffect=Class'Klingons.SithHarFlash'
     AltInstantHitEffect=Class'Klingons.AssaultExplosion'
     MuzzleFlash=Class'Klingons.SithHarFlash'
     ScorchEffect=Class'Klingons.Scorch02'
     ScorchScale=0.100000
     AltScorchEffect=Class'Klingons.Scorch04'
     AltScorchScale=0.500000
     WeaponType=8
     FireNoise=0.600000
     AltFireNoise=1.000000
     MaxTargetRange=10000.000000
     AmmoName=Class'Klingons.Canister'
     ReloadCount=25
     PickupAmmoCount=50
     bInstantHit=True
     bAltInstantHit=True
     FireOffset=(X=33.000000,Y=-10.000000,Z=14.000000)
     AIRating=0.900000
     FireSound=Sound'KlingonSFX01.Weapons.Wepon3'
     AltFireSound=Sound'KlingonSFX01.Weapons.Wepon5'
     CockingSound=Sound'KlingonSFX01.Weapons.FlamThroReload'
     SelectSound=Sound'KlingonSFX01.Weapons.FlamThroReload'
     MessageNoAmmo="No ammunition for Sith Har Blaster"
     AutoSwitchPriority=80
     InventoryGroup=8
     PickupMessage="You picked up a Sith Har Blaster"
     PlayerViewOffset=(Z=-23.000000)
     PlayerViewMesh=Mesh'Klingons.WeapFThrower'
     PickupViewMesh=Mesh'Klingons.WeapFThrowerPickup'
     PickupViewScale=2.500000
     ThirdPersonMesh=Mesh'Klingons.WeapFThrower3RD'
     Mesh=Mesh'Klingons.WeapFThrowerPickup'
     DrawScale=2.500000
     CollisionRadius=28.000000
     CollisionHeight=10.000000
     bProjTarget=True
     Mass=35.000000
}
