//=============================================================================
// AndorianBabe.
//=============================================================================
class AndorianBabe expands Humanoids;

#call q:\klingons\art\pawns\andoriangirl\final\andoriangirl.mac
#exec MESH ORIGIN MESH=PawnAndorianGirl X=0 Y=0 Z=-30 YAW=64

var float LastDanceSwitch;

function PreBeginPlay()
{
	bCanSpeak = true;
	if ( CombatStyle == Default.CombatStyle)
		CombatStyle = CombatStyle + 0.3 * FRand() - 0.15;

	// Melee Animations
	DuckMelee1 = 'Wait';
	StrafLeftMelee1 = 'Walk';
	StrafRightMelee1 = 'Walk';
	RollLeftMelee1 = 'Walk';
	RollRightMelee1 = 'Walk';
	WaitIdleMelee1 = 'Wait';
	WaitIdleMelee2 = 'Wait';
	WaitIdleMelee3 = 'Wait';
	WaitIdleMelee4 = 'Wait';
	StunnedMelee1 = 'Wait';
	StunnedSquirmMelee1 = 'Wait';
	StunnedGetupMelee1 = 'Wait';
	StabMelee1 = 'DanceOne';
	SlashMelee1 = 'DanceTwo';
	BackSlashMelee1 = 'DanceOne';
	HitGutMelee1 = 'Wait';
	HitRightMelee1 = 'Wait';
	HitLeftMelee1 = 'Wait';
	HitHeadMelee1 = 'Wait';
	RunMelee1 = 'Walk';
	BackPeddleMelee1 = 'Walk';
	ThreatenMelee1 = 'DanceOne' ;
	ThreatenMelee2 = 'DanceTwo';
	ThreatenMelee3 = 'DanceOne';
	CommandMelee1 = 'Wait';
	CommandMelee2 = 'Wait';
	WalkMelee1 = 'Walk';
	InAirMelee1 = 'Wait';
	LandMelee1 = 'Wait';


	// Ranged Animations
	DuckRanged1 = 'Wait';
	StrafLeftRanged1 = 'Walk';
	StrafLeftShootRanged1 = 'Walk';
	StrafRightRanged1 = 'Walk';
	StrafRightShootRanged1 = 'Walk';
	RollLeftRanged1 = 'Walk';
	RollRightRanged1 = 'Walk';
	WaitIdleRanged1 = 'Wait';
	WaitIdleRanged2 = 'Wait';
	WaitIdleRanged3 = 'Wait';
	WaitIdleRanged4 = 'Wait';
	StunnedRanged1 = 'Wait';
	StunnedSquirmRanged1 = 'Wait';
	StunnedShootRanged1 = 'Wait';
	StunnedGetupRanged1 = 'Wait';
	CheckRanged1 = 'Wait';
	ReloadRanged1 = 'Wait';
	KneelShootRanged1 = 'Wait';
	ShootRanged1 = 'Wait';
	HitGutRanged1 = 'Wait';
	HitRightRanged1 = 'Wait';
	HitLeftRanged1 = 'Wait';
	HitHeadRanged1 = 'Wait';
	RunRanged1 = 'Walk';
	BackPeddleRanged1 = 'Walk';
	RunShootRanged1 = 'Walk';
	SwimRanged1 = 'Walk';
	WalkRanged1 = 'Walk';
	InAirRanged1 = 'Wait';
	LandRanged1 = 'Wait';
	
	// Deaths & Stuff
	DeadBackToFace1 = 'Dead';
	DeadBlownRight1 = 'Dead';
	DeadBlownLeft1 = 'Dead';
	DeadFallFace1 = 'Dead';
	DeadFallBack1 = 'Dead';
	DeadFallRight1 = 'Dead';
	DeadBackRoll1 = 'Dead';
	DeadBlownBack1 = 'Dead';
	
	VictoryDance1 = 'DanceOne';
	VictoryDance2 = 'DanceOne';
	


	Super.PreBeginPlay();
}

function PlayMovingAttack()
{
	PlayWalking();
}

function PlayRunning()
{
	PlayWalking();
}


