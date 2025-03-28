//=============================================================================
// BoxBoomShard04.
//=============================================================================
class BoxBoomShard04 expands Shards;

#call q:\Klingons\Art\Decor\Boxes\BoxBoomBits\Final\BoxBoomBit04.mac

#exec MESH ORIGIN MESH=ExplodingBoxBit04 X=0 Y=0 Z=0

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.MetalShard'
     Mesh=Mesh'Klingons.ExplodingBoxBit04'
     LightType=LT_Steady
     LightBrightness=100
     LightHue=90
     LightRadius=8
     LightPeriod=16
     LightPhase=16
     Mass=35.000000
     Buoyancy=25.000000
}
