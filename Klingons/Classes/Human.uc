//=============================================================================
// Human.
//=============================================================================
class Human expands KlingonPlayer
	abstract;

//	Animations

var(Animations)	name	Wait1;
var(Animations) name	Wait2;
var(Animations) name	Walk;
var(Animations) name	Run;
var(Animations) name	WalkShoot;
var(Animations) name	RunShoot;
var(Animations) name	Shoot;
var(Animations) name	Scooch;
var(Animations) name	ScoochShoot;
var(Animations) name	Swim;
var(Animations) name	SwimShoot;
var(Animations) name	TreadWater;
var(Animations) name	TreadWaterShoot;
var(Animations) name	RollRight;
var(Animations) name	RollLeft;
var(Animations) name	HitBack;
var(Animations) name	HitGut;
var(Animations) name	HitHead;
var(Animations) name	HitLeft;
var(Animations) name	HitRight;
var(Animations) name	HitScooching;
var(Animations) name	B_Slash;
var(Animations) name	B_BackSlash;
var(Animations) name	B_OverHeadSlash;
var(Animations) name	B_RunSlash;
var(Animations) name	B_WalkSlash;
var(Animations) name	B_ScoochJab;
var(Animations) name	B_SwimSlash;
var(Animations) name	B_TreadWaterSlash;
var(Animations) name	D_Slash;
var(Animations) name	D_BackSlash;
var(Animations) name	D_Stab;
var(Animations) name	AD_Shoot;
var(Animations) name	AD_RunShoot;
var(Animations) name	S_Shoot;
var(Animations) name	S_RunShoot;
var(Animations) name	GL_Shoot;
var(Animations) name	GL_RunShoot;
var(Animations) name	BFG_Shoot;
var(Animations) name	BFG_RunShoot;
var(Animations) name	R_Shoot;
var(Animations) name	R_RunShoot;
var(Animations) name	RL_Shoot;
var(Animations) name	RL_RunShoot;
var(Animations) name	SC_Shoot;
var(Animations) name	SC_RunShoot;
var(Animations) name	LadderClimb;
var(Animations) name	BackFloat;
var(Animations) name	DeadTreader;
var(Animations) name	DeadSwimmer;
var(Animations) name	DeadScooch;
var(Animations) name	DeadBlownBack;
var(Animations) name	DeadBackToFace;
var(Animations) name	DeadRollBack;
var(Animations) name	DeadBlownRight;
var(Animations) name	DeadBlownLeft;
var(Animations) name	DeadFallBack;
var(Animations) name	DeadFallFace;
var(Animations) name	DeadFallSide;
var(Animations) name	Taunt1;
var(Animations) name	Jump;
var(Animations) name	Landed;
var(Animations) name	Reload;
var(Animations) name	BackPeddle;
var(Animations) name	BackPeddleShoot;
var(Animations) name	BackPeddleSlash;

//-----------------------------------------------------------------------------
//	Sounds

var(Sounds) sound		LeftStep;
var(Sounds) sound		RightStep;
var(Sounds) sound		LeftGravel;
var(Sounds) sound		RightGravel;
var(Sounds) sound		LeftMetal;
var(Sounds) sound		RightMetal;
var(Sounds) sound		GaspSound;	//ExitWater;
var(Sounds) sound		Swimming;
var(Sounds) sound		WaterDeath;
var(Sounds) sound		GaspDamage;	//ExitWaterDamage;

var(Sounds) sound		FGrunt1;
var(Sounds) sound		FGrunt2;
var(Sounds) sound		FBigGrunt;
var(Sounds) sound		MGrunt1;
var(Sounds) sound		MGrunt2;
var(Sounds) sound		MBigGrunt;
var(Sounds)	sound		DisolveDeath;

var(Sounds) sound		UnderWaterAmbience;
var(Sounds) sound		UnderWaterDamage;


