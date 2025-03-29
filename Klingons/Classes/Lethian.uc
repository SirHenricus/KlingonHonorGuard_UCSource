//=============================================================================
// Lethian.
//=============================================================================
class Lethian expands Humanoids;

#call q:\klingons\art\pawns\Lethian\final\Lethian.mac
#exec  MESH ORIGIN MESH=PawnLethian X=0 Y=0 Z=-36 YAW=64

#exec MESH NOTIFY MESH=PawnLethian SEQ=Wait        TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnLethian SEQ=Walk        TIME=0.50 FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=PawnLethian SEQ=ShockAttack TIME=0.5 FUNCTION=StunAttackTarget
#exec MESH NOTIFY MESH=PawnLethian SEQ=ShockAttack TIME=0.13 FUNCTION=SpawnLightning
#exec MESH NOTIFY MESH=PawnLethian SEQ=Attack1     TIME=0.8 FUNCTION=SpawnShot



var() int StunDamage;
var float DesiredGlow;
var LightningPulse LP;


var(Sounds) sound StunHit;




var 		bool bIsInvisible;
///////////////Basic Functions/////////////////////
function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'Duck';
	StrafLeftMelee1 = 'StrafLeft';
	StrafRightMelee1 = 'StrafRight';
	RollLeftMelee1 = 'StrafLeft';
	RollRightMelee1 = 'StrafRight';
	WaitIdleMelee1 = 'Wait';
	WaitIdleMelee2 = 'Wait';
	WaitIdleMelee3 = 'Wait';
	WaitIdleMelee4 = 'Wait';
	StunnedMelee1 = 'Stun';
	StunnedSquirmMelee1 = 'StunSquirm';
	StunnedGetupMelee1 = 'StunGetup';
	StabMelee1 = 'ShockAttack';
	SlashMelee1 = 'ShockAttack';
	BackSlashMelee1 = 'ShockAttack';
	HitGutMelee1 = 'HitGut';
	HitRightMelee1 = 'HitRight';
	HitLeftMelee1 = 'HitLeft';
	HitHeadMelee1 = 'HitHead';
	RunMelee1 = 'Run';
	BackPeddleMelee1 = 'Run';
	ThreatenMelee1 = 'Wait' ;
	ThreatenMelee2 = 'Wait';
	ThreatenMelee3 = 'Wait';
	CommandMelee1 = 'Wait';
	CommandMelee2 = 'Wait';
	WalkMelee1 = 'Walk';
	InAirMelee1 = 'Jump';
	LandMelee1 = 'Land';
	

	
	// Ranged Animations
	DuckRanged1 = 'Duck';
	StrafLeftRanged1 = 'StrafLeft';
	StrafLeftShootRanged1 = 'StrafLeft';
	StrafRightRanged1 = 'StrafRight';
	StrafRightShootRanged1 = 'StrafRight';
	RollLeftRanged1 = 'StrafLeft';
	RollRightRanged1 = 'StrafRight';
	WaitIdleRanged1 = 'Wait';
	WaitIdleRanged2 = 'Wait';
	WaitIdleRanged3 = 'Wait';
	WaitIdleRanged4 = 'Wait';
	StunnedRanged1 = 'Stun';
	StunnedSquirmRanged1 = 'StunSquirm';
	StunnedShootRanged1 = 'StunSquirm';
	StunnedGetupRanged1 = 'StunGetup';
	CheckRanged1 = 'wait';
	ReloadRanged1 = 'wait';
	KneelShootRanged1 = 'Duck';
	ShootRanged1 = 'Attack1';
	HitGutRanged1 = 'HitGut';
	HitRightRanged1 = 'HitRight';
	HitLeftRanged1 = 'HitLeft';
	HitHeadRanged1 = 'HitHead';
	RunRanged1 = 'Run';
	BackPeddleRanged1 = 'Run';
	RunShootRanged1 = 'wait';
	SwimRanged1 = 'Run';
	WalkRanged1 = 'Walk';
	InAirRanged1 = 'Jump';
	LandRanged1 = 'Land';
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBackRoll';
	DeadBlownLeft1 = 'DeadBackRoll';
	DeadFallFace1 = 'DeadBackRoll';
	DeadFallBack1 = 'DeadBlownBack';
	DeadFallRight1 = 'DeadBlownBack';
	DeadBackRoll1 = 'DeadBackRoll';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'Wait';
	VictoryDance2 = 'Wait';


	Super.PreBeginPlay();
	bIsInvisible = true;
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


