//=============================================================================
// KlingonWeapons.
//=============================================================================
class KlingonWeapons expands Weapon;

#exec OBJ LOAD FILE=..\Textures\WeaponFX01.utx PACKAGE=WeaponFX01
#exec OBJ LOAD FILE=..\Sounds\KlingonSFX01 PACKAGE=KlingonSFX01

var() int				AmmoConsumption;
var() int				AltAmmoConsumption;
var() int				NumProjectiles;
var() int				AltNumProjectiles;
var() float				DamageAmount;
var() float				AltDamageAmount;
var() float				FireRate;
var() float				AltFireRate;
var() float				Dispersion;
var() float				AltDispersion;
var() float				InstantHitMomentum;
var() float				AltInstantHitMomentum;
var() float				DefaultSoundRadius;
var() float				ShotRecoil;
var() float				AltShotRecoil;
var() rotator			AimAdjust;
var() rotator			AltAimAdjust;
var() name				HurtType;
var() name				AltHurtType;
var() class<Projectile>	ProjClass;
var() class<Projectile>	AltProjClass;
var() class<Effects>	InstantHitEffect;
var() class<Effects>	AltInstantHitEffect;

var() class<Effects>	MuzzleFlash;
var() class<Effects>	AltMuzzleFlash;

var() class<Effects>	ScorchEffect;
var() float				ScorchScale;
var() class<Effects>	AltScorchEffect;
var() float				AltScorchScale;

var actor				MuzzleFlashActor;

var int					ProjNum;
var rotator				AimTweak;
var projectile			WeapProj;
var vector				StartTrace;

var class<Projectile>	LastProjClass;
var rotator				LastProjAim;
var float				LastProjDamage;

var bool				bAltLastFired;

var() int				WeaponType;
var() float				FireNoise;
var() float				AltFireNoise;

var inventory			ItemCopy;

simulated function RandSpin(actor A,float Scale)
{
	if (A != none)
	{
		A.bFixedRotationDir=True;
		A.RotationRate=RotRand(True)*Scale;
	}
}

simulated function VelocitySpin(actor A,vector V)
{
	A.bFixedRotationDir=True;
	A.RotationRate=rotator(V);
}

simulated function MomentumMove(actor A,vector Momentum)
{
	if (Level.NetMode != NM_StandAlone || (Level.Game != None && Level.Game.IsA('DeathMatchGame'))) {
		return;
	}
	A.bBounce=True;
	A.bCollideWorld=True;
	A.SetPhysics(PHYS_Falling);
	A.Velocity+=(Momentum/A.Mass);
	RandSpin(A,1.0);
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
	if (ProjClass != None) {
		ProjectileClass=ProjClass;
		ProjectileSpeed=ProjClass.Default.speed;
	}
	if (AltProjClass != None) {
		AltProjectileClass=AltProjClass;
		AltProjectileSpeed=AltProjClass.Default.speed;
	}
}

function inventory SpawnCopy(Pawn Other)
{
	ItemCopy=Super.SpawnCopy(Other);
	return(ItemCopy);
}

function GiveAmmo(Pawn Other)
{
	local int	BeforeItemGoal;

	if (Level.Game != None) {
		BeforeItemGoal=Level.Game.ItemGoals;
	}
	Super.GiveAmmo(Other);
	if (Level.Game != None) {
		Level.Game.ItemGoals=BeforeItemGoal;
	}
}

function Weapon RecommendWeapon(out float rating,out int bUseAltMode)
{
	local Weapon	Recommended;
	local float		oldRating,
					oldFiring;
	local int		oldMode;

	if (Owner.IsA('PlayerPawn')) {
		rating=SwitchPriority();
	}
	else {
		rating=RateSelf(bUseAltMode);
		if ((Self == Pawn(Owner).Weapon) && (AmmoType == None || (AmmoType.AmmoAmount >= AmmoConsumption))) {
			rating+=0.15;
		}
	}
	if (Inventory != None) {
		Recommended=Inventory.RecommendWeapon(oldRating,oldMode);
		if ((Recommended != None) && (oldRating > rating)) {
			rating=oldRating;
			bUseAltMode=oldMode;
			return(Recommended);
		}
	}
	return(Self);
}

