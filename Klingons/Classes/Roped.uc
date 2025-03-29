//=============================================================================
// Roped.
//=============================================================================
class Roped expands KlingonPawn;

#call q:\klingons\art\pawns\Roped\final\Roped.mac
#exec MESH ORIGIN MESH=PawnRoped X=0 Y=-50 Z=-11 YAW=64 

#exec MESH NOTIFY MESH=PawnRoped SEQ=Walk       TIME=0.1  FUNCTION=FootStep
#exec MESH NOTIFY MESH=PawnRoped SEQ=Walk       TIME=0.6  FUNCTION=FootStep
#exec MESH NOTIFY MESH=PawnRoped SEQ=Walk       TIME=0.15  FUNCTION=StartMoving
#exec MESH NOTIFY MESH=PawnRoped SEQ=Walk       TIME=0.65  FUNCTION=StartMoving
#exec MESH NOTIFY MESH=PawnRoped SEQ=Pound      TIME=0.6  FUNCTION=PoundGround
#exec MESH NOTIFY MESH=PawnRoped SEQ=Throw      TIME=0.78 FUNCTION=SpawnRock
#exec MESH NOTIFY MESH=PawnRoped SEQ=Bite       TIME=0.5  FUNCTION=BiteDamageTarget
#exec MESH NOTIFY MESH=PawnRoped SEQ=SlashLeft  TIME=0.4  FUNCTION=SlashLeftDamageTarget
#exec MESH NOTIFY MESH=PawnRoped SEQ=SlashRight TIME=0.4  FUNCTION=SlashRightDamageTarget
#exec MESH NOTIFY MESH=PawnRoped SEQ=Breath TIME=0.2  FUNCTION=SpawnBreath


//Roped variables;
var() byte SlashLeftDamage,
	SlashRightDamage,
	BiteDamage;
	
var bool bStomp;
var bool bEndFootStep;
var bool bEating;
var float realSpeed;
var() name PoundEvent;
var() name StepEvent;
var(Sounds) sound Roar;
var(Sounds) sound Step;
var(Sounds) sound Pound;
var(Sounds) sound Bite;
var(Sounds) sound SlashLeft;
var(Sounds) sound SlashRight;
var(Sounds) sound SlashHit;
var(Sounds) sound BiteHit;
var(Sounds) sound ThrowRock;

function PreBeginPlay()
{
	if (AnimSequence == 'WaitGoodEatn')
		bEating = true;
	else	
		bEating = false;
	Super.PreBeginPlay();
}

singular event BaseChange()
{
	local float decorMass;
	if (Pawn(Base) != None)
	{
		Base.TakeDamage( 1000, Self,Location,0.5 * Velocity , 'stomped');
		JumpOffPawn();
	}
	else if ( (Decoration(Base) != None) && (Velocity.Z < -400) )
	{
		decorMass = FMax(Decoration(Base).Mass, 1);
		Base.TakeDamage(1000, Self, Location, 0.5 * Velocity, 'stomped');
	}
}

function eAttitude AttitudeToCreature(Pawn Other)
{
	if ( Other.IsA('Roped') )
		return ATTITUDE_Friendly;
	else
		return ATTITUDE_Ignore;
}

function ThrowOther(Pawn Other)
{
	local float dist, shake;
	local PlayerPawn aPlayer;
	local vector Momentum;

	if ( Other.mass > 500 )
		return;

	aPlayer = PlayerPawn(Other);
	if ( aPlayer == None )
	{	
		if ( !bStomp || (Other.Physics != PHYS_Walking) )
			return;
		dist = VSize(Location - Other.Location);
		if (dist > 500)
			return;
	}
	else
	{
		dist = VSize(Location - Other.Location);
		shake = FMax(75, (1500 - dist) * 0.5);
		if ( dist > 1500 )
			return;
		aPlayer.ShakeView( FMax(0, 0.35 - dist/20000), shake, 0.015 * shake);
		if ( Other.Physics != PHYS_Walking )
			return;
	}

	Momentum = -0.5 * Other.Velocity + 100 * VRand();
	Momentum.Z =  7000000.0/((0.4 * dist + 350) * Other.Mass);
	if (bStomp)
		Momentum.Z *= 2.0;		
	Other.AddVelocity(Momentum);
}

