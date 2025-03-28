//=============================================================================
// BoxShard03.
//=============================================================================
class BoxShard03 expands Shards;

#call q:\Klingons\Art\Decor\Boxes\BoxShards\Final\BoxShard03.mac

#exec MESH ORIGIN MESH=BoxShard02 X=0 Y=0 Z=13

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.BoxShard03'
     Buoyancy=35.000000
}
