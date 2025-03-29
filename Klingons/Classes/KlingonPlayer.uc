//=============================================================================
// KlingonPlayer.
//=============================================================================
class KlingonPlayer expands PlayerPawn;

#exec OBJ LOAD FILE=..\Sounds\KlingonSFX01 PACKAGE=KlingonSFX01

#call q:\Klingons\Art\Pawns\DMMale\Final\DMMale.mac

var vector				BlindVec;

var float				BlindTime,
						RunTime,
						BreathTimer,
						NextBreathTime,
						HeartBeatTimer,
						NextSpeechTime,
						VelocityIdleTime,
						LastApperitionTime;

var bool				bPlayMagSound,
						bMagSoundToggle,
						bMagBootsAttached,
						bNoBlind,
						bPlayClimbOk,
						bShowLevelStats,
						bStealth,
						bHasVacSuit,
						bMissleCam,
						bIsBackPeddling,
						bHideHUD,
						bPlayDeathAVI;

var() sound				BreathSound,
						HeartBeatSound,
						HeartBeatFastSound,
						MagSoundLeft,
						MagSoundRight,
						VacBreathSound,
						GoldEgg;

var(Speech) sound		SpeechSounds[40];

var() float				MagNoiseLevel,
						SpeechFrequency;

var() bool				bIsMale;

var KlingonDamageTypes		PawnDamageTypes;

var GameStats			LevelStats;

var travel KlingonInventory	LogBook;

var actor				FireOffsetActor,
						LadderActor,
						PlayerCamActor,
						OverheadCamActor,
						BehindCamActor;
var int					ActiveCamera;		//0=normal, 1=Overhead, 2=player, 3=Behind

var float				WeaponDamageScale;

var byte				Darkness;

// Wingman Speech
var(Sounds)	sound	SummonWingman1;
var(Sounds)	sound	SummonWingman2;
var(Sounds)	sound	SummonWingman3;
var(Sounds)	sound	SummonWingman4;
var(Sounds)	sound	SummonWingman5;

var const enum EPlayerSpeech
{
	SPEECH_DidThatHurt,
	SPEECH_HehHehHeh,
	SPEECH_PatheticHom,
	SPEECH_AGoodDay,
	SPEECH_MyTarg,
	SPEECH_BeImpressed,
	SPEECH_Traitors,
	SPEECH_ShouldveDucked,
	SPEECH_ShutUp,
	SPEECH_Next,
	SPEECH_IAmTheHand,
	SPEECH_TheBloodOath,
	SPEECH_OnlyAFool,
	SPEECH_HealMyWounds,
	SPEECH_DaktaghToGunFight,
	SPEECH_DaktaghInThroat,
	SPEECH_BatlethInChest,
	SPEECH_SplitEm,
	SPEECH_LoveThatSmell,
	SPEECH_SmokedBregit,
	SPEECH_OneLessCorpse,
	SPEECH_Run,
	SPEECH_DieWithHonor,
	SPEECH_HmHmHmHm,
	SPEECH_DaktaghWithYourName,
	SPEECH_AttitudeNext,
	SPEECH_ChopYouUp,
	SPEECH_GoKillSomething,
	SPEECH_GoSaveTheEmpire,
	SPEECH_WhatAreYouDoing,
	SPEECH_Hello,
	SPEECH_HummingATune
} PlayerSpeech;

var byte				GameKillGoals,
						GameItemGoals,
						GameSecretGoals;

var int					EndLevelTime;

var int					MessiahCount;

var string[255]			CStr;

var texture				MySkin;

var CDMusicTimer		MusicTimer;
var bool OldMouseLook;

var bool				bCOOPEndGame,
						bCOOPEndScreen;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSetCollisionSize;
	unreliable if (Role < ROLE_Authority)
		ServerRequestLevelStats,ReloadWeapon;
	reliable if (Role == ROLE_Authority && RemoteRole == ROLE_AutonomousProxy)
		ClientBlindPlayer,ClientShowMenu,
		HideHUD,ShowHUD,StowWeapon,ShowWeapon,CameraOverlay;
	unreliable if (Role == ROLE_Authority)
		ClientUpdateLevelStats;
}

function ServerSetCollisionSize(float NewRadius,float NewHeight)
{
	SetCollisionSize(NewRadius,NewHeight);
}

function TakeDamage(int Damage,pawn InstigatedBy,vector HitLocation,vector Momentum,name DamageType)
{
	local int	OldHealth;

	OldHealth=Health;
	Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
	if (OldHealth > Health) {
		PawnDamageTypes.DamageTypeFog(OldHealth-Health,Self,DamageType);
	}
}

function ClientBlindPlayer(vector Blindness)
{
	BlindVec=Blindness;
	BlindTime+=(BlindVec.X*0.005); //0.0025);
}

function CheckBlinded(float delta)
{
	local KlingonGameInfo	G;

	if (BlindTime > 0) {
		BlindTime-=delta;
		if (!bNoBlind) {
			ClientFlash(0.0,BlindVec);
		}
	}
	CheckGravityZoneDamage(delta);
	CheckTouchingLadders(delta);
	CheckPhysicalFitness(delta);
	CheckSpeech(delta);
	CheckSightings(delta);
	DrawFireOffsetLocation();
	G=KlingonGameInfo(Level.Game);
	if (G != None) {
		G.PlayRandomAmbience(Self);
	}
}

function CheckGravityZoneDamage(float delta)
{
}

function CheckTouchingLadders(float delta)
{
	local Ladders		L;

	if (Level.NetMode != NM_StandAlone) {
		return;
	}
	if (!IsInState('PlayerClimbing')) {
		foreach TouchingActors(class 'Ladders',L) {
			if (LadderActor == None) {
				LadderActor=L;
				GotoState('PlayerClimbing');
			}
			return;
		}
		LadderActor=None;
	}
}

function CheckPhysicalFitness(float delta)
{
	if (VSize(Velocity) != 0) {
		RunTime+=((VSize(Velocity)*0.0025)*delta);
	}
	else {
		if (RunTime > 0.0) {
			RunTime-=((RunTime*0.025)*delta);
		}
	}
	CheckBreathingSound(delta);
	CheckHeartBeatSound(delta);
}

function CheckBreathingSound(float delta)
{
	local float		BreathVol;

	BreathTimer+=(delta*1.5);
	if ((BreathTimer+(RunTime*0.25)) > NextBreathTime) {
		NextBreathTime=BreathTimer+5+(15*FRand());
		if (bHasVacSuit && VacBreathSound != None) {
			BreathVol=FClamp(((RunTime*0.5)*0.01),0.5,1.0);
			if (Level.NetMode != NM_DedicatedServer) {
				PlaySound(VacBreathSound,SLOT_Interact,BreathVol,True);
			}
		}
		else if (BreathSound != None && !HeadRegion.Zone.bWaterZone) {
			BreathVol=FClamp(((RunTime*0.5)*0.01),0.1,1.0);
			if (Level.NetMode != NM_DedicatedServer) {
				PlaySound(BreathSound,SLOT_Interact,BreathVol,True);
			}
		}
	}
}

function CheckHeartBeatSound(float delta)
{
	local float		HeartBeatVol;

	HeartBeatTimer+=(delta*2.0);
	if (HeartBeatTimer > float(Health)*0.1 || Health < 20) {
		HeartBeatTimer=0.0;
		HeartBeatVol=FClamp((1.0-(float(Health)/float(Default.Health))),0.1,1.0);
		if (Health < 20) {
			if (Level.NetMode != NM_DedicatedServer) {
				PlaySound(HeartBeatFastSound,SLOT_Talk,HeartBeatVol,True);
			}
		}
		else {
			if (Level.NetMode != NM_DedicatedServer) {
				PlaySound(HeartBeatSound,SLOT_Talk,HeartBeatVol,True);
			}
		}
	}
}

