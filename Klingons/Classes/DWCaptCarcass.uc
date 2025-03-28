//=============================================================================
// DWCaptCarcass.
//=============================================================================
class DWCaptCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'DWCaptain');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnDurasCapt'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
