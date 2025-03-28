//=============================================================================
// BoxBoomShard01.
//=============================================================================
class BoxBoomShard01 expands Shards;

#call q:\Klingons\Art\Decor\Boxes\BoxBoomBits\Final\BoxBoomBit01.mac

#exec MESH ORIGIN MESH=ExplodingBoxBit01 X=0 Y=0 Z=0

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.ExplodingBoxBit01'
     LightType=LT_Steady
     LightBrightness=100
     LightHue=90
     LightRadius=8
     LightPeriod=16
     LightPhase=16
     Mass=35.000000
     Buoyancy=25.000000
}
