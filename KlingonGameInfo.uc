//=============================================================================
// KlingonGameInfo.
//=============================================================================
class KlingonGameInfo expands GameInfo
	localized;

var() class<TeleportEffects>	TeleportEffect;
var() class<TeleportEffects>	ReSpawnEffect;
var() class<Weapon>				DefaultWeapon2;
var() sound						RandomAmbience[5];
var() sound						TeleportSound;
var() float						RandomAmbFreq;
var() float						RandomAmbPct;

var PlayerPawn					SendP;

var GameStats					LevelStats;

var int							KillCount,
								ItemCount,
								SecretCount;

var string[64]					SendURL;

var float						NextAmbienceTime;

var bool						bNewLogin;

event playerpawn Login(string[32] Portal,string[120] Options,out string[80] Error,class<playerpawn> SpawnClass)
{
	bNewLogin=True;
	return(Super.Login(Portal,Options,Error,SpawnClass));
}

function SendPlayer(PlayerPawn P,string[64] URL)
{
	SendP=P;
	SendURL=URL;
//	P.ClientSetMusic(None,0,0,MTRAN_Instant);
	if (KlingonPlayer(P) != None) {
		EndLevel();
	}
	else {
		PostSendPlayer();
	}
}

function PostSendPlayer()
{
	SendP.ClientSetMusic(None,0,7,MTRAN_Instant);
	KlingonHud(KlingonPlayer(SendP).MyHud).AllowMenu(true);	
	if (Left(SendURL,3) != "M03" && Left(SendURL,4) != "M20C") {
		Super.SendPlayer(SendP,SendURL);
	}
	else {
		SendP.ClientTravel(SendURL,TRAVEL_Relative,False);
	}
}

function bool IsRelevant(actor Other)
{
//	Log(Self$".IsRelevant("$Other$")");
	return(Super.IsRelevant(Other));
}

function bool PickupQuery(Pawn Other,Inventory Item)
{
	local Weapon	WInv;
	local Ammo		AInv;
	local Inventory	I;

	if (Other.Inventory == None) {
		return(True);
	}
	if (Item.IsA('Weapon')) {
		I=Other.FindInventoryType(Item.Class);
		WInv=Weapon(I);
		if (WInv != None && !WInv.IsA('Daktagh')) {
			I=Other.FindInventoryType(WInv.AmmoName);
			AInv=Ammo(I);
			if (AInv != None && AInv.AmmoAmount >= WInv.PickupAmmoCount) {
				return(False);
			}
		}
		return(True);
	}
	else {
		return(!Other.Inventory.HandlePickupQuery(Item));
	}
}

function PostBeginPlay()
{
	local int				i;
	local AmbientSoundList	A;
	local BloodSplat		B;
	local Actor				Ac;

	Super.PostBeginPlay();
	foreach AllActors(class 'AmbientSoundList',A) {
		for (i=0 ; i < 5 ; i++) {
			RandomAmbience[i]=A.RandomAmbientList[i];
			RandomAmbFreq=A.RandomAmbFreq;
			RandomAmbPct=A.RandomAmbPct;
		}
		A.Destroy();
	}
	if (bLowGore) {
		foreach AllActors(class 'BloodSplat',B) {
			B.Destroy();
		}
	}
	if (LevelStats == None) {
		LevelStats=Spawn(class 'GameStats');
	}
}

function Killed(Pawn Killer,Pawn Other,Name DamageType)
{
	Super.Killed(Killer,Other,DamageType);
	if (Killer != None && Killer != Other) {
		KillCount++;
	}
}

function AddDefaultInventory(pawn PlayerPawn)
{
	local int		BeforeItemGoals;
	local Weapon	newWeapon;

	if (PlayerPawn.IsA('Spectator')) {
		return;
	}

	BeforeItemGoals=ItemGoals;
	Super.AddDefaultInventory(PlayerPawn);
	// Spawn default weapon.
	if (DefaultWeapon2 != None && PlayerPawn.FindInventoryType(DefaultWeapon2) == None) {
		newWeapon=Spawn(DefaultWeapon2,,,Location);
		if (newWeapon != None) {
			newWeapon.BecomeItem();
			PlayerPawn.AddInventory(newWeapon);
			newWeapon.Instigator=PlayerPawn;
			newWeapon.GiveAmmo(PlayerPawn);
			newWeapon.SetSwitchPriority(PlayerPawn);
			newWeapon.WeaponSet(PlayerPawn);
		}
	}
	ItemGoals=BeforeItemGoals;
}

function PlayTeleportEffect(actor Incoming,bool bOut,bool bSound)
{
	local TeleportEffects	T;

	if (TeleportEffect != None) {
		T=Spawn(TeleportEffect,Incoming,,Incoming.Location,Incoming.Rotation);
		if (T != None) {
			T.DrawScale=Incoming.DrawScale;
			T.TeleportDelay=2.0;
			if (TeleportSound != None) {
				T.PlaySound(TeleportSound);
			}
		}
	}
	if (bOut && Incoming.IsA('PlayerPawn')) {
		PlayerPawn(Incoming).SetFOVAngle(170);
	}
}

