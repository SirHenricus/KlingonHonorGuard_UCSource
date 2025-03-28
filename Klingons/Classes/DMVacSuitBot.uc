//=============================================================================
// DMVacSuitBot.
//=============================================================================
class DMVacSuitBot expands HumanBot;

#call q:\klingons\art\pawns\DMVacSuit\final\DMVacSuit.mac
#exec MESH ORIGIN MESH=DMVacSuit X=0 Y=0 Z=-10 YAW=64

#exec MESH NOTIFY MESH=DMVacSuit SEQ=Swim TIME=0.5 FUNCTION=PlaySwimmingSound

#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddle TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddle TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddleShoot TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddleShoot TIME=0.01 FUNCTION=PlayRightFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddleSlash TIME=0.5 FUNCTION=PlayLeftFootStep
#exec MESH NOTIFY MESH=DMVacSuit SEQ=BackPeddleSlash TIME=0.01 FUNCTION=PlayRightFootStep

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

#exec MESH NOTIFY MESH=DMVacSuit SEQ=Shoot TIME=0.5 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot TIME=0.5 FUNCTION=SpawnShot

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


function ForceMeshToExist()
{
	Spawn(class'DMVacSuit');
}

function PreBeginPlay()
{
	bIsMale = TRUE;
	super.PreBeginPlay();
}

function PlayDying(name DamageType, vector HitLoc)
{
	super.PlayDying(DamageType, HitLoc);
	
	if (SpecialDeath==4)
		PlaySound(DisolveDeath, SLOT_Misc);
	else
		PlaySound(MBigGrunt, SLOT_Misc);
}	

function PlayGutHit(float tweentime)
{
	PlaySound(MGrunt1, SLOT_Misc);
	super.PlayGutHit(tweentime);
}

function PlayHeadHit(float tweentime)
{
	PlaySound(MGrunt2, SLOT_Misc);
	super.PlayHeadHit(tweentime);
}

function PlayLeftHit(float tweentime)
{
	PlaySound(MGrunt1, SLOT_Misc);
	super.PlayLeftHit(tweentime);
}

function PlayRightHit(float tweentime)
{
	PlaySound(MGrunt2, SLOT_Misc);
	super.PlayRightHit(tweentime);
}	

defaultproperties
{
     Wait1=Standing
     Wait2=Wait
     DeadRollBack=DeadBackRoll
     BackPeddle=BackPeddle
     BackPeddleShoot=BackPeddleShoot
     BackPeddleSlash=BackPeddleSlash
     LeftStep=Sound'KlingonSFX01.Player.FootLeft'
     RightStep=Sound'KlingonSFX01.Player.FootRight'
     FGrunt1=Sound'KlingonSFX01.creature.BetorGrunt1'
     FGrunt2=Sound'KlingonSFX01.creature.BetorGrunt2'
     FBigGrunt=Sound'KlingonSFX01.creature.BetorGrunt4'
     MGrunt1=Sound'KlingonSFX01.creature.DurasGruntGrnt1'
     MGrunt2=Sound'KlingonSFX01.creature.DurasGruntGrnt2'
     MBigGrunt=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     DisolveDeath=Sound'KlingonSFX01.creature.DissolveMix2'
     CarcassType=Class'Klingons.DMACCarcass'
     aimerror=1500
     AttitudeToPlayer=ATTITUDE_Hate
     Mesh=Mesh'Klingons.DMVacSuit'
     DrawScale=1.700000
     CollisionHeight=47.000000
}
