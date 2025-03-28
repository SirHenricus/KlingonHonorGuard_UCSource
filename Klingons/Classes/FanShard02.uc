//=============================================================================
// FanShard02.
//=============================================================================
class FanShard02 expands Shards;

#call q:\Klingons\Art\Missn_14\Geometry\Actors\Fan\Broken\FanPiece02.mac

#exec MESH ORIGIN MESH=FanPiece02 X=0 Y=-25 Z=175

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.FanPiece02'
     Buoyancy=18.000000
}
