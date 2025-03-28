//=============================================================================
// BigIceRock.
//=============================================================================
class BigIceRock expands ProjIceChunk;

var() name				HurtType;
var() bool				bCanBreak;
var() bool				bBreakWhenLand;
var() int				NumberShatterPieces;
var() float				PiecesLifespan;


var(Sounds)	sound 		LandedSound;
var(Sounds)	sound 		TriggerFalling;
var(Sounds)	sound 		Hit;

var(Sound)	float		VoiceRadius;

var bool takingdamage;


function PreBeginPlay()
{
	local float decision;

//	DesiredRotation.Pitch = Rotation.Pitch + Rand(2000) - 1000;
//	DesiredRotation.Roll = Rotation.Roll + Rand(2000) - 1000;
//	DesiredRotation.Yaw = Rotation.Yaw + Rand(2000) - 1000; 
//
//	bFixedRotationDir=True;
//	RotationRate=RotRand(True);	
}

function ZoneChange(ZoneInfo newZone)
{
	if ( newZone.bWaterZone )
	{
		DesiredRotation = Rotation;
		RotationRate.Pitch = 0;
		RotationRate.Yaw = 0;
		RotationRate.Roll = 0;
		
	}

	Super.ZoneChange(newZone);
}

function SpawnChunks(int num)
{
	local int    NumChunks,i;
	local ProjIceChunk   TempRock;
	local float scale;


	if ( DrawScale < 1 + FRand() )
		return;
	NumChunks = 1+Rand(num);
	scale = sqrt(0.52/NumChunks);
	if ( scale * DrawScale < 1 )
	{
		NumChunks *= scale * DrawScale;
		scale = 1/DrawScale;
	}
	speed = VSize(Velocity);
	for (i=0; i<NumChunks; i++) 
	{
//		TempRock = Spawn(class'ProjIceChunk');
		TempRock = Spawn(class);

		if (TempRock != None )
		{
			TempRock.InitFrag(TempRock, scale);
			TempRock.Mesh = SpawnedMesh;
			TempRock.GotoState('FallingState');
		}
	}
}


function trigger(actor Other, Pawn Instigator)
{
	if (Physics == PHYS_Flying)
	{
		PlaySound(TriggerFalling, SLOT_Interact,,,VoiceRadius);
		SetPhysics(PHYS_Falling);
		DesiredRotation.Pitch = Rotation.Pitch + Rand(2000) - 1000;
		DesiredRotation.Roll = Rotation.Roll + Rand(2000) - 1000;
		DesiredRotation.Yaw = Rotation.Yaw + Rand(2000) - 1000; 
		bFixedRotationDir=True;
		RotationRate=RotRand(True);			
		bBlockPlayers = false;
		
		GotoState('FallingState');
		
	}
}


function Bump(actor Other)
{
	local vector	MomVec;
//	MomVec=vect(0,0,0);
	
//	Other.TakeDamage(Damage,Instigator,self.location,MomVec,HurtType);
//	self.TakeDamage(Damage,Instigator,self.location,MomVec,HurtType);
}


/*
function Touch(actor Other)
{
	local vector	MomVec;



//	MomVec=vect(0,0,0);	//(Damage*(MomentumTransfer*0.001)*(Other.Location-HitLoc));
	Other.TakeDamage(Damage,Instigator,self.location,MomVec,HurtType);
	
	self.TakeDamage(Damage,Instigator,self.location,MomVec,HurtType);

}
*/

function Landed(vector HitNormal)
{
	bBlockPlayers = true;
//	PlaySound(LandedSound, SLOT_Interact,,,VoiceRadius);
	if (Physics == PHYS_Falling)
	{
		gotostate('Sitting');
	}
}

