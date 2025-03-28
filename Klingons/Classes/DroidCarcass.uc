//=============================================================================
// DroidCarcass.
//=============================================================================
class DroidCarcass expands KlingonCarcass;

#alwayscall q:\klingons\art\pawns\attackdgibs\final\adgibbody1.mac
#alwaysexec MESH ORIGIN MESH=PawnADGibBody1 X=20 Y=0 Z=10 YAW=64

#alwayscall q:\klingons\art\pawns\attackdgibs\final\adgibarm1.mac
#alwaysexec MESH ORIGIN MESH=PawnADGibArm1 X=-120 Y=0 Z=10 YAW=64

#alwayscall q:\klingons\art\pawns\attackdgibs\final\adgibhead1.mac
#alwaysexec MESH ORIGIN MESH=PawnADGibHead1 X=0 Y=0 Z=50 YAW=64
var float ExplodeWhenLand;
var float LastSmoke;
var bool explodedalready;

function PreBeginPlay()
{
	Super.PreBeginPlay();
	ExplodeWhenLand = FRand();

}

function ForceMeshToExist()
{
	local Mesh TempMesh;
	//XXXnever called
	Spawn(class 'AttackDroid');
	Mesh = Mesh'PawnADGibArm1';
	Mesh = Mesh'PawnADGibBody1';
	Mesh = Mesh'PawnADGibHead1';
	Mesh = Mesh'BoxShard02';
	Mesh = Mesh'TeleTop';
}

function Tick(float Delta)
{
	LastSmoke += Delta;
	if (LastSmoke > 0.05)
	{
		spawn(class 'BlackSmoke2',self,'',location);
		
		LastSmoke = 0;
	}
}

function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{
}

function AnimEnd()
{
	local float decision;
	
	//xxx so that we get the landing sound
	//
	if ( Physics == PHYS_None )
			LieStill();

	decision = FRand();
	if (decision < 0.2)
		PlayAnim('Twitch1', 0.3+0.3*FRand());
	else if (decision < 0.4)
		PlayAnim('Twitch2', 0.3+0.3*FRand());
	else
		TweenAnim('Twitch1', 2*FRand());
}

function HitWall(vector HitNormal, actor HitWall)
{
//xxx	Spawn(class 'RocketExplosion');
	if (ExplodeWhenLand < 0.5)
	{
		Explodedalready = true;
		Spawn(class 'AirSmallExp');
		ChunkUp(6);		
	}
	else
	{
		LightType = LT_Flicker;
		LightBrightness = 60;
		LightSaturation = 150;
		Super.HitWall(HitNormal,HitWall);
	}
	
//	Destroy();
}

function Landed(vector HitNormal)
{
//xxx	Spawn(class 'RocketExplosion');
//	LandedAlready = false;
//	if (ExplodeWhenLand > 0.0)
//	{
//		Spawn(class 'GroundExplosion');
///		ChunkUp(8);		
//	}

}


function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, 
							Vector Momentum, name DamageType)
{
	local TarchopGibs TCG;
	local int i;
	local Rotator rot;
	
	if (!ExplodedAlready)
	{
		CumulativeDamage += Damage;
	//		Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
		
		if ( (((Damage > 15) || !IsAnimating()) && (CumulativeDamage > 7)) || (Damage > Mass) 
			|| ((Velocity.Z > 250) && !IsAnimating()) )
		{
			ExplodedAlready = true;
			Spawn(class 'GroundExplosion');
			ChunkUp(6);		
		}
	}
	
}


function GibIt()
{
	ExplodedAlready = true;
	Spawn(class 'GroundExplosion');
	ChunkUp(6);	
	Destroy();
}

defaultproperties
{
     bodyparts(0)=Mesh'Klingons.PawnADGibArm1'
     bodyparts(1)=Mesh'Klingons.PawnADGibArm1'
     bodyparts(2)=Mesh'Klingons.PawnADGibBody1'
     bodyparts(3)=Mesh'Klingons.PawnADGibHead1'
     bodyparts(4)=Mesh'Klingons.PawnADGibHead1'
     bodyparts(5)=Mesh'Klingons.BoxShard02'
     bodyparts(6)=Mesh'Klingons.TeleTop'
     bodyparts(7)=Mesh'Klingons.PawnADGibBody1'
     LandedSound=Sound'KlingonSFX01.creature.DroidHitBig'
     Mesh=Mesh'Klingons.PawnAttackDroid1'
     DrawScale=2.500000
     CollisionHeight=18.000000
     bCollideActors=True
}
