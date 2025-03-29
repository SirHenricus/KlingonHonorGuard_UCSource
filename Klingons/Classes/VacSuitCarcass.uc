//=============================================================================
// VacSuitCarcass.
//=============================================================================
class VacSuitCarcass expands KlingonCarcass;


function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'VacSuitGuy');
}

defaultproperties
{
     Mesh=Mesh'Klingons.DMVacSuit'
     CollisionRadius=23.000000
     CollisionHeight=46.000000
     bCollideActors=True
}
