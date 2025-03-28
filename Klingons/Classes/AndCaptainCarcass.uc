//=============================================================================
// AndCaptainCarcass.
//=============================================================================
class AndCaptainCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'AndorianCaptain');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnAndorianCaptain'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