function CheckSpeech(float delta)
{
	local float		r;

	if (Level.TimeSeconds > NextSpeechTime) {
		NextSpeechTime=Level.TimeSeconds+SpeechFrequency;
		if (Health <= 20) {
			if (FRand() < 0.1) {
				if (FRand() < 0.5) {
					SayOnlyAFool();
				}
				else {
					SayHealMyWounds();
				}
			}
		}
	}
	if (VSize(Velocity) < 20) {
		VelocityIdleTime+=delta;
		if (VelocityIdleTime >= 30) {
			if (Level.TimeSeconds > NextSpeechTime) {
				NextSpeechTime=Level.TimeSeconds+SpeechFrequency;
				r=FRand();
				if (r < 0.2) {
					SayGoKillSomething();
				}
				else if (r < 0.35) {
					SayGoSaveTheEmpire();
				}
				else if (r < 0.5) {
					SayWhatAreYouDoing();
				}
				else if (r < 0.65) {
					SayHello();
				}
				else if (r < 0.8) {
					SayHummingATune();
				}
			}
		}
	}
	else {
		VelocityIdleTime=0;
	}
}

function CheckSightings(float delta)
{
	local float		r;

	if (Level.NetMode == NM_StandAlone) {
		if (Level.TimeSeconds-Level.Game.StartTime < 300) {
			return;
		}
		if (Level.TimeSeconds-LastApperitionTime > 300) {
			r=FRand();
			if (r > 0.99) {
				SpawnKahless();
				MessiahCount++;
				Log(Self$".SpawnKahless() #"$MessiahCount);
			}
			LastApperitionTime=Level.TimeSeconds;
		}
	}
}

function ViewFrom(actor ViewAct)
{
	if (ViewTarget != None) {
		if (Camera1(ViewTarget) != None) {
			Camera1(ViewTarget).GotoState('DeActivated');
		}
		if (Camera2(ViewTarget) != None) {
			Camera2(ViewTarget).GotoState('DeActivated');
		}
		if (Camera3(ViewTarget) != None) {
			Camera3(ViewTarget).GotoState('DeActivated');
		}
	}
	ViewTarget=ViewAct;
	bBehindView=False;
}

function CheckCameraViewing(float DeltaTime)
{
	local rotator	R;

	if (Camera2(ViewTarget) != None || Camera3(ViewTarget) != None) {
		R=ViewTarget.Rotation;
		R.Pitch+=16.0*DeltaTime*aLookUp;
		R.Yaw+=16.0*DeltaTime*aTurn;
		ViewTarget.SetRotation(R);
		aLookUp=0.0;
		aStrafe=0.0;
		aForward=0.0;
		aTurn=0.0;
	}
}

function DrawFireOffsetLocation()
{
	local vector	L,
					X,Y,Z;

	if (FireOffsetActor != None && Weapon != None) {
		GetAxes(ViewRotation,X,Y,Z);
		L=Location+Weapon.CalcDrawOffset()+Weapon.FireOffset.X*X+Weapon.FireOffset.Y*Y+Weapon.FireOffset.Z*Z;
		FireOffsetActor.SetLocation(L);
	}
}

exec function ReloadWeapon()
{
	if (KlingonWeapons(Weapon) != None) {
		KlingonWeapons(Weapon).DoWeaponReload();
	}
}

exec function StowWeapon()
{
	if (Weapon != None) {
		Weapon.TweenDown();
		Weapon.bWeaponUp=False;
	}
}

exec function ShowWeapon()
{
	if (Weapon != None) {
		Weapon.BringUp();
	}
}

exec function HideHUD()
{
	if (KlingonHUD(myHUD) != None) {
		KlingonHUD(myHUD).HideHUD();
		bHideHUD=True;
	}
}

exec function ShowHUD()
{
	if (KlingonHUD(myHUD) != None && bHideHUD) {
		KlingonHUD(myHUD).ShowHUD();
		bHideHUD=False;
	}
}

exec function CameraOverlay(bool b)
{
	if (KlingonHUD(myHUD) != None) {
		KlingonHUD(myHUD).CameraLook(b);
	}
}

exec function GoggleOverlay(bool b)
{
	if (KlingonHUD(myHUD) != None) {
		KlingonHUD(myHUD).GoggleLook(b);
	}
}

// KVER 06-30-98 Toggle DMHUD mode.
exec function ChangeDMHud()
{
	if ( myHud != None )
		KlingonHUD(myHUD).ChangeDMHud(1);
	myHUD.SaveConfig();
}

exec function SpawnMessiah()
{
	Spawn(class 'Apper01',Self);
}

exec function SpawnKahless()
{
	if (Level.Game != None && Level.Game.IsA('SinglePlayer')) {
		SpawnMessiah();
	}
}

exec function SpawnCamera()
{
	PlayerCamActor=Spawn(class 'CutSceneCamera',Self);
}

function DestroyCamera()
{
	if (PlayerCamActor != None) {
		PlayerCamActor.Destroy();
		if (PlayerCamActor.bDeleteme)
			PlayerCamActor = none;
		
	}
}

exec function PlayerCam()
{
	if (Level.NetMode != NM_StandAlone) {
		return;
	}
	if (ActiveCamera == 1)
	{
		balwaysmouselook = OldMouseLook;
	}
	
	if (OverheadCamActor != none)
		CutSceneCamera(OverheadCamActor).bCameraActive = false;
			
	if (BehindCamActor != none)
		CutSceneCamera(BehindCamActor).bCameraActive = false;

	if (ActiveCamera == 2)
	{
		CutSceneCamera(PlayerCamActor).bCameraActive = false;
		ViewFrom(self);
		ActiveCamera = 0;
	}
	else
	{
		ActiveCamera = 2;
		if (PlayerCamActor == none)
			SpawnCamera();
		else
			ViewFrom(PlayerCamActor);
		CutSceneCamera(PlayerCamActor).bCameraActive = true;
	}
}

function SpawnOverheadCamera()
{
	OverheadCamActor=Spawn(class 'OverheadCamera',Self);
}

function DestroyOverheadCamera()
{
	if (OverheadCamActor != None) {
		OverheadCamActor.Destroy();
		if (OverheadCamActor.bDeleteme)
			OverheadCamActor = none;
	}
}

exec function OverheadCam()
{
	if (Level.NetMode != NM_StandAlone) {
		return;
	}
	if (PlayerCamActor != none)
		CutSceneCamera(PlayerCamActor).bCameraActive = false;
			
	if (BehindCamActor != none)
		CutSceneCamera(BehindCamActor).bCameraActive = false;

	if (ActiveCamera == 1)
	{
		balwaysMouseLook = OldMouseLook;
		CutSceneCamera(OverheadCamActor).bCameraActive = false;
		ViewFrom(self);
		ActiveCamera = 0;
	}
	else
	{
		OldMouseLook = balwaysmouselook;
		balwaysmouselook = false;

		ActiveCamera = 1;
		if (OverheadCamActor == none)
			SpawnOverheadCamera();
		else
			ViewFrom(OverheadCamActor);
		CutSceneCamera(OverheadCamActor).bCameraActive = true;
	}
}


function SpawnBehindCamera()
{
	BehindCamActor=Spawn(class 'BehindCamera',Self);
}

exec function DestroyBehindCamera()
{
	if (BehindCamActor != None) {
		BehindCamActor.Destroy();
		if (BehindCamActor.bDeleteme)
			BehindCamActor = none;
		
	}
}

