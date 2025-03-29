//=============================================================================
// Korek.
//=============================================================================
class Korek expands Humanoids;

#call q:\klingons\art\pawns\Korek\final\Korek.mac
#exec MESH ORIGIN MESH=PawnKorek X=0 Y=0 Z=-45 YAW=64

#exec MESH NOTIFY MESH=PawnKorek SEQ=ShootRK           TIME=0.2  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnKorek SEQ=RunShootRK        TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnKorek SEQ=StrafRightShootRK TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnKorek SEQ=StrafLeftShootRK  TIME=0.4  FUNCTION=SpawnShot

#exec MESH NOTIFY MESH=PawnKorek SEQ=WalkRK            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnKorek SEQ=WaitRK            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnKorek SEQ=VictoryBA         TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnKorek SEQ=WalkBA            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnKorek SEQ=WaitBA            TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnKorek SEQ=OverHeadHitBA     TIME=0.5 FUNCTION=OverHeadDamageTarget
#exec MESH NOTIFY MESH=PawnKorek SEQ=SlashBA           TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnKorek SEQ=BackSlashBA       TIME=0.5 FUNCTION=BackSlashDamageTarget

#exec MESH NOTIFY MESH=PawnKorek SEQ=Laugh       TIME=0.1 FUNCTION=Laugh


//////////////////Variables///////////////////////
// Melee damage.
/*var() byte
	OverHeadDamage,
	SlashDamage,		
	BackSlashDamage;		

var(Sounds) sound hitsound3;
var(Sounds) sound hitsound4;
var(Sounds) sound overhead;
var(Sounds) sound slash;
var(Sounds) sound backslash;
var(Sounds) sound fleshslice;
var(Sounds) sound Die2;

var(Sounds) sound Command1;
var(Sounds) sound Command2;
var(Sounds) sound Command3;
var(Sounds) sound Acquire2;
var(Sounds) sound Acquire3;
var(Sounds) sound Threaten2;
var(Sounds) sound Threaten3;
var(Sounds) sound Roam2;

var(Sounds) sound Talk1;
var(Sounds) sound Talk2;
var(Sounds) sound Talk3;
var(Sounds) sound Talk4;
*/
var Pawn LastEnemy;
var (Pawn) int CutSceneDamage;
var CutSceneCamera CSCamera;
var bool CutScenePlayed;
var pawn instigator;

