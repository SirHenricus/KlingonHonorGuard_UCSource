//=============================================================================
// AndorianThress.
//=============================================================================
// By Mark E. Bradshaw

class AndorianThress expands Humanoids;

#call q:\klingons\art\pawns\Thress\final\Thress.mac
#exec MESH ORIGIN MESH=pawnthress X=0 Y=0 Z=-30 YAW=64

#exec MESH NOTIFY MESH=pawnthress SEQ=ShootFL           TIME=0.16 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=ShootFL           TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=ShootFL           TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkShootFL       TIME=0.05 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkShootFL       TIME=0.25 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkShootFL       TIME=0.50 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkShootFL       TIME=0.75 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=RunShootFL        TIME=0.16 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=RunShootFL        TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=RunShootFL        TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightShootFL TIME=0.16 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightShootFL TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightShootFL TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftShootFL  TIME=0.16 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftShootFL  TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftShootFL  TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnthress SEQ=KneelShootFL      TIME=0.05 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=pawnthress SEQ=KneelShootFL      TIME=0.34 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=pawnthress SEQ=KneelShootFL      TIME=0.67 FUNCTION=SpawnKneelShot

#exec MESH NOTIFY MESH=pawnthress SEQ=StunShootFL       TIME=0.43 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=pawnthress SEQ=StunShootFL       TIME=0.60 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=pawnthress SEQ=StunShootFL       TIME=0.77 FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=pawnthress SEQ=WaitFL            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkFL            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkSW            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnthress SEQ=WaitIdleSW        TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnthress SEQ=WaitSwordSpinSW   TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnthress SEQ=WaitSwordTossSW   TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=pawnthress SEQ=StabSW      TIME=0.4 FUNCTION=StabDamageTarget
#exec MESH NOTIFY MESH=pawnthress SEQ=StabSW      TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=pawnthress SEQ=SlashSW     TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=pawnthress SEQ=SlashSW     TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=pawnthress SEQ=BackSlashSW TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=pawnthress SEQ=BackSlashSW TIME=0.1 FUNCTION=HumanGrunt


#exec MESH NOTIFY MESH=pawnthress SEQ=BackPeddleFL   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnthress SEQ=BackPeddleFL   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnthress SEQ=BackPeddleSW   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnthress SEQ=BackPeddleSW   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftSW   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftSW   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightSW   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightSW   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=RunSW   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=RunSW   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftShootFL   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftShootFL   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftFL   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafLeftFL   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightShootFL   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightShootFL   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightFL   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=StrafRightFL   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkSW   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkSW   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkFL   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnthress SEQ=WalkFL   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnthress SEQ=RunFL   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=RunFL   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=RunShootFL   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnthress SEQ=RunShootFL   			TIME=0.66 FUNCTION=FootStepRunSound

#exec MESH NOTIFY MESH=pawnthress SEQ=ReloadFL TIME=0.37 FUNCTION=ReloadSound

//XXX
//FootStep sounds?
//Swimming?
//Ducking? Ducking To Shoot?
//Speaking?
//Projectile location?

//////////////////Variables///////////////////////
// Melee damage.
var (Pawn) int CutSceneDamage;
var CutSceneCamera CSCamera;
var bool CutScenePlayed;
var pawn instigator;
var bool cutsceneplaying;

