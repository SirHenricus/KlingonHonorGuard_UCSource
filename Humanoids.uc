//=============================================================================
// Humanoids.
//=============================================================================
class Humanoids expands KlingonPawn;

var() byte
	OverHeadDamage,
	StabDamage,
	SlashDamage,		
	BackSlashDamage;		

var(Sounds) sound hitsound3;
var(Sounds) sound hitsound4;
var(Sounds) sound stab;
var(Sounds) sound slash;
var(Sounds) sound backslash;
var(Sounds) sound fleshslice;
var(Sounds) sound Die2;
var(Sounds) sound overhead;

var(Sounds) sound Respond1;
var(Sounds) sound Respond2;
var(Sounds) sound Respond3;

var(Sounds) sound Command1;
var(Sounds) sound Command2;
var(Sounds) sound Command3;
var(Sounds) sound Acquire2;
var(Sounds) sound Acquire3;
var(Sounds) sound Threaten2;
var(Sounds) sound Threaten3;
var(Sounds) sound Roam2;

var(Sounds) sound Talk1;
var(Sounds) sound Talk2;
var(Sounds) sound Talk3;
var(Sounds) sound Talk4;

var(Sounds) sound ReloadSound1;
var(Sound) float VoiceRadius;

var(Sounds) sound DeathRitualSound1;
var(Sounds) sound LeftFoot;
var(Sounds) sound RightFoot;

var(Sounds) sound Grunt1;
var(Sounds) sound Grunt2;
var(Sounds) sound Grunt3;
var(Sounds) sound Grunt4;




// Melee Animations
var(Animations) name DuckMelee1;
var(Animations) name StrafLeftMelee1;
var(Animations) name StrafRightMelee1;
var(Animations) name RollLeftMelee1;
var(Animations) name RollRightMelee1;
var(Animations) name WaitIdleMelee1;
var(Animations) name WaitIdleMelee2;
var(Animations) name WaitIdleMelee3;
var(Animations) name WaitIdleMelee4;
var(Animations) name StunnedMelee1;
var(Animations) name StunnedSquirmMelee1;
var(Animations) name StunnedGetupMelee1;
var(Animations) name StabMelee1;
var(Animations) name SlashMelee1;
var(Animations) name BackSlashMelee1;
var(Animations) name OverheadHitMelee1;
var(Animations) name HitGutMelee1;
var(Animations) name HitRightMelee1;
var(Animations) name HitLeftMelee1;
var(Animations) name HitHeadMelee1;
var(Animations) name RunMelee1;
var(Animations) name BackPeddleMelee1;
var(Animations) name ThreatenMelee1;
var(Animations) name ThreatenMelee2;
var(Animations) name ThreatenMelee3;
var(Animations) name CommandMelee1;
var(Animations) name CommandMelee2;
var(Animations) name WalkMelee1;
var(Animations) name DeathRitualMelee1;



// Ranged Animations
var(Animations) name DuckRanged1;
var(Animations) name StrafLeftRanged1;
var(Animations) name StrafRightRanged1;
var(Animations) name RollLeftRanged1;
var(Animations) name RollRightRanged1;
var(Animations) name WaitIdleRanged1;
var(Animations) name WaitIdleRanged2;
var(Animations) name WaitIdleRanged3;
var(Animations) name WaitIdleRanged4;
var(Animations) name StunnedRanged1;
var(Animations) name StunnedSquirmRanged1;
var(Animations) name StunnedShootRanged1;
var(Animations) name StunnedGetupRanged1;
var(Animations) name CheckRanged1;
var(Animations) name ReloadRanged1;
var(Animations) name KneelShootRanged1;
var(Animations) name ShootRanged1;
var(Animations) name HitGutRanged1;
var(Animations) name HitRightRanged1;
var(Animations) name HitLeftRanged1;
var(Animations) name HitHeadRanged1;
var(Animations) name RunRanged1;
var(Animations) name BackPeddleRanged1;
var(Animations) name RunShootRanged1;
var(Animations) name StrafRightShootRanged1;
var(Animations) name StrafLeftShootRanged1;
var(Animations) name SwimRanged1;
var(Animations) name WalkRanged1;
var(Animations) name InAirMelee1;
var(Animations) name InAirRanged1;
var(Animations) name LandMelee1;
var(Animations) name LandRanged1;
var(Animations) name DeathRitualRanged1;


// Deaths & Stuff
var (Animations) name DeadBackToFace1;
var (Animations) name DeadBlownRight1;
var (Animations) name DeadBlownLeft1;
var (Animations) name DeadFallFace1;
var (Animations) name DeadFallBack1;
var (Animations) name DeadFallRight1;
var (Animations) name DeadBackRoll1;
var (Animations) name DeadBlownBack1;
var (Animations) name VictoryDance1;
var (Animations) name VictoryDance2;

var (Animations) name ComeGetSomeRanged1;
var (Animations) name ComeGetSomeRanged2;
var (Animations) name ComeGetSomeRanged3;

var (Animations) name ComeGetSomeMelee1;
var (Animations) name ComeGetSomeMelee2;
var (Animations) name ComeGetSomeMelee3;


var (Sound) float TimeBetweenThreaten;
var (Sound) float TimeBetweenRoam;
var (Sound) float TimeBetweenAcquire;
var (Sound) float TimeBetweenComResp;


var (Sound) float PercentPlayThreaten;
var (Sound) float PercentPlayRoam;
var (Sound) float PercentPlayAcquire;

var float LastRoamTime;
var float LastThreatenTime;
var float LastAcquireTime;
var	float LastSpoke;

var (Combat) NavigationPoint RetreatPoint;

var KlingonCarcass FallenComrad;
var int DeathRitualTries;


function ZoneChange(ZoneInfo newZone)
{
	local BireQT A;
	bCanSwim = newZone.bWaterZone; //only when it must
		
	if ( newZone.bWaterZone )
	{
		CombatStyle = 1.0; //always charges when in the water
		foreach VisibleActors(class 'BireQT',A,300)
		{
			if (A.Enemy == none)
			{
				A.AnnoyedBy(self);
				if (A.Enemy == none)
					A.Enemy = self;
				A.GotoState('Charging');
			}
		}		
	}
	else if (Physics == PHYS_Swimming)
		CombatStyle = Default.CombatStyle;

	Super.ZoneChange(newZone);
}

function SetMovementPhysics()
{
	if ( Region.Zone.bWaterZone )
		SetPhysics(PHYS_Swimming);
	else if (Physics != PHYS_Walking)
		SetPhysics(PHYS_Walking); 
}