///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'DuckRK';
	StrafLeftMelee1 = 'StrafLeftRK';
	StrafRightMelee1 = 'StrafRightRK';
	RollLeftMelee1 = 'StrafLeftRK';
	RollRightMelee1 = 'StrafRightRK';
	WaitIdleMelee1 = 'WaitRK';
	WaitIdleMelee2 = 'WaitRK';
	WaitIdleMelee3 = 'WaitRK';
	WaitIdleMelee4 = 'WaitRK';
	StunnedMelee1 = '';
	StunnedSquirmMelee1 = '';
	StunnedGetupMelee1 = '';
	StabMelee1 = 'OverheadHitBA';
	SlashMelee1 = 'SlashBA';
	BackSlashMelee1 = 'BackSlashBA';
	HitGutMelee1 = 'HitGutRK';
	HitRightMelee1 = 'HitRightRK';
	HitLeftMelee1 = 'HitLeftRK';
	HitHeadMelee1 = 'HitHeadRK';
	RunMelee1 = 'RunRK';
	BackPeddleMelee1 = 'RunRK';
	
	ThreatenMelee1 = 'Laugh' ;
	ThreatenMelee2 = 'Laugh';
	ThreatenMelee3 = 'Laugh';
	CommandMelee1 = 'WaitRK';
	CommandMelee2 = 'WaitRK';
	WalkMelee1 = 'WalkRK';
	InAirMelee1 = 'JumpRK';
	LandMelee1 = 'LandRK';	
	

	// Ranged Animations
	DuckRanged1 = 'DuckRK';
	StrafLeftRanged1 = 'StrafLeftRK';
	StrafLeftShootRanged1 = 'StrafLeftShootRK';
	StrafRightRanged1 = 'StrafRightRK';
	StrafRightShootRanged1 = 'StrafRightShootRK';
	RollLeftRanged1 = 'StrafLeftRK';
	RollRightRanged1 = 'StrafRightRK';
	WaitIdleRanged1 = 'WaitRK';
	WaitIdleRanged2 = 'WaitRK';
	WaitIdleRanged3 = 'WaitRK';
	WaitIdleRanged4 = 'WaitRK';
	StunnedRanged1 = '';
	StunnedSquirmRanged1 = '';
	StunnedShootRanged1 = '';
	StunnedGetupRanged1 = '';
	CheckRanged1 = 'Laugh';
	ReloadRanged1 = 'Laugh';
	KneelShootRanged1 = 'ShootRK';
	ShootRanged1 = 'ShootRK';
	HitGutRanged1 = 'HitGutRK';
	HitRightRanged1 = 'HitRightRK';
	HitLeftRanged1 = 'HitLeftRK';
	HitHeadRanged1 = 'HitHeadRK';
	RunRanged1 = 'RunRK';
	BackPeddleRanged1 = 'RunRK';
	RunShootRanged1 = 'RunShootRK';
	SwimRanged1 = 'RunRK';
	WalkRanged1 = 'WalkRK';
	InAirRanged1 = 'JumpRK';
	LandRanged1 = 'LandRK';	
	
	
	// Deaths & Stuff
	DeadBackToFace1 = 'Death';
	DeadBlownRight1 = 'Death';
	DeadBlownLeft1 = 'Death';
	DeadFallFace1 = 'Death';
	DeadFallBack1 = 'Death';
	DeadFallRight1 = 'Death';
	DeadBackRoll1 = 'Death';
	DeadBlownBack1 = 'Death';
	
	VictoryDance1 = 'Laugh';
	VictoryDance2 = 'Laugh';



	Super.PreBeginPlay();
}

function ZoneChange(ZoneInfo newZone)
{
	bCanSwim = newZone.bWaterZone; //only when it must
		
	if ( newZone.bWaterZone )
		CombatStyle = 1.0; //always charges when in the water
	else if (Physics == PHYS_Swimming)
		CombatStyle = Default.CombatStyle;

	Super.ZoneChange(newZone);
}


function Laugh()
{
	PlaySound(sound 'KorekLaugh', SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
/*	if (damageType == 'exploded')
	{
		PlaySound(sound 'Bp03rmra',SLOT_Interact,1.0,,VoiceRadius+300);	


		VolumeBrightness = 220;
		LightRadius = 220;
		LightBrightness = 204;
		LightHue = 153;
		return;
	}
	else
	{
		VolumeBrightness = 0;
		LightRadius = 0;
		LightBrightness = 0;
		LightHue = 0;
	}
*/	
	Super.TakeDamage(Damage,instigatedBy, hitLocation, vect(0,0,0), damageType);
	if (Health < 0)
	{
		SpecialDeath = 0;
	}	
	if (Health < CutSceneDamage)
	{
		if (!CutScenePlayed)
		{
			PawnsWait(true);
			AttitudeToPlayer = ATTITUDE_Ignore;
//			CSCamera = spawn(class 'CutSceneCamera',self);
			CutScenePlayed = true;
			Instigator = InstigatedBy;
			if (KlingonPlayer(Instigator) != none)
			{
				KlingonPlayer(Instigator).SwitchViewToImmediate(2);
				CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).CamOwner = self;
				CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).SetPlayerViews(self);
				
												
				KlingonHud(KlingonPlayer(Instigator).MyHud).AllowMenu(false);
				KlingonPlayer(Instigator).ClientSetMusic(None,0,255,MTRAN_Instant);				
				KlingonPlayer(Instigator).LoopAnim('Wait', 1.0, 0.05);
				
//				KlingonPlayer(Instigator).PlayWaiting();
//				KlingonPlayer(Instigator).GotoState('Waiting');
			}

			GotoState('CutSceneState');
//			log(GetStateName());
		}
	}
	
}


