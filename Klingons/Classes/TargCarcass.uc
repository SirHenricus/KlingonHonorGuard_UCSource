//=============================================================================
// TargCarcass.
//=============================================================================
class TargCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'Targ');
}

defaultproperties
{
     AnimSequence=DeadFall
     Mesh=Mesh'Klingons.PawnTarg'
     bCollideActors=True
}