function float RateSelf(out int bUseAltMode)
{
	local float EnemyDist;
	local float rating;

	rating=AIRating;
	if (AmmoType.AmmoAmount <= 0 || AmmoType.AmmoAmount < AmmoConsumption) {
		return(-2);
	}
	if (Pawn(Owner).Enemy == None) {
		bUseAltMode=0;
		return(rating);
	}
	EnemyDist=VSize(Pawn(Owner).Enemy.Location-Owner.Location);
	if (EnemyDist > 800) {
		bUseAltMode=0;
		return(rating);
	}
	bUseAltMode=int(FRand() < 0.4);
	return(rating);
}

function Weapon WeaponChange(byte F)
{	
	local Weapon	newWeapon;

	if (InventoryGroup == F) {
		if ((AmmoType != None) && (AmmoType.AmmoAmount < AmmoConsumption || AmmoType.AmmoAmount <= 0)) {
			if (Inventory == None) {
				newWeapon=None;
			}
			else {
				newWeapon=Inventory.WeaponChange(F);
			}
			if (newWeapon == None && PlayerPawn(Owner) != None) {
				PlayerPawn(Owner).ClientMessage(MessageNoAmmo);
			}
			return(newWeapon);
		}		
		else {
			return(Self);
		}
	}
	else if (Inventory == None) {
		return(None);
	}
	else {
		return(Inventory.WeaponChange(F));
	}
}

function float SwitchPriority() 
{
	local float		temp;
	local int		bTemp;

	if (Owner.IsA('ScriptedPawn')) {
		return(RateSelf(bTemp));
	}
	else if ((AmmoType != None) && (AmmoType.AmmoAmount < AmmoConsumption || AmmoType.AmmoAmount <= 0)) {
		if (Pawn(Owner).Weapon == Self) {
			return(-0.5);
		}
		else {
			return(-1);
		}
	}
	else {
		return(AutoSwitchPriority);
	}
}

function BringUp()
{
	Style=Owner.Style;
	ScaleGlow=FClamp(Owner.ScaleGlow,0.5,1.0);
//	bAltLastFired=False;
	Super.BringUp();
}

function DoWeaponReload()
{
	if (bWeaponUp) {
		GotoState('ReloadWeapon');
	}
}

function DrawMuzzleFlash()
{
	local vector	X,Y,Z;

	if (MuzzleFlashActor != None) {
		GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
		StartTrace=Owner.Location+CalcDrawOffset()+FireOffset.X*X+FireOffset.Y*Y+FireOffset.Z*Z;
		MuzzleFlashActor.SetLocation(StartTrace);
	}
}

function Finish()
{
	if (bChangeWeapon) {
		GotoState('DownWeapon');
		return;
	}
	if (PlayerPawn(Owner) == None) {
		if (AmmoType.AmmoAmount <= 0 || AmmoType.AmmoAmount < AmmoConsumption) {
			Pawn(Owner).StopFiring();
			Pawn(Owner).SwitchToBestWeapon();
		}
		else if (Pawn(Owner).bFire != 0 && FRand() < RefireRate) {
			Global.Fire(0);
		}
		else if (Pawn(Owner).bAltFire != 0 && FRand() < AltRefireRate && AmmoType.AmmoAmount >= AltAmmoConsumption) {
			Global.AltFire(0);	
		}
		else {
			Pawn(Owner).StopFiring();
			GotoState('Idle');
		}
		return;
	}
	if (Pawn(Owner).Weapon != Self) {
		GotoState('Idle');
	}
	else if (Pawn(Owner).bFire != 0 && AmmoType.AmmoAmount >= AmmoConsumption) {
		Global.Fire(0);
	}
	else if (Pawn(Owner).bAltFire != 0 && AmmoType.AmmoAmount >= AltAmmoConsumption) {
		Global.AltFire(0);
	}
	else {
		GotoState('Idle');
	}
}
 
///////////////////////////////////////////////////////

function Fire(float Value)
{
	if (!bWeaponUp) {
		return;
	}
	if (bAltLastFired && Default.ReloadCount > 0) {
		bAltLastFired=False;
		GotoState('ReloadWeapon');
	}
	else if (AmmoType.UseAmmo(AmmoConsumption)) {
		if (Default.ReloadCount > 0) {
			if (AmmoConsumption >= ReloadCount) {
				ReloadCount=0;
			}
			else {
				ReloadCount-=AmmoConsumption;
			}
		}
		GotoState('NormalFire');
		bPointing=True;
		PlayFiring();
	}
}

