//=============================================================================
// DWCaptain.
//=============================================================================
class DWCaptain expands Humanoids;

#call q:\klingons\art\pawns\DWCapt\final\DWCapt.mac
#exec MESH ORIGIN MESH=pawndurascapt X=0 Y=-15 Z=-14 YAW=64

#exec MESH NOTIFY MESH=pawndurascapt SEQ=ShootAD           TIME=0.35 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawndurascapt SEQ=RunShootAD        TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafRightShootAD TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafLeftShootAD  TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawndurascapt SEQ=KneelShootAD      TIME=0.35 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StunShootAD       TIME=0.7  FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=pawndurascapt SEQ=WalkAD            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawndurascapt SEQ=WaitAD            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawndurascapt SEQ=VictoryDanceBA    TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawndurascapt SEQ=WalkBA            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawndurascapt SEQ=WaitIdleBA        TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=pawndurascapt SEQ=OverHeadHitBA     TIME=0.5 FUNCTION=OverHeadDamageTarget
#exec MESH NOTIFY MESH=pawndurascapt SEQ=OverHeadHitBA     TIME=0.2 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=pawndurascapt SEQ=SlashBA           TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=pawndurascapt SEQ=SlashBA           TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=pawndurascapt SEQ=BackSlashBA       TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=pawndurascapt SEQ=BackSlashBA       TIME=0.1 FUNCTION=KlingonGrunt


#exec MESH NOTIFY MESH=pawndurascapt SEQ=BackPeddleAD   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=BackPeddleAD   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=BackPeddleBA   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=BackPeddleBA   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafLeftBA   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafLeftBA   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafRightBA   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafRightBA   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=RunBA   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=RunBA   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafLeftShootAD   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafLeftShootAD   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafLeftAD   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafLeftAD   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafRightShootAD   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafRightShootAD   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafRightAD   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=StrafRightAD   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=WalkBA   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=WalkBA   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=WalkAD   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=WalkAD   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=RunAD   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=RunAD   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=RunShootAD   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawndurascapt SEQ=RunShootAD   			TIME=0.66 FUNCTION=FootStepRunSound

#exec MESH NOTIFY MESH=pawndurascapt SEQ=ReloadAD       TIME=0.18 FUNCTION=ReloadSound

#alwaysexec MESH NOTIFY MESH=pawndurascapt SEQ=SharpenBA       TIME=0.1 FUNCTION=Sharpen


//////////////////Variables///////////////////////
// Melee damage.


///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;
	// Melee Animations
	DuckMelee1 = 'DuckBA';
	StrafLeftMelee1 = 'StrafLeftBA';
	StrafRightMelee1 = 'StrafRightBA';
	RollLeftMelee1 = 'RollLeftBA';
	RollRightMelee1 = 'RollRightBA';
	WaitIdleMelee1 = 'WaitIdleBA';
	WaitIdleMelee2 = 'SharpenBA';
	WaitIdleMelee3 = 'WaitFlipBA';
	WaitIdleMelee4 = 'SharpenBA';
	StunnedMelee1 = 'StunBA';
	StunnedSquirmMelee1 = 'StunSquirmBA';
	StunnedGetupMelee1 = 'StunGetupBA';
	OverheadHitMelee1 = 'OverheadHitBA';
	StabMelee1 = '';
	SlashMelee1 = 'SlashBA';
	BackSlashMelee1 = 'BackSlashBA';
	HitGutMelee1 = 'HitGutBA';
	HitRightMelee1 = 'HitRightBA';
	HitLeftMelee1 = 'HitLeftBA';
	HitHeadMelee1 = 'HitHeadBA';
	RunMelee1 = 'RunBA';
	BackPeddleMelee1 = 'BackPeddleBA';
	ThreatenMelee1 = 'BackSlashBA' ;
	ThreatenMelee2 = 'OverHeadHitBA';
	ThreatenMelee3 = 'VictoryDanceBA';
	CommandMelee1 = 'ButtonWallAD';
	CommandMelee2 = 'ButtonWallAD';
	WalkMelee1 = 'WalkBA';
	InAirMelee1 = 'JumpBA';
	LandMelee1 = 'LandBA';	
	DeathRitualMelee1 = 'HowlBA';

	// Ranged Animations
	DuckRanged1 = 'DuckAD';
	StrafLeftRanged1 = 'StrafLeftAD';
	StrafLeftShootRanged1 = 'StrafLeftShootAD';
	StrafRightRanged1 = 'StrafRightAD';
	StrafRightShootRanged1 = 'StrafRightShootAD';
	RollLeftRanged1 = 'RollLeftAD';
	RollRightRanged1 = 'RollRightAD';
	WaitIdleRanged1 = 'WaitAD';
	WaitIdleRanged2 = 'LookRightAD';
	WaitIdleRanged3 = 'LookLeftAD';
	WaitIdleRanged4 = 'CheckAD';
	StunnedRanged1 = 'StunAD';
	StunnedSquirmRanged1 = 'StunSquirmAD';
	StunnedShootRanged1 = 'StunShootAD';
	StunnedGetupRanged1 = 'StunGetupAD';
	CheckRanged1 = 'CheckAD';
	ReloadRanged1 = 'ReloadAD';
	KneelShootRanged1 = 'KneelShootAD';
	ShootRanged1 = 'ShootAD';
	HitGutRanged1 = 'HitGutAD';
	HitRightRanged1 = 'HitRightAD';
	HitLeftRanged1 = 'HitLeftAD';
	HitHeadRanged1 = 'HitHeadAD';
	RunRanged1 = 'RunAD';
	BackPeddleRanged1 = 'BackPeddleAD';
	RunShootRanged1 = 'RunShootAD';
	SwimRanged1 = 'RunAD';
	WalkRanged1 = 'WalkAD';
	InAirRanged1 = 'JumpAD';
	LandRanged1 = 'LandAD';	
	DeathRitualRanged1 = 'HowlAD';
	
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBlownRight';
	DeadBlownLeft1 = 'DeadBlownLeft';
	DeadFallFace1 = 'DeadFallFace';
	DeadFallBack1 = 'DeadFallBack';
	DeadFallRight1 = 'DeadFallRight';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'VictoryDanceBA';
	VictoryDance2 = 'VictoryDanceBA';


	Super.PreBeginPlay();
}