//-----------------------------------------------------------------------------
//	Variables
var	BOOL	bPlaySwimSound;
var BOOL	bJustSurfaced;
var BOOL	bUnderWaterDamage;
var int		SpecialDeath;
var(Pawn) class <BloodSplat>    SplatClass;

//-----------------------------------------------------------------------------
// Animation functions

state MagBootWalk
{
	function MagWalk()
	{
		PlayWalking();
	}
	
	function MagWait()
	{
		PlayWaiting();
	}
	
	function MagJump()
	{
		PlayInAir();
}
}

simulated function bool Gibbed()
{
	return FALSE;
}

function TakeDamage(int Damage,pawn InstigatedBy,vector HitLocation,vector Momentum,name DamageType)
{
	local int OldHealth;
	OldHealth = Health;
	
	if (damageType == 'blended')
		Damage += 500;
	Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);

	if (OldHealth > Health) 
	{
		if (Damage >= 7)
			SpawnBlood(Damage, HitLocation, (momentum/Mass)*3);
	}
	
}

//**********************************************************************
function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
	local int i,j;
	local BloodSplat b;
	local Rotator rot;
	local ParticleBlood P1;
	rot = Rotator(HitLocation - location);
	rot.pitch = max(min(Rot.Pitch,4000),-4000);

	if (Level.Game.bLowGore)
		return;

	for (i=min(Damage,70); i > 0; i-=10)
	{
		rot.roll = Rand(65536);
		if (SplatClass == none)
		{
			b=Spawn(class 'BloodSplat',self,'',HitLocation,rot);
			
		}
		else
		{
			b=Spawn(SplatClass,self,'',HitLocation,rot);
		}	
		
		if (b != none)
		{
			b.SetPhysics(PHYS_Falling);
			b.Velocity = Momentum * (0.2 + FRand());
		}
	}
}

simulated function PlayClimbing()
{
	PlayAnim (LadderClimb, 1.5, 0.1);
}

simulated function PlayTurning()
{
//	Log("Play Turning");
	BaseEyeHeight = Default.BaseEyeHeight;
	LoopAnim (Walk, 1.5, 0.1);
}

simulated function TweenToWalking(float tweentime)
{
	BaseEyeHeight = Default.BaseEyeHeight;
	TweenAnim (Walk, 0.05);	
}

simulated function TweenToRunning(float tweentime)
	{
	//	Log ("Tween To Running ");
		BaseEyeHeight = Default.BaseEyeHeight;
		if (bIsWalking)
		{
			TweenToWalking(0.1);
			return;
		}

		TweenAnim (Run, 0.05);
	}

simulated function PlayWalking()
{
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		if ( (vector(Rotation) Dot Acceleration) > 0 )
			PlaySwimming();
		else
			PlayWaiting();
		return;
	}

	//Log ("Player Walking");
	BaseEyeHeight = Default.BaseEyeHeight;

	if (Weapon.bPointing || (CarriedDecoration != None)) {
		if (KlingonWeapons(Weapon).WeaponType==1 || KlingonWeapons(Weapon).WeaponType==2) {
			if (bIsBackPeddling)
				LoopAnim (BackPeddleSlash, 1.5, 0.1);
			else
				LoopAnim (B_WalkSlash, 1.5, 0.1);
		}
		else {
			if (bIsBackPeddling)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (WalkShoot, 1.5, 0.1);
		}
	}
	else {
		if (bIsBackPeddling)
			LoopAnim (BackPeddle, 1.5, 0.1);
		else
			LoopAnim (Walk, 1.5, 0.05);
	}
}

