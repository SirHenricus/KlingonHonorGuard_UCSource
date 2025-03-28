//=============================================================================
// HumanBlob.
//=============================================================================
class HumanBlob expands HumanGibs;

function HitWall(vector HitNormal, actor Wall)
{
	Destroy();
}
function Landed(vector HitNormal)
{
}

defaultproperties
{
     LifeSpan=10.000000
     Mesh=Mesh'Klingons.GibBlob'
     DrawScale=0.400000
     bBounce=True
}