/* PreSetMovement()
*/
function PreSetMovement()
{
	MaxDesiredSpeed = 1.0; /*XXXUnreal 0.7 + 0.1 * skill */
	bCanJump = true;
	bCanWalk = true;
	bCanSwim = false;
	bCanFly = false;
	MinHitWall = -0.6;
	bCanOpenDoors = true;
	bCanDoSpecial = true;
	bCanDuck = true;
}


function bool IsMeleeAnim()
{
	if (!bHasRangedAttack)
	{
		return true;
	}
	else
		return (right(AnimSequence, 2) == "BA"); 
}


function Sharpen()
{
	PlaySound(sound 'SharpBat',SLOT_Interact,,,VoiceRadius);
}

function OverHeadDamageTarget()
{
	if ( MeleeDamageTarget(OverHeadDamage, (OverHeadDamage * 500 * Normal(Target.Location - Location))) )
		PlaySound(FleshSlice, SLOT_Interact,,,VoiceRadius);
}	


function PlayMeleeAttack()
{
	local float decision;

	decision = FRand();
	if (decision < 0.2)
	{
		PlayAnim(SlashMelee1); 
		PlaySound(slash,SLOT_Interact,,,VoiceRadius);
	}
 	else if (decision < 0.6)
 	{
   		PlayAnim(BackSlashMelee1);
   		PlaySound(backslash,SLOT_Interact,,,VoiceRadius);
   	}
 	else if (decision < 0.8)
 	{
 		PlayAnim('FlipBA');
 	}
 	else
 	{
 		PlayAnim(OverHeadHitMelee1);
 		PlaySound(overhead,SLOT_Interact,,,VoiceRadius);
 	} 
}


function PlayWaiting()
{
	local float decision;

	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	
		
	if (GetAnimGroup(AnimSequence) == 'Ducking')
	{
		TweenAnim(AnimSequence, 1.0);
		return;
	}	
	decision = FRand();
	if (Frand() < 0.2)
		SpawnBreath();


	if (IsMeleeAnim())
	{
		
		if (decision < 0.2)
			PlayAnim(WaitIdleMelee2, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.4)
			PlayAnim(WaitIdleMelee3, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.6) 	
			PlayAnim(WaitIdleMelee4, 0.6 + 0.3* FRand(),0.8);
		else
			LoopAnim(WaitIdleMelee1, 0.6 + 0.3* FRand(),0.8);
	}
	else
	{
		if (decision < 0.2)
			PlayAnim(WaitIdleRanged2, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.4)
			PlayAnim(WaitIdleRanged3, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.6)
			PlayAnim(WaitIdleRanged4, 0.6 + 0.3* FRand(),0.8);
		else
			LoopAnim(WaitIdleRanged1, 0.6 + 0.3* FRand(),0.8);
	}
}

defaultproperties
{
     SlashDamage=10
     BackSlashDamage=8
     slash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     backslash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     fleshslice=Sound'KlingonSFX01.Weapons.Bathit'
     Die2=Sound'KlingonSFX01.creature.DthRatKling3'
     Command1=Sound'KlingonSFX01.creature.DurCapCom1B'
     Acquire2=Sound'KlingonSFX01.creature.DurasGruntDie'
     Threaten2=Sound'KlingonSFX01.creature.DurCapThreat2'
     ReloadSound1=Sound'KlingonSFX01.Weapons.AssultLd2'
     DeathRitualSound1=Sound'KlingonSFX01.creature.KlingDeathHowl3'
     Grunt1=Sound'KlingonSFX01.creature.MDktaghBackfist'
     Grunt2=Sound'KlingonSFX01.creature.MDktaghBackslas'
     Grunt3=Sound'KlingonSFX01.creature.MDktaghSlash1'
     Grunt4=Sound'KlingonSFX01.creature.MDktaghSlash1'
     CarcassType=Class'Klingons.DWCaptCarcass'
     TimeBetweenAttacks=2.000000
     Aggressiveness=0.100000
     RefireRate=0.330000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.AssaultProjectile'
     ProjectileSpeed=1250.000000
     Acquire=Sound'KlingonSFX01.creature.DurasGruntSurre'
     Threaten=Sound'KlingonSFX01.creature.DurasGruntKill'
     bCanBeStunned=True
     bCanUseCover=True
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=8
     DodgeAmount=0.200000
     Accuracy=550.000000
     MediumDamage=Texture'KlingonFX01.creatures.DWCaptouch1'
     HeavyDamage=Texture'KlingonFX01.creatures.DWCaptouch2'
     MySide=Duras
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=50.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=90
     Intelligence=BRAINS_HUMAN
     Skill=1.000000
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt1'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.DthRatKling1'
     CombatStyle=0.300000
     AnimSequence=WaitAD
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnDurasCapt'
     DrawScale=1.600000
     CollisionHeight=49.750000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=90.000000
}