function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	if (KlingonPlayer(instigatedBy) != none)
	{
		AttitudeToPlayer = ATTITUDE_Fear;
	}
	super.TakeDamage(Damage, instigatedBy, hitlocation, momentum,damageType);
}

state() Dance
{
ignores seeplayer;
function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	if (KlingonPlayer(instigatedBy) != none)
	{
		AttitudeToPlayer = ATTITUDE_Fear;
	}
	super.TakeDamage(Damage, instigatedBy, hitlocation, momentum,damageType);
	if (Health > 0)
		GotoState('Dance','StopLook');
}

function Bump(actor Other)
{
	if (Level.TimeSeconds > 2.0 + LastDanceSwitch)
	{
		if (AnimSequence == 'DanceTwo')
			LoopAnim('DanceOne',1.0,0.3);
		else
			LoopAnim('DanceTwo',1.0,0.3);
		LastDanceSwitch = Level.TimeSeconds;
	}
	
}	
StopLook:
	PlayAnim('Wait',1.0,0.3);
	FinishAnim();
begin:
	Enable('AnimEnd');
	LoopAnim('DanceTwo');
	

}


state() GirlSleep
{

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	if (KlingonPlayer(instigatedBy) != none)
	{
		AttitudeToPlayer = ATTITUDE_Fear;
	}
	super.TakeDamage(Damage, instigatedBy, hitlocation, momentum,damageType);
	if (Health > 0)
	{
		LoopAnim('Sleep',1.0,0.6);
		GotoState('GirlSleep');
	}
	else
	{		
		DeadBackToFace1 = 'DeadSleep';
		DeadBlownRight1 = 'DeadSleep';
		DeadBlownLeft1 = 'DeadSleep';
		DeadFallFace1 = 'DeadSleep';
		DeadFallBack1 = 'DeadSleep';
		DeadFallRight1 = 'DeadSleep';
		DeadBackRoll1 = 'DeadSleep';
		DeadBlownBack1 = 'DeadSleep';
	}
}


function Bump(actor Other)
{
	if (Level.TimeSeconds > 2.0 + LastDanceSwitch)
	{
		if (AnimSequence == 'Sleep')
			LoopAnim('LayDown',1.0,0.3);
		else
			LoopAnim('Sleep',1.0,0.3);
		LastDanceSwitch = Level.TimeSeconds;
	}
}	


function SeePlayer(Actor SeenPlayer)
{
	LoopAnim('LayDown',1.0,0.6);
	SetTimer(15,false);
}


function Timer()
{
	LoopAnim('Sleep',1.0,0.8);
}
	
	
begin:

	DeadBackToFace1 = 'DeadSleep';
	DeadBlownRight1 = 'DeadSleep';
	DeadBlownLeft1 = 'DeadSleep';
	DeadFallFace1 = 'DeadSleep';
	DeadFallBack1 = 'DeadSleep';
	DeadFallRight1 = 'DeadSleep';
	DeadBackRoll1 = 'DeadSleep';
	DeadBlownBack1 = 'DeadSleep';
	HitGutMelee1 = 'DeadSleep';
	HitRightMelee1 = 'DeadSleep';
	HitLeftMelee1 = 'DeadSleep';
	HitHeadMelee1 = 'DeadSleep';
	HitGutRanged1 = 'DeadSleep';
	HitRightRanged1 = 'DeadSleep';
	HitLeftRanged1 = 'DeadSleep';
	HitHeadRanged1 = 'DeadSleep';
	

	Enable('AnimEnd');
	LoopAnim('Sleep');
	

}

defaultproperties
{
     CarcassType=Class'Klingons.KlingonCarcass'
     bWarnTarget=False
     SplatClass=Class'Klingons.GreenBlood'
     NotifyWhenDeadRadius=1000.000000
     PartBlood=Class'Klingons.GreenParticles'
     bCallWhenCarcass=False
     RetreatDamage=5
     MySide=Andorian
     GroundSpeed=321.000000
     JumpZ=-1.000000
     Health=10
     AttitudeToPlayer=ATTITUDE_Ignore
     Intelligence=BRAINS_HUMAN
     InitialState=Dance
     AnimSequence=DanceOne
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnAndorianGirl'
     DrawScale=1.400000
     bNoSmooth=True
     CollisionHeight=48.000000
}
