//=============================================================================
// Destructable.
//=============================================================================
class Destructable expands KlingonDecorations;

var() float				ExplosionDamage,
						ExplosionRadius,
						ExplosionMomentum;
var() name				ExplosionType;
var() float				ObjectHealth;
var() class<Effects>	ObjectDamagedEffect;
var() texture			ObjectDamagedSkin;
var() class<Shards>		ShardClass[10];
var() float				ShardCount;

var bool				bWaitingToExplode;
var float				AccumulatedDamage;

event PreBeginPlay()
{
	if (DrawScale != Default.Drawscale) {
		ExplosionDamage*=(DrawScale/Default.DrawScale);
		ExplosionRadius*=(DrawScale/Default.DrawScale);
		ExplosionMomentum*=(DrawScale/Default.DrawScale);
		ShardCount*=(DrawScale/Default.DrawScale);
		Mass*=(DrawScale/Default.DrawScale);
		Buoyancy*=(DrawScale/Default.DrawScale);
	}
	Super.PreBeginPlay();
}

simulated function MomentumMove(actor A,vector Momentum)
{
	A.bBounce=True;
	A.SetPhysics(PHYS_Falling);
	A.Velocity+=(Momentum/A.Mass);
	VelocitySpin(A,A.Velocity*25.0);
}

simulated function SpawnShards()
{
	local int		i,n;
	local actor		S;
	local vector	V;

	n=0;
	for (i=0 ; i < ShardCount ; i++) {
		if (n == 10 || ShardClass[n] == None) {
			n=0;
		}
		if (ShardClass[n] != None) {
			S=Spawn(ShardClass[n],Self);
			if (S != None) {
				if (S.Mass != 0.0) {
					V=(vect(0.5,0.5,1.0)*VRand());
					V.Z=Abs(V.Z);
					if (Mass != 0.0) {
						V*=((ExplosionMomentum/Mass)*(FRand()+0.25));
					}
					else {
						V*=(500.0*(FRand()+0.25));
					}
					S.Velocity=Velocity+V;
				}
				RandSpin(S,1.0);
				ShardSpawned(S);
			}
		}
		n++;
	}
}

simulated function ShardSpawned(actor S)
{
}

simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLoc,Vector Momentum,name DamageType)
{
	if (ObjectHealth > 0.0) {
		AccumulatedDamage+=Damage;
		if (AccumulatedDamage >= ObjectHealth) {
			if (DamageType == 'fell') {
				GotoState('Explode');
			}
			else {
				GotoState('Exploding');
			}
		}
		Instigator=InstigatedBy;
	}
	Super.TakeDamage(Damage,InstigatedBy,HitLoc,Momentum,DamageType);
}

simulated function Tick(float delta)
{
	local actor		a;

	if (AccumulatedDamage > 0 && ObjectDamagedEffect != None) {
		if (AccumulatedDamage >= (ObjectHealth*0.8)) {
			if (FRand() > 0.7) {
				a=Spawn(ObjectDamagedEffect);
				a.DrawScale=DrawScale;
			}
		}
		else if (AccumulatedDamage >= (ObjectHealth*0.6)) {
			if (FRand() > 0.8) {
				a=Spawn(ObjectDamagedEffect);
				a.DrawScale=DrawScale;
			}
		}
		else if (AccumulatedDamage >= (ObjectHealth*0.5)) {
			if (FRand() > 0.9) {
				a=Spawn(ObjectDamagedEffect);
				a.DrawScale=DrawScale;
			}
		}
	}
}

function Destroyed()
{
	if (EffectWhenDestroyed != None) {
		Spawn(EffectWhenDestroyed,Self);
	}
	if (ExplosionRadius != 0.0) {
		HurtRadius(ExplosionDamage,ExplosionRadius,ExplosionType,ExplosionMomentum,Location);
	}
	if (ShardCount > 0) {
		SpawnShards();
	}
	Super.Destroyed();
}

auto state Sitting
{
	function Destoyed()
	{
		Global.Destroyed();
	}
	simulated function Landed(vector HitNormal)
	{
		Global.HitWall(HitNormal,None);
	}
	simulated function HitWall(vector HitNor,actor HitActor)
	{
		Global.HitWall(HitNor,None);
	}
	simulated function ZoneChange(ZoneInfo NewZone)
	{
		Global.ZoneChange(NewZone);
	}
	simulated function BaseChange()
	{
		if (Base == None) {
			MomentumMove(Self,Velocity);
		}
		Global.BaseChange();
	}
	function Bump(actor Other)
	{
		Global.Bump(Other);
	}
	function Trigger(actor Other,pawn Instigator)
	{
		if (ObjectHealth > 0.0) {
			GotoState('Exploding');
		}
	}
	simulated function Tick(float delta)
	{
		local int		n;
		local actor		a;

		if (!bWaitingToExplode && AccumulatedDamage >= (ObjectHealth*0.8)) {
			n=Abs(ObjectHealth-AccumulatedDamage);
			SetTimer(Rand(n),False);
			bWaitingToExplode=True;
		}
		if (Skin == None && ObjectDamagedSkin != None) {
			if (AccumulatedDamage >= (ObjectHealth*0.5)) {
				PlayAnim('Damaged',1.0);
				Skin=ObjectDamagedSkin;
			}
		}
		Global.Tick(delta);
	}
	simulated function Timer()
	{
		Global.Timer();
		if (bWaitingToExplode) {
			GotoState('Exploding');
		}
	}
Begin:
	if (ExplosionDamage == 0.0 && ObjectDamagedSkin == None) {
		Disable('Tick');
	}
	AccumulatedDamage=0;
//	Skin=None;
}

state Exploding
{
	function Destoyed()
	{
		Global.Destroyed();
	}
	simulated function Landed(vector HitNormal)
	{
		Global.HitWall(HitNormal,None);
	}
	simulated function HitWall(vector HitNormal,actor HitWall)
	{
		Global.HitWall(HitNormal,None);
	}
	simulated function ZoneChange(ZoneInfo NewZone)
	{
		Global.ZoneChange(NewZone);
	}
	simulated function BaseChange()
	{
		if (Base == None) {
			MomentumMove(Self,Velocity);
		}
		Global.BaseChange();
	}
	function Bump(actor Other)
	{
		Global.Bump(Other);
	}
	simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLoc,Vector Momentum,name DamageType)
	{
		Super.TakeDamage(Damage,InstigatedBy,HitLoc,Momentum,DamageType);
		Timer();
	}
	simulated function Timer()
	{
		GotoState('Explode');
	}
	simulated function Tick(float delta)
	{
		Global.Tick(delta);
	}
Begin:
	if (Skin == None && ObjectDamagedSkin != None) {
		PlayAnim('Damaged',1.0);
		Skin=ObjectDamagedSkin;
	}
	if (AccumulatedDamage >= ObjectHealth*2.0) {
		SetTimer(FRand(),False);
	}
	else {
		SetTimer(2.0*FRand(),False);
	}
}

state Explode
{
Begin:
	Destroy();
}

defaultproperties
{
     ExplosionDamage=25.000000
     ExplosionRadius=300.000000
     ExplosionMomentum=25000.000000
     ExplosionType=exploded
     ObjectHealth=15.000000
     ObjectDamagedEffect=Class'Klingons.BlackSmoke'
     bPushable=True
     bStasis=False
     CollisionHeight=20.000000
     bCollideActors=True
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
     bProjTarget=True
     Mass=50.000000
     Buoyancy=51.000000
}
