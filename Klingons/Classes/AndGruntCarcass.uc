//=============================================================================
// AndGruntCarcass.
//=============================================================================
class AndGruntCarcass expands KlingonCarcass;

//#alwaysexec  MESH ORIGIN MESH=AndGruntCarcass X=0 Y=0 Z=400 YAW=64

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'AndorianGrunt');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnAndorianGrunt'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
