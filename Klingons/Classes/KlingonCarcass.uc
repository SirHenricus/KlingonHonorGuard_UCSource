//=============================================================================
// KlingonCarcass.
//=============================================================================
// Modified by Mark E. Bradshaw & Nathan Mefford


class KlingonCarcass expands Carcass;

var() mesh	bodyparts[8];
var() float Trails[8];
var() float ZOffset[8];
var() texture BloodColor;
var() sound GibOne;
var() sound GibTwo;
var() sound GibThree;
var() sound GibFour;
var() sound GibFive;
var() sound LandedSound;
var float TarchopSpawnRate;
var int MaxTarchopsSpawned;
var	  bool bThumped;
var class  <bloodSplat> SplatClass;
var int TarchopsSpawned;
var float LastTimeAdjBrightness;
var int SpecialDeath;
var name lastdamagetype;
var float BloodSpawnrate;
var float bloodEjectRate;
var	class <ParticleBlood>    PartBlood;
var float lastbubbleblown;
var float nextbubbletime;
var float BeginFade;
var bool bCallWhenCarcass;
var bool bMournerCalled;
var int PlayerSpeechSound;
var Pawn KilledBy;
var int BloodSpawned;
var Pawn ThePlayer;

var() string[32] FinalAVI;

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}

	if ( NewZone.bWaterZone == true)
	{
		if (AnimSequence == 'flail')
			PlayAnim('ZeroGRanged',1.0,0.1);
	
//		if (Region.Zone.ZoneGravity.Z <= -200)
//		{
//			if (SpecialDeath == 3)
//				TweenAnim('ZeroGRanged',0.1);
//		}	
	}
}

	function PreBeginPlay()
	{
		if ( !bDecorative )
			Region.Zone.NumCarcasses++;
		Super.PreBeginPlay();
		bCollideWorld = true;
	}

	function Destroyed()
	{
		if ( !bDecorative )
			Region.Zone.NumCarcasses--;
		Super.Destroyed();
	}
	
	function Initfor(actor Other)
	{
		local Rotator carcRotation;

		if ( bDecorative )
			Region.Zone.NumCarcasses++;
		bDecorative = false;
		bMeshCurvy = Other.bMeshCurvy;		
		Mesh = Other.Mesh;
		Skin = Other.Skin;
		Fatness = Other.Fatness;
		DrawScale = Other.DrawScale;
		SetCollisionSize(Other.CollisionRadius + 4, Other.CollisionHeight);
		if ( !SetLocation(Location) )
			SetCollisionSize(CollisionRadius - 4, CollisionHeight);

		DesiredRotation = other.Rotation;
		DesiredRotation.Roll = 0;
		DesiredRotation.Pitch = 0;
		AnimFrame = Other.AnimFrame;
		AnimSequence = Other.AnimSequence;  
		AnimRate = Other.AnimRate;      
		TweenRate = Other.TweenRate; 
		AnimLast = Other.AnimLast;
		AnimMinRate = Other.AnimMinRate; 
		bAnimFinished = Other.bAnimFinished;
		bAnimLoop = Other.bAnimLoop;
		bAnimNotify = Other.bAnimNotify;
		Velocity = other.Velocity;
		Mass = Other.Mass;
		ThePlayer = none;		
		if (KlingonPawn(Other) != None) {
			PlayerSpeechSound = KlingonPawn(Other).PlayerSpeechSound;
			KilledBy = KlingonPawn(Other).Enemy;
			TarchopSpawnRate = KlingonPawn(Other).TarchopSpawnRate;
			MaxTarchopsSpawned = KlingonPawn(Other).MaxTarchopsSpawned;
			VolumeRadius = Other.VolumeRadius;
			PartBlood = KlingonPawn(Other).PartBlood;
			SplatClass = KlingonPawn(Other).SplatClass;
			bCallWhenCarcass = KlingonPawn(Other).bCallWhenCarcass;
				
			SpecialDeath = KlingonPawn(Other).SpecialDeath;
			switch(SpecialDeath)
			{
				case 1:
					LightHue = 0;
					bReducedHeight = true;
					break;
				case 2:
					LightHue = 90;
					break;
				case 3:
					bReducedHeight = true;
					bBounce = true;				
					break;
				case 4:
					Mesh = Mesh'PawnDisGuy';
					Skin = Texture'Meat00';
					break;
			}
			SplatClass = KlingonPawn(Other).SplatClass;
		}
		else if (ScriptedPawn(Other) != None) {	// Bots
//			PlayerSpeechSound = ScriptedPawn(Other).PlayerSpeechSound;
			KilledBy = ScriptedPawn(Other).Enemy;
//			TarchopSpawnRate = ScriptedPawn(Other).TarchopSpawnRate;
//			MaxTarchopsSpawned = ScriptedPawn(Other).MaxTarchopsSpawned;
			VolumeRadius = Other.VolumeRadius;
//			PartBlood = ScriptedPawn(Other).PartBlood;
//			SplatClass = ScriptedPawn(Other).SplatClass;
//			bCallWhenCarcass = ScriptedPawn(Other).bCallWhenCarcass;
				
			SpecialDeath = ScriptedPawn(Other).SpecialDeath;
			switch(SpecialDeath)
			{
				case 1:
					LightHue = 0;
					bReducedHeight = true;
					break;
				case 2:
					LightHue = 90;
					break;
				case 3:
					bReducedHeight = true;
					bBounce = true;				
					break;
				case 4:
					Mesh = Mesh'PawnDisGuy';
					Skin = Texture'Meat00';
					break;
			}
//			SplatClass = ScriptedPawn(Other).SplatClass;
		}
		else if (Human(Other) != None) {	//Player
//			PlayerSpeechSound = Human(Other).PlayerSpeechSound;
			KilledBy = Human(Other).Enemy;
//			TarchopSpawnRate = Human(Other).TarchopSpawnRate;
//			MaxTarchopsSpawned = Human(Other).MaxTarchopsSpawned;
			VolumeRadius = Other.VolumeRadius;
//			PartBlood = Human(Other).PartBlood;
//			SplatClass = Human(Other).SplatClass;
//			bCallWhenCarcass = Human(Other).bCallWhenCarcass;
			ThePlayer = Human(Other);
			SpecialDeath = Human(Other).SpecialDeath;
			switch(SpecialDeath)
			{
				case 1:
					LightHue = 0;
					bReducedHeight = true;
					break;
				case 2:
					LightHue = 90;
					break;
				case 3:
					bReducedHeight = true;
					bBounce = true;				
					break;
				case 4:
					Mesh = Mesh'PawnDisGuy';
					Skin = Texture'Meat00';
					break;
			}
//			SplatClass = Human(Other).SplatClass;
		}
	}

