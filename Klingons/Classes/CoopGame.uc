//=============================================================================
// CoopGame.
//=============================================================================
class CoopGame expands KlingonGameInfo
	config;

var() config bool		bNoFriendlyFire;
var() class<Inventory>	DefaultCoopInv[10];

function AddDefaultInventory(pawn PlayerPawn)
{
	local int			BeforeItemGoals,
						i;
	local Inventory		newInv;

	if (PlayerPawn.IsA('Spectator')) {
		return;
	}

	BeforeItemGoals=ItemGoals;
	Super.AddDefaultInventory(PlayerPawn);
	// Spawn default inventory for COOP games
	for (i=0 ; i < 10 ; i++) {
		if (DefaultCoopInv[i] != None) {
			if (PlayerPawn.FindInventoryType(DefaultCoopInv[i]) == None) {
				newInv=Spawn(DefaultCoopInv[i],,,Location);
				if (newInv != None) {
					newInv.BecomeItem();
					PlayerPawn.AddInventory(newInv);
				}
				if (newInv.IsA('Weapon')) {
					Weapon(newInv).Instigator=PlayerPawn;
					Weapon(newInv).GiveAmmo(PlayerPawn);
					Weapon(newInv).SetSwitchPriority(PlayerPawn);
					Weapon(newInv).WeaponSet(PlayerPawn);
				}
			}
		}
	}
	ItemGoals=BeforeItemGoals;
}

function bool IsRelevant(actor Other)
{
	// hide all playerpawns

	if ( Other.IsA('PlayerPawn') )
	{
		Other.SetCollision(false,false,false);
		Other.bHidden = true;
	}
	return Super.IsRelevant(Other);
}

/*	LB
function PlaySpawnEffect(inventory Inv)
{
//	Playsound(sound'RespawnSound');
//	if ( !bCoopWeaponMode || !Inv.IsA('Weapon') )
//		spawn( class 'ReSpawn',,, Inv.Location );
}
*/

event playerpawn Login
(
	string[32] Portal,
	string[120] Options,
	out string[80] Error,
	class<playerpawn> SpawnClass
)
{
	local PlayerPawn      NewPlayer;
	local string[64]      InName, InPassword;
	local pawn			  aPawn;

	NewPlayer =  Super.Login(Portal, Options, Error, SpawnClass);
	if ( NewPlayer != None )
	{
		NewPlayer.bHidden = false;
		NewPlayer.SetCollision(true,true,true);
	}
	return NewPlayer;
}
	
function NavigationPoint FindPlayerStart(optional byte team, optional string[32] incomingName)
{
	local PlayerStart Dest, Candidate[8], Best;
	local float Score[8], BestScore, NextDist;
	local pawn OtherPlayer;
	local int i, num;
	local Teleporter Tel;

//	Log(Self$".FindPlayerStart() for "$incomingName);

	num = 0;
	//choose candidates	
	foreach AllActors( class 'PlayerStart', Dest )
	{
		if ( (/*Dest.bSinglePlayerStart ||*/ Dest.bCoopStart) && !Dest.Region.Zone.bWaterZone )
		{

//			Log(Self$".FindPlayerStart() #"$num$"="$Dest);

			if (num<4)
				Candidate[num] = Dest;
			else if (Rand(num) < 4)
				Candidate[Rand(4)] = Dest;
			num++;
		}
	}

//	Log(Self$".FindPlayerStart num="$num);

	if (num>4) num = 4;
	else if (num == 0)
		return None;

	//assess candidates
	for (i=0;i<num;i++)
		Score[i] = 4000 * FRand(); //randomize

	foreach AllActors( class 'Pawn', OtherPlayer )
	{
		if (OtherPlayer.bIsPlayer)
		{
			for (i=0;i<num;i++)
			{
				NextDist = VSize(OtherPlayer.Location - Candidate[i].Location);
				Score[i] += NextDist;
				if (NextDist < OtherPlayer.CollisionRadius + OtherPlayer.CollisionHeight)
					Score[i] -= 1000000.0;
			}

//			Log(Self$".FindPlayerStart() Candidate["$i$"].Score="$Score[i]);

		}
	}
	
	BestScore = Score[0];
	Best = Candidate[0];
	for (i=1;i<num;i++)
	{
		if (Score[i] > BestScore)
		{
			BestScore = Score[i];
			Best = Candidate[i];
		}
	}

//	Log(Self$".FindPlayerStart() Best="$Best);

	return Best;
}