simulated function PlayRunning()
{
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
//		PlaySound (enterwater);
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		if ( (vector(Rotation) Dot Acceleration) > 0 )
			PlaySwimming();
		else
			PlayWaiting();
		return;
	}

	//Log ("Player Running");
	BaseEyeHeight = Default.BaseEyeHeight;
	
	if (bIsBackPeddling) {
		if (Weapon.bPointing || (CarriedDecoration != None)) {
			if (KlingonWeapons(Weapon).WeaponType==1 || KlingonWeapons(Weapon).WeaponType==2)
				LoopAnim (BackPeddleSlash, 1.5, 0.1);
			else
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
		}
		else {
			LoopAnim (BackPeddle, 1.5, 0.1);
		}
		return;
	}
	
	if (Weapon.bPointing==TRUE) {
//		Log ("Run and Shoot");
		switch (KlingonWeapons(Weapon).WeaponType) {
		case 0:		// Assault Disrupter
			LoopAnim (AD_RunShoot, 1.5, 0.1);
//			Log ("Assault Disrupter");
			break;
		case 1:		// Batleth
			LoopAnim (B_RunSlash, 1.5, 0.1);
//			Log ("Batleth");
			break;
		case 2:		// Daktagh
			LoopAnim (B_RunSlash, 1.5, 0.1);
//			Log ("Daktagh");
			break;	
		case 3:		// Disrupter Pistol
			LoopAnim (RunShoot, 1.5, 0.1);
//			Log ("Disrupter Pistol");
			break;
		case 4:		// Disrupter Rifle
			LoopAnim (R_RunShoot, 1.5, 0.1);
//			Log ("Disrupter Rifle");
			break;
		case 5:		// Grenade Launcher
			LoopAnim (GL_RunShoot, 1.5, 0.1);
//			Log ("Grenade Launcher");
			break;
		case 6:		// Particle Cannon
			LoopAnim (BFG_RunShoot, 1.5, 0.1);
//			Log ("Particle Cannon");
			break;
		case 7:		// Rocket Launcher
			LoopAnim (RL_RunShoot, 1.5, 0.1);
//			Log ("Rocket Launcher");
			break;
		case 8:		// SithHar
			LoopAnim (S_RunShoot, 1.5, 0.1);
//			Log ("SithHar");
			break;
		case 9:		// SpinClaw
			LoopAnim (SC_RunShoot, 1.5, 0.1);
//			Log ("Spin Claw");
			break;
		default:
			LoopAnim (Run, 1.5, 0.1);
//			Log ("Unknown Weapon");
			break;
		}
	}
	else {
		LoopAnim(Run, 1.5, 0.05);
//		Log ("Run");
	}
}

simulated function PlayRising()
{
	BaseEyeHeight = 0.4 * Default.BaseEyeHeight;
	TweenAnim(Scooch, 0.1);
}

simulated function PlayFeignDeath()
{
	local float decision;
	local rotator R;

	BaseEyeHeight = 0;
	R = Rotation;
	R.Pitch = 0;
	SetRotation(R);
		
	decision = FRand();
	if ( decision < 0.5 )
		PlayAnim(DeadFallBack, 1.5, 0.05);
	else 
		PlayAnim(DeadFallSide, 1.5, 0.05);
}


