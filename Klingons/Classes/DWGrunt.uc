//=============================================================================
// DWGrunt.
//=============================================================================
class DWGrunt expands Humanoids;

#call q:\klingons\art\pawns\dwgrunt\final\dwgrunt.mac
#exec  MESH ORIGIN MESH=PawnDurasGrunt X=0 Y=0 Z=-30 YAW=64

#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=ShootDR           TIME=0.06 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=ShootDR           TIME=0.39 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=ShootDR           TIME=0.72 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkShootDR       TIME=0.025 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkShootDR       TIME=0.175 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkShootDR       TIME=0.325 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkShootDR       TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkShootDR       TIME=0.65 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkShootDR       TIME=0.8  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkShootDR       TIME=0.95 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunShootDR        TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunShootDR        TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunShootDR        TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunShootDR        TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunShootDR        TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftShootDR  TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftShootDR  TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftShootDR  TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftShootDR  TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftShootDR  TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightShootDR TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightShootDR TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightShootDR TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightShootDR TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightShootDR TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=KneelShootDR      TIME=0.06 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=KneelShootDR      TIME=0.39 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=KneelShootDR      TIME=0.72 FUNCTION=SpawnKneelShot

#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StunShootDR       TIME=0.43 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StunShootDR       TIME=0.53 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StunShootDR       TIME=0.63 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StunShootDR       TIME=0.73 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StunShootDR       TIME=0.83 FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkDR              TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WaitDR              TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkDK              TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WaitDaktaghSpinDK   TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WaitDaktaghBladesDK TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WaitIdleDK          TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StabDK      TIME=0.4 FUNCTION=StabDamageTarget
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StabDK      TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=SlashDK     TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=SlashDK     TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=BackSlashDK TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=BackSlashDK TIME=0.2 FUNCTION=KlingonGrunt


#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=BackPeddleDR   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=BackPeddleDR   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=BackPeddleDK   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=BackPeddleDK   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftDK   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftDK   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightDK   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightDK   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunDK   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunDK   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafLeftDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=StrafRightDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkDK   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkDK   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkDR   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=WalkDR   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunDR   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunDR   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunShootDR   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=RunShootDR   			TIME=0.66 FUNCTION=FootStepRunSound

#exec MESH NOTIFY MESH=PawnDurasGrunt SEQ=ReloadDR TIME=0.18 FUNCTION=ReloadSound


//////////////////Variables///////////////////////
// Melee damage.


///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'DuckDK';
	StrafLeftMelee1 = 'StrafLeftDK';
	StrafRightMelee1 = 'StrafRightDK';
	RollLeftMelee1 = 'RollLeftDK';
	RollRightMelee1 = 'RollRightDK';
	WaitIdleMelee1 = 'WaitIdleDK';
	WaitIdleMelee2 = 'FlipDK';
	WaitIdleMelee3 = 'WaitDaktaghBladesDK';
	WaitIdleMelee4 = 'WaitIdleDK';
	StunnedMelee1 = 'StunDK';
	StunnedSquirmMelee1 = 'StunSquirmDK';
	StunnedGetupMelee1 = 'StunGetupDK';
	StabMelee1 = 'StabDK';
	SlashMelee1 = 'SlashDK';
	BackSlashMelee1 = 'BackSlashDK';
	HitGutMelee1 = 'HitGutDK';
	HitRightMelee1 = 'HitRightDK';
	HitLeftMelee1 = 'HitLeftDK';
	HitHeadMelee1 = 'HitHeadDK';
	RunMelee1 = 'RunDK';
	BackPeddleMelee1 = 'BackPeddleDK';
	ThreatenMelee1 = 'WaitDaktaghSpinDK' ;
	ThreatenMelee2 = 'FlyingbackFistDK';
	ThreatenMelee3 = 'FlyingbackFistDK';
	CommandMelee1 = 'WaitDaktaghSpinDK';
	CommandMelee2 = 'FlyingBackFistDK';
	WalkMelee1 = 'WalkDK';
	InAirMelee1 = 'JumpDK';
	LandMelee1 = 'LandDK';	
	DeathRitualMelee1 = 'HowlDK';
	
	

	// Ranged Animations
	DuckRanged1 = 'DuckDR';
	StrafLeftRanged1 = 'StrafLeftDR';
	StrafLeftShootRanged1 = 'StrafLeftShootDR';
	StrafRightRanged1 = 'StrafRightDR';
	StrafRightShootRanged1 = 'StrafRightShootDR';
	RollLeftRanged1 = 'RollLeftDR';
	RollRightRanged1 = 'RollRightDR';
	WaitIdleRanged1 = 'WaitDR';
	WaitIdleRanged2 = 'LookRightDR';
	WaitIdleRanged3 = 'LookLeftDR';
	WaitIdleRanged4 = 'CheckDR';
	StunnedRanged1 = 'StunDR';
	StunnedSquirmRanged1 = 'StunSquirmDR';
	StunnedShootRanged1 = 'StunShootDR';
	StunnedGetupRanged1 = 'StunGetupDR';
	CheckRanged1 = 'CheckDR';
	ReloadRanged1 = 'ReloadDR';
	KneelShootRanged1 = 'KneelShootDR';
	ShootRanged1 = 'ShootDR';
	HitGutRanged1 = 'HitGutDR';
	HitRightRanged1 = 'HitRightDR';
	HitLeftRanged1 = 'HitLeftDR';
	HitHeadRanged1 = 'HitHeadDR';
	RunRanged1 = 'RunDR';
	BackPeddleRanged1 = 'BackPeddleDR';
	RunShootRanged1 = 'RunShootDR';
	SwimRanged1 = 'RunDR';
	WalkRanged1 = 'WalkDR';
	InAirRanged1 = 'JumpDR';
	LandRanged1 = 'LandDR';	
	DeathRitualRanged1 = 'HowlDR';
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBlownRight';
	DeadBlownLeft1 = 'DeadBlownLeft';
	DeadFallFace1 = 'DeadFallFace';
	DeadFallBack1 = 'DeadFallBack';
	DeadFallRight1 = 'DeadFallRight';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'WaitDaktaghSpinDK';
	VictoryDance2 = 'FlyingbackFistDK';

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
		return (right(AnimSequence, 2) == "DK"); 
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
		if (decision < 0.02)
			PlayAnim('DropDK',1.0,0.8);
		else if (decision < 0.07)
			PlayAnim('ScratchDK', 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.27)
			PlayAnim(WaitIdleMelee2, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.47)
			PlayAnim(WaitIdleMelee3, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.67) 	
			LoopAnim(WaitIdleMelee4, 0.6 + 0.3* FRand(),0.8);
		else
			LoopAnim(WaitIdleMelee1, 0.6 + 0.3* FRand(),0.8);
	}
	else
	{
		if (decision < 0.05)
			PlayAnim('ScratchDR', 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.25)
			PlayAnim(WaitIdleRanged2, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.45)
			PlayAnim(WaitIdleRanged3, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.65)
			PlayAnim(WaitIdleRanged4, 0.6 + 0.3* FRand(),0.8);
		else
			LoopAnim(WaitIdleRanged1, 0.6 + 0.3*FRand(),0.8);
	}
}


