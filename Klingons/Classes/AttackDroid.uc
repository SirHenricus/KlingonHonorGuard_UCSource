//=============================================================================
// AttackDroid.
//=============================================================================
class AttackDroid expands KlingonPawn;

#alwayscall q:\klingons\art\pawns\attackd3\final\attackd3.mac
#Alwaysexec MESH ORIGIN MESH=PawnAttackDroid X=0 Y=0 Z=170 YAW=64

#exec MESH NOTIFY MESH=PawnAttackDroid SEQ=FireBig  TIME=0.1 FUNCTION=SpawnTwoShots

var float lastsmokepuff;

//XXXXX
//Try to duck??
//Need floating stationary anim
//Deaths/twitching needs to occur in place

function PreSetMovement()
{
	bCanJump = true;
	bCanWalk = true;
	bCanSwim = false;
	bCanFly = true;
	bCanDuck = true;
	MinHitWall = -0.6;
	bCanOpenDoors = true;
	bCanDoSpecial = true;
}

function Tick(float delta)
{
	if (Health < (default.health * 0.3))
	{
		LastSmokePuff += Delta;
		if (LastSmokePuff > 0.3)
		{
			spawn(class 'BlackSmoke2');
			LastSmokePuff = 0;
		}
	}
	
	if (SpecialDeath == 3)
	{
		SetRotation(Rotation + RotationRate);
	}
	if (AmbientGlow - 5 > 0)
	{
		AmbientGlow -= 5;
	}
	if (LightBrightness-5  > 0)
	{
		LightBrightness-=5;

	}
	
}


function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	if (damageType == 'suffocated')
		return;
		
	super.TakeDamage(Damage,instigatedBy,hitlocation,momentum,damageType);
}


//XXX Testing
function TryToDuck(vector duckDir, bool bReversed)
{
	local vector HitLocation, HitNormal, Extent;
	local actor HitActor;
			
	if ( (Skill == 0) && (FRand() < 0.5) )
		DuckDir *= -1;	

	Extent.X = CollisionRadius;
	Extent.Y = CollisionRadius;
	Extent.Z = CollisionHeight;
	HitActor = Trace(HitLocation, HitNormal, Location + 100 * duckDir, Location, false, Extent);
	if (HitActor != None)
	{
		duckDir *= -1;
		HitActor = Trace(HitLocation, HitNormal, Location + 100 * duckDir, Location, false, Extent);
	}
	if (HitActor != None)
		return;

	Destination = Location + 150 * duckDir;
	Velocity = 400 * duckDir;
	AirSpeed *= 2.5;
	GotoState('TacticalMove', 'DoMove');
}	

function SetMovementPhysics()
{
	SetPhysics(PHYS_Flying); 
}

singular function Falling()
{
	SetPhysics(PHYS_Flying);
}

function PlayWaiting()
{
	TweenAnim('Deactivated',0.7);
//	LoopAnim('Search', 0.4+0.4*FRand());
}

function PlayPatrolStop()
{
	LoopAnim('Search', 0.4+0.4*FRand());

//	PlayWaiting();
}

function PlayWaitingAmbush()
{

	LoopAnim('Search', 0.4+0.4*FRand());

//	PlayWaiting();
}

function TweenToFighter(float tweentime)
{

//	TweenAnim('Static', tweentime);
}

function TweenToRunning(float tweentime)
{
	if (AnimSequence == 'Deactivated')
	{
//		PlayAnim('Transform',0.1,0.4);
		return;
	}
	if ( (AnimSequence == 'FireBig') && IsAnimating() )
		return;
	if ( (AnimSequence != 'Static') || !bAnimLoop )
		TweenAnim('Static', 4);
}

function TweenToWalking(float tweentime)
{

	if ( (AnimSequence != 'Static') || !bAnimLoop )
		TweenAnim('Static', 4);
}

function TweenToWaiting(float tweentime)
{

	TweenAnim('Search', tweentime);
}

function TweenToPatrolStop(float tweentime)
{

	TweenAnim('Search', tweentime);
}

function PlayRunning()
{
	if (AnimSequence == 'Deactivated')
	{
		PlayAnim('Transform',0.3,0.4);
		return;
	}


	LoopAnim('Search',1.0,0.8);

//	TweenAnim('Static', 1.0);
}

function PlayWalking()
{
//	TweenAnim('Static', 1.0);
	LoopAnim('Search',1.0,0.8);
}


function PlayThreatening()
{

//	TweenAnim('Static', 0.2);
	TweenAnim('Transform',2.0);

}

function PlayTurning()
{

	TweenAnim('Static', 0.3);
}

function PlayDying(name DamageType, vector HitLocation)
{
	PlaySound(Die, SLOT_Talk,,,VoiceRadius);
	PlayAnim('Destroyed', 0.7, 0.1);
}

function PlayTakeHit(float tweentime, vector HitLoc, int damage)
{
	if (Frand() < 0.5)
		PlayAnim('HitLeft', 2/tweentime);
	else
		PlayAnim('HitRight', 2/tweentime);
}

function TweenToFalling()
{

	TweenAnim('Static', 0.2);
}

function PlayInAir()
{

	TweenAnim('Static', 0.5);
}

function PlayLanded(float impactVel)
{
	TweenAnim('Static', 0.5);
}

function PlayVictoryDance()
{
	PlayAnim('Search', 0.6, 0.1);		
}

function PlayRangedAttack()
{

	PlayAnim('FireBig');
}

function SpawnTwoShots()
{
	FireProjectile( vect(0.9, 0.8, 0.4), Accuracy);
	FireProjectile( vect(0.9, -0.8, 0.4), Accuracy);	
}

function PlayMovingAttack()
{
	PlayAnim('FireBig');
}

// Robots dont spawn blood, but we can use it to sawn sparks or something
function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
	spawn(class 'WhiteSmoke1');
}



/*function Carcass SpawnCarcass()
/{
	local Klingoncarcass carc;
	
	carc = Spawn(CarcassType);
	if ( carc != None )
	{
		carc.Initfor(self);
		carc.ChunkUp(-1 * Health);		
	}

	return carc;
}
*/

State TacticalMove
{
ignores SeePlayer, HearNoise;

	function EndState()
	{
		AirSpeed = Default.AirSpeed;
		Super.EndState();
	}
}

defaultproperties
{
     CarcassType=Class'Klingons.DroidCarcass'
     TimeBetweenAttacks=5.000000
     RefireRate=0.200000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     RangedProjectile=Class'Klingons.RocketProjectile'
     ProjectileSpeed=1200.000000
     Acquire=Sound'KlingonSFX01.creature.DroidActivate'
     DodgeAmount=0.050000
     Accuracy=200.000000
     bCanStrafe=True
     AirSpeed=200.000000
     Health=40
     Intelligence=BRAINS_HUMAN
     HitSound1=Sound'KlingonSFX01.creature.DroidHitR'
     HitSound2=Sound'KlingonSFX01.creature.DroidHitL'
     Die=Sound'KlingonSFX01.creature.DroidHitBig'
     Physics=PHYS_Flying
     AnimSequence=DeActivated
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnAttackDroid'
     DrawScale=2.500000
     CollisionRadius=40.000000
     CollisionHeight=40.000000
}
