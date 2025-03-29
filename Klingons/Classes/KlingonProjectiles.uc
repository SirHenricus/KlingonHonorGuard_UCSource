//=============================================================================
// KlingonProjectiles.
//=============================================================================
class KlingonProjectiles expands Projectile
	abstract;

#exec OBJ LOAD FILE=..\Textures\WeaponFX01.utx PACKAGE=WeaponFX01
#exec OBJ LOAD FILE=..\Sounds\KlingonSFX01 PACKAGE=KlingonSFX01

var() class<Effects>	TrailEffect;
var() class<Effects>	WaterEffect;
var() float				TrailTimer;
var() float				TrailPercentage;
var() class<Effects>	ExplosionEffect;
var() class<Effects>	GlowEffect;
var() float				ExplosionRadius;
var() float				DefaultSoundRadius;
var() name				HurtType;
var() int				ObjectHealth;
var() class<Effects>	ScorchEffect;
var() float				ScorchScale;

var int					AccumulatedDamage;
var bool				bCanHitOwner,
						bSplash;

var actor				MissleCamActor;

simulated function MomentumMove(actor A,vector Momentum)
{
	A.bBounce=True;
	A.bCollideWorld=True;
	A.Velocity+=(Momentum/A.Mass);
	SetRotation(rotator(Velocity));
}

function TakeDamage(int Damage,pawn InstigatedBy,vector HitLocation,vector Momentum,name DamageType)
{
	if (ObjectHealth > 0.0) {
		AccumulatedDamage+=Damage;
		if (AccumulatedDamage >= ObjectHealth) {
			Explode(HitLocation,vect(0,0,0));
		}
		Instigator=InstigatedBy;
	}
	if (Mass > 0.0) {
		MomentumMove(Self,Momentum);
	}
}

function ProcessTouch(actor Other,vector HitLoc)
{
	local vector	MomVec;

	if (Other != Instigator || bCanHitOwner) {
		if (Inventory(Other) != None && Other.bHidden) {
			return;
		}
		MomVec=(Damage*(MomentumTransfer*0.001)*(Other.Location-HitLoc));
		Other.TakeDamage(Damage,Instigator,HitLoc,MomVec,HurtType);
		Global.Explode(HitLoc,vect(0,0,0));
	}
}

simulated function SpawnScorch(vector HitNor)
{
	local actor		A;
	local vector	TraceHitLoc,
					TraceHitNor,
					TraceEnd,
					TraceStart;

	if (ScorchEffect == None) {
		return;
	}
	TraceStart=Location;
	TraceEnd=TraceStart-(HitNor*50.0);
	A=Trace(TraceHitLoc,TraceHitNor,TraceEnd,TraceStart,False);
	if (A != none) {
		if (A.IsA('LevelInfo')) {
			A=Spawn(ScorchEffect,,,TraceHitLoc,rotator(HitNor));
			if (A != none)
				A.DrawScale=FMax(ScorchScale*FRand(),ScorchScale*0.5);
		}
	}
}

function SpawnEffect(class<Effects> C)
{
	if (Level.NetMode != NM_StandAlone && !C.Default.bNet) {
		return;
	}
	Spawn(C);
}

function Explode(vector HitLoc,vector HitNor)
{
	if (Role == ROLE_Authority && ExplosionEffect != None) {
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

function Destroyed()
{
	if (MissleCamActor != None) {
		MissleCamActor.Destroy();
	}
}

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		if (bSplash) {
			K.ActorZoneChange(NewZone,Self);
		}
	}
}

auto state Flying
{
	function TakeDamage(int Damage,pawn InstigatedBy,vector HitLocation,vector Momentum,name DamageType)
	{
		Global.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
	}
	simulated function HitWall(vector HitNor,actor WallAct)
	{
		local actor		A;
		local vector	StartSpot;

		if (GlowEffect != None) {
			StartSpot=Location+(HitNor*10.0);
			Spawn(GlowEffect,Self,,StartSpot);
		}
		SpawnScorch(HitNor);
		Super.HitWall(HitNor,WallAct);
	}
	function ProcessTouch(actor Other,vector HitLoc)
	{
		Global.ProcessTouch(Other,HitLoc);
	}
	function Explode(vector HitLoc,vector HitNor)
	{
		Global.Explode(HitLoc,HitNor);
	}
	function Expired()
	{
		Global.Explode(Location,vect(0,0,0));
	}
	simulated function Timer()
	{
		if (Physics == PHYS_None) {
			return;
		}
		if (FRand() < TrailPercentage) {
			if (Region.Zone.bWaterZone && WaterEffect != None) {
				SpawnEffect(WaterEffect);
			}
			else if (TrailEffect != None) {
				SpawnEffect(TrailEffect);
			}
		}
	}
	simulated function Tick(float delta)
	{
		if (Physics == PHYS_None) {
			return;
		}
		if (FRand() < TrailPercentage) {
			if (Region.Zone.bWaterZone && WaterEffect != None) {
				SpawnEffect(WaterEffect);
			}
			else if (TrailEffect != None) {
				SpawnEffect(TrailEffect);
			}
		}
	}
	simulated function BeginState()
	{
		bSplash=True;
		if (Level.NetMode != NM_DedicatedServer) {
			PlaySound(SpawnSound,,,,DefaultSoundRadius);
		}
		Acceleration=vector(Rotation)*speed;
		Velocity=Acceleration;
		if (TrailEffect != None) {
			if (Level.NetMode != NM_StandAlone) {
				bUnlit=True;
				if (TrailTimer != 0) {
					TrailTimer=0.25;
					TrailPercentage=1.0;
				}
			}
			if (TrailTimer != 0.0) {
				SetTimer(TrailTimer,True);
				Disable('Tick');
			}
		}
		AccumulatedDamage=0.0;
	}
}

defaultproperties
{
     DefaultSoundRadius=1600.000000
     ExploWallOut=10.000000
     RemoteRole=ROLE_SimulatedProxy
     DrawType=DT_Sprite
     Texture=Texture'Engine.S_Actor'
     bMeshCurvy=False
     CollisionRadius=2.000000
     CollisionHeight=2.000000
}
