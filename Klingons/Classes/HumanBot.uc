//=============================================================================
// HumanBot.
//=============================================================================
class HumanBot expands Bots
	abstract;

var(Animations)	name	Wait1;
var(Animations)	name	Wait2;
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
// Sound vars 

var(Sounds) sound	leftstep;
var(Sounds) sound	rightstep;
var(Sounds) sound	leftGravel;
var(Sounds) sound	rightGravel;
var(Sounds) sound	leftMetal;
var(Sounds) sound	rightMetal;
var(Sounds) sound	ExitWater;
var(Sounds) sound	Swimming;
var(Sounds) sound	WaterDeath;
var(Sounds) sound	ExitWaterDamage;
var(Sounds) sound	DamageUnderwater;
var(Sounds) sound	FGrunt1;
var(Sounds) sound	FGrunt2;
var(Sounds) sound	FBigGrunt;
var(Sounds) sound	MGrunt1;
var(Sounds) sound	MGrunt2;
var(Sounds) sound	MBigGrunt;
var(Sounds)	sound	DisolveDeath;

// Wingman Speech
var(Sounds)	sound	SummonWingman1;
var(Sounds)	sound	SummonWingman2;
var(Sounds)	sound	SummonWingman3;
var(Sounds)	sound	SummonWingman4;
var(Sounds)	sound	SummonWingman5;
var(Sounds) sound	LowHealth1;
var(Sounds) sound	LowHealth2;
//-----------------------------------------------------------------------------
//	Variables

var	BOOL	bIsMale;
var(Pawn) class <BloodSplat>    SplatClass;


//-----------------------------------------------------------------------------
// Animation functions


function TakeDamage(int Damage,pawn InstigatedBy,vector HitLocation,vector Momentum,name DamageType)
{
	if (Damage >= 7)
		SpawnBlood(Damage, HitLocation,(momentum/Mass)*3);
	Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
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
		
		if (b == none)
			Log("BloodSpawn Failed");
		else
		{
			b.SetPhysics(PHYS_Falling);
			b.Velocity = Momentum * (0.2 + FRand());
		}
	}
}


simulated function PlayTurning()
{
//	Log("Play Turning");
	BaseEyeHeight = Default.BaseEyeHeight;
	LoopAnim (Walk, 1.5, 0.1);
}

function TweenToWalking(float tweentime)
	{
		//Log("Tween To Walking");
		if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
		{
			if ( (vector(Rotation) Dot Acceleration) > 0 )
				TweenToSwimming(tweentime);
			else
				TweenToWaiting(tweentime);
		}
		
		BaseEyeHeight = Default.BaseEyeHeight;
		if (Weapon == None)
			TweenAnim(Walk, tweentime);
		else if ( Weapon.bPointing ) 
		{
			switch (KlingonWeapons(Weapon).WeaponType) {
			case 0:		// Assault Disrupter
				TweenAnim (WalkShoot, tweentime);
				break;
			case 1:		// Batleth
				TweenAnim (B_WalkSlash, tweentime);
				break;
			case 2:		// Daktagh
				TweenAnim (B_WalkSlash, tweentime);
				break;	
			case 3:		// Disrupter Pistol
				TweenAnim (WalkShoot, tweentime);
				break;
			case 4:		// Disrupter Rifle
				TweenAnim (WalkShoot, tweentime);
				break;
			case 5:		// Grenade Launcher
				TweenAnim (WalkShoot, tweentime);
				break;
			case 6:		// Particle Cannon
				TweenAnim (WalkShoot, tweentime);
				break;
			case 7:		// Rocket Launcher
				TweenAnim (WalkShoot, tweentime);
				break;
			case 8:		// SithHar
				TweenAnim (WalkShoot, tweentime);
				break;
			case 9:		// SpinClaw
				TweenAnim (WalkShoot, tweentime);
				break;
			default:
				TweenAnim (Walk, tweentime);
				break;
			}
		}
		else
		{
			TweenAnim(Walk, tweentime);
		} 
		
	}


