//=============================================================================
// RPBeastCarcass.
//=============================================================================
class RPBeastCarcass expands KlingonCarcass;


function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'RPBeast');
}

defaultproperties
{
     AnimSequence=DeadFwdRoll
     Mesh=Mesh'Klingons.PawnRureBeast'
     DrawScale=0.700000
     CollisionRadius=30.000000
     CollisionHeight=20.000000
     bCollideActors=True
}
