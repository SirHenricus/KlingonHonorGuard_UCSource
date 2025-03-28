//=============================================================================
// IceFish.
//=============================================================================
class IceFish expands KlingonPawn;

#call q:\klingons\art\pawns\icefish\final\icefish.mac
#exec  MESH ORIGIN MESH=PawnIceFish X=0 Y=-180 Z=25 YAW=64

#exec MESH NOTIFY MESH=PawnIceFish SEQ=Attack1 TIME=0.44 FUNCTION=Bite1DamageTarget
#exec MESH NOTIFY MESH=PawnIceFish SEQ=Attack2 TIME=0.77 FUNCTION=Bite2DamageTarget
#exec MESH NOTIFY MESH=PawnIceFish SEQ=Attack3 TIME=0.4  FUNCTION=Bite3DamageTarget
#exec MESH NOTIFY MESH=PawnIceFish SEQ=Attack3 TIME=0.8  FUNCTION=Bite3DamageTarget
#exec MESH NOTIFY MESH=PawnIceFish SEQ=Swim    TIME=0.5  FUNCTION=SpawnBubbles
//-----------------------------------------------------------------------------
// IceFish variables.

// Attack damage.
var() byte
	Bite1Damage,
	Bite2Damage,
	Bite3Damage;

var(Sounds) sound Bite1;
var(Sounds) sound Bite2;
var(Sounds) sound Bite3;
var(Sounds) sound BiteHit;
var(Sounds) sound Turn;

//-----------------------------------------------------------------------------
// IceFish functions.

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
		//GotoState('Flopping');
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

function SetMovementPhysics()
{
	if (Region.Zone.bWaterZone)
		SetPhysics(PHYS_Swimming);
	else
	{
		SetPhysics(PHYS_Falling);
		MoveTimer = -1.0;
	//	GotoState('Flopping');
	} 
}



function PlayWaiting()
{
	LoopAnim('Swim', 0.1 + 0.3*FRand());
}

function PlayPatrolStop()
{
	LoopAnim('Swim', 0.1 + 0.3 * FRand());
}

function PlayWaitingAmbush()
{
	LoopAnim('Swim', 0.1 + 0.3 * FRand());
}

function PlayChallenge()
{
	PlayAnim('Swim', 0.4, 0.2);
}

function TweenToFighter(float tweentime)
{
	TweenAnim('Swim', tweentime);
}

function TweenToRunning(float tweentime)
{
	if ( (AnimSequence != 'Swim') || !bAnimLoop )
		TweenAnim('Swim', tweentime);
}

function TweenToWalking(float tweentime)
{
	if ( (AnimSequence != 'Swim') || !bAnimLoop )
		TweenAnim('Swim', tweentime);
}

function TweenToWaiting(float tweentime)
{
	PlayAnim('Swim', 0.2 + 0.8 * FRand(), 0.3);
}

function TweenToPatrolStop(float tweentime)
{
	TweenAnim('Swim', tweentime);
}

function PlayRunning()
{
	LoopAnim('Swim', -1.5/WaterSpeed,, 0.4);
}

function PlayWalking()
{
	LoopAnim('Swim', -1.5/WaterSpeed,, 0.4);
}

function PlayThreatening()
{
	PlayAnim('Attack2', 0.2+0.3*FRand());
}

function PlayTurning()
{
	LoopAnim('Swim', 2.5);
	PlaySound(turn, SLOT_Interact,,,VoiceRadius);
}

function PlayDying(name DamageType, vector HitLocation)
{
	PlaySound(Die, SLOT_Talk,,,VoiceRadius);
	PlayAnim('Dead', 0.7, 0.1);
	buoyancy*=1.05;
}

function PlayTakeHit(float tweentime, vector HitLoc, int damage)
{
	PlayAnim('Hit', 4/tweentime);
}

function TweenToFalling()
{
	DesiredRotation = Rotation;
	DesiredRotation.Pitch = 0;
	TweenAnim('Dead', 0.2);
}

function PlayInAir()
{
	PlayAnim('Dead', 0.7);
}

