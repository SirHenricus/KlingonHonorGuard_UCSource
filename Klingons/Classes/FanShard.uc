//=============================================================================
// FanShard.
//=============================================================================
class FanShard expands Shards;

#call q:\Klingons\Art\Missn_14\Geometry\Actors\Fan\Broken\FanPiece01.mac

#exec MESH ORIGIN MESH=FanPiece01 X=0 Y=-50 Z=150

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.FanPiece01'
     CollisionRadius=8.000000
     CollisionHeight=8.000000
     Buoyancy=20.000000
}
