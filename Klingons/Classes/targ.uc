//=============================================================================
// Targ.
//=============================================================================
class Targ expands KlingonPawn;

#call q:\klingons\art\pawns\Targ\final\Targ.mac
#exec MESH ORIGIN MESH=pawntarg X=0 Y=10 Z=30 YAW=64
//#alwaysexec MESH ORIGIN MESH=pawntarg X=0 Y=-10 Z=30 YAW=64


#exec MESH NOTIFY MESH=pawntarg SEQ=BiteRight  TIME=0.6 FUNCTION=BiteRightDamageTarget
#exec MESH NOTIFY MESH=pawntarg SEQ=BiteLeft   TIME=0.6 FUNCTION=BiteLeftDamageTarget
#exec MESH NOTIFY MESH=pawntarg SEQ=Gore       TIME=0.4 FUNCTION=GoreDamageTarget

//#exec MESH NOTIFY MESH=pawntarg SEQ=Poop   TIME=0.5 FUNCTION=SpawnPoop

var() byte
	BiteRightDamage,
	BiteLeftDamage,
	GoreDamage;

var(Sounds) sound BiteRight;
var(Sounds) sound BiteLeft;
var(Sounds) sound Gore;
var(Sounds) sound FleshBite;
var(Sounds) sound FleshGore;

var(Sounds) sound Bark1;
var(Sounds) sound Bark2;
var(Sounds) sound Bark3;

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

return;
	
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

function GoreDamageTarget()
{
	if ( MeleeDamageTarget(GoreDamage, (GoreDamage * 5000 * Normal(Target.Location - Location))) ); 
		PlaySound(FleshGore, SLOT_Interact,,true,VoiceRadius);
}

////////////////////////////Animations////////////////////////////
function PlayWaiting()
{
	local float decision;
	
	decision = FRand();

//	if (decision < 0.1)
//		PlayAnim('Poop', 0.5+0.5*FRand());
	if (decision < 0.2)
		PlayAnim('WaitLook', 0.3+0.5*FRand(),0.1);
	else if (decision < 0.4)
		PlayAnim('WaitSniff', 0.5+0.5*FRand(),0.1);
	else 
		PlayAnim('WaitBreath', 0.5+0.5*FRand(),0.1);
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
	PlayAnim('WaitSniff', 0.8,0.1);
}

function TweenToFighter(float tweentime)
{
	TweenAnim('Gore', tweentime);
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
	TweenAnim('WaitBreath', tweentime);
}

function TweenToPatrolStop(float tweentime)
{
	TweenAnim('WaitBreath', tweentime);
}

function PlayRunning()
{
	local vector X,Y,Z;
	local float YAccel;

//	GetAxes(rotation, X,Y,Z);
//	YAccel = Acceleration dot Y;
	
/*	if (YAccel < -0.5)
	{
		if (AnimSequence == 'RunRight')
			LoopAnim('RunRight', -2.8/GroundSpeed,,0.4);
		else
			LoopAnim('RunRight', -2.8/GroundSpeed,0.1,0.4);
	}
	else if (YAccel > 0.5)
	{
		if (AnimSequence == 'RunLeft')
			LoopAnim('RunLeft', -2.8/GroundSpeed,,0.4);
		else
			LoopAnim('RunLeft', -2.8/GroundSpeed,0.1,0.4);
	}
	else
	{
*/		if (AnimSequence == 'Run')
			LoopAnim('Run', -2.8/GroundSpeed,,0.4);
		else
			LoopAnim('Run', -2.8/GroundSpeed,0.1,0.4);
//	}
}

function PlayWalking()
{
	LoopAnim('Walk', -6.5/GroundSpeed,,0.4);
}

function PlayThreatening()
{
	PlayAnim('WaitSniff', 0.8,0.1);
}

function PlayDying(name DamageType, vector HitLocation)
{
	PlaySound(Die, SLOT_Talk,,,VoiceRadius);

	if (FRand() < 0.5)
		PlayAnim('DeadFall',1.0,0.1);
	else
		PlayAnim('DeadBlowUp',1.0,0.1);

	/*if ( size(Velocity) > 300.0)
	{
		if (Velocity.Z > 150 || FRand() < 0.25)
			PlayAnim('DeadBlowUp', 1.0, 0.1);
		else
			PlayAnim('DeadFwdRoll', 1.0, 0.1);
	}
	else if (FRand() < 0.3)
		PlayAnim('DeadBlowUp', 1.0, 0.1);
	else
		PlayAnim('DeadFall', 0.7, 0.1);*/
}

function PlayTakeHit(float tweentime, vector HitLoc, int damage)
{
	PlayAnim('HitFront');
}

function PlayVictoryDance()
{
//	PlayAnim('poop', 1.0, 0.1);

	PlayAnim('WaitSniff', 1.0, 0.1);
}

function PlayMeleeAttack()
{
	local float decision;
	
	decision = FRand();
	
	if (decision < 0.4)
	{
		PlayAnim('BiteRight');
		PlaySound(BiteRight, SLOT_Interact,,true,VoiceRadius);
	}
	else if (decision < 0.8)
	{
		PlayAnim('BiteLeft');
		PlaySound(BiteLeft, SLOT_Interact,,true,VoiceRadius);
	}
	else 
	{
		PlayAnim('Gore');
		PlaySound(Gore, SLOT_Interact,,true,VoiceRadius);
	}
}

function PlayTurning()
{
	//log("calling turnpawing animation in playturning");
	LoopAnim('Walk', 1.0,0.1);
}

/*
function SpawnPoop()
{
	local vector X,Y,Z;
	GetAxes(rotation, X,Y,Z);
	
	spawn(class 'TargTurd', self, '', location - 0.9*collisionradius*X - 0.4*collisionheight*Z);
}
*/

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
	TurnTo(location + 50*(location - Target.location));
	DesiredRotation = rot(0,0,0);
	DesiredRotation.Yaw = Rotation.Yaw;
	setRotation(DesiredRotation);
	PlayVictoryDance();
	FinishAnim(); 
	WhatToDoNext('Waiting','TurnFromWall');
}

defaultproperties
{
     BiteRightDamage=7
     BiteLeftDamage=7
     GoreDamage=7
     BiteRight=Sound'KlingonSFX01.creature.TargBite'
     BiteLeft=Sound'KlingonSFX01.creature.TargBite'
     Gore=Sound'KlingonSFX01.creature.TargHit2'
     FleshBite=Sound'KlingonSFX01.creature.FleshBite2'
     CarcassType=Class'Klingons.TargCarcass'
     Aggressiveness=0.500000
     Acquire=Sound'KlingonSFX01.creature.TargAquire'
     Fear=Sound'KlingonSFX01.creature.TargFear'
     Roam=Sound'KlingonSFX01.creature.TargRoam'
     Threaten=Sound'KlingonSFX01.creature.TargDeath'
     SplatClass=Class'Klingons.PinkBlood'
     MediumDamage=Texture'KlingonFX01.creatures.targOUCH1'
     HeavyDamage=Texture'KlingonFX01.creatures.targOUCH2'
     MeleeRange=30.000000
     GroundSpeed=400.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     JumpZ=160.000000
     HearingThreshold=1.000000
     Health=44
     Skill=0.500000
     HitSound1=Sound'KlingonSFX01.creature.TargHit1'
     HitSound2=Sound'KlingonSFX01.creature.TargHit3'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.TargThreaten'
     CombatStyle=0.500000
     AnimSequence=WaitLook
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnTarg'
     DrawScale=1.500000
     CollisionRadius=40.500000
     CollisionHeight=28.500000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Mass=200.000000
}
