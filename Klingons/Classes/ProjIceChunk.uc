//=============================================================================
// ProjIceChunk.
//=============================================================================
class ProjIceChunk expands Projectile;

var() mesh				SpawnedMesh;

#call q:\klingons\art\projectiles\RopedIce\IceChunk\IceChunk.mac


function PreBeginPlay()
{
	local float decision;
	Super.PreBeginPlay();
	Velocity = Vector(Rotation) * speed;
//	Velocity = vect(0,0,0);
	DesiredRotation.Pitch = Rotation.Pitch + Rand(2000) - 1000;
	DesiredRotation.Roll = Rotation.Roll + Rand(2000) - 1000;
	DesiredRotation.Yaw = Rotation.Yaw + Rand(2000) - 1000; 
	decision = FRand();
	
	bFixedRotationDir=True;
	RotationRate=RotRand(True);	


//	if (decision<0.25) 
//		PlayAnim('Is', 1.0, 0.0);
//	else if (decision<0.5) 
//		PlayAnim('My', 1.0, 0.0);
//	else if (decision <0.75) 
//		PlayAnim('Bitch', 1.0, 0.0);
//	if (FRand() < 0.5)
//		RotationRate.Pitch = Rand(180000);
//	if ( (RotationRate.Pitch == 0) || (FRand() < 0.8) )
//		RotationRate.Roll = Max(0, 50000 + Rand(200000) - RotationRate.Pitch);
}

function TakeDamage( int NDamage, Pawn instigatedBy, 
				Vector hitlocation, Vector momentum, name damageType) {

	// If a rock is shot, it will fragment into a number of smaller
	// pieces.  The player can fragment a giant boulder which would
	// otherwise crush him/her, and escape with minor or no wounds
	// when a multitude of smaller rocks hit.
	
	//log ("Rock gets hit by something...");
	Velocity += Momentum/(DrawScale * 10);
	if (Physics == PHYS_None )
	{
		SetPhysics(PHYS_Falling);
		Velocity.Z += 0.4 * Vsize(momentum);
	}
	SpawnChunks(6);
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
		TempRock = Spawn(class'ProjIceChunk');
		if (TempRock != None )
		{
			TempRock.InitFrag(self, scale);
			TempRock.Mesh = SpawnedMesh;
		}
	}
	InitFrag(self, 0.5);
	Mesh = SpawnedMesh;
}

function InitFrag(ProjIceChunk myParent, float scale)
{
	local rotator newRot;

	SetPhysics(PHYS_Falling);
	// Pick a random size for the chunks
	RotationRate = Rotator(Vrand());
	scale *= (0.5 + FRand());
	DrawScale = scale * myParent.DrawScale;
	if ( DrawScale <= 0.5 )
		SetCollisionSize(0,0);
	else
		SetCollisionSize(CollisionRadius * DrawScale/Default.DrawScale, CollisionHeight * DrawScale/Default.DrawScale);

	Velocity = Normal(VRand() + myParent.Velocity/myParent.speed) 
				* (myParent.speed * (0.4 + 0.3 * (FRand() + FRand())));
				

}	

auto state Flying
{
	function ProcessTouch (Actor Other, Vector HitLocation)
	{
		local int hitdamage;

		speed = VSize(Velocity);
		if ( (Other != instigator) || (((Other.Location - HitLocation) Dot Velocity) > 0) )
		{
			Velocity = Normal(Other.Location - HitLocation) * speed * 0.5;
			SetPhysics(PHYS_Falling);
		}
		PlaySound(ImpactSound, SLOT_Misc, DrawScale/10);	
		if ( (Other != instigator) && (ProjIceChunk(Other) == none) )
		{
			// The mass of the rock is proportional to the
			// scale factor cubed, and the damage incurred by
			// whatever the rock hits will be proportional to
			// the contact force, mass*acceleration.  The acceleration
			// factor is approximated by the impact speed.
			//
//			log("calling takedamage");
			Hitdamage = Damage * 0.0002 * (DrawScale**3) * speed;
//			if ( HitDamage > 4 )
			if (KlingonPlayer(Other) != none)
			{
				Other.TakeDamage(hitdamage, instigator,HitLocation,
					vect(0,0,0), 'crushed' );
			}
			else
			{
				Other.TakeDamage(hitdamage, instigator,HitLocation,
					(35000.0 * Velocity/speed), 'crushed' );
			}
					
		}
		
	}
	
	simulated function Landed(vector HitNormal)
	{
		HitWall(HitNormal, None);
	}

	simulated function HitWall (vector HitNormal, actor Wall)
	{
		local vector RealHitNormal;
		local float soundRad;

		if ( (Mover(Wall) != None) && Mover(Wall).bDamageTriggered )
			Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), '');
		if ( Drawscale > 2.0 )
			soundRad = 500 * DrawScale;
		else
			soundRad = 100;
		PlaySound(ImpactSound, SLOT_Misc, DrawScale/8,,soundRad);	
		speed = VSize(velocity);
		if ( (HitNormal.Z > 0.8) && (speed < 60 - DrawScale) )
		{
			SetPhysics(PHYS_None);
			GotoState('Sitting');	
		}
		else
		{			
			SetPhysics(PHYS_Falling);
			RealHitNormal = HitNormal;
			if ( FRand() < 0.5 )
				RotationRate.Pitch = Max(RotationRate.Pitch, 100000);
			else
				RotationRate.Roll = Max(RotationRate.Roll, 100000);
			HitNormal = Normal(HitNormal + 0.5 * VRand()); 
			if ( (RealHitNormal Dot HitNormal) < 0 )
				HitNormal.Z *= -0.7;
			Velocity = 0.7 * (Velocity - 2 * HitNormal * (Velocity Dot HitNormal));
			DesiredRotation = Rotator(HitNormal);
			if ( (speed > 150) && (FRand() * 30 < DrawScale) )
				SpawnChunks(4);
		}
	}

Begin:
	Sleep(5.0);
	SetPhysics(PHYS_Falling);
}

State Sitting
{
Begin:
	SetPhysics(PHYS_None);
	Sleep(DrawScale * 0.5);
	Destroy();
}

defaultproperties
{
     SpawnedMesh=Mesh'Klingons.ProjIceChunk'
     speed=1000.000000
     MaxSpeed=1000.000000
     Damage=40.000000
     Physics=PHYS_Falling
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=40.000000
     Mesh=Mesh'Klingons.ProjIceChunk'
     DrawScale=4.000000
     bMeshCurvy=False
     CollisionRadius=30.000000
     CollisionHeight=30.000000
     bProjTarget=True
}