simulated function PlayDying(name DamageType, vector HitLoc)
{
	local vector X,Y,Z, HitVec, HitVec2D;
	local float dotp;
	local carcass carc;
	local float RandAni, RandDeath;
		
	SpecialDeath = 0;
		
	if (DamageType == 'blended')
	{
		SpecialDeath = 8;	// Instant gib with fans
		return;
	}
	RandDeath = FRand();
	if (Region.Zone.ZoneGravity.Z > -200) {
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		SpecialDeath = 6;
		return;
	}
	
	if (Region.Zone.bWaterZone) {
		PlaySound(WaterDeath,SLOT_Misc,1.0,True);
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		if (RandDeath>0.7)
			SpecialDeath = 6;
		else
			PlayAnim(DeadSwimmer,0.7,0.1);
		return;
	}
	
	if (Velocity.Z > 300) {
		SpecialDeath = 3;
		return;
	}

	switch (DamageType) {
	case 'burned':
		if (RandDeath>0.3) {
			SpecialDeath = 4;
			return;
		}
		break;
	case 'blasted':
		if (RandDeath>0.85) {
			SpecialDeath = 4;
			return;
		}
		break;
	case 'disintegrated':
		if (RandDeath>0.5) {
			SpecialDeath = 1;
			return;
		}
		break;
	case 'zapped':
		if (RandDeath>0.4) {
			SpecialDeath = 2;
			return;
		}
		break;
	case 'peppered':
		if (RandDeath>0.3) {
			SpecialDeath = 2;
			return;
		}
		break;
	case 'exploded':
		SpecialDeath = 8;
		return;
	}
	
	if (Health<-51) {
		SpecialDeath = 8;
		return;
	}
			
	PlaySound(Die,SLOT_Misc);
	BaseEyeHeight = Default.BaseEyeHeight;
			
	if ( FRand() < 0.15 )
	{
		PlayAnim(DeadRollBack,0.7,0.1);
		return;
	}

	// check for big hit
	if ( (Velocity.Z > 250) && (FRand() < 0.7) )
	{
		PlayAnim(DeadBlownBack, 0.7, 0.1);
		return;
	}

	// check for head hit
	if (DamageType == 'Perforated' && (HitLoc.Z - Location.Z > 0.6 * CollisionHeight))
	{
		PlayAnim(DeadBackToFace, 0.7, 0.1);
		return;
	}

	GetAxes(Rotation,X,Y,Z);
	X.Z = 0;
	HitVec = Normal(HitLoc - Location);
	HitVec2D= HitVec;
	HitVec2D.Z = 0;
	dotp = HitVec2D dot X;
	
	if (Abs(dotp) > 0.71) //then hit in front or back
		PlayAnim(DeadFallFace, 0.7, 0.1);
	else
	{
		dotp = HitVec dot Y;
		if (dotp > 0.0)
		{	// Right
			if (FRand()>0.67)
				PlayAnim(DeadFallSide, 0.7, 0.1);
			else
				PlayAnim(DeadBlownRight, 0.7, 0.1);
		}
		else	// Left
			if (FRand()>0.67)
				PlayAnim(DeadFallSide, 0.7, 0.1);
			else
				PlayAnim(DeadBlownLeft, 0.7, 0.1);
	}
}


simulated function PlayGutHit(float tweentime)
{
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
		return;
		
	if ( (AnimSequence == HitGut) || (AnimSequence == DeadFallBack) )
	{
		if (FRand() < 0.5)
			TweenAnim(HitLeft, 0.05);
		else
			TweenAnim(HitRight, 0.05);
	}
	else
		TweenAnim(HitGut, 0.05);

}

simulated function PlayHeadHit(float tweentime)
{
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
		return;
		
	if ( (AnimSequence == HitHead) || (AnimSequence == DeadFallBack) )
		TweenAnim(HitHead, 0.05);
	else if ( FRand() < 0.6 )
		TweenAnim(HitHead, 0.05);
	else
		TweenAnim(HitGut, 0.05);
}

simulated function PlayLeftHit(float tweentime)
{
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
		return;
		
	if ( (AnimSequence == HitLeft) || (AnimSequence == DeadFallBack) )
		TweenAnim(HitLeft, 0.05);
	else if ( FRand() < 0.6 )
		TweenAnim(HitLeft, 0.05);
	else 
		TweenAnim(HitGut, 0.05);
}

simulated function PlayRightHit(float tweentime)
{
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
		return;
		
	if ( (AnimSequence == HitRight) || (AnimSequence == DeadFallBack) )
		TweenAnim(HitRight, 0.05);
	else if ( FRand() < 0.6 )
		TweenAnim(HitRight, 0.05);
	else
		TweenAnim(HitGut, 0.05);
}
	
