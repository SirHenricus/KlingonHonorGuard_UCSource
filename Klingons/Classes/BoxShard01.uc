//=============================================================================
// BoxShard01.
//=============================================================================
class BoxShard01 expands Shards;

#call q:\Klingons\Art\Decor\Boxes\BoxShards\Final\BoxShard01.mac

#exec MESH ORIGIN MESH=BoxShard01 X=0 Y=0 Z=0

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.BoxShard01'
     CollisionRadius=14.000000
     CollisionHeight=1.500000
     Buoyancy=35.000000
}