exec function BehindCam()
{
	if (Level.NetMode != NM_StandAlone) {
		return;
	}
	if (ActiveCamera == 1)
	{
		balwaysmouselook = OldMouseLook;
	}

	if (PlayerCamActor != none)
		CutSceneCamera(PlayerCamActor).bCameraActive = false;
			
	if (OverheadCamActor != none)
		CutSceneCamera(OverheadCamActor).bCameraActive = false;

	if (ActiveCamera == 3)
	{
		CutSceneCamera(BehindCamActor).bCameraActive = false;
		ViewFrom(self);
		ActiveCamera = 0;
	}
	else
	{
		ActiveCamera = 3;
		if (BehindCamActor == none)
			SpawnBehindCamera();
		else
			ViewFrom(BehindCamActor);
		CutSceneCamera(BehindCamActor).bCameraActive = true;
	}

/*	if (BehindCamActor == None) 
	{
		SpawnBehindCamera();
	}
	else
		ViewFrom(BehindCamActor);
*/	
}


exec function SwitchView()
{
	if (Level.NetMode != NM_StandAlone) {
		return;
	}
	if (ActiveCamera == 1)
		balwaysmouselook = OldMouseLook;
		
	ActiveCamera++;
	if (ActiveCamera > 3)
		ActiveCamera = 0;

	switch(ActiveCamera)
	{
		case 0:
			if (PlayerCamActor != none)
				CutSceneCamera(PlayerCamActor).bCameraActive = false;
				
			if (BehindCamActor != none)
				CutSceneCamera(BehindCamActor).bCameraActive = false;

			if (OverheadCamActor != none)
				CutSceneCamera(OverheadCamActor).bCameraActive = false;
				
			ViewFrom(self);		
			break;
		case 1:
			OldMouseLook = balwaysmouselook;
			balwaysmouselook = false;
			if (OverheadCamActor == none)
				SpawnOverheadCamera();
			else
			{
				if (PlayerCamActor != none)
					CutSceneCamera(PlayerCamActor).bCameraActive = false;
					
				if (BehindCamActor != none)
					CutSceneCamera(BehindCamActor).bCameraActive = false;

				CutSceneCamera(OverheadCamActor).bCameraActive = true;
				ViewFrom(OverheadCamActor);
			}
			break;
		case 2:
		
			if (PlayerCamActor == none)
				SpawnCamera();
			else
			{	
				if (OverheadCamActor != none)
					CutSceneCamera(OverheadCamActor).bCameraActive = false;
					
				if (BehindCamActor != none)
					CutSceneCamera(BehindCamActor).bCameraActive = false;

				CutSceneCamera(PlayerCamActor).bCameraActive = true;
				ViewFrom(PlayerCamActor);
			}
			break;
		case 3:

			if (BehindCamActor == none)
				SpawnBehindCamera();
			else
			{
				if (PlayerCamActor != none)
					CutSceneCamera(PlayerCamActor).bCameraActive = false;
					
				if (OverheadCamActor != none)
					CutSceneCamera(OverheadCamActor).bCameraActive = false;

			
				CutSceneCamera(BehindCamActor).bCameraActive = true;
				ViewFrom(BehindCamActor);
			}
			break;
	}
}

exec function SwitchViewTo(int Camera)
{
	if (Level.NetMode != NM_StandAlone) {
		return;
	}
	SwitchViewToImmediate(Camera);
}

function SwitchViewToImmediate(int Camera)
{
	if (Level.NetMode != NM_StandAlone) {
		return;
	}
	if (ActiveCamera == 1)
		balwaysmouselook = OldMouseLook;

	ActiveCamera = camera;
	if (ActiveCamera > 3)
		ActiveCamera = 0;

	switch(ActiveCamera)
	{
		case 0:
			if (PlayerCamActor != none)
				CutSceneCamera(PlayerCamActor).bCameraActive = false;
				
			if (BehindCamActor != none)
				CutSceneCamera(BehindCamActor).bCameraActive = false;

			if (OverheadCamActor != none)
				CutSceneCamera(OverheadCamActor).bCameraActive = false;
				
			ViewFrom(self);		
			break;
		case 1:
			OldMouseLook = balwaysmouselook;
			balwaysmouselook = false;
			if (OverheadCamActor == none)
				SpawnOverheadCamera();
			else
			{
				if (PlayerCamActor != none)
					CutSceneCamera(PlayerCamActor).bCameraActive = false;
					
				if (BehindCamActor != none)
					CutSceneCamera(BehindCamActor).bCameraActive = false;

				CutSceneCamera(OverheadCamActor).bCameraActive = true;
				ViewFrom(OverheadCamActor);
			}
			break;
		case 2:
		
			if (PlayerCamActor == none)
				SpawnCamera();
			else
			{	
				if (OverheadCamActor != none)
					CutSceneCamera(OverheadCamActor).bCameraActive = false;
					
				if (BehindCamActor != none)
					CutSceneCamera(BehindCamActor).bCameraActive = false;

				CutSceneCamera(PlayerCamActor).bCameraActive = true;
				ViewFrom(PlayerCamActor);
			}
			break;
		case 3:

			if (BehindCamActor == none)
				SpawnBehindCamera();
			else
			{
				if (PlayerCamActor != none)
					CutSceneCamera(PlayerCamActor).bCameraActive = false;
					
				if (OverheadCamActor != none)
					CutSceneCamera(OverheadCamActor).bCameraActive = false;

			
				CutSceneCamera(BehindCamActor).bCameraActive = true;
				ViewFrom(BehindCamActor);
			}
			break;
	}
}


exec function MissleCam(bool b)
{
	bMissleCam=b;
}

exec function SpawnWingman()
{
	local float		rnd;
	
	if (Level.NetMode == NM_StandAlone) {
		Spawn(class 'MaleWingman',Self);
		Spawn(class 'MaleWingman2',Self);

		rnd = FRand();
		if (rnd>0.8)
			PlaySound(SummonWingman1, SLOT_Talk);
		else if (rnd>0.6)
			PlaySound(SummonWingman2, SLOT_Talk);
		else if (rnd>0.4)
			PlaySound(SummonWingman3, SLOT_Talk);
		else if (rnd>0.2)
			PlaySound(SummonWingman4, SLOT_Talk);
		else
			PlaySound(SummonWingman5, SLOT_Talk);
	}
}

exec function IWantMy2000Dollars()
{
	if (Level.NetMode == NM_StandAlone) {
		Spawn(class 'MaleWingman',Self);
		Spawn(class 'MaleWingman2',Self);
		PlaySound(GoldEgg,SLOT_Talk,1.0,True);
	}
}

exec function Gilman()
{
	if (Level.NetMode == NM_StandAlone) {
		Spawn(class 'MaleWingman',Self);
		Spawn(class 'MaleWingman2',Self);
		PlaySound(GoldEgg,SLOT_Talk,1.0,True);
	}
}

exec function DebugFireOffset()
{
	if (FireOffsetActor == None) {
		FireOffsetActor=Spawn(class 'FireOffsetMarker');
		if (Weapon != None) {
			ClientMessage(Weapon.FireOffset);
		}
	}
	else {
		FireOffsetActor.Destroy();
	}
}

exec function FireOffsetX(float delta)
{
	if (Weapon != None) {
		Weapon.FireOffset.X+=delta;
		ClientMessage(Weapon.FireOffset);
	}
}

exec function FireOffsetY(float delta)
{
	if (Weapon != None) {
		Weapon.FireOffset.Y+=delta;
		ClientMessage(Weapon.FireOffset);
	}
}

exec function FireOffsetZ(float delta)
{
	if (Weapon != None) {
		Weapon.FireOffset.Z+=delta;
		ClientMessage(Weapon.FireOffset);
	}
}