function TweenToRunning(float tweentime)
	{
		//Log("Tween To Running");
		
		if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
		{
			if ( (vector(Rotation) Dot Acceleration) > 0 )
				TweenToSwimming(tweentime);
			else
				TweenToWaiting(tweentime);
			return;
		}

		BaseEyeHeight = Default.BaseEyeHeight;

		if (Weapon == None)
			TweenAnim(Run, tweentime);
		else if ( Weapon.bPointing ) 
		{
			switch (KlingonWeapons(Weapon).WeaponType) {
			case 0:		// Assault Disrupter
				TweenAnim (AD_RunShoot, tweentime);
				break;
			case 1:		// Batleth
				TweenAnim (B_RunSlash, tweentime);
				break;
			case 2:		// Daktagh
				TweenAnim (B_RunSlash, tweentime);
				break;	
			case 3:		// Disrupter Pistol
				TweenAnim (RunShoot, tweentime);
				break;
			case 4:		// Disrupter Rifle
				TweenAnim (R_RunShoot, tweentime);
				break;
			case 5:		// Grenade Launcher
				TweenAnim (GL_RunShoot, tweentime);
				break;
			case 6:		// Particle Cannon
				TweenAnim (BFG_RunShoot, tweentime);
				break;
			case 7:		// Rocket Launcher
				TweenAnim (RL_RunShoot, tweentime);
				break;
			case 8:		// SithHar
				TweenAnim (S_RunShoot, tweentime);
				break;
			case 9:		// SpinClaw
				TweenAnim (SC_RunShoot, tweentime);
				break;
			default:
				TweenAnim (Run, tweentime);
				break;
			}
		}
		else
		{
			TweenAnim(Run, tweentime);
		} 
		
	}

function PlayWalking()
{
	local float strafeMag;
	local vector Focus2D, Loc2D, Dest2D;
	local vector lookDir, moveDir, Y;

	//Log ("Player Walking");
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
		if ( (vector(Rotation) Dot Acceleration) > 0 )
			PlaySwimming();
		else
			PlayWaiting();
		return;
	}

	BaseEyeHeight = Default.BaseEyeHeight;
	Focus2D = Focus;
	Focus2D.Z = 0;
	Loc2D = Location;
	Loc2D.Z = 0;
	Dest2D = Destination;
	Dest2D.Z = 0;
	lookDir = Normal(Focus2D - Loc2D);
	moveDir = Normal(Dest2D - Loc2D);
	strafeMag = lookDir dot moveDir;
		
	if (Weapon.bPointing || (CarriedDecoration != None)) {
		if (KlingonWeapons(Weapon).WeaponType==1 || KlingonWeapons(Weapon).WeaponType==2) {
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleSlash, 1.5, 0.1);
			else
				LoopAnim (B_WalkSlash, 1.5, 0.1);
		}
		else {
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (WalkShoot, 1.5, 0.1);
		}
	}
	else {
		if (strafeMag < -0.8)
			LoopAnim (BackPeddle, 1.5, 0.1);
		else
			LoopAnim (Walk, 1.5, 0.1);
	}
}


function PlayRunning()
{
	local float strafeMag;
	local vector Focus2D, Loc2D, Dest2D;
	local vector lookDir, moveDir, Y;
	
	//Log("Play Running");
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
		if ( (vector(Rotation) Dot Acceleration) > 0 )
			PlaySwimming();
		else
			PlayWaiting();
		return;
	}

	BaseEyeHeight = Default.BaseEyeHeight;
	BaseEyeHeight = Default.BaseEyeHeight;
	Focus2D = Focus;
	Focus2D.Z = 0;
	Loc2D = Location;
	Loc2D.Z = 0;
	Dest2D = Destination;
	Dest2D.Z = 0;
	lookDir = Normal(Focus2D - Loc2D);
	moveDir = Normal(Dest2D - Loc2D);
	strafeMag = lookDir dot moveDir;
		
	if ( Weapon.bPointing ) 
	{
		switch (KlingonWeapons(Weapon).WeaponType) {
		case 0:		// Assault Disrupter
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (AD_RunShoot, 1.5, 0.1);
			break;
		case 1:		// Batleth
		case 2:		// Daktagh
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleSlash, 1.5, 0.1);
			else
				LoopAnim (B_RunSlash, 1.5, 0.1);
			break;
		case 3:		// Disrupter Pistol
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (RunShoot, 1.5, 0.1);
			break;
		case 4:		// Disrupter Rifle
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (R_RunShoot, 1.5, 0.1);
			break;
		case 5:		// Grenade Launcher
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (GL_RunShoot, 1.5, 0.1);
			break;
		case 6:		// Particle Cannon
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (BFG_RunShoot, 1.5, 0.1);
			break;
		case 7:		// Rocket Launcher
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (RL_RunShoot, 1.5, 0.1);
			break;
		case 8:		// SithHar
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (S_RunShoot, 1.5, 0.1);
			break;
		case 9:		// SpinClaw
			if (strafeMag < -0.8)
				LoopAnim (BackPeddleShoot, 1.5, 0.1);
			else
				LoopAnim (SC_RunShoot, 1.5, 0.1);
			break;
		default:
			if (strafeMag < -0.8)
				LoopAnim (BackPeddle, 1.5, 0.1);
			else
				LoopAnim (Run, 1.5, 0.1);
			break;
		}
	}
	else
	{
		if (strafeMag < -0.8)
			LoopAnim (BackPeddleShoot, 1.5, 0.1);
		else
			LoopAnim(Run, 1.5, 0.1);
	}
}

