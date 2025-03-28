//=============================================================================
// DMMale.
//=============================================================================
class DMMale expands Human;

#call q:\klingons\art\pawns\DMMale\final\DMMale.mac
#exec MESH ORIGIN MESH=DMMale X=0 Y=0 Z=-20 YAW=64

#exec MESH NOTIFY MESH=DMMale SEQ=Swim TIME=0.5 FUNCTION=PlaySwimmingSound
#exec MESH NOTIFY MESH=DMMale SEQ=LadderClimb TIME=0.01 FUNCTION=PlayClimbSound
#exec MESH NOTIFY MESH=DMMale SEQ=LadderClimb TIME=0.5 FUNCTION=PlayClimbSound

#exec MESH NOTIFY MESH=DMMale SEQ=BackPeddle TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=BackPeddle TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=BackPeddleShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=BackPeddleShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=BackPeddleSlash TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=BackPeddleSlash TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=Walk TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=Walk TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=Run TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=Run TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=WalkShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=WalkShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=Scooch TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=ScoochShoot TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_AD TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_AD TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_SIT TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_SIT TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_GL TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_GL TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_BFG TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_BFG TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_DR TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_DR TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_RL TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_RL TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_SC TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunShoot_SC TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMMale SEQ=RunSlash_BAT TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMMale SEQ=RunSlash_BAT TIME=0.01 FUNCTION=PlayRightFootStep

#exec OBJ LOAD FILE=..\Textures\DMMaleSkins.utx PACKAGE=Klingons

