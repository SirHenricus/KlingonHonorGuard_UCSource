//=============================================================================
// CargoShip.
//=============================================================================
class CargoShip expands KlingonPawn;

#call q:\klingons\art\missn_07\geometry\actors\cargoship\final\cargoship.mac
#exec MESH ORIGIN MESH=PawnCargoShip X=0 Y=0 Z=-30 YAW=64


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

function PlayDeathHit(float Damage, vector HitLocation, name damageType)
{
	spawn(class 'AirExplosion3');
	spawn(class 'ParticleExplosion');
}


function damageAttitudeTo(pawn Other)
{
	return;
}



function PlayGutHit(float tweentime)
{
	PlayAnim('Pickup', 0.1, 0.1);
}

function PlayHeadHit(float tweentime)
{
	PlayAnim('Pickup', 0.1, 0.1);

}

function PlayLeftHit(float tweentime)
{
	PlayAnim('Pickup', 0.1, 0.1);
}

function PlayRightHit(float tweentime)
{
	PlayAnim('Pickup', 0.1, 0.1);
}



state Hunting
{
Begin:
}

state Attacking
{
Begin:
}


state Acquisition
{
Begin:
}


State TacticalMove
{
Begin:
}

State Roaming
{
Begin:
}


State Wandering
{
Begin:
}


State TakeHit
{
Begin:
}

defaultproperties
{
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnCargoShip'
}
