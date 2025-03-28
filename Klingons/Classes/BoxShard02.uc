//=============================================================================
// BoxShard02.
//=============================================================================
class BoxShard02 expands Shards;

#call q:\Klingons\Art\Decor\Boxes\BoxShards\Final\BoxShard02.mac

#exec MESH ORIGIN MESH=BoxShard02 X=0 Y=0 Z=0

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.BoxShard02'
     CollisionRadius=14.000000
     CollisionHeight=2.500000
     Buoyancy=35.000000
}
