//=============================================================================
// SentryGunTop.
//=============================================================================
class SentryGunTop expands KlingonPawn;

#call q:\klingons\art\pawns\sentry1\character\final\sentryguntop.mac
#exec MESH ORIGIN MESH=PawnSentryGunTop X=0 Y=0 Z=177 YAW=0

//-----------------------------------------------------------------------------
// Tentacle functions.
//
var bool bActive;
var bool bFromInventory;
var PlayerPawn InventoryOwner;

function PostBeginPlay()
{
	local Rotator Rot;
	
	Rot = Rotation;
	Rot.Pitch = 0;
	Rot.Roll = 0;
	SetRotation(Rot);
}

function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
	spawn(class 'Spark1');
}


function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	if (damageType == 'suffocated')
		return;
		
	super.TakeDamage(Damage,instigatedBy,hitlocation,momentum,damageType);
}



function WhatToDoNext(name LikelyState, name LikelyLabel)
{
	bQuiet = false;
	GotoState('Waiting');
}

function AnnoyedBy(Pawn Other)
{
}

function eAttitude AttitudeTo(Pawn Other)
{
	if (Other.bIsPlayer)
	{
		if (bFromInventory && Other == InventoryOwner)
			return ATTITUDE_Friendly;
		else
			return ATTITUDE_Hate;
	}
	else 
		return AttitudeToCreature(Other);
}

function eAttitude AttitudeToCreature(Pawn Other)
{
	if (bFromInventory && KlingonPawn(Other).AttitudeTo(InventoryOwner) < ATTITUDE_Ignore)
		return ATTITUDE_Hate;
	else
		return ATTITUDE_Friendly;
}

simulated function ClientAddVelocity( vector NewVelocity )
{
	if (Physics == PHYS_Rotating)
		Velocity = vect(0,0,0);
	else
		Velocity += NewVelocity;
}

function PreSetMovement()
{
	bCanJump = false;
	bCanWalk = false;
	bCanSwim = true;
	bCanFly = false;
	MinHitWall = -0.85;
	bCanOpenDoors = false;
	bCanDoSpecial = false;
}

function SetMovementPhysics()
{
	if (Region.Zone.bWaterZone)
		SetPhysics(PHYS_Swimming);
	else
		SetPhysics(PHYS_Rotating); 
}

function bool SetEnemy( Pawn NewEnemy )
{
	local bool temp;
	
	bCanWalk = true; //even though can't move, still acquire enemies
//	log(class$"PreSetEnemy Attitude = "$AttitudeToPlayer);
//	log(class$"NewEnemy = "$NewEnemy);
	if (NewEnemy != InventoryOwner)
		temp = Super.SetEnemy(NewEnemy);
//	log(class$"PreSetEnemy Attitude = "$AttitudeToPlayer);
	bCanWalk = false;
	
//	if (temp)
//		log(class$"Acquired Enemy = "$NewEnemy);
	return temp;
}

function Drop()
{
	//implemented in TentacleCarcass
}

singular function Falling()
{
	SetMovementPhysics();
}

function PlayWaiting()
{
	if (bActive)
		TweenAnim('Static', 2.0);
	else
		TweenAnim('Closed', 2.0);
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
	if (bActive)
		TweenAnim('Static', 1.0);
	else
		TweenAnim('Closed', 1.0);
}

function TweenToFighter(float tweentime)
{
	if (bActive)
		TweenAnim('Static', tweentime);
	else
		GotoState('Transforming');
}

function TweenToRunning(float tweentime)
{
	if (bActive)
		TweenAnim('Static', tweentime);
	else
		TweenAnim('Closed', tweentime);
}

function TweenToWalking(float tweentime)
{
	if (bActive)
		TweenAnim('Static', tweentime);
	else
		TweenAnim('Closed', tweentime);
}

function TweenToWaiting(float tweentime)
{
	if (bActive)
		TweenAnim('Static', tweentime);
	else
		TweenAnim('Closed', tweentime);
}

function TweenToPatrolStop(float tweentime)
{
	if (bActive)
		TweenAnim('Static', tweentime);
	else
		TweenAnim('Closed', tweentime);
}

function PlayRunning()
{
	if (bActive)
		TweenAnim('Static', 1.0);
	else
		GotoState('Transforming');
}

function PlayWalking()
{
	if (bActive)
		TweenAnim('Static', 1.0);
	else
		GotoState('Transforming');
}

function PlayThreatening()
{
	if ( FRand() < 0.8 )
		PlayAnim('Waver', 0.4);
	else
		PlayAnim('Smack', 0.4);
}

function PlayTurning()
{
	if (bActive)
		TweenAnim('Static', 1.0);
}