simulated function PlayLanded(float impactVel)
{	
	impactVel = impactVel/JumpZ;
	impactVel = 0.1 * impactVel * impactVel;
	BaseEyeHeight = Default.BaseEyeHeight;

	if ( Role == ROLE_Authority )
	{
		if ( !FootRegion.Zone.bWaterZone && (impactVel > 0.01) )
			PlaySound(rightStep, SLOT_Interact, FClamp(4 * impactVel,0.5,5), false,1000, 1.0);
	}
	if ( (impactVel > 0.06) || (GetAnimGroup(AnimSequence) == 'Jumping') )
	{
		TweenAnim(Landed, 0.12);
	}
	else if ( !IsAnimating() )
	{
		if ( GetAnimGroup(AnimSequence) == 'TakeHit' )
		{
			SetPhysics(PHYS_Walking);
			AnimEnd();
		}
		else 
		{
			TweenAnim(Landed, 0.12);
		}
	}
}
	
simulated function PlayInAir()
{
	BaseEyeHeight =  0.7 * Default.BaseEyeHeight;
	TweenAnim(Jump, 0.1);
}

simulated function PlayDuck()
{
	BaseEyeHeight = 0;
	TweenAnim(Scooch, 0.25);
}

simulated function PlayCrawling()
{
	//log("Play duck");
	BaseEyeHeight = 0;
	LoopAnim(Scooch, 1.0, 0.1);
}

simulated function TweenToWaiting(float tweentime)
{
//	Log("Tween Waiting - "$tweentime);
//	Log ("State -"$GetStateName());
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		LoopAnim(TreadWater, 1.5, 0.05);
	}
	else if ((Weapon != none) && (Weapon.bPointing==TRUE)) {
		PlayFiring();
	}
	else
	{
		BaseEyeHeight = Default.BaseEyeHeight;
		PlayAnim(Wait1, 1.0, 0.05);
	}
}
	
simulated function PlayWaiting()
{
	local name newAnim;

//	Log("Waiting");
	BaseEyeHeight = Default.BaseEyeHeight;
	
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		if (Weapon.bPointing==TRUE)
			LoopAnim(TreadWaterShoot, 1.5, 0.1);
		else
			LoopAnim(TreadWater, 1.5, 0.1);
	}
	else
	{
		if (bIsTurning)
			PlayTurning();
		else
			LoopAnim(Wait1, 1.0, 0.05);
	}
}	

simulated function PlayFiring()
{
	// switch animation sequence mid-stream if needed
	//Log ("PlayFiring");
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk'))) {
		AnimSequence = SwimShoot;
	}
	else if (bIsCrouching) {
		if (KlingonWeapons(Weapon).WeaponType == 1 || KlingonWeapons(Weapon).WeaponType == 2)
			AnimSequence = B_ScoochJab;
		else
			AnimSequence = ScoochShoot;
	}
	else {
		switch (KlingonWeapons(Weapon).WeaponType) {
		case 0:		// Assault Disrupter
			if (AnimSequence==Run)
				AnimSequence = AD_RunShoot;
			else if (AnimSequence==Walk)
				AnimSequence = WalkShoot;
			else
				LoopAnim (AD_Shoot, 0.7, 0.1);
//			Log ("Assault Disrupter");
			break;
		case 1:		// Batleth
			if (AnimSequence==Run)
				AnimSequence = B_RunSlash;
			else if (AnimSequence==Walk)
				AnimSequence = B_WalkSlash;
			else
				LoopAnim (B_Slash, 1.0, 0.1);
//			Log ("Batleth");
			break;
		case 2:		// Daktagh
			if (AnimSequence==Run)
				AnimSequence = B_RunSlash;
			else if (AnimSequence==Walk)
				AnimSequence = B_WalkSlash;
			else
				LoopAnim (D_Slash, 1.0, 0.1);
//			Log ("Daktagh");
			break;	
		case 3:		// Disrupter Pistol
			if (AnimSequence==Run)
				AnimSequence = RunShoot;
			else if (AnimSequence==Walk)
				AnimSequence = WalkShoot;
			else
				LoopAnim (Shoot, 0.7, 0.1);
//			Log ("Disrupter Pistol");
			break;
		case 4:		// Disrupter Rifle
			if (AnimSequence==Run)
				AnimSequence = R_RunShoot;
			else if (AnimSequence==Walk)
				AnimSequence = WalkShoot;
			else
				LoopAnim (R_Shoot, 1.0, 0.1);
//			Log ("Disrupter Rifle");
			break;
		case 5:		// Grenade Launcher
			if (AnimSequence==Run)
				AnimSequence = GL_RunShoot;
			else if (AnimSequence==Walk)
				AnimSequence = WalkShoot;
			else
				LoopAnim (GL_Shoot, 1.0, 0.1);
//			Log ("Grenade Launcher");
			break;
		case 6:		// Particle Cannon
			if (AnimSequence==Run)
				AnimSequence = BFG_RunShoot;
			else if (AnimSequence==Walk)
				AnimSequence = WalkShoot;
			else
				PlayAnim (BFG_Shoot, 0.7, 0.5);
//			Log ("Particle Cannon");
			break;
		case 7:		// Rocket Launcher
			if (AnimSequence==Run)
				AnimSequence = RL_RunShoot;
			else if (AnimSequence==Walk)
				AnimSequence = WalkShoot;
			else
				LoopAnim (RL_Shoot, 1.0, 0.1);
//			Log ("Rocket Launcher");
			break;
		case 8:		// SithHar
			if (AnimSequence==Run)
				AnimSequence = S_RunShoot;
			else if (AnimSequence==Walk)
				AnimSequence = WalkShoot;
			else
				LoopAnim (S_Shoot, 1.0, 0.1);
//			Log ("SithHar");
			break;
		case 9:		// SpinClaw
			if (AnimSequence==Run)
				AnimSequence = SC_RunShoot;
			else if (AnimSequence==Walk)
				AnimSequence = WalkShoot;
			else
				PlayAnim (SC_Shoot, 0.8, 0.1);
//			Log ("Spin Claw");
			break;
		default:
			LoopAnim (Shoot, 1.0, 0.1);
//			Log ("Shoot - Unknown Weapon!");
			break;
		}
	}
}

