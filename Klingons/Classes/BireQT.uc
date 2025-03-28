//=============================================================================
// BireQT.
//=============================================================================
class BireQT expands KlingonPawn;

#call q:\klingons\art\pawns\BireQT\final\BireQT.mac
#exec MESH NOTIFY MESH=PawnBireQT SEQ=Bite1       TIME=0.5  FUNCTION=Bite1DamageTarget
#exec MESH NOTIFY MESH=PawnBireQT SEQ=Bite2       TIME=0.5  FUNCTION=Bite2DamageTarget
#exec MESH NOTIFY MESH=PawnBireQT SEQ=BiteCombo   TIME=0.25 FUNCTION=Bite1DamageTarget
#exec MESH NOTIFY MESH=PawnBireQT SEQ=BiteCombo   TIME=0.75 FUNCTION=Bite2DamageTarget

//-----------------------------------------------------------------------------
// BireQT variables.

// Attack damage.
var() byte
	Bite1Damage,
	Bite2Damage;

var(Sounds) sound Bite1;
var(Sounds) sound Bite2;
var(Sounds) sound BiteHit;
var(Sounds) sound Turn;

var vector Jumpvect;
//-----------------------------------------------------------------------------
// BireQT functions.

function ZoneChange(ZoneInfo newZone)
{
	if ( newZone.bWaterZone )
	{
		if (Physics != PHYS_Swimming)
			setPhysics(PHYS_Swimming);
	}
	else if (Physics == PHYS_Swimming)
	{
		SetPhysics(PHYS_Falling);
		MoveTimer = -1.0;
		GotoState('Flopping');
		
	}
}

function PreSetMovement()
{
	MaxDesiredSpeed = 1.0;
	bCanJump = true;
	bCanWalk = false;
	bCanSwim = true;
	bCanFly = false;
	MinHitWall = -0.6;
	bCanOpenDoors = false;
	bCanDoSpecial = false;
}

function SetFall()
{
	if (Enemy != None)
	{
		NextState = 'Attacking'; //default
		NextLabel = 'Begin';
		NextAnim = 'Swim1';

		GotoState('FallingState');
	}
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
					Vector momentum, name damageType)
{
	if (DamageType == 'Suffocated')
		return;
	Super.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType);
}

function SetMovementPhysics()
{
	if (Region.Zone.bWaterZone)
		SetPhysics(PHYS_Swimming);
	else
	{
		SetPhysics(PHYS_Falling);
		MoveTimer = -1.0;
		GotoState('Flopping');
	} 
}

function TweenToCommand(float Tweentime)
{
}

function PlayCommand()
{
}


function PlayWaiting()
{
	LoopAnim('Swim1', 0.1 + 0.3*FRand(),0.1);
}

function PlayPatrolStop()
{
	LoopAnim('Swim1', 0.1 + 0.3 * FRand(),0.1);
}

function PlayWaitingAmbush()
{
	LoopAnim('Swim1', 0.1 + 0.3 * FRand(),0.1);
}

function PlayChallenge()
{
	PlayAnim('Swim1', 0.4, 0.2);
}

function TweenToFighter(float tweentime)
{
	TweenAnim('Swim1', tweentime);
}

function TweenToRunning(float tweentime)
{
	if ( (AnimSequence != 'Swim1') || !bAnimLoop )
		TweenAnim('Swim1', tweentime);
}

function TweenToWalking(float tweentime)
{
	if ( (AnimSequence != 'Swim1') || !bAnimLoop )
		TweenAnim('Swim1', tweentime);
}

function TweenToWaiting(float tweentime)
{
	PlayAnim('Swim1', 0.2 + 0.8 * FRand(), 0.3);
}

function TweenToPatrolStop(float tweentime)
{
	TweenAnim('Swim1', tweentime);
}

function PlayRunning()
{
	LoopAnim('Swim1', -1.5/WaterSpeed,, 0.4);
}

function PlayWalking()
{
	LoopAnim('Swim1', -1.5/WaterSpeed,, 0.4);
}

function PlayThreatening()
{
	PlayAnim('BiteCombo',,0.1);
}

function PlayTurning()
{
	PlaySound(turn, SLOT_Interact,,,VoiceRadius);
	LoopAnim('Swim1', 1.2,0.1);
}

