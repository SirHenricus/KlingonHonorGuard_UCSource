//=============================================================================
// AndorianGrunt.
//=============================================================================
class AndorianGrunt expands Humanoids;


#call q:\klingons\art\pawns\AGrunt\final\AGrunt.mac
#exec  MESH ORIGIN MESH=PawnAndorianGrunt X=0 Y=0 Z=-30 YAW=64

#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=ShootDR           TIME=0.06 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=ShootDR           TIME=0.39 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=ShootDR           TIME=0.72 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkShootDR       TIME=0.025 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkShootDR       TIME=0.175 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkShootDR       TIME=0.325 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkShootDR       TIME=0.5  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkShootDR       TIME=0.65 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkShootDR       TIME=0.8  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkShootDR       TIME=0.95 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunShootDR        TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunShootDR        TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunShootDR        TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunShootDR        TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunShootDR        TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftShootDR  TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftShootDR  TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftShootDR  TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftShootDR  TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftShootDR  TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightShootDR TIME=0.03 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightShootDR TIME=0.23 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightShootDR TIME=0.43 FUNCTION=SpawnShot
//#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightShootDR TIME=0.63 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightShootDR TIME=0.83 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=KneelShootDR      TIME=0.06 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=KneelShootDR      TIME=0.39 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=KneelShootDR      TIME=0.72 FUNCTION=SpawnKneelShot

#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StunShootDR       TIME=0.43 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StunShootDR       TIME=0.53 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StunShootDR       TIME=0.63 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StunShootDR       TIME=0.73 FUNCTION=SpawnStunShot
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StunShootDR       TIME=0.83 FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkDR            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WaitDR            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkAX            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WaitIdleAX        TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WaitAxeSpinAX     TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=SlashAX     TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=SlashAX     TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=BackSlashAX TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=BackSlashAX TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=MineAX      TIME=0.5 FUNCTION=MineEffect
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=FlyingBackfistAX     TIME=0.35 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=FlyingBackfistAX     TIME=0.1 FUNCTION=HumanGrunt


#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=BackPeddleDR   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=BackPeddleDR   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=BackPeddleAX   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=BackPeddleAX   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftAX   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftAX   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightAX   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightAX   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunAX   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunAX   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafLeftDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=StrafRightDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkAX   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkAX   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkDR   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=WalkDR   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunDR   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunDR   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunShootDR   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=RunShootDR   			TIME=0.66 FUNCTION=FootStepRunSound


#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=HitLeftDR   			TIME=0.8 FUNCTION=ReturnDaktagh1
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=HitRightDR   			TIME=0.8 FUNCTION=ReturnDaktagh1
#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=HitGutDR   			TIME=0.8 FUNCTION=ReturnDaktagh1

#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=ButtonWallDR   		TIME=0.26 FUNCTION=ReturnDaktagh2

#exec MESH NOTIFY MESH=PawnAndorianGrunt SEQ=ReloadDR      TIME=0.23 FUNCTION=ReloadSound


//////////////////Variables///////////////////////
// Melee damage.

///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'DuckAX';
	StrafLeftMelee1 = 'StrafLeftAX';
	StrafRightMelee1 = 'StrafRightAX';
	RollLeftMelee1 = 'RollLeftAX';
	RollRightMelee1 = 'RollRightAX';
	WaitIdleMelee1 = 'WaitIdleAX';
	WaitIdleMelee2 = 'WaitAxeSpinAX';
	WaitIdleMelee3 = 'AntennaRubAX';
	WaitIdleMelee4 = 'WaitIdleAX';
	StunnedMelee1 = 'StunAX';
	StunnedSquirmMelee1 = 'StunSquirmAX';
	StunnedGetupMelee1 = 'StunGetupAX';
	StabMelee1 = 'FlyingBackfistAX';
	SlashMelee1 = 'SlashAX';
	BackSlashMelee1 = 'BackSlashAX';
	HitGutMelee1 = 'HitGutAX';
	HitRightMelee1 = 'HitRightAX';
	HitLeftMelee1 = 'HitLeftAX';
	HitHeadMelee1 = 'HitHeadAX';
	RunMelee1 = 'RunAX';
	BackPeddleMelee1 = 'BackPeddleAX';
	ThreatenMelee1 = 'WaitAxeSpinAX' ;
	ThreatenMelee2 = 'FlyingbackFistAX';
	ThreatenMelee3 = 'FlyingbackFistAX';
	CommandMelee1 = 'WaitAxeSpinAX';
	CommandMelee2 = 'FlyingBackFistAX';
	WalkMelee1 = 'WalkAX';
	InAirMelee1 = 'JumpAX';
	LandMelee1 = 'LandAX';
	

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
		
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBlownRight';
	DeadBlownLeft1 = 'DeadBlownLeft';
	DeadFallFace1 = 'DeadFallFace';
	DeadFallBack1 = 'DeadFallBack';
	DeadFallRight1 = 'DeadFallRight';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'WaitSwordSpinDR';
	VictoryDance2 = 'FlyingbackFistDR';
	
	ComeGetSomeMelee1 = 'ComeGetSomeAX';
	ComeGetSomeMelee2 = 'WaitIdleAX';
	ComeGetSomeMelee3 = 'ComeGetSomeAX';

	ComeGetSomeRanged1 = 'LookLeftDR';
	ComeGetSomeRanged2 = 'LookRightDR';
	ComeGetSomeRanged3 = 'LookRightDR';
	
	Super.PreBeginPlay();
}