/*  Taken from Unreal Male01
#exec MESH IMPORT MESH=Male1 ANIVFILE=MODELS\Male1_a.3D DATAFILE=MODELS\Male_d.3D X=0 Y=0 Z=0 ZEROTEX=1
#exec MESH ORIGIN MESH=Male1 X=150 Y=80 Z=0 YAW=64 ROLL=-64

#exec MESH SEQUENCE MESH=Male1 SEQ=All       STARTFRAME=0   NUMFRAMES=473
#exec MESH SEQUENCE MESH=Male1 SEQ=GutHit    STARTFRAME=0   NUMFRAMES=1  Group=TakeHit
#exec MESH SEQUENCE MESH=Male1 SEQ=AimDnLg   STARTFRAME=1   NUMFRAMES=1  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=AimDnSm   STARTFRAME=2   NUMFRAMES=1  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=AimUpLg   STARTFRAME=3   NUMFRAMES=1  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=AimUpSm   STARTFRAME=4   NUMFRAMES=1  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=Taunt1    STARTFRAME=5   NUMFRAMES=7  RATE=6  Group=Gesture
#exec MESH SEQUENCE MESH=Male1 SEQ=Breath1   STARTFRAME=12  NUMFRAMES=7  RATE=6  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=Breath2   STARTFRAME=19  NUMFRAMES=6  RATE=6  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=CockGun   STARTFRAME=25  NUMFRAMES=8  RATE=6  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=Dead2     STARTFRAME=33  NUMFRAMES=16 RATE=15 Group=TakeHit
#exec MESH SEQUENCE MESH=Male1 SEQ=Dead3     STARTFRAME=49  NUMFRAMES=13 RATE=15 Group=TakeHit
#exec MESH SEQUENCE MESH=Male1 SEQ=Dead4     STARTFRAME=62  NUMFRAMES=16 RATE=15 Group=TakeHit
#exec MESH SEQUENCE MESH=Male1 SEQ=Dead5     STARTFRAME=78  NUMFRAMES=23 RATE=15 Group=TakeHit
#exec MESH SEQUENCE MESH=Male1 SEQ=Dead6     STARTFRAME=101 NUMFRAMES=28 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=Dead7     STARTFRAME=129 NUMFRAMES=21 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=DeathEnd  STARTFRAME=457 NUMFRAMES=1
#exec MESH SEQUENCE MESH=Male1 SEQ=DeathEnd2 STARTFRAME=48  NUMFRAMES=1
#exec MESH SEQUENCE MESH=Male1 SEQ=DeathEnd3 STARTFRAME=61  NUMFRAMES=1
#exec MESH SEQUENCE MESH=Male1 SEQ=DuckWlkL  STARTFRAME=150 NUMFRAMES=15 RATE=15 Group=Ducking
#exec MESH SEQUENCE MESH=Male1 SEQ=DuckWlkS  STARTFRAME=165 NUMFRAMES=15 RATE=15 Group=Ducking
#exec MESH SEQUENCE MESH=Male1 SEQ=HeadHit   STARTFRAME=180 NUMFRAMES=1  Group=TakeHit
#exec MESH SEQUENCE MESH=Male1 SEQ=JumpLgFr  STARTFRAME=181 NUMFRAMES=1  Group=Jumping
#exec MESH SEQUENCE MESH=Male1 SEQ=JumpSmFr  STARTFRAME=182 NUMFRAMES=1  Group=Jumping
#exec MESH SEQUENCE MESH=Male1 SEQ=LandLgFr  STARTFRAME=183 NUMFRAMES=1 Group=Landing
#exec MESH SEQUENCE MESH=Male1 SEQ=LandSmFr  STARTFRAME=184 NUMFRAMES=1 Group=Landing
#exec MESH SEQUENCE MESH=Male1 SEQ=LeftHit   STARTFRAME=185 NUMFRAMES=1 Group=TakeHit
#exec MESH SEQUENCE MESH=Male1 SEQ=Look      STARTFRAME=186 NUMFRAMES=25 RATE=15 Group=Waiting //FIXME - can't use! - make much more subtle
#exec MESH SEQUENCE MESH=Male1 SEQ=RightHit  STARTFRAME=211 NUMFRAMES=1  Group=TakeHit
#exec MESH SEQUENCE MESH=Male1 SEQ=RunLg     STARTFRAME=212 NUMFRAMES=10 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=RunLgFr   STARTFRAME=222 NUMFRAMES=10 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=RunSm     STARTFRAME=232 NUMFRAMES=10 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=RunSmFr   STARTFRAME=242 NUMFRAMES=10 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=StillFrRp STARTFRAME=252 NUMFRAMES=15 RATE=15 Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=StillLgFr STARTFRAME=267 NUMFRAMES=10 RATE=15 Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=StillSmFr STARTFRAME=277 NUMFRAMES=8  RATE=15 Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=SwimLg    STARTFRAME=285 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=SwimSm    STARTFRAME=300 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=TreadLg   STARTFRAME=315 NUMFRAMES=15 RATE=15 Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=TreadSm   STARTFRAME=330 NUMFRAMES=15 RATE=15 Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=Victory1  STARTFRAME=345 NUMFRAMES=25 RATE=15 Group=Gesture
#exec MESH SEQUENCE MESH=Male1 SEQ=WalkLg    STARTFRAME=370 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=WalkLgFr  STARTFRAME=385 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=WalkSm    STARTFRAME=400 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=WalkSmFr  STARTFRAME=415 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Male1 SEQ=Wave      STARTFRAME=430 NUMFRAMES=15 RATE=15 Group=Gesture
#exec MESH SEQUENCE MESH=Male1 SEQ=Dead1     STARTFRAME=445 NUMFRAMES=13 RATE=15  
#exec MESH SEQUENCE MESH=Male1 SEQ=Walk      STARTFRAME=458 NUMFRAMES=15 RATE=15  
#exec MESH SEQUENCE MESH=Male1 SEQ=TurnSm    STARTFRAME=415 NUMFRAMES=2
#exec MESH SEQUENCE MESH=Male1 SEQ=TurnLg    STARTFRAME=385 NUMFRAMES=2
#exec MESH SEQUENCE MESH=Male1 SEQ=Taunt1L   STARTFRAME=473 NUMFRAMES=7  RATE=6  Group=Gesture
#exec MESH SEQUENCE MESH=Male1 SEQ=Breath1L  STARTFRAME=480 NUMFRAMES=7  RATE=6  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=Breath2L  STARTFRAME=487 NUMFRAMES=6  RATE=6  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=CockGunL  STARTFRAME=493 NUMFRAMES=8  RATE=6  Group=Waiting
#exec MESH SEQUENCE MESH=Male1 SEQ=LookL     STARTFRAME=501 NUMFRAMES=25 RATE=15 Group=Waiting //FIXME - can't use! - make much more subtle
#exec MESH SEQUENCE MESH=Male1 SEQ=Victory1L STARTFRAME=526 NUMFRAMES=25 RATE=15 Group=Gesture
#exec MESH SEQUENCE MESH=Male1 SEQ=WaveL     STARTFRAME=551 NUMFRAMES=15 RATE=15 Group=Gesture

#exec TEXTURE IMPORT NAME=Kurgan FILE=MODELS\Kurgan.PCX GROUP=Skins 
#exec MESHMAP SCALE MESHMAP=Male1 X=0.056 Y=0.056 Z=0.112
#exec MESHMAP SETTEXTURE MESHMAP=Male1 NUM=0 TEXTURE=Kurgan

#exec MESH NOTIFY MESH=Male1 SEQ=RunLG TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Male1 SEQ=RunLG TIME=0.75 FUNCTION=PlayMetalStep
#exec MESH NOTIFY MESH=Male1 SEQ=RunLGFR TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Male1 SEQ=RunLGFR TIME=0.75 FUNCTION=PlayMetalStep
#exec MESH NOTIFY MESH=Male1 SEQ=RunSM TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Male1 SEQ=RunSM TIME=0.75 FUNCTION=PlayMetalStep
#exec MESH NOTIFY MESH=Male1 SEQ=RunSMFR TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Male1 SEQ=RunSMFR TIME=0.75 FUNCTION=PlayMetalStep
#exec MESH NOTIFY MESH=Male1 SEQ=WalkLG TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Male1 SEQ=WalkLG TIME=0.75 FUNCTION=PlayMetalStep
#exec MESH NOTIFY MESH=Male1 SEQ=WalkLGFR TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Male1 SEQ=WalkLGFR TIME=0.75 FUNCTION=PlayMetalStep
#exec MESH NOTIFY MESH=Male1 SEQ=WalkSM TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Male1 SEQ=WalkSM TIME=0.75 FUNCTION=PlayMetalStep
#exec MESH NOTIFY MESH=Male1 SEQ=WalkSMFR TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Male1 SEQ=WalkSMFR TIME=0.75 FUNCTION=PlayMetalStep
#exec MESH NOTIFY MESH=Male1 SEQ=Dead2 TIME=0.92 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Male1 SEQ=Dead3 TIME=0.45 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Male1 SEQ=Dead4 TIME=0.54 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Male1 SEQ=Dead5 TIME=0.68 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Male1 SEQ=Dead6 TIME=0.57 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Male1 SEQ=Dead7 TIME=0.78 FUNCTION=LandThump

#exec TEXTURE IMPORT NAME=JMale2 FILE=MODELS\HML_1.PCX GROUP=Skins 
#exec TEXTURE IMPORT NAME=JMale3 FILE=MODELS\HML_2.PCX GROUP=Skins 
#exec TEXTURE IMPORT NAME=JMale4 FILE=MODELS\HML_3.PCX GROUP=Skins 
#exec TEXTURE IMPORT NAME=JMale5 FILE=MODELS\HML_4.PCX GROUP=Skins 
#exec TEXTURE IMPORT NAME=JMale6 FILE=MODELS\HML_5.PCX GROUP=Skins 
#exec TEXTURE IMPORT NAME=JMale7 FILE=MODELS\HML_6.PCX GROUP=Skins 
#exec TEXTURE IMPORT NAME=JMale8 FILE=MODELS\HML_7.PCX GROUP=Skins 

#exec AUDIO IMPORT FILE="Sounds\male\metal01.WAV" NAME="metwalk1" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\male\metal02.WAV" NAME="metwalk2" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\male\metal03.WAV" NAME="metwalk3" GROUP="Male"

simulated function PlayMetalStep()
{
	local sound step;
	local float decision;

	if ( Role < ROLE_Authority )
		return;
	if ( !bIsWalking && (Level.Game.Difficulty > 1) && ((Weapon == None) || !Weapon.bPointing) )
		MakeNoise(0.05 * Level.Game.Difficulty);
	if ( FootRegion.Zone.bWaterZone )
	{
		PlaySound(sound 'LSplash', SLOT_Interact, 1, false, 1000.0, 1.0);
		return;
	}

	decision = FRand();
	if ( decision < 0.34 )
		step = sound'MetWalk1';
	else if (decision < 0.67 )
		step = sound'MetWalk2';
	else
		step = sound'MetWalk3';

	if ( bIsWalking )
		PlaySound(step, SLOT_Interact, 0.5, false, 400.0, 1.0);
	else 
		PlaySound(step, SLOT_Interact, 1, false, 800.0, 1.0);
}
*/