/*

state Waiting
{
Begin:
	if (Enemy == none)
	{
		Enemy = LastEnemy;
		Super.GotoState('Attacking');

	}
	else
		GotoState('Attacking');
	
}


function bool SetEnemy( Pawn NewEnemy )
{
	LastEnemy = NewEnemy;
	Super.SetEnemy(NewEnemy);

}
*/

state CutSceneState
{
ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall,takeDamage,Hitwall, WarnTarget,landed,ChooseTeamAttackFor,ChooseLeaderAttack;
	function BeginState()
	{
//		logDebug("Entering CutSceneState "$nextState,2);
	
		nextstate = '';
	}
	function EndState()
	{
//		logDebug("Ending CutSceneState "$nextState,2);
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
	
	PlayAnim('Death',0.9,0.1);
	PlaySound(sound 'KorekDeath3', SLOT_Talk, /*volume*/,,4000,/*pitch*/);
//	PawnsWait(true);
	FinishAnim();
	
	Health = CutSceneDamage-1;
	CutSceneDamage = -2000;

	if (KlingonPlayer(instigator) != none)	
	{
		CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).ResetPlayerViews();		
	}
	
//	AttitudeToPlayer = ATTITUDE_Ignore;

//	PawnsWait(false);
	
//	GotoState('Waiting');

}

/*
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

function SetMovementPhysics()
{
	if ( Region.Zone.bWaterZone )
		SetPhysics(PHYS_Swimming);
	else if (Physics != PHYS_Walking)
		SetPhysics(PHYS_Walking); 
}

//xxx this is probably good to go.  Need to check it real quick though
function TryToDuck(vector duckDir, bool bReversed)
{
	local vector HitLocation, HitNormal, Extent;
	local bool duckLeft;
	local actor HitActor;
	local float decision;

//	log("try to duck");			
	duckDir.Z = 0;
	duckLeft = !bReversed;

	Extent.X = CollisionRadius;
	Extent.Y = CollisionRadius;
	Extent.Z = CollisionHeight;
	HitActor = Trace(HitLocation, HitNormal, Location + 160 * duckDir, Location, false, Extent);
	if (HitActor != None)
	{
		duckLeft = !duckLeft;
		duckDir *= -1;
		HitActor = Trace(HitLocation, HitNormal, Location + 160 * duckDir, Location, false, Extent);
	}
	if (HitActor != None)
		return;
	
	HitActor = Trace(HitLocation, HitNormal, Location + 128 * duckDir - MaxStepHeight * vect(0,0,1), Location + 128 * duckDir, false, Extent);
	if (HitActor == None)
		return;
		
	SetFall();
	if (IsMeleeAnim())
		TweenAnim('DuckRK', 0.3);
	else
		TweenAnim('DuckRK', 0.3);
	Velocity = duckDir * GroundSpeed;
	Velocity.Z = 200;
	SetPhysics(PHYS_Falling);
	GotoState('Falling','Ducking');
}	

function bool IsMeleeAnim()
{
	return (right(AnimSequence, 2) == "BA"); 
}
/////////////////Speaking Functions/////////////////
function SpeechTimer()
{
	//last syllable expired.  Decide whether to keep the floor or quit
	if ( (Enemy == None || bTeamLeader) && (FRand() < 0.6) )
	{
		bIsSpeaking = false;
		if (TeamLeader != None)
			TeamLeader.bTeamSpeaking = false;
	}
	else
		Speak();
}

function SpeakOrderTo(KlingonPawn TeamMember)
{
	local float decision;
	
	if ( (TeamMember == self) || (!TeamMember.bCanSpeak) || (FRand() < 0.5) )
	{
		bIsSpeaking = true;
		if (TeamLeader != None)	
			TeamLeader.bTeamSpeaking = true;
	
		decision = FRand();		
		if (decision < 0.33)
			PlaySound(Command1, SLOT_Talk, /*volume*/,,,/*pitch*/);
		else if (decision < 0.67)
			PlaySound(Command2, SLOT_Talk, /*volume*/,,,/*pitch*/);
		else
			PlaySound(Command3, SLOT_Talk, /*volume*/,,,/*pitch*/);	
		
		SpeechTime = 0.5 + 0.5*FRand();
	}
	else
		TeamMember.SpeakOrderTo(self);
		
}

