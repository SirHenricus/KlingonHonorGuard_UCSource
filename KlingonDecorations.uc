//=============================================================================
// KlingonDecorations.
//=============================================================================
class KlingonDecorations expands Decoration;

var() sound				ImpactSound;
var() float				VisibleLifeSpan;

event PreBeginPlay()
{
	if (DrawScale != Default.Drawscale) {
		SetCollisionSize(CollisionRadius*DrawScale/Default.DrawScale,CollisionHeight*DrawScale/Default.DrawScale);
	}
	Super.PreBeginPlay();
}

function Spawned()
{
	SetTimer(VisibleLifeSpan,False);
}

simulated function RandSpin(actor A,float Scale)
{
	A.bFixedRotationDir=True;
	A.RotationRate=RotRand(True)*Scale;
}

simulated function VelocitySpin(actor A,vector V)
{
	A.bFixedRotationDir=True;
	A.RotationRate=rotator(V);
}

simulated function MomentumMove(actor A,vector Momentum)
{
	A.bBounce=True;
	A.bCollideWorld=True;
	A.SetPhysics(PHYS_Falling);
	A.Velocity+=(Momentum/A.Mass);
	RandSpin(A,1.0);
}

simulated function Timer()
{
	if (!PlayerCanSeeMe()) {
		Destroy();
	}
	else {
		SetTimer(VisibleLifeSpan,False);
	}
}

simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLocation,Vector Momentum,name DamageType)
{
	if (Mass > 0.0) {
		MomentumMove(Self,Momentum);
	}
}

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	if (NewZone.bWaterZone) {
		RotationRate*=0.9;
	}
	if (!NewZone.bWaterZone && Region.Zone.bWaterZone && (Buoyancy > Mass)) {
		bBobbing=True;
		if (Buoyancy > 1.1*Mass) {
			Buoyancy=0.95*Buoyancy;
		}
		else if (Buoyancy > 1.03*Mass) {
			Buoyancy=0.99*Buoyancy;
		}
	}
	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}
	if (NewZone.bPainZone && (NewZone.DamagePerSec > 0)) {
		TakeDamage(100,None,Location,vect(0,0,0),NewZone.DamageType);
	}
}

simulated function HitWall(vector HitNor,actor HitActor)
{
	local rotator	R;
	local float		FallDamage;

	FallDamage=Abs(0.015*Velocity.Z);
	TakeDamage(FallDamage,None,Location,vect(0,0,0),'fell');
	if (Velocity.Z > 0.0) {	// hit a ceiling
		Velocity.Z=0.0;
	}
	Velocity=((Velocity dot HitNor)*HitNor*(-2.0)+Velocity);
	Velocity*=FClamp(1.0-(Mass*0.02),0.1,0.9);
	if (Region.Zone.bWaterZone == False) {
		PlaySound(ImpactSound);
		R=Rotation;
		if (VSize(Velocity) < 20) {
			bBounce=False;
			SetPhysics(PHYS_None);
			Velocity=vect(0,0,0);
			bFixedRotationDir=False;
			R.Roll=0.0;
		}
		R.Pitch=0.0;
		SetRotation(R);
	}
}

simulated function Landed(vector HitNor)
{
//	if( bWasCarried && !SetLocation(Location) )
//	{
//		if( Instigator!=None && (VSize(Instigator.Location - Location) < CollisionRadius + Instigator.CollisionRadius) )
//			SetLocation(Instigator.Location);
//		TakeDamage( 1000, Instigator, Vect(0,0,1), Vect(0,0,1)*900,'exploded' );
//	}
	HitWall(HitNor,None);
	bWasCarried=false;
	bBobbing=false;
}

defaultproperties
{
     bStatic=False
     bMeshCurvy=False
}