//xxx this is probably good to go.  Need to check it real quick though
function TryToDuck(vector duckDir, bool bReversed)
{
	local vector HitLocation, HitNormal, Extent;
	local bool duckLeft;
	local actor HitActor;
	local float decision;

	//logDebug("Entered TryToDuck "$CurrentlyDucking,4);

	if (CurrentlyDucking)
		return;
		
	duckDir.Z = 0;
	duckLeft = !bReversed;
	Extent.X = CollisionRadius;
	Extent.Y = CollisionRadius;
	Extent.Z = CollisionHeight;
	HitActor = Trace(HitLocation, HitNormal, Location + 160 * duckDir, Location, false, Extent);
	if (HitActor != None)
	{
		duckLeft = !duckLeft;
		duckDir *= -1;
		HitActor = Trace(HitLocation, HitNormal, Location + 160 * duckDir, Location, false, Extent);
	}
	if (HitActor != None)
		return;
	
	HitActor = Trace(HitLocation, HitNormal, Location + 128 * duckDir - MaxStepHeight * vect(0,0,1), Location + 128 * duckDir, false, Extent);
	if (HitActor == None)
		return;

	Enable('AnimEnd');		
	CurrentlyDucking = true;		
//	SetFall();
//	DesiredSpeed = GroundSpeed;
	if (IsMeleeAnim())
	{
		if (FRand() < 0.1)
		{
						//logDebug("calling TweenAnim",4);

			TweenAnim(DuckMelee1, 0.3);
			Velocity.X = 0;
			Velocity.Y = 0;
			Velocity.Z = 0;						
			CurrentlyDucking = false;		

		}
		else
		{
			Velocity = duckDir * GroundSpeed;
			Velocity.Z = 150; 
		
			if (FRand() < 0.5)
			{
				//logDebug("calling PlayAnim1",4);
					if (!duckLeft)
						PlayAnim(StrafLeftMelee1, 1.0, 0.1);
					else
						PlayAnim(StrafRightMelee1, 1.0, 0.1);
					Destination = location + (duckDir)*150;
						
			}
			else
			{
				//logDebug("calling PlayAnim2",4);
			
				if (!duckLeft)
					PlayAnim(RollLeftMelee1, 1.0, 0.1);
				else
					PlayAnim(RollRightMelee1, 1.0, 0.1);
				Destination = location + (duckDir)*100;
			}
			Focus = Enemy.location;
			//logDebug("Going to tacticalMove from TryToDuck",4);
			GotoState('TacticalMove','DuckTo');
		}
	}
	else
	{
		if (FRand() < 0.1)
		{
			TweenAnim(DuckRanged1, 0.3);
			Velocity.X = 0;
			Velocity.Y = 0;
			Velocity.Z = 0;						
			CurrentlyDucking = false;		
			
		}
		else
		{
			Velocity.X = 0;
			Velocity.Y = 0;
			Velocity.Z = 0;						
			Acceleration = vect(0,0,0);
			
			Velocity = duckDir * GroundSpeed;
		
//			Destination = Location + duckDir * GroundSpeed *25;	
	
			
			Velocity.Z = 150;
			
			if (FRand() < 0.5)
			{
				if (Frand() < 0.3)
				{
					if (!duckLeft)
						PlayAnim(StrafLeftShootRanged1, 1.0, 0.1);
					else
						PlayAnim(StrafRightShootRanged1, 1.0, 0.1);
				}
				else
				{
					if (!duckLeft)
						PlayAnim(StrafLeftRanged1,1.0,0.1);
					else
						PlayAnim(StrafRightRanged1,1.0,0.1);
				}
				Destination = location + (duckDir)*150;
				
			}
			else
			{
			
				if (!duckLeft)
					PlayAnim(RollLeftRanged1,0.8,0.1);
				else
					PlayAnim(RollRightRanged1,0.8,0.1);
				Destination = location + (duckDir)*100;
			}
			Focus = Enemy.location;
			GotoState('RangedAttack','DuckTo');
		}
	}
	
		
//	SetPhysics(PHYS_Falling);
//	GotoState('FallingState','Ducking');
}

/////////////////Speaking Functions/////////////////
/*
function SpeechTimer()
{
	//last syllable expired.  Decide whether to keep the floor or quit
	if ( (Enemy == None || bTeamLeader) && (FRand() < 0.6) )
	{
		bIsSpeaking = false;
		if (TeamLeader != None)
			TeamLeader.bTeamSpeaking = false;
	}
	else
		Speak();
}

function SpeakOrderTo(KlingonPawn TeamMember)
{
	local float decision;

	if ( (TeamMember == self) || (!TeamMember.bCanSpeak) || (FRand() < 0.5) )
	{
		bIsSpeaking = true;
		if (TeamLeader != None)	
			TeamLeader.bTeamSpeaking = true;
	
		decision = FRand();	
		if (bTeamLeader)
		{
			PlaySound(Command1, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
		}
		else	
		{
			PlaySound(Respond1, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
		}
		SpeechTime = 0.5 + 0.5*FRand();
	}
	else
		TeamMember.SpeakOrderTo(self);
}

function SpeakTo(KlingonPawn Other)
{
	if (Other.bIsSpeaking || ((TeamLeader != None) && TeamLeader.bTeamSpeaking) )
		return;
	
	Speak();
}



function Speak()
{
	local float decision;

	bIsSpeaking = true;
	if (TeamLeader != None)	
		TeamLeader.bTeamSpeaking = true;

	if (bTeamLeader)
		PlaySound(Command1, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
	else	
		PlaySound(Respond1, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);

//	decision = FRand();
//	if (decision < 0.25)
//		PlaySound(Talk1,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
//	else if (decision < 0.5)
//		PlaySound(Talk2,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
//	else if (decision < 0.75)
//		PlaySound(Talk3,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
//	else
//		PlaySound(Talk4,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);

	SpeechTime = 0.5 + FRand();
}
*/

function PawnsWait(bool PawnsWaitPlease)
{
	local Humanoids A;
	
	if (PawnsWaitPlease)
	{
		foreach VisibleActors(class 'Humanoids',A,1000)
		{
			if (A != self)
			{
				A.AttitudeToPlayer = ATTITUDE_Ignore;
				A.GotoState('Waiting');
			}
		}
	}
	else
	{
		foreach VisibleActors(class 'Humanoids',A,1000)
		{
			if (A != self)
			{
				A.AttitudeToPlayer = ATTITUDE_Hate;
				A.GotoState('Attacking');
				
			}
		}
	}

}

function HumanGrunt()
{
	KlingonGrunt();
}

function KlingonGrunt()
{
	if (FRand() < 0.25)
		PlaySound(Grunt1,SLOT_Talk,,,VoiceRadius);	
	else if (FRand() < 0.5)		
		PlaySound(Grunt2,SLOT_Talk,,,VoiceRadius);	
	else if (FRand() < 0.75)		
		PlaySound(Grunt3,SLOT_Talk,,,VoiceRadius);	
	else 
		PlaySound(Grunt4,SLOT_Talk,,,VoiceRadius);	
}

function FootStepSound()
{
	if (FRand() < 0.5)
		PlaySound(LeftFoot,SLOT_Interact,0.4,,VoiceRadius+100);	
	else
		PlaySound(RightFoot,SLOT_Interact,0.4,,VoiceRadius+100);	
}

function FootStepRunSound()
{
	if (FRand() < 0.5)
		PlaySound(LeftFoot,SLOT_Interact,0.8,,VoiceRadius+200);	
	else
		PlaySound(RightFoot,SLOT_Interact,0.8,,VoiceRadius+200);	
}


