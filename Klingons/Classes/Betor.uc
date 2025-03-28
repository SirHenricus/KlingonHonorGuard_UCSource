//=============================================================================
// Betor.
//=============================================================================
class Betor expands Humanoids;

#call q:\klingons\art\pawns\Betor\final\Betor.mac
#exec  MESH ORIGIN MESH=PawnBetor X=0 Y=0 Z=-22 YAW=64

#exec MESH NOTIFY MESH=PawnBetor SEQ=Shoot1DP            TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnBetor SEQ=Shoot2DP            TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnBetor SEQ=Shoot3DP            TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnBetor SEQ=RunShootDP          TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafLeftShootDP    TIME=0.45 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafRightShootDP   TIME=0.45 FUNCTION=SpawnShot

#exec MESH NOTIFY MESH=PawnBetor SEQ=Wait1DP             TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnBetor SEQ=Wait2DP             TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnBetor SEQ=WalkDP              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnBetor SEQ=WalkKF              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnBetor SEQ=WaitKF              TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnBetor SEQ=WaitDaktaghSpinDK   TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnBetor SEQ=WaitDaktaghBladesDK TIME=0.50 FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=PawnBetor SEQ=StabKF              TIME=0.4 FUNCTION=StabDamageTarget
#exec MESH NOTIFY MESH=PawnBetor SEQ=StabKF              TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnBetor SEQ=SlashKF             TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=PawnBetor SEQ=SlashKF             TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=PawnBetor SEQ=BackSlashKF         TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=PawnBetor SEQ=BackSlashKF         TIME=0.1 FUNCTION=HumanGrunt


#exec MESH NOTIFY MESH=PawnBetor SEQ=BackPeddleDP   		TIME=0.2 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=BackPeddleDP   		TIME=0.6 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafLeftKF   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafLeftKF   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafRightKF   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafRightKF   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=RunDK   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=RunDK   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafLeftShootDP   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafLeftShootDP   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafLeftDP   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafLeftDP   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafRightShootDP   	TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafRightShootDP   	TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafRightDP   		TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=StrafRightDP   		TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=WalkKF   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=WalkKF   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=WalkDP   				TIME=0.5 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=WalkDP   				TIME=0.08 FUNCTION=FootStepSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=RunDP   				TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=RunDP   				TIME=0.66 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=RunShootDP   			TIME=0.13 FUNCTION=FootStepRunSound
#exec MESH NOTIFY MESH=PawnBetor SEQ=RunShootDP   			TIME=0.66 FUNCTION=FootStepRunSound


//////////////////Variables///////////////////////
// Melee damage.


///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'DuckKF';
	StrafLeftMelee1 = 'StrafLeftKF';
	StrafRightMelee1 = 'StrafRightKF';
	RollLeftMelee1 = 'StrafLeftKF';
	RollRightMelee1 = 'StrafRightKF';
	WaitIdleMelee1 = 'WaitKF';
	WaitIdleMelee2 = 'WaitKF';
	WaitIdleMelee3 = 'WaitKF';
	WaitIdleMelee4 = 'WaitKF';
	StunnedMelee1 = 'StunKF';
	StunnedSquirmMelee1 = 'StunSquirmKF';
	StunnedGetupMelee1 = 'StunGetupKF';
	StabMelee1 = 'StabKF';
	SlashMelee1 = 'SlashKF';
	BackSlashMelee1 = 'BackSlashKF';
	HitGutMelee1 = 'HitGutKF';
	HitRightMelee1 = 'HitRightKF';
	HitLeftMelee1 = 'HitLeftKF';
	HitHeadMelee1 = 'HitHeadKF';
	RunMelee1 = 'RunKF';
	BackPeddleMelee1 = 'BackPeddleKF';
	ThreatenMelee1 = 'SlashKF';
	ThreatenMelee2 = 'BackSlashKF';
	ThreatenMelee3 = 'SlashKF';
	CommandMelee1 = 'Wait1DP';
	CommandMelee2 = 'Wait1DP';
	WalkMelee1 = 'WalkKF';
	InAirMelee1 = 'JumpKF';
	LandMelee1 = 'LandKF';	
	

	// Ranged Animations
	DuckRanged1 = 'DuckDP';
	StrafLeftRanged1 = 'StrafLeftDP';
	StrafLeftShootRanged1 = 'StrafLeftShootDP';
	StrafRightRanged1 = 'StrafRightDP';
	StrafRightShootRanged1 = 'StrafLeftShootDP';
	RollLeftRanged1 = 'StrafLeftDP';
	RollRightRanged1 = 'StrafRightDP';
	WaitIdleRanged1 = 'Wait1DP';
	WaitIdleRanged2 = 'Wait1DP';
	WaitIdleRanged3 = 'Wait2DP';
	WaitIdleRanged4 = 'Wait2DP';
	StunnedRanged1 = 'StunDP';
	StunnedSquirmRanged1 = 'StunSquirmDP';
	StunnedShootRanged1 = 'StunShootDP';
	StunnedGetupRanged1 = 'StunGetupDP';
	CheckRanged1 = 'Wait1DP';
	ReloadRanged1 = 'Wait1DP';
	KneelShootRanged1 = 'Shoot1DP';
	ShootRanged1 = 'ShootDP';
	HitGutRanged1 = 'HitGutDP';
	HitRightRanged1 = 'HitRightDP';
	HitLeftRanged1 = 'HitLeftDP';
	HitHeadRanged1 = 'HitHeadDP';
	RunRanged1 = 'RunDP';
	BackPeddleRanged1 = 'RunDP';
	RunShootRanged1 = 'RunShootDP';
	SwimRanged1 = 'RunDP';
	WalkRanged1 = 'WalkDP';
	InAirRanged1 = 'JumpDP';
	LandRanged1 = 'LandDP';
			
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadFall';
	DeadBlownRight1 = 'DeadFall';
	DeadBlownLeft1 = 'DeadFall';
	DeadFallFace1 = 'DeadFall';
	DeadFallBack1 = 'DeadFall';
	DeadFallRight1 = 'DeadFall';
	DeadBackRoll1 = 'DeadFall';
	DeadBlownBack1 = 'DeadFall';
	
	VictoryDance1 = 'Wait1DP';
	VictoryDance2 = 'Wait2DP';
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