exec function ShowDarkPoints()
{
	local DarkPoint		A;

	foreach AllActors(class 'DarkPoint',A) {
		A.bHidden=False;
	}
}

exec function HideDarkPoints()
{
	local DarkPoint		A;

	foreach AllActors(class 'DarkPoint',A) {
		A.bHidden=True;
	}
}

exec function SayDidThatHurt()
{
	SaySpeech(SPEECH_DidThatHurt);
}

exec function SayHehHehHeh()
{
	SaySpeech(SPEECH_HehHehHeh);
}

exec function SayPatheticHom()
{
	SaySpeech(SPEECH_PatheticHom);
}

exec function SayAGoodDay()
{
	SaySpeech(SPEECH_AGoodDay);
}

exec function SayMyTarg()
{
	SaySpeech(SPEECH_MyTarg);
}

exec function SayBeImpressed()
{
	SaySpeech(SPEECH_BeImpressed);
}

exec function SayTraitors()
{
	SaySpeech(SPEECH_Traitors);
}

exec function SayShouldveDucked()
{
	SaySpeech(SPEECH_ShouldveDucked);
}

exec function SayShutUp()
{
	SaySpeech(SPEECH_ShutUp);
}

exec function SayNext()
{
	SaySpeech(SPEECH_Next);
}

exec function SayIAmTheHand()
{
	SaySpeech(SPEECH_IAmTheHand);
}

exec function SayTheBloodOath()
{
	SaySpeech(SPEECH_TheBloodOath);
}

exec function SayOnlyAFool()
{
	SaySpeech(SPEECH_OnlyAFool);
}

exec function SayHealMyWounds()
{
	SaySpeech(SPEECH_HealMyWounds);
}

exec function SayDaktaghToGunFight()
{
	SaySpeech(SPEECH_DaktaghToGunFight);
}

exec function SayDaktaghInThroat()
{
	SaySpeech(SPEECH_DaktaghInThroat);
}

exec function SayBatlethInChest()
{
	SaySpeech(SPEECH_BatlethInChest);
}

exec function SaySplitEm()
{
	SaySpeech(SPEECH_SplitEm);
}

exec function SayLoveThatSmell()
{
	SaySpeech(SPEECH_LoveThatSmell);
}

exec function SaySmokedBregit()
{
	SaySpeech(SPEECH_SmokedBregit);
}

exec function SayOneLessCorpse()
{
	SaySpeech(SPEECH_OneLessCorpse);
}

exec function SayRun()
{
	SaySpeech(SPEECH_Run);
}

exec function SayDieWithHonor()
{
	SaySpeech(SPEECH_DieWithHonor);
}

exec function SayHmHmHmHm()
{
	SaySpeech(SPEECH_HmHmHmHm);
}

exec function SayDaktaghWithYourName()
{
	SaySpeech(SPEECH_DaktaghWithYourName);
}

exec function SayAttitudeNext()
{
	SaySpeech(SPEECH_AttitudeNext);
}

exec function SayChopYouUp()
{
	SaySpeech(SPEECH_ChopYouUp);
}

exec function SayGoKillSomething()
{
	SaySpeech(SPEECH_GoKillSomething);
}

exec function SayGoSaveTheEmpire()
{
	SaySpeech(SPEECH_GoSaveTheEmpire);
}

exec function SayWhatAreYouDoing()
{
	SaySpeech(SPEECH_WhatAreYouDoing);
}

exec function SayHello()
{
	SaySpeech(SPEECH_Hello);
}

exec function SayHummingATune()
{
	SaySpeech(SPEECH_HummingATune);
}

exec function SaySpeech(EPlayerSpeech s)
{
	if (Level.NetMode == NM_DedicatedServer) {
		return;
	}
	if (HeadRegion.Zone.bWaterZone) {
		return;
	}
	if (SpeechSounds[s] != None) {
		PlaySound(SpeechSounds[s],SLOT_Talk,1.0,True);
	}
}

exec function SaySpeechInt(int s)
{
	if (Level.NetMode == NM_DedicatedServer) {
		return;
	}
	if (HeadRegion.Zone.bWaterZone) {
		return;
	}
	if (SpeechSounds[s] != None) {
		PlaySound(SpeechSounds[s],SLOT_Talk,1.0,True);
	}
}

exec function ActivateMagBoots()
{
	local inventory	Inv;

	Inv=FindInventoryType(class 'MagBoots');
	if (MagBoots(Inv) != None && !Inv.bActive) {
		MagBoots(Inv).GotoState('Activated');
	}
}

exec function DeActivateMagBoots()
{
	local inventory	Inv;

	Inv=FindInventoryType(class 'MagBoots');
	if (MagBoots(Inv) != None && Inv.bActive) {
		MagBoots(Inv).GotoState('DeActivated');
	}
}

exec function ToggleLevelStats()
{
	bShowLevelStats=!bShowLevelStats;
}

function ClientUpdateLevelStats(int NewET,int NewKC,int NewKG,int NewIC,int NewIG,int NewSC,int NewSG)
{
	if (LevelStats != None) {
		LevelStats.RefreshStats(NewET,NewKC,NewKG,NewIC,NewIG,NewSC,NewSG);
	}
}

function ServerUpdateLevelStats()
{
	local int				ET,KC,KG,IC,IG,SC,SG;
	local KlingonGameInfo	K;

	ET=Level.TimeSeconds-Level.Game.StartTime;
	if (!IsInState('LevelEnded') || EndLevelTime == 0) {
		EndLevelTime=ET;
	}
	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		KC=K.KillCount;
		IC=K.ItemCount;
		SC=K.SecretCount;
		KG=Level.Game.KillGoals;
		IG=Level.Game.ItemGoals;
		SG=Level.Game.SecretGoals;
	}
	else {
		KC=KillCount;
		IC=ItemCount;
		SC=SecretCount;
		KG=Level.Game.KillGoals;
		IG=Level.Game.ItemGoals;
		SG=Level.Game.SecretGoals;
	}
	ClientUpdateLevelStats(EndLevelTime,KC,KG,IC,IG,SC,SG);
}

function ServerRequestLevelStats()
{
	local KlingonGameInfo	K;

	if (KlingonGameInfo(Level.Game) != None) {
		K=KlingonGameInfo(Level.Game);
		if (K.LevelStats != None) {
			K.LevelStats.UpdateClient(Self);
		}
	}
}

event PostRender(canvas Canvas)
{
	Super.PostRender(Canvas);
	if (bShowLevelStats) {
		if (LevelStats == None) {
			LevelStats=Spawn(class 'GameStats',Self);
		}
		if (LevelStats != None) {
			LevelStats.ShowStats(Canvas);
		}
	}
}

event PostBeginPlay()
{
	Super.PostBeginPlay();
	MusicTimer = spawn(class'CDMusicTimer',self);

	if (PawnDamageTypes == None) {
		PawnDamageTypes=spawn(class 'KlingonDamageTypes');
	}
	if ( LogBook == None )
	{
		LogBook=spawn(class 'KlingonInventory');
		AddInventory (LogBook);
//		LogBook.ResetAVI();
	}
	if (Role == ROLE_Authority) {
		GameKillGoals=Level.Game.KillGoals;
		GameItemGoals=Level.Game.ItemGoals;
		GameSecretGoals=Level.Game.SecretGoals;
	}
	// Temp
	bPlayDeathAVI=True;

	ClientSetMusic(Level.Song,Level.SongSection,Level.CdTrack,MTRAN_Fade);
}

event Destroyed()
{
	Super.Destroyed();
	if (LevelStats != None) {
		LevelStats.Destroy();
	}
	if (PawnDamageTypes != None) {
		PawnDamageTypes.Destroy();
	}
}

