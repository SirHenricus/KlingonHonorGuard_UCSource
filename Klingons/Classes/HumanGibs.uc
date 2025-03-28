//=============================================================================
// HumanGibs.
//=============================================================================
class HumanGibs expands Gibs;

#call q:\klingons\art\pawns\HumanGibs\arm\gibarm.mac
#exec MESH ORIGIN MESH=GibTCflat X=0 Y=30 Z=10 YAW=64

#call q:\klingons\art\pawns\HumanGibs\Blob\GibBlob.mac
#exec MESH ORIGIN MESH=GibTCLeg X=0 Y=20 Z=20 YAW=64

#call q:\klingons\art\pawns\HumanGibs\head\gibhead.mac
#exec MESH ORIGIN MESH=GibTClong X=0 Y=0 Z=30 YAW=64

#call q:\klingons\art\pawns\HumanGibs\leg\gibleg.mac
#exec MESH ORIGIN MESH=GibTCblob X=0 Y=0 Z=-5 YAW=64

var float LastUpdate;

function tick(float Delta)
{
	LastUpdate += Delta;
	if (LastUpdate > 0.05)
	{
		Spawn(class'BlackSmoke');
		LastUpdate = 0;
	}	
}

defaultproperties
{
}
