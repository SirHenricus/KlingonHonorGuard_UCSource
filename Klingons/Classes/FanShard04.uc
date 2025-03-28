//=============================================================================
// FanShard04.
//=============================================================================
class FanShard04 expands Shards;

#call q:\Klingons\Art\Missn_14\Geometry\Actors\Fan\Broken\FanPiece04.mac

#exec MESH ORIGIN MESH=FanPiece04 X=-25 Y=0 Z=300

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.FanPiece04'
     CollisionHeight=15.000000
     Buoyancy=22.000000
}