function AltFire(float Value)
{
	if (!bWeaponUp) {
		return;
	}
	if (AltAmmoConsumption <= 0) {
		return;
	}
	if (!bAltLastFired && Default.ReloadCount > 0) {
		bAltLastFired=True;
		GotoState('ReloadWeapon');
	}
	else if (AmmoType.UseAmmo(AltAmmoConsumption)) {
		if (Default.ReloadCount > 0) {
			if (AltAmmoConsumption >= ReloadCount) {
				ReloadCount=0;
			}
			else {
				ReloadCount-=AltAmmoConsumption;
			}
		}
		GotoState('AltFiring');
		bPointing=True;
		PlayAltFiring();
	}
}

function FireProjectile()
{
	local float		D;

	if (IsInState('NormalFire')) {
		AimTweak=AimAdjust;
		if (FireSound != None) {
			Owner.PlaySound(FireSound,SLOT_None,Pawn(Owner).SoundDampening*4.0,,DefaultSoundRadius);
		}
		if (bInstantHit) {
			TraceFire(0.0);
		}
		else {
			for (ProjNum=0 ; ProjNum < NumProjectiles ; ProjNum++) {
				WeapProj=ProjectileFire(ProjectileClass,ProjectileSpeed,bWarnTarget);
				D=DamageAmount;
				if (Bots(Owner) != None) {
					if (Bots(Owner).WeaponDamageScale != 0.0) {
						D*=Bots(Owner).WeaponDamageScale;
					}
				}
				else if (KlingonPlayer(Owner) != None) {
					if (KlingonPlayer(Owner).WeaponDamageScale != 0.0) {
						D*=KlingonPlayer(Owner).WeaponDamageScale;
					}
				}
				if (KlingonProjectiles(WeapProj) != None) {
					KlingonProjectiles(WeapProj).HurtType=HurtType;
				}
				WeapProj.Damage=D;
				LastProjDamage=D;
			}
		}
	}
	else if (IsInState('AltFiring')) {
		AimTweak=AltAimAdjust;
		if (AltFireSound != None) {
			Owner.PlaySound(AltFireSound,SLOT_None,Pawn(Owner).SoundDampening*4.0,,DefaultSoundRadius);
		}
		if (bAltInstantHit) {
			TraceFire(0.0);
		}
		else {
			for (ProjNum=0 ; ProjNum < AltNumProjectiles ; ProjNum++) {
				WeapProj=ProjectileFire(AltProjectileClass,AltProjectileSpeed,bAltWarnTarget);
				D=AltDamageAmount;
				if (Bots(Owner) != None) {
					if (Bots(Owner).WeaponDamageScale != 0.0) {
						D*=Bots(Owner).WeaponDamageScale;
					}
				}
				else if (KlingonPlayer(Owner) != None) {
					if (KlingonPlayer(Owner).WeaponDamageScale != 0.0) {
						D*=KlingonPlayer(Owner).WeaponDamageScale;
					}
				}
				if (KlingonProjectiles(WeapProj) != None) {
					KlingonProjectiles(WeapProj).HurtType=AltHurtType;
				}
				WeapProj.Damage=D;
				LastProjDamage=D;
			}
		}
	}
	if (PlayerPawn(Owner) != None) {
		PlayerPawn(Owner).ShakeView(ShakeTime,ShakeMag,ShakeVert);
	}
}

