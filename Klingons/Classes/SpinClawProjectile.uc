//=============================================================================
// SpinClawProjectile.
//=============================================================================
class SpinClawProjectile expands KlingonProjectiles;

#call q:\Klingons\Art\Projectiles\SpinClawPJ\Final\SpinClawPJ.mac
#exec MESH ORIGIN MESH=ProjSpinClaw X=0 Y=0 Z=0 YAW=64

var() class<Effects>	SparkClass;
var() float				TickDamage;

var actor				AttachedPawn;
var float				AttachedDamage;

simulated function GoHomeFunction()
{
	if (AttachedPawn != None && AttachedPawn == Instigator) {
		GotoState('Flying');
	}
	else {
		GotoState('GoHome');
	}
}

simulated function Explode(vector HitLoc,vector HitNor)
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
		A.DrawScale=FMax(1.0*FRand(),0.5);
	}
*/
	SpawnScorch(vect(0,0,1));
	Super.Explode(HitLoc,HitNor);
}

simulated function ProcessTouch(actor Other,vector HitLoc)
{
	if (Other != Instigator) {
		if (Other.IsA('Pawn') || Other.IsA('Decoration')) {
			AttachedPawn=Other;
			GotoState('Slicing');
		}
	}
	else if (bCanHitOwner) {
		if (Instigator.Weapon.IsA('SpinClaw')) {
			Instigator.Weapon.GotoState('Catch');
			Destroy();
		}
		else {
			Damage*=25.0;
			Explode(HitLoc,vect(0,0,0));
		}
	}
}

simulated function HitWall(vector HitNor,actor HitAct)
{
	local rotator	R;
	local actor		A;

//	if (Instigator.Health <= 0) {
//		Damage*=25.0;
//		Explode(Location,vect(0,0,0));
//		return;
//	}
	bCanHitOwner=True;
	Velocity+=((Velocity dot HitNor)*HitNor)*(-2.0);
	Acceleration=Velocity;
	R=rotator(Velocity);
	SetRotation(R);
	if (ImpactSound != None) {
		PlaySound(ImpactSound,SLOT_Misc,VSize(Velocity)/1300,,DefaultSoundRadius);
		MakeNoise(0.25);
	}
	if (SparkClass != None) {
		Spawn(SparkClass);
	}
	SpawnScorch(HitNor);
}

auto state Flying
{
	simulated function ProcessTouch(actor Other,vector HitLoc)
	{
		Global.ProcessTouch(Other,HitLoc);
	}
	simulated function HitWall(vector HitNor,actor HitAct)
	{
		Global.HitWall(HitNor,HitAct);
	}
	simulated function Timer()
	{
		GoHomeFunction();
	}
	simulated function BeginState()
	{
		Super.BeginState();
		LoopAnim('Spin');
		SetTimer(5.0,False);
//		if (Instigator != None && Instigator.Weapon != None) {
//			SetOwner(Instigator.Weapon);
//		}
	}
}

state Slicing
{
	simulated function ProcessTouch(actor Other,vector HitLoc)
	{
	}
	simulated function Timer()
	{
		if (AttachedPawn != None && AttachedPawn.bDeleteMe) {
			AttachedPawn=None;
		}
		if (AttachedPawn != None) {
			SetLocation(AttachedPawn.Location);
			AttachedPawn.TakeDamage(TickDamage,Instigator,Location,vect(0,0,0),HurtType);
			AttachedDamage+=TickDamage;
			if (AttachedDamage >= Damage) {
				GoHomeFunction();
			}
		}
		else {
			GoHomeFunction();
		}
	}
	simulated function BeginState()
	{
		AttachedDamage=0.0;
		SetTimer(0.1,True);
	}
}

state GoHome
{
	simulated function HitWall(vector HitNor,actor HitAct)
	{
		Global.HitWall(HitNor,HitAct);
		GotoState('Flying');
	}
	simulated function ProcessTouch(actor Other,vector HitLoc)
	{
		Global.ProcessTouch(Other,HitLoc);
	}
	simulated function Tick(float Delta)
	{
		local vector	HomeVector;

		HomeVector=Instigator.Location-Location;
		Acceleration=speed*HomeVector;
		Velocity=Acceleration;
	}
	simulated function BeginState()
	{
		bCanHitOwner=True;
	}
}

defaultproperties
{
     SparkClass=Class'Klingons.Spark1'
     TickDamage=5.000000
     WaterEffect=Class'Klingons.WaterBubble'
     TrailPercentage=0.600000
     ExplosionEffect=Class'Klingons.AirSmallExp'
     ExplosionRadius=200.000000
     HurtType=Pureed
     speed=800.000000
     MaxSpeed=800.000000
     Damage=80.000000
     MomentumTransfer=10000
     SpawnSound=Sound'KlingonSFX01.Weapons.SpinStart'
     ImpactSound=Sound'KlingonSFX01.Weapons.SpinBounce'
     LifeSpan=30.000000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.ProjSpinClaw'
     DrawScale=0.200000
     SoundVolume=255
     AmbientSound=Sound'KlingonSFX01.Weapons.SpinLoop'
     CollisionRadius=8.000000
     bProjTarget=True
     LightType=LT_Steady
     LightBrightness=128
     LightHue=45
     LightRadius=16
     bBounce=True
     Mass=30.000000
}