/*
	function SpawnBlood(int Damage, vector HitLocation)
	{
//		local int		i,n;
//		local actor		a;
//
//		if (SplatClass == None)
//			return;
//		n=0.34*Damage;
//		for (i=0 ; i < n ; i++)
//		{
//xxx			a=Spawn(Splatclass, self);
//			a.SetPhysics(PHYS_Falling);
//			a.Velocity=600*Vrand();
//			a.Velocity.z = abs(a.Velocity.z);
//		}
		local int i,n;
		local BloodSplat b;
		local Rotator rot;
		
		rot = Rotator(HitLocation - location);
		rot.pitch = max(min(Rot.Pitch,4000),-4000);
		n=0.34*Damage;
		for (i=min(Damage,40); i > 0; i-=10)
		{
			rot.roll = Rand(65536);
			b = Spawn(class 'BloodSplat',self,'',HitLocation,rot);
			b.SetPhysics(PHYS_Falling);
			b.Velocity=150*Vrand();
			b.Velocity.z = abs(b.Velocity.z);
			
		}
	}
*/


function PlayAVIs()
{
	local vector BlindVect;

// If it's not a mission, no AVIs
	if (Left(Level.Title,1) != "M")
	{
		return;
	}
	if (Level.Title == "M16: THE REACTOR")
	{
		PlayerPawn(ThePlayer).ConsoleCommand("PlayAVI F_Prax.avi N "$FinalAVI$" N");
//		PlayerPawn(ThePlayer).ReStartLevel(); 		
	}
	else
	{
		if (Level.Title == "M12: THE FEK'LHR")
		{
			PlayerPawn(ThePlayer).ConsoleCommand("PlayAVI F_D7x.avi N "$FinalAVI$" N");
//			PlayerPawn(ThePlayer).ReStartLevel(); 				
		}
// Probably shouldn't play death AVI on training mission
		else if (Left(Level.Title,3) != "M01")
		{
			PlayerPawn(ThePlayer).ConsoleCommand("PlayAVI "$FinalAVI$" N");
//			PlayerPawn(ThePlayer).ReStartLevel(); 		
		}
	}
}

//**********************************************************************
function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
	local int i,j;
	local BloodSplat b;
	local Rotator rot;
	local ParticleBlood P1;
	rot = Rotator(HitLocation - location);
	rot.pitch = max(min(Rot.Pitch,4000),-4000);

	if (Level.Game.bLowGore)
		return;
		
	if (BloodSpawned > 30)
		return;
		
	for (i=min(Damage,70); i > 0; i-=10)
	{
		rot.roll = Rand(65536);
		if (SplatClass == none)
		{
			b=Spawn(class 'BloodSplat',self,'',HitLocation,rot);
			
		}
		else
		{
			b=Spawn(SplatClass,self,'',HitLocation,rot);
//			for (j=0 ; j<20; j++)
//			{
//				P1= Spawn(class 'GreenParticles',self,'',HitLocation);
//				P1.Velocity = -Momentum*0.2 + VRand()*30;
//			}
			
		}	
		
		if (b != none)
		{
			b.SetPhysics(PHYS_Falling);
			b.Velocity = Momentum * (0.2 + FRand());
			BloodSpawned++;
		}
	}
}


