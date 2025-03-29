//=============================================================================
// Tarchop.
//=============================================================================
class Tarchop expands KlingonPawn;

#call q:\klingons\art\pawns\Tarchop\final\Tarchop.mac
#exec MESH ORIGIN MESH=PawnTarchop X=-0 Y=0 Z=-10 YAW=64

//#exec MESH NOTIFY MESH=PawnTarchop SEQ=tail TIME=0.5 FUNCTION=tailDamageTarget
#exec MESH NOTIFY MESH=PawnTarchop SEQ=sting TIME=0.5 FUNCTION=tailDamageTarget


var(Sounds)  sound tailStrike;
var(Sounds)  sound tailHit;
var(AI)		 byte   tailDamage;
var NavigationPoint retreatDest;

function PreSetMovement()
{
	WalkingSpeed = 0.5;
	bCanJump = true;
	bCanWalk = true;
	bCanSwim = false;
	bCanFly = false;
	bCanDuck = false;
	MinHitWall = -0.75;
	if (Intelligence > BRAINS_Reptile)
		bCanOpenDoors = true;
	if (Intelligence == BRAINS_Human)
		bCanDoSpecial = true;
		

}

function eAttitude AttitudeToCreature(Pawn Other)
{
	if (HateThisSide != 'none')
	{
		if (KlingonPawn(Other) != none)
		{
			if (KlingonPawn(Other).MySide == HateThisSide)
				return ATTITUDE_Hate;
		}
	}
	
	return ATTITUDE_Friendly;
}

function tailDamageTarget()
{
	if ( MeleeDamageTarget(tailDamage, (10 * 100 * Normal(Target.Location - Location))) ); 
		PlaySound(tailHit, SLOT_Interact, /*volume*/,,VoiceRadius,/*pitch*/);
}

function TryToDuck(vector DuckDir, bool bReversed)
{
	return;
}

function SetMovementPhysics()
{
	if (Enemy != None && Enemy.Physics != PHYS_Spider)
		SetPhysics(PHYS_Walking); 
	else
		SetPhysics(PHYS_Spider);
}

function PlayWaiting()
{
	local float decision;
	
	decision = FRand();
	
	if (AnimSequence == 'WaitIdle')
	{
		if (decision < 0.6)
			PlayAnim('WaitIdle', 0.3+Frand());
		else if (decision < 0.75 && Floor.z > 0.7 )
			PlayAnim('WaitJump');
		else
		{
			PlayAnim('WaitLook', 0.5+0.5*FRand());
		}
	}
	else if (AnimSequence == 'WaitLook')
	{
		if (decision < 0.25 && Floor.z > 0.7)
			PlayAnim('WaitJump');
		else
			PlayAnim('WaitIdle', 0.3+FRand());
	}
	else if (AnimSequence == 'WaitJump')
	{
		if (decision < 0.25 && Floor.z > 0.7)
			PlayAnim('WaitJump');
		else if (decision < 0.5)
			PlayAnim('WaitLook', 0.5+0.5*FRand());
		else
			PlayAnim('WaitIdle', 0.3+FRand());
	}
	else 
		LoopAnim('WaitIdle', 0.3+FRand());
}

function PlayPatrolStop()
{
	PlayWaiting();
}

function PlayWaitingAmbush()
{
	PlayWaiting();
}

function PlayFighter()
{
	PlayAnim('WaitIdle', 2.0);
}

function TweenToFighter(float tweentime)
{
	TweenAnim('WaitIdle', tweentime);
}

function TweenToRunning(float tweentime)
{
	if ( (AnimSequence != 'Walk') || !bAnimLoop )
		TweenAnim('Walk', tweentime);
}

function TweenToWalking(float tweentime)
{
	TweenToRunning(tweentime);
}

function TweenToWaiting(float tweentime)
{
	TweenAnim('WaitIdle', tweentime);
}

function TweenToPatrolStop(float tweentime)
{
	TweenToWaiting(tweentime);
}

function PlayRunning()
{
	if (Enemy == None || FRand() < 0.5)
		LoopAnim('Walk', -5.0/GroundSpeed,, 0.4);
	else
		LoopAnim('WalkMad', -5.0/GroundSpeed,, 0.4);
}

