//=============================================================================
// HunterBolt.
//=============================================================================
class HunterBolt expands HunterProjectile;


simulated function Explode(vector HitLoc,vector HitNor)
{
	if (ExplosionEffect != None) {
		Spawn(ExplosionEffect,Self);
	}
	if (ExplosionRadius != 0.0) {
		HurtRadius(damage,ExplosionRadius,HurtType,MomentumTransfer,HitLoc);
		MakeNoise(1.0);
	}
	if (ImpactSound != None) {
		PlaySound(ImpactSound,,,,DefaultSoundRadius);
		MakeNoise(0.25);
	}
	Destroy();
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
	simulated function Expired()
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
		Velocity=0.7*((Velocity dot HitNor)*HitNor*(-2.0)+Velocity);
		speed=VSize(Velocity);
		if (Level.NetMode != NM_DedicatedServer) {
			PlaySound(ImpactSound,SLOT_Misc,FMax(0.5,speed/800),,DefaultSoundRadius);
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
	simulated function Tick(float delta)
	{
//		Drawscale *= 1.03;
		if (VSize(Velocity) > 30) {
			Acceleration=-((vector(Rotation)*delta)*10.0);
		}
		else {
			Acceleration=vect(0,0,0);
			Velocity=vect(0,0,0);
		}
	}
	simulated function Timer()
	{
		local pawn		VisActor;
		local vector	ClosestDist,dist;

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
		LockOnActor=None;
		LightType=LT_None;
		SetTimer(0.1,False);
	}
}

defaultproperties
{
     TrailEffect=None
     WaterEffect=None
     ExplosionEffect=Class'Klingons.ElectricExplosion5'
     HurtType=Imploded
     ObjectHealth=5
     speed=1.000000
     Damage=10.000000
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'WeaponFX01.electc001'
     Skin=Texture'WeaponFX01.electc001'
     Mesh=None
     DrawScale=1.200000
     AmbientSound=Sound'KlingonSFX01.creature.LethianPro'
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     LightType=LT_SubtlePulse
     LightHue=160
     LightSaturation=25
     LightRadius=10
     VolumeBrightness=10
     VolumeRadius=1
}