///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'DuckSW';
	StrafLeftMelee1 = 'StrafLeftSW';
	StrafRightMelee1 = 'StrafRightSW';
	RollLeftMelee1 = 'RollLeftSW';
	RollRightMelee1 = 'RollRightSW';
	WaitIdleMelee1 = 'WaitIdleSW';
	WaitIdleMelee2 = 'LookLeftSW';
	WaitIdleMelee3 = 'WaitSwordTossSW';
	WaitIdleMelee4 = 'LookRightSW';
	StunnedMelee1 = 'StunSW';
	StunnedSquirmMelee1 = 'StunSquirmSW';
	StunnedGetupMelee1 = 'StunGetupSW';
	StabMelee1 = 'StabSW';
	SlashMelee1 = 'SlashSW';
	BackSlashMelee1 = 'BackSlashSW';
	HitGutMelee1 = 'HitGutSW';
	HitRightMelee1 = 'HitRightSW';
	HitLeftMelee1 = 'HitLeftSW';
	HitHeadMelee1 = 'HitHeadSW';
	RunMelee1 = 'RunSW';
	BackPeddleMelee1 = 'BackPeddleSW';
	ThreatenMelee1 = 'WaitSwordSpinSW' ;
	ThreatenMelee2 = 'FlyingbackFistSW';
	ThreatenMelee3 = 'WaitSwordSpinSW';
	CommandMelee1 = 'WaitSwordSpinSW';
	CommandMelee2 = 'FlyingBackFistSW';
	WalkMelee1 = 'WalkSW';
	InAirMelee1 = 'JumpSW';
	LandMelee1 = 'LandSW';	


	// Ranged Animations
	DuckRanged1 = 'DuckFL';
	StrafLeftRanged1 = 'StrafLeftFL';
	StrafLeftShootRanged1 = 'StrafLeftShootFL';
	StrafRightRanged1 = 'StrafRightFL';
	StrafRightShootRanged1 = 'StrafRightShootFL';
	RollLeftRanged1 = 'RollLeftFL';
	RollRightRanged1 = 'RollRightFL';
	WaitIdleRanged1 = 'WaitFL';
	WaitIdleRanged2 = 'LookRightFL';
	WaitIdleRanged3 = 'LookRightFL';
	WaitIdleRanged4 = 'CheckFL';
	StunnedRanged1 = 'StunFL';
	StunnedSquirmRanged1 = 'StunSquirmFL';
	StunnedShootRanged1 = 'StunShootFL';
	StunnedGetupRanged1 = 'StunGetupFL';
	CheckRanged1 = 'CheckFL';
	ReloadRanged1 = 'ReloadFL';
	KneelShootRanged1 = 'KneelShootFL';
	ShootRanged1 = 'ShootFL';
	HitGutRanged1 = 'HitGutFL';
	HitRightRanged1 = 'HitRightFL';
	HitLeftRanged1 = 'HitLeftFL';
	HitHeadRanged1 = 'HitHeadFL';
	RunRanged1 = 'RunFL';
	BackPeddleRanged1 = 'BackPeddleFL';
	RunShootRanged1 = 'RunShootFL';
	SwimRanged1 = 'RunFL';
	WalkRanged1 = 'WalkFL';
	InAirRanged1 = 'JumpFL';
	LandRanged1 = 'LandFL';
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBlownRight';
	DeadBlownLeft1 = 'DeadBlownLeft';
	DeadFallFace1 = 'DeadFallFace';
	DeadFallBack1 = 'DeadFallBack';
	DeadFallRight1 = 'DeadFallRight';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'WaitSwordSpinSW';
	VictoryDance2 = 'FlyingbackFistSW';



	Super.PreBeginPlay();
}


function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	local int actualdamage;
	local float dam,ad;

	if (!CutScenePlaying)
	{
		if (!CutScenePlayed)
		{
			actualDamage = Level.Game.ReduceDamage(Damage, DamageType, self, instigatedBy);
		
			if (ActualDamage > Health - CutSceneDamage)
			{
				dam = damage;
				ad = ActualDamage;
				Damage = (Health - CutSceneDamage) * (dam / Ad) + 10;
			}
		}
				
		Super.TakeDamage(Damage, instigatedBy, hitLocation, momentum, damageType);
		if (Health < 0)
		{
			if (SpecialDeath != 3)
				SpecialDeath = 0;
		}
		
		if (Velocity.Z > 0)
			Velocity.Z = 0;
		if (Health < CutSceneDamage)
		{
			if (!CutScenePlayed)
			{
				if (Health < 0)
					Health = CutSceneDamage;
			
				Instigator = InstigatedBy;
				CutScenePlaying = true;
				PlayCutScene();
			}
		}
	}
}


function PlayCutScene()
{
	if (KlingonPlayer(Instigator) != none)
	{
//		SetRotation(rotator(KlingonPlayer(Instigator).location - location));
		DesiredRotation = rotator(KlingonPlayer(Instigator).location - location);
		KlingonPlayer(Instigator).SwitchViewToImmediate(2);
		CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).CamOwner = self;
		CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).SetPlayerViews(self);
		
		KlingonHud(KlingonPlayer(Instigator).MyHud).AllowMenu(false);
		KlingonPlayer(Instigator).ClientSetMusic(None,0,255,MTRAN_Instant);
		KlingonPlayer(Instigator).LoopAnim('Wait', 1.0, 0.05);

