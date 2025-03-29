//=============================================================================
// TarchopGibs.
//=============================================================================
class TarchopGibs expands Gibs;

#call q:\klingons\art\pawns\tarchop\gibs\flat\tcgibflat.mac
#exec MESH ORIGIN MESH=GibTCflat X=0 Y=30 Z=10 YAW=64

#call q:\klingons\art\pawns\tarchop\gibs\leg\tcgibleg.mac
#exec MESH ORIGIN MESH=GibTCLeg X=0 Y=20 Z=20 YAW=64

#call q:\klingons\art\pawns\tarchop\gibs\long\tcgiblong.mac
#exec MESH ORIGIN MESH=GibTClong X=0 Y=0 Z=30 YAW=64

#call q:\klingons\art\pawns\tarchop\gibs\blob\tcgibblob.mac
#exec MESH ORIGIN MESH=GibTCblob X=0 Y=0 Z=-5 YAW=64

defaultproperties
{
}
