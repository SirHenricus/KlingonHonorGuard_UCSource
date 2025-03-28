//=============================================================================
// BoxShard04.
//=============================================================================
class BoxShard04 expands Shards;

#call q:\Klingons\Art\Decor\Boxes\BoxShards\Final\BoxShard04.mac

#exec MESH ORIGIN MESH=BoxShard04 X=0 Y=0 Z=0

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.BoxShard04'
     CollisionRadius=8.000000
     CollisionHeight=2.500000
     Buoyancy=35.000000
}
