//=============================================================================
// BirdOfPrey.
//=============================================================================
class BirdOfPrey expands KlingonPawn;

#call q:\klingons\art\missn_19\geometry\bopsimple\s-bop1.mac
#exec MESH ORIGIN MESH=PawnSmallBOP X=0 Y=0 Z=-30 YAW=0

#exec MESH NOTIFY MESH=PawnSmallBOP SEQ=StaticShoot        TIME=0.5 FUNCTION=SpawnShot


function PreSetMovement()
{
	bCanJump = true;
	bCanWalk = true;
	bCanSwim = false;
	bCanFly = true;
	bCanDuck = true;
	MinHitWall = -0.6;
	bCanOpenDoors = false;
	bCanDoSpecial = true;
}

function Tick(float delta)
{
}

function PlayWaiting()
{
	PlayAnim('StaticParked', 1.0, 0.1);
}



function PlayRangedAttack()
{
	//SpawnShot();
}

function SpawnShot()
{
	FireProjectile( vect(1.3, -0.5, 0.4), 400);
}


function SetMovementPhysics()
{
	SetPhysics(PHYS_Flying); 
}

singular function Falling()
{
	SetPhysics(PHYS_Flying);
}


function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
	// dont spawn no blood
	spawn(class 'BlackSmoke');
	if (Damage > 100)
	{
		spawn(class 'BoxShard02');
	}
}

function Bump(actor Other)
{
	if (BirdOfPrey(Other) != none)
	{
		TakeDamage( 1000, Pawn(Other), location, vect(0,0,0), 'imploded');
	}
}

function PlayDeathHit(float Damage, vector HitLocation, name damageType)
{
	spawn(class 'AirExplosion3');
	spawn(class 'ParticleExplosion');
}


function damageAttitudeTo(pawn Other)
{
	return;
}


state Hunting
{
}

state Attacking
{
}


state Acquisition
{
}


State TacticalMove
{
}

defaultproperties
{
     RangedProjectile=Class'Klingons.DisruptorRed'
     JumpZ=0.000000
     SightRadius=0.000000
     HearingThreshold=0.000000
     FovAngle=0.000000
     Health=700
     AttitudeToPlayer=ATTITUDE_Ignore
     Intelligence=BRAINS_HUMAN
     AnimSequence=StaticFlight
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnSmallBOP'
     DrawScale=3.000000
     CollisionRadius=40.000000
     CollisionHeight=40.000000
     Mass=1000.000000
     RotationRate=(Yaw=10000)
}