function Projectile ProjectileFire(class<projectile>ProjClass,float ProjSpeed,bool bWarn)
{
	local vector		Start,X,Y,Z;

//	Owner.MakeNoise(Pawn(Owner).SoundDampening);
	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	Start=Owner.Location+CalcDrawOffset()+FireOffset.X*X+FireOffset.Y*Y+FireOffset.Z*Z;
	AdjustedAim=WeaponAdjustAim(Start,ProjSpeed,bWarn);
	if (IsInState('AltFiring')) {
		Owner.MakeNoise(AltFireNoise);
	
//		if (AltFireSound != None) {
//			Owner.PlaySound(AltFireSound,SLOT_None,Pawn(Owner).SoundDampening*4.0,,DefaultSoundRadius);
//		}
		if (AltMuzzleFlash != None) {
			MuzzleFlashActor=Spawn(AltMuzzleFlash,,,Start);
		}
		AdjustedAim.Yaw+=(AltDispersion*(FRand()-0.5));
		AdjustedAim.Pitch+=(AltDispersion*(FRand()-0.5));
	}
	else {
		Owner.MakeNoise(FireNoise);
	
//		if (FireSound != None) {
//			Owner.PlaySound(FireSound,SLOT_None,Pawn(Owner).SoundDampening*4.0,,DefaultSoundRadius);
//		}
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

function ReFireProjectile()
{
	local Projectile	P;
	local vector		Start,X,Y,Z;

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	Start=Owner.Location+CalcDrawOffset()+FireOffset.X*X+FireOffset.Y*Y+FireOffset.Z*Z;
	if (IsInState('AltFiring')) {
		if (AltMuzzleFlash != None) {
			MuzzleFlashActor=Spawn(AltMuzzleFlash,,,Start);
		}
	}
	else {
		if (MuzzleFlash != None) {
			MuzzleFlashActor=Spawn(MuzzleFlash,,,Start);
		}
	}
	P=Spawn(LastProjClass,,,Start,LastProjAim);
	P.Damage=LastProjDamage;
}

function TraceFire(float Accuracy)
{
	local vector	HitLocation,
					HitNormal,
					EndTrace,
					X,Y,Z;
	local actor		Other;

//	Owner.MakeNoise(Pawn(Owner).SoundDampening);
	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	StartTrace=Owner.Location+CalcDrawOffset()+FireOffset.X*X+FireOffset.Y*Y+FireOffset.Z*Z;
	AdjustedAim=WeaponAdjustAim(StartTrace,0.0,False);
	if (IsInState('AltFiring')) {
		Owner.MakeNoise(AltFireNoise);
	
//		if (AltFireSound != None) {
//			Owner.PlaySound(AltFireSound,SLOT_None,Pawn(Owner).SoundDampening*4.0,,DefaultSoundRadius);
//		}
		if (AltMuzzleFlash != None) {
			MuzzleFlashActor=Spawn(AltMuzzleFlash,,,StartTrace);
		}
		AdjustedAim.Yaw+=(AltDispersion*(FRand()-0.5));
		AdjustedAim.Pitch+=(AltDispersion*(FRand()-0.5));
	}
	else {
		Owner.MakeNoise(FireNoise);
//		if (FireSound != None) {
//			Owner.PlaySound(FireSound,SLOT_None,Pawn(Owner).SoundDampening*4.0,,DefaultSoundRadius);
//		}
		if (MuzzleFlash != None) {
			MuzzleFlashActor=Spawn(MuzzleFlash,,,StartTrace);
		}
		AdjustedAim.Yaw+=(Dispersion*(FRand()-0.5));
		AdjustedAim.Pitch+=(Dispersion*(FRand()-0.5));
	}
	EndTrace=StartTrace+Accuracy*(FRand()-0.5)*Y*1000+Accuracy*(FRand()-0.5)*Z*1000;
	EndTrace+=(MaxTargetRange*vector(AdjustedAim));
	Other=Pawn(Owner).TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);
	if (VSize(HitLocation) == 0.0) {
		HitLocation=EndTrace;
	}
	WeaponRecoil();
	ProcessTraceHit(Other,HitLocation,HitNormal,vector(AdjustedAim),Y,Z);
}

function ProcessTraceHit(actor HitAct,vector HitLoc,vector HitNor,vector X,vector Y,vector Z)
{
	local vector	MomVec;
	local float		D;
	local actor		A;

	if (IsInState('NormalFire')) {
		if (HitAct != None) {
			D=DamageAmount;
			if (Bots(Owner) != None && Bots(Owner).WeaponDamageScale != 0.0) {
				D*=Bots(Owner).WeaponDamageScale;
			}
			else if (KlingonPlayer(Owner).WeaponDamageScale != 0.0) {
				D*=KlingonPlayer(Owner).WeaponDamageScale;
			}
			MomVec=D*vector(AdjustedAim)*(InstantHitMomentum*0.02);
			HitAct.TakeDamage(D,Instigator,HitLoc,MomVec,HurtType);
			if (HitAct.IsA('LevelInfo')) {
				if (InstantHitEffect != None) {
					Spawn(InstantHitEffect,,,HitLoc);
					if (HurtType == 'Sliced' || HurtType == 'Hacked')
						PlaySound(Misc3Sound,SLOT_None,Pawn(Owner).SoundDampening);
				}
				if (ScorchEffect != None) {
					A=Spawn(ScorchEffect,,,HitLoc,rotator(HitNor));
					A.DrawScale=FMax(ScorchScale*FRand(),ScorchScale*0.5);
				}
			}
		}
	}
	else if (IsInState('AltFiring')) {
		if (HitAct != None) {
			D=AltDamageAmount;
			if (Bots(Owner) != None && Bots(Owner).WeaponDamageScale != 0.0) {
				D*=Bots(Owner).WeaponDamageScale;
			}
			else if (KlingonPlayer(Owner) != None && KlingonPlayer(Owner).WeaponDamageScale != 0.0) {
				D*=KlingonPlayer(Owner).WeaponDamageScale;
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
		}
	}
}

function WeaponRecoil()
{
	local float		RecoilAmount;

	if (IsInState('AltFiring')) {
		RecoilAmount=AltShotRecoil;
	}
	else {
		RecoilAmount=ShotRecoil;
	}
	if (RecoilAmount == 0.0) {
		return;
	}
	if (PlayerPawn(Owner) != None) {
		Owner.Velocity-=vector(PlayerPawn(Owner).ViewRotation)*RecoilAmount;
//		Pawn(Owner).AddVelocity(-vector(PlayerPawn(Owner).ViewRotation)*RecoilAmount);
	}
	else {
		Owner.Velocity-=vector(Rotation)*RecoilAmount;
	}
}

/*
function rotator WeaponAdjustAim(rotator Aim)
{
	if (Owner.IsA('PlayerPawn')) {
		switch (PlayerPawn(Owner).Handedness) {
		case -1:	// right hand
			Aim.Yaw-=AimTweak.Yaw;
			break;
		case 1:		// left hand
			Aim.Yaw+=AimTweak.Yaw;
			break;
		case 0:		// center
			break;
		}
		Aim.Pitch+=AimTweak.Pitch;
		return(Aim);
	}
}
*/

function rotator WeaponAdjustAim(vector StartTrace,float ProjSpeed,bool bWarn)
{
	local float			BestAim,
						BestDist;
	local vector		HitLoc,
						HitNor,
						EndTrace,
						StartLoc,
						ViewRot;
	local actor			Other;
	local PlayerPawn	P;

	if (Bots(Owner) != None) {
		return(Bots(Owner).AdjustAim(ProjSpeed,StartTrace,Bots(Owner).AimError,True,True));
	}
	if (PlayerPawn(Owner) == None) {
		return(Rotation);
	}
	P=PlayerPawn(Owner);
	ViewRot=vector(P.ViewRotation);
	if (P.CollisionHeight != P.Default.CollisionHeight) {
		StartLoc=P.Location+(vect(0,0,0.1)*P.Default.CollisionHeight);
	}
	else {
		StartLoc=P.Location+(vect(0,0,0.8)*P.Default.CollisionHeight);
	}
	EndTrace=StartLoc+(1000000*ViewRot);
	Other=Trace(HitLoc,HitNor,EndTrace,StartLoc,True);
	if (VSize(HitLoc) == 0.0) {
		HitLoc=EndTrace;
	}
	if (Other != None && Other.bProjTarget) {
		if (bWarn && Other.IsA('Pawn')) {
			Pawn(Other).WarnTarget(P,ProjSpeed,ViewRot);
		}
		return(rotator(HitLoc-StartTrace));
	}
	BestAim=FMin(0.93,P.MyAutoAim);
	Other=P.PickTarget(BestAim,BestDist,ViewRot,StartLoc);
	if (bWarn && Pawn(Other) != None) {
		Pawn(Other).WarnTarget(P,ProjSpeed,ViewRot);
	}
	if (Level.Game.Difficulty > 2 || P.bAlwaysMouseLook || P.MyAutoAim >= 1) {
		return(rotator(HitLoc-StartTrace));
	}
	if (Other == None) {
		BestAim=P.MyAutoAim;
		Other=P.PickAnyTarget(BestAim,BestDist,ViewRot,StartLoc);
	}
	if (Other != None) {
		HitLoc=StartLoc+ViewRot*BestDist;
		HitLoc.Z=Other.Location.Z+0.3*Other.CollisionHeight;
	}
	return(rotator(HitLoc-StartTrace));
}

function PlayFiring()
{
	PlayAnim('Shoot',FireRate,FireRate/10.0);
}

function PlayAltFiring()
{
	PlayAnim('Shoot',AltFireRate,AltFireRate/10.0);
}

function PlayIdleAnim()
{
	LoopAnim('Idle',0.04,0.3);
//	Enable('AnimEnd');
}

function Landed(vector HitNormal)
{
	local rotator	R;
	local float		FallDamage;

	FallDamage=Abs(0.015*Velocity.Z);
	TakeDamage(FallDamage,None,Location,vect(0,0,0),'fell');
	Velocity=((Velocity dot HitNormal)*HitNormal*(-2.0)+Velocity);
	Velocity*=(0.9-FClamp(Mass/100,0.1,0.8));
	R=Rotation;
	if (VSize(Velocity) < 30) {
		bBounce=False;
		SetPhysics(PHYS_None);
		Velocity=vect(0,0,0);
		bFixedRotationDir=False;
		R.Roll=0.0;
	}
	R.Pitch=0.0;
	SetRotation(R);
}

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}
}

