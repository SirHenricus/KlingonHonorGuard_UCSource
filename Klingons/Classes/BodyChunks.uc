//=============================================================================
// BodyChunks.
//=============================================================================
class BodyChunks expands Carcass;

var	  Bloodtrail	trail;
var	  texture		BloodColor;
var	  float			TrailSize;
var(sounds) sound   GibBounce1;
var(sounds) sound   GibBounce2;
var(sounds) sound   GibBounce3;
var(sounds) sound   GibBounce4;
var(sounds) sound   GibBounce5;

function PostBeginPlay()
{
	if ( Region.Zone.bDestructive )
		Destroy();
	else
		Super.PostBeginPlay();
}

simulated function ZoneChange( ZoneInfo NewZone )
{
	local KlingonGameInfo	K;

/*
	if ( NewZone.bWaterZone )
	{
		if ( bSplash && !Region.Zone.bWaterZone && (Abs(Velocity.Z) < 80) )
		{
			RotationRate *= 0.6;
			if ( trail != None )
				trail.Destroy();
			if ( Mass <= Buoyancy )
				SetCollisionSize(0,0);
		}
		// else play a splash
		bSplash = true;
	}
*/

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}

	if ( NewZone.bDestructive || (NewZone.bPainZone  && (NewZone.DamagePerSec > 0)) )
		Destroy();
}
	
function Destroyed()
{
	if ( trail != None )
		trail.Destroy();
	Super.Destroyed();
}

function Initfor(actor Other)
{
	local vector RandDir;

	bDecorative = false;
	DrawScale = Other.DrawScale;
	RotationRate.Yaw = Rand(200000) - 100000;
	RotationRate.Pitch = Rand(200000 - Abs(RotationRate.Yaw)) - 0.5 * (200000 - Abs(RotationRate.Yaw));
	RandDir = 700 * FRand() * VRand();
	RandDir.Z = 500 * FRand() - 250;
	Velocity = (0.2 + FRand()) * (other.Velocity + RandDir);
	If (Region.Zone.bWaterZone)
		Velocity *= 0.5;
	if ( TrailSize > 0 )
	{
		if ( KlingonCarcass(Other) != None )
			BloodColor = KlingonCarcass(Other).BloodColor;
		else if ( (BodyChunks(Other) != None) && (BodyChunks(Other).trail.skin != None) )
			BloodColor = BodyChunks(Other).trail.skin;
	}
			
	if ( FRand() < 0.3 )
		Buoyancy = 1.06 * Mass; // float corpse
	else
		Buoyancy = 0.94 * Mass;
}

function ChunkUp(int Damage)
{
	if (bHidden)
		return;
	//XXXSpawn(class 'BloodSpurt2');
	if (bPlayerCarcass)
	{
		bHidden = true;
		SetPhysics(PHYS_None);
		SetCollision(false,false,false);
		bProjTarget = false;
	}
	else
		destroy();
}

function ClientExtraChunks()
{
//xxx	If ( Level.NetMode == NM_Server )
		return;
	//XXXSpawn(class 'Bloodspurt2');
}

simulated function Landed(vector HitNormal)
{
	local rotator finalRot;

	if ( trail != None )
	{
		trail.Destroy();
		trail = None;
	}
	finalRot = Rotation;
	finalRot.Roll = 0;
	finalRot.Pitch = 0;
	setRotation(finalRot);
	//XXXif ( Level.NetMode != NM_Server )
	//XXX	Spawn(class 'Bloodspurt2');
	SetPhysics(PHYS_None);
	SetCollision(true, false, false);
}

simulated function HitWall(vector HitNormal, actor Wall)
{
	local float speed, decision;

	Velocity = 0.8 * (Velocity - 2 * HitNormal * (Velocity Dot HitNormal));
	Velocity.Z = FMin(Velocity.Z * 0.8, 700);
	speed = VSize(Velocity);
	if ( (speed < 250) && (trail != None) )
	{
		trail.Destroy();
		trail = None;
	}
	else if ( speed > 350 )
	{
		decision = FRand();
		if ( decision < 0.2 )
			PlaySound(GibBounce1);
		else if ( decision < 0.4 )
			PlaySound(GibBounce2);
		else if ( decision < 0.6 )
			PlaySound(GibBounce3);
		else if ( decision < 0.8 )
			PlaySound(GibBounce4);
		else 
			PlaySound(GibBounce5);
	}
	//XXXif ( (trail == None) && (Level.NetMode != NM_Server) )
	//XXX	Spawn(class 'Bloodspurt2');

	if ( speed < 120 )
	{
		bBounce = false;
		Disable('HitWall');
	}
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{
	SetPhysics(PHYS_Falling);
	bBobbing = false;
	Velocity += momentum/Mass;
	CumulativeDamage += Damage;
	If ( Damage > FMin(15, Mass) || (CumulativeDamage > Mass) )
		ChunkUp(Damage);
}

auto state Dying
{
	ignores TakeDamage;

Begin:
	if ( bDecorative )
		SetPhysics(PHYS_None);
	else if ( TrailSize > 0 )
	{
//		trail = Spawn(class'BloodTrail',self);
//		trail.DrawScale = TrailSize;
//		trail.skin = BloodColor;
	}
	Sleep(0.2);
	GotoState('Dead');
}	

state Dead 
{
	function BeginState()
	{
		if ( bDecorative )
			lifespan = 0.0;
		else
			SetTimer(5.0, false);
	}
}

defaultproperties
{
     TrailSize=3.000000
     LifeSpan=90.000000
     Mesh=Mesh'Klingons.AmmoFuelCell'
     bMeshCurvy=False
     bBounce=True
     bFixedRotationDir=True
     Mass=30.000000
     Buoyancy=27.000000
     RotationRate=(Pitch=30000,Roll=30000)
}