/*
#exec AUDIO IMPORT FILE="Sounds\Male\deathc1.WAV" NAME="MDeath1" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\deathc3.WAV" NAME="MDeath3" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\deathc4.WAV" NAME="MDeath4" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\injurL2.WAV" NAME="MInjur1" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\injurL04.WAV" NAME="MInjur2" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\injurM04.WAV" NAME="MInjur3" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\injurH5.WAV" NAME="MInjur4" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\drownM02.WAV" NAME="MDrown1" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\gasp02.WAV" NAME="MGasp1" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\hgasp1.WAV" NAME="MGasp2" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\jump1.WAV" NAME="MJump1" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\UWinjur41.WAV" NAME="MUWHit1" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\UWinjur42.WAV" NAME="MUWHit2" GROUP="Male"
#exec AUDIO IMPORT FILE="Sounds\Male\lland01.WAV" NAME="lland01" GROUP="Male"

function PlayDying(name DamageType, vector HitLoc)
{
	local vector X,Y,Z, HitVec, HitVec2D;
	local float dotp;
	local carcass carc;

	BaseEyeHeight = Default.BaseEyeHeight;
	PlayDyingSound();
			
	if ( FRand() < 0.15 )
	{
		PlayAnim('Dead2',0.7,0.1);
		return;
	}

	// check for big hit
	if ( (Velocity.Z > 250) && (FRand() < 0.7) )
	{
		if ( (hitLoc.Z > Location.Z) && (FRand() < 0.65) )
		{
			PlayAnim('Dead5',0.7,0.1);
			if ( Level.NetMode != NM_Client )
			{
				carc = Spawn(class 'MaleHead',,, Location + CollisionHeight * vect(0,0,0.8), Rotation + rot(3000,0,16384) );
				if (carc != None)
				{
					carc.Initfor(self);
					carc.Velocity = Velocity + VSize(Velocity) * VRand();
					carc.Velocity.Z = FMax(carc.Velocity.Z, Velocity.Z);
				}
				carc = Spawn(class 'CreatureChunks');
				if (carc != None)
				{
					carc.Mesh = mesh 'CowBody1';
					carc.Initfor(self);
					carc.Velocity = Velocity + VSize(Velocity) * VRand();
					carc.Velocity.Z = FMax(carc.Velocity.Z, Velocity.Z);
				}
				carc = Spawn(class 'Arm1',,, Location + CollisionHeight * vect(0,0,0.8), Rotation + rot(3000,0,16384) );
				if (carc != None)
				{
					carc.Initfor(self);
					carc.Velocity = Velocity + VSize(Velocity) * VRand();
					carc.Velocity.Z = FMax(carc.Velocity.Z, Velocity.Z);
				}
			}
		}
		else
			PlayAnim('Dead1', 0.7, 0.1);
		return;
	}

	// check for head hit
	if ( (DamageType == 'Decapitated') || (HitLoc.Z - Location.Z > 0.6 * CollisionHeight) )
	{
		DamageType = 'Decapitated';
		PlayAnim('Dead4', 0.7, 0.1);
		if ( Level.NetMode != NM_Client )
		{
			carc = Spawn(class 'MaleHead',,, Location + CollisionHeight * vect(0,0,0.8), Rotation + rot(3000,0,16384) );
			if (carc != None)
			{
				carc.Initfor(self);
				carc.Velocity = Velocity + VSize(Velocity) * VRand();
				carc.Velocity.Z = FMax(carc.Velocity.Z, Velocity.Z);
			}
		}
		return;
	}

	GetAxes(Rotation,X,Y,Z);
	X.Z = 0;
	HitVec = Normal(HitLoc - Location);
	HitVec2D= HitVec;
	HitVec2D.Z = 0;
	dotp = HitVec2D dot X;
	
	if (Abs(dotp) > 0.71) //then hit in front or back
		PlayAnim('Dead3', 0.7, 0.1);
	else
	{
		dotp = HitVec dot Y;
		if (dotp > 0.0)
			PlayAnim('Dead6', 0.7, 0.1);
		else
			PlayAnim('Dead7', 0.7, 0.1);
	}
}

function PlayGutHit(float tweentime)
{
	if ( (AnimSequence == 'GutHit') || (AnimSequence == 'Dead2') )
	{
		if (FRand() < 0.5)
			TweenAnim('LeftHit', tweentime);
		else
			TweenAnim('RightHit', tweentime);
	}
	else if ( FRand() < 0.6 )
		TweenAnim('GutHit', tweentime);
	else
		TweenAnim('Dead2', tweentime);

}

function PlayHeadHit(float tweentime)
{
	if ( (AnimSequence == 'HeadHit') || (AnimSequence == 'Dead3') )
		TweenAnim('GutHit', tweentime);
	else if ( FRand() < 0.6 )
		TweenAnim('HeadHit', tweentime);
	else
		TweenAnim('Dead3', tweentime);
}

function PlayLeftHit(float tweentime)
{
	if ( (AnimSequence == 'LeftHit') || (AnimSequence == 'Dead6') )
		TweenAnim('GutHit', tweentime);
	else if ( FRand() < 0.6 )
		TweenAnim('LeftHit', tweentime);
	else 
		TweenAnim('Dead6', tweentime);
}

function PlayRightHit(float tweentime)
{
	if ( (AnimSequence == 'RightHit') || (AnimSequence == 'Dead1') )
		TweenAnim('GutHit', tweentime);
	else if ( FRand() < 0.6 )
		TweenAnim('RightHit', tweentime);
	else
		TweenAnim('Dead1', tweentime);
}
*/

