//=============================================================================
// VacSuitGuy.
//=============================================================================
// By Mark E. Bradshaw

class VacSuitGuy expands Humanoids;

#exec MESH NOTIFY MESH=DMVacSuit SEQ=Shoot TIME=0.5 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=DMVacSuit SEQ=RunShoot TIME=0.5 FUNCTION=SpawnShot


//XXX
//FootStep sounds?
//Swimming?
//Ducking? Ducking To Shoot?
//Speaking?
//Projectile location?

//////////////////Variables///////////////////////
// Melee damage.
var(Pawn) class<inventory> mygun;

///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	local Inventory gun;
	local vector gunloc;
	
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'HitScooching';
	StrafLeftMelee1 = 'Run';
	StrafRightMelee1 = 'Run';
	RollLeftMelee1 = 'RollLeft';
	RollRightMelee1 = 'RollRight';
	WaitIdleMelee1 = 'Wait';
	WaitIdleMelee2 = 'Wait';
	WaitIdleMelee3 = 'Wait';
	WaitIdleMelee4 = 'Wait';
	StunnedMelee1 = 'DeadFallBack';
	StunnedSquirmMelee1 = '';
	StunnedGetupMelee1 = '';
	StabMelee1 = 'Stab_DAK';
	SlashMelee1 = 'Slash_DAK';
	BackSlashMelee1 = 'BackSlash_DAK';
	HitGutMelee1 = 'HitGut';
	HitRightMelee1 = 'HitRight';
	HitLeftMelee1 = 'HitLeft';
	HitHeadMelee1 = 'HitHead';
	RunMelee1 = 'Run';
	BackPeddleMelee1 = 'Run';
	ThreatenMelee1 = 'Slash_DAK' ;
	ThreatenMelee2 = 'Slash_DAK';
	ThreatenMelee3 = 'Slash_DAK';
	CommandMelee1 = 'Taunt1';
	CommandMelee2 = 'Taunt1';
	WalkMelee1 = 'Walk';
	InAirMelee1 = 'Jump';
	LandMelee1 = 'Land';


	// Ranged Animations
	DuckRanged1 = 'HitScooching';
	StrafLeftRanged1 = 'Run';
	StrafLeftShootRanged1 = 'Run';
	StrafRightRanged1 = 'Run';
	StrafRightShootRanged1 = 'Run';
	RollLeftRanged1 = 'RollLeft';
	RollRightRanged1 = 'RollRight';
	WaitIdleRanged1 = 'Wait';
	WaitIdleRanged2 = 'Wait';
	WaitIdleRanged3 = 'Wait';
	WaitIdleRanged4 = 'Wait';
	StunnedRanged1 = 'DeadFallBack';
	StunnedSquirmRanged1 = '';
	StunnedShootRanged1 = '';
	StunnedGetupRanged1 = '';
	CheckRanged1 = 'Reload';
	ReloadRanged1 = 'Reload';
	KneelShootRanged1 = 'Shoot';
	ShootRanged1 = 'Shoot';
	HitGutRanged1 = 'HitGut';
	HitRightRanged1 = 'HitRight';
	HitLeftRanged1 = 'HitLeft';
	HitHeadRanged1 = 'HitHead';
	RunRanged1 = 'Run';
	BackPeddleRanged1 = 'Run';
	RunShootRanged1 = 'RunShoot';
	SwimRanged1 = 'Run';
	WalkRanged1 = 'Walk';
	InAirRanged1 = 'Jump';
	LandRanged1 = 'Land';
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBlownRight';
	DeadBlownLeft1 = 'DeadBlownLeft';
	DeadFallFace1 = 'DeadFallFace';
	DeadFallBack1 = 'DeadFallBack';
	DeadFallRight1 = 'DeadFallBack';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'Taunt1';
	VictoryDance2 = 'Taunt1';
	

	Super.PreBeginPlay();


	gun = Spawn(class'DisruptorPistol');
	gunloc = gun.location;
	gunloc.z +=150;
	gun.Setlocation(gunloc);
	gun.pickupViewScale = 0.1;
	gun.pickupviewmesh = none;
	gun.giveto(self);
//	gun.Setcollision(false,false,false);

//	AddInventory(gun);
	 
//	{
//		gun.BecomePickup();
//	}
	
//	else
//		log("Add failed");

	SwitchToBestWeapon();	
//	gun.bHidden = true;	
	
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

function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
}

function PlayLeftFootStep()
{
	PlaySound(sound'MagBootLeft',SLOT_Interact,300,,VoiceRadius);	
	
}

function PlayRightFootStep()
{
	PlaySound(sound'MagBootRight',SLOT_Interact,300,,VoiceRadius);	
	
}


function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	if (damageType == 'Suffocated')
		return;
		
	Super.TakeDamage(Damage, instigatedBy, hitLocation, momentum, damageType);
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

	PlayRangedAttack();
	return;
/*
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
*/ 	
}



/////////////////Animation Functions//////////////////////

defaultproperties
{
     mygun=Class'Klingons.DisruptorRifle'
     CarcassType=Class'Klingons.VacSuitCarcass'
     Aggressiveness=0.500000
     bHasRangedAttack=True
     RangedProjectile=Class'Klingons.DisruptorRed'
     Accuracy=650.000000
     MySide=VacSuit
     MeleeRange=50.000000
     AccelRate=100.000000
     JumpZ=-1.000000
     HitSound1=Sound'KlingonSFX01.creature.DurasGruntGrnt1'
     HitSound2=Sound'KlingonSFX01.creature.DurasGruntGrnt3'
     CombatStyle=0.500000
     AnimSequence=Wait
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.DMVacSuit'
     DrawScale=1.600000
     CollisionHeight=50.000000
}