function SpeechTimer()
{
	//last syllable expired.  Decide whether to keep the floor or quit
	if ( (Enemy == None || bTeamLeader) && (FRand() < 0.6) )
	{
		bIsSpeaking = false;
		if (TeamLeader != None)
			TeamLeader.bTeamSpeaking = false;
	}
	else
		Speak();
}

function SpeakOrderTo(KlingonPawn TeamMember)
{
	local float decision;

	if (Level.TimeSeconds - LastSpoke > TimeBetweenComResp)
	{

		if ( (TeamMember == self) || (!TeamMember.bCanSpeak) || (FRand() < 0.5) )
		{
			bIsSpeaking = true;
			if (TeamLeader != None)	
				TeamLeader.bTeamSpeaking = true;
	
				
			LastSpoke = Level.TimeSeconds;
			decision = FRand();	
			if (bTeamLeader)
			{
				PlaySound(Command1, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
			}
			else	
			{
				PlaySound(Respond1, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
			}
			SpeechTime = 0.5 + 0.5*FRand();
		}
		else
			TeamMember.SpeakOrderTo(self);
	}
}


// Called when one pawn bumps into another pawn. (MEB)
function SpeakTo(KlingonPawn Other)
{
	if (Other.bIsSpeaking || ((TeamLeader != None) && TeamLeader.bTeamSpeaking) )
		return;
	
	Speak();
}


// Called from SpeakOrders state from ChooseLeaderAttack
function Speak()
{
	local float decision;

	if (Level.TimeSeconds - LastSpoke > TimeBetweenComResp)
	{
	
		bIsSpeaking = true;
		if (TeamLeader != None)	
			TeamLeader.bTeamSpeaking = true;
	
		LastSpoke = Level.TimeSeconds;
		if (bTeamLeader)
			PlaySound(Command1, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
		else	
			PlaySound(Respond1, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
	
	//	decision = FRand();
	//	if (decision < 0.25)
	//		PlaySound(Talk1,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
	//	else if (decision < 0.5)
	//		PlaySound(Talk2,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
	//	else if (decision < 0.75)
	//		PlaySound(Talk3,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
	//	else
	//		PlaySound(Talk4,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
	
		SpeechTime = 0.5 + FRand();
	}
}



function PlayAcquisitionSound()
{
	local float decision;
	if (Acquire == None) return;
	if (!bCanSpeak) return;	
	if (FRand() > PercentPlayAcquire) return;
	if ((TeamLeader!= None) && (TeamLeader.bIsSpeaking)) return;		// don't talk when the boss is talkin

//	if ( bCanSpeak && (TeamLeader != None) && !TeamLeader.bTeamSpeaking )

	
	if (Level.TimeSeconds - LastAcquireTime > TimeBetweenAcquire)
	{
		decision = FRand();
		if (decision < 0.3)
			PlaySound(Acquire,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
		else if (decision < 0.6)
		{
			if (Acquire2 == none)
				PlaySound(Acquire,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
			else
				PlaySound(Acquire2,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
		}
		else
		{
			if (Acquire3 == none)
				PlaySound(Acquire,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
			else
				PlaySound(Acquire3,SLOT_Talk,/*inflection*/,,VoiceRadius, /*pitch*/);
		}
		LastAcquireTime = Level.TimeSeconds;
	}
}

function PlayThreateningSound()
{
	local float decision;

	if (Threaten == None) return;
	if (!bCanSpeak) return;
	if (FRand() > PercentPlayThreaten) return;
	
	decision = FRand();
	if (Level.TimeSeconds - LastThreatenTime > TimeBetweenThreaten)
	{
		if (decision < 0.3)
			PlaySound(Threaten, SLOT_Talk,, true,VoiceRadius);
		else if (decision < 0.6)
		{
			if (Threaten2 == none)
				PlaySound(Threaten, SLOT_Talk,, true,VoiceRadius);
			else
				PlaySound(Threaten2, SLOT_Talk,, true,VoiceRadius);
		}
		else
		{
			if (Threaten3 == none)
				PlaySound(Threaten, SLOT_Talk,, true,VoiceRadius);
			else
				PlaySound(Threaten3, SLOT_Talk,, true,VoiceRadius);
		}	
		LastThreatenTime = Level.TimeSeconds;
	}
}


function PlayRoamingSound()
{
	local float decision;

	if (Roam == None) return;
	if (!bCanSpeak) return;
	if (FRand() > PercentPlayRoam) return;

	if (Level.TimeSeconds - LastRoamTime  > TimeBetweenRoam)
	{
		decision = FRand();
		if (decision < 0.5)
			PlaySound(Roam,SLOT_Talk,/*inflection*/,true,VoiceRadius, /*pitch*/);
		else
		{
			if (Roam2 == none)
				PlaySound(Roam,SLOT_Talk,/*inflection*/,true,VoiceRadius, /*pitch*/);
			else
				PlaySound(Roam2,SLOT_Talk,/*inflection*/,true,VoiceRadius, /*pitch*/);		
		}
		
		LastRoamTime = Level.TimeSeconds;
	}
}

function PlayComeGetSome()
{
	local float Decision;
	
	Decision = Frand();
	if (IsMeleeAnim())
	{
		if (Decision < 0.33)
			PlayAnim(ComeGetSomeMelee1,1.0,0.1);
		else if (Decision < 0.66)
			PlayAnim(ComeGetSomeMelee2,1.0,0.1);
		else
			PlayAnim(ComeGetSomeMelee3,1.0,0.1);
	}
	else
	{
		if (Decision < 0.33)
			PlayAnim(ComeGetSomeRanged1,1.0,0.1);
		else if (Decision < 0.66)
			PlayAnim(ComeGetSomeRanged2,1.0,0.1);
		else
			PlayAnim(ComeGetSomeRanged3,1.0,0.1);
	}
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


function PlayPatrolStop()
{
	PlayWaiting();
}

function PlayWaitingAmbush()
{
	PlayWaiting();
}


function PlayChallenge()
{
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	
	if (IsMeleeAnim())
	{
		if ( TryToCrouch() )
		{
			TweenAnim(KneelShootRanged1, 0.2);
			return;
		}	
		PlayThreateningSound();
		PlayAnim(WaitIdleMelee1, 0.5+0.5*FRand(),0.3);
	}
	else
		PlayAnim(WaitIdleRanged1, 0.5+0.5*FRand(),0.3);
	
}


function TweenToFighter(float tweentime)
{
	if (Region.Zone.bWaterZone)
	{
		TweenToSwimming(tweentime);
		return;
	}

	if (IsMeleeAnim())
		TweenAnim(WaitIdleMelee1, tweentime);
	else
		TweenAnim(WaitIdleRanged1, tweentime);
}

function PlayKneel()
{
//logDebug("Calling PlayKneel",5);
	if (IsMeleeAnim())
		TweenAnim(DuckMelee1, 0.3);
	else
		TweenAnim(KneelShootRanged1, 0.3);
}


function TweenToRunning(float tweentime)
{
	if (Region.Zone.bWaterZone)
	{
		TweenToSwimming(tweentime);
		return;
	}
	if (IsMeleeAnim())
	{
		if (AnimSequence != RunMelee1 || !bAnimLoop)
			TweenAnim(RunMelee1, tweentime);
	}
	else
	{
		if (AnimSequence != RunRanged1 || !bAnimLoop)
			TweenAnim(RunRanged1, tweentime);
	}
}

function TweenToWalking(float tweentime)
{
	if (Region.Zone.bWaterZone)
	{
		TweenToSwimming(tweentime);
		return;
	}
	if (IsMeleeAnim())
		TweenAnim(WalkMelee1, tweentime);
	else
		TweenAnim(WalkRanged1, tweentime);
}

function TweenToWaiting(float tweentime)
{
	if (Region.Zone.bWaterZone)
	{
		TweenToSwimming(tweentime);
		return;
	}
	if (GetAnimGroup(AnimSequence) == 'Ducking')
	{
		TweenAnim(AnimSequence, tweentime);
		return;
	}
	if (IsMeleeAnim())
		TweenAnim(WaitIdleMelee1, tweentime);
	else
		TweenAnim(WaitIdleRanged1, tweentime);
}

function TweenToPatrolStop(float tweentime)
{
	TweenToWaiting(tweentime);
}


function PlayRunning()
{
	local float strafeMag;
	local vector Focus2D, Loc2D, Dest2D;
	local vector lookDir, moveDir, Y;

	DesiredSpeed = MaxDesiredSpeed;
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}

	if (Focus == Destination)
	{
		if (IsMeleeAnim())
		{	
			LoopAnim(RunMelee1, -1.6/GroundSpeed,0.1, 0.4);
			return;
		}
		else
		{
			LoopAnim(RunRanged1, -1.6/GroundSpeed,0.1, 0.4);
			return;
		}
	}	
	Focus2D = Focus;
	Focus2D.Z = 0;
	Loc2D = Location;
	Loc2D.Z = 0;
	Dest2D = Destination;
	Dest2D.Z = 0;
	lookDir = Normal(Focus2D - Loc2D);
	moveDir = Normal(Dest2D - Loc2D);
	strafeMag = lookDir dot moveDir;
	if (IsMeleeAnim())
	{
		if (strafeMag > 0.8)
			LoopAnim(RunMelee1, -1.6/GroundSpeed,0.1, 0.4);
		else if (strafeMag < -0.8)
			LoopAnim(BackPeddleMelee1, -2.6/GroundSpeed,0.1, 0.4);
		else
		{
			Y = (lookDir Cross vect(0,0,1));
			if ((Y Dot (Dest2D - Loc2D)) < 0) 
				LoopAnim(StrafRightMelee1, -1.6/GroundSpeed,0.1, 1.0); 
			else
				LoopAnim(StrafLeftMelee1, -1.6/GroundSpeed,0.1, 1.0);
		}
	}
	else
	{
		if (strafeMag > 0.8)
			LoopAnim(RunRanged1, -1.6/GroundSpeed,0.1, 0.4);
		else if (strafeMag < -0.8)
			LoopAnim(BackPeddleRanged1, -2.6/GroundSpeed,0.1, 0.4);
		else
		{
			Y = (lookDir Cross vect(0,0,1));
			if ((Y Dot (Dest2D - Loc2D)) < 0) 
				LoopAnim(StrafRightRanged1, -1.6/GroundSpeed,0.1, 1.0); 
			else
				LoopAnim(StrafLeftRanged1, -1.6/GroundSpeed,0.1, 1.0);
		}
	}
}

//XXX here we need to assert that you have the gun drawn already
//xxx othewise swithc from sword to gun will look odd
function PlayMovingAttack()
{
	local float strafeMag;
	local vector Focus2D, Loc2D, Dest2D;
	local vector lookDir, moveDir, Y;

	if (!CanFireAtEnemy())
	{
		PlayRunning();
		return;
	}
		
		
	if (IsMeleeAnim())
	{
//		log("warning: in melee mode and got to PlayMovingAttack in "$self);
		return;
	}
	
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	DesiredSpeed = MaxDesiredSpeed;

	if (Focus == Destination)
	{
		LoopAnim(RunShootRanged1, -1.6/GroundSpeed,0.1, 0.4);
		return;
	}	
	Focus2D = Focus;
	Focus2D.Z = 0;
	Loc2D = Location;
	Loc2D.Z = 0;
	Dest2D = Destination;
	Dest2D.Z = 0;
	lookDir = Normal(Focus2D - Loc2D);
	moveDir = Normal(Dest2D - Loc2D);
	strafeMag = lookDir dot moveDir;
	if (strafeMag > 0.8)
		LoopAnim(RunShootRanged1, -1.6/GroundSpeed,0.1, 0.4);
	else if (strafeMag < -0.8)
		LoopAnim(RunShootRanged1, -1.6/GroundSpeed,0.1, 0.4);
	else
	{
		MoveTimer += 0.2;
		DesiredSpeed = 0.6;
		Y = (lookDir Cross vect(0,0,1));
		if ((Y Dot (Dest2D - Loc2D)) < 0) 
			LoopAnim(StrafRightShootRanged1, -1.6/GroundSpeed,0.1, 1.0); 
		else
			LoopAnim(StrafLeftShootRanged1, -1.6/GroundSpeed,0.1, 1.0);
	}
}

function PlayWalking()
{
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	if ( IsMeleeAnim() )
		LoopAnim(WalkMelee1, -3.3/GroundSpeed,0.1, 0.4);
	else
		LoopAnim(WalkRanged1, -3.3/GroundSpeed,0.1, 0.4);
}

function TweenToSwimming(float tweentime)
{
	if (AnimSequence != SwimRanged1 || !bAnimLoop)
		TweenAnim(SwimRanged1, tweentime);
}

function PlaySwimming()
{
	LoopAnim(SwimRanged1, -1.0/GroundSpeed,,0.3);
}

function TweenToFalling()
{
	if ( IsMeleeAnim() )
		TweenAnim(InAirMelee1, 0.5);		// was .25
	else
		TweenAnim(InAirRanged1,0.5);
}

function PlayInAir()
{
	if ( IsMeleeAnim() )
//		TweenAnim(DuckMelee1, 0.5);
		TweenAnim(InAirMelee1, 0.3);
	else
//		TweenAnim(DuckRanged1,0.5);
		TweenAnim(InAirRanged1,0.3);

}

function PlayOutOfWater()
{
	if ( IsMeleeAnim() )
		TweenAnim(DuckMelee1, 0.5);
	else
		TweenAnim(DuckRanged1,0.5);
}

function PlayLanded(float impactVel)
{
	local float tweentime;
//logDebug("Calling PlayLanded",5);
	FootStepSound();
	PlaySound(sound'BodyFall2', SLOT_Talk,,,VoiceRadius+100,);
		
	if (impactVel > 1.7 * JumpZ)
		tweentime = 0.2;
	else
		tweentime = 0.05;
		
	if (IsMeleeAnim())
		Tweenanim(LandMelee1,tweentime);
	else
		TweenAnim(LandRanged1, tweentime);
}

function PlayThreatening()
{
	local float decision;

	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	decision = FRand();

	PlayThreateningSound();
	
	if (decision < 0.33)
	{
		PlayAnim(ThreatenMelee3,,0.2);
	}
	else if (decision < 0.66)
	{
		PlayAnim(ThreatenMelee2,,0.2);
	}
	else
		PlayAnim(ThreatenMelee1,,0.2);
}

function PlayTurning()
{
	if (Region.Zone.bWaterZone)
	{
		PlaySwimming();
		return;
	}
	if (GetAnimGroup(AnimSequence) == 'Ducking')
		return;
	if (IsMeleeAnim())
		TweenAnim(BackPeddleMelee1, 0.3);
	else
		TweenAnim(BackPeddleRanged1, 0.3);
}

function TweenToCommand(float Tweentime)
{
	TweenAnim(CommandMelee1, tweentime);
}

function PlayCommand()
{
	if (Frand() < 0.75)
		PlayAnim(CommandMelee1);
	else
		PlayAnim(CommandMelee2);
}


function PlayVictoryDance()
{	
	local float decision;
	
	decision = FRand();
	if (decision < 0.5)
		PlayAnim(VictoryDance1, 0.7+0.6*FRand(), 0.2);
	else
		PlayAnim(VictoryDance2,,0.2);
}



function PlayBigDeath(name DamageType)
{
	PlayDeathAnims();
	if (SpecialDeath == 4)
		PlaySound(sound'DissolveMix2', SLOT_Talk,,,VoiceRadius,);
	else
		PlaySound(Die2, SLOT_Talk,,,VoiceRadius,);
	
}

function PlayHeadDeath(name DamageType)
{
	//XXXUnreal Stuff for decapitation effects, see unreal stuff
	PlayDeathAnims();
	if (SpecialDeath == 4)
		PlaySound(sound'DissolveMix2', SLOT_Talk,,,VoiceRadius,);
	else
		PlaySound(Die, SLOT_Talk,,,VoiceRadius,);
}

function PlayLeftDeath(name DamageType)
{
	PlayDeathAnims();
	if (SpecialDeath == 4)
		PlaySound(sound'DissolveMix2', SLOT_Talk,,,VoiceRadius,);
	else
		PlaySound(Die, SLOT_Talk,,,VoiceRadius,);
}

function PlayRightDeath(name DamageType)
{
	PlayDeathAnims();
	if (SpecialDeath == 4)
		PlaySound(sound'DissolveMix2', SLOT_Talk,,,VoiceRadius,);
	else
		PlaySound(Die, SLOT_Talk,,,VoiceRadius,);
}

function PlayGutDeath(name DamageType)
{
	PlayDeathAnims();
	if (SpecialDeath == 4)
		PlaySound(sound'DissolveMix2', SLOT_Talk,,,VoiceRadius,);
	else
		PlaySound(Die, SLOT_Talk,,,VoiceRadius,);
}


function PlayGutHit(float tweentime)
{
	local float PercentHurt,A1,A2;	

/*	if ( IsMeleeAnim() )
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == HitGutMelee1) )
		{
			if (FRand() < 0.5)
				PlayAnim(HitLeftMelee1,0.2, tweentime);

			else
				PlayAnim(HitRightMelee1,0.2, tweentime);

		}
		else
			PlayAnim(HitGutMelee1,0.2, tweentime);
	}
	else
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == HitGutRanged1) )
		{
			if (FRand() < 0.5)
				PlayAnim(HitLeftRanged1,0.2, tweentime);
			else
				PlayAnim(HitRightRanged1,0.2, tweentime);
		}
		else
			PlayAnim(HitGutRanged1,0.2, tweentime);

	}
*/
	A1 = Default.Health - Health;
	A2 = Default.Health;
	PercentHurt = 1.0 - (A1 / A2);		// 1 is completely hurt
	if ( IsMeleeAnim() )
	{
		if (LastPainTime - Level.TimeSeconds < 0.2)
			PlayAnim(HitGutMelee1,0.2 + (PercentHurt * 0.3), tweentime);
	}
	else
	{
		if (LastPainTime - Level.TimeSeconds < 0.2)
			PlayAnim(HitGutRanged1,0.2 + (PercentHurt * 0.3), tweentime);
	}


}

function PlayHeadHit(float tweentime)
{
	local float PercentHurt,A1,A2;	
/*	if ( IsMeleeAnim() )
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == HitHeadMelee1) )
			PlayAnim(HitGutMelee1, 0.2, tweentime);
		else
			PlayAnim(HitHeadMelee1, 0.2, tweentime);
	}
	else
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == HitHeadRanged1) )
			PlayAnim(HitGutRanged1,0.2, tweentime);
		else
			PlayAnim(HitHeadRanged1,0.2, tweentime);
	}		
*/
	A1 = Default.Health - Health;
	A2 = Default.Health;
	PercentHurt = 1.0 - (A1 / A2);		// 1 is completely hurt
	if ( IsMeleeAnim() )
	{
		if (LastPainTime - Level.TimeSeconds < 0.2)
			PlayAnim(HitHeadMelee1, 0.25 + (PercentHurt * 0.4), tweentime);
	}
	else
	{
		if (LastPainTime - Level.TimeSeconds < 0.2)
			PlayAnim(HitHeadRanged1,0.25 + (PercentHurt * 0.4), tweentime);
	}		


}

function PlayLeftHit(float tweentime)
{
	local float PercentHurt,A1,A2;	
/*	if ( IsMeleeAnim() )
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == HitLeftMelee1) )
			PlayAnim(HitGutMelee1,0.2, tweentime);
		else
			PlayAnim(HitLeftMelee1,0.2, tweentime);
	}
	else
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == HitLeftRanged1) )
			PlayAnim(HitGutRanged1,0.2, tweentime);
		else
			PlayAnim(HitLeftRanged1,0.2, tweentime);

	}
*/	
	A1 = Default.Health - Health;
	A2 = Default.Health;
	PercentHurt = 1.0 - (A1 / A2);		// 1 is completely hurt
	if ( IsMeleeAnim() )
	{
		if (LastPainTime - Level.TimeSeconds < 0.2)
			PlayAnim(HitLeftMelee1,0.25 + (PercentHurt * 0.4), tweentime);
	}
	else
	{
		if (LastPainTime - Level.TimeSeconds < 0.2)
			PlayAnim(HitLeftRanged1,0.25 + (PercentHurt * 0.4), tweentime);

	}
	

}

function PlayRightHit(float tweentime)
{
	local float PercentHurt,A1,A2;	

/*	if ( IsMeleeAnim() )
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == HitRightMelee1) )
			PlayAnim(HitGutMelee1, 0.2, tweentime);
		else
			PlayAnim(HitRightMelee1,0.2,  tweentime);
	}
	else
	{
		if ( (LastPainTime - Level.TimeSeconds < 0.2) && (LastPainAnim == HitRightRanged1) )
			PlayAnim(HitGutRanged1,0.2, tweentime);
		else
			PlayAnim(HitRightRanged1,0.2, tweentime);
	}
*/	
	A1 = Default.Health - Health;
	A2 = Default.Health;
	PercentHurt = 1.0 - (A1 / A2);		// 1 is completely hurt
	if ( IsMeleeAnim() )
	{
		if (LastPainTime - Level.TimeSeconds < 0.2) 
			PlayAnim(HitRightMelee1,0.25 + (PercentHurt * 0.4),  tweentime);
	}
	else
	{
		if (LastPainTime - Level.TimeSeconds < 0.2)
			PlayAnim(HitRightRanged1,0.25 + (PercentHurt * 0.4), tweentime);
	}


}


function PlayMeleeAttack()
{
	local float decision;

	decision = FRand();
 	if (decision < 0.33)
 	{
   		PlayAnim(StabMelee1,,0.1);
   		PlaySound(slash,SLOT_Interact,,,VoiceRadius,);
   	}
 	else if (decision < 0.66)
 	{
   		PlayAnim(SlashMelee1,,0.1);
   		PlaySound(slash,SLOT_Interact,,,VoiceRadius,);
 	}
 	else
 	{
 		PlayAnim(BackSlashMelee1,,0.1);
 		PlaySound(backslash,SLOT_Interact,,,VoiceRadius,);
 	}
}

function PlayStun()
{
	if (IsMeleeAnim())
		PlayAnim(StunnedMelee1, 0.7, 0.25);
	else
		PlayAnim(StunnedRanged1, 0.7, 0.25);
}

function PlayStunned()
{
	if (IsMeleeAnim())
		PlayAnim(StunnedSquirmMelee1, 0.4+0.8*FRand());
	else
	{
		if (FRand() < 0.5)
			PlayAnim(StunnedSquirmRanged1, 0.4+0.8*FRand());
		else
			PlayAnim(StunnedShootRanged1);
	}
}



function PlayStunGetUp()
{
	if (IsMeleeAnim())
		PlayAnim(StunnedGetupMelee1, 0.7, 0.25);
	else
		PlayAnim(StunnedGetupRanged1, 0.7, 0.25);
}

function SpawnShot()
{
//	FireProjectile( vect(1.3, -0.5, 0.4), Accuracy);
	FireProjectile( vect(1.7, -0.5, 1.1), Accuracy);
}

function SpawnKneelShot()
{
//	FireProjectile( vect(1.3, -0.5, 0.4), Accuracy);
	FireProjectile( vect(1.7, -0.5, 0.3), Accuracy);
}

function SpawnStunShot()
{
	FireProjectile( vect(1.3, -0.5, -0.2), Accuracy * 2);
}

function StabDamageTarget()
{
	if (Target == none) return;

	if ( MeleeDamageTarget(StabDamage, (StabDamage * 500 * Normal(Target.Location - Location))) ) 
		PlaySound(FleshSlice, SLOT_Interact,,,VoiceRadius,);
}		

function SlashDamageTarget()
{
	if (Target == none) return;

	if ( MeleeDamageTarget(SlashDamage, (SlashDamage * 500 * Normal(Target.Location - Location))) ) 
		PlaySound(FleshSlice, SLOT_Interact,,,VoiceRadius,);
}

function BackSlashDamageTarget()
{
	if (Target == none) return;
	if ( MeleeDamageTarget(BackSlashDamage, (BackSlashDamage * 500 * Normal(Target.Location - Location))) ) 
		PlaySound(FleshSlice, SLOT_Interact,,,VoiceRadius,);
}





function PlayRangedAttack()
{
	if (GetAnimGroup(AnimSequence) == 'Ducking')
		{
			if (CoverObject != none)
			{
				if (CoverPoint(CoverObject).CoverHeight != COVER_WAISTHEIGHT)
					PlayAnim(KneelShootRanged1, 1.0, 0.15);
				else
					PlayAnim(ShootRanged1,1.0,0.15);
			}
			else
				PlayAnim(KneelShootRanged1, 1.0, 0.15);
		}
	else
		PlayAnim(ShootRanged1,1.0,0.15);
}

function PlayReloadAnim()
{
	if (!IsMeleeAnim())
	{
		if (FRand() < 0.2)
			PlayAnim(CheckRanged1,1.0,0.15);
		else
			PlayAnim(ReloadRanged1,1.0,0.15);
	}
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
//Level.Game.SetGameSpeed(0.1);
	switch(LastHitDirection)
	{
		case 11:
		case 12:
		case 1:
			if (LastHitPower > 150)
			{
				if (RandAni < 0.333)
					PlayAnim(DeadBackToFace1,0.8,0.1);
				else if (RandAni < 0.666)
					PlayAnim(DeadBackRoll1,0.7,0.1);
				else
					PlayAnim(DeadBlownBack1,0.6,0.1);
			}
			else
			{
				if (RandAni < 0.25)
					PlayAnim(DeadFallBack1,0.6,0.1);
				else if (RandAni < 0.5)
					PlayAnim(DeadFallRight1,0.7,0.1);
				else if (RandAni < 0.75)
					PlayAnim(DeadFallFace1,0.7,0.1);
				else
					PlayAnim(DeadBlownBack1,0.6,0.1);
			}
			break;
		case 9:
		case 10:		
			if (LastHitPower > 150)
				PlayAnim(DeadBlownRight1,0.7,0.1);
			else
				PlayAnim(DeadFallRight1,0.60,0.1);
			break;
		case 3:
		case 2:
			if (LastHitPower > 150)
				PlayAnim(DeadBlownLeft1,0.6,0.1);
			else
				PlayAnim(DeadFallRight1,0.6,0.1);
			break;	
		case 8:
		case 7:
		case 6:
		case 5:
		case 4:		
			if (LastHitPower > 150)
				PlayAnim(DeadFallFace1,0.7,0.1);
			else
				PlayAnim(DeadFallFace1,0.5,0.1);

			break;
	}
}


function SetFall()
{
	if (Enemy != None)
	{
		NextState = 'Attacking'; //default
		NextLabel = 'Begin';
		if (IsMeleeAnim())
			NextAnim = WaitIdleMelee1;
		else
			NextAnim = WaitIdleRanged1;

		GotoState('FallingState');
	}
}

function ReloadSound()
{
//	PlaySound(ReloadSound, SLOT_Talk, /*volume*/,,VoiceRadius,/*pitch*/);
	PlaySound(ReloadSound1, SLOT_Interact, , ,VoiceRadius);

}

//function Landed(vector HitNormal)
//{
//	FootStepSound();
//	super.landed(HitNormal);
//}

function bool CanFireAtEnemy()
{
	local vector HitLocation, HitNormal,X,Y,Z, projStart;
	local actor HitActor;
	
	//logDebug("in CanFireAtEnemy 1",4);
	if (!LineOfSightTo(Enemy))
	{
		return false;
	}
	
	//logDebug("in CanFireAtEnemy 2",4);
	
	GetAxes(Rotation,X,Y,Z);
	projStart = Location + 1.3 * CollisionRadius * X - 0.5 * CollisionRadius * Y + 0.4 * CollisionHeight * Z;
	HitActor = Trace(HitLocation, HitNormal, 
			projStart + 1000 * Normal(Enemy.Location - Location), 
			projStart, true);
	//logDebug("in CanFireAtEnemy 3  "$HitActor,4);
			
	if (Humanoids(HitActor) != none)
	{
		if (MySide != '')
		{
			if (Humanoids(HitActor).MySide == MySide)
			{
				//logDebug("HitActor.MySide="$Humanoids(HitActor).MySide$"  My Myside="$MySide,4);
				
				return false;
			}
		}
	}
	//logDebug("in CanFireAtEnemy 4  "$HitActor,4);

	if ( (HitActor == None) || (HitActor == Enemy) 
		|| ((Pawn(HitActor) != None) && (AttitudeTo(Pawn(HitActor)) <= ATTITUDE_Ignore)) )
	{
		return true;
	}
	//logDebug("in CanFireAtEnemy 5  "$HitActor,4);

	HitActor = Trace(HitLocation, HitNormal, 
			projStart + 1000 * Normal(Enemy.Location - Location + Enemy.CollisionHeight * vect(0,0,0.9)), 
			projStart , true);
	//logDebug("in CanFireAtEnemy 6  "$HitActor,4);
			
	if (Humanoids(HitActor) != none)
	{
		if (MySide != '')
		{
			if (Humanoids(HitActor).MySide == MySide)
			{
	
				return false;
			}
		}
	}
	//logDebug("in CanFireAtEnemy 7  "$HitActor,4);
	
	return ( (HitActor == None) || (HitActor == Enemy) 
			|| ((Pawn(HitActor) != None) && (AttitudeTo(Pawn(HitActor)) <= ATTITUDE_Ignore)) );
}

state DeathRitual
{
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
							Vector momentum, name damageType)
	{
		Super.TakeDamage(Damage, instigatedBy, hitLocation, momentum,damageType);
		FallenComrad.bMournerCalled = false;
		FallenComrad.BeginFade = 0;
		FallenComrad = none;
		GotoState('Attacking');
	}
	
	function EndState()
	{
		//logDebug("Leaving state DeathRitual",2);
	}
	function BeginState()
	{
		//logDebug("Entering state DeathRitual",2);
	}
	

Begin:
	//logDebug("Begin in DeathRitual",5);
	Enable('AnimEnd');
	DeathRitualTries++;
MovingToComrad:
	//logDebug("MovingToComrad in DeathRitual",5);

	if (Enemy == none)
	{
		If ( actorReachable(FallenComrad) )
		{
			//logDebug("actorReachable "$FallenComrad,5);
		
			Destination = FallenComrad.location + Normal(location - FallenComrad.location)* 80;
			Focus = FallenComrad.location;
			PlayRunning();
			MoveTo(Destination);
			DeathRitualTries=0;			
			// Should have arrived now
			Goto('MornComrad');
		}
		else
		{
			//logDebug("actor not Reachable "$FallenComrad,5);
		
			MoveTarget = FindPathToward(FallenComrad);
			if (MoveTarget == none)
			{
				// Ok we got a problem, lets shine this eulegy
				FallenComrad.bMournerCalled = false;
				FallenComrad.BeginFade = 0;
				FallenComrad = none;
				if (DeathRitualTries > 5)
					bIgnoreDeadBodies = true;		// forget this comrad crap
				Goto('GoOnWithYourLife');
			}
			Destination = MoveTarget.location;

			//logDebug("actor not Reachable "$FallenComrad$" MT="$MoveTarget,5);
			
			Focus = MoveTarget.location;
			PlayRunning();
			MoveTo(Destination);
		}
	}
	else
	{
		Goto('EnemyDetected');
	}
	
	Goto('MovingToComrad');

MornComrad:
	//logDebug("MornComrad in DeathRitual",5);

	if (IsMeleeAnim())
		PlayAnim(DuckMelee1,1.0,0.5);
	else
		PlayAnim(DuckRanged1,1.0,0.5);
	
	FinishAnim();
	Sleep(1.5);	
	PlaySound(DeathRitualSound1,SLOT_Talk,,,VoiceRadius);
	if (IsMeleeAnim())
		PlayAnim(DeathRitualMelee1,1.0,0.3);
	else
		PlayAnim(DeathRitualRanged1,1.0,0.3);
	
	FinishAnim();
//	PlaySound(DeathRitualSound1,SLOT_Talk,,,VoiceRadius);
	if (IsMeleeAnim())
		PlayAnim(WaitIdleMelee1,1.0,0.3);
	else
		PlayAnim(WaitIdleRanged1,1.0,0.3);
	
	FinishAnim();

	FallenComrad.BeginFade = Level.TimeSeconds +1;
	Goto('GoOnWithYourLife');
			
EnemyDetected:
	//logDebug("EnemyDetected in DeathRitual",5);

	FallenComrad = none;
	GotoState('Attacking');	

GoOnWithYourLife:
	//logDebug("GoOnWithYourLife in DeathRitual",5);

	FallenComrad = none;
	
	if (Orders == 'Patroling')
		GotoState('Patroling');
	else
		GotoState('Waiting');

}



state MarksRetreating
{
ignores SeePlayer, EnemyNotVisible, HearNoise;

/*	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
							Vector momentum, name damageType)
	{
		Global.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType);
		if ( health <= 0 )
			return;
		if (NextState == 'TakeHit')
		{
			NextState = 'Retreating'; 
			NextLabel = 'TakeHit';
			GotoState('TakeHit'); 
		}
	}

	function Timer()
	{
		bReadyToAttack = True;
		Enable('Bump');
	}
	
	function SetFall()
	{
		NextState = 'Retreating'; 
		NextLabel = 'Landed';
		NextAnim = AnimSequence;
		GotoState('FallingState'); 
	}

	function HitWall(vector HitNormal, actor Wall)
	{
		FindCoverObject();
		if (CoverObject != none)
			GotoState('UseCover');
			
		bSpecialPausing = false;
		if (Physics == PHYS_Falling)
			return;
		if ( Wall.IsA('Mover') && Mover(Wall).HandleDoor(self) )
		{
			if ( SpecialPause > 0 )
				Acceleration = vect(0,0,0);
			GotoState('Retreating', 'SpecialNavig');
			return;
		}
		Focus = Destination;
		if (PickWallAdjust())
			GotoState('Retreating', 'AdjustFromWall');
		else
		{
			Home = None;
			MoveTimer = -1.0;
		}
	}

	/* if has a base then run toward it if its not visible to player. (FIXME)
	adjusts attitude based on proximity to base
	Else pick a random pathnode not visible to player and run toward it.
	Also - modify weights of paths visible and near to player up.
	*/
	function PickDestination()
	{
	 	//bog("find retreat destination");
		Aggressiveness = -0.3;
		CombatStyle = -0.3;
	}

	function ChangeDestination()
	{
		local actor oldTarget;
		local Actor path;
		
		oldTarget = Home;
		PickDestination();
		if (Home == oldTarget)
		{
			Aggressiveness += 0.3;
			GotoState('TacticalMove', 'TacticalTick');
		}
		else
		{
			path = FindPathToward(Home);
			if (path == None)
			{
				Aggressiveness += 0.3;
				GotoState('TacticalMove', 'TacticalTick');
			}
			else 
			{
				MoveTarget = path;
				Destination = path.Location;
			}
		}
	}

	function Bump(actor Other)
	{
		local vector VelDir, OtherDir;
		local float speed;

		if (Pawn(Other) != None)
		{
			if ( (Other == Enemy) || SetEnemy(Pawn(Other)) )
				GotoState('MeleeAttack');
			else if ( (HomeBase(Home) != None) 
				&& (VSize(Location - Home.Location) < HomeBase(Home).Extent) )
				ReachedHome();
			return;
		}
		if ( TimerRate <= 0 )
			setTimer(1.0, false);
		
		speed = VSize(Velocity);
		if ( speed > 1 )
		{
			VelDir = Velocity/speed;
			VelDir.Z = 0;
			OtherDir = Other.Location - Location;
			OtherDir.Z = 0;
			OtherDir = Normal(OtherDir);
			if ( (VelDir Dot OtherDir) > 0.9 )
			{
				Velocity.X = VelDir.Y;
				Velocity.Y = -1 * VelDir.X;
				Velocity *= FMax(speed, 200);
			}
		} 
		Disable('Bump');
	}
	
	function ReachedHome()
	{
		if (LineOfSightTo(Enemy))
		{
			if (HomeBase(RetreatPoint) != None)
			{
				Aggressiveness += 0.2;
				if ( !bMoraleBoosted )
					health = Min(default.health, health+20);
				MakeNoise(1.0);
				GotoState('Attacking');
			}
			else
				ChangeDestination();
		}
		else
		{
			if (Homebase(RetreatPoint) != None)
				MakeNoise(1.0);
			aggressiveness += 0.2;
			if ( !bMoraleBoosted )
				health = Min(default.health, health+5);
			GotoState('Retreating', 'TurnAtHome');
		}
		bMoraleBoosted = true;	
	}

	function PickNextSpot()
	{
		local Actor path;
		local vector dist2d;
		local float zdiff;
		local vector NewLoc;

//		log("in PicknextSpot");
		if ( RetreatPoint == None )
		{
			PickDestination();
			if ( RetreatPoint == None )
				return;
		}
		dist2d = RetreatPoint.Location - Location;
//		log("Dist="$dist2d);
		zdiff = dist2d.Z;
		dist2d.Z = 0.0;

		
		if ((VSize(dist2d) < 2 * CollisionRadius) && (Abs(zdiff) < CollisionHeight))
		{
//			log("Reached home baby!");
			ReachedHome();
		}
		else
		{
//			if (PointReachable(RetreatPoint.location))
//			{
				if (Enemy != none)
					Focus = Enemy.location;
				else
					Focus = RetreatPoint.location;
				Destination = RetreatPoint.location;			
/*			}
			else
			{
				NewLoc = Normal(RetreatPoint.location - location) * 200;
				if (PointReachable(NewLoc))
				{
					Destination = NewLoc;
					if (Enemy != none)
						Focus = Enemy.location;
					else
						Focus = Destination;
				}
				else
				{
					NewLoc = Normal(RetreatPoint.location - location) * 100;
					if (PointReachable(NewLoc))
					{
						Destination = NewLoc;
						if (Enemy != none)
							Focus = Enemy.location;
						else
							Focus = Destination;
					}
					else
					{
						PickDestination();
					}
				}
			}
*/
//			GotoState('TacticalMove', 'NoCharge');
			
		}
	}

	function AnimEnd() 
	{

		if ( bSpecialPausing )
			PlayPatrolStop();
		else if ( bCanFire && LineOfSightTo(Enemy) )
			PlayCombatMove();
		else
			PlayRunning();
	}
*/
	function EndState()
	{
		//logDebug("Leaving state MarksRetreting",2);
	}
	function BeginState()
	{
		//logDebug("Entering state MarksRetreting",2);
//		bCanFire = false;
//		bSpecialPausing = false;
//		SpecialGoal = None;
//		SpecialPause = 0.0;
	}

Begin:
	//bog(class$" retreating");
	
//	GetBehindCoverObject();	
//	if (CoverObject != none)
//		GotoState('UseCover');

	Aggressiveness = -0.3;
	CombatStyle = -0.3;

//	PickNextSpot();
DoDirectMove:
//	PlayRunning();
//	MoveTo(Destination);
	GotoState('TacticalMove','RecoverEnemy');
}


state GameEnded
{
ignores SeePlayer, HearNoise, KilledBy, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, TakeDamage, WarnTarget;

	function Tick(float delta)
	{
		style = STY_Translucent;		
		ScaleGlow -= delta/2;
		
		if (ScaleGlow <= 0.05)
		{
			Destroy();
		}
	}
	function BeginState()
	{
		SetPhysics(PHYS_None);
//		HidePlayer();
	}
}



/*	
	if ( bReadyToAttack && (FRand() < 0.6) )
	{
		SetTimer(TimeBetweenAttacks, false);
		bReadyToAttack = false;
	}
	TweenToRunning(0.1);
	WaitForLanding();
	PickDestination();

Landed:
	TweenToRunning(0.1);
	
RunAway:
	PickNextSpot();
SpecialNavig:
	if (SpecialPause > 0.0)
	{
		if ( LineOfSightTo(Enemy) )
		{
			bFiringPaused = true;
			NextState = 'Retreating';
			NextLabel = 'Moving';
			GotoState('RangedAttack');
		}
		bSpecialPausing = true;
		Acceleration = vect(0,0,0);
		TweenToPatrolStop(0.25);
		Sleep(SpecialPause);
		SpecialPause = 0.0;
		bSpecialPausing = false;
		TweenToRunning(0.1);
	}
Moving:
	if ( MoveTarget == None )
	{
		Sleep(0.0);
		Goto('RunAway');
	}
	if ( !bCanStrafe || !LineOfSightTo(Enemy) ||
		(Skill - 2 * FRand() + (Normal(Enemy.Location - Location - vect(0,0,1) * (Enemy.Location.Z - Location.Z)) 
			Dot Normal(MoveTarget.Location - Location - vect(0,0,1) * (MoveTarget.Location.Z - Location.Z))) < 0) )
	{
		bCanFire = false;
		MoveToward(MoveTarget);
	}
	else
	{
		bCanFire = true;
		StrafeFacing(MoveTarget.Location, Enemy);
	}
	Goto('RunAway');

TakeHit:
	TweenToRunning(0.12);
	Goto('Moving');

AdjustFromWall:
	StrafeTo(Destination, Focus); 
	MoveTo(Destination);
	Goto('Moving');

TurnAtHome:
	Acceleration = vect(0,0,0);
	TurnTo(Homebase(Home).lookdir);
	GotoState('Ambushing', 'FindAmbushSpot');
}
*/

defaultproperties
{
     VoiceRadius=600.000000
     LeftFoot=Sound'KlingonSFX01.Player.FootLeft'
     RightFoot=Sound'KlingonSFX01.Player.FootRight'
     TimeBetweenThreaten=15.000000
     TimeBetweenRoam=20.000000
     TimeBetweenAcquire=5.000000
     TimeBetweenComResp=15.000000
     PercentPlayThreaten=1.000000
     PercentPlayRoam=1.000000
     PercentPlayAcquire=1.000000
     bIgnoreDeadBodies=False
     bCallWhenCarcass=True
     RetreatDamage=15
}
