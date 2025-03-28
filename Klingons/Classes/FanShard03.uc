//=============================================================================
// FanShard03.
//=============================================================================
class FanShard03 expands Shards;

#call q:\Klingons\Art\Missn_14\Geometry\Actors\Fan\Broken\FanPiece03.mac

#exec MESH ORIGIN MESH=FanPiece03 X=-50 Y=0 Z=350

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.FanPiece03'
     CollisionHeight=15.000000
     Buoyancy=19.000000
}