function PlayClimbing()
{
}

function Died(pawn Killer,name DamageType,vector HitLocation)
{
	HideHUD();
	LightType=Default.LightType;
	LightBrightness=Default.LightBrightness;
	LightHue=Default.LightHue;
	LightPeriod=Default.LightPeriod;
	LightPhase=Default.LightPhase;
	VolumeBrightness=Default.VolumeBrightness;
	VolumeRadius=Default.VolumeRadius;
	LightRadius=Default.LightRadius;
	VolumeFog=Default.VolumeFog;
	bHidden=Default.bHidden;
	ScaleGlow=Default.ScaleGlow;
	Style=Default.Style;
	BlindTime=0;
	if (Weapon != None) {
		Weapon.Style=Weapon.Default.Style;
		Weapon.bHidden=Weapon.Default.bHidden;
		Weapon.ScaleGlow=Weapon.Default.ScaleGlow;
	}
	Super.Died(Killer,DamageType,HitLocation);
}

exec function SwitchWeapon(byte F)
{
	if (Weapon != None && Weapon.bWeaponUp) {
		Super.SwitchWeapon(F);
	}
}

/*
exec function ClientLevelEnded()
{
	GotoState('LevelEnded');
}
*/

function bool ViewTargetFire(optional float F)
{
	if (ViewTarget == None) {
		return(False);
	}
	if (Camera3(ViewTarget) != None) {
		Camera3(ViewTarget).Fire(F);
		return(True);
	}
	else if (CameraMonitor(ViewTarget) != None) {
		CameraMonitor(ViewTarget).UnTrigger(Self,Self);
		return(True);
	}
	return(False);
}

function bool ViewTargetAltFire(optional float F)
{
	if (ViewTarget == None) {
		return(False);
	}
	if (Camera3(ViewTarget) != None) {
		Camera3(ViewTarget).AltFire(F);
		return(True);
	}
	else if (CameraMonitor(ViewTarget) != None) {
		CameraMonitor(ViewTarget).UnTrigger(Self,Self);
		return(True);
	}
	return(False);
}

state Dying
{
	ignores SeePlayer,
			HearNoise,
			KilledBy,
			Bump,
			HitWall,
			HeadZoneChange,
			FootZoneChange,
			ZoneChange,
			SwitchWeapon,
			Falling;

	exec function Fire(optional float F)
	{
		if ((Level.NetMode == NM_Standalone) && !Level.Game.IsA('DeathMatchGame')) {
			if (bFrozen) {
				return;
			}
			RestartLevel();
		}
		else {
			ServerRestartPlayer();
		}
	}
	exec function AltFire( optional float F )
	{
		Fire(F);
	}
	function Timer()
	{
		Fire(0);
	}
	function BeginState()
	{
		Super.BeginState();
		bFrozen = false;
		SetTimer(60.0, false);		
	}
}

state PlayerWalking
{
	exec function Fire(optional float F)
	{
		if (!ViewTargetFire(F)) {
			Super.Fire(F);
		}
	}
	exec function AltFire(optional float F)
	{
		if (!ViewTargetAltFire(F)) {
			Super.AltFire(F);
		}
	}
	singular function ZoneChange(ZoneInfo NewZone)
	{
		Super.ZoneChange(NewZone);
		if (Abs(NewZone.ZoneGravity.Z) <= 100.0 || NewZone.bGravityZone) {
			ActivateMagBoots();
		}
	}
	event PlayerTick(float delta)
	{
		CheckCameraViewing(delta);
		Super.PlayerTick(delta);
		CheckBlinded(delta);
	}
	function PlayerMove(float delta)
	{
		local actor		A;
		local vector	Ext,
						EndLoc,
						HitLoc,
						HitNor;

		if (bIsCrouching) {
			if (CollisionHeight > Default.CollisionHeight/2.0) {
				ServerSetCollisionSize(CollisionRadius,Default.CollisionHeight/2.0);
				BaseEyeHeight=0;
			}
		}
		else if (CollisionHeight != Default.CollisionHeight) {
			EndLoc=Location+(vect(0,0,1)*Default.CollisionHeight);
			Ext=(vect(1,1,0)*CollisionRadius); //+(vect(0,0,1)*CollisionHeight);
			A=Trace(HitLoc,HitNor,EndLoc,Location,False,Ext);
			if (A == None) {
				ServerSetCollisionSize(CollisionRadius,Default.CollisionHeight);
				BaseEyeHeight=Default.BaseEyeHeight;
			}
			else {
				BaseEyeHeight=0;
				bIsCrouching=True;
			}
		}
		GroundSpeed=Default.GroundSpeed;
		if (Level.Game != None && Level.Game.IsA('SinglePlayer')) {
			GroundSpeed*=0.6667;
		}
		WaterSpeed=Default.WaterSpeed;
		if (aForward < 0.0) {
			bIsBackPeddling=True;
			GroundSpeed*=0.5;
			WaterSpeed*=0.5;
		}
		else {
			bIsBackPeddling=False;
		}
		Super.PlayerMove(delta);
	}
	function BeginState()
	{
		if (Physics == PHYS_Interpolating) {
			StartWalk();
			ShowWeapon();
		}
		if (bHideHUD) {
			ShowHUD();
		}
		if (Weapon != None && !Weapon.bWeaponUp) {
			Weapon.BringUp();
		}
		Super.BeginState();
	}
}

state FeigningDeath
{
	ignores	SeePlayer,HearNoise,Bump; //,Fire,AltFire;

	exec function Fire(optional float F)
	{
		ViewTargetFire(F);
	}
	exec function AltFire(optional float F)
	{
		ViewTargetAltFire(F);
	}
	event PlayerTick(float delta)
	{
		CheckCameraViewing(delta);
		Super.PlayerTick(delta);
		CheckBlinded(delta);
	}
}

state PlayerSwimming
{
	ignores SeePlayer,HearNoise,Bump;

	exec function Fire(optional float F)
	{
		if (!ViewTargetFire(F)) {
			Super.Fire(F);
		}
	}
	exec function AltFire(optional float F)
	{
		if (!ViewTargetAltFire(F)) {
			Super.AltFire(F);
		}
	}
	event PlayerTick(float delta)
	{
		CheckCameraViewing(delta);
		Super.PlayerTick(delta);
		CheckBlinded(delta);
	}
}

state PlayerFlying
{
	ignores SeePlayer,HearNoise,Bump;

	exec function Fire(optional float F)
	{
		if (!ViewTargetFire(F)) {
			Super.Fire(F);
		}
	}
	exec function AltFire(optional float F)
	{
		if (!ViewTargetAltFire(F)) {
			Super.AltFire(F);
		}
	}
	event PlayerTick(float delta)
	{
		CheckCameraViewing(delta);
		Super.PlayerTick(delta);
		CheckBlinded(delta);
	}
}

state PlayerWaking
{
	ignores SeePlayer,HearNoise,KilledBy,Bump,HitWall,HeadZoneChange,
			FootZoneChange,ZoneChange,SwitchWeapon,Falling;

	exec function Fire(optional float F)
	{
		if (!ViewTargetFire(F)) {
			Super.Fire(F);
		}
	}
	exec function AltFire(optional float F)
	{
		if (!ViewTargetAltFire(F)) {
			Super.AltFire(F);
		}
	}
	event PlayerTick(float delta)
	{
		CheckCameraViewing(delta);
		Super.PlayerTick(delta);
		CheckBlinded(delta);
	}
}

