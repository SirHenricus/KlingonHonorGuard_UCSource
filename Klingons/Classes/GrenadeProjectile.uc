//=============================================================================
// GrenadeProjectile.
//=============================================================================
class GrenadeProjectile expands KlingonProjectiles;

#call q:\Klingons\Art\Pickups\Ammo\HERocket\Final\HERocket.mac

#exec MESH ORIGIN MESH=AmmoHERocket X=-5 Y=750 Z=30 YAW=64



function Explode(vector HitLoc,vector HitNor)
{
/*
	local actor		A;
	local vector	TraceHitLoc,
					TraceHitNor,
					TraceEnd,
					TraceStart;

	TraceStart=Location;
	TraceEnd=TraceStart-(vect(0,0,1)*100.0);
	A=Trace(TraceHitLoc,TraceHitNor,TraceEnd,TraceStart,False);
	if (ScorchEffect != None && A.IsA('LevelInfo')) {
		A=Spawn(ScorchEffect,,,TraceHitLoc,rotator(vect(0,0,1)));
		A.DrawScale=FMax(ScorchScale*FRand(),ScorchScale*0.5);
	}
*/
	SpawnScorch(vect(0,0,1));
	Super.Explode(HitLoc,HitNor);
}

auto state Flying
{
	simulated function HitWall(vector HitNor,actor HitAct)
	{
		bCanHitOwner=True;
		SetPhysics(PHYS_Falling);
		Velocity=0.6*((Velocity dot HitNor)*HitNor*(-2.0)+Velocity);
		RandSpin(100000);
		speed=VSize(Velocity);
		if (Level.NetMode != NM_DedicatedServer) {
			PlaySound(ImpactSound,SLOT_Misc,FMax(0.5,speed/800),,DefaultSoundRadius);
			MakeNoise(0.25);
		}
		if (Velocity.Z > 400) {
			Velocity.Z=0.5*(400+Velocity.Z);
		}
		if (speed < 20) {
			bBounce=False;
			SetPhysics(PHYS_None);
			RotationRate=rotator(vect(0,0,0));
		}
	}
	simulated function Landed(vector HitNor)
	{
		HitWall(HitNor,None);
	}
	simulated function Timer()
	{
		Super.Timer();
		if (Physics == PHYS_Projectile) {
			SetPhysics(PHYS_Falling);
		}
		if (TrailTimer != 0.0) {
			SetTimer(TrailTimer,False);
		}
	}
	simulated function BeginState()
	{
		local rotator	RandRot;

		Super.BeginState();
		RandRot.Pitch=FRand()*1400-700;
		RandRot.Yaw=FRand()*1400-700;
		RandRot.Roll=FRand()*1400-700;
		Velocity=Velocity >> RandRot;
		Acceleration=vect(0,0,0);
		RandSpin(50000);	
		bCanHitOwner=False;
		SetTimer(0.25,False);
	}
}

defaultproperties
{
     TrailEffect=Class'Klingons.BlackSmoke'
     WaterEffect=Class'Klingons.WaterBubble'
     TrailPercentage=0.300000
     ExplosionEffect=Class'Klingons.GroundExplosion'
     ExplosionRadius=400.000000
     HurtType=exploded
     ObjectHealth=5
     ScorchEffect=Class'Klingons.Scorch01'
     ScorchScale=0.700000
     speed=700.000000
     MaxSpeed=700.000000
     Damage=50.000000
     MomentumTransfer=50000
     ImpactSound=Sound'KlingonSFX01.Weapons.GranadBn'
     LifeSpan=4.000000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.AmmoHERocket'
     DrawScale=0.400000
     AmbientGlow=64
     bUnlit=True
     CollisionRadius=6.000000
     CollisionHeight=6.000000
     bProjTarget=True
     bBounce=True
     bFixedRotationDir=True
     Mass=35.000000
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
}
