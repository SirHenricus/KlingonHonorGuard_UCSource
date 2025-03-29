//=============================================================================
// Krax.
//=============================================================================
// By Mark E. Bradshaw

class Krax expands Humanoids;

#call q:\klingons\art\pawns\krax\final\krax.mac
#exec MESH ORIGIN MESH=pawnkrax X=0 Y=-15 Z=-24 YAW=64


#exec MESH NOTIFY MESH=pawnkrax SEQ=ShootAD           TIME=0.35 FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnkrax SEQ=RunShootAD        TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnkrax SEQ=StrafRightShootAD TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnkrax SEQ=StrafLeftShootAD  TIME=0.4  FUNCTION=SpawnShot
#exec MESH NOTIFY MESH=pawnkrax SEQ=KneelShootAD      TIME=0.35 FUNCTION=SpawnKneelShot

#exec MESH NOTIFY MESH=pawnkrax SEQ=WalkAD            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnkrax SEQ=WaitAD            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnkrax SEQ=VictoryDanceBA    TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnkrax SEQ=WalkBA            TIME=0.5  FUNCTION=SpawnBreath
#exec MESH NOTIFY MESH=pawnkrax SEQ=WaitIdleBA        TIME=0.5  FUNCTION=SpawnBreath

#exec MESH NOTIFY MESH=pawnkrax SEQ=OverHeadHitBA     TIME=0.5 FUNCTION=OverHeadDamageTarget
#exec MESH NOTIFY MESH=pawnkrax SEQ=OverHeadHitBA     TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=pawnkrax SEQ=SlashBA           TIME=0.5 FUNCTION=SlashDamageTarget
#exec MESH NOTIFY MESH=pawnkrax SEQ=SlashBA           TIME=0.1 FUNCTION=HumanGrunt
#exec MESH NOTIFY MESH=pawnkrax SEQ=BackSlashBA       TIME=0.5 FUNCTION=BackSlashDamageTarget
#exec MESH NOTIFY MESH=pawnkrax SEQ=BackSlashBA       TIME=0.1 FUNCTION=HumanGrunt

#exec MESH NOTIFY MESH=pawnkrax SEQ=ReloadAD       TIME=0.56 FUNCTION=ReloadSound


//////////////////Variables///////////////////////
// Melee damage.
var (Pawn) int CutSceneDamage;
var CutSceneCamera CSCamera;
var bool CutScenePlayed;
var pawn instigator;
var bool cutsceneplaying;

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
	RollLeftMelee1 = 'StrafLeftBA';
	RollRightMelee1 = 'StrafRightBA';
	WaitIdleMelee1 = 'WaitIdleBA';
	WaitIdleMelee2 = 'FlipBA';
	WaitIdleMelee3 = 'FlipBA';
	WaitIdleMelee4 = 'WaitIdleBA';
	StunnedMelee1 = 'StunBA';
	StunnedSquirmMelee1 = 'StunSquirmBA';
	StunnedGetupMelee1 = 'StunGetupBA';
	StabMelee1 = 'StabBA';
// need overhead hit stuff
	SlashMelee1 = 'SlashBA';
	BackSlashMelee1 = 'BackSlashBA';
	HitGutMelee1 = 'HitGutBA';
	HitRightMelee1 = 'HitRightBA';
	HitLeftMelee1 = 'HitLeftBA';
	HitHeadMelee1 = 'HitHeadBA';
	RunMelee1 = 'RunBA';
	BackPeddleMelee1 = 'RunBA';
	ThreatenMelee1 = 'VictoryDanceBA' ;
	ThreatenMelee2 = 'BackSlashBA';
	ThreatenMelee3 = 'OverHeadHitBA';
	CommandMelee1 = 'BackSlashBA';
	CommandMelee2 = 'VictoryDanceBA';
	WalkMelee1 = 'WalkBA';
	InAirMelee1 = 'JumpBA';
	LandMelee1 = 'LandBA';	
	
	

	// Ranged Animations
	DuckRanged1 = 'DuckAD';
	StrafLeftRanged1 = 'StrafLeftAD';
	StrafLeftShootRanged1 = 'StrafLeftShootAD';
	StrafRightRanged1 = 'StrafRightAD';
	StrafRightShootRanged1 = 'StrafRightShootAD';
	RollLeftRanged1 = 'StrafLeftAD';
	RollRightRanged1 = 'StrafRightAD';
	WaitIdleRanged1 = 'WaitAD';
	WaitIdleRanged2 = 'WaitAD';
	WaitIdleRanged3 = 'WaitAD';
	WaitIdleRanged4 = 'WaitAD';
	StunnedRanged1 = 'StunAD';
	StunnedSquirmRanged1 = 'StunSquirmAD';
	StunnedShootRanged1 = 'StunShootAD';
	StunnedGetupRanged1 = 'StunGetupAD';
	CheckRanged1 = 'ReloadAD';
	ReloadRanged1 = 'ReloadAD';
	KneelShootRanged1 = 'ShootAD';
	ShootRanged1 = 'ShootAD';
	HitGutRanged1 = 'HitGutAD';
	HitRightRanged1 = 'HitRightAD';
	HitLeftRanged1 = 'HitLeftAD';
	HitHeadRanged1 = 'HitHeadAD';
	RunRanged1 = 'RunAD';
	BackPeddleRanged1 = 'RunAD';
	RunShootRanged1 = 'RunShootAD';
	SwimRanged1 = 'RunAD';
	WalkRanged1 = 'WalkAD';
	InAirRanged1 = 'JumpAD';
	LandRanged1 = 'LandAD';	
	
	
	// Deaths & Stuff
	DeadBackToFace1 = 'DeadBackToFace';
	DeadBlownRight1 = 'DeadBlownBack';
	DeadBlownLeft1 = 'DeadBlownBack';
	DeadFallFace1 = 'DeadBackToFace';
	DeadFallBack1 = 'DeadBlownBack';
	DeadFallRight1 = 'DeadBlownBack';
	DeadBackRoll1 = 'DeadBlownBack';
	DeadBlownBack1 = 'DeadBlownBack';
	
	VictoryDance1 = 'VictoryDanceBA';
	VictoryDance2 = 'VictoryDanceBA';


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



