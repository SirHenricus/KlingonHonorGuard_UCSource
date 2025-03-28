//=============================================================================
// AndorianCaptain.
//=============================================================================
class AndorianCaptain expands Humanoids;

#call q:\klingons\art\pawns\acapt\final\acapt.mac
#exec MESH ORIGIN MESH=PawnAndorianCaptain X=0 Y=0 Z=-30 YAW=64

#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=ShootFL           TIME=0.16 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=ShootFL           TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=ShootFL           TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkShootFL       TIME=0.05 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkShootFL       TIME=0.25 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkShootFL       TIME=0.50 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkShootFL       TIME=0.75 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunShootFL        TIME=0.16 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunShootFL        TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunShootFL        TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightShootFL TIME=0.16 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightShootFL TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightShootFL TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftShootFL  TIME=0.16 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftShootFL  TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftShootFL  TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=KneelShootFL      TIME=0.05 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=KneelShootFL      TIME=0.34 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=KneelShootFL      TIME=0.67 FUNCTION=SpawnKneelShot

#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StunShootFL       TIME=0.43 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StunShootFL       TIME=0.60 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StunShootFL       TIME=0.77 FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WaitFL            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WaitDR            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkFL            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkSW            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WaitIdleSW        TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WaitSwordSpinSW   TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WaitSwordTossSW   TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StabSW      TIME=0.4 FUNCTION=StabDamageTarget
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StabSW      TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=SlashSW     TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=SlashSW     TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=BackSlashSW TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=BackSlashSW TIME=0.1 FUNCTION=HumanGrunt


#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=BackPeddleFL   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=BackPeddleFL   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=BackPeddleSW   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=BackPeddleSW   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftSW   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftSW   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightSW   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightSW   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunSW   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunSW   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftShootFL   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftShootFL   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftFL   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafLeftFL   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightShootFL   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightShootFL   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightFL   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=StrafRightFL   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkSW   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkSW   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkFL   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=WalkFL   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunFL   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunFL   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunShootFL   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=RunShootFL   			TIME=0.66 FUNCTION=FootStepRunSound

#exec MESH NOTIFY MESH=PawnAndorianCaptain SEQ=ReloadFL TIME=0.37 FUNCTION=ReloadSound


//XXX
//FootStep sounds?
//Swimming?
//Ducking? Ducking To Shoot?
//Speaking?
//Projectile location?

//////////////////Variables///////////////////////
// Melee damage.



///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'DuckSW';
	StrafLeftMelee1 = 'StrafLeftSW';
	StrafRightMelee1 = 'StrafRightSW';
	RollLeftMelee1 = 'RollLeftSW';
	RollRightMelee1 = 'RollRightSW';
	WaitIdleMelee1 = 'WaitIdleSW';
	WaitIdleMelee2 = 'LookRightSW';
	WaitIdleMelee3 = 'WaitSwordTossSW';
	WaitIdleMelee4 = 'LookLeftSW';
	StunnedMelee1 = 'StunSW';
	StunnedSquirmMelee1 = 'StunSquirmSW';
	StunnedGetupMelee1 = 'StunGetupSW';
	StabMelee1 = 'StabSW';
	SlashMelee1 = 'SlashSW';
	BackSlashMelee1 = 'BackSlashSW';
	HitGutMelee1 = 'HitGutSW';
	HitRightMelee1 = 'HitRightSW';
	HitLeftMelee1 = 'HitLeftSW';
	HitHeadMelee1 = 'HitHeadSW';
	RunMelee1 = 'RunSW';
	BackPeddleMelee1 = 'BackPeddleSW';
	ThreatenMelee1 = 'WaitSwordSpinSW' ;
	ThreatenMelee2 = 'FlyingbackFistSW';
	ThreatenMelee3 = 'WaitSwordSpinSW';
	CommandMelee1 = 'WaitSwordSpinSW';
	CommandMelee2 = 'FlyingBackFistSW';
	WalkMelee1 = 'WalkSW';
	InAirMelee1 = 'JumpSW';
	LandMelee1 = 'LandSW';


	// Ranged Animations
	DuckRanged1 = 'DuckFL';
	StrafLeftRanged1 = 'StrafLeftFL';
	StrafLeftShootRanged1 = 'StrafLeftShootFL';
	StrafRightRanged1 = 'StrafRightFL';
	StrafRightShootRanged1 = 'StrafRightShootFL';
	RollLeftRanged1 = 'RollLeftFL';
	RollRightRanged1 = 'RollRightFL';
	WaitIdleRanged1 = 'WaitFL';
	WaitIdleRanged2 = 'LookRightFL';
	WaitIdleRanged3 = 'LookLeftFL';
	WaitIdleRanged4 = 'CheckFL';
	StunnedRanged1 = 'StunFL';
	StunnedSquirmRanged1 = 'StunSquirmFL';
	StunnedShootRanged1 = 'StunShootFL';
	StunnedGetupRanged1 = 'StunGetupFL';
	CheckRanged1 = 'CheckFL';
	ReloadRanged1 = 'ReloadFL';
	KneelShootRanged1 = 'KneelShootFL';
	ShootRanged1 = 'ShootFL';
	HitGutRanged1 = 'HitGutFL';
	HitRightRanged1 = 'HitRightFL';
	HitLeftRanged1 = 'HitLeftFL';
	HitHeadRanged1 = 'HitHeadFL';
	RunRanged1 = 'RunFL';
	BackPeddleRanged1 = 'BackPeddleFL';
	RunShootRanged1 = 'RunShootFL';
	SwimRanged1 = 'RunFL';
	WalkRanged1 = 'WalkFL';
	InAirRanged1 = 'JumpFL';
	LandRanged1 = 'LandFL';
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBlownRight';
	DeadBlownLeft1 = 'DeadBlownLeft';
	DeadFallFace1 = 'DeadFallFace';
	DeadFallBack1 = 'DeadFallBack';
	DeadFallRight1 = 'DeadFallRight';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'WaitSwordSpinSW';
	VictoryDance2 = 'FlyingbackFistSW';
	


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
		return (right(AnimSequence, 2) == "SW"); 
}