function Tick(float DeltaTime)
{
	local bool bDone;
	local float OverGlow;
	
	Super.Tick(DeltaTime);
	if (!bisinvisible)
		return;

	if (ScaleGlow < DesiredGlow)
	{
		ScaleGlow+=0.1*DeltaTime;
		if (ScaleGlow > DesiredGlow)
		{
			OverGlow = ScaleGlow-DesiredGlow;
			DesiredGlow = 0.5*FRand() + 0.5*VSize(Velocity)/GroundSpeed;
			if (ScaleGlow < DesiredGlow)
				ScaleGlow+=OverGlow;
			else
				ScaleGlow-=OverGlow;
		}
	}
	else
	{
		ScaleGlow-=0.1*DeltaTime;
		if (ScaleGlow < DesiredGlow)
		{
			OverGlow = DesiredGlow-ScaleGlow;
			DesiredGlow = 0.5*FRand() + 0.5*VSize(Velocity)/GroundSpeed;
			if (ScaleGlow < DesiredGlow)
				ScaleGlow+=OverGlow;
			else
				ScaleGlow-=OverGlow;
		}		
	}
}


function AdjustLightningPosition()
{
	local vector StartOffset;
	local vector X,Y,Z,ProjStart;
	local rotator newrot;

	GetAxes(Rotation,X,Y,Z);
	StartOffset = vect(1.6, 0.0, 1.5);
	projStart = Location + StartOffset.X * CollisionRadius * X 
				+ StartOffset.Y * CollisionRadius * Y 
				+ StartOffset.Z * CollisionRadius * Z;

	lp.SetLocation(projstart);
//	newrot = rotation;
//	newrot.roll = 16500;
//	lp.setrotation(newrot);
}

function SpawnLightning()
{
	local Rotator newrot;

	LP = spawn(class'LightningPulse');
	LP.DrawScale = 0.11;

//	newrot = Rotation;
//	newrot.roll = 16500;
//	LP.SetRotation(newrot);
	
	AdjustLightningPosition();
	PlaySound(sound'DisruptHit',SLOT_Interact,,,VoiceRadius);

}


function StunAttackTarget()
{
	if ( MeleeDamageTarget(StunDamage, (StunDamage * 500 * Normal(Target.Location - Location))) ) 
	{
		PlaySound(StunHit, SLOT_Interact,,,VoiceRadius);
		//KlingonPlayer(Target).FlashDamage(5);
	}
}			

function BecomeVisible()
{
	bisinvisible = false;
	ScaleGlow = 1.0;
	Style = STY_Normal;
}

function BecomeInVisible()
{
	bisinvisible = true;
	DesiredGlow = 0.5;
	Style = STY_Translucent;
}

function PlayRangedAttack()
{
	PlayAnim(ShootRanged1,1.0,0.15);
		
}

function PlayDeathAnims()
{
	local float RandAni;
	
	if ((SpecialDeath == 1) || 
		(SpecialDeath == 3) ||
		(SpecialDeath == 4) ||
		(SpecialDeath == 5))
		return;

	RandAni = FRand();
	if (RandAni < 0.33)
	{
		PlayAnim(DeadBackToFace1,0.6,0.1);
	}
	else if (RandAni < 0.66)
	{
		PlayAnim(DeadBackRoll1,0.6,0.1);
	}
	else
	{
		PlayAnim(DeadBlownBack1,0.6,0.1);
	}
	
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	if (damageType == 'Imploded')
	{
		Damage = 0;
	}
		
	Super.TakeDamage(Damage, instigatedBy, hitlocation, 
						momentum, damageType);
}

