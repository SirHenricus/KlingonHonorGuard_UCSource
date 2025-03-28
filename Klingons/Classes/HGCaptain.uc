//=============================================================================
// HGCaptain.
//=============================================================================
class HGCaptain expands Humanoids;

#call q:\klingons\art\pawns\HGCapt\final\HGCapt.mac
#exec MESH ORIGIN MESH=PawnHonorGuardCapt X=0 Y=0 Z=-21 YAW=64

#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=ShootGL           TIME=0.2  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WalkShootGL       TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=RunShootGL        TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafRightShootGL TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafLeftShootGL  TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=KneelShootGL      TIME=0.2  FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StunShootGL       TIME=0.63 FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WalkGL            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WaitGL            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=VictoryDanceBA    TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WalkBA            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WaitIdleBA        TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=OverHeadHitBA TIME=0.5 FUNCTION=OverHeadDamageTarget
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=OverHeadHitBA TIME=0.2 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=SlashBA       TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=SlashBA       TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=BackSlashBA   TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=BackSlashBA   TIME=0.1 FUNCTION=KlingonGrunt

#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=BackPeddleGL   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=BackPeddleGL   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=BackPeddleBA   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=BackPeddleBA   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafLeftBA   		TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafLeftBA   		TIME=0.66 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafRightBA   		TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafRightBA   		TIME=0.66 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=RunBA   				TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=RunBA   				TIME=0.66 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafLeftShootGL   	TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafLeftShootGL   	TIME=0.66 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafLeftGL   		TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafLeftGL   		TIME=0.66 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafRightShootGL   	TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafRightShootGL   	TIME=0.66 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafRightGL   		TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=StrafRightGL   		TIME=0.66 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WalkBA   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WalkBA   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WalkGL   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=WalkGL   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=RunGL   				TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=RunGL   				TIME=0.66 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=RunShootGL   			TIME=0.13 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=RunShootGL   			TIME=0.66 FUNCTION=FootStepSound

#exec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=ReloadGL   TIME=0.57 FUNCTION=ReloadSound
#alwaysexec MESH NOTIFY MESH=PawnHonorGuardCapt SEQ=SharpenBA       TIME=0.1 FUNCTION=Sharpen


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
	WaitIdleMelee2 = 'WaitFlipBA';
	WaitIdleMelee3 = 'WaitFlipBA';
	WaitIdleMelee4 = 'SharpenBA';
	StunnedMelee1 = 'StunBA';
	StunnedSquirmMelee1 = 'StunSquirmBA';
	StunnedGetupMelee1 = 'StunGetupBA';
	StabMelee1 = 'StabBA';
	SlashMelee1 = 'SlashBA';
	BackSlashMelee1 = 'BackSlashBA';
	HitGutMelee1 = 'HitGutBA';
	HitRightMelee1 = 'HitRightBA';
	HitLeftMelee1 = 'HitLeftBA';
	HitHeadMelee1 = 'HitHeadBA';
	RunMelee1 = 'RunBA';
	BackPeddleMelee1 = 'BackPeddleBA';
	ThreatenMelee1 = 'VictoryDanceBA' ;
	ThreatenMelee2 = 'BackSlashBA';
	ThreatenMelee3 = 'OverHeadHitBA';
	CommandMelee1 = 'PointGL';
	CommandMelee2 = 'VictoryDanceBA';
	WalkMelee1 = 'WalkBA';
	InAirMelee1 = 'JumpBA';
	LandMelee1 = 'LandBA';	
	DeathRitualMelee1 = 'HowlBA';
	

	// Ranged Animations
	DuckRanged1 = 'DuckGL';
	StrafLeftRanged1 = 'StrafLeftGL';
	StrafLeftShootRanged1 = 'StrafLeftShootGL';
	StrafRightRanged1 = 'StrafRightGL';
	StrafRightShootRanged1 = 'StrafRightShootGL';
	RollLeftRanged1 = 'RollLeftGL';
	RollRightRanged1 = 'RollRightGL';
	WaitIdleRanged1 = 'WaitGL';
	WaitIdleRanged2 = 'LookRightGL';
	WaitIdleRanged3 = 'LookLeftGL';
	WaitIdleRanged4 = 'CheckGL';
	StunnedRanged1 = 'StunGL';
	StunnedSquirmRanged1 = 'StunSquirmGL';
	StunnedShootRanged1 = 'StunShootGL';
	StunnedGetupRanged1 = 'StunGetupGL';
	CheckRanged1 = 'CheckGL';
	ReloadRanged1 = 'ReloadGL';
	KneelShootRanged1 = 'KneelShootGL';
	ShootRanged1 = 'ShootGL';
	HitGutRanged1 = 'HitGutGL';
	HitRightRanged1 = 'HitRightGL';
	HitLeftRanged1 = 'HitLeftGL';
	HitHeadRanged1 = 'HitHeadGL';
	RunRanged1 = 'RunGL';
	BackPeddleRanged1 = 'BackPeddleGL';
	RunShootRanged1 = 'RunShootGL';
	SwimRanged1 = 'RunGL';
	WalkRanged1 = 'WalkGL';
	InAirRanged1 = 'JumpGL';
	LandRanged1 = 'LandGL';	
	DeathRitualRanged1 = 'HowlGL';
	
	
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