defaultproperties
{
     Wait1=Standing
     Wait2=Wait
     B_ScoochJab=ScoochJab_BAT
     DeadRollBack=DeadBackRoll
     BackPeddle=BackPeddle
     BackPeddleShoot=BackPeddleShoot
     BackPeddleSlash=BackPeddleSlash
     LeftStep=Sound'KlingonSFX01.Player.FootLeft'
     RightStep=Sound'KlingonSFX01.Player.FootRight'
     LeftGravel=Sound'KlingonSFX01.Player.GravelFootLeft'
     RightGravel=Sound'KlingonSFX01.Player.GravelFootRight'
     LeftMetal=Sound'KlingonSFX01.Player.MetalFootLeft'
     RightMetal=Sound'KlingonSFX01.Player.MetalFootRight'
     GaspSound=Sound'KlingonSFX01.Player.Gasp'
     Swimming=Sound'KlingonSFX01.Player.WtrStep1'
     WaterDeath=Sound'KlingonSFX01.Player.WaterDeath'
     GaspDamage=Sound'KlingonSFX01.Player.WtrChokOut'
     DisolveDeath=Sound'KlingonSFX01.creature.DissolveMix2'
     UnderWaterAmbience=Sound'KlingonSFX01.Ambience.UnderwaterLp'
     UnderWaterDamage=Sound'KlingonSFX01.Player.UndrWtrChok'
     SpeechSounds(0)=Sound'KlingonSFX01.Player.PlayerFerengi'
     SpeechSounds(1)=Sound'KlingonSFX01.Player.PlayerTrchpfood'
     SpeechSounds(2)=Sound'KlingonSFX01.Player.PatheticHom'
     SpeechSounds(3)=Sound'KlingonSFX01.Player.PlayerGoodDay'
     SpeechSounds(4)=Sound'KlingonSFX01.Player.PlayerTargistgh'
     SpeechSounds(5)=Sound'KlingonSFX01.Player.PLYRImprssed'
     SpeechSounds(6)=Sound'KlingonSFX01.Player.PlayerBestUhave'
     SpeechSounds(7)=Sound'KlingonSFX01.Player.PlayerDucked2'
     SpeechSounds(8)=Sound'KlingonSFX01.Player.PLYRShutup'
     SpeechSounds(9)=Sound'KlingonSFX01.Player.PlayerNext'
     SpeechSounds(10)=Sound'KlingonSFX01.Player.PlayerHndofKlss'
     SpeechSounds(11)=Sound'KlingonSFX01.Player.PlayerBldOath'
     SpeechSounds(12)=Sound'KlingonSFX01.Player.PlayerOnlyaFool'
     SpeechSounds(13)=Sound'KlingonSFX01.Player.PlayerHeal'
     SpeechSounds(14)=Sound'KlingonSFX01.Player.PlayerNever'
     SpeechSounds(15)=Sound'KlingonSFX01.Player.PlayerIsthatmyD'
     SpeechSounds(16)=Sound'KlingonSFX01.Player.PlayerIsthatmy'
     SpeechSounds(17)=Sound'KlingonSFX01.Player.PlayerSpltem'
     SpeechSounds(18)=Sound'KlingonSFX01.Player.PlayerLvethtsme'
     SpeechSounds(19)=Sound'KlingonSFX01.Player.PlayerSmkdBrgt'
     SpeechSounds(20)=Sound'KlingonSFX01.Player.Player1less'
     SpeechSounds(21)=Sound'KlingonSFX01.Player.PlayerDietired'
     SpeechSounds(22)=Sound'KlingonSFX01.Player.PlayerStand'
     SpeechSounds(23)=Sound'KlingonSFX01.Player.PlayerLaugh'
     SpeechSounds(24)=Sound'KlingonSFX01.Player.PlayerNameonit'
     SpeechSounds(25)=Sound'KlingonSFX01.Player.PlayerNext'
     SpeechSounds(26)=Sound'KlingonSFX01.Player.PlayerChopup'
     SpeechSounds(27)=Sound'KlingonSFX01.Player.PlayerGoKillSom'
     SpeechSounds(28)=Sound'KlingonSFX01.Player.PlayerSveEmpre'
     SpeechSounds(29)=Sound'KlingonSFX01.Player.PlayerWhtrudoin'
     SpeechSounds(30)=Sound'KlingonSFX01.Player.PlayerHello'
     SpeechSounds(31)=Sound'KlingonSFX01.Player.PlayerHum'
     bIsMale=True
     SummonWingman1=Sound'KlingonSFX01.creature.SMSum1'
     SummonWingman2=Sound'KlingonSFX01.creature.SMSum2'
     SummonWingman3=Sound'KlingonSFX01.creature.SMSum3'
     SummonWingman4=Sound'KlingonSFX01.creature.SMSum4'
     SummonWingman5=Sound'KlingonSFX01.creature.SMSum5'
     CarcassType=Class'Klingons.DMMaleCarcass'
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt1'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt2'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.KraxDie'
     Mesh=Mesh'Klingons.DMMale'
     DrawScale=1.650000
     CollisionHeight=47.000000
     Buoyancy=99.000000
}