function PlayMeleeAttack()
{
	local float decision;

	decision = FRand();
 	if (decision < 0.33)
 	{
   		PlayAnim(StabMelee1,,0.1);
   		PlaySound(slash,SLOT_Interact,,,VoiceRadius,);
   	}
 	else if (decision < 0.6)
 	{
   		PlayAnim(SlashMelee1,,0.1);
   		PlaySound(slash,SLOT_Interact,,,VoiceRadius,);
 	}
 	else if (decision < 0.7)
 	{
 		if (AnimSequence == WaitIdleMelee3)
	   		PlayAnim(WaitIdleMelee4,,0.1);	// spinning slash
	   	else
	  		PlayAnim(WaitIdleMelee3,,0.1);	// sword toss
 	}
 	else if (decision < 0.8)
 	{
   		PlayAnim(WaitIdleMelee4,,0.1);	// spinning slash
 		PlaySound(backslash,SLOT_Interact,,,VoiceRadius,);
 	}
 	else
 	{
 		PlayAnim(BackSlashMelee1,,0.1);
 		PlaySound(backslash,SLOT_Interact,,,VoiceRadius,);
 	}
}



/////////////////Animation Functions//////////////////////

defaultproperties
{
     StabDamage=5
     SlashDamage=8
     BackSlashDamage=8
     stab=Sound'KlingonSFX01.creature.AndCptSwing'
     slash=Sound'KlingonSFX01.creature.AndCptSwing'
     backslash=Sound'KlingonSFX01.creature.AndCptSwing'
     fleshslice=Sound'KlingonSFX01.Weapons.Batslash2'
     Die2=Sound'KlingonSFX01.creature.AndoDie2Hard'
     Command1=Sound'KlingonSFX01.creature.Ando03Hard'
     Acquire2=Sound'KlingonSFX01.creature.Ando13Hard'
     Threaten2=Sound'KlingonSFX01.creature.Ando14Hard'
     ReloadSound1=Sound'KlingonSFX01.Weapons.FlamThroReload'
     Grunt1=Sound'KlingonSFX01.creature.AndoBckfst'
     Grunt2=Sound'KlingonSFX01.creature.AndoBckslsh'
     Grunt3=Sound'KlingonSFX01.creature.AndoBckfst'
     Grunt4=Sound'KlingonSFX01.creature.AndoBckslsh'
     CarcassType=Class'Klingons.AndCaptainCarcass'
     TimeBetweenAttacks=5.000000
     Aggressiveness=0.500000
     RefireRate=0.250000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.DisruptorRed'
     ProjectileSpeed=0.000000
     Acquire=Sound'KlingonSFX01.creature.Ando08Hard'
     Fear=Sound'KlingonSFX01.creature.Ando11Hard'
     Roam=Sound'KlingonSFX01.creature.AndoBreathHard'
     Threaten=Sound'KlingonSFX01.creature.Ando12Hard'
     bCanBeStunned=True
     Breath=Sound'KlingonSFX01.creature.AndoBreathHard'
     bCanUseCover=True
     SplatClass=Class'Klingons.GreenBlood'
     ShotsBeforeReload=8
     DodgeAmount=0.140000
     Accuracy=600.000000
     PartBlood=Class'Klingons.GreenParticles'
     RetreatDamage=25
     MediumDamage=Texture'KlingonFX01.creatures.acaptouch1'
     HeavyDamage=Texture'KlingonFX01.creatures.acaptouch2'
     MySide=Andorian
     MuzzleFlash=Class'Klingons.DisruptorFlash2'
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.Wepon4'
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=40.000000
     GroundSpeed=250.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=90
     Intelligence=BRAINS_HUMAN
     Skill=1.000000
     HitSound1=Sound'KlingonSFX01.creature.AndoHit2Hard'
     HitSound2=Sound'KlingonSFX01.creature.AndoHit3Hard'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.AndoDie1Hard'
     CombatStyle=0.100000
     Physics=PHYS_Walking
     AnimSequence=WaitFL
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnAndorianCaptain'
     DrawScale=1.600000
     CollisionRadius=23.500000
     CollisionHeight=45.750000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
}
