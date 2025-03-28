//=============================================================================
// DMCarcass.
//=============================================================================
class DMCarcass expands KlingonCarcass;

//#call q:\klingons\art\pawns\DMHonorguard\final\dmhonorguard.mac
//#alwaysexec MESH ORIGIN MESH=dmhonorguard X=0 Y=0 Z=-16 YAW=64

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'DMCarcass');
}
/*
//xxx special case shit
function Initfor(actor Other)
{
	local Rotator carcRotation;

	if ( bDecorative )
		Region.Zone.NumCarcasses++;
	bDecorative = false;		
	//xxxMesh = Other.Mesh;
	//xxxSkin = Other.Skin;
	//xxxDrawScale = Other.DrawScale;
	SetCollisionSize(Other.CollisionRadius, Other.CollisionHeight);
	DesiredRotation = other.Rotation;
	DesiredRotation.Roll = 0;
	DesiredRotation.Pitch = 0;
	Velocity = other.Velocity;
	Mass = Other.Mass;
}

*/

defaultproperties
{
     LifeSpan=60.000000
     DrawScale=1.500000
     CollisionRadius=35.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
