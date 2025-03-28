//=============================================================================
// BoxRadioactive.
//=============================================================================
class BoxRadioactive expands Destructable;

#call q:\Klingons\Art\Decor\Boxes\BoxBoom\Final\BoxBoom.mac

#exec MESH ORIGIN MESH=ExplodingBox X=0 Y=0 Z=0

defaultproperties
{
     ExplosionDamage=80.000000
     ExplosionMomentum=35000.000000
     ShardClass(0)=Class'Klingons.BoxBoomShard01'
     ShardClass(1)=Class'Klingons.BoxBoomShard02'
     ShardClass(2)=Class'Klingons.BoxBoomShard03'
     ShardClass(3)=Class'Klingons.BoxBoomShard04'
     ShardClass(4)=Class'Klingons.BoxBoomShard05'
     ShardCount=5.000000
     EffectWhenDestroyed=Class'Klingons.AirExplosion'
     Physics=PHYS_Falling
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.ExplodingBox'
     LightType=LT_Steady
     LightBrightness=100
     LightHue=90
     LightRadius=10
     LightPeriod=16
     LightPhase=16
     bBounce=True
     Mass=75.000000
     Buoyancy=72.000000
}