function GibIt()
{
	local HumanGibs PartsIsParts;
	local Rotator Rot;

	if (Level.Game.bLowGore)
		return;
			
	PartsIsParts = spawn(class'HumanArm');
	PartsIsParts.velocity = VRand() * 350;
	if (PartsIsParts.velocity.Z < 0)
		PartsIsParts.velocity.Z = -PartsIsParts.velocity.Z;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;
	
	PartsIsParts = spawn(class'HumanArm');
	PartsIsParts.velocity = VRand() * 450;
	if (PartsIsParts.velocity.Z < 0)
		PartsIsParts.velocity.Z = -PartsIsParts.velocity.Z;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;

	PartsIsParts = spawn(class'HumanLeg');
	PartsIsParts.velocity = VRand() * 250;
	SpawnBlood(5, location, PartsIsParts.velocity);
	
	if (PartsIsParts.velocity.Z < 0)
		PartsIsParts.velocity.Z = -PartsIsParts.velocity.Z;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;
	SpawnBlood(5, location, PartsIsParts.velocity);
	
	PartsIsParts = spawn(class'HumanLeg');
	PartsIsParts.velocity = VRand() * 350;
	if (PartsIsParts.velocity.Z < 0)
		PartsIsParts.velocity.Z = -PartsIsParts.velocity.Z;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;	
	SpawnBlood(5, location, PartsIsParts.velocity);

	PartsIsParts = spawn(class'HumanHead');
	PartsIsParts.velocity = VRand() * 350;
	if (PartsIsParts.velocity.Z < 0)
		PartsIsParts.velocity.Z = -PartsIsParts.velocity.Z;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;
	SpawnBlood(5, location, PartsIsParts.velocity);
	
	PartsIsParts = spawn(class'HumanBlob');
	PartsIsParts.velocity = VRand() * 550;
	if (PartsIsParts.velocity.Z < 0)
		PartsIsParts.velocity.Z = -PartsIsParts.velocity.Z;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;	
	SpawnBlood(5, location, PartsIsParts.velocity);
	
	PartsIsParts = spawn(class'HumanBlob');
	PartsIsParts.velocity = VRand() * 350;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;	
	SpawnBlood(5, location, PartsIsParts.velocity);

	PartsIsParts = spawn(class'HumanBlob');
	PartsIsParts.velocity = VRand() * 250;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;	

	PartsIsParts = spawn(class'HumanBlob');
	PartsIsParts.velocity = VRand() * 450;
	PartsIsParts.bFixedRotationDir=True;
	PartsIsParts.RotationRate=RotRand(True)*2;	

		if (ThePlayer != none)
		{
			bHidden = true;
			GotoState('WaitToDestroy');
		}
		else
			Destroy();
}


	function Tick(float delta)
	{
		local float invertedpercent,percentCompleted;
		local ParticleBlood P1;
		LastTimeAdjBrightness += delta;

		switch(SpecialDeath)
		{
			case 1:
			case 2:
				if (SpecialDeath == 1)
					LightHue = 0;
				else
					LightHue = 90;
	
				style = STY_Translucent;		
				if (LastTimeAdjBrightness < 2.0)
				{		
					PercentCompleted = (2 - LastTimeAdjBrightness) / 2;
					invertedpercent = 1-PercentCompleted;
		
					if (PercentCompleted > 0.5)
					{
						VolumeBrightness = (invertedpercent * 55.0 );
						ScaleGlow = 4.0;
						AmbientGlow = (invertedpercent * 455.0 );
						LightBrightness = (invertedpercent* 455.0);
//						VolumeRadius = 2;//(temp1 * 455.0);
					}
					else
					{
						ScaleGlow = 0;//PercentCompleted * 2;
						VolumeBrightness = (PercentCompleted * 55.0 );
		
						AmbientGlow = (PercentCompleted * 455 );
						LightBrightness = (PercentCompleted * 455 );
//						VolumeRadius = 2;//(ScaleGlow * 455 );
					}	
				}
				else
				{
					if (KlingonPlayer(KilledBy) != none)
					{
						if (FRand() < 0.2)
						{
							if (FRand() < 0.5)
							{
								KlingonPlayer(KilledBy).SayOneLessCorpse();
							}
							else
							{
								if (FRand() < 0.5)
									KlingonPlayer(KilledBy).SayLoveThatSmell();
								else
									KlingonPlayer(KilledBy).SaySmokedBregit();
							}
						}
					}
					if (ThePlayer != none)
					{
						bHidden = true;
						LightBrightness = 0;
						ScaleGlow = 0.0;
						VolumeBrightness =0.0;
						GotoState('WaitToDestroy');
					}
					else
						Destroy();
				}
				break;
			case 3:
			case 6:
				if (Region.Zone.ZoneGravity.Z <= -200)			
				{
				
					if (LastTimeAdjBrightness > 0.05)
					{
						if (!Level.Game.bLowGore)
						{
							RotationRate *= 0.95;
							if (Velocity.Z > 0)
								Velocity *= 0.93;
							else
								Velocity *= 01.03;
							
							if (BloodEjectRate > 0)
							{
								LastTimeAdjBrightness = 0;
		
								BloodEjectRate *= 0.99;
								P1 = spawn(PartBlood,self,'',self.location);	 //,self,'',HitLocation);
								if (P1 != none)
								{
									P1.Velocity = vector(Rotation) * 160 * BloodEjectRate + VRand() * 5;	
									P1.SetPhysics(PHYS_Falling);
									P1.DrawScale *= (FRand() + 1.0);
								}
							}
						}
					}
				}
				else
				{
					if (LastTimeAdjBrightness > BloodSpawnRate)
					{
						if (!Level.Game.bLowGore)
						{					
							BloodEjectRate *= 0.99;
							P1 = spawn(PartBlood,self,'',self.location);	 //,self,'',HitLocation);
							
							if (P1 != none)
							{
								if (AnimSequence == 'StunDead')
									P1.Velocity = vect(0,0,1) * 160 * BloodEjectRate + VRand() * 5;	
								else
									P1.Velocity = vector(Rotation) * 160 * BloodEjectRate + VRand() * 5;	
								P1.SetPhysics(PHYS_Projectile);
								P1.DrawScale *= (FRand() + 1.0);
							}
							LastTimeAdjBrightness = 0.0;
						}
					}
					BloodSpawnRate += 0.0003;					
					
				}
				
				SetRotation(Rotation + RotationRate);
				break;
			case 4:
				if (LightBrightness > 5)
					LightBrightness -= 2;
				if (LastTimeAdjBrightness > 0.10)
				{
					AmbientGlow -= 5;
					
				
					if (Skin == Texture'Meat09')
					{

						if (ThePlayer != none)
						{
							bHidden = true;
							GotoState('WaitToDestroy');
						}
						else
							Destroy();
					}
					if (Skin == Texture'Meat08')
						Skin = Texture'Meat09';
					if (Skin == Texture'Meat07')
						Skin = Texture'Meat08';
					if (Skin == Texture'Meat06')
						Skin = Texture'Meat07';
					if (Skin == Texture'Meat05')
						Skin = Texture'Meat06';
					if (Skin == Texture'Meat04')
						Skin = Texture'Meat05';
					if (Skin == Texture'Meat03')
						Skin = Texture'Meat04';
					if (Skin == Texture'Meat02')
						Skin = Texture'Meat03';
					if (Skin == Texture'Meat01')
						Skin = Texture'Meat02';
					if (Skin == Texture'Meat00')
						Skin = Texture'Meat01';
					LastTimeAdjBrightness = 0;
				}
				break;
			case 5:
				if (LastTimeAdjBrightness > 0.05)
				{
					DrawScale -= 0.008;
					LastTimeAdjBrightness =0.0;
				}
				break;
			default:
				if (LastTimeAdjBrightness > 0.05)
				{
					LastTimeAdjBrightness = 0.0;;
				
					CumulativeDamage -= 1;
					if (CumulativeDamage < 0)
						CumulativeDamage = 0;
			
					if ((lastdamagetype == 'Disintegrated') || (lastdamagetype == 'zapped'))
					{
						AmbientGlow = CumulativeDamage*2;
						LightBrightness = CumulativeDamage*2;
					}
					else
					{
						AmbientGlow = 0;
						LightBrightness = 0;
					}
				}
				break;
		}
		if ( Region.Zone.bWaterZone )
		{
			LastBubbleBlown += Delta;
			if (LastBubbleBlown > NextBubbleTime)
			{
				NextBubbleTime += 0.05;
				spawn(class'waterbubble');
				LastBubbleBlown = 0;
			}
		}
	}

