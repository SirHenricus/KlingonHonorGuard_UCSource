//=============================================================================
// HGCaptCarcass.
//=============================================================================
class HGCaptCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'HGCaptain');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnHonorGuardCapt'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
