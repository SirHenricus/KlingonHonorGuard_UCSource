//=============================================================================
// DMFemale.
//=============================================================================
class DMFemale expands Human;

#call q:\klingons\art\pawns\DMFemale\final\DMFemale.mac
#exec MESH ORIGIN MESH=DMFemale X=0 Y=0 Z=-26 YAW=64

#exec MESH NOTIFY MESH=DMFemale SEQ=Swim TIME=0.5 FUNCTION=PlaySwimmingSound
#exec MESH NOTIFY MESH=DMFemale SEQ=LadderClimb TIME=0.01 FUNCTION=PlayClimbSound
#exec MESH NOTIFY MESH=DMFemale SEQ=LadderClimb TIME=0.5 FUNCTION=PlayClimbSound

#exec MESH NOTIFY MESH=DMFemale SEQ=BackPeddle TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=BackPeddle TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=BackPeddleShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=BackPeddleShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=BackPeddleSlash TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=BackPeddleSlash TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=Walk TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=Walk TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=Run TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=Run TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=WalkShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=WalkShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=Scooch TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=ScoochShoot TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_AD TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_AD TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_SIT TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_SIT TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_GL TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_GL TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_BFG TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_BFG TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_DR TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_DR TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_RL TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_RL TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_SC TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunShoot_SC TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMFemale SEQ=RunSlash_BAT TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMFemale SEQ=RunSlash_BAT TIME=0.01 FUNCTION=PlayRightFootStep

#exec OBJ LOAD FILE=..\Textures\DMFemaleSkins.utx PACKAGE=Klingons