simulated function PlayWeaponSwitch(Weapon NewWeapon)
{
}

simulated function PlaySwimming()
{
	BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
	if (Weapon.bPointing==TRUE)
		LoopAnim (SwimShoot, 1.5, 0.1);
	else
		LoopAnim(Swim, 1.5, 0.1);
}

simulated function TweenToSwimming(float tweentime)
{
	BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
	TweenAnim(Swim,0.05);
}

simulated function PlayDodge()
{
	if (DodgeDir == DODGE_Left) {
		PlayAnim (RollLeft, 1.0, 0.1);
	}
	else if (DodgeDir == DODGE_Right) {
		PlayAnim (RollRight, 1.0, 0.1);
	}
}

simulated function PlayLeftFootStep()
{
	if (Velocity.z==0 && VSize(Velocity)>40) {
//		Log ("LeftStep");
		if (FRand()<0.5)
			PlaySound(leftstep, SLOT_Misc);
		else
			PlaySound(rightstep, SLOT_Misc);
	}
}

simulated function PlayRightFootStep()
{
	if (Velocity.z==0 && VSize(Velocity)>40) {
//		Log ("RightStep");
		if (FRand()<0.5)
			PlaySound(leftstep, SLOT_Misc);
		else
			PlaySound(rightstep, SLOT_Misc);
	}
}

simulated function PlaySwimmingSound()
{
	if (Region.Zone.bWaterZone) {
		if (VSize(Velocity)>40) {
			if (bPlaySwimSound)
				bPlaySwimSound = FALSE;
			else
				bPlaySwimSound = TRUE;
				
			if (bPlaySwimSound)
				PlaySound(swimming, SLOT_Misc);
		}
	}
}

simulated function PlayClimbSound()
{
	if (FRand() < 0.5) {
		PlaySound(leftMetal, SLOT_Misc);
	}
	else {
		PlaySound(rightMetal, SLOT_Misc);
	}
}

simulated function Gasp()
{
	if (bUnderWaterDamage) {
		PlaySound(GaspDamage,SLOT_Pain,1.0,True);
		bUnderWaterDamage=False;
	}
	else {
		PlaySound(GaspSound,SLOT_Pain,1.0,True);
	}
}

