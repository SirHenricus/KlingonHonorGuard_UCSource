//=============================================================================
// HGGruntCarcass.
//=============================================================================
class HGGruntCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'HGGrunt');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnHonorGuardGrunt'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