function ZoneChange(ZoneInfo newZone)
{
	bCanSwim = newZone.bWaterZone; //only when it must
		
	if ( newZone.bWaterZone )
		CombatStyle = 1.0; //always charges when in the water
	else if (Physics == PHYS_Swimming)
		CombatStyle = Default.CombatStyle;

	Super.ZoneChange(newZone);
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
		return (right(AnimSequence, 2) == "AX"); 
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
		if (decision < 0.1)
			PlayAnim(WaitIdleMelee2, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.2)
			PlayAnim(WaitIdleMelee3, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.3) 	
			PlayAnim(WaitIdleMelee4, 0.6 + 0.3* FRand(),0.8);
		else
			LoopAnim(WaitIdleMelee1, 0.6 + 0.3* FRand(),0.8);
	}
	else
	{
		if (decision < 0.05)
			PlayAnim('AntennaRubDR', 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.15)
			PlayAnim(WaitIdleRanged2, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.25)
			PlayAnim(WaitIdleRanged3, 0.6 + 0.3* FRand(),0.8);
		else if (decision < 0.35)
			PlayAnim(WaitIdleRanged4, 0.6 + 0.3* FRand(),0.8);
		else
			LoopAnim(WaitIdleRanged1, 0.6 + 0.3*FRand(),0.8);
	}
}



function ReturnDaktagh1()
{
	if (SpecialHit == 1)
		PlayAnim('ButtonWallDR',1.4,0.1);	
}

function ReturnDaktagh2()
{
	if (SpecialHit == 1)
	{
		ReturnDaktaghProjectile(vect(1.3, 0.5, 0.4), 200);
		SpecialHit = 0;
	}
		
}

function PlayVictoryDance()
{	
	local float decision;
	
	decision = Frand();
	if (decision < 0.1)
		PlayAnim('WaitAxeSpinAX', 0.7+0.6*FRand(), 0.2);
	else if (decision < 0.2)
		PlayAnim('FlyingbackFistAX',,0.2);
	else if (decision < 0.3)
//		PlayAnim('DanceWooWoo', 0.7+0.6*FRand(), 0.2);
		LoopAnim('DanceWooWoo', 1.0, 0.2);
	else 
		LoopAnim('Dance', 0.7+0.6*FRand(), 0.2);
}


function MineEffect()
{
	local vector X,Y,Z;
	local vector hitloc, hitnorm;
	local actor hit;
	
	GetAxes(rotation, X,Y,Z);
	hit = trace(hitloc, hitnorm,  location+4*collisionradius*X+0.2*collisionheight*Z, location+0.2*collisionheight*Z);
	if (hit == None)
		return;	
//	spawn(class 'ImpactSpark',,,hitloc);
	if (FRand() < 0.5)
		spawn(class 'Spark1',,,hitloc);

}

defaultproperties
{
     OverHeadDamage=8
     StabDamage=5
     SlashDamage=8
     BackSlashDamage=8
     slash=Sound'KlingonSFX01.creature.AndCptSwing'
     backslash=Sound'KlingonSFX01.creature.AndCptSwing'
     fleshslice=Sound'KlingonSFX01.Weapons.Batslash2'
     Die2=Sound'KlingonSFX01.creature.AndoDie2Hard'
     Respond1=Sound'KlingonSFX01.creature.Ando19Hard'
     Acquire2=Sound'KlingonSFX01.creature.Ando13Hard'
     Threaten2=Sound'KlingonSFX01.creature.Ando07Hard'
     ReloadSound1=Sound'KlingonSFX01.Weapons.DsrptRifReload'
     Grunt1=Sound'KlingonSFX01.creature.AndoBckfst'
     Grunt2=Sound'KlingonSFX01.creature.AndoBckslsh'
     Grunt3=Sound'KlingonSFX01.creature.AndoBckfst'
     Grunt4=Sound'KlingonSFX01.creature.AndoBckslsh'
     CarcassType=Class'Klingons.AndGruntCarcass'
     TimeBetweenAttacks=5.000000
     Aggressiveness=0.400000
     RefireRate=0.250000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     RangedProjectile=Class'Klingons.DisruptorGreen'
     Acquire=Sound'KlingonSFX01.creature.Ando01Hard'
     Fear=Sound'KlingonSFX01.creature.AndoFear4Hard'
     Roam=Sound'KlingonSFX01.creature.AndoRoam1Hard'
     Threaten=Sound'KlingonSFX01.creature.Ando10Hard'
     bCanBeStunned=True
     bCanUseCover=True
     SplatClass=Class'Klingons.GreenBlood'
     ShotsBeforeReload=10
     DodgeAmount=0.080000
     Accuracy=800.000000
     PartBlood=Class'Klingons.GreenParticles'
     RetreatDamage=25
     MediumDamage=Texture'KlingonFX01.creatures.agruntouch1'
     HeavyDamage=Texture'KlingonFX01.creatures.agruntouch2'
     MySide=Andorian
     MuzzleFlash=Class'Klingons.DisruptorFlash3'
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.Wepon4'
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=45.000000
     GroundSpeed=220.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=60
     Intelligence=BRAINS_HUMAN
     Skill=1.000000
     HitSound1=Sound'KlingonSFX01.creature.AndoHit2Hard'
     HitSound2=Sound'KlingonSFX01.creature.AndoHit3Hard'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.AndoDie1Hard'
     CombatStyle=0.300000
     Physics=PHYS_Walking
     AnimSequence=WaitDR
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnAndorianGrunt'
     DrawScale=1.600000
     CollisionHeight=46.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=90.000000
}