state AntiGravFly
{
	ignores	SeePlayer,
			HearNoise,
			Bump;

	function AnimEnd()
	{
		PlaySwimming();
	}
	exec function Fire(optional float F)
	{
		if (!ViewTargetFire(F)) {
			Super.Fire(F);
		}
	}
	exec function AltFire(optional float F)
	{
		if (!ViewTargetAltFire(F)) {
			Super.AltFire(F);
		}
	}
	event PlayerTick(float DeltaTime)
	{
		CheckCameraViewing(DeltaTime);
		if (bUpdatePosition) {
			ClientUpdatePosition();
		}
		PlayerMove(DeltaTime);
		CheckBlinded(DeltaTime);
	}
	function PlayerMove(float DeltaTime)
	{
		local actor		A;
		local vector	NewAccel,
						X,Y,Z,
						Ext,
						EndLoc,
						HitLoc,
						HitNor;
		local rotator	OldRotation;

		EndLoc=Location-(vect(0,0,10)*Default.CollisionHeight);
		Ext=(vect(1,1,0)*CollisionRadius);
		A=Trace(HitLoc,HitNor,EndLoc,Location,False,Ext);
		if (A == None) {
			if (Physics != PHYS_Falling) {
				SetPhysics(PHYS_Falling);
			}
			NewAccel=Acceleration;
		}
		else {
			if (Physics != PHYS_Flying) {
				SetPhysics(PHYS_Flying);
			}
			GetAxes(ViewRotation,X,Y,Z);
			aForward*=0.2;
			aStrafe*=0.2;
			aLookup*=0.24;
			aTurn*=0.24;
			NewAccel=aForward*X+aStrafe*Y+(vect(0,0,25.0)*Sin(2*Level.TimeSeconds));
		}
		OldRotation=Rotation;
		UpdateRotation(DeltaTime,2);
		if (Role < ROLE_Authority) {
			ReplicateMove(DeltaTime,NewAccel,DODGE_None,OldRotation-Rotation);
		}
		else {
			ProcessMove(DeltaTime,NewAccel,DODGE_None,OldRotation-Rotation);
		}
	}
	function BeginState()
	{
		SetPhysics(PHYS_Flying);
		if (!IsAnimating()) {
			PlayWalking();
		}
	}
}

state MagBootWalk
{
	ignores	AnimEnd,
			SeePlayer,
			HearNoise,
			Bump;

	function MagWalk()
	{
	}
	
	function MagWait()
	{
	}
	
	function MagJump()
	{
	}
	
	exec function Fire(optional float F)
	{
		if (!ViewTargetFire(F)) {
			Super.Fire(F);
		}
	}
	exec function AltFire(optional float F)
	{
		if (!ViewTargetAltFire(F)) {
			Super.AltFire(F);
		}
	}
	singular function ZoneChange(ZoneInfo NewZone)
	{
		Super.ZoneChange(NewZone);
		if (Abs(NewZone.ZoneGravity.Z) > 100.0 && !NewZone.bGravityZone) {
			DeActivateMagBoots();
		}
	}
	event PlayerTick(float DeltaTime)
	{
		CheckCameraViewing(DeltaTime);
		if (bUpdatePosition) {
			ClientUpdatePosition();
		}
		PlayerMove(DeltaTime);
		CheckBlinded(DeltaTime);
	}
	// Called every PlayerTick()
	function PlayerMove(float DeltaTime)
	{
		local vector	Ext,
						HitLoc,
						HitNor,
						EndLoc,
						ForwardAccel,
						NewAccel,
						X,Y,Z;
		local rotator	R,OldRotation;
		local actor		HitActor;

		GetAxes(ViewRotation,X,Y,Z);
		aForward*=0.05;
		aStrafe*=0.05;
		aLookup*=0.24;
		aTurn*=0.24;
		if (ViewRotation.Pitch > 16384 && ViewRotation.Pitch < 49152) {
			aTurn=-aTurn;
		}
		bMagBootsAttached=False;
		R=ViewRotation;
		R.Pitch-=16384.0;
		EndLoc=Location+(Vector(R)*250.0);
		HitActor=Trace(HitLoc,HitNor,EndLoc,Location,False); //,Ext);
		if (HitActor.IsA('LevelInfo')) { // == Level) {
			if (Physics != PHYS_None) {
				SetPhysics(PHYS_None);
			}
			NewAccel=(HitNor*-950.0);
			ForwardAccel=(aForward*X+aStrafe*Y)*Abs(Sin(6*Level.TimeSeconds));
			NewAccel+=ForwardAccel;
			if (aForward != 0 || aStrafe != 0) {
				if (aForward > 0) {
					bIsBackPeddling = FALSE;
					MagWalk();
				}
				else {
					bIsBackPeddling = TRUE;
					MagWalk();
				}
			}
			else {
				MagWait();
			}
			if (bPlayMagSound) {
				if (VSize(ForwardAccel) < 60.0) {
					bPlayMagSound=False;
					if (bMagSoundToggle) {
						if (Level.NetMode != NM_DedicatedServer) {
							PlaySound(MagSoundLeft,SLOT_Misc);
						}
						MakeNoise(MagNoiseLevel);
						bMagSoundToggle=False;
					}
					else {
						if (Level.NetMode != NM_DedicatedServer) {
							PlaySound(MagSoundRight,SLOT_Misc);
						}
						MakeNoise(MagNoiseLevel);
						bMagSoundToggle=True;
					}
				}
			}
			else if (VSize(ForwardAccel) >= 60.0) {
				bPlayMagSound=True;
			}
			SetRotation(rotator(HitNor));
			bMagBootsAttached=True;
		}
		else {
			SetPhysics(PHYS_Falling);
			MagJump();
		}
//		if (Physics == PHYS_Falling) {
//			NewAccel=Acceleration;
//		}
		OldRotation=Rotation;
		UpdateRotation(DeltaTime,1);
		if (Role < ROLE_Authority) { // then save this move and replicate it
			ReplicateMove(DeltaTime,NewAccel,DodgeDir,OldRotation-Rotation);
		}
		else if (Physics == PHYS_None) {
			ProcessMove(DeltaTime,NewAccel,DodgeDir,OldRotation-Rotation);
		}
	}
	// Called from PlayerMove() every PlayerTick()
	function UpdateRotation(float DeltaTime,float maxPitch)
	{
		local rotator	NewRotation;
	
		DesiredRotation=ViewRotation;
		ViewRotation.Pitch+=32.0*DeltaTime*aLookUp;
		ViewRotation.Pitch=ViewRotation.Pitch&65535;
		ViewRotation.Yaw+=32.0*DeltaTime*aTurn;
		ViewShake(deltaTime);
		ViewFlash(deltaTime);
		NewRotation=ViewRotation;
		SetRotation(NewRotation);
	}
	// Called from ReplicateMove()
	function ProcessMove(float DeltaTime,vector NewAccel,eDodgeDir DodgeMove,rotator DeltaRot)
	{
		MoveSmooth(NewAccel*DeltaTime);
	}
	function BeginState()
	{
		if (Physics != PHYS_Falling) {
			SetPhysics(PHYS_None);
		}
	}
	function EndState()
	{
		DeActivateMagBoots();
		bMagBootsAttached=False;
	}
}

