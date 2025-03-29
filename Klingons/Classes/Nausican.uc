//=============================================================================
// Nausican.
//=============================================================================
class Nausican expands Humanoids;

#call q:\klingons\art\pawns\Nausican\final\Nausican.mac
#exec MESH ORIGIN MESH=PawnNausican X=0 Y=-30 Z=-28 YAW=64

#exec MESH NOTIFY MESH=PawnNausican SEQ=ShootGL           TIME=0.2 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnNausican SEQ=WalkShootGL       TIME=0.5 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnNausican SEQ=RunShootGL        TIME=0.4 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafRightShootGL TIME=0.4 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafLeftShootGL  TIME=0.4 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnNausican SEQ=KneelShootGL      TIME=0.2 FUNCTION=SpawnKneelShot

#exec MESH NOTIFY MESH=PawnNausican SEQ=WalkGL            TIME=0.5 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnNausican SEQ=WaitGL            TIME=0.5 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnNausican SEQ=WalkDK            TIME=0.5 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnNausican SEQ=WaitIdleDK        TIME=0.5 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnNausican SEQ=WaitKnifeSpinDK   TIME=0.5 FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnNausican SEQ=StabDK      TIME=0.4 FUNCTION=StabDamageTarget
#exec MESH NOTIFY MESH=PawnNausican SEQ=StabDK      TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnNausican SEQ=SlashDK     TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnNausican SEQ=SlashDK     TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnNausican SEQ=BackSlashDK TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnNausican SEQ=BackSlashDK TIME=0.1 FUNCTION=HumanGrunt


#exec MESH NOTIFY MESH=PawnNausican SEQ=ReloadGL TIME=0.55 FUNCTION=ReloadSound

#exec MESH NOTIFY MESH=PawnNausican SEQ=BackPeddleGL   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=BackPeddleGL   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=BackPeddleDK   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=BackPeddleDK   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafLeftDK   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafLeftDK   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafRightDK   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafRightDK   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=RunDK   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=RunDK   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafLeftShootGL   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafLeftShootGL   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafLeftGL   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafLeftGL   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafRightShootGL   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafRightShootGL   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafRightGL   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=StrafRightGL   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=WalkDK   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=WalkDK   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=WalkGL   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=WalkGL   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=RunGL   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=RunGL   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=RunShootGL   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnNausican SEQ=RunShootGL   			TIME=0.66 FUNCTION=FootStepRunSound

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
	DuckMelee1 = 'DuckDK';
	StrafLeftMelee1 = 'StrafLeftDK';
	StrafRightMelee1 = 'StrafRightDK';
	RollLeftMelee1 = 'RollLeftDK';
	RollRightMelee1 = 'RollRightDK';
	WaitIdleMelee1 = 'WaitIdleDK';
	WaitIdleMelee2 = 'WaitKnifeSpinDK';
	WaitIdleMelee3 = 'WaitIdleDK';
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
	ThreatenMelee1 = 'WaitKnifeSpinDK' ;
	ThreatenMelee2 = 'FlyingbackFistDK';
	ThreatenMelee3 = 'WaitKnifeSpinDK';
	CommandMelee1 = 'WaitKnifeSpinDK';
	CommandMelee2 = 'FlyingBackFistDK';
	WalkMelee1 = 'WalkDK';
	InAirMelee1 = 'JumpDK';
	LandMelee1 = 'LandDK';	
	
	

	// Ranged Animations
	DuckRanged1 = 'DuckGL';
	StrafLeftRanged1 = 'StrafLeftGL';
	StrafLeftShootRanged1 = 'StrafLeftShootGL';
	StrafRightRanged1 = 'StrafRightGL';
	StrafRightShootRanged1 = 'StrafRightShootGL';
	RollLeftRanged1 = 'RollLeftGL';
	RollRightRanged1 = 'RollRightGL';
	WaitIdleRanged1 = 'WaitGL';
	WaitIdleRanged2 = 'WaitGL';
	WaitIdleRanged3 = 'WaitGL';
	WaitIdleRanged4 = 'WaitGL';
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
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBlownRight';
	DeadBlownLeft1 = 'DeadBlownLeft';
	DeadFallFace1 = 'DeadFallFace';
	DeadFallBack1 = 'DeadFallBack';
	DeadFallRight1 = 'DeadFallRight';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'WaitKnifeSpinDK';
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

defaultproperties
{
     StabDamage=5
     SlashDamage=7
     BackSlashDamage=10
     hitsound3=Sound'KlingonSFX01.creature.NausHit3'
     stab=Sound'KlingonSFX01.Weapons.Batswing'
     slash=Sound'KlingonSFX01.Weapons.Batswing'
     backslash=Sound'KlingonSFX01.Weapons.Batswing'
     fleshslice=Sound'KlingonSFX01.Weapons.Batslash2'
     Die2=Sound'KlingonSFX01.creature.NausDie2'
     Respond1=Sound'KlingonSFX01.creature.NausResp1b'
     Acquire2=Sound'KlingonSFX01.creature.NausAquire3'
     Threaten2=Sound'KlingonSFX01.creature.NausThreat3'
     ReloadSound1=Sound'KlingonSFX01.Weapons.GrenadeLd2'
     Grunt1=Sound'KlingonSFX01.creature.NausicanSlash4'
     Grunt2=Sound'KlingonSFX01.creature.NausicanSlash5'
     Grunt3=Sound'KlingonSFX01.creature.NausicanSlash4'
     Grunt4=Sound'KlingonSFX01.creature.NausicanSlash5'
     CarcassType=Class'Klingons.NausicanCarcass'
     TimeBetweenAttacks=5.000000
     Aggressiveness=0.300000
     RefireRate=0.500000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     RangedProjectile=Class'Klingons.GrenadeProjectile'
     ProjectileSpeed=500.000000
     Acquire=Sound'KlingonSFX01.creature.NausAquire1'
     Roam=Sound'KlingonSFX01.creature.NausRoam3'
     Threaten=Sound'KlingonSFX01.creature.NausThreat2'
     bCanBeStunned=True
     bCanUseCover=True
     SplatClass=Class'Klingons.RedBlood'
     ShotsBeforeReload=6
     DodgeAmount=0.400000
     Accuracy=700.000000
     PartBlood=Class'Klingons.RedParticles'
     MediumDamage=Texture'KlingonFX01.creatures.NausicanOUCH1'
     HeavyDamage=Texture'KlingonFX01.creatures.NausicanOUCH2'
     MySide=Nausican
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.GrenadFr'
     bHasFlail=True
     bCanStrafe=True
     MeleeRange=50.000000
     GroundSpeed=250.000000
     AirSpeed=0.000000
     AccelRate=500.000000
     HearingThreshold=1.000000
     Health=70
     UnderWaterTime=30.000000
     Intelligence=BRAINS_HUMAN
     HitSound1=Sound'KlingonSFX01.creature.NausHit2'
     HitSound2=Sound'KlingonSFX01.creature.NausHit3'
     Land=Sound'KlingonSFX01.creature.Jump'
     Die=Sound'KlingonSFX01.creature.NausDie1'
     CombatStyle=0.250000
     Physics=PHYS_Walking
     AnimSequence=WaitGL
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnNausican'
     DrawScale=1.600000
     CollisionRadius=24.000000
     CollisionHeight=51.500000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Mass=150.000000
     Buoyancy=140.000000
}