function PlaySpawnEffect(inventory Inv)
{
	local TeleportEffects	T;

	if (ReSpawnEffect != None) {
		T=Spawn(ReSpawnEffect,,,Inv.Location);
		if (T != None) {
			T.DrawScale=Inv.DrawScale;
			T.TeleportDelay=2.0;
		}
	}
}

function int ReduceDamage(int Damage,name DamageType,pawn injured,pawn instigatedBy)
{
	local int	ScaledDamage;

	if (injured.Region.Zone.bNeutralZone) {
		return(0);
	}
	ScaledDamage=Damage;
	if (injured.bIsPlayer) {
		switch (Difficulty) {
		case 0:
			ScaledDamage=float(ScaledDamage)*0.25;
			break;
		case 1:
			ScaledDamage=float(ScaledDamage)*0.5;
			break;
		case 2:
			ScaledDamage=float(ScaledDamage)*1.0;
			break;
		case 3:
			ScaledDamage=float(ScaledDamage)*1.5;
			break;
		}
	}
	else {
		switch (Difficulty) {
		case 0:
			ScaledDamage=float(ScaledDamage)*1.75;
			break;
		case 1:
			ScaledDamage=float(ScaledDamage)*1.5;
			break;
		case 2:
			ScaledDamage=float(ScaledDamage)*1.0;
			break;
		case 3:
			ScaledDamage=float(ScaledDamage)*0.75;
			break;
		}
	}
	return(ScaledDamage);
}

function string[64] KillMessage(name damageType,pawn Other)
{
	local KlingonPlayer		P;
	local Bots				B;

	P=KlingonPlayer(Other);
	if (P != None && P.PawnDamageTypes != None) {
		return(P.PawnDamageTypes.GetDeathMessage(Other,damageType));
	}
	B=Bots(Other);
	if (B != None && B.PawnDamageTypes != None) {
		return(B.PawnDamageTypes.GetDeathMessage(Other,damageType));
	}
}

function string[64] CreatureKillMessage(name damageType, pawn Other)
{
	return(KillMessage(damageType,Other));
}

function string[64] PlayerKillMessage(name damageType,pawn Other)
{
	return(KillMessage(damageType,Other));
} 	

simulated function PlayRandomAmbience(pawn Player)
{
	local int	s;

	if (Level.TimeSeconds > NextAmbienceTime) {
		if (FRand() < RandomAmbPct) {
			s=Rand(5);
			if (RandomAmbience[s] != None) {
				Player.PlaySound(RandomAmbience[s],SLOT_Misc,1.0,True);
			}
		}
		NextAmbienceTime=Level.TimeSeconds+RandomAmbFreq;
	}
}

simulated function ActorZoneChange(ZoneInfo NewZone,actor A)
{
	local float		SplashSize;
	local actor		S;
	local rotator	R;

	if (VSize(A.Velocity) < 100.0) {
		return;
	}
	SplashSize=FClamp(A.Mass*VSize(A.Velocity)*0.000025,0.1,1.0);
	if (NewZone.EntryActor != None) {
		R=rot(0,32768,0)*FRand();
		S=Spawn(NewZone.EntryActor,,,A.Location,R);
		S.DrawScale=SplashSize;
	}
	if (NewZone.EntrySound != None) {
		A.PlaySound(NewZone.EntrySound,,FClamp(A.Mass*0.01,0.1,1.0));
	}
	if (A.Region.Zone.ExitActor != None) {
		R=rot(0,32768,0)*FRand();
		S=Spawn(A.Region.Zone.ExitActor,,,A.Location,R);
		S.DrawScale=SplashSize;
	}
	if (A.Region.Zone.ExitSound != None) {
		A.PlaySound(A.Region.Zone.ExitSound,,FClamp(A.Mass*0.01,0.1,1.0));
	}
}

function EndLevel()
{
	local Actor		A;
	local Pawn		aPawn;

	foreach AllActors(class 'Actor',A,'EndLevel') {
		A.Trigger(Self,None);
	}
	if (Level.NetMode == NM_StandAlone) {
		if (KlingonPlayer(SendP) != None) {
			KlingonPlayer(SendP).GotoState('LevelEnded');
		}
	}
	else {
		aPawn=Level.PawnList;
		while (aPawn != None) {
			if (aPawn.bIsPlayer) {
				if (KlingonPlayer(aPawn) != None) {
//					Log(Self$".EndLevel() "$aPawn$".GotoState(LevelEnded)");
					KlingonPlayer(aPawn).GotoState('LevelEnded');
				}
			}	
			aPawn=aPawn.NextPawn;
		}
	}
}

defaultproperties
{
     DefaultWeapon2=Class'Klingons.Daktagh'
     DefaultPlayerClass=Class'Klingons.KlingonPlayer'
     DefaultWeapon=Class'Klingons.DisruptorPistol'
     GameMenuType=Class'Klingons.KlingonMenuGameOptions'
     HUDType=Class'Klingons.KlingonHUD'
}
