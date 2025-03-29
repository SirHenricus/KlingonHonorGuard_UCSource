//=============================================================================
// RPBeast.
//=============================================================================
class RPBeast expands KlingonPawn;

#call q:\klingons\art\pawns\RPBeast\final\RPBeast.mac
#exec MESH ORIGIN MESH=PawnRureBeast X=0 Y=-150 Z=-37 YAW=64

#exec MESH NOTIFY MESH=PawnRureBeast SEQ=BiteRight  TIME=0.6 FUNCTION=BiteRightDamageTarget
#exec MESH NOTIFY MESH=PawnRureBeast SEQ=BiteLeft   TIME=0.6 FUNCTION=BiteLeftDamageTarget
#exec MESH NOTIFY MESH=PawnRureBeast SEQ=RipRight   TIME=0.4 FUNCTION=RipRightDamageTarget
#exec MESH NOTIFY MESH=PawnRureBeast SEQ=RipLeft    TIME=0.4 FUNCTION=RipLeftDamageTarget

#exec MESH NOTIFY MESH=PawnRureBeast SEQ=WaitPee    TIME=0.2 FUNCTION=SpawnPee
#exec MESH NOTIFY MESH=PawnRureBeast SEQ=EatCycle   TIME=0.3 FUNCTION=MangleFood
#exec MESH NOTIFY MESH=PawnRureBeast SEQ=EatCycle   TIME=0.8 FUNCTION=MangleFood
#exec MESH NOTIFY MESH=PawnRureBeast SEQ=EatCycle   TIME=0.05 FUNCTION=MangleFood
#exec MESH NOTIFY MESH=PawnRureBeast SEQ=EatCycle   TIME=0.55 FUNCTION=MangleFood

#exec MESH NOTIFY MESH=PawnRureBeast SEQ=DeadBlowUp TIME=0.1  FUNCTION=BlowUp

var() byte
	BiteRightDamage,
	BiteLeftDamage,
	RipRightDamage,
	RipLeftDamage;

var(Sounds) sound BiteRight;
var(Sounds) sound BiteLeft;
var(Sounds) sound RipRight;
var(Sounds) sound RipLeft;
var(Sounds) sound FleshBite;
var(Sounds) sound FleshRip;

var(Sounds) sound Bark1;
var(Sounds) sound Bark2;
var(Sounds) sound Bark3;

//xxxvar		 BeastPee Pee;
var	bool bEater;
//XXX this modifies voice pitch and combatstyle--perhaps unnecessarily
function PreBeginPlay()
{
	bCanSpeak = true;
	Super.PreBeginPlay();
}

/* PreSetMovement()
*/
function PreSetMovement()
{
	MaxDesiredSpeed = 1.0;
	bCanJump = true;
	bCanWalk = true;
	bCanSwim = false;
	bCanFly = false;
	MinHitWall = -0.6;
	bCanOpenDoors = false;
	bCanDoSpecial = false;
	bCanDuck = true;  
}