simulated function PlayHit(float Damage,vector HitLocation,name damageType,float MomentumZ)
{
	PlayTakeHit(0.05, HitLocation, Damage);
	Super.PlayHit(Damage,HitLocation,damageType,MomentumZ);
	if (Level.TimeSeconds-LastPainSound < 0.25) {
		return;
	}
	if (Damage > 0) {
		if (damageType == 'drowned') {
			if (UnderWaterDamage != None) {
				PlaySound(UnderWaterDamage,SLOT_Pain);
			}
			bUnderWaterDamage=True;
		}
		else {
			PlayTakeHitSound(Damage,damageType,2);
		}
	}
}

simulated function HeadZoneChange(ZoneInfo NewHeadZone)
{
	if (Level.NetMode == NM_Client) {
		return;
	}
	Super.HeadZoneChange(NewHeadZone);
	if (NewHeadZone.bWaterZone) {
		AmbientSound=UnderWaterAmbience;
		SoundRadius=1;
		SoundVolume=128;
	}
	else if (AmbientSound == UnderWaterAmbience) {
		AmbientSound=Default.AmbientSound;
		SoundRadius=Default.SoundRadius;
		SoundVolume=Default.SoundVolume;
	}
}

defaultproperties
{
     Walk=Walk
     Run=Run
     WalkShoot=WalkShoot
     RunShoot=RunShoot
     Shoot=Shoot
     Scooch=Scooch
     ScoochShoot=ScoochShoot
     Swim=Swim
     SwimShoot=SwimShoot
     TreadWater=TreadWater
     TreadWaterShoot=TreadWaterShoot
     RollRight=RollRight
     RollLeft=RollLeft
     HitBack=HitBack
     HitGut=HitGut
     HitHead=HitHead
     HitLeft=HitLeft
     HitRight=HitRight
     HitScooching=HitScooching
     B_Slash=Slash_BAT
     B_BackSlash=BackSlash_BAT
     B_OverHeadSlash=OverHeadSlash_BAT
     B_RunSlash=RunSlash_BAT
     B_WalkSlash=WalkSlash_BAT
     B_ScoochJab=ScoochSlash_BAT
     B_SwimSlash=SwimSlash_BAT
     B_TreadWaterSlash=TreadWaterSlash_BAT
     D_Slash=Slash_DAK
     D_BackSlash=BackSlash_DAK
     D_Stab=Stab_DAK
     AD_Shoot=Shoot_AD
     AD_RunShoot=RunShoot_AD
     S_Shoot=Shoot_SIT
     S_RunShoot=RunShoot_SIT
     GL_Shoot=Shoot_GL
     GL_RunShoot=RunShoot_GL
     BFG_Shoot=Shoot_BFG
     BFG_RunShoot=RunShoot_BFG
     R_Shoot=Shoot_DR
     R_RunShoot=RunShoot_DR
     RL_Shoot=Shoot_RL
     RL_RunShoot=RunShoot_RL
     SC_Shoot=Shoot_SC
     SC_RunShoot=RunShoot_SC
     LadderClimb=LadderClimb
     BackFloat=FloatingOnBack
     DeadTreader=DeadTreader
     DeadSwimmer=DeadSwimmer
     DeadScooch=DeadScooch
     DeadBlownBack=DeadBlownBack
     DeadBacktoFace=DeadBacktoFace
     DeadRollBack=DeadRollBack
     DeadBlownRight=DeadBlownRight
     DeadBlownLeft=DeadBlownLeft
     DeadFallBack=DeadFallBack
     DeadFallFace=DeadFallFace
     DeadFallSide=DeadFallSide
     Taunt1=Taunt1
     Jump=Jump
     Landed=Land
     Reload=Reload
     SplatClass=Class'Klingons.BloodSplat'
     AnimSequence=Wait
     bMeshCurvy=False
}
