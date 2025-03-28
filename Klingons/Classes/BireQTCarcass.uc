//=============================================================================
// BireQTCarcass.
//=============================================================================
class BireQTCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'BireQT');
}

defaultproperties
{
     AnimSequence=None
     Mesh=Mesh'Klingons.PawnBireQt'
     bCollideActors=True
}