function PlayDying(name DamageType, vector HitLocation)
{
	PlaySound(Die, SLOT_Talk,,,VoiceRadius);
	PlayAnim('Death1', 0.7, 0.1);
	buoyancy*=1.05;
}

function PlayTakeHit(float tweentime, vector HitLoc, int damage)
{
	PlayAnim('GetHit1', 2/tweentime,0.1);
}

function TweenToFalling()
{
	DesiredRotation = Rotation;
	DesiredRotation.Pitch = 0;
	TweenAnim('Death1', 0.2);
}

function PlayInAir()
{
	PlayAnim('Death1', 0.7,0.1);
}

function PlayLanded(float impactVel)
{
	TweenAnim('Swim1', 0.2);
}

function PlayVictoryDance()
{
	PlayAnim('BiteCombo', 0.6, 0.1);
	PlaySound(Bite1, SLOT_Interact,,,VoiceRadius);
}


function Bite1DamageTarget()
{
	if ( MeleeDamageTarget(Bite1Damage, (Bite1Damage * 500.0 * Normal(Location - Target.Location))) )
		PlaySound(BiteHit, SLOT_Interact,,,VoiceRadius);
}

function Bite2DamageTarget()
{
	if ( MeleeDamageTarget(Bite2Damage, (Bite2Damage * 500.0 * Normal(Target.Location - Location))) )
		PlaySound(BiteHit, SLOT_Interact,,,VoiceRadius);
}

function PlayMeleeAttack()
{
	local float decision;
	
	decision = FRand();
	if (decision < 0.5)
	{
		PlaySound(Bite1, SLOT_Interact,,,VoiceRadius);
		PlayAnim('Bite1',,0.1);
	}
	else 
	{
		PlaySound(Bite2, SLOT_Interact,,,VoiceRadius);
		PlayAnim('Bite2',,0.1); 
 	}
}


state Flopping
{
function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
					Vector momentum, name damageType)
{
	if (DamageType == 'Suffocated')
		return;
	Super.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType);
	if (Health > 0)
		GotoState('Flopping');
}

function Timer()
{
	TakeDamage(3,self,self.location,vect(0,0,0),'Suicide');
}

function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
	if (Momentum != vect(0,0,0))
		Super.SpawnBlood(Damage,HitLocation,Momentum);
		
}

Begin:
	SetTimer(3.0, true);
	
FlopAround:
	if (Region.Zone.bWaterZone)
		GotoState('Attacking');

	if (Frand() < 0.1)
	{
		PlayMeleeAttack();
	}
	else
	{
		PlayWalking();
	}		
	FinishAnim();
//	Health -= 2;
	if (Frand() < (Health / Default.Health))
	{
		PlayAnim('GetHit1', 1.5,0.1);
		JumpVect = VRand() * 200;
		if (JumpVect.Z < 0)
			JumpVect.Z = -JumpVect.Z;
		AddVelocity(JumpVect);
		DesiredRotation = Rotator(VRand());
		DesiredRotation.Pitch = 0;

		FinishAnim();
//		Velocity = VRand() * 300;
//		Velocity.Z = 500;
	}
	Goto('FlopAround');
		
}

defaultproperties
{
     Bite1Damage=6
     Bite2Damage=6
     Bite1=Sound'KlingonSFX01.creature.bregitbite1'
     Bite2=Sound'KlingonSFX01.creature.bregitbite2'
     CarcassType=Class'Klingons.BireQTCarcass'
     Aggressiveness=1.000000
     WalkingSpeed=0.200000
     ProjectileSpeed=0.000000
     Roam=Sound'KlingonSFX01.creature.bregitswim'
     SplatClass=Class'Klingons.GreenBlood'
     bCanStrafe=True
     MeleeRange=25.000000
     GroundSpeed=0.000000
     WaterSpeed=600.000000
     AirSpeed=0.000000
     AccelRate=600.000000
     SightRadius=2000.000000
     PeripheralVision=-0.500000
     Health=40
     Die=Sound'KlingonSFX01.creature.bregitdies'
     CombatStyle=1.000000
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnBireQt'
     CollisionRadius=24.000000
     CollisionHeight=12.000000
     Mass=120.000000
     Buoyancy=120.000000
     RotationRate=(Pitch=13000,Roll=13000)
}
