//=============================================================================
// RPCaptainCarcass.
//=============================================================================
class RPCaptainCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'RPCaptain');
}

defaultproperties
{
     Mesh=Mesh'Klingons.PawnRureCapt'
     CollisionRadius=40.000000
     CollisionHeight=5.000000
     bCollideActors=True
}