state PlayerClimbing
{
	ignores SeePlayer,
			HearNoise,
			Bump;

	exec function Fire(optional float F)
	{
		ViewTargetFire(F);
	}
	exec function AltFire(optional float F)
	{
		ViewTargetAltFire(F);
	}
	exec function SwitchWeapon(byte F)
	{
	}
	function AnimEnd()
	{
		bPlayClimbOk=True;
	}
	function Timer()
	{
		if (Weapon != None && Weapon.bWeaponUp) {
			StowWeapon();
		}
	}
	function Landed(vector HitNormal)
	{
		Global.Landed(HitNormal);
		if (DodgeDir == DODGE_Active) {
			DodgeDir=DODGE_Done;
			DodgeClickTimer=0.0;
			Velocity*=0.1;
		}
		else {
			DodgeDir=DODGE_None;
		}
	}
	function Dodge(vector X,vector Y,vector Z)
	{
		if (bIsCrouching || (Physics == PHYS_Falling)) {
			return;
		}
		if (DodgeDir == DODGE_Forward) {
			Velocity=1.5*GroundSpeed*X+(Velocity Dot Y)*Y;
		}
		else if (DodgeDir == DODGE_Back) {
			Velocity=-1.5*GroundSpeed*X+(Velocity Dot Y)*Y;
		}
		else if (DodgeDir == DODGE_Left) {
			Velocity=1.5*GroundSpeed*Y+(Velocity Dot X)*X;
		}
		else if (DodgeDir == DODGE_Right) {
			Velocity=-1.5*GroundSpeed*Y+(Velocity Dot X)*X;
		}
		DodgeDir=DODGE_Active;
		PlayDuck();
		Velocity.Z=160;
		SetPhysics(PHYS_Falling);				
	}
	event PlayerTick(float DeltaTime)
	{
		CheckCameraViewing(DeltaTime);
		if (bUpdatePosition) {
			ClientUpdatePosition();
		}
		PlayerMove(DeltaTime);
		CheckBlinded(DeltaTime);
	}
	function PlayerMove(float DeltaTime)
	{
		local rotator			NewRotation;
		local vector			NewAccel,
								X,Y,Z;
		local EDodgeDir 		OldDodge;
		local bool				bStillTouching;
		local Ladders			L;

		GetAxes(ViewRotation,X,Y,Z);
		aForward*=0.1;
		aStrafe*=0.1;
		if (DodgeClickTime > 0.0) {
			if (DodgeDir < DODGE_Active) {
				OldDodge=DodgeDir;
				DodgeDir=DODGE_None;
				if (bEdgeForward && bWasForward) {
					DodgeDir=DODGE_Forward;
				}
				if (bEdgeBack && bWasBack) {
					DodgeDir=DODGE_Back;
				}
				if (bEdgeLeft && bWasLeft) {
					DodgeDir=DODGE_Left;
				}
				if (bEdgeRight && bWasRight) {
					DodgeDir=DODGE_Right;
				}
				if (DodgeDir == DODGE_None) {
					DodgeDir=OldDodge;
				}
				else if (DodgeDir != OldDodge) {
					DodgeClickTimer=DodgeClickTime+0.5*DeltaTime;
				}
				else {
					Dodge(X,Y,Z);
				}
			}
			if (DodgeDir == DODGE_Done) {
				DodgeClickTimer-=DeltaTime;
				if (DodgeClickTimer < -0.35) {
					DodgeDir=DODGE_None;
					DodgeClickTimer=DodgeClickTime;
				}
			}		
			else if ((DodgeDir != DODGE_None) && (DodgeDir != DODGE_Active)) {
				DodgeClickTimer-=DeltaTime;			
				if (DodgeClickTimer < 0) {
					DodgeDir=DODGE_None;
					DodgeClickTimer=DodgeClickTime;
				}
			}
		}
		NewAccel=(aForward*Vector(ViewRotation)*vect(0,0,0.5)+aStrafe*Y)*Abs(Sin(2*Level.TimeSeconds));
		UpdateRotation(DeltaTime,1);
		if (Role < ROLE_Authority) { // then save this move and replicate it
			ReplicateMove(DeltaTime,NewAccel,DodgeDir,rot(0,0,0));
		}
		else {
			ProcessMove(DeltaTime,NewAccel,DodgeDir,rot(0,0,0));
		}
		if (VSize(NewAccel) != 0.0 && bPlayClimbOk) {
			PlayClimbing();
			bPlayClimbOk=False;
		}
		if (Level.NetMode == NM_StandAlone) {
			bStillTouching=False;
			foreach TouchingActors(class 'Ladders',L) {
				bStillTouching=True;
			}
			if (!bStillTouching) {
				GotoState('PlayerWalking');
			}
		}
	}
	function UpdateRotation(float DeltaTime,float maxPitch)
	{
		aLookup*=0.3;
		aTurn*=0.3;
		ViewRotation.Pitch+=32.0*DeltaTime*aLookUp;
		ViewRotation.Pitch=ViewRotation.Pitch&65535;
		if ((ViewRotation.Pitch > 18000) && (ViewRotation.Pitch < 49152)) {
			if (aLookUp > 0) {
				ViewRotation.Pitch=18000;
			}
			else {
				ViewRotation.Pitch=49152;
			}
		}
		ViewRotation.Yaw+=32.0*DeltaTime*aTurn;
		if (LadderActor != None) {
			SetRotation(LadderActor.Rotation);
		}
	}
	function ProcessMove(float DeltaTime,vector NewAccel,eDodgeDir DodgeMove,rotator DeltaRot)
	{
		Acceleration=NewAccel;
		if (!MoveSmooth(NewAccel*DeltaTime)) {
//			GotoState('PickupWeaponIdle');
			GotoState('PlayerWalking');
		}
	}
	function EndState()
	{
		local vector	NewVel;

		SetPhysics(PHYS_Falling);
		if (Acceleration.Z > 0.0 && LadderActor != None) {
			NewVel=vector(LadderActor.Rotation)*100.0;
			NewVel.Z=JumpZ;
			AddVelocity(NewVel);
		}
		else {
			Velocity=vect(0,0,0);
		}
		Acceleration=vect(0,0,0);
	}
	function BeginState()
	{
		SetTimer(0.25,False);
		SetPhysics(PHYS_None);
		PlayClimbing();
		if (Level.NetMode == NM_StandAlone) {
			bPlayClimbOk=False;
		}
		else {
			bPlayClimbOk=True;
		}
		Velocity=vect(0,0,0);
		Acceleration=vect(0,0,0);
	}
/*
Begin:
	SetTimer(0.25,False);
	SetPhysics(PHYS_None);
	if (AnimRate == 0.0) {
		PlayClimbing();
		bPlayClimbOk=False;
	}
	Log(Self$".State="$GetStateName()$" Physics="$Physics);
*/
}

/*
state PickupWeaponIdle
{
Begin:
	if (Weapon != None && !Weapon.bWeaponUp) {
		Weapon.BringUp();
//		Weapon.FinishAnim();
	}
	GotoState('PlayerWalking');
}
*/

state LockControls
{
	exec function Fire(optional float F)
	{
	}
	exec function AltFire(optional float F)
	{
	}
	exec function SwitchWeapon(byte F)
	{
	}
	function Trigger(actor Other,pawn EventInstigator)
	{
		GotoState('UnLockControls');
	}
//	function Timer()
//	{
//		GotoState('UnLockControls');
//	}
//	function EndState()
//	{
//		Enable('PlayerInput');
//	}
//	function BeginState()
//	{
//		Disable('PlayerInput');
//	}
Begin:
	Velocity=vect(0,0,0);
	Acceleration=vect(0,0,0);
}

state UnLockControls
{
Begin:
	GotoState('PlayerWalking');
}

state IntroScene
{
	exec function Fire(optional float F)
	{
		ShowMenu();
	}
	exec function AltFire(optional float F)
	{
		Fire(0);
	}
	exec function SwitchWeapon(byte F)
	{
	}
	function Timer()
	{
		if (KlingonHUD(myHUD) != None) {
			KlingonHUD(myHUD).AllowMenu(True);
		}
	}
	function Trigger(actor Other,pawn EventInstigator)
	{
	}
Begin:
	SetTimer(10,False);
	Velocity=vect(0,0,0);
	Acceleration=vect(0,0,0);
}

