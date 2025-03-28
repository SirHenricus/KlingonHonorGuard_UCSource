//=============================================================================
// DWGruntCarcass.
//=============================================================================
class DWGruntCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'DWGrunt');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnDurasGrunt'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