function SpeakTo(KlingonPawn Other)
{
	if (Other.bIsSpeaking || ((TeamLeader != None) && TeamLeader.bTeamSpeaking) )
		return;
	
	Speak();
}

function Speak()
{
	local float decision;
	
	bIsSpeaking = true;
	if (TeamLeader != None)	
		TeamLeader.bTeamSpeaking = true;
	
	decision = FRand();
	if (decision < 0.25)
		PlaySound(Talk1,SLOT_Talk,/*inflection*/,,, /*pitch*/);
	else if (decision < 0.5)
		PlaySound(Talk2,SLOT_Talk,/*inflection*/,,, /*pitch*/);
	else if (decision < 0.75)
		PlaySound(Talk3,SLOT_Talk,/*inflection*/,,, /*pitch*/);
	else
		PlaySound(Talk4,SLOT_Talk,/*inflection*/,,, /*pitch*/);

	SpeechTime = 0.5 + FRand();
}
	
function PlayAcquisitionSound()
{
	local float decision;
	
	if ( bCanSpeak && (TeamLeader != None) && !TeamLeader.bTeamSpeaking )
	{
		decision = FRand();
		if (decision < 0.33)
			PlaySound(Acquire,SLOT_Talk,/*inflection*/,,, /*pitch*/);
		else if (decision < 0.67)
			PlaySound(Acquire2,SLOT_Talk,/*inflection*/,,, /*pitch*/);
		else
			PlaySound(Acquire3,SLOT_Talk,/*inflection*/,,, /*pitch*/);
	}
}

function PlayRoamingSound()
{
	local float decision;
	
	if ( bCanSpeak  )
	{
		decision = FRand();
		if (decision < 0.5)
			PlaySound(Roam,SLOT_Talk,/*inflection*/,true,, /*pitch*/);
		else
			PlaySound(Roam2,SLOT_Talk,/*inflection*/,true,, /*pitch*/);		
	}
}

/////////////////Animation Functions//////////////////////
function PlayWaiting()
{
	local float decision;
	
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
	LoopAnim('WaitRK', 0.3+0.3*FRand());
}

function PlayPatrolStop()
{
	PlayWaiting();
}

function PlayWaitingAmbush()
{
	PlayWaiting();
}

function PlayChallenge()
{
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}	
	PlayThreateningSound();
	PlayAnim('WaitRK', 0.5+0.5*FRand());
}

function TweenToFighter(float tweentime)
{
	if (Region.Zone.bWaterZone)
	{
		TweenToSwimming(tweentime);
		return;
	}
	TweenAnim('WaitRK', tweentime);
}

function TweenToRunning(float tweentime)
{
	if (Region.Zone.bWaterZone)
	{
		TweenToSwimming(tweentime);
		return;
	}
	if (IsMeleeAnim())
	{
		if (AnimSequence != 'RunBA' || !bAnimLoop)
			TweenAnim('RunBA', tweentime);
	}
	else
	{
		if (AnimSequence != 'RunRK' || !bAnimLoop)
			TweenAnim('RunRK', tweentime);
	}
}

function TweenToWalking(float tweentime)
{
	if (Region.Zone.bWaterZone)
	{
		TweenToSwimming(tweentime);
		return;
	}
	if (IsMeleeAnim())
		TweenAnim('WalkBA', tweentime);
	else
		TweenAnim('WalkRK', tweentime);
}