function PlayRising()
{
	BaseEyeHeight = 0.4 * Default.BaseEyeHeight;
	TweenAnim(Scooch, 0.7);
}

function PlayFeignDeath()
{
	local float decision;

	decision = FRand();
	BaseEyeHeight = 0;
	if ( decision < 0.33 )
		TweenAnim(DeadRollBack, 0.5);
	else if ( decision < 0.67 )
		TweenAnim(DeadBlownBack, 0.5);
	else 
		TweenAnim(DeadFallBack, 0.5);
}

function PlayDying(name DamageType, vector HitLoc)
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
	
	BaseEyeHeight = Default.BaseEyeHeight;
	PlaySound(Die,SLOT_Misc);
			
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

function PlayGutHit(float tweentime)
{
	if ( (AnimSequence == HitGut)  )
	{
		if (FRand() < 0.5)
			TweenAnim(HitLeft, tweentime);
		else
			TweenAnim(HitRight, tweentime);
	}
	else
		TweenAnim(HitGut, tweentime);

}

function PlayHeadHit(float tweentime)
{
	if ( (AnimSequence == HitHead) )
		TweenAnim(HitHead, tweentime);
	else if ( FRand() < 0.6 )
		TweenAnim(HitHead, tweentime);
	else
		TweenAnim(HitGut, tweentime);
}

function PlayLeftHit(float tweentime)
{
	if ( (AnimSequence == HitLeft) )
		TweenAnim(HitLeft, tweentime);
	else if ( FRand() < 0.6 )
		TweenAnim(HitLeft, tweentime);
	else 
		TweenAnim(HitGut, tweentime);
}

function PlayRightHit(float tweentime)
{
	if ( (AnimSequence == HitRight) )
		TweenAnim(HitRight, tweentime);
	else if ( FRand() < 0.6 )
		TweenAnim(HitRight, tweentime);
	else
		TweenAnim(HitGut, tweentime);
}	
	
function PlayLanded(float impactVel)
{	
	impactVel = impactVel/JumpZ;
	impactVel = 0.1 * impactVel * impactVel;
	BaseEyeHeight = Default.BaseEyeHeight;

	if ( impactVel > 0.17 )
		PlaySound(LandGrunt, SLOT_Talk, FMin(4, 5 * impactVel),false,1600,FRand()*0.4+0.8);
	if ( !FootRegion.Zone.bWaterZone && (impactVel > 0.01) )
		PlaySound(Land, SLOT_Interact, FClamp(4 * impactVel,0.2,4.5), false,1600, 1.0);

	if ( (impactVel > 0.06) || (GetAnimGroup(AnimSequence) == 'Jumping') )
	{
		TweenAnim(Landed, 0.12);
	}
	else if ( !IsAnimating() )
	{
		if ( GetAnimGroup(AnimSequence) == 'TakeHit' )
			AnimEnd();
		else 
		{
			TweenAnim(Landed, 0.12);
		}
	}
}
	
function PlayInAir()
{
	BaseEyeHeight =  0.7 * Default.BaseEyeHeight;
	if ( (Weapon == None) || (Weapon.Mass < 20) )
		TweenAnim(Shoot, 0.8);
	else
		TweenAnim(Shoot, 0.8); 
}

function PlayDuck()
{
	//Log("Play Duck");
	BaseEyeHeight = 0;
//	TweenAnim(Scooch, 0.25);
	LoopAnim(Scooch, 1.0, 0.1);
}

function PlayCrawling()
{
	//log("Play Crawling");
	BaseEyeHeight = 0;
	LoopAnim(Scooch, 1.0, 0.1);
}