function FootStep()
{
	local actor A;
	local pawn Thrown;
	//slightly throw player if nearby ,& play footstep sound
	bStomp = false;
	bEndFootstep = false;
	if (StepEvent != '')
		foreach AllActors( class 'Actor', A, StepEvent )
			A.Trigger( Self, Instigator );

	Thrown = Level.PawnList;
	While ( Thrown != None )
	{
		ThrowOther(Thrown);
		Thrown = Thrown.nextPawn;
	}
	
	realSpeed = DesiredSpeed; //fixme - don't stop if very low friction
	DesiredSpeed = 0.0;
	PlaySound(Step, SLOT_Interact,,,VoiceRadius);
}

function StartMoving()
{
	DesiredSpeed = realSpeed;
}

function PoundGround()
{
	local actor A;
	local pawn Thrown;

	if (PoundEvent != '')
		foreach AllActors( class 'Actor', A, PoundEvent )
			A.Trigger( Self, Instigator );
			
	//throw all nearby creatures, and play sound
	bStomp = true;
	Thrown = Level.PawnList;
	While ( Thrown != None )
	{
		ThrowOther(Thrown);
		Thrown = Thrown.nextPawn;
	}
	PlaySound(Step, SLOT_Interact, 24,,VoiceRadius);
}


function PlayWaiting()
{
	local float decision;

	decision = FRand();

	if (bEndFootStep)
		FootStep();
				
	if (bEating)
		PlayAnim('WaitGoodEatn', 0.5+0.5*FRand());
	else if (decision < 0.95)
		PlayAnim('Breath', 0.5+0.3*FRand());
	else
	{
		PlayAnim('Roar');
		PlaySound(Roar, SLOT_Interact,,,VoiceRadius);
	}
}
	
//PlayPatrolStop(), and PlayWaitingAmbush() all use PlayWaiting(); 			
function PlayPatrolStop()
{
	if (bEndFootStep)
		FootStep();
	DesiredSpeed = 0.0;
	PlayWaiting();
}

function PlayWaitingAmbush()
{
	if (bEndFootStep)
		FootStep();
	DesiredSpeed = 0.0;
	PlayWaiting();
}

function PlayChallenge()
{
	local float decision;

	if (bEndFootStep)
		FootStep();
	DesiredSpeed = 0.0;
	decision = FRand();

	if (decision < 0.8)
	{
		PlayAnim('Roar');
		PlaySound(Roar, SLOT_Interact,,,VoiceRadius);
	}
	else if ( decision < 0.9 )
	{
		PlayAnim('SlashLeft', 1.0, 0.2);
		PlaySound(SlashLeft, SLOT_Interact,,,VoiceRadius);
	}
	else
	{
		PlayAnim('SlashRight', 1.0, 0.2);
		PlaySound(SlashRight, SLOT_Interact,,,VoiceRadius);
	}
}

function TweenToFighter(float tweentime)
{
	if (bEating)
		GotoState('Swallow');
	else
	{
		bEndFootStep = ( (AnimSequence == 'Walk') && (AnimFrame > 0.1) );   
		TweenAnim('Bite', tweentime);
	}
}

function TweenToRunning(float tweentime)
{
	if (bEating)
		GotoState('Swallow');
	else
	{
		if ( (AnimSequence != 'Walk') || !bAnimLoop )
			TweenAnim('Walk', tweentime);
	}
}

function TweenToWalking(float tweentime)
{
	if (bEating)
		GotoState('Swallow');
	else
		TweenAnim('Walk', tweentime);
}