/*  Taken from unreal female01
#exec AUDIO IMPORT FILE="Sounds\female\mdrown2.WAV" NAME="mdrown2fem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\hgasp3.WAV"  NAME="hgasp3fem"  GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\linjur2.WAV" NAME="linjur1fem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\linjur3.WAV" NAME="linjur2fem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\linjur4.WAV" NAME="linjur3fem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\hinjur4.WAV" NAME="hinjur4fem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\death1d.WAV" NAME="death1dfem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\death2a.WAV" NAME="death2afem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\death3c.WAV" NAME="death3cfem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\death4c.WAV" NAME="death4cfem" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\lland1.WAV"  NAME="lland1fem"  GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\lgasp1.WAV"  NAME="lgasp1fem"  GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\jump1.WAV"  NAME="jump1fem"  GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\female\UWhit01.WAV" NAME="FUWHit1" GROUP="Female"
#exec AUDIO IMPORT FILE="Sounds\Male\UWinjur42.WAV" NAME="MUWHit2" GROUP="Male"

#exec MESH IMPORT MESH=Female1 ANIVFILE=MODELS\Female1_a.3D DATAFILE=MODELS\Female_d.3D X=0 Y=0 Z=0 ZEROTEX=1
#exec MESH ORIGIN MESH=Female1 X=-30 Y=-75 Z=20 YAW=64 ROLL=-64

#exec MESH SEQUENCE MESH=Female1 SEQ=All       STARTFRAME=0   NUMFRAMES=598 
#exec MESH SEQUENCE MESH=Female1 SEQ=GutHit    STARTFRAME=0   NUMFRAMES=1				Group=TakeHit
#exec MESH SEQUENCE MESH=Female1 SEQ=AimDnLg   STARTFRAME=1   NUMFRAMES=1				Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=AimDnSm   STARTFRAME=2   NUMFRAMES=1				Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=AimUpLg   STARTFRAME=3   NUMFRAMES=1				Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=AimUpSm   STARTFRAME=4   NUMFRAMES=1				Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=Taunt1    STARTFRAME=5   NUMFRAMES=15 RATE=15		Group=Gesture
#exec MESH SEQUENCE MESH=Female1 SEQ=Breath1   STARTFRAME=20  NUMFRAMES=7  RATE=6		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=Breath2   STARTFRAME=27  NUMFRAMES=15 RATE=15		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=CockGun   STARTFRAME=42  NUMFRAMES=6  RATE=6		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=Dead2     STARTFRAME=48  NUMFRAMES=18 RATE=12		Group=TakeHit
#exec MESH SEQUENCE MESH=Female1 SEQ=Dead3     STARTFRAME=66  NUMFRAMES=16 RATE=12		Group=TakeHit
#exec MESH SEQUENCE MESH=Female1 SEQ=Dead4     STARTFRAME=82  NUMFRAMES=13 RATE=12		Group=TakeHit
#exec MESH SEQUENCE MESH=Female1 SEQ=Dead5     STARTFRAME=95  NUMFRAMES=16 RATE=12		Group=TakeHit
#exec MESH SEQUENCE MESH=Female1 SEQ=Dead6     STARTFRAME=111 NUMFRAMES=11 RATE=12
#exec MESH SEQUENCE MESH=Female1 SEQ=Dead7     STARTFRAME=122 NUMFRAMES=23 RATE=12
#exec MESH SEQUENCE MESH=Female1 SEQ=DeathEnd  STARTFRAME=481 NUMFRAMES=1
#exec MESH SEQUENCE MESH=Female1 SEQ=DeathEnd2 STARTFRAME=65  NUMFRAMES=1
#exec MESH SEQUENCE MESH=Female1 SEQ=DeathEnd3 STARTFRAME=81  NUMFRAMES=1
#exec MESH SEQUENCE MESH=Female1 SEQ=DuckWlkL  STARTFRAME=145 NUMFRAMES=15 RATE=15		Group=Ducking
#exec MESH SEQUENCE MESH=Female1 SEQ=DuckWlkS  STARTFRAME=160 NUMFRAMES=15 RATE=15		Group=Ducking
#exec MESH SEQUENCE MESH=Female1 SEQ=HeadHit   STARTFRAME=175 NUMFRAMES=1				Group=TakeHit
#exec MESH SEQUENCE MESH=Female1 SEQ=JumpLgFr  STARTFRAME=176 NUMFRAMES=1				Group=Jumping
#exec MESH SEQUENCE MESH=Female1 SEQ=JumpSmFr  STARTFRAME=177 NUMFRAMES=1				Group=Jumping
#exec MESH SEQUENCE MESH=Female1 SEQ=LandLgFr  STARTFRAME=178 NUMFRAMES=1				Group=Landing
#exec MESH SEQUENCE MESH=Female1 SEQ=LandSmFr  STARTFRAME=179 NUMFRAMES=1				Group=Landing
#exec MESH SEQUENCE MESH=Female1 SEQ=LeftHit   STARTFRAME=180 NUMFRAMES=1				Group=TakeHit
#exec MESH SEQUENCE MESH=Female1 SEQ=Look      STARTFRAME=181 NUMFRAMES=25 RATE=15      Group=Waiting //FIXME - can't use! - make much more subtle
#exec MESH SEQUENCE MESH=Female1 SEQ=RightHit  STARTFRAME=206 NUMFRAMES=1				Group=TakeHit
#exec MESH SEQUENCE MESH=Female1 SEQ=RunLg     STARTFRAME=207 NUMFRAMES=10 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=RunLgFr   STARTFRAME=217 NUMFRAMES=10 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=RunSm     STARTFRAME=227 NUMFRAMES=10 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=RunSmFr   STARTFRAME=237 NUMFRAMES=10 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=StillFrRp STARTFRAME=247 NUMFRAMES=15 RATE=15		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=StillLgFr STARTFRAME=262 NUMFRAMES=10 RATE=15		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=StillSmFr STARTFRAME=272 NUMFRAMES=8  RATE=15		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=SwimLg    STARTFRAME=280 NUMFRAMES=18 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=SwimSm    STARTFRAME=298 NUMFRAMES=18 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=TreadLg   STARTFRAME=316 NUMFRAMES=15 RATE=15		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=TreadSm   STARTFRAME=331 NUMFRAMES=15 RATE=15		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=Victory1  STARTFRAME=346 NUMFRAMES=18 RATE=15		Group=Gesture
#exec MESH SEQUENCE MESH=Female1 SEQ=WalkLg    STARTFRAME=364 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=WalkLgFr  STARTFRAME=379 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=WalkSm    STARTFRAME=394 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=WalkSmFr  STARTFRAME=409 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=Wave      STARTFRAME=424 NUMFRAMES=15 RATE=15		Group=Gesture
#exec MESH SEQUENCE MESH=Female1 SEQ=Dead1     STARTFRAME=439 NUMFRAMES=43 RATE=12
#exec MESH SEQUENCE MESH=Female1 SEQ=Walk      STARTFRAME=482 NUMFRAMES=15 RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=TurnLg    STARTFRAME=379 NUMFRAMES=2  RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=TurnSm    STARTFRAME=409 NUMFRAMES=2  RATE=15
#exec MESH SEQUENCE MESH=Female1 SEQ=Taunt1L   STARTFRAME=497 NUMFRAMES=15 RATE=15		Group=Gesture
#exec MESH SEQUENCE MESH=Female1 SEQ=Breath1L  STARTFRAME=512 NUMFRAMES=7  RATE=6		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=Breath2L  STARTFRAME=519 NUMFRAMES=15 RATE=15		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=CockGunL  STARTFRAME=534 NUMFRAMES=6  RATE=6		Group=Waiting
#exec MESH SEQUENCE MESH=Female1 SEQ=LookL     STARTFRAME=540 NUMFRAMES=25 RATE=15      Group=Waiting //FIXME - can't use! - make much more subtle
#exec MESH SEQUENCE MESH=Female1 SEQ=Victory1L STARTFRAME=565 NUMFRAMES=18 RATE=15		Group=Gesture
#exec MESH SEQUENCE MESH=Female1 SEQ=WaveL     STARTFRAME=583 NUMFRAMES=15 RATE=15		Group=Gesture

#exec MESHMAP SCALE MESHMAP=Female1 X=0.056 Y=0.056 Z=0.112
#exec TEXTURE IMPORT NAME=gina FILE=MODELS\gina.PCX GROUP=Skins 
#exec MESHMAP SETTEXTURE MESHMAP=Female1 NUM=0 TEXTURE=gina

#exec MESH NOTIFY MESH=Female1 SEQ=RunLG TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=RunLG TIME=0.75 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=RunLGFR TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=RunLGFR TIME=0.75 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=RunSM TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=RunSM TIME=0.75 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=RunSMFR TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=RunSMFR TIME=0.75 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=WalkLG TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=WalkLG TIME=0.75 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=WalkLGFR TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=WalkLGFR TIME=0.75 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=WalkSM TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=WalkSM TIME=0.75 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=WalkSMFR TIME=0.25 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=WalkSMFR TIME=0.75 FUNCTION=PlayFootStep
#exec MESH NOTIFY MESH=Female1 SEQ=Dead2 TIME=0.92 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Female1 SEQ=Dead3 TIME=0.45 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Female1 SEQ=Dead4 TIME=0.54 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Female1 SEQ=Dead5 TIME=0.68 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Female1 SEQ=Dead6 TIME=0.57 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Female1 SEQ=Dead7 TIME=0.78 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Female1 SEQ=Dead1 TIME=0.46 FUNCTION=LandThump
#exec MESH NOTIFY MESH=Female1 SEQ=Dead1 TIME=0.65 FUNCTION=Convulse
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
     DisolveDeath=Sound'KlingonSFX01.creature.DissolveMix'
     UnderWaterAmbience=Sound'KlingonSFX01.Ambience.UnderwaterLp'
     UnderWaterDamage=Sound'KlingonSFX01.Player.UndrWtrChok'
     SpeechSounds(0)=Sound'KlingonSFX01.Player.FPlayerFerengi'
     SpeechSounds(1)=Sound'KlingonSFX01.Player.FPlayerTrchpfoo'
     SpeechSounds(2)=Sound'KlingonSFX01.Player.FPatheticHom'
     SpeechSounds(3)=Sound'KlingonSFX01.Player.FPlayerGoodDay'
     SpeechSounds(4)=Sound'KlingonSFX01.Player.FPlayerTargistg'
     SpeechSounds(5)=Sound'KlingonSFX01.Player.FPLYRImprssed'
     SpeechSounds(6)=Sound'KlingonSFX01.Player.FPlayerBestUhav'
     SpeechSounds(7)=Sound'KlingonSFX01.Player.FPlayerDucked'
     SpeechSounds(8)=Sound'KlingonSFX01.Player.FPLYRShutup'
     SpeechSounds(9)=Sound'KlingonSFX01.Player.Frdt10'
     SpeechSounds(10)=Sound'KlingonSFX01.Player.FPlayerHndofKls'
     SpeechSounds(11)=Sound'KlingonSFX01.Player.FPlayerBldoath'
     SpeechSounds(12)=Sound'KlingonSFX01.Player.FPlayerOnlyaFoo'
     SpeechSounds(13)=Sound'KlingonSFX01.Player.FPlayerHeal'
     SpeechSounds(14)=Sound'KlingonSFX01.Player.FPlayerNever'
     SpeechSounds(15)=Sound'KlingonSFX01.Player.FPlayerIsthatmy'
     SpeechSounds(17)=Sound'KlingonSFX01.Player.FPlayerSpltem'
     SpeechSounds(18)=Sound'KlingonSFX01.Player.FPlayerLvethtsm'
     SpeechSounds(19)=Sound'KlingonSFX01.Player.FPlayerSmkdBrgt'
     SpeechSounds(20)=Sound'KlingonSFX01.Player.FPlayer1less'
     SpeechSounds(21)=Sound'KlingonSFX01.Player.FPlayerDietired'
     SpeechSounds(22)=Sound'KlingonSFX01.Player.FPlayerStand'
     SpeechSounds(23)=Sound'KlingonSFX01.Player.FPlayerLaugh'
     SpeechSounds(25)=Sound'KlingonSFX01.Player.FPlayerNext'
     SpeechSounds(26)=Sound'KlingonSFX01.Player.FPlayerChopup'
     SpeechSounds(27)=Sound'KlingonSFX01.Player.FPlayerGoKillSo'
     SpeechSounds(28)=Sound'KlingonSFX01.Player.FPlayerSveEmpre'
     SpeechSounds(29)=Sound'KlingonSFX01.Player.FPlayerWhtrudoi'
     SpeechSounds(30)=Sound'KlingonSFX01.Player.FPlayerHello'
     SpeechSounds(31)=Sound'KlingonSFX01.Player.FPlayerHum'
     SummonWingman1=Sound'KlingonSFX01.creature.SMSum1'
     SummonWingman2=Sound'KlingonSFX01.creature.SMSum2'
     SummonWingman3=Sound'KlingonSFX01.creature.SMSum3'
     SummonWingman4=Sound'KlingonSFX01.creature.SMSum4'
     SummonWingman5=Sound'KlingonSFX01.creature.SMSum5'
     CarcassType=Class'Klingons.DMFemaleCarcass'
     HitSound1=Sound'KlingonSFX01.creature.LursaGrunt1'
     HitSound2=Sound'KlingonSFX01.creature.LursaGrunt2'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.BetorGrunt4'
     Mesh=Mesh'Klingons.DMFemale'
     DrawScale=1.600000
     CollisionHeight=47.000000
}
