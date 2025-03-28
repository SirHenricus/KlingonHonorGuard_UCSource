//=============================================================================
// HGGrunt.
//=============================================================================
class HGGrunt expands Humanoids;

#call q:\klingons\art\pawns\HGGrunt\final\HGGrunt.mac
#exec MESH ORIGIN MESH=pawnhonorguardgrunt X=0 Y=0 Z=-13 YAW=64

#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=ShootAD           TIME=0.35 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=RunShootAD        TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafRightShootAD TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafLeftShootAD  TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=KneelShootAD      TIME=0.35 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StunShootAD       TIME=0.7  FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=WalkAD            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=WaitAD            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=WalkME            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=WaitIdleME        TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=PunchME       TIME=0.5 FUNCTION=StabDamageTarget
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=PunchME       TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=SlashME       TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=SlashME       TIME=0.15 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=BackSlashME   TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=BackSlashME   TIME=0.1 FUNCTION=KlingonGrunt


#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=ReloadAD   TIME=0.56 FUNCTION=ReloadSound

#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=BackPeddleAD   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=BackPeddleAD   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=BackPeddleME   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=BackPeddleME   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafLeftME   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafLeftME   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafRightME   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafRightME   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=RunME   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=RunME   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafLeftShootAD   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafLeftShootAD   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafLeftAD   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafLeftAD   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafRightShootAD   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafRightShootAD   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafRightAD   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=StrafRightAD   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=WalkME   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=WalkME   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=WalkAD   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=WalkAD   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=RunAD   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=RunAD   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=RunShootAD   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=pawnhonorguardgrunt SEQ=RunShootAD   			TIME=0.66 FUNCTION=FootStepRunSound



//////////////////Variables///////////////////////
// Melee damage.


///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'DuckME';
	StrafLeftMelee1 = 'StrafLeftME';
	StrafRightMelee1 = 'StrafRightME';
	RollLeftMelee1 = 'RollLeftME';
	RollRightMelee1 = 'RollRightME';
	WaitIdleMelee1 = 'WaitIdleME';
	WaitIdleMelee2 = 'LookLeftME';
	WaitIdleMelee3 = 'LookRightME';
	WaitIdleMelee4 = 'ScratchME';
	StunnedMelee1 = 'StunME';
	StunnedSquirmMelee1 = 'StunSquirmME';
	StunnedGetupMelee1 = 'StunGetupME';
	StabMelee1 = 'PunchME';
	SlashMelee1 = 'SlashME';
	BackSlashMelee1 = 'BackSlashME';
	HitGutMelee1 = 'HitGutME';
	HitRightMelee1 = 'HitRightME';
	HitLeftMelee1 = 'HitLeftME';
	HitHeadMelee1 = 'HitHeadME';
	RunMelee1 = 'RunME';
	BackPeddleMelee1 = 'BackPeddleME';
	ThreatenMelee1 = 'BackSlashME' ;
	ThreatenMelee2 = 'BackSlashME';
	ThreatenMelee3 = 'BackSlashME';
	CommandMelee1 = 'BackSlashME';
	CommandMelee2 = 'BackSlashME';
	WalkMelee1 = 'WalkME';
	InAirMelee1 = 'JumpME';
	LandMelee1 = 'LandME';	
	DeathRitualMelee1 = 'HowlME';
	
	

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
	
	VictoryDance1 = 'PunchME';
	VictoryDance2 = 'BackSlashME';

	ComeGetSomeMelee1 = 'ComeGetSomeME';
	ComeGetSomeMelee2 = 'tude1ME';
	ComeGetSomeMelee3 = 'tude2ME';

	ComeGetSomeRanged1 = 'LookBothAD';
	ComeGetSomeRanged2 = 'ComeGetSomeAD';
	ComeGetSomeRanged3 = 'ComeGetSomeAD';
	

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
		return (right(AnimSequence, 2) == "ME"); 
}



function StabDamageTarget()
{
	if (Target == none) return;

	if ( MeleeDamageTarget(StabDamage, (StabDamage * 500 * Normal(Target.Location - Location))) ) 
		PlaySound(stab, SLOT_Interact,,,VoiceRadius,);
}		

defaultproperties
{
     StabDamage=7
     SlashDamage=10
     BackSlashDamage=8
     stab=Sound'KlingonSFX01.creature.Punch1'
     slash=Sound'KlingonSFX01.Weapons.Batswing'
     backslash=Sound'KlingonSFX01.Weapons.Batswing'
     fleshslice=Sound'KlingonSFX01.Weapons.Batslash2'
     Die2=Sound'KlingonSFX01.creature.DthRatKling3'
     overhead=Sound'KlingonSFX01.Weapons.Batswing'
     Respond1=Sound'KlingonSFX01.creature.HGGrunResp3'
     Acquire2=Sound'KlingonSFX01.creature.HGGrunAquire1'
     Threaten2=Sound'KlingonSFX01.creature.HGGrunThreat1'
     ReloadSound1=Sound'KlingonSFX01.Weapons.AssultLd2'
     DeathRitualSound1=Sound'KlingonSFX01.creature.KlingDeathHowl3'
     Grunt1=Sound'KlingonSFX01.creature.MDktaghBackfist'
     Grunt2=Sound'KlingonSFX01.creature.MDktaghBackslas'
     Grunt3=Sound'KlingonSFX01.creature.MDktaghStab2'
     Grunt4=Sound'KlingonSFX01.creature.MDktaghSlash1'
     CarcassType=Class'Klingons.HGGruntCarcass'
     TimeBetweenAttacks=3.000000
     Aggressiveness=0.500000
     RefireRate=0.300000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     RangedProjectile=Class'Klingons.AssaultProjectile'
     ProjectileSpeed=1250.000000
     Acquire=Sound'KlingonSFX01.creature.HGGrunAquire3'
     Threaten=Sound'KlingonSFX01.creature.HGGrunThreat3'
     bCanBeStunned=True
     bCanUseCover=True
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=8
     DodgeAmount=0.300000
     Accuracy=600.000000
     MediumDamage=Texture'KlingonFX01.creatures.HGGruntOUCH1'
     HeavyDamage=Texture'KlingonFX01.creatures.HGGruntOUCH2'
     MySide=HonorGuard
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=40.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=80
     Intelligence=BRAINS_HUMAN
     Skill=1.000000
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt2'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     Die=Sound'KlingonSFX01.creature.DthRatKling1'
     CombatStyle=0.500000
     AnimSequence=WaitAD
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnHonorGuardGrunt'
     DrawScale=1.600000
     CollisionHeight=49.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
}