function TweenToWaiting(float tweentime)
{
	TweenAnim('Breath', tweentime);
}

function TweenToPatrolStop(float tweentime)
{	
	TweenAnim('Breath', tweentime);
}

function PlayRunning()
{
	LoopAnim('Walk', -1.0/GroundSpeed,, 0.8);
}

function PlayWalking()
{
	LoopAnim('Walk', -1.0/GroundSpeed,, 0.8);
	if (FRand() < 0.5)
		PlaySound(Roam, SLOT_Talk, (0.5 + 0.5 * FRand()) * TransientSoundVolume,,VoiceRadius);
}

function PlayThreatening()
{
	if (FRand() < 0.8)
	{
		PlayAnim('Roar');
		PlaySound(Roar, SLOT_Talk,,,VoiceRadius);
	}
	else
	{
		PlaySound(Pound, SLOT_Talk,,,VoiceRadius);
		PlayAnim('Pound', 1.0, 0.2);
	}
}

function PlayTurning()
{
	if (bEndFootStep)
		FootStep();
	DesiredSpeed = 0.0;
	TweenAnim('Walk', 0.2);
}

function PlayDying(name DamageType, vector HitLocation)
{
	PlayAnim('Dead', 0.7, 0.15);
	PlaySound(Die, SLOT_Talk,,,VoiceRadius);
}

/*
function PlayTakeHit(float tweentime, vector HitLoc, int Damage)
{
	if (bEating)
	{
		NextState = 'Swallow';
		GotoState('Swallow');
	}
//	TweenAnim('Walk', tweentime);
}
*/

function SpawnRock()
{
	local Projectile Proj;
	local vector X,Y,Z, projStart;
	GetAxes(Rotation,X,Y,Z);
	
	MakeNoise(1.0);
	projStart = Location + 0.8 * CollisionRadius * X + 1.2 * CollisionHeight * Z;
	Proj = Projectile(spawn(RangedProjectile ,self,'',projStart,AdjustAim(1000, projStart, Accuracy, false, true)));

//xxx Need to change this back to BigRock when we figure out why it crashes
//	Proj = spawn(class 'DisruptorRed' ,self,'',projStart,AdjustAim(1000, projStart, 400, false, true));
//	Proj = spawn(class 'BigRock' ,self,'',projStart,AdjustAim(1000, projStart, 400, false, true));
	if( Proj != None )
	{
		Proj.SetPhysics(PHYS_Projectile);
//		Proj.DrawScale = DrawScale;
	}
	return;
	
	projStart = Location + CollisionRadius * X + 0.4 * CollisionHeight * Z;
	Proj = spawn(class 'BigRock' ,self,'',projStart,AdjustAim(1000, projStart, Accuracy, false, true));
	if( Proj != None )
		Proj.SetPhysics(PHYS_Projectile);
/*
	projStart = Location + CollisionRadius * X -  40 * Y + 0.4 * CollisionHeight * Z;
	Proj = spawn(class 'BigRock' ,self,'',projStart,AdjustAim(1000, projStart, 400, true, true));
	if( Proj != None )
		Proj.SetPhysics(PHYS_Projectile);

	if (FRand() < 0.2 * skill)
	{
		projStart = Location + CollisionRadius * X + 40 * Y + 0.4 * CollisionHeight * Z;
		Proj = spawn(class 'BigRock' ,self,'',projStart,AdjustAim(1000, projStart, 2000, false, true));
		if( Proj != None )
			Proj.SetPhysics(PHYS_Projectile);
	}
*/	
}

function PlayVictoryDance()
{
	if (bEndFootStep)
		FootStep();
	DesiredSpeed = 0.0;
	PlayAnim('Roar', 0.8, 0.2); //gib the enemy here!
	PlaySound(Roar, SLOT_Talk,,,VoiceRadius);
}