function PlayWalking()
{
	LoopAnim('Walk', -5.0/GroundSpeed,, 0.4);
}


function PlayThreatening()
{
	PlayAnim('Sting');
}

function PlayTurning()
{
	LoopAnim('Walk');
}


function PlayDying(name DamageType, vector HitLocation)
{
	PlaySound(Die, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
	if (Frand() < 0.3)
		PlayAnim('Dead', 0.7, 0.0);
	else if (FRand() < 0.7)
		PlayAnim('BlownUp',0.7,0.0);
	else
		PlayAnim('DeadWhither',0.7,0.1);


}

/*
function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
	local int i;
	local BloodSplat b;
	local Rotator rot;
	
	rot = Rotator(HitLocation - location);
	rot.pitch = max(min(Rot.Pitch,4000),-4000);
	for (i=min(Damage,40); i > 0; i-=10)
	{
		rot.roll = Rand(65536);
		b = Spawn(class 'BloodSplat', self, '', HitLocation, rot);
		b.DrawScale = 0.3+0.3*FRand();
//		b.Skin = texture 'EffectABloodTex1';
	}
}
*/

//xxx need take hit animation
function PlayTakeHit(float tweentime, vector HitLoc, int damage)
{
	TweenAnim('Walk', tweentime);
}

function TweenToFalling()
{
	TweenAnim('Walk', 0.2);
}

function PlayInAir()
{
	LoopAnim('Walk', 0.4);
}

function PlayLanded(float impactVel)
{
	TweenAnim('Walk', 0.3);
}

function PlayVictoryDance()
{
	PlayAnim('WaitJump', 1.0);
}
	
function PlayMeleeAttack()
{
	PlaySound(tailStrike, SLOT_Interact, /*volume*/,,VoiceRadius,/*pitch*/);
	PlayAnim('Sting');
}

function SetFall()
{
	log("Set fall needs to be subclassed for "$self);
	if (Enemy != None)
	{
		NextState = 'Attacking'; //default
		NextLabel = 'Begin';
		NextAnim = 'WaitIdle';

		GotoState('FallingState');
	}
}


state Roaming
{
	function bool TryPick(vector DestDir)
	{
		local actor HitActor;
		local vector HitNormal, HitLocation;

//		log("In tryPick "$DestDir);
		if (Floor != vect(0,0,0))
			Destination = Location + (200 + 300 * FRand()) * Normal( DestDir - Floor * (DestDir Dot Floor)) + FRand() * vect(0,0,100);
		else
			Destination = Location + (200 + 300 * FRand()) * DestDir;

//		log("Destination = "$Destination);
		HitActor = Trace(HitLocation, HitNormal, Destination, Location, false);
		if ( VSize(HitLocation - Location) < 80 )
		{
			//if ( HitNormal.Z < 0 )
			//	return false;
			Destination = Location + Normal(DestDir + (HitNormal Cross vect(0,0,1))) * (200 + 300 * FRand());  
			HitActor = Trace(HitLocation, HitNormal, Destination, Location, false);
			if ( VSize(HitLocation - Location) > 80 )
				return true;
			Destination = Location + Normal(DestDir - (HitNormal Cross vect(0,0,1))) * (200 + 300 * FRand()); 
			HitActor = Trace(HitLocation, HitNormal, Destination, Location, false);
			if ( VSize(HitLocation - Location) < 80 )
			{
				return false;
			}				
		}
			
		return true;
	}
	
	function PickDestination()
	{
		local float enemydist;
		local bool EnemyFOV, bSeeEnemy;
		local vector enemyViewDir, hideDir;
		local NavigationPoint Nav;
		/*enemydist = Size(Location - Enemy.Location);
		enemyViewDir = Vector(Enemy.ViewRotation);
		bSeeEnemy = LineOfSightTo(Enemy);
		EnemyFOV = ( ((Location - Enemy.Location) Dot enemyViewDir) > 0.7 * enemydist );
		//log("Enemydist = "$enemydist$" FOV "$EnemyFOV$" seeenemy "$bSeeEnemy);
		if ( enemydist > 600 )
		{
			if ( bSeeEnemy && EnemyFOV && (Location.Z > Enemy.Location.Z) )
				GotoState('Active', 'Hide');
			else
			{
				Destination = 0.5 * (Location + Enemy.Location);
				Destination.Z = FMax(Location.Z, Enemy.Location.Z);
			}
			return;
		}
		if ( (enemydist > 180) && bSeeEnemy && !EnemyFOV )
			GotoState('Active', 'Hide');

		// try to get out of FOV, more than away
		hideDir = Normal( 2 * (Location - Enemy.Location)/enemydist - enemyViewDir);
		*/hideDir = normal(Vrand() - VRand());
		if ( TryPick(hideDir) )
			return;
		
		/*// try to get away
		if ( TryPick((Location - Enemy.Location)/enemydist) )
			return;*/
		
		// move toward pathnode			
		if ( (RetreatDest == None) || ActorReachable(RetreatDest) )
			RetreatDest = FindRandomDest();

		if ( RetreatDest != None )
		{
			if ( ActorReachable(RetreatDest) )
			{
				Destination = RetreatDest.Location;
				return;
			}
			else
			{
				MoveTarget = FindPathToward(RetreatDest);
				if ( MoveTarget != None )
				{
					Destination = MoveTarget.Location;
					return;
				}
			}
		}	
		
		// try other FOV dir.
		if ( TryPick(-1 * hideDir) )
			return;
		GotoState('Active', 'Hide');
	}
	
	function SetMovementPhysics()
	{
		SetPhysics(PHYS_Spider); 
	}
	
	function EndState()
	{
		if (Floor.z > 0.7)
			SetPhysics(PHYS_Walking);
		else
			SetPhysics(PHYS_Falling);
	}
	function BeginState()
	{
		PickDestination();
		SetMovementPhysics();
		
	}

}

/*
state FallingState
{
	function Landed(vector HitNormal)
	{
		local float landVol;

		// SetMovementPhysics(); //by default
		//log(class$" Landed at speed "$velocity.Z);
		bJustLanded = true;
		if ( (Velocity.Z < -0.8 * JumpZ) || bUpAndOut)
		{
			MakeNoise(-0.5 * Velocity.Z/(FMax(JumpZ, 150.0)));
			PlayLanded(Velocity.Z);
			landVol = Velocity.Z/JumpZ;
			landVol = 0.01 * Mass * landVol * landVol;
			if ( !FootRegion.Zone.bWaterZone )
				PlaySound(Land, SLOT_Interact, FMin(20, landVol)); 

			GotoState('Falling', 'Landed');
		}
		else if ( !bIsPlayer && (Velocity.Z < -0.65 * JumpZ) )
		{
			PlayLanded(Velocity.Z);
			GotoState('FallingState', 'FastLanded');
		}
		else 
			GotoState('FallingState', 'Done');
	}
	
	function EndState()
	{
		CallParent.EndState();
		SetMovementPhysics();
	}
}

*/

defaultproperties
{
     tailStrike=Sound'KlingonSFX01.creature.TarBite2'
     tailHit=Sound'KlingonSFX01.creature.TarSting'
     tailDamage=5
     CarcassType=Class'Klingons.TarchopCarcass'
     Orders=Roaming
     bLeadTarget=False
     bWarnTarget=False
     ProjectileSpeed=0.000000
     Acquire=Sound'KlingonSFX01.creature.TarAcquire'
     Roam=Sound'KlingonSFX01.creature.TarRun'
     Threaten=Sound'KlingonSFX01.creature.TarThreaten'
     SplatClass=Class'Klingons.GreenBlood'
     VoiceRadius=400.000000
     MeleeRange=20.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=10
     Intelligence=BRAINS_REPTILE
     HitSound1=Sound'KlingonSFX01.creature.TarHit1'
     HitSound2=Sound'KlingonSFX01.creature.TarHit2'
     Land=Sound'KlingonSFX01.creature.TarJump'
     Die=Sound'KlingonSFX01.creature.TarDie'
     CombatStyle=0.500000
     Physics=PHYS_Spider
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnTarchop'
     DrawScale=0.500000
     CollisionRadius=20.000000
     CollisionHeight=9.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=1
     bActorShadows=True
}
