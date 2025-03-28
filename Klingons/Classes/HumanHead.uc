//=============================================================================
// HumanHead.
//=============================================================================
class HumanHead expands HumanGibs;

function HitWall(vector HitNormal, actor Wall)
{
	Destroy();
}
function Landed(vector HitNormal)
{
}

defaultproperties
{
     LifeSpan=1.000000
     Mesh=Mesh'Klingons.GibHead'
     DrawScale=0.300000
     bBounce=True
}