/*
function Tick(float Delta)
{
	LastTimeAdjBrightness += Delta;
		
	if (LastTimeAdjBrightness > 0.05)
	{
		LastTimeAdjBrightness = 0.0;;

		AmbientGlow = CumulativeDamage*2;
		LightBrightness = CumulativeDamage*2;
		
		CumulativeDamage -= 1;
		if (CumulativeDamage < 0)
			CumulativeDamage = 0;
	}
}
*/
	function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, 
							Vector Momentum, name DamageType)
	{
		//xxxSpawn(class'BloodSpurt',,,HitLocation);
//		Super.TakeDamage(Damage, instigatedBy, HitLocation, Momentum, DamageType);
		if ( !bDecorative )
		{
			bBobbing = false;
			SetPhysics(PHYS_Falling);
		}
		if ((SpecialDeath == 3) || (SpecialDeath == 6))
		{
			if (Region.zone.zonegravity.Z > -200)
				SetPhysics(PHYS_projectile);
		}
		Velocity += momentum/(Mass + 200);
		Velocity.z = Vsize(Velocity);
		if ( DamageType == 'shot' )
			Damage *= 0.4;
		CumulativeDamage += Damage;
		lastdamagetype = damageType;
		SpawnBlood(Damage, HitLocation, VRand()* 200);
		
		if (damageType == 'Disintegrated')
		{
			LightHue = 0;
			Velocity = vect(0,0,0);			
			Acceleration = vect(0,0,0);			
		}
		else
		{
			if (damageType == 'zapped')
			{
				LightHue = 90;
				Velocity = vect(0,0,0);				
				Acceleration = vect(0,0,0);			
			}
		}
		
		

		if ( (((Damage > 32) || !IsAnimating()) && (CumulativeDamage > 100)) || (Damage > Mass) 
			|| ((Velocity.Z > 250) && !IsAnimating()) )
			{
//			ChunkUp(Damage * 0.5);
				if (SpecialDeath == 3)
				{
					if (Region.Zone.ZoneGravity.Z > -200)			
					{
						BloodEjectRate = 0.7;
						BloodSpawnRate = 0.05;
					}
				}
			}
		if (damageType == 'blended')
		{
			GibIt();
		}
		if ( bDecorative )
			Velocity = vect(0,0,0);
	}


	function CreateReplacement()
	{
		local BodyChunks carc;
		
		if (bHidden)
			return;

//		log("in CreateReplacement");		
		if ( bodyparts[0] != None )
		{
//			log("Spawning body chunks in CreateReplacement");
			carc = Spawn(class 'BodyChunks',,, Location + ZOffset[0] * CollisionHeight * vect(0,0,1)); 
		}
		if (carc != None)
		{
			carc.TrailSize = Trails[0];
			carc.Mesh = bodyparts[0];
			carc.Initfor(self);
			carc.Velocity = velocity; //no rand
			carc.DrawScale = 0.3;		// match this up with value in clientextrachunks

			carc.Bugs = Bugs;
			if ( Bugs != None )
				Bugs.SetBase(carc);
			Bugs = None;
		}
		else if ( Bugs != None )
			Bugs.Destroy();
			
	}

	function ChunkUp(int Damage)
	{
		CreateReplacement();
		ClientExtraChunks();
		SetPhysics(PHYS_None);
		bHidden = true;
		SetCollision(false,false,false);
		bProjTarget = false;
		GotoState('Gibbing');
	}


	function ClientExtraChunks()
	{
		local BodyChunks carc;
		//local bloodspurt Blood;
		local int n;
		
		n = 1;
		while ( (n<8) && (bodyparts[n] != none) )
		{
			carc = Spawn(class 'BodyChunks',,, Location + ZOffset[n] * CollisionHeight * vect(0,0,1));
			if (carc != None)
			{
				carc.TrailSize = Trails[n];
				carc.Mesh = bodyparts[n];
				carc.Initfor(self);
				carc.DrawScale = 0.3;
			}
			n++;
		}
		//XXXBlood = Spawn(class 'Bloodspurt');
		
	}


