//=============================================================================
// ParticleAttractor.
//=============================================================================
class ParticleAttractor expands ParticleProjectile;

#call q:\Klingons\Art\Pickups\Ammo\HERocket\Final\HERocket.mac

#exec MESH ORIGIN MESH=AmmoHERocket X=-5 Y=750 Z=30 YAW=64

var() class<Effects>	GlowClass;
var() float				GravityForce;
var() float				GravityRange;

var int					ActorCount,
						TimerCount;

var float				AttractForce;

var actor				ActorList[20],
						GlowEffect,
						GlowEffectChild;

auto state Flying
{
	function TakeDamage(int Damage,pawn InstigatedBy,vector HitLocation,vector Momentum,name DamageType)
	{
		Global.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
	}
	simulated function ProcessTouch(actor Other,vector HitLoc)
	{
		HitWall(Normal(Location-Other.Location),Other);
	}
	simulated function HitWall(vector HitNor,actor HitAct)
	{
		bCanHitOwner=True;
		SetPhysics(PHYS_Falling);
		Velocity=0.7*((Velocity dot HitNor)*HitNor*(-2.0)+Velocity);
		RandSpin(100000);
		speed=VSize(Velocity);
		if (Level.NetMode != NM_DedicatedServer) {
			PlaySound(ImpactSound,SLOT_Misc,FMax(0.5,speed/800),,DefaultSoundRadius);
		}
		if (Velocity.Z > 400) {
			Velocity.Z=0.5*(400+Velocity.Z);
		}
		if (speed < 20) {
			bBounce=False;
			SetPhysics(PHYS_None);
			GotoState('Floating');
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
		Velocity=Vector(Rotation)*Speed+FRand()*100*Vector(Rotation);
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

state Floating
{
	function TakeDamage(int Damage,pawn InstigatedBy,vector HitLocation,vector Momentum,name DamageType)
	{
		Global.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
	}
	simulated function Timer()
	{
		Velocity=vect(0,0,25);
		SetPhysics(PHYS_Projectile);
		GotoState('PreAttracting');
	}
	simulated function BeginState()
	{
		SetTimer(3,False);
	}
}

state PreAttracting
{
	simulated function Timer()
	{
		bHidden=True;
		Velocity=vect(0,0,0);
		SetPhysics(PHYS_None);
		GotoState('Attracting');
	}
	simulated function BeginState()
	{
		SetTimer(3,False);
	}
}

state Attracting
{
	ignores	TakeDamage,
			ProcessTouch;

	function Explode(vector HitLoc,vector HitNor)
	{
		if (GlowEffect != None) {
			GlowEffect.Destroy();
		}
		if (ExplosionEffect != None) {
			Spawn(ExplosionEffect);
		}
		if (ExplosionRadius != 0.0) {
			HurtRadius(damage,ExplosionRadius,HurtType,MomentumTransfer,HitLoc);
			MakeNoise(1.0);
		}
		Destroy();
	}
	function Expired()
	{
		Explode(Location,vect(0,0,0));
	}
	simulated function Timer()
	{
		local int		i;
		local actor		A;

		for (i=0 ; i < 20 ; i++) {
			ActorList[i]=None;
		}
		ActorCount=0;
		foreach VisibleActors(class 'Actor',A,GravityRange) {
			if (ActorCount < 20 && !A.bHidden && A.Mass > 0 && A != Self) {
				if (Mover(A) == None) {
					if (Inventory(A) == None || (Level.Game != None && Level.Game.IsA('SinglePlayer'))) {
						ActorList[ActorCount]=A;
						ActorCount++;
					}
				}
			}
		}
		if (Role == ROLE_Authority) {
			TimerCount++;
			if (TimerCount >= 11) {
				Expired();
			}
		}
	}
	simulated function ActorAddVelocity(actor a,vector v)
	{
		if (Pawn(a) != None) {
			Pawn(a).Velocity+=(v*2);
		}
		else {
			a.Velocity+=v;
			a.MoveSmooth(a.Velocity/200.0);
			a.SetPhysics(PHYS_Falling);
		}
	}
	simulated function Tick(float delta)
	{
		local int				i;
		local rotator			R;
		local vector			AttractVel,V;
		local float				Dist,M;
		local KlingonEffects	GlowChild;

		R=Rotation+RotationRate;
		RotationRate.Yaw+=(10.0*(1.0+delta));
		AttractForce+=(GravityForce*delta);
		SetRotation(R);
		for (i=0 ; i < ActorCount ; i++) {
			if (ActorList[i] != None) {
				V=Location-ActorList[i].Location;
				Dist=max(VSize(V),1.0);
				M=max(ActorList[i].Mass,1.0);
//				if (M == 0.0) {
//					M=1.0;
//				}
//				if (Dist == 0.0) {
//					Dist=1.0;
//				}
				AttractVel=(((V*AttractForce)/Dist)/M);
				ActorAddVelocity(ActorList[i],AttractVel);
				if (Pawn(ActorList[i]) == None) {
					ActorList[i].bFixedRotationDir=True;
					ActorList[i].RotationRate=rotator(ActorList[i].Velocity*200.0);
				}
			}
		}
		LightBrightness=(AttractForce*0.075);
		if (GlowEffectChild == None) {
			if (KlingonEffects(GlowEffect) != None) {
				GlowEffectChild=KlingonEffects(GlowEffect).ChildActor;
			}
		}
		GlowChild=KlingonEffects(GlowEffectChild);
		while (GlowChild != None) {
			GlowChild.SetLocation(Location);
			GlowChild.DrawScale=(AttractForce*(GlowChild.Default.DrawScale*0.001));
			if (GlowChild.DrawScale > 6.0) {
				GlowChild.DrawScale=6.0;
			}
			GlowChild=KlingonEffects(GlowChild.ChildActor);
		}
//		if (GlowEffect != None) {
//			GlowEffect.SetLocation(Location);
//			GlowEffect.DrawScale=(AttractForce/300.0);
//			if (GlowEffect.DrawScale > 10.0) {
//				GlowEffect.DrawScale=10.0;
//			}
//			GlowEffect.DrawScale+=(GlowEffect.Default.DrawScale*FRand());
//			GlowEffect.LightBrightness=GlowEffect.DrawScale*25;
//		}
		if (Physics != PHYS_None) {
			SetPhysics(PHYS_None);
		}
	}
	simulated function BeginState()
	{
		TimerCount=0;
		AttractForce=0.0;
	}
Begin:
	Disable('Tick');
	GlowEffect=Spawn(GlowClass,Self);
	GlowEffectChild=None;
	Timer();
	SetTimer(2.0,True);
	Enable('Tick');
}

defaultproperties
{
     GlowClass=Class'Klingons.ElectricExplosion1'
     GravityForce=300.000000
     GravityRange=1500.000000
     TrailEffect=Class'Klingons.BlackSmoke'
     TrailTimer=0.300000
     ExplosionRadius=300.000000
     HurtType=Imploded
     ObjectHealth=25
     ScorchEffect=None
     ScorchScale=0.000000
     speed=600.000000
     MaxSpeed=600.000000
     SpawnSound=Sound'KlingonSFX01.Weapons.Wepon2'
     ImpactSound=Sound'KlingonSFX01.Weapons.GrenadBn2'
     LifeSpan=0.000000
     DrawType=DT_Mesh
     Style=STY_Normal
     Mesh=Mesh'Klingons.AmmoHERocket'
     DrawScale=0.400000
     AmbientSound=Sound'KlingonSFX01.Weapons.VortexLp'
     CollisionRadius=6.000000
     CollisionHeight=6.000000
     LightBrightness=0
     LightHue=140
     bBounce=True
     Mass=30.000000
}
