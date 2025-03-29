//=============================================================================
// Warden.
//=============================================================================
class Warden expands Humanoids;


#call q:\klingons\art\pawns\Warden\final\Warden.mac
#exec  MESH ORIGIN MESH=PawnWarden X=0 Y=0 Z=-23 YAW=64

#exec MESH NOTIFY MESH=PawnWarden SEQ=ShootDR             TIME=0.35 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnWarden SEQ=RunShootDR          TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafLeftShootDR    TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafRightShootDR   TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnWarden SEQ=KneelShootDR        TIME=0.35 FUNCTION=SpawnKneelShot

#exec MESH NOTIFY MESH=PawnWarden SEQ=WaitDR              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnWarden SEQ=WalkDR              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnWarden SEQ=WalkDK              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnWarden SEQ=WaitIdleDK          TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnWarden SEQ=WaitDaktaghSpin   TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnWarden SEQ=WaitDaktaghBlades TIME=0.50 FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnWarden SEQ=StabDK              TIME=0.4 FUNCTION=StabDamageTarget
#exec MESH NOTIFY MESH=PawnWarden SEQ=StabDK              TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnWarden SEQ=SlashDK             TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnWarden SEQ=SlashDK             TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnWarden SEQ=BackSlashDK         TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnWarden SEQ=BackSlashDK         TIME=0.1 FUNCTION=HumanGrunt


#exec MESH NOTIFY MESH=PawnWarden SEQ=BackPeddleDR   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=BackPeddleDR   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=BackPeddleDK   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=BackPeddleDK   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafLeftDK   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafLeftDK   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafRightDK   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafRightDK   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=RunDK   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=RunDK   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafLeftShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafLeftShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafLeftDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafLeftDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafRightShootDR   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafRightShootDR   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafRightDR   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=StrafRightDR   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=WalkDK   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=WalkDK   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=WalkDR   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=WalkDR   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=RunDR   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=RunDR   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=RunShootDR   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnWarden SEQ=RunShootDR   			TIME=0.66 FUNCTION=FootStepRunSound

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
	WaitIdleMelee2 = 'WaitDaktaghSpin';
	WaitIdleMelee3 = 'WaitDaktaghBlades';
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
	BackPeddleMelee1 = 'RunDK';
	ThreatenMelee1 = 'WaitDaktaghSpin' ;
	ThreatenMelee2 = 'SlashDK';
	ThreatenMelee3 = 'BackSlashDK';
	CommandMelee1 = 'WaitDaktaghSpin';
	CommandMelee2 = 'WaitDaktaghBlades';
	WalkMelee1 = 'WalkDK';
	InAirMelee1 = 'JumpDK';
	LandMelee1 = 'LandDK';	
	
	

	// Ranged Animations
	DuckRanged1 = 'DuckDR';
	StrafLeftRanged1 = 'StrafLeftDR';
	StrafLeftShootRanged1 = 'StrafLeftShootDR';
	StrafRightRanged1 = 'StrafRightDR';
	StrafRightShootRanged1 = 'StrafRightShootDR';
	RollLeftRanged1 = 'RollLeftDR';
	RollRightRanged1 = 'RollRightDR';
	WaitIdleRanged1 = 'WaitDR';
	WaitIdleRanged2 = 'WaitDR';
	WaitIdleRanged3 = 'WaitDR';
	WaitIdleRanged4 = 'WaitDR';
	StunnedRanged1 = 'StunDR';
	StunnedSquirmRanged1 = 'StunSquirmDR';
	StunnedShootRanged1 = 'StunShootDR';
	StunnedGetupRanged1 = 'StunGetupDR';
	CheckRanged1 = 'ReloadAD';
	ReloadRanged1 = 'ReloadAD';
	KneelShootRanged1 = 'KneelShootDR';
	ShootRanged1 = 'ShootDR';
	HitGutRanged1 = 'HitGutDR';
	HitRightRanged1 = 'HitRightDR';
	HitLeftRanged1 = 'HitLeftDR';
	HitHeadRanged1 = 'HitHeadDR';
	RunRanged1 = 'RunDR';
	BackPeddleRanged1 = 'RunDR';
	RunShootRanged1 = 'RunShootDR';
	SwimRanged1 = 'RunDR';
	WalkRanged1 = 'WalkDR';
	InAirRanged1 = 'JumpDR';
	LandRanged1 = 'LandDR';	
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBackToFace';
	DeadBlownLeft1 = 'DeadBackToFace';
	DeadFallFace1 = 'DeadBackToFace';
	DeadFallBack1 = 'DeadBlownBack';
	DeadFallRight1 = 'DeadBackRoll';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'WaitDaktaghSpin';
	VictoryDance2 = 'WaitDaktaghBlades';

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
     StabDamage=10
     SlashDamage=10
     BackSlashDamage=10
     stab=Sound'KlingonSFX01.Weapons.Batswing'
     slash=Sound'KlingonSFX01.Weapons.Batswing'
     backslash=Sound'KlingonSFX01.Weapons.Batswing'
     fleshslice=Sound'KlingonSFX01.Weapons.Batslash2'
     Acquire2=Sound'KlingonSFX01.creature.WardenTaunt3'
     Threaten2=Sound'KlingonSFX01.creature.WardenTaunt4'
     Threaten3=Sound'KlingonSFX01.creature.WardenTaunt2'
     ReloadSound1=Sound'KlingonSFX01.Weapons.AssultLd2'
     Grunt1=Sound'KlingonSFX01.creature.MDktaghBackfist'
     Grunt2=Sound'KlingonSFX01.creature.MDktaghBackslas'
     Grunt3=Sound'KlingonSFX01.creature.MDktaghStab2'
     Grunt4=Sound'KlingonSFX01.creature.MDktaghSlash1'
     CarcassType=Class'Klingons.KlingonCarcass'
     TimeBetweenAttacks=1.500000
     Aggressiveness=0.250000
     RefireRate=0.500000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.AssaultProjectile'
     ProjectileSpeed=1250.000000
     Acquire=Sound'KlingonSFX01.creature.WardenTaunt5'
     Threaten=Sound'KlingonSFX01.creature.WardenTaunt1'
     bCanUseCover=True
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=8
     DodgeAmount=0.200000
     RetreatDamage=5
     MySide=RuraPente
     bCanStrafe=True
     MeleeRange=40.000000
     GroundSpeed=400.000000
     AirSpeed=0.000000
     AccelRate=512.000000
     HearingThreshold=1.000000
     Health=300
     Intelligence=BRAINS_HUMAN
     Skill=3.000000
     Physics=PHYS_Walking
     AnimSequence=WaitDR
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnWarden'
     DrawScale=1.600000
     CollisionRadius=27.000000
     CollisionHeight=54.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Mass=140.000000
     Buoyancy=150.000000
}