function SlashRightDamageTarget()
{
	local vector X,Y,Z;
	GetAxes(Rotation,X,Y,Z);
	
	if ( MeleeDamageTarget(SlashRightDamage, (70000.0 * ( Y + vect(0,0,1) ))) )
		PlaySound(SlashHit, SLOT_Interact,,,VoiceRadius);
}

function SlashLeftDamageTarget()
{
	local vector X,Y,Z;
	GetAxes(Rotation,X,Y,Z);
	
	if ( MeleeDamageTarget(SlashLeftDamage, (70000.0 * ( vect(0,0,1) - Y))) )
		PlaySound(SlashHit, SLOT_Interact,,,VoiceRadius);
}

function BiteDamageTarget()
{
	if ( MeleeDamageTarget(BiteDamage, (30000.0 * Normal(Target.Location - Location) )) )
		PlaySound(BiteHit, SLOT_Interact,,,VoiceRadius);
}

//Titan doesn't need to face as directly
function bool NeedToTurn(vector targ)
{
	local int YawErr;

	DesiredRotation = Rotator(targ - location);
	DesiredRotation.Yaw = DesiredRotation.Yaw & 65535;
	YawErr = (DesiredRotation.Yaw - (Rotation.Yaw & 65535)) & 65535;
	if ( (YawErr < 8000) || (YawErr > 57535) )
		return false;

	return true;
}
	
function PlayMeleeAttack()
{
	local float decision;

	if (bEndFootStep)
		FootStep();
	
	decision = FRand();
	
	if (decision < 0.4)
	{
		PlaySound(SlashRight, SLOT_Interact,,,VoiceRadius);
 		PlayAnim('SlashRight');
	}
	else if (decision < 0.8)
	{ 
		PlaySound(SlashLeft, SLOT_Interact,,,VoiceRadius);
		PlayAnim('SlashLeft'); 
	}
	else
	{
		PlaySound(Bite, SLOT_Interact,,,VoiceRadius);
		PlayAnim('Bite', 1.0);
	}
}

function PlayRangedAttack()
{
	Skin = texture 'ProjIceChunkTex1';

	if ( bEndFootStep )
		FootStep();
	if ( (AnimSequence == 'Pound') || (FRand() < 0.7) )
	{
		PlaySound(ThrowRock, SLOT_Interact,,,VoiceRadius);
		PlayAnim('Throw');
	}
	else
	{
		PlayAnim('Pound'); 
		PlaySound(Pound, SLOT_Talk,,,VoiceRadius);
	}
}


function SpawnBreath()
{
	local SmokeBreath SBF;
	local vector X,Y,Z;
	local rotator breathrot;
	
	if (bBreath && (bForceBreath || PlayerCanSeeMe()) )
	{
		GetAxes(rotation, X,Y,Z);
		Y = location + 0.8*collisionradius*X - 0.1*collisionheight*Z;

		SBF = spawn(class 'SmokeBreath', self, '', Y);
		SBF.lifespan = 0.8; 
		SBF.breathrate = 100;
		if (Breath != None)
			PlaySound(Breath, SLOT_Interact,,,VoiceRadius);
	}
}


State Swallow
{
ignores SeePlayer, HearNoise, Bump;
		
function EndState()
{
	bEating = false;
//	Skin = texture 'PawnRopedIce1';
}

Begin:
//	log(class$" is in state Swallow");	
	PlayAnim('Swallow');
	FinishAnim();
	if (Enemy != None)
		GotoState('Attacking', 'SetAttackTimer');
	else
		GotoState('Acquisition');
}