state LevelEnded
{
	ignores	Bump,HitWall,
			HeadZoneChange,FootZoneChange,ZoneChange,
			SwitchWeapon,
			TakeDamage,Falling;

	exec function Fire(optional float F)
	{
		local KlingonGameInfo	K;

		bShowLevelStats=False;
		K=KlingonGameInfo(Level.Game);
		if (K != None) {
			if (CStr != "") {
				ConsoleCommand(CStr);
				CStr="";
			}
			K.PostSendPlayer();
		}
	}
	exec function AltFire(optional float F)
	{
		Fire(F);
	}
	function Timer()
	{
		if (bCOOPEndGame) {
			bShowLevelStats=False;
			ClientSetMusic(None,0,8,MTRAN_Instant);
			SetTimer(196,True);
		}
		else {
			Fire(0);
		}
	}
	event PostRender(canvas Canvas)
	{
		local float		XRatio,YRatio;
		local int		TU,TV;
		local texture	Coop1,Coop2,Coop3,Coop4;

		if (bCOOPEndScreen) {
			Coop1=texture'coop_p1';
			Coop2=texture'coop_p2';
			Coop3=texture'coop_p3';
			Coop4=texture'coop_p4';
			XRatio=Canvas.ClipX*0.0015625;
			YRatio=Canvas.ClipY*0.0020833333333;
			Canvas.DrawColor.r=255;
			Canvas.DrawColor.g=255;
			Canvas.DrawColor.b=255;
			Canvas.bNoSmooth=true;
			Canvas.Style=1;
			TU=320*XRatio;
			TV=330*YRatio;
			Canvas.SetPos(0,0);
			Canvas.DrawTile(Coop1,TU,TV,0,0,Coop1.UClamp,Coop1.VClamp);
			Canvas.DrawTile(Coop2,TU,TV,0,0,Coop2.UClamp,Coop2.VClamp);
			Canvas.SetPos(0,TV);
			TU=320*XRatio;
			TV=150*YRatio;
			Canvas.DrawTile(Coop3,TU,TV,0,0,Coop3.UClamp,Coop3.VClamp/2);
			Canvas.DrawTile(Coop4,TU,TV,0,0,Coop4.UClamp,Coop4.VClamp/2);
		}
		Global.PostRender(Canvas);
	}
	function RemovePawnActors()
	{
		local Pawn		P;

		foreach AllActors(class 'Pawn',P) {
			if (!P.bIsPlayer) {
				P.GotoState('GameEnded');
			}
		}
	}
	function BeginState()
	{
		if (Level.NetMode != NM_StandAlone) {
			if (Left(Level.Title,4) == "M20C") {
				bCOOPEndGame=True;
				bCOOPEndScreen=True;
			}
		}
		Velocity=vect(0,0,0);
		Acceleration=vect(0,0,0);
		StowWeapon();
		if (KlingonHUD(myHUD) != None) {
			KlingonHUD(myHUD).TimerStop();
		}
		HideHUD();
		bShowLevelStats=True;
		if (!bCOOPEndGame) {
			RemovePawnActors();
			if (!Region.Zone.bWaterZone) {
				if (Left(Level.Title,3) != "M01" && Left(Level.Title,4) != "M20B") {
					if (Level.Game != None && Level.Game.IsA('SinglePlayer')) {
						SpawnCamera();
					}
					LoopAnim('Win');
				}
			}
			ClientSetMusic(None,0,7,MTRAN_Instant);
			SetTimer(90,False);
		}
		else {
			SetTimer(10,False);
		}
	}
	function EndState()
	{
		bCOOPEndGame=False;
		bCOOPEndScreen=False;
		bShowLevelStats=False;
	}
}

state GameEnded
{
	exec function Fire(optional float F)
	{
		ClientShowMenu();
	}
	exec function AltFire(optional float F)
	{
		Fire(0);
	}
	event PostRender(canvas Canvas)
	{
		local string[64]	S;
		local int			X,Y;
		local int			L,XL,YL;

		if (Level.LevelAction != LEVACT_None) {
			return;
		}
		S="PRESS FIRE TO CONTINUE";
		if (Canvas.ClipX >= 512) {
			Canvas.Font=Font'hLRedFont';
		}
		else {
			Canvas.Font=Font'hMRedFont';
		}
		L=Len(S);
		Canvas.StrLen(S,L,0,XL,YL);
		X=(Canvas.ClipX*0.5)-(XL*0.5);
		Y=(Canvas.ClipY*0.5)-(YL*0.5);
		Canvas.SetPos(X,Y);
		Canvas.DrawText(S,False);
		Global.PostRender(Canvas);
	}
	function BeginState()
	{
		if (KlingonHUD(myHUD) != None) {
			KlingonHUD(myHUD).AllowMenu(True);
		}
		Super.BeginState();
	}
}

function ClientShowMenu()
{
	ShowMenu();
}

exec function ShowMenu()
{
	if ( KlingonHUD(myHUD).bAllowMenu == true )
	{
		bShowLevelStats=false;
	
		WalkBob = vect(0,0,0);
		bShowMenu = true; // menu is responsible for turning this off
		Player.Console.GotoState('Menuing');
			
		if( Level.Netmode == NM_Standalone )
			SetPause(true);
	}
}

exec function QuickSave()
{
	if (KlingonHUD(myHUD).bAllowMenu == True) {
		Super.QuickSave();
	}
}

exec function QuickLoad()
{
	if (KlingonHUD(myHUD).bAllowMenu == True) {
		Super.QuickLoad();
	}
}

function ClientSetMusic( music NewSong, byte NewSection, byte NewCdTrack, EMusicTransition NewTransition )
{
	if (newCdTrack != 255)
	{
		if ( KlingonHUD(MyHUD) != None ) 
		{
			if ( KlingonHUD(MyHUD).MusicOn == true )
			{	
				Song        = NewSong;
				SongSection = NewSection;
				CdTrack     = NewCdTrack;
				Transition  = NewTransition;
				
				MusicTimer.TrackNumber = NewCdTrack;
				if (!MusicTimer.IsInState('PlayTracks'))
					MusicTimer.GotoState('PlayTracks');
			}
		}
	}
	else
	{
		Song        = NewSong;
		SongSection = NewSection;
		CdTrack     = NewCdTrack;
		Transition  = NewTransition;
		MusicTimer.GotoState('StopTracks');
	}
}

exec function BehindView( Bool B )
{
	if (Level.NetMode != NM_StandAlone) {
		return;
	}

	bBehindView = B;
}

defaultproperties
{
     BreathSound=Sound'KlingonSFX01.Player.KlingBreathSlow'
     HeartBeatSound=Sound'KlingonSFX01.Player.HeartSlow'
     HeartBeatFastSound=Sound'KlingonSFX01.Player.HeartMed'
     MagSoundLeft=Sound'KlingonSFX01.Player.MagBootLeft'
     MagSoundRight=Sound'KlingonSFX01.Player.MagBootRight'
     VacBreathSound=Sound'KlingonSFX01.Player.VacSuit'
     GoldEgg=Sound'KlingonSFX01.creature.SMEgg'
     MagNoiseLevel=0.250000
     SpeechFrequency=5.000000
     GroundSpeed=600.000000
     AirSpeed=400.000000
     AccelRate=800.000000
     JumpZ=340.000000
     BaseEyeHeight=38.000000
     UnderWaterTime=30.000000
     bIsKillGoal=False
     AnimSequence=Run
     DrawType=DT_Mesh
     DrawScale=1.250000
     CollisionHeight=45.000000
     Buoyancy=85.000000
}