function BreakRock()
{
	local BigIceRock TempRock;
	local float PieceSize,RadiusScaleAdjust;
	local int i;

//	disable('TakeDamage');	
	if (bdeleteMe)
		return;
	PieceSize = (1 / NumberShatterPieces) * 1.5;
	if (DrawScale > (Default.DrawScale * 0.3))
	{
		for(i=0; i<numberShatterPieces; i++)
		{
			RadiusScaleAdjust = (1/ NumberShatterPieces) * (1.3 + FRand() *0.5);
			PieceSize = DrawScale * RadiusScaleAdjust;
			spawn(class 'whiteSmoke');
			TempRock = Spawn(class);
			TempRock.DrawScale = PieceSize;
			if (SpawnedMesh != none)
				TempRock.Mesh = SpawnedMesh;
			TempRock.SetCollisionSize( CollisionRadius *RadiusScaleAdjust, CollisionHeight *RadiusScaleAdjust);
			TempRock.LandedSound = none;	
			TempRock.Velocity = VRand() * 300;
			TempRock.Velocity.Z = FRand() * 300;
			TempRock.SetRotation( Rotator(VRand()));
			tempRock.bBreakWhenLand = false;
			tempRock.SetPhysics(PHYS_Falling);
			TempRock.lifespan = piecesLifespan;
			TempRock.Pieceslifespan = piecesLifespan;			
		}
	}
	Destroy();
	
}

function TakeDamage( int NDamage, Pawn instigatedBy, 
				Vector hitlocation, Vector momentum, name damageType) {

	// If a rock is shot, it will fragment into a number of smaller
	// pieces.  The player can fragment a giant boulder which would
	// otherwise crush him/her, and escape with minor or no wounds
	// when a multitude of smaller rocks hit.
	
	//log ("Rock gets hit by something...");
	if (bCanBreak)
	{
		PlaySound(Hit, SLOT_Interact,,,VoiceRadius);
	
		Instigator = instigatedBy;
		Velocity += Momentum/(DrawScale * 10);
		if (Physics == PHYS_None )
		{
			SetPhysics(PHYS_Falling);
			Velocity.Z += 0.4 * Vsize(momentum);
		}
		BreakRock();		
//		SpawnChunks(6);
	}
}

state() Flying
{
Begin:
	SetPhysics(PHYS_Flying);
}


state() Sitting
{
Begin:
	RotationRate.Pitch = 0;
	RotationRate.Yaw = 0;
	RotationRate.Roll = 0;
	bBlockPlayers = true;
	setPhysics(PHYS_Falling);
	
}

auto State FallingState
{
function ProcessTouch(actor Other,vector HitLoc)
{
	local vector	MomVec;
//	MomVec=(Damage*(MomentumTransfer*0.001)*(Other.Location-HitLoc));
	if (!TakingDamage)
	{
		TakingDamage = true;
		if (bBreakWhenLand)
		{			
			Other.TakeDamage(Damage,Instigator,self.location,MomVec,HurtType);
			self.TakeDamage(Damage,Instigator,self.location,MomVec,HurtType);
		}
	}
	TakingDamage = false;
//		Other.TakeDamage(Damage,Instigator,HitLoc,MomVec,HurtType);
//		Global.Explode(HitLoc,vect(0,0,0));
}


//f/unction Bump(actor Other)
//{
//	local vector	MomVec;
//	MomVec=vect(0,0,0);
//	PlaySound(Hit, SLOT_Interact,,,VoiceRadius);

//log("in bump "$self$" with "$Other$" damage="$damage);	
//	Other.TakeDamage(Damage,Instigator,self.location,MomVec,HurtType);
//	self.TakeDamage(Damage,Instigator,self.location,MomVec,HurtType);
//}

function HitWall(vector HitNormal,actor bla)
{
	if (bBreakWhenLand)
	{
		if (bCanBreak)
		{
			BreakRock();
		}
	}	
}

function Landed(vector HitNormal)
{
	bBlockPlayers = true;
	PlaySound(LandedSound, SLOT_Interact,,,VoiceRadius);
	if (bBreakWhenLand)
	{
		if (bCanBreak)
		{
			BreakRock();
			
		}
	}	
	if (Physics == PHYS_Falling)
	{
		gotostate('Sitting');
	}
}


Begin:
	setPhysics(PHYS_Falling);
}

defaultproperties
{
     bCanBreak=True
     bBreakWhenLand=True
     NumberShatterPieces=3
     PiecesLifespan=30.000000
     LandedSound=Sound'KlingonSFX01.creature.RockBreak2'
     Hit=Sound'KlingonSFX01.Movers.IceFallSt'
     VoiceRadius=900.000000
     SpawnedMesh=None
     speed=0.000000
     Damage=5.000000
     LifeSpan=0.000000
     bBlockActors=True
     Buoyancy=120.000000
}
