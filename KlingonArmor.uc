//=============================================================================
// KlingonArmor.
//=============================================================================
class KlingonArmor expands Pickup;

#exec OBJ LOAD FILE=..\Textures\KlingonHUD.utx PACKAGE=KlingonHUD

var() mesh		PlayerMesh;
var() texture	PlayerSkin;

var actor		MyOwner;
var mesh		MyMesh;
var inventory	ItemCopy;

function RandSpin(actor A,float Scale)
{
	A.bFixedRotationDir=True;
	A.RotationRate=RotRand(True)*Scale;
}

function VelocitySpin(actor A,vector V)
{
	A.bFixedRotationDir=True;
	A.RotationRate=rotator(V);
}

function MomentumMove(actor A,vector Momentum)
{
	if (Level.NetMode != NM_StandAlone || (Level.Game != None && Level.Game.IsA('DeathMatchGame'))) {
		return;
	}
	A.bBounce=True;
	A.bCollideWorld=True;
	A.SetPhysics(PHYS_Falling);
	A.Velocity+=(Momentum/A.Mass);
	VelocitySpin(A,A.Velocity);
}

function Landed(vector HitNormal)
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

function inventory SpawnCopy(pawn Other)
{
	ItemCopy=Super.SpawnCopy(Other);
	ItemCopy.ProtectionType1=ProtectionType1;
	ItemCopy.ProtectionType2=ProtectionType2;
	return(ItemCopy);
}

function bool HandlePickupQuery(inventory Item)
{
	if (Owner.IsA('Bots'))
		return false;
		
	if (Item.bIsAnArmor) {
		if (Charge < Item.Charge) {
			Destroy();	// deleted from inventory in Destroyed()
			return(False);
		}
		return(True);
	}
	return(Super.HandlePickupQuery(Item));
}

function PickupFunction(pawn Other)
{
	local string[64]	SkinName;

	if (bIsItemGoal) {
		Other.ItemCount++;
		if (Level.Game != None) {
			if (KlingonGameInfo(Level.Game) != None) {
				KlingonGameInfo(Level.Game).ItemCount++;
			}
		}
	}
	if (ItemCopy != None && KlingonArmor(ItemCopy) != None && Other.Skin != None) {
		if (KlingonArmor(ItemCopy).PlayerMesh != None) {
			KlingonArmor(ItemCopy).MyMesh=Other.Default.Mesh;
			Other.Mesh=KlingonArmor(ItemCopy).PlayerMesh;
			if (Other.IsA('KlingonPlayer') || Other.IsA('Bots')) {
				if (ItemCopy.IsA('CombatArmor')) {
					SkinName="DMVacSuitSkins.AC"$string(Other.Skin);
				}
				else if (ItemCopy.IsA('VacSuit')) {
					SkinName="DMVacSuitSkins.Vac"$string(Other.Skin);
				}
				if (KlingonPlayer(Other) != None) {
					if (KlingonPlayer(Other).MySkin == None) {
						KlingonPlayer(Other).MySkin=Other.Skin;
					}
					PlayerPawn(Other).ServerChangeSkin(SkinName);
				}
				else {
					if (Bots(Other).MySkin == None) {
						Bots(Other).MySkin=Other.Skin;
					}
					Bots(Other).ServerChangeSkin(SkinName);
				}
			}
		}
		KlingonArmor(ItemCopy).MyOwner=Other;
	}
}

function Destroyed()
{
	if ((PlayerMesh != None) && (MyOwner != None)) {
		MyOwner.Mesh=MyMesh;
		if (KlingonPlayer(MyOwner) != None) {
			MyOwner.Skin=KlingonPlayer(MyOwner).MySkin;
		}
		else if (Bots(MyOwner) != None) {
			MyOwner.Skin=Bots(MyOwner).MySkin;
		}
	}
	Super.Destroyed();
}

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}
}

auto state Pickup
{
	function ZoneChange(ZoneInfo NewZone)
	{
		if (NewZone.bWaterZone) {
			RotationRate*=0.9;
		}
		Global.ZoneChange(NewZone);
	}
	function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLocation,Vector Momentum,name DamageType)
	{
		if (Mass > 0.0) {
			MomentumMove(Self,Momentum);
		}
	}
	function Landed(vector HitNormal)
	{
		Global.Landed(HitNormal);
	}
	function HitWall(vector HitNormal,actor HitWall)
	{
		Global.Landed(HitNormal);
	}
}

defaultproperties
{
     bDisplayableInv=True
     bInstantRespawn=True
     RespawnTime=120.000000
     bIsAnArmor=True
     PickupSound=Sound'KlingonSFX01.Pickups.Health3'
     RespawnSound=Sound'KlingonSFX01.Effects.Replicator'
     bMeshCurvy=False
     bProjTarget=True
     Mass=30.000000
}
