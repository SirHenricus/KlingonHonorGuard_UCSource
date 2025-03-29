//=============================================================================
// NausicanCarcass.
//=============================================================================
class NausicanCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'Nausican');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnNausican'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
