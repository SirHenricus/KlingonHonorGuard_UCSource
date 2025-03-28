//=============================================================================
// DMFemaleBot.
//=============================================================================
class DMFemaleBot expands HumanBot;


#call q:\klingons\art\pawns\DMFemale\final\DMFemale.mac
#exec MESH ORIGIN MESH=DMFemale X=0 Y=0 Z=-26 YAW=64

#exec MESH NOTIFY MESH=DMFemale SEQ=Swim TIME=0.5 FUNCTION=PlaySwimmingSound

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

function ForceMeshToExist()
{
	Spawn(class'DMFemale');
}

function PreBeginPlay()
{
	bIsMale = FALSE;
	super.PreBeginPlay();
}

function PlayDying(name DamageType, vector HitLoc)
{
	super.PlayDying(DamageType, HitLoc);
	
	if (SpecialDeath==4)
		PlaySound(DisolveDeath, SLOT_Misc);
	else
		PlaySound(FBigGrunt, SLOT_Misc);
}	

function PlayGutHit(float tweentime)
{
	PlaySound(FGrunt1, SLOT_Misc);
	super.PlayGutHit(tweentime);
}

function PlayHeadHit(float tweentime)
{
	PlaySound(FGrunt2, SLOT_Misc);
	super.PlayHeadHit(tweentime);
}

function PlayLeftHit(float tweentime)
{
	PlaySound(FGrunt1, SLOT_Misc);
	super.PlayLeftHit(tweentime);
}

function PlayRightHit(float tweentime)
{
	PlaySound(FGrunt2, SLOT_Misc);
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
     DisolveDeath=Sound'KlingonSFX01.creature.DissolveMix'
     CarcassType=Class'Klingons.DMFemaleCarcass'
     aimerror=1500
     GroundSpeed=600.000000
     AttitudeToPlayer=ATTITUDE_Hate
     Mesh=Mesh'Klingons.DMFemale'
     DrawScale=1.600000
     CollisionHeight=47.000000
}