/////////////////Animation Functions//////////////////////

defaultproperties
{
     StabDamage=5
     SlashDamage=8
     BackSlashDamage=8
     stab=Sound'KlingonSFX01.Weapons.Batswing'
     slash=Sound'KlingonSFX01.Weapons.Batswing'
     backslash=Sound'KlingonSFX01.Weapons.Batswing'
     fleshslice=Sound'KlingonSFX01.Weapons.Batslash2'
     Die2=Sound'KlingonSFX01.creature.DthRatKling3'
     Respond1=Sound'KlingonSFX01.creature.DurasGruntYes'
     Acquire2=Sound'KlingonSFX01.creature.DurasGruntHurt'
     Threaten2=Sound'KlingonSFX01.creature.DurGrunThreaten'
     ReloadSound1=Sound'KlingonSFX01.Weapons.DsrptRifReload'
     DeathRitualSound1=Sound'KlingonSFX01.creature.KlingDeathHowl3'
     Grunt1=Sound'KlingonSFX01.creature.MDktaghBackfist'
     Grunt2=Sound'KlingonSFX01.creature.MDktaghBackslas'
     Grunt3=Sound'KlingonSFX01.creature.MDktaghStab2'
     Grunt4=Sound'KlingonSFX01.creature.MDktaghSlash1'
     CarcassType=Class'Klingons.DWGruntCarcass'
     TimeBetweenAttacks=5.000000
     Aggressiveness=0.600000
     RefireRate=0.250000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     RangedProjectile=Class'Klingons.DisruptorGreen'
     ProjectileSpeed=0.000000
     Acquire=Sound'KlingonSFX01.creature.Jakebmo'
     Threaten=Sound'KlingonSFX01.creature.DurGrunThreat1'
     bCanBeStunned=True
     bCanUseCover=True
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=10
     DodgeAmount=0.120000
     Accuracy=650.000000
     MediumDamage=Texture'KlingonFX01.creatures.DWGruntouch1'
     HeavyDamage=Texture'KlingonFX01.creatures.DWGruntouch2'
     MySide=Duras
     MuzzleFlash=Class'Klingons.DisruptorFlash3'
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.Wepon4'
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=40.000000
     GroundSpeed=250.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=70
     Intelligence=BRAINS_HUMAN
     Skill=1.000000
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt1'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.DthRatKling1'
     CombatStyle=0.600000
     Physics=PHYS_Walking
     AnimSequence=WaitDR
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnDurasGrunt'
     DrawScale=1.600000
     CollisionHeight=47.500000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=90.000000
}
