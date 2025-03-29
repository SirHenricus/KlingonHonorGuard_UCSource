//=============================================================================
// RPGruntCarcass.
//=============================================================================
class RPGruntCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'RPGrunt');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnRureGrunt'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