function TweenToWaiting(float tweentime)
{
	//Log("Tween To Waiting");
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		TweenAnim(Swim, tweentime);
	}
	else
	{
		BaseEyeHeight = Default.BaseEyeHeight;
		if ( Enemy != None )
			ViewRotation = Rotator(Enemy.Location - Location);
		else
			ViewRotation.Pitch = 0;
		ViewRotation.Pitch = ViewRotation.Pitch & 65535;
		If ( (ViewRotation.Pitch > RotationRate.Pitch) 
			&& (ViewRotation.Pitch < 65536 - RotationRate.Pitch) )
		{
			If (ViewRotation.Pitch < 32768) {
				TweenAnim(Wait1, 0.3);
			}
		}
		else if ((Weapon != none) && (Weapon.bPointing))
			TweenAnim(Shoot, tweentime);
		else
			TweenAnim(Wait1, tweentime);
	}
	
}

function TweenToFighter(float tweentime)
{
	TweenToWaiting(tweentime);
}
	
function PlayChallenge()
{
	local float decision;

	decision = FRand();
	if ( decision < 0.6 )
		TweenToWaiting(0.1);
	else
		PlayAnim(Taunt1, 0.7, 0.1);
}	
	
function PlayWaiting()
{
	local name newAnim;
	
	//Log("Play Waiting");
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		if ( (Weapon != None) && Weapon.bPointing )
			LoopAnim(TreadWaterShoot, 1.5, 0.1);
		else
			LoopAnim(TreadWater, 1.5, 0.1);
	}
	else {	
		BaseEyeHeight = Default.BaseEyeHeight;
		if (Weapon.bPointing) {
			switch (KlingonWeapons(Weapon).WeaponType) {
			case 0:		// Assault Disrupter
				LoopAnim (AD_Shoot, 1.0, 0.1);
				//Log("Play Waiting");
				break;
			case 1:		// Batleth
				LoopAnim (B_Slash, 1.0, 0.1);
				break;
			case 2:		// Daktagh
				LoopAnim (D_Slash, 1.0, 0.1);
				break;	
			case 3:		// Disrupter Pistol
				LoopAnim (Shoot, 1.0, 0.1);
				break;
			case 4:		// Disrupter Rifle
				LoopAnim (R_Shoot, 1.0, 0.1);
				break;
			case 5:		// Grenade Launcher
				LoopAnim (GL_Shoot, 1.0, 0.1);
				break;
			case 6:		// Particle Cannon
				LoopAnim (BFG_Shoot, 1.0, 0.1);
				break;
			case 7:		// Rocket Launcher
				LoopAnim (RL_Shoot, 1.0, 0.1);
				break;
			case 8:		// SithHar
				LoopAnim (S_Shoot, 1.0, 0.1);
				break;
			case 9:		// SpinClaw
				LoopAnim (SC_Shoot, 1.0, 0.1);
				break;
			default:
				LoopAnim (Shoot, 1.0, 0.1);
				break;
			}
		}
		else {
			LoopAnim (Wait1, 1.0, 0.05);
		}
	}
}	
	