/*
function FootStepSound()
{
	if (FRand() < 0.5)
		PlaySound(sound'FootGrav',SLOT_Interact,,,VoiceRadius);	
	else
		PlaySound(sound'FootGrav2',SLOT_Interact,,,VoiceRadius);	
}
*/

function Sharpen()
{
	PlaySound(sound 'SharpBat',SLOT_Interact,,,VoiceRadius);
}


function SetMovementPhysics()
{
	if ( Region.Zone.bWaterZone )
		SetPhysics(PHYS_Swimming);
	else if (Physics != PHYS_Walking)
		SetPhysics(PHYS_Walking); 
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

function PlayMeleeAttack()
{
	local float decision;

	decision = FRand();
	if (decision < 0.2)
	{
		PlayAnim('SlashBA'); 
		PlaySound(slash,SLOT_Interact,,,VoiceRadius);
	}
 	else if (decision < 0.6)
 	{
   		PlayAnim('BackSlashBA');
   		PlaySound(backslash,SLOT_Interact,,,VoiceRadius);
   	}
 	else if (decision < 0.8)
 	{
 		PlayAnim('FlipBA');
 	}
 	else
 	{
 		PlayAnim('OverHeadHitBA');
 		PlaySound(overhead,SLOT_Interact,,,VoiceRadius);
 	} 
}


function OverHeadDamageTarget()
{
	if ( MeleeDamageTarget(OverHeadDamage, (OverHeadDamage * 500 * Normal(Target.Location - Location))) ) 
		PlaySound(FleshSlice, SLOT_Interact,,,VoiceRadius);
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
     OverHeadDamage=20
     StabDamage=10
     SlashDamage=15
     BackSlashDamage=15
     stab=Sound'KlingonSFX01.Weapons.BatSwingBig'
     slash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     backslash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     fleshslice=Sound'KlingonSFX01.Weapons.Bathit'
     Die2=Sound'KlingonSFX01.creature.DthRatKling3'
     overhead=Sound'KlingonSFX01.Weapons.BatSwingBig'
     Command1=Sound'KlingonSFX01.creature.HGCapCommand1'
     Acquire2=Sound'KlingonSFX01.creature.HGCapAquire3'
     Threaten2=Sound'KlingonSFX01.creature.HGCapThreat3'
     ReloadSound1=Sound'KlingonSFX01.Weapons.GrenadeLd2'
     DeathRitualSound1=Sound'KlingonSFX01.creature.KlingDeathHowl3'
     LeftFoot=None
     RightFoot=None
     Grunt1=Sound'KlingonSFX01.creature.MDktaghBackfist'
     Grunt2=Sound'KlingonSFX01.creature.MDktaghBackslas'
     Grunt3=Sound'KlingonSFX01.creature.MDktaghStab2'
     Grunt4=Sound'KlingonSFX01.creature.MDktaghSlash1'
     CarcassType=Class'Klingons.HGCaptCarcass'
     TimeBetweenAttacks=5.000000
     Aggressiveness=0.100000
     RefireRate=0.500000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.GrenadeProjectile'
     ProjectileSpeed=1500.000000
     Acquire=Sound'KlingonSFX01.creature.HGCapAquire2'
     Threaten=Sound'KlingonSFX01.creature.HGCapThreat2'
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=6
     DodgeAmount=0.400000
     Accuracy=500.000000
     MediumDamage=Texture'KlingonFX01.creatures.HGCaptOUCH1'
     HeavyDamage=Texture'KlingonFX01.creatures.HGCaptOUCH2'
     MySide=HonorGuard
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.GrenadFr'
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=40.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=120
     Intelligence=BRAINS_HUMAN
     Skill=2.000000
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt1'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.DthRatKling1'
     Physics=PHYS_Walking
     AnimSequence=WaitGL
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnHonorGuardCapt'
     DrawScale=1.600000
     CollisionRadius=24.000000
     CollisionHeight=48.500000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
}
