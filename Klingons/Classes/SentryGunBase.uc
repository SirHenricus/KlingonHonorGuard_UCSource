//=============================================================================
// SentryGunBase.
//=============================================================================
class SentryGunBase expands KlingonPawn;

#call q:\klingons\art\pawns\sentry1\character\final\sentrygunbase.mac
#exec MESH ORIGIN MESH=PawnSentryGunBase X=0 Y=0 Z=60 YAW=64

#exec MESH NOTIFY MESH=PawnSentryGunBase SEQ=Transform TIME=0.375 FUNCTION=TransformTop

var SentryGunTop	Top;
var bool 	bFromInventory;

function PostBeginPlay()
{
	TweenAnim('Closed', 0.1);
	Top = spawn(class 'SentryGunTop', self, '', location+(collisionheight + 12)*vect(0,0,1));
	Top.SetPhysics(PHYS_Rotating);
	Top.Health = Health;
	Top.bActive = false;
	if (Orders == 'InActive')
		Top.Orders = Orders;
	else
		Top.Orders = 'Transforming';
		
	bFromInventory = (PlayerPawn(Owner) != None);
	Top.bFromInventory = bFromInventory;
	if (bFromInventory)
	{
		Top.InventoryOwner = PlayerPawn(Owner);
		Top.AttitudeToPlayer = ATTITUDE_Friendly;
		AttitudeToPlayer = ATTITUDE_Friendly;
	}
	Super.PostBeginPlay();
}

function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
	spawn(class 'Spark1');
}


function TransformTop()
{
//	log(class$"in transform top");
	if (Top != None)
	{
		Top.PlayAnim('Transform', 0.85);
		Top.GotoState('Transforming', 'Transform');
	}
}

function PlayTransformation()
{
	PlayAnim('Transform', 1.0);
}

function WhatToDoNext(name LikelyState, name LikelyLabel)
{
	bQuiet = false;
	GotoState('Waiting');
}

function eAttitude AttitudeTo(Pawn Other)
{
	if (Top != None)
		return Top.AttitudeTo(Other);
	else
		return ATTITUDE_Ignore;
}

function eAttitude AttitudeToCreature(Pawn Other)
{
	if (Top != None)
		return Top.AttitudeToCreature(Other);
	else
		return ATTITUDE_Ignore;
}

function AnnoyedBy(Pawn Other)
{
}

function bool SetEnemy( Pawn NewEnemy )
{
	return false;
}

simulated function ClientAddVelocity( vector NewVelocity )
{
	Velocity = vect(0,0,0);
}

function PreSetMovement()
{
	bCanJump = false;
	bCanWalk = false;
	bCanSwim = false;
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
		SetPhysics(PHYS_None); 
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
							Vector momentum, name damageType) 
{	
	if (Physics == PHYS_None)
		SetMovementPhysics();

	if (CarriedDecoration != None)
		DropDecoration();
		
	MakeNoise(1.0); 	

//xxx	if (Top != None)
//xxx		Top.Damage(Damage, instigatedBy, hitlocation, momentum, damageType);
}

function Destroyed()
{
	Spawn(class 'GroundExplosion1');
}

state TakeHit 
{
ignores seeplayer, hearnoise, bump, hitwall;

Begin:
	Acceleration = vect(0,0,0);
	Sleep(0.5);
	if (Physics == PHYS_Falling)
	{
		NextAnim = '';
		GotoState('FallingState', 'Ducking');
	}
	else if (NextState != '')
		GotoState(NextState, NextLabel);
	else
		GotoState('Waiting');	
}

defaultproperties
{
     CarcassType=Class'Klingons.KlingonCarcass'
     bIgnoreFriends=True
     Acquire=Sound'KlingonSFX01.creature.sentryactivate'
     VoiceRadius=0.000000
     Accuracy=0.000000
     Health=40
     AttitudeToPlayer=ATTITUDE_Ignore
     Intelligence=BRAINS_NONE
     Die=Sound'KlingonSFX01.creature.SentryTwitch2'
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnSentryGunBase'
     CollisionRadius=14.000000
     CollisionHeight=9.000000
     bBlockActors=False
}