function PickupFunction(pawn P)
{
	ItemCopy.LifeSpan=0;
	if (bIsItemGoal) {
		P.ItemCount++;
		if (Level.Game != None) {
			if (KlingonGameInfo(Level.Game) != None) {
				KlingonGameInfo(Level.Game).ItemCount++;
			}
		}
	}
}

auto state Pickup
{
	function ZoneChange(ZoneInfo NewZone)
	{
		Global.ZoneChange(NewZone);
	}
	function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLocation,Vector Momentum,name DamageType)
	{
		if (Mass > 0.0) {
			MomentumMove(Self,Momentum);
		}
	}
	function Landed(vector HitNormal)
	{
		Global.Landed(HitNormal);
	}
	function HitWall(vector HitNormal,actor HitWall)
	{
		Global.Landed(HitNormal);
	}
	function Touch(actor Other)
	{
		if (ValidTouch(Other)) {
			Super.Touch(Other);
			if (Pawn(Other) != None) {
				PickupFunction(Pawn(Other));
			}
		}
	}
}

state NormalFire
{
	function Fire(float f)
	{
	}
	function AltFire(float f)
	{
	}
	simulated function Tick(float delta)
	{
		DrawMuzzleFlash();
	}
Begin:
	FinishAnim();
	if (Default.ReloadCount > 0 && ReloadCount < AmmoConsumption && AmmoType.AmmoAmount >= ReloadCount) {
		GotoState('ReloadWeapon');
	}
	else {
		Finish();
	}
}