function int ReduceDamage(int Damage, name DamageType, pawn injured, pawn instigatedBy)
{
	if ( bNoFriendlyFire && (instigatedBy != None) 
		&& instigatedBy.bIsPlayer && injured.bIsPlayer && (instigatedBy != injured) )
		return 0;

	return Super.ReduceDamage(Damage, DamageType, injured, instigatedBy);
}

function bool ShouldRespawn(Actor Other)
{
	if (Other.IsA('Weapon') && !Weapon(Other).bHeldItem) {
		if (Other.IsA('Daktagh') || Other.IsA('Batleth')) {
			return(False);
//			Inventory(Other).ReSpawnTime=Inventory(Other).Default.ReSpawnTime;
		}
		else if (Inventory(Other).ReSpawnTime != 0) {
			Inventory(Other).ReSpawnTime=1.0;
			return(True);
		}
	}
	else if (Other.IsA('Keys') || (Inventory(Other) != None && Inventory(Other).bInstantRespawn)) {
		Inventory(Other).RespawnTime=1.0;
		return(True);
	}
	return(False);
}

function SendPlayer(PlayerPawn P,string[64] URL)
{
	local Pawn	aPawn;

	SendP=P;
	SendURL=URL;
	EndLevel();
}

function PostSendPlayer()
{
	if (Left(Level.Title,4) == "M20C") {
		EndGame();
		return;
	}
	SendP.ClientSetMusic(None,0,7,MTRAN_Instant);
	Log(Self$".PostSendPlayer() Travelling to "$SendURL);
/*
	if (Left(SendURL,3) != "M03" && Left(SendURL,4) != "M20C") {
		Log(Self$".ServerTravel("$SendURL$",True)");
		Level.ServerTravel(SendURL,True);
	}
	else {
		Log(Self$".ServerTravel("$SendURL$",False)");
		Level.ServerTravel(SendURL,False);
	}
*/
	Level.ServerTravel(SendURL,False);
}

/*
function SendPlayer(PlayerPawn aPlayer, string[64] URL)
{
	Level.ServerTravel( URL, true );
}
*/

function Killed(Pawn Killer,Pawn Other,Name DamageType)
{
	local int	BeforeKillCount;

	BeforeKillCount=KillCount;
	Super.Killed(Killer,Other,DamageType);
	if (Other.bIsPlayer) {
		Killer.Score-=2;
		KillCount=BeforeKillCount;
	}
}

/*
function EndGame()
{
	local Pawn	aPawn;

	aPawn=Level.PawnList;
	while (aPawn != None) {
		if (aPawn.bIsPlayer) {
			Log(Self$".EndGame() "$aPawn$".ClientGameEnded()");
			aPawn.ClientGameEnded();
		}	
		aPawn=aPawn.NextPawn;
	}
}
*/

function bool PickupQuery(Pawn Other,Inventory Item)
{
	local Weapon	WInv;
	local Ammo		AInv;
	local Inventory	I;

	if (Other.Inventory == None) {
		return(True);
	}
	if (Item.IsA('Weapon') && Item.ReSpawnTime != 0) {
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

/*
function PlayTeleportEffect(actor Incoming,bool bOut,bool bSound)
{
	local TeleportEffects	T;

	if (TeleportEffect != None) {
		T=Spawn(TeleportEffect,Incoming,,Incoming.Location,Incoming.Rotation);
		if (T != None) {
			T.DrawScale=Incoming.DrawScale;
			T.TeleportDelay=2.0;
		}
	}
	if (TeleportSound != None) {
		Incoming.PlaySound(TeleportSound);
	}
}
*/

defaultproperties
{
     DefaultCoopInv(0)=Class'Klingons.DisruptorRifle'
     DefaultCoopInv(1)=Class'Klingons.AssaultDisruptor'
     DefaultCoopInv(2)=Class'Klingons.Batleth'
     bRestartLevel=False
     bPauseable=False
     MapPrefix="M"
}