function TweenToWaiting(float tweentime)
{
	if (Region.Zone.bWaterZone)
	{
		TweenToSwimming(tweentime);
		return;
	}
	if (GetAnimGroup(AnimSequence) == 'Ducking')
	{
		TweenAnim(AnimSequence, 1.0);
		return;
	}
	if (IsMeleeAnim())
		TweenAnim('WaitBA', tweentime);
	else
		TweenAnim('WaitRK', tweentime);
}

function TweenToPatrolStop(float tweentime)
{
	TweenToWaiting(tweentime);
}

function PlayRunning()
{
	local float strafeMag;
	local vector Focus2D, Loc2D, Dest2D;
	local vector lookDir, moveDir, Y;

	DesiredSpeed = MaxDesiredSpeed;
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}

	if (Focus == Destination)
	{
		if (IsMeleeAnim())
		{	
			LoopAnim('RunBA', -1.6/GroundSpeed,, 0.4);
			return;
		}
		else
		{
			LoopAnim('RunRK', -1.6/GroundSpeed,, 0.4);
			return;
		}
	}	
	Focus2D = Focus;
	Focus2D.Z = 0;
	Loc2D = Location;
	Loc2D.Z = 0;
	Dest2D = Destination;
	Dest2D.Z = 0;
	lookDir = Normal(Focus2D - Loc2D);
	moveDir = Normal(Dest2D - Loc2D);
	strafeMag = lookDir dot moveDir;
	if (IsMeleeAnim())
	{
		if (strafeMag > 0.8)
			LoopAnim('RunBA', -1.6/GroundSpeed,, 0.4);
		else if (strafeMag < -0.8)
			LoopAnim('RunBA', -1.6/GroundSpeed,, 0.4);
		else
		{
			Y = (lookDir Cross vect(0,0,1));
			if ((Y Dot (Dest2D - Loc2D)) < 0) 
				LoopAnim('StrafRightBA', -1.6/GroundSpeed,, 1.0); 
			else
				LoopAnim('StrafLeftBA', -1.6/GroundSpeed,, 1.0);
		}
	}
	else
	{
		if (strafeMag > 0.8)
			LoopAnim('RunRK', -1.6/GroundSpeed,, 0.4);
		else if (strafeMag < -0.8)
			LoopAnim('RunRK', -1.6/GroundSpeed,, 0.4);
		else
		{
			Y = (lookDir Cross vect(0,0,1));
			if ((Y Dot (Dest2D - Loc2D)) < 0) 
				LoopAnim('StrafRightRK', -1.6/GroundSpeed,, 1.0); 
			else
				LoopAnim('StrafLeftRK', -1.6/GroundSpeed,, 1.0);
		}
	}
}

//XXX here we need to assert that you have the gun drawn already
//xxx othewise swithc from sword to gun will look odd
function PlayMovingAttack()
{
	local float strafeMag;
	local vector Focus2D, Loc2D, Dest2D;
	local vector lookDir, moveDir, Y;

	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	DesiredSpeed = MaxDesiredSpeed;

	if (Focus == Destination)
	{
		LoopAnim('RunShootRK', -1.6/GroundSpeed,, 0.4);
		return;
	}	
	Focus2D = Focus;
	Focus2D.Z = 0;
	Loc2D = Location;
	Loc2D.Z = 0;
	Dest2D = Destination;
	Dest2D.Z = 0;
	lookDir = Normal(Focus2D - Loc2D);
	moveDir = Normal(Dest2D - Loc2D);
	strafeMag = lookDir dot moveDir;
	if (strafeMag > 0.8)
		LoopAnim('RunShootRK', -1.6/GroundSpeed,, 0.4);
	else if (strafeMag < -0.8)
		LoopAnim('RunShootRK', -1.6/GroundSpeed,, 0.4);
	else
	{
		MoveTimer += 0.2;
		DesiredSpeed = 0.6;
		Y = (lookDir Cross vect(0,0,1));
		if ((Y Dot (Dest2D - Loc2D)) < 0) 
			LoopAnim('StrafRightShootRK', -1.6/GroundSpeed,, 1.0); 
		else
			LoopAnim('StrafLeftShootRK', -1.6/GroundSpeed,, 1.0);
	}
}