function PlayLanded(float impactVel)
{
	TweenAnim('Swim', 0.2);
}

function PlayVictoryDance()
{
	PlayAnim('Attack2', 0.6, 0.1);
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

function Bite3DamageTarget()
{
	if ( MeleeDamageTarget(Bite3Damage, (Bite3Damage * 500.0 * Normal(Target.Location - Location))) )
		PlaySound(BiteHit, SLOT_Interact,,,VoiceRadius);
}

function SpawnBubbles()
{
	local vector X,Y,Z;

	GetAxes(rotation, X,Y,Z);
	spawn(class 'WaterBubble', self, '', location + collisionradius*(0.5+0.5*FRand())*X);
}

function PlayMeleeAttack()
{
	local float decision;
	
	decision = FRand();
	if (decision < 0.4)
	{
		PlaySound(Bite1, SLOT_Interact,,,VoiceRadius);
		PlayAnim('Attack1');
	}
	else if (decision < 0.8)
	{
		PlaySound(Bite2, SLOT_Interact,,,VoiceRadius);
		PlayAnim('Attack2'); 
 	}
 	else
 	{
 		PlaySound(Bite3, SLOT_Interact,,,VoiceRadius);
 		PlayAnim('Attack1');
 	}
}

state Wandering
{
	function bool TestDirection(vector dir, out vector pick)
	{	
		local vector HitLocation, HitNormal, dist;
		local float minDist;
		local actor HitActor;

		minDist = 4*collisionradius;
		pick = dir * (minDist + (450 + 12 * CollisionRadius) * (FRand()));

		HitActor = Trace(HitLocation, HitNormal, Location + pick + 1.5 * CollisionRadius * dir , Location, false);
		if (HitActor != None)
		{
			pick = HitLocation + (HitNormal - dir) * 2 * CollisionRadius;
			HitActor = Trace(HitLocation, HitNormal, pick , Location, false);
			if (HitActor != None)
				return false;
		}
		else
			pick = Location + pick;
		 
		dist = pick - Location;
		if (Physics == PHYS_Walking)
			dist.Z = 0;
		
		return (VSize(dist) > minDist); 
	}
			
	function PickDestination()
	{
		local vector pick, pickdir;
		local bool success;
		local float XY;
		//Favor XY alignment
		XY = FRand();
		if (XY < 0.3)
		{
			pickdir.X = 1;
			pickdir.Y = 0;
		}
		else if (XY < 0.6)
		{
			pickdir.X = 0;
			pickdir.Y = 1;
		}
		else
		{
			pickdir.X = 2 * FRand() - 1;
			pickdir.Y = 2 * FRand() - 1;
		}
		if (Physics != PHYS_Walking)
		{
			pickdir.Z = 2 * FRand() - 1;
			pickdir = Normal(pickdir);
		}
		else
		{
			pickdir.Z = 0;
			if (XY >= 0.6)
				pickdir = Normal(pickdir);
		}	

		success = TestDirection(pickdir, pick);
		if (!success)
			success = TestDirection(-1 * pickdir, pick);
		
		if (success)	
			Destination = pick;
		else
			GotoState('Wandering', 'Turn');
	}
}

defaultproperties
{
     Bite1Damage=10
     Bite2Damage=10
     Bite3Damage=5
     CarcassType=Class'Klingons.KlingonCarcass'
     Aggressiveness=1.000000
     WalkingSpeed=0.200000
     ProjectileSpeed=0.000000
     SplatClass=Class'Klingons.GreenBlood'
     bCanStrafe=True
     MeleeRange=25.000000
     GroundSpeed=0.000000
     WaterSpeed=600.000000
     AirSpeed=0.000000
     AccelRate=600.000000
     SightRadius=2000.000000
     PeripheralVision=-0.500000
     Health=70
     Intelligence=BRAINS_REPTILE
     CombatStyle=1.000000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnIceFish'
     DrawScale=3.000000
     CollisionRadius=60.000000
     CollisionHeight=16.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=3
     Mass=200.000000
     Buoyancy=200.000000
     RotationRate=(Pitch=0,Yaw=13000,Roll=13000)
}