//		KlingonPlayer(Instigator).PlayWaiting();
//		KlingonPlayer(Instigator).GotoState('Waiting');
	}
	PawnsWait(true);
	AttitudeToPlayer = ATTITUDE_Ignore;
	CutScenePlayed = true;
	GotoState('CutSceneState');
}


/* PreSetMovement()
*/
function PreSetMovement()
{
	MaxDesiredSpeed = 1.0; /*XXXUnreal 0.7 + 0.1 * skill */
	bCanJump = true;
	bCanWalk = true;
	bCanSwim = false;
	bCanFly = false;
	MinHitWall = -0.6;
	bCanOpenDoors = true;
	bCanDoSpecial = true;
	bCanDuck = true;
}


function bool IsMeleeAnim()
{
	if (!bHasRangedAttack)
	{
		return true;
	}
	else
		return (right(AnimSequence, 2) == "SW"); 
}

function PlayWaiting()
{
	local float decision;

	if (Instigator != none)
	{
		if (vsize(vector(rotation) + vector(Instigator.rotation)) > 1)
		{
			AttitudeToPlayer = ATTITUDE_Hate;
			GotoState('Attacking');
			return;
		}
	}
		
		
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	
		
	if (GetAnimGroup(AnimSequence) == 'Ducking')
	{
		TweenAnim(AnimSequence, 1.0);
		return;
	}	
	decision = FRand();
	if (Frand() < 0.2)
		SpawnBreath();
	if (IsMeleeAnim())
	{
		
		if (decision < 0.2)
			PlayAnim(WaitIdleMelee2, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.4)
			PlayAnim(WaitIdleMelee3, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.6) 	
			PlayAnim(WaitIdleMelee4, 0.6 + 0.3* FRand(),0.8);
		else
			LoopAnim(WaitIdleMelee1, 0.6 + 0.3* FRand(),0.8);
	}
	else
	{
		if (decision < 0.2)
			PlayAnim(WaitIdleRanged2, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.4)
			PlayAnim(WaitIdleRanged3, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.6)
			PlayAnim(WaitIdleRanged4, 0.6 + 0.3* FRand(),0.8);
		else
			LoopAnim(WaitIdleRanged1, 0.6 + 0.3* FRand(),0.8);
	}
}



state CutSceneState
{
ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall,
		takeDamage,Hitwall, WarnTarget,landed,ChooseTeamAttackFor,ChooseLeaderAttack,
		WhatToDoNext,SetFall;
		
	function BeginState()
	{
	//	nextstate = '';
	}
	function EndState()
	{
	}
	
Begin:
	setPhysics(PHYS_Falling);
	Enable('AnimEnd');
	AttitudeToPlayer = ATTITUDE_Ignore;
	
	Velocity = vect(0,0,0);
	Acceleration = vect(0,0,0);
	setPhysics(PHYS_Falling);
	
//	PlayAnim(WaitIdleRanged1,1.0,0.3);
//	FinishAnim();
	Sleep(0.2);
	PlaySound(sound 'ThressCutSc2', SLOT_Talk, /*volume*/,,2000,/*pitch*/);
	
	PlayAnim('CutScene',1.06,0.1);
	PawnsWait(true);
	
	FinishAnim();
	
	Health = CutSceneDamage-1;
	CutSceneDamage = -2000;
	AttitudeToPlayer = ATTITUDE_Ignore;

	if (KlingonPlayer(Instigator) != none)
	{	
		CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).ResetPlayerViews();	
		KlingonHud(KlingonPlayer(Instigator).MyHud).AllowMenu(true);				
		KlingonPlayer(Instigator).ClientSetMusic(None,0,5,MTRAN_Fade);
	}

//	PawnsWait(false);
	CutScenePlaying = false;
	GotoState('Waiting');

}