State Threatening
{
ignores falling, landed; //fixme

Begin:
	Acceleration = vect(0,0,0);
	bReadyToAttack = true;
	if (Enemy.bIsPlayer)
		Disable('SeePlayer'); //but not hear noise
	if (bEating)
	{
		PlayAnim('Swallow');
		FinishAnim();
		bEating = false;
//xxx		Skin = texture 'PawnRopedIce1';
	}
	else
	{	
		TweenToPatrolStop(0.2);
		FinishAnim();
	}
	NextAnim = '';
	
FaceEnemy:
	Acceleration = vect(0,0,0);
	if (NeedToTurn(enemy.Location))
	{	
		PlayTurning();
		TurnToward(Enemy);
		TweenToPatrolStop(0.2);
		FinishAnim();
		NextAnim = '';
	}
		
Threaten:
	if (AttitudeTo(Enemy) < ATTITUDE_Threaten)
		GotoState('Attacking');

	PlayThreatening();
	FinishAnim();

	if (AttitudeTo(Enemy) < ATTITUDE_Threaten)
		GotoState('Attacking');
		
	if (Orders == 'Guarding')
	{ //stay between enemy and guard object
		If (Enemy.bIsPlayer &&
			(VSize(Enemy.Location - OrderObject.Location) < OrderObject.CollisionRadius + 2 * CollisionRadius + MeleeRange))
		{
			AttitudeToPlayer = ATTITUDE_Hate;
			GotoState('Attacking', 'SetAttackTimer');
		}
	}
	else if (FRand() < 0.9 - Aggressiveness) //mostly just turn
		Goto('FaceEnemy');
	else if (VSize(Enemy.Location - Location) < 2.5 * (CollisionRadius + Enemy.CollisionRadius + MeleeRange))
		Goto('FaceEnemy');

	WaitForLanding();
	if (Orders == 'Guarding') //stay between enemy and guard object
		PickGuardDestination();
	else
		PickThreatenDestination();
		
	if (Destination != Location)
	{
		TweenToWalking(0.2);
		FinishAnim();
		PlayWalking();
		MoveTo(Destination, WalkingSpeed);
		Acceleration = vect(0,0,0);
		TweenToPatrolStop(0.2);
		FinishAnim();
		NextAnim = '';
	}
		
	Goto('FaceEnemy');
}

defaultproperties
{
     SlashLeftDamage=40
     SlashRightDamage=40
     BiteDamage=30
     Roar=Sound'KlingonSFX01.creature.RopedScream'
     Step=Sound'KlingonSFX01.creature.RopedFist2'
     Pound=Sound'KlingonSFX01.creature.RopedFist'
     SlashLeft=Sound'KlingonSFX01.creature.RopedSlash2'
     SlashRight=Sound'KlingonSFX01.creature.RopedSlash2'
     ThrowRock=Sound'KlingonSFX01.creature.RocRipThro'
     CarcassType=Class'Klingons.KlingonCarcass'
     TimeBetweenAttacks=2.000000
     Aggressiveness=0.500000
     RefireRate=0.300000
     WalkingSpeed=0.300000
     bHasRangedAttack=True
     bWarnTarget=False
     RangedProjectile=Class'Klingons.ProjIceChunk'
     ProjectileSpeed=1000.000000
     Acquire=Sound'KlingonSFX01.creature.RopedScream'
     Roam=Sound'KlingonSFX01.creature.BreathChal'
     bBreath=True
     Breath=Sound'KlingonSFX01.creature.BreathChal'
     SplatClass=Class'Klingons.RedBlood'
     VoiceRadius=1200.000000
     Accuracy=0.000000
     MeleeRange=70.000000
     GroundSpeed=400.000000
     AccelRate=1000.000000
     JumpZ=-1.000000
     HearingThreshold=0.700000
     Health=300
     Skill=2.000000
     Die=Sound'KlingonSFX01.creature.RopedScream'
     CombatStyle=0.400000
     Physics=PHYS_Walking
     DrawType=DT_Mesh
     Texture=None
     Skin=Texture'Klingons.ProjIceChunkTex1'
     Mesh=Mesh'Klingons.PawnRoped'
     DrawScale=4.000000
     CollisionRadius=100.000000
     CollisionHeight=105.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=4
     Mass=2000.000000
     Buoyancy=1800.000000
}