State MeleeAttack
{
ignores SeePlayer, HearNoise, Bump;

function EndState()
{
	BecomeInVisible();
}

function Tick(float DeltaTime)
{
	if (lp != none)
		AdjustLightningPosition();

	Global.Tick(DeltaTime);	
}


function BeginState()
{
	BecomeVisible();
	Target = Enemy;
	Disable('AnimEnd');
	bReadyToAttack = false;
}

Begin:
	DesiredRotation = Rotator(Enemy.Location - Location);
	TweenToFighter(0.15); 
	
FaceTarget:
	Acceleration = vect(0,0,0); //stop
	if (NeedToTurn(Enemy.Location))
	{
		PlayTurning();
		TurnToward(Enemy);
		TweenToFighter(0.1);
	}
	FinishAnim();
	OldAnimRate = 0;	// force no tween 
		
	if ( (Abs(Location.Z - Enemy.Location.Z) 
			> FMax(CollisionHeight, Enemy.CollisionHeight) + 0.5 * FMin(CollisionHeight, Enemy.CollisionHeight)) ||
		(VSize(Location - Enemy.Location) > MeleeRange + CollisionRadius + Enemy.CollisionRadius) )
		GotoState('RangedAttack', 'ReadyToAttack'); 

ReadyToAttack:
	DesiredRotation = Rotator(Enemy.Location - Location);
	PlayMeleeAttack();
	Enable('AnimEnd');
Attacking:
	TurnToward(Enemy);
	Goto('Attacking');
DoneAttacking:
	Disable('AnimEnd');
	KeepAttacking();
	if ( FRand() < 0.3 - 0.1 * skill )
	{
		Acceleration = vect(0,0,0); //stop
		DesiredRotation = Rotator(Enemy.Location - Location);
		PlayChallenge();
		FinishAnim();
		TweenToFighter(0.1);
	}
	Goto('FaceTarget');
}

state TakeHit 
{
ignores seeplayer, hearnoise, bump, hitwall;

function EndState()
{
	BecomeInVisible();
}

function BeginState()
{
	BecomeVisible();
	LastPainTime = Level.TimeSeconds;
	LastPainAnim = AnimSequence;
}
		
Begin:
	if (AnimSequence == 'blinded')
		GotoState('Blinded');
	if (GetAnimGroup(AnimSequence) == 'Stun')
		GotoState('Stunned');
	
	Acceleration = Normal(Acceleration);
	FinishAnim();
	Sleep(0.05);
	Acceleration = vect(0,0,0);
	if (Physics == PHYS_Falling)
	{
		NextAnim = '';
		if ( Velocity.X * Velocity.X + Velocity.Y * Velocity.Y < 10000 )
			TweenToFalling();
		GotoState('FallingState', 'Ducking');
	}
	else if (NextState != '')
		GotoState(NextState, NextLabel);
	else
		GotoState('Attacking');
}

defaultproperties
{
     StunDamage=25
     Acquire2=Sound'KlingonSFX01.creature.LethAquire2B'
     Threaten2=Sound'KlingonSFX01.creature.LethThreat2B'
     CarcassType=Class'Klingons.KlingonCarcass'
     Aggressiveness=0.500000
     bHasRangedAttack=True
     bWarnTarget=False
     RangedProjectile=Class'Klingons.HunterBolt'
     Acquire=Sound'KlingonSFX01.creature.LethAquire3B'
     Threaten=Sound'KlingonSFX01.creature.LethThreat1B'
     bCanBeStunned=True
     SplatClass=Class'Klingons.RedBlood'
     DodgeAmount=0.100000
     PartBlood=Class'Klingons.RedParticles'
     MediumDamage=Texture'KlingonFX01.creatures.LethianOUCH1'
     HeavyDamage=Texture'KlingonFX01.creatures.LethianOUCH2'
     MySide=Lethian
     bCanStrafe=True
     MeleeRange=30.000000
     GroundSpeed=400.000000
     AirSpeed=0.000000
     AccelRate=400.000000
     HearingThreshold=1.500000
     Health=60
     Intelligence=BRAINS_HUMAN
     Skill=0.500000
     HitSound1=Sound'KlingonSFX01.creature.LethHit2'
     HitSound2=Sound'KlingonSFX01.creature.LethHit4'
     Die=Sound'KlingonSFX01.creature.LethDie'
     CombatStyle=0.400000
     Physics=PHYS_Walking
     DrawType=DT_Mesh
     Style=STY_Translucent
     Texture=None
     Mesh=Mesh'Klingons.PawnLethian'
     DrawScale=1.600000
     ScaleGlow=0.400000
     CollisionRadius=24.000000
     CollisionHeight=48.500000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=90.000000
}
