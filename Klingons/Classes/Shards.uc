//=============================================================================
// Shards.
//=============================================================================
class Shards expands KlingonDecorations;

var float		SpinScale;

function HitWall(vector HitNor,actor HitAct)
{
	Super.HitWall(HitNor,HitAct);
	RandSpin(Self,SpinScale);
	SpinScale*=0.75;
}

function Landed(vector HitNor)
{
	HitWall(HitNor,None);
}

function Timer()
{
	if (VSize(Velocity) != 0.0) {
		return;
	}
	Super.Timer();
}

/*
singular function Touch(actor Other)
{
	local float		ShardDamage;

	if (Other.IsA('Shards')) {
		return;
	}
	if (Other.Mass != 0.0) {
		ShardDamage=Abs(0.005*VSize(Velocity));
		Other.TakeDamage(ShardDamage,None,Location,(Velocity*Mass)*0.01,'sliced');
	}
}
*/

function Spawned()
{
	SpinScale=1.0;
	Super.Spawned();
}

defaultproperties
{
     VisibleLifeSpan=30.000000
     Physics=PHYS_Falling
     LifeSpan=90.000000
     DrawType=DT_Mesh
     CollisionRadius=12.000000
     CollisionHeight=4.000000
     bCollideActors=True
     bCollideWorld=True
     bProjTarget=True
     bBounce=True
     Mass=25.000000
}