function Landed(vector HitNormal)
	{
		local rotator finalRot;
		local float OldHeight;

		RotationRate.Yaw = 0.0;
		RotationRate.Roll = 0.0;
		RotationRate.Pitch = 0.0;			
		

		finalRot = Rotation;
		finalRot.Roll = 0;
		finalRot.Pitch = 0;
		setRotation(finalRot);
		if (SpecialDeath == 3)
		{
			if (Region.Zone.ZoneGravity.Z <= -200)			
			{
				// normal gravity
				TweenAnim('Splat',0.1);
				BloodEjectRate = 0;
				BloodSpawnRate = 30;
				
				if (FRand() < 0.5)
					PlaySound(sound'BodyFall1',SLOT_Interact,1.0,,2200);
				else
					PlaySound(sound'BodyFall2',SLOT_Interact,1.0,,2200);
				PlaySound(sound'TarSting',SLOT_Talk,0.5,,2200);
				SpawnBlood(5, Location, vect(0,0,0));
				GotoState('WaitToDie');
					
			}
			else
			{
				TweenAnim('StunDead',0.1);
			
				BloodSpawnRate *= 0.5;
			}

		}
//xxx		if ( !bDecorative )
//			Spawn(class 'Bloodspurt');
		SetPhysics(PHYS_None);
		

		SetCollision(bCollideActors, false, false);
		if ( !IsAnimating() )
			LieStill();
			
	}


	function AnimEnd()
	{
		if ( Physics == PHYS_None )
			LieStill();
	}

	function LieStill()
	{
		if ( !bThumped && !bDecorative )
			LandThump();
		if ( !bReducedHeight )
			ReduceCylinder();
	}

	function ThrowOthers()
	{
		local float dist, shake;
		local pawn Thrown;
		local PlayerPawn aPlayer;
		local vector Momentum;

		Thrown = Level.PawnList;
		While ( Thrown != None )
		{
			aPlayer = PlayerPawn(Thrown);
			if ( aPlayer != None )
			{	
				dist = VSize(Location - aPlayer.Location);
				shake = FMax(500, 1500 - dist);
				aPlayer.ShakeView( FMax(0, 0.35 - dist/20000),shake, 0.015 * shake );
				if ( (aPlayer.Physics == PHYS_Walking) && (dist < 1500) )
				{
					Momentum = -0.5 * aPlayer.Velocity + 100 * VRand();
					Momentum.Z =  7000000.0/((0.4 * dist + 350) * aPlayer.Mass);
//xxx					aPlayer.ClientAddVelocity(Momentum);
				}
			}
		Thrown = Thrown.nextPawn;
		}
	}

	function LandThump()
	{
		local float impact;

		if ( Physics == PHYS_None)
		{
			bThumped = true;
			if ( Role == ROLE_Authority )
			{
				impact = 0.75 + Velocity.Z * 0.004;
				impact = Mass * impact * impact * 0.01;
				PlaySound(LandedSound,, impact);
				if ( Mass >= 500 )
					ThrowOthers();
			}
		}
	}

	function ReduceCylinder()
	{
		local float OldHeight;

		bReducedHeight = true;
		SetCollision(bCollideActors,False,False);
		OldHeight = CollisionHeight;
		SetCollisionSize(CollisionRadius + 4, CollisionHeight * 0.3);
		PrePivot = vect(0,0,1) * (OldHeight - CollisionHeight); 
		if ( !SetLocation(Location - PrePivot) )
		{
			SetCollisionSize(CollisionRadius - 4, CollisionHeight);
			if ( !SetLocation(Location - PrePivot) )
			{
				SetCollisionSize(CollisionRadius, OldHeight);
				SetCollision(false, false, false);
				PrePivot = vect(0,0,0);
			}
		}
		PrePivot = PrePivot + vect(0,0,2);
		Mass = Mass * 0.8;
	}

	function HitWall(vector HitNormal, actor Wall)
	{
		//XXXSpawn(class 'Bloodspurt');
//		Velocity = 0.7 * (Velocity - 2 * HitNormal * (Velocity Dot HitNormal));
//		Velocity.Z *= 0.9;

		Velocity=((Velocity dot HitNormal)*HitNormal*(-2.0)+Velocity);
		if (Region.Zone.ZoneGravity.Z > -200)
		{
			Velocity *= 0.8;
	
			RotationRate.Yaw *= 0.8;
			RotationRate.Roll *= 0.8;
			RotationRate.Pitch *= 0.8;			
			if ( Abs(Velocity.Z) < 20)
			{
				bBounce = false;
				Disable('HitWall');
			}
			
		}
		else
		{
			Velocity *= 0.1;
			RotationRate.Yaw *= 0.2;
			RotationRate.Roll *= 0.2;
			RotationRate.Pitch *= 0.2;	
			if (HitNormal != vect(0,0,1))
			{
				if (FRand() < 0.5)
					PlaySound(sound'BodyFall1',SLOT_Interact,1.0,,2200);
				else
					PlaySound(sound'BodyFall2',SLOT_Interact,1.0,,2200);
			}
			SpawnBlood(5, Location, vect(0,0,0));					
			if ( Abs(Velocity.Z) < 200)
			{
				bBounce = false;
				Disable('HitWall');
			}
			
		}
		
//		Velocity*=(1.0-(Mass*0.01));
		
	}