state AltFiring
{
	function Fire(float f)
	{
	}
	function AltFire(float f)
	{
	}
	simulated function Tick(float delta)
	{
		DrawMuzzleFlash();
	}
Begin:
	FinishAnim();
	if (Default.ReloadCount > 0 && ReloadCount < AltAmmoConsumption && AmmoType.AmmoAmount >= ReloadCount) {
		GotoState('ReloadWeapon');
	}
	else {
		Finish();
	}
}

state Idle
{
	function AnimEnd()
	{
		PlayIdleAnim();
	}
	function bool PutDown()
	{
		if (bWeaponUp || (AnimFrame < 0.75)) {
			GotoState('DownWeapon');
		}
		else {
			bChangeWeapon=True;
		}
		return(True);
	}
Begin:
	bPointing=False;
	if (AmmoType != None && (AmmoType.AmmoAmount <= 0 || AmmoType.AmmoAmount < AmmoConsumption)) {
		Pawn(Owner).SwitchToBestWeapon();
	}
	if (Pawn(Owner).bFire != 0) {
		Fire(0.0);
	}
	if (Pawn(Owner).bAltFire != 0) {
		AltFire(0.0);
	}
	Disable('AnimEnd');
	PlayIdleAnim();
}

state ReloadWeapon
{
	function Fire(float f)
	{
	}
	function AltFire(float f)
	{
	}
Begin:
	Owner.PlaySound(CockingSound,SLOT_None,Pawn(Owner).SoundDampening,,DefaultSoundRadius);
	PlayAnim('Reload',1.0);
	ReloadCount=Default.ReloadCount;
	FinishAnim();
	Finish();
}

defaultproperties
{
     DefaultSoundRadius=1600.000000
     AimAdjust=(Pitch=100,Yaw=200)
     AltAimAdjust=(Pitch=100,Yaw=200)
     FireOffset=(X=25.000000,Y=-15.000000,Z=5.000000)
     bRotatingPickup=False
     PlayerViewOffset=(X=0.000000,Z=-20.000000)
     PickupSound=Sound'KlingonSFX01.Pickups.GenPickup'
     RespawnSound=Sound'KlingonSFX01.Effects.Replicator'
     bMeshCurvy=False
}
