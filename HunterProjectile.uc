//=============================================================================
// HunterProjectile.
//=============================================================================
class HunterProjectile expands RocketProjectile;

#call q:\Klingons\Art\Pickups\Ammo\HERocket\Final\HERocket.mac

#exec MESH ORIGIN MESH=AmmoHERocket X=-5 Y=750 Z=30 YAW=64

var actor	LockOnActor;
var vector	LockOnVector;

replication
{
	reliable if (Role == ROLE_Authority)
		LockOnActor;
}

function Explode(vector HitLoc,vector HitNor)
{
	SpawnScorch(vect(0,0,1));
	Super.Explode(HitLoc,HitNor);
}

auto state Flying
{
	simulated function Tick(float delta)
	{
		Super.Tick(delta);
		if (LockOnActor != None) {
			LockOnVector=LockOnActor.Location-Location;
			Acceleration=LockOnVector*speed;
		}
		SetRotation(rotator(LockOnVector));
	}
	simulated function Timer()
	{
		if (LockOnActor != None) {
			if (Pawn(LockOnActor).LineOfSightTo(Self)) {
				return;
			}
		}
		GotoState('AcquireTarget');
	}
	simulated function BeginState()
	{
		Super.BeginState();
		if (LockOnActor == None) {
			GotoState('AcquireTarget');
		}
		else {
			LightType=Default.LightType;
			SetTimer(1.0,True);
		}
	}
	simulated function EndState()
	{
		SetTimer(0.0,False);
	}
}

state AcquireTarget
{
	function Expired()
	{
		Global.Explode(Location,vect(0,0,0));
	}
	simulated function ProcessTouch(actor Other,vector HitLoc)
	{
		Global.ProcessTouch(Other,HitLoc);
	}
	simulated function HitWall(vector HitNor,actor HitWall)
	{
		bCanHitOwner=True;
		Velocity=0.6*((Velocity dot HitNor)*HitNor*(-2.0)+Velocity);
		speed=VSize(Velocity);
		if (Level.NetMode != NM_DedicatedServer) {
			PlaySound(ImpactSound,,,,DefaultSoundRadius);
		}
		SetRotation(rotator(Velocity));
		if (speed < 20) {
			Velocity=vect(0,0,0);
			Acceleration=vect(0,0,0);
		}
	}
	simulated function Landed(vector HitNor)
	{
		HitWall(HitNor,None);
	}
/*
	simulated function Tick(float delta)
	{
		if (VSize(Velocity) > 30) {
			Velocity=(delta*0.99)*Velocity;
		}
		else {
			Acceleration=vect(0,0,0);
			Velocity=vect(0,0,0);
		}
	}
*/
	simulated function Timer()
	{
		local pawn		VisActor;
		local vector	ClosestDist,dist;

		if (Role == ROLE_Authority) {
			LockOnActor=None;
			ClosestDist=vect(1.0,1.0,1.0)*99999.0;
			foreach VisibleActors(class 'Pawn',VisActor,,Location) {
				if (bCanHitOwner == True || VisActor != Instigator) {
					dist=VisActor.Location-Location;
					if (VSize(dist) < VSize(ClosestDist)) {
						ClosestDist=dist;
						LockOnActor=VisActor;
					}
				}
			}
		}
		if (LockOnActor != None) {
			LockOnVector=LockOnActor.Location-Location;
			GotoState('Flying');
		}
		else {
			SetTimer(2.0,False);
		}
	}
	simulated function BeginState()
	{
		LoopAnim('Static');
		LockOnActor=None;
		LightType=LT_None;
		SetTimer(5.0,False);
	}
}

defaultproperties
{
     TrailTimer=0.000000
     TrailPercentage=0.800000
     ObjectHealth=10
     speed=250.000000
     MaxSpeed=400.000000
     LifeSpan=20.000000
     CollisionHeight=8.000000
     bBounce=True
     bFixedRotationDir=False
     RotationRate=(Roll=0)
}