function PlayDying(name DamageType, vector HitLocation)
{
	local vector NewVel;
	
	NewVel = 400*VRand();
	if (NewVel.z < 200)
		NewVel.z = 500*FRand();
	NewVel.z *= 2.0;
	Velocity += NewVel;
	
	PlaySound(Die, SLOT_Talk,,,VoiceRadius);
	
	if (owner != none)
		owner.Destroy();
}

function PlayTakeHit(float tweentime, vector HitLoc, int Damage)
{
	if (bActive)
		TweenAnim('Static', tweentime);
	else
	{
		NextState = 'Transforming';
		GotoState('Transforming');
	}
}

function TweenToFalling()
{
	TweenAnim('Closed', 1.0);
}

function PlayInAir()
{
	TweenAnim('Closed', 0.5);
}

function PlayLanded(float impactVel)
{
	TweenAnim('Closed', 0.5);
}


function PlayVictoryDance()
{
	TweenAnim('Static', 0.5);
}

function PlayRangedAttack()
{
	FireProjectile( vect(1.2, 0.0, 0.5), 200);	
	PlayAnim('Shoot');
}


state Attacking
{
ignores SeePlayer, HearNoise, Bump, HitWall;

	function ChooseAttackMode()
	{
		if (Physics == PHYS_Swimming)
		{
			Super.ChooseAttackMode();
			return;
		}
			
		if ((Enemy == None) || (Enemy.Health <= 0))
		{
			if ((OldEnemy != None) && (OldEnemy.Health > 0)) 
				{
				Enemy = OldEnemy;
				OldEnemy = None;
				}
			else
			{
				 GotoState('Waiting');
				 return;
			}
		}
			
		if (!LineOfSightTo(Enemy))
			GotoState('Waiting');
		else
			GotoState('RangedAttack');
	}
}


state Acquisition
{
 
PlayOut:
	FinishAnim();
		
Begin:
//	GotoState('Attacking', 'SetAttackTimer');
	GotoState('Attacking');

}

State Waiting
{
	function EndState()
	{
		RotationRate = default.RotationRate;
	}

	function ChooseFocus()
	{
		DesiredRotation = rotation;
		DesiredRotation.yaw += Rand(16384) - Rand(16384);
		DesiredRotation.yaw = DesiredRotation.yaw & 65535;
		Focus = location + vector(DesiredRotation);
	}
	
	function FindEnemy()
	{
		local Pawn P;
		local vector X,Y,Z;
			
		GetAxes(rotation, X,Y,Z);
		foreach VisibleActors(class 'Pawn', P, SightRadius)
		{
			if ((!P.IsA('SentryGunBase')) && (P.AttitudeToPlayer != ATTITUDE_Friendly))
			{
//				log(P.Class$" is in visible actors");
//				log(P.Class$" attitudetoplayer is "$P.AttitudeToPlayer);
				Y = P.location - location;
				Y.z = X.z;
				Y = normal(Y);
				if (Y dot X > 0.7)
					if (SetEnemy(P))
						return;
			}
		}
	}
	
Begin:
	TweenToWaiting(0.4);
	bReadyToAttack = false;
	
LookAround:
	ChooseFocus();
	RotationRate.yaw = 5000+5000*FRand();
	TurnTo(focus);
Sleep:
	if (AttitudeToPlayer == ATTITUDE_Friendly)
		FindEnemy();
	Sleep(2.0+2.0*FRand());
		Goto('LookAround');
}

State InActive expands Waiting
{
ignores SeePlayer, Bump;

Begin:
//	log(class$" in state Inactive");
}

State Transforming
{
ignores SeePlayer, HearNoise, Bump;

function BeginState()
{
	local Rotator Rate;
	
	Rate.yaw = 0;
	Rate.Pitch = 0;
	Rate.Roll = 0;
	RotationRate = Rate;
}

function EndState()
{
	RotationRate = default.RotationRate;
}

Transform:
	FinishAnim();
	bActive = true;
	if (Enemy != None)
		GotoState('Attacking', 'SetAttackTimer');
	else
		GotoState('Waiting');		
Begin:
//	log(class$" is in state Transforming");	
	if ((owner != None) && (SentryGunBase(owner) != None))
		SentryGunBase(owner).PlayTransformation();
}

defaultproperties
{
     CarcassType=Class'Klingons.SentryTopCarcass'
     Aggressiveness=1.000000
     RefireRate=0.700000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bIgnoreFriends=True
     RangedProjectile=Class'Klingons.DisruptorRed'
     ProjectileSpeed=1000.000000
     Accuracy=0.000000
     WaterSpeed=100.000000
     AccelRate=100.000000
     JumpZ=10.000000
     PeripheralVision=-0.500000
     Health=200
     UnderWaterTime=1.000000
     Intelligence=BRAINS_HUMAN
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnSentryGunTop'
     CollisionRadius=9.000000
     CollisionHeight=12.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=1
     RotationRate=(Pitch=0,Yaw=30000,Roll=0)
}