function PlayWalking()
{
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	if ( IsMeleeAnim() )
		LoopAnim('WalkBA', -3.3/GroundSpeed,, 0.4);
	else
		LoopAnim('WalkRK', -3.3/GroundSpeed,, 0.4);
}

function TweenToSwimming(float tweentime)
{
	if (AnimSequence != 'RunRK' || !bAnimLoop)
		TweenAnim('RunRK', tweentime);
}

function PlaySwimming()
{
	LoopAnim('RunRK', -1.0/GroundSpeed,,0.3);
}

function TweenToFalling()
{
	if ( IsMeleeAnim() )
		TweenAnim('DuckBA', 0.25);
	else
		TweenAnim('DuckRK',0.25);
}

function PlayInAir()
{
	if ( IsMeleeAnim() )
		TweenAnim('DuckBA', 0.5);
	else
		TweenAnim('DuckRK',0.5);
}

function PlayOutOfWater()
{
	if ( IsMeleeAnim() )
		TweenAnim('DuckBA', 0.5);
	else
		TweenAnim('DuckRK',0.5);
}

function PlayLanded(float impactVel)
{
	local float tweentime;
	
	if (impactVel > 1.7 * JumpZ)
		tweentime = 0.5;
	else
		tweentime = 0.1;
		
	if (IsMeleeAnim())
		Tweenanim('DuckBA',tweentime);
	else
		TweenAnim('DuckRK', tweentime);
}

function PlayThreatening()
{
	local float decision;

	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	decision = FRand();
	
	PlayThreateningSound();
	if (decision < 0.25)
		PlayAnim('BackSlashBA',,0.2);
	else if (decision < 0.5)
		PlayAnim('OverHeadHitBA',,0.2);
	else
		PlayAnim('VictoryBA',,0.2);
}

function PlayTurning()
{
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	if (GetAnimGroup(AnimSequence) == 'Ducking')
		return;
	if (IsMeleeAnim())
		TweenAnim('WalkBA', 0.3);
	else
		TweenAnim('WalkRK', 0.3);
}

function TweenToCommand(float Tweentime)
{
	TweenAnim('BackSlashBA', tweentime);
}

function PlayCommand()
{
	if (Frand() < 0.5)
		PlayAnim('VictoryBA',,0.2);
	else
		PlayAnim('BackSlashBA');
}

function PlayVictoryDance()
{	
	local float decision;
	
	PlayAnim('VictoryBA',,0.2);
}

function PlayDying(name DamageType, vector HitLoc)
{
//	PlayAnim('Death',0.7, 0.1);
	PlaySound(Die);
}

function PlayGutHit(float tweentime)
{
	if ( IsMeleeAnim() )
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == 'HitGutBA') )
		{
			if (FRand() < 0.5)
				TweenAnim('HitLeftBA', tweentime);
			else
				TweenAnim('HitRightBA', tweentime);
		}
		else
			TweenAnim('HitGutBA', tweentime);
	}
	else
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == 'HitGutRK') )
		{
			if (FRand() < 0.5)
				TweenAnim('HitLeftRK', tweentime);
			else
				TweenAnim('HitRightRK', tweentime);
		}
		else
			TweenAnim('HitGutRK', tweentime);
	}
}

function PlayHeadHit(float tweentime)
{
	if ( IsMeleeAnim() )
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == 'HitHeadBA') )
			TweenAnim('HitGutBA', tweentime);
		else
			TweenAnim('HitHeadBA', tweentime);
	}
	else
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == 'HitHeadRK') )
			TweenAnim('HitGutRK', tweentime);
		else
			TweenAnim('HitHeadRK', tweentime);
	}		
}

function PlayLeftHit(float tweentime)
{
	if ( IsMeleeAnim() )
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == 'HitLeftBA') )
			TweenAnim('HitGutBA', tweentime);
		else
			TweenAnim('HitLeftBA', tweentime);
	}
	else
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == 'HitLeftRK') )
			TweenAnim('HitGutRK', tweentime);
		else
			TweenAnim('HitLeftRK', tweentime);
	}
}

