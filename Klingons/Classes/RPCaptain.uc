//=============================================================================
// RPCaptain.
//=============================================================================
class RPCaptain expands Humanoids;

#alwayscall q:\klingons\art\pawns\RPCapt\final\RPCapt.mac
#alwaysexec  MESH ORIGIN MESH=PawnRureCapt X=0 Y=0 Z=-30 YAW=64

#exec MESH NOTIFY MESH=PawnRureCapt SEQ=ShootDR           TIME=0.06 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=ShootDR           TIME=0.39 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=ShootDR           TIME=0.72 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkShootDR       TIME=0.025 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkShootDR       TIME=0.175 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkShootDR       TIME=0.325 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkShootDR       TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkShootDR       TIME=0.65 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkShootDR       TIME=0.8  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkShootDR       TIME=0.95 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunShootDR        TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunShootDR        TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunShootDR        TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunShootDR        TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunShootDR        TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftShootDR  TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftShootDR  TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftShootDR  TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftShootDR  TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftShootDR  TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightShootDR TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightShootDR TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightShootDR TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightShootDR TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightShootDR TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=KneelShootDR      TIME=0.06 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=KneelShootDR      TIME=0.39 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=KneelShootDR      TIME=0.72 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StunShootDR       TIME=0.43 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StunShootDR       TIME=0.53 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StunShootDR       TIME=0.63 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StunShootDR       TIME=0.73 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StunShootDR       TIME=0.83 FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkDR            TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WaitDR            TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=VictoryDanceBA    TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkBA            TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WaitIdleBA        TIME=0.50 FUNCTION=SpawnBreath
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=ReloadDR		  TIME=0.18 FUNCTION=BeginReload
//#exec MESH NOTIFY MESH=PawnRureCapt SEQ=ReloadDR		  TIME=0.74 FUNCTION=EndReload


#exec MESH NOTIFY MESH=PawnRureCapt SEQ=OverHeadHitBA TIME=0.5 FUNCTION=OverHeadDamageTarget
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=OverHeadHitBA TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=SlashBA       TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=SlashBA       TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=BackSlashBA   TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=BackSlashBA   TIME=0.1 FUNCTION=KlingonGrunt


#exec MESH NOTIFY MESH=PawnRureCapt SEQ=ReloadDR   TIME=0.32 FUNCTION=ReloadSound

#exec MESH NOTIFY MESH=PawnRureCapt SEQ=BackPeddleDR   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=BackPeddleDR   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=BackPeddleBA   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=BackPeddleBA   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftBA   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftBA   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightBA   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightBA   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunBA   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunBA   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafLeftDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=StrafRightDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkBA   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkBA   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkDR   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=WalkDR   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunDR   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunDR   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunShootDR   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureCapt SEQ=RunShootDR   			TIME=0.66 FUNCTION=FootStepRunSound

#alwaysexec MESH NOTIFY MESH=PawnRureCapt SEQ=SharpenBA       TIME=0.1 FUNCTION=Sharpen


//////////////////Variables///////////////////////
// Melee damage.
var() byte
	OverHeadDamage;
	
		


var(Sounds) sound overhead;


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
	WaitIdleMelee3 = 'SharpenBA';
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
	ThreatenMelee2 = 'OverHeadHitBA';
	ThreatenMelee3 = 'BackSlashBA';
	CommandMelee1 = 'PointBA';
	CommandMelee2 = 'PointBA';
	WalkMelee1 = 'WalkBA';
	InAirMelee1 = 'JumpBA';
	LandMelee1 = 'LandBA';	
	DeathRitualMelee1 = 'HowlBA';
	
	

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
	WaitIdleRanged4 = 'CheckRifleDR';
	StunnedRanged1 = 'StunDR';
	StunnedSquirmRanged1 = 'StunSquirmDR';
	StunnedShootRanged1 = 'StunShootDR';
	StunnedGetupRanged1 = 'StunGetupDR';
	CheckRanged1 = 'CheckRifleDR';
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
	
	VictoryDance1 = 'VictoryDanceBA';
	VictoryDance2 = 'VictoryDanceBA';
	
	ComeGetSomeMelee1 = 'PointBA';
	ComeGetSomeMelee2 = 'PointBA';
	ComeGetSomeMelee3 = 'PointBA';

	ComeGetSomeRanged1 = 'LookRightDR';
	ComeGetSomeRanged2 = 'PointDR';
	ComeGetSomeRanged3 = 'WaitDR';	

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
/////////////////Speaking Functions/////////////////


function Sharpen()
{
	PlaySound(sound 'SharpBat',SLOT_Interact,,,VoiceRadius);
}


function TweenToCommand(float Tweentime)
{
	if (IsMeleeAnim())
		TweenAnim('PointBA', tweentime);
	else
		TweenAnim('PointDR', tweentime);
}

function PlayCommand()
{
	if (IsMeleeAnim())
		PlayAnim('PointBA', 0.8);
	else
		PlayAnim('PointDR', 0.8);
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
     OverHeadDamage=15
     overhead=Sound'KlingonSFX01.Weapons.BatSwingBig'
     StabDamage=5
     SlashDamage=5
     BackSlashDamage=10
     slash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     backslash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     fleshslice=Sound'KlingonSFX01.Weapons.Bathit'
     Die2=Sound'KlingonSFX01.creature.DthRatKling3'
     Command1=Sound'KlingonSFX01.creature.RPCapCommand2'
     Acquire2=Sound'KlingonSFX01.creature.RPCapAquire2'
     Threaten2=Sound'KlingonSFX01.creature.RPCapThreat2'
     ReloadSound1=Sound'KlingonSFX01.Weapons.DsrptRifReload'
     DeathRitualSound1=Sound'KlingonSFX01.creature.KlingDeathHowl3'
     Grunt1=Sound'KlingonSFX01.creature.MDktaghBackfist'
     Grunt2=Sound'KlingonSFX01.creature.MDktaghBackslas'
     Grunt3=Sound'KlingonSFX01.creature.MDktaghStab2'
     Grunt4=Sound'KlingonSFX01.creature.MDktaghSlash1'
     CarcassType=Class'Klingons.RPCaptainCarcass'
     TimeBetweenAttacks=5.000000
     Aggressiveness=0.300000
     RefireRate=0.250000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.DisruptorGreen'
     ProjectileSpeed=1000.000000
     Acquire=Sound'KlingonSFX01.creature.RPCapAquire1'
     Threaten=Sound'KlingonSFX01.creature.RPCapThreat1'
     bCanBeStunned=True
     Breath=Sound'KlingonSFX01.creature.BreathKling'
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=10
     DodgeAmount=0.100000
     Accuracy=700.000000
     MediumDamage=Texture'KlingonFX01.creatures.rpcaptOUCH1'
     HeavyDamage=Texture'KlingonFX01.creatures.rpcaptOUCH2'
     MySide=RuraPente
     MuzzleFlash=Class'Klingons.DisruptorFlash3'
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.Wepon4'
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=50.000000
     GroundSpeed=250.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=80
     Intelligence=BRAINS_HUMAN
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt2'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.DthRatKling1'
     CombatStyle=0.200000
     Physics=PHYS_Walking
     AnimSequence=WaitDR
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnRureCapt'
     DrawScale=1.600000
     CollisionHeight=47.500000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
}