//////////////////////////Speech////////////////////////////
//XXX syllable thingy again
function SpeechTimer()
{
	//last syllable expired.  Decide whether to keep the floor or quit
	if (FRand() < 0.7)
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
	if ( (TeamMember == self) || (!TeamMember.bCanSpeak) || (FRand() < 0.5) )
		Speak();
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
	if (decision < 0.33)
		PlaySound(Bark1,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
	else if (decision < 0.67)
		PlaySound(Bark2,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
	else
		PlaySound(Bark3,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);

	SpeechTime = 0.3+0.3*FRand();
}

//=========================================================================================

//XXX should have maybe 3 duck options--left, right, regular duck
function TryToDuck(vector DuckDir, bool bReversed)
{

}	

function BiteRightDamageTarget()
{
	if ( MeleeDamageTarget(BiteRightDamage, (BiteRightDamage * 1000 * Normal(Target.Location - Location))) ); 
		PlaySound(FleshBite, SLOT_Interact,,true,VoiceRadius);
}		

function BiteLeftDamageTarget()
{
	if ( MeleeDamageTarget(BiteLeftDamage, (BiteLeftDamage * 1000 * Normal(Target.Location - Location))) ); 
		PlaySound(FleshBite, SLOT_Interact,,true,VoiceRadius);
}

function RipRightDamageTarget()
{
	if ( MeleeDamageTarget(RipRightDamage, (RipRightDamage * -500 * Normal(Target.Location - Location))) ); 
		PlaySound(FleshRip, SLOT_Interact,,true,VoiceRadius);
}		

function RipLeftDamageTarget()
{
	if ( MeleeDamageTarget(RipLeftDamage, (RipLeftDamage * -500 * Normal(Target.Location - Location))) ); 
		PlaySound(FleshRip, SLOT_Interact,,true,VoiceRadius);
}

////////////////////////////Animations////////////////////////////
function PlayWaiting()
{
	local float decision;
	
	decision = FRand();

	if (bEater)
	{
		if (AnimSequence == 'ToEat')
		{
			PlayAnim('EatCycle', 0.7+0.6*FRand());
			SetAlertness(-1.0);
		}
		else if (AnimSequence == 'EatCycle')
		{
			if (decision < 0.8)
				PlayAnim('EatCycle', 0.7+0.6*FRand());
			else
				PlayAnim('FromEat');
		}
		else if (AnimSequence == 'FromEat')
		{
			PlayAnim('WaitLook', 0.7+0.6*FRand());
			SetAlertness(0.25);
		}
		else if (AnimSequence == 'WaitLook')
		{
			if (decision < 0.5)
				PlayAnim('ToEat');
			else
				PlayAnim('WaitCalm', 0.7+0.6*FRand());
		}
		else if (AnimSequence == 'WaitCalm')
		{
			if (decision < 0.2)
				PlayAnim('ToEat');
			else if (decision < 0.4)
				PlayAnim('WaitLook', 0.7+0.6*FRand());
			else
				PlayAnim('WaitCalm', 0.7+0.6*FRand());
		}
		else
			TweenAnim('WaitCalm', 0.25);
		//XXX
		if (AnimSequence == 'WaitCalm')
			SetAlertness(0.0);
	}
	else if (AnimSequence == 'WaitMad')
	{
		if (decision < 0.6)
			PlayAnim('WaitMad', 0.5+0.3*FRand());
		else if (decision < 0.8)
			PlayAnim('WaitLook', 0.7+0.6*FRand());
		else
			PlayAnim('WaitCalm', 0.3+0.3*FRand());
	}
	else if (AnimSequence == 'WaitPee')
	{	PlayAnim('WaitCalm', 0.3+0.3*FRand());
		SetAlertness(0.0);
	}
	
	else if (AnimSequence == 'WaitCalm')
	{
		if (decision < 0.1)
		{
			PlayAnim('WaitPee', 1.0, 0.2);
			SetAlertness(-0.7);
		}
		else if (decision < 0.15)
			PlayAnim('WaitMad', 0.5+0.3*FRand());
		else if (decision < 0.8)
			PlayAnim('WaitLook', 0.7+0.6*FRand());
		else
			PlayAnim('WaitCalm', 0.3+0.3*FRand());
	}
	else
		PlayAnim('WaitCalm', 0.3+0.3*FRand());
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
	PlayAnim('WaitMad', 0.8);
}

function TweenToFighter(float tweentime)
{
	TweenAnim('WaitMad', tweentime);
}

function TweenToRunning(float tweentime)
{
	if (AnimSequence != 'Run' || !bAnimLoop)
		TweenAnim('Run', tweentime);
}

function TweenToWalking(float tweentime)
{
	TweenAnim('Walk', tweentime);
}

function TweenToWaiting(float tweentime)
{
	TweenAnim('WaitCalm', tweentime);
}

function TweenToPatrolStop(float tweentime)
{
	TweenAnim('WaitCalm', tweentime);
}

function PlayRunning()
{
	local vector X,Y,Z;
	local float YAccel;

	GetAxes(rotation, X,Y,Z);
	YAccel = Acceleration dot Y;
	
	if (YAccel < -1.5)
	{
		if (AnimSequence == 'RunRight')
			LoopAnim('RunRight', -2.0/GroundSpeed,,0.4);
		else
			LoopAnim('RunRight', -2.0/GroundSpeed,0.1,0.4);
	}
	else if (YAccel > 1.5)
	{
		if (AnimSequence == 'RunLeft')
			LoopAnim('RunLeft', -2.0/GroundSpeed,,0.4);
		else
			LoopAnim('RunLeft', -2.0/GroundSpeed,0.1,0.4);
	}
	else
	{
		if (AnimSequence == 'Run')
			LoopAnim('Run', -2.0/GroundSpeed,,0.4);
		else
			LoopAnim('Run', -2.0/GroundSpeed,0.1,0.4);
	}
}

function PlayWalking()
{
	LoopAnim('Walk', -6.5/GroundSpeed,,0.4);
}

function PlayThreatening()
{
	PlayAnim('WaitMad', 0.8);
}

function PlayTurning()
{
	LoopAnim('Walk', 1.5);
}

function PlayDying(name DamageType, vector HitLocation)
{
	local float decision;
	
	PlaySound(Die, SLOT_Talk,,,VoiceRadius);
	
	decision = frand();
	if (decision < 0.33)
	{
		PlayAnim('DeadFall', 0.7, 0.1);
	} if (decision < 0.66)
	{
		PlayAnim('DeadFwdRoll', 1.0, 0.1);
	} else
	{
		PlayAnim('DeadBlowUp', 1.0, 0.1);		
	}
/*
	if ( VSize(Velocity) > 300.0)
	{
		if (Velocity.Z > 150 || FRand() < 0.25)
			PlayAnim('DeadBlowUp', 1.0, 0.1);
		else
			PlayAnim('DeadFwdRoll', 1.0, 0.1);
	}
	else if (FRand() < 0.3)
		PlayAnim('DeadBlowUp', 1.0, 0.1);
	else
		PlayAnim('DeadFall', 0.7, 0.1);
*/
}

function PlayTakeHit(float tweentime, vector HitLoc, int damage)
{
	PlayAnim('HitFront');
}

function PlayVictoryDance()
{
	PlayAnim('WaitPee', 1.0, 0.1);
}

function PlayMeleeAttack()
{
	local float decision;
	
	decision = FRand();
	
	if (decision < 0.25)
	{
		PlayAnim('BiteRight');
		PlaySound(BiteRight, SLOT_Interact,,true,VoiceRadius);
	}
	else if (decision < 0.5)
	{
		PlayAnim('BiteLeft');
		PlaySound(BiteLeft, SLOT_Interact,,true,VoiceRadius);
	}
	else if (decision < 0.75)
	{
		PlayAnim('RipRight');
		PlaySound(RipRight, SLOT_Interact,,true,VoiceRadius);
	}
	else
	{
		PlayAnim('RipLeft');
		PlaySound(RipLeft, SLOT_Interact,,true,VoiceRadius);
	}	
}

function SpawnPee()
{
	local vector loc, X,Y,Z;
	local rotator rot1;
	
	GetAxes(rotation, X,Y,Z);
	loc = location + 11.64*X - 20.79*Y + 68.99*Z;
	rot1 = rotation;
	rot1.yaw -= 4416;
	
//xxx	Pee = Spawn(class 'BeastPee',,,loc, rot1);
//xxx	Pee.LoopAnim('BeastPee', 0.3);
//xxx	Pee.lifespan = 0.85;
}

function MangleFood()
{
	local vector loc, X,Y,Z;
	
	GetAxes(rotation, X,Y,Z);
	loc = location + 1.15*X*collisionradius - 0.5*Z*collisionheight;
//xxx	Spawn(class 'Blood', self, '', loc);
}

function BlowUp()
{
	local vector X,Y,Z;
	
	GetAxes(rotation, X,Y,Z);
	Velocity += 150*(2*Z - X);
} 

state Waiting
{

	function EndState()
	{
		bEater = false;
	}

TurnFromWall:
//xxx	if ( NearWall() )
//xxx	{
//xxx		PlayTurning();
//xxx		TurnTo(Focus);
//xxx	}

Begin:
	if (OrderTag == 'Eating')
		bEater = true;
	TweenToWaiting(0.4);
	bReadyToAttack = false;
	DesiredRotation = rot(0,0,0);
	DesiredRotation.Yaw = Rotation.Yaw;
	SetRotation(DesiredRotation);
	if (Physics != PHYS_Falling) 
		SetPhysics(PHYS_None);
KeepWaiting:
	NextAnim = '';
}

state VictoryDance
{
ignores SeePlayer, HearNoise; //FIXME - don't ignore, particularly if bot

Begin:
	if ( (Target == None) || 
		(VSize(Location - Target.Location) < 
		(1.3 * CollisionRadius + Target.CollisionRadius + CollisionHeight - Target.CollisionHeight)) )
			Goto('Taunt');
	Destination = Target.Location;
	TweenToWalking(0.3);
	FinishAnim();
	PlayWalking();
	Enable('Bump');
		
MoveToEnemy:

	WaitForLanding();
	PickDestination();
	if (SpecialPause > 0.0)
	{
		Acceleration = vect(0,0,0);
		TweenToPatrolStop(0.3);
		Sleep(SpecialPause);
		SpecialPause = 0.0;
		TweenToWalking(0.1);
		FinishAnim();
		PlayWalking();
	}
	MoveToward(MoveTarget, WalkingSpeed);
	Enable('Bump');
	If (VSize(Location - Target.Location) < 
		(1.3 * CollisionRadius + Target.CollisionRadius + Abs(CollisionHeight - Target.CollisionHeight)))
		Goto('Taunt');
	Goto('MoveToEnemy');

Taunt:
	Acceleration = vect(0,0,0);
	TweenToFighter(0.2);
	FinishAnim();
	PlayTurning();
	if (FRand() < 0.5)
	{
		TurnTo(location + ((Target.location - location) Cross vect(0,0,1)) );
		DesiredRotation = rot(0,0,0);
		DesiredRotation.Yaw = Rotation.Yaw;
		setRotation(DesiredRotation);
		TweenToFighter(0.2);
		FinishAnim();
		PlayVictoryDance();
		FinishAnim(); 
		WhatToDoNext('Waiting','TurnFromWall');
	}
	else
	{
		TurnToward(Target);
		DesiredRotation = rot(0,0,0);
		DesiredRotation.Yaw = Rotation.Yaw;
		setRotation(DesiredRotation);
		bEater = true;
		GotoState('Waiting');
	}
}

/*
state Dying
{
	function BeginState()
	{
		if (AnimSequence != 'DeadFwdRoll')
			Super.BeginState();
	}

	function Tick(float DeltaTime)
	{
		if (AnimSequence == 'DeadFwdRoll')
		{
			Velocity -= 0.5*FootRegion.zone.ZoneGroundFriction*Velocity*deltatime;
			Setlocation(location + Velocity*DeltaTime);
			if (Velocity dot Velocity < 100)
			{
				SetTimer(0.1, false);
				SetPhysics(PHYS_None);
			}
		}
	}
	
	/*event Landed(vector HitNormal)
	{
		SetPhysics(PHYS_Walking);
	}*/
}	
*/

defaultproperties
{
     BiteRightDamage=5
     BiteLeftDamage=5
     RipRightDamage=5
     RipLeftDamage=5
     BiteRight=Sound'KlingonSFX01.creature.BiteRight'
     BiteLeft=Sound'KlingonSFX01.creature.BiteLeft'
     RipRight=Sound'KlingonSFX01.creature.RipRight'
     RipLeft=Sound'KlingonSFX01.creature.RipLeft'
     FleshBite=Sound'KlingonSFX01.creature.FleshBite2'
     FleshRip=Sound'KlingonSFX01.creature.FleshRip2'
     Bark1=Sound'KlingonSFX01.creature.DogBark2'
     CarcassType=Class'Klingons.RPBeastCarcass'
     Aggressiveness=0.750000
     RefireRate=0.750000
     WalkingSpeed=0.200000
     bLeadTarget=False
     bWarnTarget=False
     ProjectileSpeed=0.000000
     Acquire=Sound'KlingonSFX01.creature.DogAquire'
     Roam=Sound'KlingonSFX01.creature.DogRoam'
     Threaten=Sound'KlingonSFX01.creature.DogThreaten'
     Breath=Sound'KlingonSFX01.creature.DogBreath'
     SplatClass=Class'Klingons.RedBlood'
     PartBlood=Class'Klingons.RedParticles'
     MediumDamage=Texture'KlingonFX01.creatures.RPDogOUCH1'
     HeavyDamage=Texture'KlingonFX01.creatures.RPDogOUCH2'
     MeleeRange=40.000000
     GroundSpeed=400.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     JumpZ=225.000000
     HearingThreshold=5.000000
     Health=40
     HitSound1=Sound'KlingonSFX01.creature.DogHit1'
     HitSound2=Sound'KlingonSFX01.creature.DogHit2'
     Die=Sound'KlingonSFX01.creature.DogDie'
     CombatStyle=0.800000
     Physics=PHYS_Walking
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnRureBeast'
     DrawScale=0.700000
     CollisionRadius=30.000000
     CollisionHeight=28.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=1
     Buoyancy=90.000000
}