function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	local int actualdamage;
	local float dam,ad;

	if (!CutScenePlayed)
	{
		actualDamage = Level.Game.ReduceDamage(Damage, DamageType, self, instigatedBy);
		
		if (ActualDamage > Health - CutSceneDamage)
		{
			dam = damage;
			ad = ActualDamage;
			Damage = (Health - CutSceneDamage) * (dam / Ad) + 10;
		}
	}

	Super.TakeDamage(Damage, instigatedBy, hitLocation, momentum, damageType);
	if (Health < CutSceneDamage)
	{
		if (!CutScenePlayed)
		{
			Instigator = InstigatedBy;
			CutScenePlaying = true;
			PlayCutScene();
		}
	}
}

function PlayCutScene()
{
			if (KlingonPlayer(Instigator) != none)
			{
				SetRotation(rotator(KlingonPlayer(Instigator).location - location));
				KlingonPlayer(Instigator).SwitchViewToImmediate(2);
				CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).CamOwner = self;
				CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).SetPlayerViews(self);
				
				KlingonHud(KlingonPlayer(Instigator).MyHud).AllowMenu(false);
				KlingonPlayer(Instigator).ClientSetMusic(None,0,255,MTRAN_Instant);				
				KlingonPlayer(Instigator).LoopAnim('Wait', 1.0, 0.05);
				
//				KlingonPlayer(Instigator).PlayWaiting();
//				KlingonPlayer(Instigator).GotoState('Waiting');
			}
			CutScenePlayed = true;

			GotoState('CutSceneState');
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


state CutSceneState
{
ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall,takeDamage,Hitwall, WarnTarget,landed,ChooseTeamAttackFor,ChooseLeaderAttack;
	function BeginState()
	{
		nextstate = '';
	}
	function EndState()
	{
	}
	
Begin:

	setPhysics(PHYS_Falling);
	Enable('AnimEnd');
	Velocity = vect(0,0,0);
	Acceleration = vect(0,0,0);
	setPhysics(PHYS_Falling);
	
//	PlayAnim(WaitIdleRanged1,1.0,0.3);
//	FinishAnim();
	Sleep(0.2);
	PlaySound(sound 'KraxCutScene3', SLOT_Talk, /*volume*/,,2000,/*pitch*/);

	PlayAnim('CutScene',1.07,0.1);
	PawnsWait(true);
	
	FinishAnim();
	
	Health = CutSceneDamage-1;
	CutSceneDamage = -2000;

	PawnsWait(false);
	if (KlingonPlayer(Instigator) != none)
	{
		CutSceneCamera(KlingonPlayer(Instigator).PlayerCamActor).ResetPlayerViews();		
		KlingonHud(KlingonPlayer(Instigator).MyHud).AllowMenu(true);		
		KlingonPlayer(Instigator).ClientSetMusic(None,0,7,MTRAN_Fade);
	}
	CutScenePlaying = false;
	GotoState('Attacking');
}