state TakeHit 
{
ignores seeplayer, hearnoise, bump, hitwall;

	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
	{
		Global.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType);
	}

	function Landed(vector HitNormal)
	{
		if (Velocity.Z < -1.4 * JumpZ)
			MakeNoise(-0.5 * Velocity.Z/(FMax(JumpZ, 150.0)));
		bJustLanded = true;
	}

	function Timer()
	{
		bReadyToAttack = true;
		if ( SpeechTime > 0 )
		{
			SpeechTime = -1.0;
			bIsSpeaking = false;
			if ( TeamLeader != None )
				TeamLeader.bTeamSpeaking = false;
		}
	}

	function PlayHitAnim(vector HitLocation, float Damage)
	{

		if ( LastPainTime - Level.TimeSeconds > 0.1 )
		{
			if (Damage > 1) // spawn some blood
			{
//xxx				if (   ( damageType != 'Drowned') 
//xxx						&& 	(damageType != 'Burned') 
//xxx						&& 	(damageType != 'Corroded'))
//xxx					SpawnBlood(damage,Hitlocation);
			}		
//xxx			PlayTakeHitSound(Damage,damageType);
			PlayTakeHit(0.05, hitLocation, Damage);
			BeginState();
			GotoState('TakeHit', 'Begin');
		} 
	}	

	function BeginState()
	{
		LogDebug("Entering TakeHit State in KP",1);

		LastPainTime = Level.TimeSeconds;
		LastPainAnim = AnimSequence;
	}
	function EndState()
	{
		LogDebug("Leaving TakeHit State in KP",2);
	}
		
Begin:
	if (CutScenePlaying)
		PlayCutScene();
	else
	{
	
		if (AnimSequence == 'blinded')
		{
		
			GotoState('Blinded');
		}
		if (GetAnimGroup(AnimSequence) == 'Stun')
			GotoState('Stunned');
			
		// Acceleration = Normal(Acceleration);
		FinishAnim();
		if ( skill < 2 )
			Sleep(0.05);
			
		if ( (Physics == PHYS_Falling) && !Region.Zone.bWaterZone )
		{
			Acceleration = vect(0,0,0);
			NextAnim = '';
			
			GotoState('FallingState', 'Ducking');
		}
		else if (NextState != '')
		{
			GotoState(NextState, NextLabel);
		}
		else
		{
			GotoState('Attacking');
		}
	}
}

defaultproperties
{
     CutSceneDamage=250
     OverHeadDamage=10
     StabDamage=7
     SlashDamage=10
     BackSlashDamage=10
     hitsound3=Sound'KlingonSFX01.creature.ThressGrunt08'
     hitsound4=Sound'KlingonSFX01.creature.ThressGrunt06'
     stab=Sound'KlingonSFX01.creature.AndCptSwing'
     slash=Sound'KlingonSFX01.creature.AndCptSwing'
     backslash=Sound'KlingonSFX01.Weapons.Batswing'
     fleshslice=Sound'KlingonSFX01.Weapons.Batslash2'
     Threaten2=Sound'KlingonSFX01.creature.ThressTaunt3'
     Threaten3=Sound'KlingonSFX01.creature.ThressTaunt1'
     ReloadSound1=Sound'KlingonSFX01.Weapons.FlamThroReload'
     Grunt1=Sound'KlingonSFX01.creature.AndoSlash'
     Grunt2=Sound'KlingonSFX01.creature.AndoStab'
     Grunt3=Sound'KlingonSFX01.creature.AndoSlash'
     Grunt4=Sound'KlingonSFX01.creature.AndoStab'
     CarcassType=Class'Klingons.KlingonCarcass'
     TimeBetweenAttacks=2.000000
     Aggressiveness=0.350000
     RefireRate=0.400000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.DisruptorRed'
     ProjectileSpeed=400.000000
     Acquire=Sound'KlingonSFX01.creature.ThressTaunt1'
     Threaten=Sound'KlingonSFX01.creature.ThressTaunt2'
     bCanUseCover=True
     SplatClass=Class'Klingons.GreenBlood'
     ShotsBeforeReload=8
     DodgeAmount=0.300000
     PartBlood=Class'Klingons.GreenParticles'
     RetreatDamage=5
     MySide=Andorian
     MuzzleFlash=Class'Klingons.DisruptorFlash2'
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.Wepon4'
     bCanStrafe=True
     MeleeRange=50.000000
     GroundSpeed=425.000000
     AccelRate=512.000000
     HearingThreshold=1.000000
     Health=500
     Intelligence=BRAINS_HUMAN
     Skill=3.000000
     HitSound1=Sound'KlingonSFX01.creature.ThressGrunt03'
     HitSound2=Sound'KlingonSFX01.creature.ThressGrunt02'
     Die=Sound'KlingonSFX01.creature.ThressGrunt11'
     CombatStyle=0.400000
     Physics=PHYS_Walking
     AnimSequence=WaitFL
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnThress'
     DrawScale=1.600000
     CollisionHeight=46.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=120.000000
}
