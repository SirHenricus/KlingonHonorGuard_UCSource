//=============================================================================
// ParticleBlood.
//=============================================================================
class ParticleBlood expands Effects;

var() texture	ParticleTextures[4];
var int			RandomTex;

state fallingState {
	function HitWall(vector HitNor,actor HitActor)
	{
		Destroy();
	}
	function Landed(vector HitNor)
	{
		Destroy();
	}

}

auto state Flying {
	function HitWall(vector HitNor,actor HitActor)
	{
		Destroy();
	}
	function Landed(vector HitNor)
	{
		Destroy();
	}
	function Timer()
	{
		if (Region.Zone.ZoneGravity.Z <= -200)
		{
			// Gravity has changed, fall
			setPhysics(PHYS_Falling);
			gotostate('FallingState');
		}
	}
Begin:
	RandomTex=Rand(4);
	Skin=ParticleTextures[RandomTex];
	Texture=ParticleTextures[RandomTex];
	DrawType=DT_Sprite;
//	Velocity=Owner.Velocity;
	if (Physics == PHYS_None)
		SetPhysics(PHYS_Projectile);
	settimer(0.2, true);
}

defaultproperties
{
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=1.000000
     DrawScale=0.300000
     bMeshCurvy=False
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bCollideWorld=True
}
