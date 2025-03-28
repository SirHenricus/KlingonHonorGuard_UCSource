//=============================================================================
// KlingonAmmo.
//=============================================================================
class KlingonAmmo expands Ammo
	abstract;

#exec OBJ LOAD FILE=..\Sounds\KlingonSFX01 PACKAGE=KlingonSFX01
#exec OBJ LOAD FILE=..\Textures\KlingonHUD.utx PACKAGE=KlingonHUD

var() float				ExplosionDamage,
						ExplosionRadius,
						ExplosionMomentum;
var() name				ExplosionType;
var() class<Effects>	ExplosionEffect;
var() float				ObjectHealth;
var() class<Effects>	ObjectDamagedEffect;
var() class<Effects>	ExpProjectile;
var() int				ExpProjCount;

var bool				bWaitingToExplode;
var float				AccumulatedDamage,
						DefaultHealth;

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
	if (Level.NetMode != NM_StandAlone || (Level.Game != None && Level.Game.IsA('DeathMatchGame'))) {
		return;
	}
	A.RemoteRole=ROLE_SimulatedProxy;
	A.bBounce=True;
	A.bCollideWorld=True;
	A.SetPhysics(PHYS_Falling);
	A.Velocity+=(Momentum/A.Mass);
	VelocitySpin(A,A.Velocity);
}

simulated function Landed(vector HitNormal)
{
	local rotator	R;
	local float		FallDamage;

	FallDamage=Abs(0.015*Velocity.Z);
	TakeDamage(FallDamage,None,Location,vect(0,0,0),'fell');
	Velocity=((Velocity dot HitNormal)*HitNormal*(-2.0)+Velocity);
	Velocity*=(1.0-(Mass*0.01));
	if (Region.Zone.bWaterZone == False) {
		R=Rotation;
		if (VSize(Velocity) < 30) {
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

simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLocation,Vector Momentum,name DamageType)
{
	if (Mass > 0.0) {
		MomentumMove(Self,Momentum);
	}
}

simulated function Tick(float delta)
{
	local actor		a;

	if (bHidden == True) {
		return;
	}
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

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}
}

simulated function PickupFunction(pawn P)
{
	AccumulatedDamage=0;
	Super.PickupFunction(P);
	if (bIsItemGoal) {
		P.ItemCount++;
		if (Level.Game != None) {
			if (KlingonGameInfo(Level.Game) != None) {
				KlingonGameInfo(Level.Game).ItemCount++;
			}
		}
	}
}

function bool HandlePickupQuery(inventory Item)
{
	if ((Class == Item.Class) || (ClassIsChildOf(Item.Class,class'Ammo') && (Class == Ammo(Item).ParentAmmo))) {
		if (AmmoAmount == MaxAmmo) {
			return(True);
		}
		if (PlayerPawn(Owner) != None) {
			PlayerPawn(Owner).ClientMessage(Item.PickupMessage);
		}
		PickupFunction(Pawn(Owner));
		Item.PlaySound(Item.PickupSound);
		AddAmmo(Ammo(Item).AmmoAmount);
		Item.SetRespawn();
		return(True);
	}
	if (Inventory == None) {
		return(False);
	}
	return(Inventory.HandlePickupQuery(Item));
}

auto state Pickup
{
	function Touch(actor Other)
	{
		Super.Touch(Other);
	}
	simulated function ZoneChange(ZoneInfo NewZone)
	{
		if (NewZone.bWaterZone) {
			RotationRate*=0.9;
		}
		Global.ZoneChange(NewZone);
	}
	simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLocation,Vector Momentum,name DamageType)
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
		Global.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
	}
	simulated function Landed(vector HitNormal)
	{
		Global.Landed(HitNormal);
	}
	simulated function HitWall(vector HitNormal,actor HitWall)
	{
		Global.Landed(HitNormal);
	}
	simulated function Trigger(actor Other,pawn Instigator)
	{
		AccumulatedDamage+=ObjectHealth*0.8;
	}
	simulated function Tick(float delta)
	{
		local int		n;

		Super.Tick(delta);
		if (!bWaitingToExplode && AccumulatedDamage >= (ObjectHealth*0.8)) {
			n=Abs(ObjectHealth-AccumulatedDamage);
			SetTimer(Rand(n),False);
			bWaitingToExplode=True;
		}
		Global.Tick(delta);
	}
	simulated function Timer()
	{
		Super.Timer();
		if (bWaitingToExplode) {
			GotoState('Exploding');
		}
	}
}

state Exploding
{
	simulated function Landed(vector HitNormal)
	{
		Global.Landed(HitNormal);
	}
	simulated function HitWall(vector HitNormal,actor HitWall)
	{
		Global.Landed(HitNormal);
	}
	simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLoc,Vector Momentum,name DamageType)
	{
		Global.TakeDamage(Damage,InstigatedBy,HitLoc,Momentum,DamageType);
	}
	simulated function Tick(float delta)
	{
		Global.Tick(delta);
	}
	simulated function Timer()
	{
		GotoState('Explode');
	}
Begin:
	SetTimer(2.0*FRand(),False);
}

state Explode
{
	function ExplodeObject()
	{
		local actor		a;
		local int		i,n;
		local vector	ExplodeVector;

		Spawn(ExplosionEffect);
		HurtRadius(ExplosionDamage,ExplosionRadius,ExplosionType,ExplosionMomentum,Location);
		if (ExpProjectile != None) {
			n=Rand(ExpProjCount);
			if (n > 0) {
				for (i=0 ; i < n ; i++) {
					ExplodeVector.X=(20*(FRand()-0.5));
					ExplodeVector.Y=(20*(FRand()-0.5));
					ExplodeVector.Z=(20*FRand());
					ExplodeVector*=FClamp(ExplosionDamage,5.0,25.0);
					a=Spawn(ExpProjectile,Owner,Tag);
					a.bBounce=True;
					a.bCollideWorld=True;
					a.Velocity=ExplodeVector;
					if (Inventory(a) != None) {
						Inventory(a).RespawnTime=0.0;
					}
					VelocitySpin(a,ExplodeVector);
					a.SetPhysics(PHYS_Falling);
					if (KlingonAmmo(a) != None) {
						KlingonAmmo(a).AccumulatedDamage=Rand(KlingonAmmo(a).ObjectHealth);
					}
				}
			}
		}
	}
Begin:
	ExplodeObject();
	AccumulatedDamage=0;
	SetRespawn();
}

defaultproperties
{
     RespawnSound=Sound'KlingonSFX01.Effects.Replicator'
     bMeshCurvy=False
     bProjTarget=True
}