function PlayRightHit(float tweentime)
{
	if ( IsMeleeAnim() )
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == 'HitRightBA') )
			TweenAnim('HitGutBA', tweentime);
		else
			TweenAnim('HitRightBA', tweentime);
	}
	else
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == 'HitRightRK') )
			TweenAnim('HitGutRK', tweentime);
		else
			TweenAnim('HitRightRK', tweentime);
	}
}

function PlayMeleeAttack()
{
	local float decision;

	decision = FRand();
	if (decision < 0.2)
	{
		PlayAnim('SlashBA'); 
		PlaySound(slash,SLOT_Interact);
	}
 	else if (decision < 0.6)
 	{
   		PlayAnim('BackSlashBA');
   		PlaySound(backslash,SLOT_Interact);
   	}
 	else
 	{
 		PlayAnim('OverHeadHitBA');
 		PlaySound(overhead,SLOT_Interact);
 	} 
}

function SpawnShot()
{
	FireProjectile( vect(1.3, -0.5, 0.4), 400);
}

function SpawnStunShot()
{
	FireProjectile( vect(1.3, -0.5, -0.2), 1000);
}

function OverHeadDamageTarget()
{
	if ( MeleeDamageTarget(OverHeadDamage, (OverHeadDamage * 500 * Normal(Target.Location - Location))) ) 
		PlaySound(FleshSlice, SLOT_Interact);
}		

function SlashDamageTarget()
{
	if ( MeleeDamageTarget(SlashDamage, (SlashDamage * 500 * Normal(Target.Location - Location))) ) 
		PlaySound(FleshSlice, SLOT_Interact);
}

function BackSlashDamageTarget()
{
	if ( MeleeDamageTarget(BackSlashDamage, (BackSlashDamage * 500 * Normal(Target.Location - Location))) ) 
		PlaySound(FleshSlice, SLOT_Interact);
}

function PlayRangedAttack()
{
	PlayAnim('ShootRK');
}	

*/

defaultproperties
{
     OverHeadDamage=25
     StabDamage=20
     SlashDamage=20
     BackSlashDamage=20
     slash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     backslash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     fleshslice=Sound'KlingonSFX01.Weapons.Bathit'
     overhead=Sound'KlingonSFX01.Weapons.BatSwingBig'
     Acquire2=Sound'KlingonSFX01.creature.KorekTaunt06'
     Threaten2=Sound'KlingonSFX01.creature.KorekTaunt03'
     Threaten3=Sound'KlingonSFX01.creature.KorekTaunt09'
     ReloadSound1=Sound'KlingonSFX01.Weapons.RocketLd2'
     VoiceRadius=1000.000000
     CarcassType=Class'Klingons.KlingonCarcass'
     TimeBetweenAttacks=2.000000
     Aggressiveness=0.900000
     RefireRate=0.500000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.RocketProjectile'
     ProjectileSpeed=1200.000000
     Acquire=Sound'KlingonSFX01.creature.KorekTaunt08'
     Threaten=Sound'KlingonSFX01.creature.KorekTaunt01'
     bCanUseCover=True
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=4
     DodgeAmount=0.600000
     Accuracy=300.000000
     RetreatDamage=5
     MySide=HonorGuard
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.RocketSt'
     bCanStrafe=True
     MeleeRange=50.000000
     GroundSpeed=400.000000
     AirSpeed=0.000000
     AccelRate=512.000000
     HearingThreshold=1.000000
     Health=1600
     Intelligence=BRAINS_HUMAN
     Skill=3.000000
     HitSound1=Sound'KlingonSFX01.creature.KorekHit3'
     HitSound2=Sound'KlingonSFX01.creature.KorekHit4'
     CombatStyle=0.900000
     Physics=PHYS_Walking
     AnimSequence=WaitRK
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnKorek'
     DrawScale=1.600000
     CollisionRadius=29.000000
     CollisionHeight=54.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=90.000000
}
