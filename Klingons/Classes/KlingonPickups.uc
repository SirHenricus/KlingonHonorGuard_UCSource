//=============================================================================
// KlingonPickups.
//=============================================================================
class KlingonPickups expands Pickup;

#exec OBJ LOAD FILE=..\Sounds\KlingonSFX01 PACKAGE=KlingonSFX01
#exec OBJ LOAD FILE=..\Textures\KlingonHUD.utx PACKAGE=KlingonHUD

var() sound		Warning1Sound;
var() int		Warning1Time;
var() sound		Warning2Sound;
var() int		Warning2Time;
var() float		ConsumptionRate;
var() float		DefaultSoundRadius;

var actor		MyOwner;
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

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}
}

//
// Advanced function which lets existing items in a pawn's inventory
// prevent the pawn from picking something up. Return true to abort pickup
// or if item handles the pickup
function bool HandlePickupQuery( inventory Item )
{
	if (item.class == class) 
	{
		if (bCanHaveMultipleCopies) 
		{   // for items like Artifact
			NumCopies++;
			if (PlayerPawn(Owner) != None) {
				PlayerPawn(Owner).ClientMessage(PickupMessage);
			}
			Item.PlaySound (Item.PickupSound,,2.0);
			Item.SetRespawn();
		}
		else if ( bDisplayableInv || Owner.IsA('Bots')) 
		{		
			if ( Charge<Item.Charge )	
				Charge= Item.Charge;
			if (PlayerPawn(Owner) != None) {
				PlayerPawn(Owner).ClientMessage(PickupMessage);
			}
			Item.PlaySound (PickupSound,,2.0);
			Item.SetReSpawn();
		}
		return true;				
	}
	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

function PickupFunction(pawn P)
{
	if (ItemCopy.bIsItemGoal) {
		P.ItemCount++;
		if (Level.Game != None) {
			if (KlingonGameInfo(Level.Game) != None) {
				KlingonGameInfo(Level.Game).ItemCount++;
			}
		}
	}
	KlingonPickups(ItemCopy).MyOwner=P;
}

function inventory SpawnCopy(pawn Other)
{
	ItemCopy=Super.SpawnCopy(Other);
	return(ItemCopy);
}

function ItemActivated()
{
}

function ItemDeActivated()
{
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

state Activated
{
	function Timer()
	{
		if (Charge > 0) {
			Charge--;
			if (Charge <= 0) {
				GotoState('DeActivated');
			}
			if (Charge == Warning1Time) {
				MyOwner.PlaySound(Warning1Sound); //,SLOT_None,Pawn(MyOwner).SoundDampening,,DefaultSoundRadius);
			}
			if (Charge == Warning2Time) {
				MyOwner.PlaySound(Warning2Sound);
			}
		}
	}
	function BeginState()
	{
		if (MyOwner == None) {
			MyOwner=Owner;
		}
		if (Default.Charge != 0 && Charge <= 0) {
			GotoState('DeActivated');
			return;
		}
		Super.BeginState();
		if (bActive) {
			MyOwner.PlaySound(ActivateSound);
			if (ConsumptionRate != 0.0) {
				SetTimer(ConsumptionRate,True);
			}
			ItemActivated();
		}
	}
	function EndState()
	{
		if (ConsumptionRate != 0.0) {
			SetTimer(0.0,False);
		}
		Super.EndState();
	}
}

state DeActivated
{
	function Activate()
	{
		if (Default.Charge != 0 && Charge <= 0) {
			UsedUp();
		}
		else {
			GotoState('Activated');
		}
	}
/*
	simulated function BeginState()
	{
		ItemDeActivated();
		MyOwner.PlaySound(DeActivateSound);
		if (Default.Charge != 0 && Charge <= 0) {
			UsedUp();
		}
	}
*/
//	function BeginState()	// It suck that this breaks when using BeginState (MEB??)
Begin:
	ItemDeActivated();
	if (MyOwner != None) {
		MyOwner.PlaySound(DeActivateSound);
	}
	if (Default.Charge != 0 && Charge <= 0) {
		UsedUp();
	}
}

defaultproperties
{
     DefaultSoundRadius=1600.000000
     bActivatable=True
     RespawnTime=120.000000
     PickupSound=Sound'KlingonSFX01.Pickups.Health3'
     RespawnSound=Sound'KlingonSFX01.Effects.Replicator'
     bMeshCurvy=False
     bProjTarget=True
     Mass=30.000000
}