state TakeHit 
{
ignores seeplayer, hearnoise, bump, hitwall;

	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
	{
		Global.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType);
	}

	function Landed(vector HitNormal)
	{
		if (Velocity.Z < -1.4 * JumpZ)
			MakeNoise(-0.5 * Velocity.Z/(FMax(JumpZ, 150.0)));
		bJustLanded = true;
	}

	function Timer()
	{
		bReadyToAttack = true;
		if ( SpeechTime > 0 )
		{
			SpeechTime = -1.0;
			bIsSpeaking = false;
			if ( TeamLeader != None )
				TeamLeader.bTeamSpeaking = false;
		}
	}

	function PlayHitAnim(vector HitLocation, float Damage)
	{

		if ( LastPainTime - Level.TimeSeconds > 0.1 )
		{
			if (Damage > 1) // spawn some blood
			{
//xxx				if (   ( damageType != 'Drowned') 
//xxx						&& 	(damageType != 'Burned') 
//xxx						&& 	(damageType != 'Corroded'))
//xxx					SpawnBlood(damage,Hitlocation);
			}		
//xxx			PlayTakeHitSound(Damage,damageType);
			PlayTakeHit(0.05, hitLocation, Damage);
			BeginState();
			GotoState('TakeHit', 'Begin');
		} 
	}	

	function BeginState()
	{
//		LogDebug("Entering TakeHit State in KP",1);

		LastPainTime = Level.TimeSeconds;
		LastPainAnim = AnimSequence;
	}
	function EndState()
	{
//		LogDebug("Leaving TakeHit State in KP",2);
	}
		
Begin:
	if (CutScenePlaying)
		PlayCutScene();
	else
	{
	
		if (AnimSequence == 'blinded')
		{
		
			GotoState('Blinded');
		}
		if (GetAnimGroup(AnimSequence) == 'Stun')
			GotoState('Stunned');
			
		// Acceleration = Normal(Acceleration);
		FinishAnim();
		if ( skill < 2 )
			Sleep(0.05);
			
		if ( (Physics == PHYS_Falling) && !Region.Zone.bWaterZone )
		{
			Acceleration = vect(0,0,0);
			NextAnim = '';
			
			GotoState('FallingState', 'Ducking');
		}
		else if (NextState != '')
		{
			GotoState(NextState, NextLabel);
		}
		else
		{
			GotoState('Attacking');
		}
	}
}

defaultproperties
{
     CutSceneDamage=600
     OverHeadDamage=20
     SlashDamage=15
     BackSlashDamage=15
     hitsound3=Sound'KlingonSFX01.creature.KraxHit3'
     hitsound4=Sound'KlingonSFX01.creature.KraxHit4'
     stab=Sound'KlingonSFX01.Weapons.BatSwingBig'
     slash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     backslash=Sound'KlingonSFX01.Weapons.BatSwingBig'
     fleshslice=Sound'KlingonSFX01.Weapons.Bathit'
     overhead=Sound'KlingonSFX01.Weapons.BatSwingBig'
     Threaten2=Sound'KlingonSFX01.creature.KraxTaunt3'
     ReloadSound1=Sound'KlingonSFX01.Weapons.AssultLd2'
     Grunt1=Sound'KlingonSFX01.creature.MDktaghBackfist'
     Grunt2=Sound'KlingonSFX01.creature.MDktaghBackslas'
     Grunt3=Sound'KlingonSFX01.creature.MDktaghStab2'
     Grunt4=Sound'KlingonSFX01.creature.MDktaghSlash1'
     CarcassType=Class'Klingons.KlingonCarcass'
     TimeBetweenAttacks=2.000000
     Aggressiveness=0.400000
     RefireRate=0.400000
     bHasRangedAttack=True
     bMovingRangedAttack=True
     bTeamLeader=True
     RangedProjectile=Class'Klingons.AssaultProjectile'
     ProjectileSpeed=1250.000000
     Acquire=Sound'KlingonSFX01.creature.KraxTaunt4'
     Threaten=Sound'KlingonSFX01.creature.KraxTaunt1'
     bCanUseCover=True
     SplatClass=Class'Klingons.BloodSplat'
     ShotsBeforeReload=8
     DodgeAmount=0.400000
     RetreatDamage=5
     MySide=Duras
     bCanStrafe=True
     MeleeRange=50.000000
     GroundSpeed=425.000000
     AirSpeed=0.000000
     AccelRate=512.000000
     HearingThreshold=1.000000
     Health=1200
     Intelligence=BRAINS_HUMAN
     Skill=2.000000
     Die=Sound'KlingonSFX01.creature.KraxDie'
     CombatStyle=0.400000
     Physics=PHYS_Walking
     AnimSequence=WaitAD
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PawnKrax'
     DrawScale=1.600000
     CollisionRadius=32.000000
     CollisionHeight=52.000000
     LightType=LT_Steady
     LightRadius=7
     VolumeRadius=2
     Buoyancy=90.000000
}
