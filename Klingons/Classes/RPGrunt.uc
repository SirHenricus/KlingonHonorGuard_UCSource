//=============================================================================
// RPGrunt.
//=============================================================================
class RPGrunt expands Humanoids;

#call q:\klingons\art\pawns\RPGrunt\final\RPGrunt.mac
#exec  MESH ORIGIN MESH=PawnRureGrunt X=0 Y=0 Z=-27 YAW=64

#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=ShootDR             TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=RunShootDR          TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafLeftShootDR    TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafRightShootDR   TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=KneelShootDR        TIME=0.50 FUNCTION=SpawnKneelShot
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StunShootDR         TIME=0.70 FUNCTION=SpawnStunShot

#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WaitDR              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WalkDR              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WalkDK              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WaitIdleDK          TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WaitDaktaghSpinDK   TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WaitDaktaghBladesDK TIME=0.50 FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StabDK              TIME=0.4 FUNCTION=StabDamageTarget
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StabDK              TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=SlashDK             TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=SlashDK             TIME=0.1 FUNCTION=KlingonGrunt
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=BackSlashDK         TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=BackSlashDK         TIME=0.1 FUNCTION=KlingonGrunt


#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=DeadStumble         TIME=0.13 FUNCTION=StumbleMove
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=DeadStumble         TIME=0.31 FUNCTION=StumbleMove
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=DeadStumble         TIME=0.41 FUNCTION=StumbleMove
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=DeadStumble         TIME=0.53 FUNCTION=StumbleMove
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=DeadStumble         TIME=0.63 FUNCTION=StumbleMove
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=DeadStumble         TIME=0.8  FUNCTION=StumbleMove

#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=BackPeddleDR   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=BackPeddleDR   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=BackPeddleDK   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=BackPeddleDK   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafLeftDK   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafLeftDK   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafRightDK   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafRightDK   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=RunDK   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=RunDK   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafLeftShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafLeftShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafLeftDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafLeftDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafRightShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafRightShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafRightDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=StrafRightDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WalkDK   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WalkDK   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WalkDR   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=WalkDR   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=RunDR   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=RunDR   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=RunShootDR   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnRureGrunt SEQ=RunShootDR   			TIME=0.66 FUNCTION=FootStepRunSound


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
	WaitIdleMelee2 = 'WaitDaktaghBladesDK';
	WaitIdleMelee3 = 'FlipDK';
	WaitIdleMelee4 = 'WaitDaktaghBladesDK';
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
	RollLeftRanged1 = 'RollLeftDP';
	RollRightRanged1 = 'RollRightDP';
	WaitIdleRanged1 = 'WaitDR';
	WaitIdleRanged2 = 'LookRightDP';
	WaitIdleRanged3 = 'LookLeftDP';
	WaitIdleRanged4 = 'CheckDP';
	StunnedRanged1 = 'StunDR';
	StunnedSquirmRanged1 = 'StunSquirmDR';
	StunnedShootRanged1 = 'StunShootDR';
	StunnedGetupRanged1 = 'StunGetupDR';
	CheckRanged1 = 'CheckDP';
	ReloadRanged1 = 'CheckDP';
	KneelShootRanged1 = 'KneelShootDR';
	ShootRanged1 = 'ShootDR';
	HitGutRanged1 = 'HitGutDR';
	HitRightRanged1 = 'HitRightDR';
	HitLeftRanged1 = 'HitLeftDR';
	HitHeadRanged1 = 'HitHeadDR';
	RunRanged1 = 'RunDR';
	BackPeddleRanged1 = 'BackPeddleDP';
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

	ComeGetSomeMelee1 = 'WaitIdleDK';
	ComeGetSomeMelee2 = 'WaitIdleDK';
	ComeGetSomeMelee3 = 'WaitIdleDK';

	ComeGetSomeRanged1 = 'WaitDR';
	ComeGetSomeRanged2 = 'LookRightDP';
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
		return (right(AnimSequence, 2) == "DK"); 
}




function StumbleMove()
{
	local vector X,Y,Z;
	
	GetAxes(rotation, X,Y,Z);
	Velocity += 75*(Z-X);	
}

defaultproperties
{
     StabDamage=5
     SlashDamage=8
     BackSlashDamage=8
     stab=Sound'KlingonSFX01.Weapons.Batswing'
     slash=Sound'KlingonSFX01.Weapons.Batswing'
     backslash=Sound'KlingonSFX01.Weapons.Batswing'
     Die2=Sound'KlingonSFX01.creature.DthRatKling1'
     Respond1=Sound'KlingonSFX01.creature.RPGrunResp1b'
     Acquire2=Sound'KlingonSFX01.creature.RPGruntAquire1'
     Threaten2=Sound'KlingonSFX01.creature.RPGruntThreat2'
     DeathRitualSound1=Sound'KlingonSFX01.creature.KlingDeathHowl3'
     Grunt1=Sound'KlingonSFX01.creature.MDktaghBackfist'
     Grunt2=Sound'KlingonSFX01.creature.MDktaghBackslas'
     Grunt3=Sound'KlingonSFX01.creature.MDktaghStab2'
     Grunt4=Sound'KlingonSFX01.creature.MDktaghSlash1'
     CarcassType=Class'Klingons.RPGruntCarcass'
     TimeBetweenAttacks=2.000000
     Aggressiveness=0.300000
     RefireRate=0.500000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     RangedProjectile=Class'Klingons.DisruptorGreen'
     Acquire=Sound'KlingonSFX01.creature.Halt'
     Threaten=Sound'KlingonSFX01.creature.RPGruntThreat3'
     bCanBeStunned=True
     Breath=Sound'KlingonSFX01.creature.BreathKling'
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=999
     DodgeAmount=0.060000
     Accuracy=900.000000
     MediumDamage=Texture'KlingonFX01.creatures.RPgruntOUCH1'
     HeavyDamage=Texture'KlingonFX01.creatures.RPgruntOUCH2'
     MySide=RuraPente
     MuzzleFlash=Class'Klingons.DisruptorFlash3'
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.Wepon4'
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=40.000000
     GroundSpeed=300.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=50
     Intelligence=BRAINS_HUMAN
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt2'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.DthRatKling2'
     CombatStyle=0.400000
     Physics=PHYS_Walking
     AnimSequence=WaitDR
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnRureGrunt'
     DrawScale=1.600000
     CollisionHeight=49.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=90.000000
}