function SetMovementPhysics()
{
	if ( Region.Zone.bWaterZone )
		SetPhysics(PHYS_Swimming);
	else if (Physics != PHYS_Walking)
		SetPhysics(PHYS_Walking); 
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	Super.TakeDamage(Damage,instigatedBy, hitLocation, vect(0,0,0), damageType);
	
	if (Health < 0)
	{
		SpecialDeath = 0;
	}
	
}


function bool IsMeleeAnim()
{
	if (!bHasRangedAttack)
	{
		return true;
	}
	else
		return (right(AnimSequence, 2) == "KF"); 
}


function PlayBigDeath(name DamageType)
{
	PlaySound(Die2, SLOT_Talk);
	PlayAnim('DeadFall',0.8,0.1);
}

function PlayHeadDeath(name DamageType)
{
	//XXXUnreal Stuff for decapitation effects, see unreal stuff
	PlayAnim('DeadFall',0.7,0.1);
	PlaySound(Die, SLOT_Talk);
}

function PlayLeftDeath(name DamageType)
{	
	PlayAnim('DeadFall',0.6,0.1);
	PlaySound(Die,SLOT_Talk);
}

function PlayRightDeath(name DamageType)
{
	PlayAnim('DeadFall',0.7,0.1);
	PlaySound(Die,SLOT_Talk);
}

function PlayGutDeath(name DamageType)
{
	PlayAnim('DeadFall',0.7,0.1);
	PlaySound(Die,SLOT_Talk);
}



function PlayRangedAttack()
{
	local float decision;
	
	if (decision < 0.3)
		PlayAnim('Shoot2DP', 1.0, 0.1);
	else if (decision < 0.6)
		PlayAnim('Shoot3DP', 1.0, 0.15);
	else
		PlayAnim('Shoot1DP', 1.0, 0.15);
}	

defaultproperties
{
     StabDamage=10
     SlashDamage=10
     BackSlashDamage=10
     stab=Sound'KlingonSFX01.creature.AndCptSwing'
     slash=Sound'KlingonSFX01.creature.AndCptSwing'
     backslash=Sound'KlingonSFX01.creature.AndCptSwing'
     fleshslice=Sound'KlingonSFX01.Weapons.Batslash2'
     Threaten2=Sound'KlingonSFX01.creature.Betor6'
     Threaten3=Sound'KlingonSFX01.creature.NewBetor4'
     Grunt1=Sound'KlingonSFX01.creature.FMSlash'
     Grunt2=Sound'KlingonSFX01.creature.FMStab'
     Grunt3=Sound'KlingonSFX01.creature.FMSlash'
     Grunt4=Sound'KlingonSFX01.creature.FMStab'
     CarcassType=Class'Klingons.KlingonCarcass'
     RefireRate=0.600000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.DisruptorProjectile'
     ProjectileSpeed=2000.000000
     Acquire=Sound'KlingonSFX01.creature.Betor3'
     Threaten=Sound'KlingonSFX01.creature.Betor2'
     bCanUseCover=True
     SplatClass=Class'Klingons.BloodSplat'
     DodgeAmount=0.500000
     RetreatDamage=5
     MySide=Duras
     MuzzleFlash=Class'Klingons.DisruptorFlash3'
     MuzzleFlashSound=Sound'KlingonSFX01.Weapons.Wepon4'
     bCanStrafe=True
     MeleeRange=35.000000
     GroundSpeed=400.000000
     AirSpeed=0.000000
     AccelRate=512.000000
     HearingThreshold=1.000000
     Health=1500
     Intelligence=BRAINS_HUMAN
     Skill=2.500000
     HitSound1=Sound'KlingonSFX01.creature.BetorGrunt1'
     HitSound2=Sound'KlingonSFX01.creature.BetorGrunt1'
     Die=Sound'KlingonSFX01.creature.BetorGrunt2'
     Physics=PHYS_Walking
     AnimSequence=Wait1DP
     DrawType=DT_Mesh
     Texture=None
     Mesh=Mesh'Klingons.PawnBetor'
     DrawScale=1.600000
     CollisionHeight=49.500000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=90.000000
}