function PlayFiring()
{
	//Log("Play Firing");
	// switch animation sequence mid-stream if needed
	if (Region.Zone.bWaterZone || (Region.Zone.ZoneGravity.Z > -200 && !IsInState('MagBootWalk')))
	{
		BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
		AnimSequence = TreadWaterShoot;
		return;
	}
	
	switch (KlingonWeapons(Weapon).WeaponType) {
	case 0:		// Assault Disrupter
		if (AnimSequence==Run)
			AnimSequence = AD_RunShoot;
		else if (AnimSequence==Walk)
			AnimSequence = WalkShoot;
		else
			LoopAnim(AD_RunShoot, 1.5, 0.1);
//			AnimSequence = AD_Shoot;
		return;
	case 1:		// Batleth
		if (AnimSequence==Run)
			AnimSequence = B_RunSlash;
		else if (AnimSequence==Walk)
			AnimSequence = B_WalkSlash;
		else
			LoopAnim(B_RunSlash, 1.5, 0.1);
//			AnimSequence = B_Slash;
		return;
	case 2:		// Daktagh
		if (AnimSequence==Run)
			AnimSequence = B_RunSlash;
		else if (AnimSequence==Walk)
			AnimSequence = B_WalkSlash;
		else
			LoopAnim(B_RunSlash, 1.5, 0.1);
//			AnimSequence = D_Slash;
		return;	
	case 3:		// Disrupter Pistol
		if (AnimSequence==Run)
			AnimSequence = RunShoot;
		else if (AnimSequence==Walk)
			AnimSequence = WalkShoot;
		else
			LoopAnim(RunShoot, 1.5, 0.1);
//			AnimSequence = Shoot;
		return;
	case 4:		// Disrupter Rifle
		if (AnimSequence==Run)
			AnimSequence = R_RunShoot;
		else if (AnimSequence==Walk)
			AnimSequence = WalkShoot;
		else
			LoopAnim(R_RunShoot, 1.5, 0.1);
//			AnimSequence = R_Shoot;
		return;
	case 5:		// Grenade Launcher
		if (AnimSequence==Run)
			AnimSequence = GL_RunShoot;
		else if (AnimSequence==Walk)
			AnimSequence = WalkShoot;
		else
			LoopAnim(GL_RunShoot, 1.5, 0.1);
//			AnimSequence = GL_Shoot;
		return;
	case 6:		// Particle Cannon
		if (AnimSequence==Run)
			AnimSequence = BFG_RunShoot;
		else if (AnimSequence==Walk)
			AnimSequence = WalkShoot;
		else
			LoopAnim(BFG_RunShoot, 1.5, 0.1);
//			AnimSequence = BFG_Shoot;
		return;
	case 7:		// Rocket Launcher
		if (AnimSequence==Run)
			AnimSequence = RL_RunShoot;
		else if (AnimSequence==Walk)
			AnimSequence = WalkShoot;
		else
			LoopAnim(RL_RunShoot, 1.5, 0.1);
//			AnimSequence = RL_Shoot;
		return;
	case 8:		// SithHar
		if (AnimSequence==Run)
			AnimSequence = S_RunShoot;
		else if (AnimSequence==Walk)
			AnimSequence = WalkShoot;
		else
			LoopAnim(S_RunShoot, 1.5, 0.1);
//			AnimSequence = S_Shoot;
		return;
	case 9:		// SpinClaw
		if (AnimSequence==Run)
			AnimSequence = SC_RunShoot;
		else if (AnimSequence==Walk)
			AnimSequence = WalkShoot;
		else
			LoopAnim(SC_RunShoot, 1.5, 0.1);
//			AnimSequence = SC_Shoot;
		return;
	}
	LoopAnim(Shoot, 1.0, 0.1);
}

function PlayWeaponSwitch(Weapon NewWeapon)
{
/*	if ( (Weapon == None) || (Weapon.Mass < 20) )
	{
		if ( (NewWeapon != None) && (NewWeapon.Mass > 20) )
		{
			if ( (AnimSequence == Run) || (AnimSequence == RunShoot) )
				AnimSequence = Run;
			else if ( (AnimSequence == Walk) || (AnimSequence == WalkShoot) )
				AnimSequence = Walk;	
		 	else if ( AnimSequence == Jump )
		 		AnimSequence = Jump;
			else if ( AnimSequence == Scooch)
				AnimSequence = Scooch;
		 	else if ( AnimSequence == Shoot )
		 		AnimSequence = Shoot;
//			else if ( AnimSequence == 'AimDnSm' )
//				AnimSequence = 'AimDnLg';
//			else if ( AnimSequence == 'AimUpSm' )
//				AnimSequence = 'AimUpLg';
		 }	
	}
	else if ( (NewWeapon == None) || (NewWeapon.Mass < 20) )
	{		
		if ( (AnimSequence == Run) || (AnimSequence == RunShoot) )
			AnimSequence = Run;
		else if ( (AnimSequence == Walk) || (AnimSequence == WalkShoot) )
			AnimSequence = Walk;
	 	else if ( AnimSequence == Jump)
	 		AnimSequence = Jump;
		else if ( AnimSequence == Scooch)
			AnimSequence = Scooch;
	 	else if (AnimSequence == Shoot)
	 		AnimSequence = Shoot;
//		else if ( AnimSequence == 'AimDnLg' )
//			AnimSequence = 'AimDnSm';
//		else if ( AnimSequence == 'AimUpLg' )
//			AnimSequence = 'AimUpSm';
	}
*/	
}

function PlaySwimming()
{
	BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
	LoopAnim(Swim, 1.0, 0.1);
}

function TweenToSwimming(float tweentime)
{
	BaseEyeHeight = 0.7 * Default.BaseEyeHeight;
	TweenAnim(Swim,tweentime);
}

//-----------------------------------------------------------------------------
// Sound functions


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
     SplatClass=Class'Klingons.PinkBlood'
     AttitudeToPlayer=ATTITUDE_Friendly
     Skill=5.000000
     AnimSequence=Wait
     CollisionHeight=46.000000
     Buoyancy=99.000000
}