auto state Dying
{
	ignores TakeDamage;

Begin:
	if ( bDecorative && !bReducedHeight )
	{
		ReduceCylinder();
		SetPhysics(PHYS_None);
	}
//	Sleep(0.2);
	GotoState('Dead');
}

state Dead 
{
	function AddFliesAndRats()
	{
		if ( (flies > 0) && (Bugs == None) && (Level.NetMode == NM_Standalone) )
		{
			//Bugs = Spawn(class 'DeadBodySwarm');
			if (Bugs != None)
			{
				Bugs.SetBase(Self);
				//DeadBodySwarm(Bugs).swarmsize = flies * (FRand() + 0.5);
				//DeadBodySwarm(Bugs).swarmradius = collisionradius;
			}
		}
	}

	function CheckZoneCarcasses()
	{
		local KlingonCarcass C, Best;

		if ( !bDecorative && (Region.Zone.NumCarcasses > Region.Zone.MaxCarcasses) )
		{
			Best = self;
			ForEach AllActors(class'KlingonCarcass', C)
				if ( (C != Self) && !C.bDecorative && (C.Region.Zone == Region.Zone) && !C.IsAnimating() )
				{
					if ( Best == self )
						Best = C;
					else if ( !C.PlayerCanSeeMe() )
					{
						Best = C;
						break;
					}
				}
			Best.Destroy();
		}
	}

	function Timer()
	{
		local Tarchop tarc;
		local vector loc;
		local Humanoids A;
		local bool foundone;
		
		if ( !bHidden )
		{
			if (SpecialDeath == 3)
			{
				if (Region.Zone.ZoneGravity.Z <= -200)
				{
					// normal gravity
					if (Physics == PHYS_Projectile)
					{
						setPhysics(PHYS_Falling);
					}
				}
			}
			if (bCallWhenCarcass)
			{
				if (SpecialDeath == 0)
				{
					if ((Level.TimeSeconds > BeginFade) && (BeginFade != 0))
					{
						AmbientGlow = 0;
						SpecialDeath = 1;
//						LightSaturation = 255;
						LastTimeAdjBrightness = 0;	
						LightRadius = 0;			
					}
					else
					{
						if (!bMournerCalled)
						{
							FoundOne = false;
							foreach VisibleActors(class 'Humanoids',A,600)
							{
								if (!FoundOne)
								{
									if (A.Enemy == none)
									{
										if ((A.AttitudeToPlayer != ATTITUDE_IGNORE) && (A.AttitudeToPlayer != ATTITUDE_FRIENDLY))
										{
											if (A.FallenComrad == none)
											{
												if (!A.bIgnoreDeadBodies)
												{
													A.FallenComrad = self;
													A.GotoState('DeathRitual');
													FoundOne = true;
													bMournerCalled = true;
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			
			if (FRand() < TarchopSpawnRate)
			{
				if (TarchopsSpawned < MaxTarchopsSpawned)
				{
					tarc = spawn(class  'Tarchop',self,'',Location);
					tarc.AttitudeToPlayer = ATTITUDE_Ignore;
					tarc.DrawScale = 0.25;
					tarc.SetPhysics(PHYS_Falling);
					tarc.Acceleration = vect(0,0,0);
					loc = location;
					loc.Z -= (CollisionHeight / 2);
					loc.X += FRand() * 45;
					loc.Y += FRand() * 45;
					tarc.SetLocation(Loc);
					tarc.Health = 8;
					TarchopsSpawned += 1;
				}
			}
//			if (Fatness > 345)
//			{
//				ChunkUp(10);
//				Destroy();	
//			}
		}
	}
	
	
	
/*	function Tick(float delta)
	{
		if (ScaleGlow > 0.01)
			ScaleGlow -= 0.01;
		else
			ScaleGlow = 0;

		style = STY_Translucent;

		if (volumebrightness < 200)
		{
			VolumeBrightness ++;
		
			if (volumebrightness < 50)
			{
				AmbientGlow += 3;
				LightBrightness +=3;
				VolumeRadius += 2;
				
			}
			else
			{
				if (AmbientGlow  > 1)
				{
					AmbientGlow -= 1;
					LightBrightness -=1;
					if (VolumeRadius > 1)
						VolumeRadius -= 1;
					
				}
				else
					VolumeBrightness = 0;
			}

			
		}
//		log(AmbientGlow$" "$volumeBrightness$" "$LightBrightness$" "$volumeradius$"  "$ScaleGlow);
	}
*/

	function BeginState()
	{
		local Rotator ForwardRot;
		
		if ( bDecorative )
			lifespan = 0.0;
		else
		{
			SetTimer(0.5, true); 
		}
		LastTimeAdjBrightness = 0;
// This was causing the overlays to not work in multiplayer games -LB
//		if (KlingonPlayer(ThePlayer) != none)
//		{
//			KlingonHud(KlingonPlayer(ThePlayer).MyHud).SetOverlay(false);
//			KlingonHud(KlingonPlayer(ThePlayer).MyHud).CameraLook(false);
//		}		
		switch (SpecialDeath)
		{
			case 6:
				if (Velocity.Z < 30)
					Velocity.Z = 30;
				if (VSize(Velocity) > 1200)
					velocity = normal(Velocity) * 1200;

				BloodEjectRate = 1.0;
				BloodSpawnRate = 0.05;
				RotationRate.Yaw = 10;
				RotationRate.Roll = 10;
				
				RotationRate.Pitch = 400;			
			

				if (Region.Zone.ZoneGravity.Z > -200)
					SetPhysics(PHYS_Projectile);
				else
					SetPhysics(PHYS_Falling);
				TweenAnim('ZeroGRanged',0.1);
				break;
			case 3:
				if (VSize(Velocity) > 1200)
					velocity = normal(Velocity) * 1200;
	
				BloodEjectRate = 1.0;
				BloodSpawnRate = 0.05;
				if (Region.Zone.ZoneGravity.Z > -200)
				{
					RotationRate.Yaw = 10;
					RotationRate.Roll = 10;
					RotationRate.Pitch = VSize(Velocity) * 2;			
					SetPhysics(PHYS_Projectile);
					TweenAnim('ZeroGRanged',0.1);
					
				}
				else
				{
//					TweenAnim('StunDead',0.0);
					Disable('AnimEnd');
					LoopAnim('Flail',1.0);
					bAnimLoop = true;

					ForwardRot = Rotation;
					ForwardRot.Pitch = 16000;
					SetRotation(ForwardRot);
					RotationRate.Yaw = 0;
					RotationRate.Roll = 0;
					RotationRate.Pitch = -400;			
					SetPhysics(PHYS_Falling);
				}
				break;
			case 4:
				LightBrightness = 250;
				LightHue = 37;			
				AmbientGlow = 200;
				PlayAnim('Disintegrate',0.4,0.1);			
				break;
			case 5:
				PlayAnim('Explode',0.2,0.1);			
				LastTimeAdjBrightness = -0.7;				
				
				Style = STY_Translucent;
				Texture = texture'dis3blu2';
				DrawScale = 0.2;
				bParticles = True;
				break;
			case 8:
				if (!Level.Game.bLowGore)
					GibIt();
		}
		
//			SetTimer(30.0 - 2 * Region.Zone.NumCarcasses, false); 
	}
Begin:
	if (SpecialDeath != 3)
	{
		FinishAnim();

		if ((SpecialDeath != 1) && (SpecialDeath != 2))
		{
			if 	(PlayerSpeechSound > -1)
			{
				if (DMCarcass(self) == none)
				{
					if (KilledBy.Health > 0)
						KlingonPlayer(KilledBy).SaySpeechInt(PlayerSpeechSound);		
				}
			}
		}
		if (SpecialDeath == 0)
		{
			if (ThePlayer != none)
			{
				GotoState('WaitToDie');
			}
		}
		
		Sleep(5.0);
		CheckZoneCarcasses();
		Sleep(7.0);
		if ( !bDecorative && !bHidden && !Region.Zone.bWaterZone && !Region.Zone.bPainZone )
			AddFliesAndRats();	
	}
}
	
state WaitToDestroy
{
	function Tick(float Delta)
	{
	}

Begin:
	if (Level.Game != None && Level.Game.IsA('SinglePlayer'))
	{
		if (KlingonPlayer(ThePlayer) != None && KlingonPlayer(ThePlayer).bPlayDeathAVI)
		{
			Sleep(1.0);
			PlayerPawn(ThePlayer).ClientSetMusic(None,0,255,MTRAN_Instant);
			if ((Level.Title == "M16: THE REACTOR") || (Level.Title == "M12: THE FEK'LHR"))
			{
				Sleep(1.0);
			}
			else
				Sleep(5.0);

			PlayAVIs();
		}
	}

	Destroy();
}

state WaitToDie
{
	function Tick(float Delta)
	{
	}

Begin:
	if (Level.Game != None && Level.Game.IsA('SinglePlayer'))
	{
		if (KlingonPlayer(ThePlayer) != None && KlingonPlayer(ThePlayer).bPlayDeathAVI)
		{
			Sleep(1.0);

			PlayerPawn(ThePlayer).ClientSetMusic(None,0,255,MTRAN_Instant);
			if ((Level.Title == "M16: THE REACTOR") || (Level.Title == "M12: THE FEK'LHR"))
			{
				Sleep(1.0);
			}
			else
				Sleep(5.0);

			PlayAVIs();
		}
	}
}


state Gibbing
{
	ignores Landed, HitWall, AnimEnd, TakeDamage;

	function GibSound()
	{
		local float decision;

		decision = FRand();
		if (decision < 0.2)
			PlaySound(GibOne, SLOT_Interact, 0.05 * Mass);
		else if ( decision < 0.4 )
			PlaySound(GibTwo, SLOT_Interact, 0.05 * Mass);
		else if ( decision < 0.6 )
			PlaySound(GibThree, SLOT_Interact, 0.05 * Mass);
		else if ( decision < 0.8 )
			PlaySound(GibFour, SLOT_Interact, 0.05 * Mass);
		else 
			PlaySound(GibFive, SLOT_Interact, 0.05 * Mass);
	}

Begin:
	Sleep(0.2);
	GibSound();
	if ( !bPlayerCarcass )
		Destroy();
}

/*
*/

defaultproperties
{
     bodyparts(0)=Mesh'Klingons.AmmoFuelCell'
     bodyparts(1)=Mesh'Klingons.AmmoFuelCell'
     bodyparts(2)=Mesh'Klingons.AmmoFuelCell'
     bodyparts(3)=Mesh'Klingons.AmmoFuelCell'
     bodyparts(4)=Mesh'Klingons.AmmoFuelCell'
     bodyparts(5)=Mesh'Klingons.AmmoFuelCell'
     bodyparts(6)=Mesh'Klingons.AmmoFuelCell'
     bodyparts(7)=Mesh'Klingons.AmmoFuelCell'
     Trails(0)=3.000000
     Trails(1)=3.000000
     Trails(2)=3.000000
     Trails(3)=3.000000
     Trails(4)=3.000000
     Trails(5)=3.000000
     Trails(6)=3.000000
     Trails(7)=3.000000
     ZOffset(0)=0.500000
     ZOffset(1)=-0.500000
     FinalAVI="Death.avi"
     AnimSequence=DeadBacktoFace
     DrawScale=1.600000
     bMeshCurvy=False
     bCollideActors=False
     bCollideWorld=False
     LightType=LT_Steady
     LightRadius=7
     bBounce=True
}
