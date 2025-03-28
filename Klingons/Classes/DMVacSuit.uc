//=============================================================================
// DMVacSuit.
//=============================================================================
class DMVacSuit expands Human;

#call q:\klingons\art\pawns\DMVacSuit\final\DMVacSuit.mac
#exec MESH ORIGIN MESH=DMVacSuit X=0 Y=0 Z=-26 YAW=64

#exec MESH NOTIFY MESH=DMVacSuit SEQ=Swim TIME=0.5 FUNCTION=PlaySwimmingSound
#exec MESH NOTIFY MESH=DMVacSuit SEQ=LadderClimb TIME=0.01 FUNCTION=PlayClimbSound
#exec MESH NOTIFY MESH=DMVacSuit SEQ=LadderClimb TIME=0.5 FUNCTION=PlayClimbSound

#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddle TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddle TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddleShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddleShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddleSlash TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddleSlash TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=Shoot TIME=0.5 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot TIME=0.5 FUNCTION=SpawnShot

#exec MESH NOTIFY MESH=DMVacSuit SEQ=Walk TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=Walk TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=Run TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=Run TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=WalkShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=WalkShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=Scooch TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=ScoochShoot TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_AD TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_AD TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_SIT TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_SIT TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_GL TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_GL TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_BFG TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_BFG TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_DR TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_DR TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_RL TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_RL TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_SC TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot_SC TIME=0.01 FUNCTION=PlayRightFootStep

#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunSlash_BAT TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunSlash_BAT TIME=0.01 FUNCTION=PlayRightFootStep

#exec OBJ LOAD FILE=..\Textures\DMVacSuitSkins.utx PACKAGE=Klingons

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
     bIsMale=True
     SummonWingman1=Sound'KlingonSFX01.creature.SMSum1'
     SummonWingman2=Sound'KlingonSFX01.creature.SMSum2'
     SummonWingman3=Sound'KlingonSFX01.creature.SMSum3'
     SummonWingman4=Sound'KlingonSFX01.creature.SMSum4'
     SummonWingman5=Sound'KlingonSFX01.creature.SMSum5'
     CarcassType=Class'Klingons.DMACCarcass'
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt4'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.KraxDie'
     AnimSequence=DK_BackSlash
     Mesh=Mesh'Klingons.DMVacSuit'
     DrawScale=1.700000
     CollisionHeight=47.000000
}
